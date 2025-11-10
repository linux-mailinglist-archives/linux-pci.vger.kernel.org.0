Return-Path: <linux-pci+bounces-40667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1D3C44E74
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 05:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390B7188CE40
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 04:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AC641C63;
	Mon, 10 Nov 2025 04:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UGpOJCIW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D65720468E
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 04:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762749042; cv=none; b=aCqheHOcvNhqAmdtX3HDLaDDpfbt1+IyrABxkR20Gqqaz8WXsj+y9wZSmWixugCcF8Nrw6aQdVCLKJBH6n3JDMeeg2j3sj4UmH9D/EjUqrHzOdrR+P5oQJEWGIEZ06Anv/MzapAe9le5eGsHbPhzNLR5wZ6NWBSRp2VmkvIFNTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762749042; c=relaxed/simple;
	bh=/MaK8XJpPj9MvaeY04XRTBctbl3/A0aTY2hauY/Dgw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzoQd1tplNdz9heafwsOTGc5bwL3ORKlU8W02opqfn1/dxjQ3Wz9SU2RB9NDcmD4Vgc7vMnb3ycVsqxtpJ0N1KYXAyR9faBG5mkEbOKym7PprvKFt5w4d8vkDP75bemrcmSOO45eqphzWOXV/ijCsFiJhU6cA1ALBAWhtRqmZbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UGpOJCIW; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762749041; x=1794285041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/MaK8XJpPj9MvaeY04XRTBctbl3/A0aTY2hauY/Dgw4=;
  b=UGpOJCIWqsgiZU0a7T0NkjtTJV6Pk3lK2shSxTBX/4/eZhAsfBCq/IkW
   /QB1raN9IiGGxT+yucHJkxReWGhDjMMsUWDTZiqyqBYPCXMSTMQn8NDZe
   JvHXUgr+gIWFA3DseTK0VsnYi5QTE4bLiBxuXTCV0a1rXTiDcx+iOEAtO
   Xt/lXmta1VlmWLLEkrWtdGlZA5+JRoG8pfoDDeswUWX2CtpmgXcCOaKjw
   tz/xjczioUpTBJnHYYX2CxvIIhUFZdQ+nurCovkGKfXhR8GHEit7DxmF/
   C7Q8rykmxyUndluZGijBtRcNgrCnTKXMqsVW5GcPrdl0ZglSIs7V8vOQl
   g==;
X-CSE-ConnectionGUID: PR9fxh5wQP+odMSDbC7fLg==
X-CSE-MsgGUID: jnv8RCpTSW+Izpm4kPVelw==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64707625"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="64707625"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 20:30:40 -0800
X-CSE-ConnectionGUID: phv2LWDmT3msgRtTHfJFRw==
X-CSE-MsgGUID: y13hwxISRsWhn3w+6x6PRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="225829214"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 09 Nov 2025 20:30:38 -0800
Date: Mon, 10 Nov 2025 12:16:16 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-pci@vger.kernel.org, linux-coco@lists.linux.dev,
	gregkh@linuxfoundation.org, aik@amd.com, aneesh.kumar@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>
Subject: Re: [PATCH v8 7/9] PCI/IDE: Add IDE establishment helpers
Message-ID: <aRFnEMYe9yCic5a3@yilunxu-OptiPlex-7050>
References: <20251031212902.2256310-1-dan.j.williams@intel.com>
 <20251031212902.2256310-8-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031212902.2256310-8-dan.j.williams@intel.com>

> +{
> +	if (!pci_is_pcie(pdev)) {
> +		pci_warn_once(pdev, "not a PCIe device\n");
> +		return NULL;
> +	}
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ENDPOINT:
> +		if (pdev != ide->pdev) {
> +			pci_warn_once(pdev, "setup expected Endpoint: %s\n", pci_name(ide->pdev));
> +			return NULL;
> +		}
> +		return &ide->partner[PCI_IDE_EP];
> +	case PCI_EXP_TYPE_ROOT_PORT: {

No need the braces

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>

> +		struct pci_dev *rp = pcie_find_root_port(ide->pdev);
> +
> +		if (pdev != rp) {
> +			pci_warn_once(pdev, "setup expected Root Port: %s\n",
> +				      pci_name(rp));
> +			return NULL;
> +		}
> +		return &ide->partner[PCI_IDE_RP];
> +	}
> +	default:
> +		pci_warn_once(pdev, "invalid device type\n");
> +		return NULL;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_to_settings);

