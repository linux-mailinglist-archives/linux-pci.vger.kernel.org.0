Return-Path: <linux-pci+bounces-28844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C0FACC2C5
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 11:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14EC170634
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 09:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DB318DB29;
	Tue,  3 Jun 2025 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PhkqckiJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC792C327A;
	Tue,  3 Jun 2025 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748942329; cv=none; b=YAdCkskWqB1gaQmlYgSDXumLC6tv1hFmwo5N7gJwSm1q2GoXA2gLqUzIFxqV/7JzYfwDFisMmdcJIfdmsUWhDssNB+RAFngMH0zI++7lQIeyVfP0kBW+1/lTGY9LMkdj2QiFhDYFRPEWm68LEKc/5xccy+pSIs3hvJ3q4B6IUDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748942329; c=relaxed/simple;
	bh=6QEcL01YpnCqvbTuBXO0Xe3eoIxPT1gt6bMAM3bpvdk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fB/D9O7PPjfjNbvTjJHZGLuWuXcRKrUmTNPjmkc2wcOXh5N9z/f3v1KViczdaComspfhPFRkbAyh+00tG+YpARoXO58NMeK8V9i2KVR95AEngDZqClHgcgfyhSC3XJKiwiox4TT21+uDZ/cIHOztrsVel4GjOF2dsW/mpGCE7+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PhkqckiJ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748942328; x=1780478328;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6QEcL01YpnCqvbTuBXO0Xe3eoIxPT1gt6bMAM3bpvdk=;
  b=PhkqckiJY6vnSY446mZF1Gd4uX/3oKWDDHQ8cSwtYY8O963YIAq17qsl
   iokuq5a3KE/ff0aSbUTJhpYW6FxfGzs07shgj7hMej0i41OIlDy3Cg8Dk
   jHUNFq5PSN7zgwEXH74RPKV4/k6dFPrPbgaA7EHIxsd56644IS1ftCA9T
   4+SitXstjFrfm6SuvE35C1lGXu4n4UOrfXsGjywDKWikCBrArRSGa+n5r
   ra9C4afF96wnxtviD0gELCM7qv2dAXakgNeyk2I18mlYvr7OuaLdechIv
   aFQpiwpavXLLh/F+yWDerw5j10qZ7vBmjWFPAqMHQp27vyRUFXKZmDDzI
   g==;
X-CSE-ConnectionGUID: 2bOkv3h+TCWaUerzlztUQw==
X-CSE-MsgGUID: 8YNgsErbRpiP8F5G8KVrlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="38600390"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="38600390"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:18:47 -0700
X-CSE-ConnectionGUID: nEIonyeOSYKEDWSoQw2zlQ==
X-CSE-MsgGUID: a00KUzj8R+mGwBWPoiFS3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="145429410"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.141])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:18:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Jun 2025 12:18:39 +0300 (EEST)
To: Hans Zhang <18255117159@163.com>
cc: lpieralisi@kernel.org, bhelgaas@google.com, 
    manivannan.sadhasivam@linaro.org, kw@linux.com, cassel@kernel.org, 
    robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 1/6] PCI: Introduce generic bus config read helper
 function
In-Reply-To: <20250514161258.93844-2-18255117159@163.com>
Message-ID: <d6eeb0b5-53b3-5c40-00df-f79aa2619711@linux.intel.com>
References: <20250514161258.93844-1-18255117159@163.com> <20250514161258.93844-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 15 May 2025, Hans Zhang wrote:

> The primary PCI config space accessors are tied to the size of the read
> (byte/word/dword). Upcoming refactoring of PCI capability discovery logic
> requires passing a config accessor function that must be able to perform
> read with different sizes.
> 
> Add any size config space read accessor pci_bus_read_config() to allow
> giving it as the config space accessor to the upcoming PCI capability
> discovery macro.
> 
> Reconstructs the PCI function discovery logic to prepare for unified
> configuration of access modes. No function changes are intended.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
> Changes since v9 ~ v11:
> - None
> 
> Changes since v8:
> - The new split is patch 1/6.
> - The patch commit message were modified.
> ---
>  drivers/pci/access.c | 17 +++++++++++++++++
>  drivers/pci/pci.h    |  2 ++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index b123da16b63b..603332658ab3 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -85,6 +85,23 @@ EXPORT_SYMBOL(pci_bus_write_config_byte);
>  EXPORT_SYMBOL(pci_bus_write_config_word);
>  EXPORT_SYMBOL(pci_bus_write_config_dword);
>  
> +int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
> +			u32 *val)
> +{
> +	struct pci_bus *bus = priv;
> +	int ret;
> +
> +	if (size == 1)
> +		ret = pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
> +	else if (size == 2)
> +		ret = pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
> +	else
> +		ret = pci_bus_read_config_dword(bus, devfn, where, val);

Perhaps this should check also size == 4 and return 
PCIBIOS_BAD_REGISTER_NUMBER in case size is wrong.

> +
> +	return ret;


> +}
> +EXPORT_SYMBOL_GPL(pci_bus_read_config);

Does this even need to be exported? Isn't the capability search always 
built in?

>  int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
>  			    int where, int size, u32 *val)
>  {
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index b81e99cd4b62..5e1477d6e254 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -88,6 +88,8 @@ extern bool pci_early_dump;
>  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
>  bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
>  bool pcie_cap_has_rtctl(const struct pci_dev *dev);
> +int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
> +			u32 *val);
>  
>  /* Functions internal to the PCI core code */
>  
> 

-- 
 i.


