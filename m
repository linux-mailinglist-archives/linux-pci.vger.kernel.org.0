Return-Path: <linux-pci+bounces-42351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 429EDC96721
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 10:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06DA03A3FE4
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 09:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7DA3002CA;
	Mon,  1 Dec 2025 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SciG9jOQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B0330170C;
	Mon,  1 Dec 2025 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582340; cv=none; b=ZrxkfhkNnP2vV48Qp22gLnVkp21v3v1QikMzczaz+6PS0Vlvq/jKafPTZoj3XoIl7ptICHP1YXXTsGUKrwjUQI12n4IV0gWsItTC0bHtKAyGovlq6Rv1AddrBjzmE2sBL7elyRYzuD70PBwcziTdolKlncc+qZP54xdcdjweBrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582340; c=relaxed/simple;
	bh=LVq+9/5cspg+92u9dMeDbFkSwVC27IuNYD4W/eM5Mo8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qBgi6HR6sIjVUFNK07WDgAaDsYLz0Z2ca9hSCCEK+dqApoEEEERWKT04Oj+xJAiQ2lUamSc41Yc2X+ByhIqrHS2Plc81rQhdLZqIlw3aWbpaO3IEwtRRSQ44l4NJTv+Jg62oMebwCC5y2xldltAwEgxfFq0i1XsxQW3gZosYlJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SciG9jOQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764582339; x=1796118339;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LVq+9/5cspg+92u9dMeDbFkSwVC27IuNYD4W/eM5Mo8=;
  b=SciG9jOQ0Yuw/UkCyvYNP3ZyZWITsWx+5HHor/VTMVmI1SOBVW2X9GOs
   CktUjfcUol5OH9TNIggxzj48FCfzoFX6oo6f5WvxrgyPZUhShdowfJBD5
   H9vIPDTGA4p7Gcvr7fjFZD9uWLAmGjRirNR2i6Vxzd2BA5bW1WGBrCnkc
   nhZoaJXDjM3xgTsErx925e3J2JF1N2mp6JJ0V9Dxu9DlexmwvSmRlAgb+
   gN2K9On2W3T+AlQ9t04df+Xf+FO14NcSiApvWv1w2Q5WoZqJ7I6nHHGDV
   e59E7rNMEJknmZ6LkjsDG84ZStcpdUPVhLb3fBq9WIkLKw9sxghzeV5C3
   w==;
X-CSE-ConnectionGUID: F9YLRbndQLqjHbD9kOuBcg==
X-CSE-MsgGUID: pmLp1FcFSYmcQqsXgbYtjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="83904407"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="83904407"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 01:45:38 -0800
X-CSE-ConnectionGUID: eQTCE5n4SwqGJSbvQFWvDQ==
X-CSE-MsgGUID: pqI9JhVkS+26dacxPa+kIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="217388554"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.202])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 01:45:32 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 1 Dec 2025 11:45:28 +0200 (EET)
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Matthew W Carlis <mattc@purestorage.com>, 
    ALOK TIWARI <alok.a.tiwari@oracle.com>, ashishk@purestorage.com, 
    bamstadt@purestorage.com, msaggi@purestorage.com, sconnor@purestorage.com, 
    Lukas Wunner <lukas@wunner.de>, Jiwei <jiwei.sun.bj@qq.com>, 
    guojinhui.liam@bytedance.com, ahuang12@lenovo.com, sunjw10@lenovo.com, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Always lift 2.5GT/s restriction in PCIe failed link
 retraining
In-Reply-To: <alpine.DEB.2.21.2511290245460.36486@angie.orcam.me.uk>
Message-ID: <440e7c29-bee1-29f3-afa8-7b5905fd6cf2@linux.intel.com>
References: <alpine.DEB.2.21.2511290245460.36486@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 1 Dec 2025, Maciej W. Rozycki wrote:

