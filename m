Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F555AB708
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 18:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbiIBQ72 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 12:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbiIBQ71 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 12:59:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7832D10A629;
        Fri,  2 Sep 2022 09:59:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36126B82CCA;
        Fri,  2 Sep 2022 16:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF84C433C1;
        Fri,  2 Sep 2022 16:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662137963;
        bh=DGrp9ol7B2fcIuUbZg7Ryi5vbk3GSCvjRzXLRLhagJc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VsoJYHVYCxuH9OeEdmFUSU6JUMq3+qm/agKa2mDB297wYG3ajJFAztMFqB4BJlRAL
         ZQBQym/PhDcFs2+7N4sMgIpisQN/RmxpsiWajH4fp4IX1l0SbYMdfXrGcpzoe8+sG5
         FW0TJ/FBY9+sdzDB7IC1a+1N+qQsTQjr/XvPyFN8ZHK1HGh96nYy2WXJ2Xe2vKhFst
         Lbb1m+ssGgPalRPKK20TMZwPyVxWn/pkF7Ke1wnq2GeydIkygxI1SSntDBU1XtsrF6
         UWEQmWGMkeQTaRFPpaYuPtgHDXKaPBj6MBzpUhPX87odsEaKNVRq8IQZgkmE9KrcIx
         5V8+wdAFdEtMw==
Date:   Fri, 2 Sep 2022 11:59:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jason Andryuk <jandryuk@gmail.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen-pcifront: Handle missed Connected state
Message-ID: <20220902165921.GA354189@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829151536.8578-1-jandryuk@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The conventional style for subject (from "git log --oneline") is:

  xen/pcifront: Handle ...

On Mon, Aug 29, 2022 at 11:15:36AM -0400, Jason Andryuk wrote:
> An HVM guest with linux stubdom and 2 PCI devices failed to start as

"stubdom" might be handy shorthand in the Xen world, but I think
it would be nice to consistently spell out "stubdomain" since you use
both forms randomly in this commit log and newbies like me have to
wonder whether they're the same or different.

> libxl timed out waiting for the PCI devices to be added.  It happens
> intermittently but with some regularity.  libxl wrote the two xenstore
> entries for the devices, but then timed out waiting for backend state 4
> (Connected) - the state stayed at 7 (Reconfiguring).  (PCI passthrough
> to an HVM with stubdomain is PV passthrough to the stubdomain and then
> HVM passthrough with the QEMU inside the stubdomain.)
> 
> The stubdom kernel never printed "pcifront pci-0: Installing PCI
> frontend", so it seems to have missed state 4 which would have
> called pcifront_try_connect -> pcifront_connect_and_init_dma

Add "()" after function names for clarity.

> Have pcifront_detach_devices special-case state Initialised and call
> pcifront_connect_and_init_dma.  Don't use pcifront_try_connect because
> that sets the xenbus state which may throw off the backend.  After
> connecting, skip the remainder of detach_devices since none have been
> initialized yet.  When the backend switches to Reconfigured,
> pcifront_attach_devices will pick them up again.

Bjorn
