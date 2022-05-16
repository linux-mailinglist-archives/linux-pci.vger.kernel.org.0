Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150805291A3
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 22:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiEPUjP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 16:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348733AbiEPUhC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 16:37:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0945001E;
        Mon, 16 May 2022 13:18:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 973B96124D;
        Mon, 16 May 2022 20:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9343CC34115;
        Mon, 16 May 2022 20:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652732299;
        bh=+6uDV10Sc3DTLJDwxFmU67G8zR9GmxWTjZaSRJ32XLg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=e4kdVQ/Dpfon3rGXiGajSkfjR9K2FBo1wKLw+wBBNeMi+8vyzfTWecKzDAW3TzJ7z
         hxID2Br1Mj8PN/ghRReXgpxOIUhovVXSC7q6OCnTP0fBTK+2B045Dd01UGJQ+/SBmD
         0YmUSh87/GSaM70G2VJ7hhy2LGITABy1w11uDcGncZMALgUpekTZHVRDOwD7Z8oqBq
         pw3kHdktEP7gZuRSm0gpVZGAMiF996gaYID9Axl6FPHNQ7xMB93+ks+STQmDifhLkq
         ulNVvCjlwUGzbchx+0ihF8VPGYcos2W0d5K1dYo2vpVvIgdbOGqEw4LN0ye0tNN+mg
         cn2fff1GBOWxg==
Date:   Mon, 16 May 2022 15:18:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
        hch@lst.de, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, svarbanov@mm-sol.com,
        bjorn.andersson@linaro.org, axboe@fb.com,
        quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
        quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me
Subject: Re: [PATCH 1/3] PCI: Add a flag to notify PCI drivers about
 powerdown during suspend
Message-ID: <20220516201817.GA1047280@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513110027.31015-2-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 13, 2022 at 04:30:25PM +0530, Manivannan Sadhasivam wrote:
> On some systems like Chromebooks based on Qcom chipsets, the OS may
> powerdown all PCIe devices during system suspend for aggressive
> powersaving. In that case, the PCI host controller drivers need to notify
> the PCI device drivers that the power will be taken off during system
> suspend so that the drivers can prepare the devices accordingly.

"The OS may powerdown all PCIe devices ..." makes it sound like this
is an OS policy decision.  Where exactly (what function) is that?

Or if it's not an OS policy decision, but rather some property of the
hardware, say that specifically.

> One prime example is the PCI NVMe driver. This flag can be used by the
> driver to shutdown the NVMe device during suspend and recover it during
> resume.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  include/linux/pci.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 60adf42460ab..069caf1fe88d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -578,6 +578,7 @@ struct pci_host_bridge {
>  	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
>  	unsigned int	size_windows:1;		/* Enable root bus sizing */
>  	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
> +	unsigned int	suspend_poweroff:1;	/* OS may poweroff devices during system suspend */
>  
>  	/* Resource alignment requirements */
>  	resource_size_t (*align_resource)(struct pci_dev *dev,
> -- 
> 2.25.1
> 
