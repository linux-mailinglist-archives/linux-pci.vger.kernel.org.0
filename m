Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3433621766
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 15:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiKHOxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 09:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiKHOxF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 09:53:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDEC1B79E;
        Tue,  8 Nov 2022 06:53:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA297B81B1C;
        Tue,  8 Nov 2022 14:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D8BC433D6;
        Tue,  8 Nov 2022 14:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667919182;
        bh=Fl5ECyuY0mcLHt9TgY/lsirRQMw5DTyd6GMsAdCpztI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CctLNRlT4AHCZliJcH/6pdP//+ol44krbIxM4mU8zKOB6VRkXpgUEYdFTOyrCM4qT
         t2nzs44ZtIXX+YrJRgDwwTJl4BS4n+JT6wjk+CgpByxKhs6meu+27b+yXRDIOLvXj4
         FD1bZo5RYy8S2sMzV2XKxn9ZIYHi55vjswjsCu35Ik/Z8eAQ4mg0EuD+2ABSMdDL4G
         FwxiF9oPiEp8VyrNbxazazIYqzsNAvIXLeVhkvfYnRgbmDOJcmR0qDqmnZLFvlfNWa
         3ZuekeNi8Dg03JpqmxgJpk1hD/eu3vnqvBmxOoGLh3Bpb8I+MiIIddg2YgRV7ZPDCk
         bL/WfWAKK2qpA==
Date:   Tue, 8 Nov 2022 08:53:00 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Wei Gong <gongwei833x@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221108145300.GA472813@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026060912.173250-1-mst@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 26, 2022 at 02:11:21AM -0400, Michael S. Tsirkin wrote:
> virtio uses the same driver for VFs and PFs.  Accordingly,
> pci_device_is_present is used to detect device presence. This function
> isn't currently working properly for VFs since it attempts reading
> device and vendor ID.

> As VFs are present if and only if PF is present,
> just return the value for that device.

VFs are only present when the PF is present *and* the PF has VF Enable
set.  Do you care about the possibility that VF Enable has been
cleared?

> Reported-by: Wei Gong <gongwei833x@gmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Wei Gong, thanks for your testing of the RFC!
> As I made a small change, would appreciate re-testing.
> 
> Thanks!
> 
> changes from RFC:
> 	use pci_physfn() wrapper to make the code build without PCI_IOV
> 
> 
>  drivers/pci/pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 2127aba3550b..899b3f52e84e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6445,8 +6445,13 @@ bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2)
>  
>  bool pci_device_is_present(struct pci_dev *pdev)
>  {
> +	struct pci_dev *physfn = pci_physfn(pdev);
>  	u32 v;
>  
> +	/* Not a PF? Switch to the PF. */
> +	if (physfn != pdev)
> +		return pci_device_is_present(physfn);
> +
>  	if (pci_dev_is_disconnected(pdev))
>  		return false;
>  	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
> -- 
> MST
> 
