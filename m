Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E9D6F0999
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 18:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243499AbjD0QPE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 12:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjD0QPC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 12:15:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B881FD4;
        Thu, 27 Apr 2023 09:15:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EADB361050;
        Thu, 27 Apr 2023 16:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299DCC433EF;
        Thu, 27 Apr 2023 16:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682612100;
        bh=fxTrS+s2c8YlhXQmpP9j+DvPz8LMLKyuHrslsFK1DrE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NEXNs1L91RH1f0081I2HTyPt6Mj5UFOrhXbEp1sHjFm+HbXtFP5DpJhC3lSAPxuTf
         +gfHIac8Dmez/eFaWLsGq0GD9+kt+INEqf9Ad+mUGbCafGEQ01eQ88hrAICxrUjH1V
         GRyH18e/c5aDylm9HEYGzA29Cbr8C0Lk4RdoiWi5jYbxSnLtRW0VlNvEI8Zte13jRG
         9osgTQusKy+V+Jcm/YOZOdrz+gsijj3br7i+2mr+7j/hK/RkyXb9nC0Tr1mTAUrB3d
         bwJI4h68Qhd+uG7liwRndW6ufbJYPp8eLrJxqaUSk3ugt4sbOswq7G4Na5pMGRVxnj
         GEU8r/xV8PGQA==
Date:   Thu, 27 Apr 2023 11:14:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Korneliusz Osmenda <korneliuszo@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH 0/3] PCI: Fix race condition upon sysfs init
Message-ID: <20230427161458.GA249886@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427142901.3570536-1-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 27, 2023 at 04:28:58PM +0200, Alexander Stein wrote:
> Hi everyone,
> 
> this series is a totally different approach for fixing the sysfs init race
> condition. The initial problem is stated at [1]. Previous proposals were
> rejected ([2] and [3]). Here is what's happening
> 
> 
>         CPU 0                                  CPU 1
> 
>                                         imx6_pcie_probe()
>                                         dw_pcie_host_init()
>                                         pci_host_probe()
>                                         pci_scan_root_bus_bridge()
>                                           pci_scan_child_bus_extend()
>                                           pci_scan_slot()
>                                           pci_scan_single_device()
>                                           pci_device_add()
> pci_sysfs_init()                          device_add()
>   sysfs_initialized = 1;                  bus_add_device()
>   for_each_pci_dev()                          ...
>     pci_create_sysfs_dev_files()                  
>                                         pci_bus_add_devices()
>                                         pci_bus_add_device()
>                                         pci_create_sysfs_dev_files()
> 
> Eventually calling pci_create_sysfs_dev_files() twice on the same pci_dev.
> It's a very tight window, deeper PCIe trees increase that window during
> host probe. Asynchronous PCIe host probe is a necessity
> (PROBE_PREFER_ASYNCHRONOUS).
> 
> The first two patches are preparations for the last one actually fixing
> the race. As functions like pci_create_sysfs_dev_files() are called from
> externtal and internal to pci-sysfs, an internal version without checking
> for sysfs_initialized is required.
> For the fix a wait queue is introduced where all callers from external
> callsites (regarding pci-sysfs.c) are waiting until pci_sysfs_init
> initcall has finished and woken up all waiters.
> 
> A subtlety is that within __pci_create_sysfs_dev_files the resource files
> (created by pci_sysfs_init) need to be removed, so they can be created
> again from pci_host_probe call.

I'll look at this in more detail, but if there's any way at all that
we could get rid of pci_sysfs_init() completely and do this with
static attributes or some other existing sysfs infrastructure, I would
STRONGLY prefer it because that infrastructure has already solved this
problem.

Maybe that's impossible and we really need to make a one-off solution
just for PCI, but ... I haven't been convinced yet.

> Links:
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=215515
> [2] https://lore.kernel.org/linux-pci/20230316091540.494366-1-alexander.stein@ew.tq-group.com/
> [3] https://lore.kernel.org/linux-pci/20230316103036.1837869-1-alexander.stein@ew.tq-group.com/
> 
> Alexander Stein (3):
>   PCI/sysfs: sort headers alphabetically
>   PCI/sysfs: create private functions for
>     pci_create_legacy_files/pci_create_sysfs_dev_files
>   PCI/sysfs: Fix sysfs init race condition
> 
>  drivers/pci/pci-sysfs.c | 87 +++++++++++++++++++++++++----------------
>  1 file changed, 53 insertions(+), 34 deletions(-)
> 
> -- 
> 2.34.1
> 
