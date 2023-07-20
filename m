Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AEC75B9E3
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 23:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjGTVz4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 17:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGTVzz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 17:55:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5186D1719;
        Thu, 20 Jul 2023 14:55:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA93361C37;
        Thu, 20 Jul 2023 21:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB259C433C8;
        Thu, 20 Jul 2023 21:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689890153;
        bh=/bXS787t6CrBfx1QzszVq51xokDzGgEBIJZxAQSEBpc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PckrirTH+R/atkbCgfex4heLW9KXK7s+ISrPtn4IqPCDQOKZUWg1Hku404dLZZsBi
         NuuAgsruXLXuYa229tXINUGekioW5P7Daw5vmq90cy11jXiwkYB9r4Q+5N+La7zPDk
         5WqD3lk4QWHGuFSFJug0czFpUN8scQsR9tJ+IWE8KHhCRC0TUgdK5LmS3cYU52B7qH
         9e5rmBwkikmKUYtCWFxPRDrRYB+UqPcIPK0NqFdydH+LDgmkJl14xxSE3FtpsbiCvI
         9KcFD7+bTSrCTKeTdQWB2g7KwQ6lw6itidOZ0E6XQVL48L8lzxOjEWHZyfxe0A+k0L
         Xv+29EkPDh4uA==
Date:   Thu, 20 Jul 2023 16:55:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jammy Zhou <Jammy.Zhou@amd.com>,
        Ken Wang <Qingqing.Wang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        Jonas =?iso-8859-1?Q?Dre=DFler?= <verdre@v0yd.nl>,
        stable@vger.kernel.org
Subject: Re: [PATCH v5 05/11] drm/amdgpu: Use RMW accessors for changing
 LNKCTL
Message-ID: <20230720215550.GA554900@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230717120503.15276-6-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 17, 2023 at 03:04:57PM +0300, Ilpo Järvinen wrote:
> Don't assume that only the driver would be accessing LNKCTL. ASPM
> policy changes can trigger write to LNKCTL outside of driver's control.
> And in the case of upstream bridge, the driver does not even own the
> device it's changing the registers for.
> 
> Use RMW capability accessors which do proper locking to avoid losing
> concurrent updates to the register value.
> 
> Fixes: a2e73f56fa62 ("drm/amdgpu: Add support for CIK parts")
> Fixes: 62a37553414a ("drm/amdgpu: add si implementation v10")
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: stable@vger.kernel.org

Do we have any reports of problems that are fixed by this patch (or by
others in the series)?  If not, I'm not sure it really fits the usual
stable kernel criteria:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-kernel-rules.rst?id=v6.4

> ---
>  drivers/gpu/drm/amd/amdgpu/cik.c | 36 +++++++++-----------------------
>  drivers/gpu/drm/amd/amdgpu/si.c  | 36 +++++++++-----------------------
>  2 files changed, 20 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
> index 5641cf05d856..e63abdf52b6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -1574,17 +1574,8 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
>  			u16 bridge_cfg2, gpu_cfg2;
>  			u32 max_lw, current_lw, tmp;
>  
> -			pcie_capability_read_word(root, PCI_EXP_LNKCTL,
> -						  &bridge_cfg);
> -			pcie_capability_read_word(adev->pdev, PCI_EXP_LNKCTL,
> -						  &gpu_cfg);
> -
> -			tmp16 = bridge_cfg | PCI_EXP_LNKCTL_HAWD;
> -			pcie_capability_write_word(root, PCI_EXP_LNKCTL, tmp16);
> -
> -			tmp16 = gpu_cfg | PCI_EXP_LNKCTL_HAWD;
> -			pcie_capability_write_word(adev->pdev, PCI_EXP_LNKCTL,
> -						   tmp16);
> +			pcie_capability_set_word(root, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
> +			pcie_capability_set_word(adev->pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
>  
>  			tmp = RREG32_PCIE(ixPCIE_LC_STATUS1);
>  			max_lw = (tmp & PCIE_LC_STATUS1__LC_DETECTED_LINK_WIDTH_MASK) >>
> @@ -1637,21 +1628,14 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
>  				msleep(100);
>  
>  				/* linkctl */
> -				pcie_capability_read_word(root, PCI_EXP_LNKCTL,
> -							  &tmp16);
> -				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
> -				tmp16 |= (bridge_cfg & PCI_EXP_LNKCTL_HAWD);
> -				pcie_capability_write_word(root, PCI_EXP_LNKCTL,
> -							   tmp16);
> -
> -				pcie_capability_read_word(adev->pdev,
> -							  PCI_EXP_LNKCTL,
> -							  &tmp16);
> -				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
> -				tmp16 |= (gpu_cfg & PCI_EXP_LNKCTL_HAWD);
> -				pcie_capability_write_word(adev->pdev,
> -							   PCI_EXP_LNKCTL,
> -							   tmp16);
> +				pcie_capability_clear_and_set_word(root, PCI_EXP_LNKCTL,
> +								   PCI_EXP_LNKCTL_HAWD,
> +								   bridge_cfg &
> +								   PCI_EXP_LNKCTL_HAWD);
> +				pcie_capability_clear_and_set_word(adev->pdev, PCI_EXP_LNKCTL,
> +								   PCI_EXP_LNKCTL_HAWD,
> +								   gpu_cfg &
> +								   PCI_EXP_LNKCTL_HAWD);

Wow, there's a lot of pointless-looking work going on here:

  set root PCI_EXP_LNKCTL_HAWD
  set GPU  PCI_EXP_LNKCTL_HAWD

  for (i = 0; i < 10; i++) {
    read root PCI_EXP_LNKCTL
    read GPU  PCI_EXP_LNKCTL

    clear root PCI_EXP_LNKCTL_HAWD
    if (root PCI_EXP_LNKCTL_HAWD was set)
      set root PCI_EXP_LNKCTL_HAWD

    clear GPU  PCI_EXP_LNKCTL_HAWD
    if (GPU  PCI_EXP_LNKCTL_HAWD was set)
      set GPU  PCI_EXP_LNKCTL_HAWD
  }

If it really *is* pointless, it would be nice to clean it up, but that
wouldn't be material for this patch, so what you have looks good.

>  				/* linkctl2 */
>  				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,

The PCI_EXP_LNKCTL2 stuff also includes RMW updates.  I don't see any
uses of PCI_EXP_LNKCTL2 outside this driver that look relevant, so I
guess we don't care about making the PCI_EXP_LNKCTL2 updates atomic?

Bjorn