> Discard Vendor:Device ID matching in the PCIe failed link retraining 
> quirk and ignore the link status for the removal of the 2.5GT/s speed 
> clamp, whether applied by the quirk itself or the firmware earlier on.  
> Revert to the original target link speed if this final link retraining 
> has failed.
> 
> This is so that link training noise in hot-plug scenarios does not make 
> a link remain clamped to the 2.5GT/s speed where an event race has led 
> the quirk to apply the speed clamp for one device, only to leave it in 
> place for a subsequent device to be plugged in.
> 
> Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Cc: <stable@vger.kernel.org> # v6.5+
> ---
>  drivers/pci/quirks.c |   50 ++++++++++++++++++--------------------------------
>  1 file changed, 18 insertions(+), 32 deletions(-)
> 
> linux-pcie-failed-link-retrain-unclamp-always.diff
> Index: linux-macro/drivers/pci/quirks.c
> ===================================================================
> --- linux-macro.orig/drivers/pci/quirks.c
> +++ linux-macro/drivers/pci/quirks.c
> @@ -79,11 +79,10 @@ static bool pcie_lbms_seen(struct pci_de
>   * Restrict the speed to 2.5GT/s then with the Target Link Speed field,
>   * request a retrain and check the result.
>   *
> - * If this turns out successful and we know by the Vendor:Device ID it is
> - * safe to do so, then lift the restriction, letting the devices negotiate
> - * a higher speed.  Also check for a similar 2.5GT/s speed restriction the
> - * firmware may have already arranged and lift it with ports that already
> - * report their data link being up.
> + * If this turns out successful, or where a 2.5GT/s speed restriction has
> + * been previously arranged by the firmware and the port reports its link
> + * already being up, lift the restriction, in a hope it is safe to do so,
> + * letting the devices negotiate a higher speed.
>   *
>   * Otherwise revert the speed to the original setting and request a retrain
>   * again to remove any residual state, ignoring the result as it's supposed
> @@ -94,52 +93,39 @@ static bool pcie_lbms_seen(struct pci_de
>   */
>  int pcie_failed_link_retrain(struct pci_dev *dev)
>  {
> -	static const struct pci_device_id ids[] = {
> -		{ PCI_VDEVICE(ASMEDIA, 0x2824) }, /* ASMedia ASM2824 */
> -		{}
> -	};
> -	u16 lnksta, lnkctl2;
> +	u16 lnksta, lnkctl2, oldlnkctl2;
>  	int ret = -ENOTTY;
> +	u32 lnkcap;
>  
>  	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
>  	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
>  		return ret;
>  
>  	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> +	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &oldlnkctl2);
>  	if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
> -		u16 oldlnkctl2;
> -
>  		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
>  
> -		pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &oldlnkctl2);
>  		ret = pcie_set_target_speed(dev, PCIE_SPEED_2_5GT, false);
> -		if (ret) {
> -			pci_info(dev, "retraining failed\n");
> -			pcie_set_target_speed(dev, PCIE_LNKCTL2_TLS2SPEED(oldlnkctl2),
> -					      true);
> -			return ret;
> -		}
> -
> -		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> +		if (ret)
> +			goto err;
>  	}
>  
>  	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
> -
> -	if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
> -	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
> -	    pci_match_id(ids, dev)) {
> -		u32 lnkcap;
> -
> +	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> +	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
> +	    (lnkcap & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {

I'm trying to recall, if there was some particular reason why 
->supported_speeds couldn't be used in this function. It would avoid the 
need to read LinkCap at all.

>  		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
> -		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
>  		ret = pcie_set_target_speed(dev, PCIE_LNKCAP_SLS2SPEED(lnkcap), false);
> -		if (ret) {
> -			pci_info(dev, "retraining failed\n");
> -			return ret;
> -		}
> +		if (ret)
> +			goto err;
>  	}
>  
>  	return ret;

return 0;

> +err:
> +	pci_info(dev, "retraining failed\n");
> +	pcie_set_target_speed(dev, PCIE_LNKCTL2_TLS2SPEED(oldlnkctl2), true);
> +	return ret;
>  }
>  
>  static ktime_t fixup_debug_start(struct pci_dev *dev,
> 

-- 
 i.


