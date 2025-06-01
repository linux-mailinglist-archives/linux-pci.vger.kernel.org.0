Return-Path: <linux-pci+bounces-28782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D1EAC9F9A
	for <lists+linux-pci@lfdr.de>; Sun,  1 Jun 2025 19:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8D4174C18
	for <lists+linux-pci@lfdr.de>; Sun,  1 Jun 2025 17:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB291F1319;
	Sun,  1 Jun 2025 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cz7ytJx5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801AC1F0E49
	for <linux-pci@vger.kernel.org>; Sun,  1 Jun 2025 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748798543; cv=none; b=b0Gcs078yj/pymrZJzBH4gC+PFHpIhUGv9a/OlpLSZM09UmqDKBVF+Py0F3ZduPe8nJcEY6KiH12X6Q3CSs7Dx2lbqwgQUhegmwBarS9nLnf0lpRFdJ2cRv6vacf1c9+U6OMpFZMjyGbFiVBkrhgkyRUe+HUrE4rCr70szzfBG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748798543; c=relaxed/simple;
	bh=XYtZ8hPVoS36618hvMJTxFasWcg1vgDTWrPXxNncnDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/efMdrhef0CHYj3LmpSNcU2efyyCZUWbDi97xAavi589xZTEqXROMqwl9fpsrzxe4y8i6L5/WTqefD+Hk3eI7RpbAwt263tzWmeKwafwfmA/f18WiqvdhAftVFGJotEOeFmYApsiv9EyO2rNosJTIxFJY7dddoKjQvSOnrCDVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cz7ytJx5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2351ffb669cso26715005ad.2
        for <linux-pci@vger.kernel.org>; Sun, 01 Jun 2025 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748798541; x=1749403341; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3PGxl3SxA+FXcctq4t0AyhynMTiv9JReGhiddIeNQLY=;
        b=Cz7ytJx5Aro1Vs5c1ZTgu9PsamiRHvvu5l2DtZ9GZRwrJx3mruGfxVgD5PtA7Yz7W/
         KWyH/NOnQu+xmK04v0OJzGS/gm2Qv/nhRzIE0c3A0Psu7e1CY0lQDEY65TNeOVjhWW5u
         udaKaWrkNBHwcPH+jB7HJyzO4OoYLBFgAU0MamrJRw1Evy9uYnUHqwdzQXusbwd69fz1
         ga93ZG63Vkp3uWbQCqqtjm/ejE1VACtPaDAS/TqN3mDfLQRDPPGqFFbVSeMKkFJxklzp
         3YFd5h67U2w7oqAVD4k6BS6SAU80GY3vtF+QQlIrhXrD9QN1Va/5aiQSYXegiSNDEf01
         1HQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748798541; x=1749403341;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3PGxl3SxA+FXcctq4t0AyhynMTiv9JReGhiddIeNQLY=;
        b=rsm8Q+RQbmWQaVRUDiq6uR3oE6XGdsNjHulfDk1STtSClHkBci4Z5VlmgMDIW6bCAd
         9SasxJrYvIDjqBqvo4h47vT8E8Evjo3ATzpQXx+PYTZu1s9CE5uXLDUuSEFtWAoqXDvn
         pRE2O96JnXyIqFkvqTNcKcQKeYeCzXZQQEoaTsANVg+4gAtmhQGrY9f8tfBtT2HOuBEH
         zJ9W0A9SEQlg4pXxQ6eLQafU+ICcwa70l7bnckUbgNlBEfXomjToKie/w5UMJ7IRIhHj
         qthfOaKQ08lddKJFrTCYVwyYZ51bdZsUyBZJ/hwyQqcVbJj9VWQuyaaOBy6Wp9JKN2rz
         vdGg==
X-Forwarded-Encrypted: i=1; AJvYcCVmc+pWG7VJGM9L93oERRogJF72L9ukZOfIoz/RIpnozgxCFbnJhLW+cxE3NLhB0YW1orBKiR9qyD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDve463Xjm7HsZDkVUBYtY2kuUvr3+Oe09l0ZrPeWaPfAdpCzJ
	NvD7to/I8x0V5YZyUgiM8KSx/7TxIXN5pzlAPXTx1KQqrbcJz0HqMWNzU/8vy9BKOw==
X-Gm-Gg: ASbGncvjE7vToEKcX5/OK9b1oiaZOG49DOrpchTRm4yJWd65uRexf9ZGZHb/Amt9fP9
	6Vi6ymsn/LickfAJUXsIGxaz0ULVYjwsYGSw+vxYKKehdgc95UkEqCD6caOym2NuW2WJ6VkvQ3+
	VjeJadYncvZA5YLg9V5MTJ1wS8gT4Skv186D0KJbK7RRRKdysAQ3PoOt8/FyXHfg+IYtUACHc27
	xT6NmK/D0bH1oYz3sbnCK5qqj+9JV1uBjodOBbzUcOnBi55GmR9ZxTItMlfW+X8zsOMjc5rSahe
	b7LDTrUCJeKAj5Rta/vS9kW68tdyYi4jnSrEVFVrWg4NN3BEAMDTHiTKXo0Htsk=
