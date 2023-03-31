Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532236D289E
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 21:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCaT0K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Mar 2023 15:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjCaT0J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Mar 2023 15:26:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7B82031B
        for <linux-pci@vger.kernel.org>; Fri, 31 Mar 2023 12:26:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F7C1B831E4
        for <linux-pci@vger.kernel.org>; Fri, 31 Mar 2023 19:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7817C433D2;
        Fri, 31 Mar 2023 19:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680290766;
        bh=WJa543mJSNyYTJR5QsnsryEXbOodqYiasEk9BWyWloU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r/6d7R3olffPU3rvYXycgGgKeEB6ocEuoYlw4n8rOVjAL+COGgXA8vtySTFrq859w
         NSv0tlhVZpkgzF/CMtvbm3KZ1YS1BwqCsFpb38d8lKDwz/mvIS8ua7ezZNtiyLIwWC
         ytESu8H3ggInyt2ZSegVXdCs+fnQiNLCUJpVOK8TCZ7HFsTvwOmoBfoObK13WU6Q95
         0rsWza0pVrusUeYEKNha2EXRxTjS+0SgBRVhnjIeS88RPVjHYsNX84lscrE9mOLFPx
         QBDh0uxB+VkchjiW/C74lNPT+w2gvuLmavMCHGBdOfV0UY039SXfFRcidwMFTIB8b+
         jER7ny4AXwpVg==
Date:   Fri, 31 Mar 2023 14:26:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, Oded Gabbay <ogabbay@kernel.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        linux-pci@vger.kernel.org,
        Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: Re: [PATCH] accel/ivpu: Remove D3hot delay for Meteorlake
Message-ID: <20230331192604.GA3246007@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331114027.2803100-1-stanislaw.gruszka@linux.intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 31, 2023 at 01:40:27PM +0200, Stanislaw Gruszka wrote:
> From: Karol Wachowski <karol.wachowski@linux.intel.com>
> 
> VPU on MTL has hardware optimizations and does not require 10ms
> D0 - D3hot transition delay imposed by PCI specification.

PCIe r6.0, sec 5.9.

> The delay removal is traditionally done by adding PCI ID to
> quirk_remove_dhot_delay() in drivers/pci/quirks.c . But since

quirk_remove_d3hot_delay()

> we do not need that optimization before driver probe and we
> can better specify in the ivpu driver on what (future) hardware
> use the optimization, we do not use quirk_remove_dhot_delay()

Again.

> for that.
> 
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> ---
>  drivers/accel/ivpu/ivpu_drv.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
> index 3be4a5a2b07a..cf9925c0a8ad 100644
> --- a/drivers/accel/ivpu/ivpu_drv.c
> +++ b/drivers/accel/ivpu/ivpu_drv.c
> @@ -442,6 +442,10 @@ static int ivpu_pci_init(struct ivpu_device *vdev)
>  	/* Clear any pending errors */
>  	pcie_capability_clear_word(pdev, PCI_EXP_DEVSTA, 0x3f);
>  
> +	/* VPU MTL does not require PCI spec 10m D3hot delay */
> +	if (ivpu_is_mtl(vdev))
> +		pdev->d3hot_delay = 0;

d3hot_delay is used after a D0->D3hot transition, after a D3hot->D0
transition, and after the D0->D3hot and D3hot->D0 transitions in
pci_pm_reset().

I assume this device can tolerate removing *all* of those delays,
right?

>  	ret = pcim_enable_device(pdev);
>  	if (ret) {
>  		ivpu_err(vdev, "Failed to enable PCI device: %d\n", ret);
> -- 
> 2.25.1
> 
