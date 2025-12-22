Return-Path: <linux-pci+bounces-43529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5933ECD67A0
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 16:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 238ED307623A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 15:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4CC309F00;
	Mon, 22 Dec 2025 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tu5zLGys"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47738320A01
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766415892; cv=none; b=V+Pj/+uHEUegs5pqQiLvWIgLXcV8cpjBYZgxKXtcU0v6faBnj/uPQbMRkNW+pL4wV0/IWa6yW5Ye/TnticBQvwfgVKzj0PezAd189lxYBYrqfi3FaZTmPPVgetXIaPxCG4djDGKRNquVvmadw1VNCqItgKf4/5wbWT75DBrMqHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766415892; c=relaxed/simple;
	bh=V6WAaEP1B/01Eqh0K3TgR1/bnWn12dLPrN0VGYolMkk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=I+Bg1pgP8J+Tl2IGp7HII2SevRIeal1TPqfKmZwHGmqXf00wubisCORQKSJpy3R2lYUNM/0QuYzyqR0ApvBBMuFtoeRCwcT+l4u+yjyU5u+4JEeFqql2rBj/4RXfaOzrU7IUK4t3dxa/h+Rld3fVr/5+CVcfsJpp9BQ2UHxr1Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tu5zLGys; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766415890; x=1797951890;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=V6WAaEP1B/01Eqh0K3TgR1/bnWn12dLPrN0VGYolMkk=;
  b=Tu5zLGysiJCdRO6oyr1Ogxu5tf+w0cl7LpA3XT6l/BXe94bS2DhMdGCl
   ZYeSMc8OfxMyrwv1ydbIv2jbWirwEXpvEw4ub6y2TRjmjcux3+fuDP4Xw
   AkOEQKbkPmNjFPmxWNMMG9lNq6NM0rJuR0LooS3OamHbEMKeaE4g+WKjY
   tTVaJKlN2BokJgn4pHNUucVeSbtJrpfp7R4YrL9VM8FMnFBqgudZt13aI
   G0QdDNp7/h9NBiLhTxRvJmE7DvwgwMKc2iUl/RRsggz5ENQj/i1Zo9B/7
   5TUYvxjGbrBAR8AdWua3sBhKaxnz+Rjb8BmJjfwUigzDmn+WfAR/m0/MY
   Q==;
X-CSE-ConnectionGUID: ntvH/n2CSsWCRvduxkPd1w==
X-CSE-MsgGUID: T1iJ0T97SHuJjy9o2LRQXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="71901423"
X-IronPort-AV: E=Sophos;i="6.21,168,1763452800"; 
   d="scan'208";a="71901423"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 07:04:49 -0800
X-CSE-ConnectionGUID: Z/G6RZNYTeW3Xhe1G2Br7w==
X-CSE-MsgGUID: hv95g8RNRQCp5JfQSaiOJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,168,1763452800"; 
   d="scan'208";a="230201733"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 07:04:47 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 22 Dec 2025 17:04:44 +0200 (EET)
To: Roman Shlyakhov <roman.shlyakhov.rs@gmail.com>
cc: helgaas@kernel.org, linux-pci@vger.kernel.org, 
    oe-kbuild-all@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] pci: pci-stub fix kernel-doc warnings
In-Reply-To: <20251222132854.112890-1-roman.shlyakhov.rs@gmail.com>
Message-ID: <bd06eeb4-69ca-9a93-9a48-3f0316ed8377@linux.intel.com>
References: <20251222132854.112890-1-roman.shlyakhov.rs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 22 Dec 2025, Roman Shlyakhov wrote:

