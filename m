Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3034E4C1CF2
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 21:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240543AbiBWUNv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 15:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237733AbiBWUNq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 15:13:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBFD4C419
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 12:13:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED9B5B8212F
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 20:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C7BC340E7;
        Wed, 23 Feb 2022 20:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645647195;
        bh=L7d7iG7lRmORL3gu1lqlToL23jzch1hEujwvhPCVdqo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=F9uXOOFUFvD1hhhC+0dCAl6wJTupnhlclpvpg/WLX5oSfLQ5fOfDgFsFagBMdsFMo
         BwWsL0try7L2rtu9Lc8fSF6BE0PtS78ZyIlOHCIfM17+ZlqcF36uYt7dbezAbwYO/v
         TG6ZMsBweesdBfY7gGbbSmRZYd089fGHEonkNuXiKmY+8NyeYVfjtavT66J8TV5p//
         BoE0n6UPcpuQy+KPHYfcMKnB/jR+QprkrHtAhTGtZIBpnQKg2VtFqHIQUXd0Ryuty2
         l23FByslWoLFOkQifzO2H3Q1Q51EPBM1AHjhtzVxQsw36yRro5a2UOvUc389mHb06u
         XEKbY3zG2wmWA==
Date:   Wed, 23 Feb 2022 14:13:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Apply quirk_amd_harvest_no_ats to all navi10 and 14
 asics
Message-ID: <20220223201313.GA148471@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220222160801.841643-1-alexander.deucher@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 22, 2022 at 11:08:01AM -0500, Alex Deucher wrote:
> There are enough vbios escapes without the proper workaround
> that some users still hit this.  MS never productized ATS on
> windows so OEM platforms that were windows only didn't always
> validate ATS.
> 
> The advantages of ATS are not worth it compared to the potential
> instabilities on harvested boards.  Just disable ATS on all navi10
> and 14 boards.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1760
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Thanks, applied to for-linus for v5.17 with commit log:

    PCI: Mark all AMD Navi10 and Navi14 GPU ATS as broken
    
    There are enough VBIOS escapes without the proper workaround that some
    users still hit this.  Microsoft never productized ATS on Windows so OEM
    platforms that were Windows-only didn't always validate ATS.
    
    The advantages of ATS are not worth it compared to the potential
    instabilities on harvested boards.  Disable ATS on all Navi10 and Navi14
    boards.
    
    Symptoms include:
    
      amdgpu 0000:07:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0007 address=0xffffc02000 flags=0x0000]
      AMD-Vi: Event logged [IO_PAGE_FAULT device=07:00.0 domain=0x0007 address=0xffffc02000 flags=0x0000]
      [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma0 timeout, signaled seq=6047, emitted seq=6049
      amdgpu 0000:07:00.0: amdgpu: GPU reset begin!
      amdgpu 0000:07:00.0: amdgpu: GPU reset succeeded, trying to resume
      amdgpu 0000:07:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring sdma0 test failed (-110)
      [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block <sdma_v4_0> failed -110
      amdgpu 0000:07:00.0: amdgpu: GPU reset(1) failed
    
    Related commits:
    
      e8946a53e2a6 ("PCI: Mark AMD Navi14 GPU ATS as broken")
      a2da5d8cc0b0 ("PCI: Mark AMD Raven iGPU ATS as broken in some platforms")
      45beb31d3afb ("PCI: Mark AMD Navi10 GPU rev 0x00 ATS as broken")
      5e89cd303e3a ("PCI: Mark AMD Navi14 GPU rev 0xc5 ATS as broken")
      d28ca864c493 ("PCI: Mark AMD Stoney Radeon R7 GPU ATS as broken")
      9b44b0b09dec ("PCI: Mark AMD Stoney GPU ATS as broken")
    
    [bhelgaas: add symptoms and related commits]
    Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1760
    Link: https://lore.kernel.org/r/20220222160801.841643-1-alexander.deucher@amd.com
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Acked-by: Christian König <christian.koenig@amd.com>
    Acked-by: Guchun Chen <guchun.chen@amd.com>

> ---
>  drivers/pci/quirks.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 003950c738d2..ea2de1616510 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5341,11 +5341,6 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
>   */
>  static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
>  {
> -	if ((pdev->device == 0x7312 && pdev->revision != 0x00) ||
> -	    (pdev->device == 0x7340 && pdev->revision != 0xc5) ||
> -	    (pdev->device == 0x7341 && pdev->revision != 0x00))
> -		return;
> -
>  	if (pdev->device == 0x15d8) {
>  		if (pdev->revision == 0xcf &&
>  		    pdev->subsystem_vendor == 0xea50 &&
> @@ -5367,10 +5362,19 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_amd_harvest_no_ats);
>  /* AMD Iceland dGPU */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
>  /* AMD Navi10 dGPU */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7310, quirk_amd_harvest_no_ats);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7318, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7319, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731a, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731b, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731e, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731f, quirk_amd_harvest_no_ats);
>  /* AMD Navi14 dGPU */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7341, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7347, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x734f, quirk_amd_harvest_no_ats);
>  /* AMD Raven platform iGPU */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_ats);
>  #endif /* CONFIG_PCI_ATS */
> -- 
> 2.35.1
> 
