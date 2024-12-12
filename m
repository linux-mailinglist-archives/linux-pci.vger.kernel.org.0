Return-Path: <linux-pci+bounces-18257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E8A9EE485
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 11:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBBEF164539
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 10:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2246D21129A;
	Thu, 12 Dec 2024 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XpXBYVMj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D241F2381
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000854; cv=none; b=m0+8LhcWKHcFPWBhq4n2kqg1ofcA1JO3Xe8Jk2J5KMfG3b8Zf7FiqTPUtG5ZIWahVlt+FUyrkxJX335VZZRcavAFHGKjwug8umeOaoYmAjHGpW8kwzKydARmD5L1n64fJr8ddK6g1CooEWWehc+ej6AZx8o1NyWSQ9mV+QPTZ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000854; c=relaxed/simple;
	bh=MOlQQdO5lK3U572ldkpTBbrDmAKTbjY10M2pA09lNNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7al9qFCaJVLWdmJfka1FOfwbFNQFkO1+G7zqMYME+OnX3gt5oLqhFgtLCdP/qk5poSbgxMfc2iMjTkgOXJjo9/w5MuqyOkv5yrNEHAQWzQNWVBoDDOU5rripy4FrJSj4AB/ds0UuM6ELdxXMgKAlzuRuTVNXUEihoMjIZ13hjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XpXBYVMj; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734000853; x=1765536853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MOlQQdO5lK3U572ldkpTBbrDmAKTbjY10M2pA09lNNg=;
  b=XpXBYVMjMwI7u/Ep1QMtoVP4hiTzpydLKJq0fEB0oOx2o6hQTH9xyZF8
   /ZFWYh+HPK7AhO/Upqx4SHf43netBAacNOb/4AHTXd0zV4EDcplknXs1f
   a6qRYtCozzl6hpDqohzlKl8joiOtuhPB/hcZzzJROX+9S4HKftGSlotBs
   itTpevrbWTgSWcKMf6wTnAQTbICCGPZFqv+I4quFLSl2qnEVwbju67AxA
   xsylh7LuYIjyEOjaEfAPQeMJ+boOhCiu3+3vJGCqDFPj4nqgPonzwC/Ex
   gx0cxxzqElkinSxkTdZh+F6uH73nTaP1xd/N6wUZtZG1zKXIc9EfqmYJy
   A==;
X-CSE-ConnectionGUID: ZF/Z5uxpSZK5AlMXVcVuRg==
X-CSE-MsgGUID: a7aQFFE7R2SNDLuR3SearQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34457134"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="34457134"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 02:54:12 -0800
X-CSE-ConnectionGUID: tQTjDtP0TNeQQ72BIFVR6A==
X-CSE-MsgGUID: DEbwxkEuR0ObeawGhvzQ+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119439918"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 12 Dec 2024 02:54:10 -0800
Date: Thu, 12 Dec 2024 18:50:52 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <Z1rADLJV8tbI9adp@yilunxu-OptiPlex-7050>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>

> +static void __pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	int pos;
> +	u32 val;
> +
> +	pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
> +			     pdev->nr_ide_mem);
> +
> +	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT_MASK, ide->devid_end);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
> +
> +	val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
> +	      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE_MASK, ide->devid_start) |
> +	      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG_MASK, ide->domain);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
> +
> +	for (int i = 0; i < ide->nr_mem; i++) {
> +		val = FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |
> +		      FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK,
> +				 lower_32_bits(ide->mem[i].start) >>
> +					 PCI_IDE_SEL_ADDR_1_BASE_LOW_SHIFT) |
> +		      FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK,
> +				 lower_32_bits(ide->mem[i].end) >>
> +					 PCI_IDE_SEL_ADDR_1_LIMIT_LOW_SHIFT);

Oh, I missunderstood the _LOW_SHIFT Macros. But still think if they
could be moved out of pci_reg.h. Placing in pci_reg.h makes me think
they are some register field offsets.

Thanks,
Yilun