> Fix kernel-doc warnings reported by kernel test robot:
> 
> Warning: drivers/pci/pci-stub.c:55 This comment starts with '/**',
> 	but isn't a kernel-doc comment.
> Warning: drivers/pci/pci-stub.c:122 This comment starts with '/**',
> 	but isn't a kernel-doc comment.
> Warning: drivers/pci/pci-stub.c:148 This comment starts with '/**',
> 	but isn't a kernel-doc comment.
> Warning: drivers/pci/pci-stub.c:207 This comment starts with '/**',
> 	but isn't a kernel-doc comment.
> Warning: drivers/pci/pci-stub.c:222 This comment starts with '/**',
> 	but isn't a kernel-doc comment.
> 
> Convert incorrect /** comments to proper kernel-doc format or
> regular /* comments as required by Documentation/doc-guide/kernel-doc.rst.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512202126.F1IQYL9V-lkp@intel.com/
> Signed-off-by: Roman Shlyakhov <roman.shlyakhov.rs@gmail.com>
> ---
>  drivers/pci/pci-stub.c | 58 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 48 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
> index 3ca5e11c3939..fdeed328080e 100644
> --- a/drivers/pci/pci-stub.c
> +++ b/drivers/pci/pci-stub.c
> @@ -27,6 +27,14 @@
>  
>  static char ids[1024] __initdata;
>  
> +/**
> + * struct pci_stub_busid - represents a PCI BUSID for stub driver binding
> + * @domain: PCI domain (if domain_specified is true)
> + * @bus: PCI bus number
> + * @device: PCI device/slot number
> + * @function: PCI function number
> + * @domain_specified: true if domain was explicitly specified in BUSID
> + */
>  struct pci_stub_busid {
>  	unsigned int domain;
>  	unsigned int bus;
> @@ -52,8 +60,11 @@ MODULE_PARM_DESC(ids, "Initial PCI IDs to add to the stub driver, format is "
>  		"\"vendor:device[:subvendor[:subdevice[:class[:class_mask]]]]\""
>  		" and multiple comma separated entries can be specified");
>  
> -/**
> - * Checking if the PCI device matches the BUSID list.
> +/*

Didn't you just make this kerneldoc compatible so why only /* ?

> + * pci_stub_find_busid - Check if the PCI device matches the BUSID list
> + * @dev: PCI device to check
> + *
> + * Return: pointer to matching pci_stub_busid if found, NULL otherwise

Add . (+same comment to return entries below)

>   */
>  static struct pci_stub_busid *pci_stub_find_busid(struct pci_dev *dev)
>  {
> @@ -81,6 +92,13 @@ static struct pci_stub_busid *pci_stub_find_busid(struct pci_dev *dev)
>  	return NULL;
>  }
>  
> +/**
> + * pci_stub_probe - Probe function for pci-stub driver
> + * @dev: PCI device being probed
> + * @id: matching PCI device ID if any
> + *
> + * Return: 0 on successful claim, -ENODEV otherwise
> + */
>  static int pci_stub_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  {
>  	struct pci_stub_busid *busid = pci_stub_find_busid(dev);
> @@ -120,7 +138,15 @@ static struct pci_driver stub_driver = {
>  };
>  
>  /**
> - * Parsing a single BUSID.
> + * pci_stub_parse_one_busid - Parse a single BUSID string
> + * @str: BUSID string to parse
> + * @busid: pointer to pci_stub_busid structure to fill
> + *
> + * Formats accepted:
> + * - with domain: "DDDD:BB:DD.F"
> + * - without domain: "BB:DD.F"
> + *
> + * Return: 0 on success, -EINVAL on parse error
>   */
>  static int pci_stub_parse_one_busid(const char *str, struct pci_stub_busid *busid)
>  {
> @@ -145,8 +171,10 @@ static int pci_stub_parse_one_busid(const char *str, struct pci_stub_busid *busi
>  	return 0;
>  }
>  
> -/**
> - * Parsing the "busid" kernel parameter.
> +/*

Here too, isn't this not kernel doc compatible?

(Did you perhaps start this patch with one approach and then made the 
comments kerneldoc compatible later and forgot to add the second * back?)

There are two more similar case below.

> + * pci_stub_parse_busid_param - Parse the "busid" kernel parameter
> + *
> + * Parses comma-separated list of BUSIDs and registers them for binding.
>   */
>  static void __init pci_stub_parse_busid_param(void)
>  {
> @@ -205,7 +233,11 @@ static void __init pci_stub_parse_busid_param(void)
>  }
>  
>  /**
> - * early_param "pci_stub_busid" handler for the built-in module.
> + * pci_stub_early_param - early_param handler for "pci_stub_busid"
> + * @str: BUSID list parameter value
> + *
> + * This function is called during early boot to parse BUSID list.
> + * Return: 0 on success
>   */
>  static int __init pci_stub_early_param(char *str)
>  {
> @@ -219,8 +251,11 @@ static int __init pci_stub_early_param(char *str)
>  
>  early_param("pci_stub_busid", pci_stub_early_param);
>  
> -/**
> - * Binding devices by BUSID via dynamic IDs.
> +/*
> + * pci_stub_bind_free_devices - Bind devices by BUSID via dynamic IDs
> + *
> + * Attempts to bind all PCI devices matching registered BUSIDs to pci-stub
> + * driver using dynamic IDs.
>   */
>  static void __init pci_stub_bind_free_devices(void)
>  {
> @@ -285,8 +320,11 @@ static void __init pci_stub_bind_free_devices(void)
>  	pr_info("pci-stub: bound %d device(s), skipped %d\n", bound, skipped);
>  }
>  
> -/**
> - * Checking the final binding state.
> +/*
> + * pci_stub_verify_bindings - Check the final binding state
> + *
> + * Verifies which devices from BUSID list are bound to pci-stub,
> + * bound to other drivers, or not bound at all.
>   */
>  static void __init pci_stub_verify_bindings(void)
>  {
> 

-- 
 i.