X-Google-Smtp-Source: AGHT+IGdEN2qeOOmEA0WZo8jBXGtNuiq7nSp1+snxKHmbj3Hsef5BBzeQGzwQjQ8QwS6UwQ7OVWKYw==
X-Received: by 2002:a17:903:22c4:b0:220:d257:cdbd with SMTP id d9443c01a7336-2355f783273mr80408645ad.48.1748798540641;
        Sun, 01 Jun 2025 10:22:20 -0700 (PDT)
Received: from thinkpad ([120.56.205.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc8a56sm57346635ad.20.2025.06.01.10.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 10:22:20 -0700 (PDT)
Date: Sun, 1 Jun 2025 22:52:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] PCI: Add Extended Tag + MRRS quirk for Xeon 6
Message-ID: <xwcoamcgyprdiru3z3qyamqxjmolis23vps4axzkpesgjrag4p@wnp63ospijyw>
References: <20250422130207.3124-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250422130207.3124-1-ilpo.jarvinen@linux.intel.com>

On Tue, Apr 22, 2025 at 04:02:07PM +0300, Ilpo Järvinen wrote:
> When bifurcated to x2, Xeon 6 Root Port performance is sensitive to the
> configuration of Extended Tags, Max Read Request Size (MRRS), and 10-Bit
> Tag Requester (note: there is currently no 10-Bit Tag support in the
> kernel). While those can be configured to the recommended values by FW,
> kernel may decide to overwrite the initial values.
> 
> Unfortunately, there is no mechanism for FW to indicate OS which parts
> of PCIe configuration should not be altered. Thus, the only option is
> to add such logic into the kernel as quirks.
> 
> There is a pre-existing quirk flag to disable Extended Tags. Depending
> on CONFIG_PCIE_BUS_* setting, MRRS may be overwritten by what the
> kernel thinks is the best for performance (the largest supported
> value), resulting in performance degradation instead with these Root
> Ports. (There would have been a pre-existing quirk to disallow
> increasing MRRS but it is not identical to rejecting >128B MRRS.)
> 
> Add a quirk that disallows enabling Extended Tags and setting MRRS
> larger than 128B for devices under Xeon 6 Root Ports if the Root Port is
> bifurcated to x2. Reject >128B MRRS only when it is going to be written
> by the kernel (this assumes FW configured a good initial value for MRRS
> in case the kernel is not touching MRRS at all).
> 
> It was first attempted to always write MRRS when the quirk is needed
> (always overwrite the initial value). That turned out to be quite
> invasive change, however, given the complexity of the initial setup
> callchain and various stages returning early when they decide no changes
> are necessary, requiring override each. As such, the initial value for
> MRRS is now left into the hands of FW.
> 
> Link: https://cdrdv2.intel.com/v1/dl/getContent/837176
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
> v2:
> - Explain in changelog why FW cannot solve this on its own
> - Moved the quirk under arch/x86/pci/
> - Don't NULL check value from pci_find_host_bridge()
> - Added comment above the quirk about the performance degradation
> - Removed all setup chain 128B quirk overrides expect for MRRS write
>   itself (assumes a sane initial value is set by FW)
> 
>  arch/x86/pci/fixup.c | 30 ++++++++++++++++++++++++++++++
>  drivers/pci/pci.c    | 15 ++++++++-------
>  include/linux/pci.h  |  1 +
>  3 files changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index efefeb82ab61..aa9617bc4b55 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -294,6 +294,36 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PB1,	pcie_r
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC,	pcie_rootport_aspm_quirk);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC1,	pcie_rootport_aspm_quirk);
>  
> +/*
> + * PCIe devices underneath Xeon6 PCIe Root Port bifurcated to 2x have slower
> + * performance with Extended Tags and MRRS > 128B. Workaround the performance
> + * problems by disabling Extended Tags and limiting MRRS to 128B.
> + *
> + * https://cdrdv2.intel.com/v1/dl/getContent/837176
> + */
> +static void quirk_pcie2x_no_tags_no_mrrs(struct pci_dev *pdev)
> +{
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
> +	u32 linkcap;
> +
> +	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &linkcap);
> +	if (FIELD_GET(PCI_EXP_LNKCAP_MLW, linkcap) != 0x2)
> +		return;
> +
> +	bridge->no_ext_tags = 1;
> +	bridge->only_128b_mrrs = 1;

My 2 cents here. Wouldn't it work if you hardcode MRRS to 128 in PCI_EXP_DEVCTL
here and then set pci_host_bridge::no_inc_mrrs to 1? This would avoid
introducing an extra flag and also serve the same purpose.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

