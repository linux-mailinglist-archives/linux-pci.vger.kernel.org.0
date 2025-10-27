Return-Path: <linux-pci+bounces-39467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC39C11537
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 21:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A02461EA6
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 20:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5127748F;
	Mon, 27 Oct 2025 20:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="di9bTY2V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0892DA77F
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 20:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595715; cv=none; b=ieS1ODraMorqDHjvLh4JZNLqyrgppP5LmpxvncNXhnsuIKNseYamcswnXMF31RqpeQ4+wuN+hd87WhEj1DzJEBlbdLinsmzepWfP8qvpokma5ej8RFTQ0ZLeF9kkVNui2uSjqGB9m0T9WVOccSHqpZyugirpx9V/6qmmVh3mvfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595715; c=relaxed/simple;
	bh=yaiJY7kJATbVvAEeWT9eBONMSBJsKPlsGlY0COoauqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmMcV4C/NuB8RmcsZHIvgy7mZyvjL+K4Sib4jR+3QGQ3mYZj8r+vk5KCEINLEB3bzx5/vNd7sHuoS44hipnp4Dua+xwaTIyYR/hNZNd5fZWlMsqm0esO1TmXO1I4KvKBj3EZjuB+NcidXSHy/I8PLmAzzaBqUVLbeZw6fAafnDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=di9bTY2V; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761595714; x=1793131714;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yaiJY7kJATbVvAEeWT9eBONMSBJsKPlsGlY0COoauqA=;
  b=di9bTY2Vc1hmLDr2k4BPZU8iN5qEnit5hPw573337gP3t5UwRSiIt0aT
   WgOp72H5dG2feWs1LltVV/SbTwZucmEhxDG0xQNYIMlFNX7hswjOUzvEB
   KblTgobqPl98L1c+td1aGeiE37RHEWIDtO2vWNgYbs+wtsDJQtnnFfIko
   v2mH7+UvAaj8OQfCsG8KeEosCUgws0Wp055W+9bkX67HjmfsGYybxn5yE
   FGUvBJP1nTYR8iA/f4AQ9XyFmwfa8EYwMYCLYV43PorOqfuOf6tLUjf6m
   U5REugg+xlK2NnW/A/jKqLM7K2kO21zrZyW9kJTIm7kB6ysDgxnqG4O+M
   g==;
X-CSE-ConnectionGUID: e4JHeTNqTRuIls2Dz4LIyA==
X-CSE-MsgGUID: +eBviy2fQ42kCEG5opl84g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63593871"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="63593871"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 13:08:33 -0700
X-CSE-ConnectionGUID: z3GbI6VERcKjxhgYg3cXjg==
X-CSE-MsgGUID: C8aHrpNvSpGHYZneOPtBOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="222346323"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.109.111]) ([10.125.109.111])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 13:08:32 -0700
Message-ID: <ae79489d-8cf1-44ba-80e5-ac114c077117@intel.com>
Date: Mon, 27 Oct 2025 13:08:31 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: vmd: Switch to pci_bus_find_emul_domain_nr()
To: Dan Williams <dan.j.williams@intel.com>, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, jonathan.derrick@linux.dev,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, Szymon Durawa <szymon.durawa@linux.intel.com>,
 Nirmal Patel <nirmal.patel@linux.intel.com>
References: <20251024224622.1470555-1-dan.j.williams@intel.com>
 <20251024224622.1470555-3-dan.j.williams@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251024224622.1470555-3-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/24/25 3:46 PM, Dan Williams wrote:
> The new common domain number allocator can replace the custom allocator
> in VMD.
> 
> Beyond some code reuse benefits it does close a potential race whereby
> vmd_find_free_domain() collides with new PCI buses coming online with a
> conflicting domain number. Such a race has not been observed in
> practice, hence not tagging this change as a fix.
> 
> As VMD uses pci_create_root_bus() rather than pci_alloc_host_bridge() +
> pci_scan_root_bus_bridge() it has no chance to set ->domain_nr in the
> bridge so needs to manage freeing the domain number on its own.
> 
> Cc: Szymon Durawa <szymon.durawa@linux.intel.com>
> Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/pci/controller/vmd.c | 40 +++++++++++++++---------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index b4b62b9ccc45..03b5920138f0 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -578,22 +578,6 @@ static void vmd_detach_resources(struct vmd_dev *vmd)
>  	vmd->dev->resource[VMD_MEMBAR2].child = NULL;
>  }
>  
> -/*
> - * VMD domains start at 0x10000 to not clash with ACPI _SEG domains.
> - * Per ACPI r6.0, sec 6.5.6,  _SEG returns an integer, of which the lower
> - * 16 bits are the PCI Segment Group (domain) number.  Other bits are
> - * currently reserved.
> - */
> -static int vmd_find_free_domain(void)
> -{
> -	int domain = 0xffff;
> -	struct pci_bus *bus = NULL;
> -
> -	while ((bus = pci_find_next_bus(bus)) != NULL)
> -		domain = max_t(int, domain, pci_domain_nr(bus));
> -	return domain + 1;
> -}
> -
>  static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
>  				resource_size_t *offset1,
>  				resource_size_t *offset2)
> @@ -878,13 +862,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  		.parent = res,
>  	};
>  
> -	sd->vmd_dev = vmd->dev;
> -	sd->domain = vmd_find_free_domain();
> -	if (sd->domain < 0)
> -		return sd->domain;
> -
> -	sd->node = pcibus_to_node(vmd->dev->bus);
> -
>  	/*
>  	 * Currently MSI remapping must be enabled in guest passthrough mode
>  	 * due to some missing interrupt remapping plumbing. This is probably
> @@ -910,9 +887,24 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
>  	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
>  
> +	sd->vmd_dev = vmd->dev;
> +
> +	/*
> +	 * Emulated domains start at 0x10000 to not clash with ACPI _SEG
> +	 * domains.  Per ACPI r6.0, sec 6.5.6,  _SEG returns an integer, of
> +	 * which the lower 16 bits are the PCI Segment Group (domain) number.
> +	 * Other bits are currently reserved.
> +	 */
> +	sd->domain = pci_bus_find_emul_domain_nr(0, 0x10000, INT_MAX);
> +	if (sd->domain < 0)
> +		return sd->domain;
> +
> +	sd->node = pcibus_to_node(vmd->dev->bus);
> +
>  	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
>  				       &vmd_ops, sd, &resources);
>  	if (!vmd->bus) {
> +		pci_bus_release_emul_domain_nr(sd->domain);
>  		pci_free_resource_list(&resources);
>  		vmd_remove_irq_domain(vmd);
>  		return -ENODEV;
> @@ -1005,6 +997,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  		return -ENOMEM;
>  
>  	vmd->dev = dev;
> +	vmd->sysdata.domain = PCI_DOMAIN_NR_NOT_SET;
>  	vmd->instance = ida_alloc(&vmd_instance_ida, GFP_KERNEL);
>  	if (vmd->instance < 0)
>  		return vmd->instance;
> @@ -1070,6 +1063,7 @@ static void vmd_remove(struct pci_dev *dev)
>  	vmd_detach_resources(vmd);
>  	vmd_remove_irq_domain(vmd);
>  	ida_free(&vmd_instance_ida, vmd->instance);
> +	pci_bus_release_emul_domain_nr(vmd->sysdata.domain);
>  }
>  
>  static void vmd_shutdown(struct pci_dev *dev)


