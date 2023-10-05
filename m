Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCF87BA460
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 18:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240004AbjJEQFP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 12:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237488AbjJEQEE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 12:04:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0249D5DFCE;
        Thu,  5 Oct 2023 07:07:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BD5C4936D;
        Thu,  5 Oct 2023 11:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696506102;
        bh=5/c2akYQDQa+5AUEIuaC2Lyms0EC3q6cd/b6zPtv2Oc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IzUJWvyg2uWuoJwnUC4g0aGsoEtxo/jyNhLez+4oqOyCBkFG193DSI8dSz2o3sgnL
         Uhe1mIFQRX6RO2ROVu4vf1Gh2g7DX4xeq/W95JheoklK/cMH8sB2Agp/fu9BQzDaU3
         GJ+y2Dh1NH4jiCr4PbcyH8qfF1cxi8itppxJpUgY=
Date:   Thu, 5 Oct 2023 13:41:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valentine Sinitsyn <valesini@yandex-team.ru>
Cc:     Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 2/2] PCI: Implement custom llseek for sysfs resource
 entries
Message-ID: <2023100503-change-nimbly-8c58@gregkh>
References: <2023092241-obedient-squirt-966c@gregkh>
 <20230925084013.309399-2-valesini@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925084013.309399-2-valesini@yandex-team.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 25, 2023 at 11:40:13AM +0300, Valentine Sinitsyn wrote:
> Since commit 636b21b50152 ("PCI: Revoke mappings like devmem"), mmappable
> sysfs entries have started to receive their f_mapping from the iomem
> pseudo filesystem, so that CONFIG_IO_STRICT_DEVMEM is honored in sysfs
> (and procfs) as well as in /dev/[k]mem.
> 
> This resulted in a userspace-visible regression:
> 
> 1. Open a sysfs PCI resource file (eg. /sys/bus/pci/devices/*/resource0)
> 2. Use lseek(fd, 0, SEEK_END) to determine its size
> 
> Expected result: a PCI region size is returned.
> Actual result: 0 is returned.
> 
> The reason is that PCI resource files residing in sysfs use
> generic_file_llseek(), which relies on f_mapping->host inode to get the
> file size. As f_mapping is now redefined, f_mapping->host points to an
> anonymous zero-sized iomem_inode which has nothing to do with sysfs file
> in question.
> 
> Implement a custom llseek method for sysfs PCI resources, which is
> almost the same as proc_bus_pci_lseek() used for procfs entries.
> 
> This makes sysfs and procfs entries consistent with regards to seeking,
> but also introduces userspace-visible changes to seeking PCI resources
> in sysfs:
> 
> - SEEK_DATA and SEEK_HOLE are no longer supported;
> - Seeking past the end of the file is prohibited while previously
>   offsets up to MAX_NON_LFS were accepted (reading from these offsets
>   was always invalid).
> 
> Fixes: 636b21b50152 ("PCI: Revoke mappings like devmem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Valentine Sinitsyn <valesini@yandex-team.ru>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci-sysfs.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)

I'll take these now, for 6.7-rc1, but not mark them as fixes or cc:
stable as this is a new functionality, the code has never worked for
lseek on these files so it's not like anything was broken :)

thanks,

greg k-h
