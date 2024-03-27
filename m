Return-Path: <linux-pci+bounces-5299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1124288F14C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 22:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F641C30CB3
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 21:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A47153517;
	Wed, 27 Mar 2024 21:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bE51qHG8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD5E383A3;
	Wed, 27 Mar 2024 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711576177; cv=none; b=WpB4hHJeRf2xAQoKKJ/CFDg0CskyaShBu8Du/em/TTwDJWCPuNxco6hLYAYp/sjfADeEAgqnCE5sf6jpo6K3P5GXdJI1qYgjrK4apEAbQ/QYoXkUpgiDhDiSF/lZ+MEVnWOG/3js1HRn8yRdUOAeK72x4HMkUf6B1ager2JszK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711576177; c=relaxed/simple;
	bh=LOgu3IfNSw65kfZ80SNmRsH5J4Pyw4aaraDAKAOZHBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VA6wcvJ8sBjp6vEEDslkk5oMl3lmAUvBjFAYX1xKz8oAupWBYj6mNV12BMR8Ye+7vq9bfFWx29MMOmJlG1NN5Kb24Eb4Oz0lKdERRUUvBR4Rk8HLFGlB9qbxNGKj4SHOQ5g8Q3DMWA1RpKVEIHsnGJkWLSYeJuxPNVwnvOI7MNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bE51qHG8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711576176; x=1743112176;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LOgu3IfNSw65kfZ80SNmRsH5J4Pyw4aaraDAKAOZHBU=;
  b=bE51qHG8p/eoNTkCpPmjEK1Xa6OfTJQnIpx09OS6PkLAitKIxnMl+nWJ
   tU0Lt9eBdv4+wyI+fGtObc7wlHrEHHvqPoYd0d+rtUcAOCGPL+409ot8i
   Gi8sDzmQ1dJipGgHCMwUYgRwb1DDyCKE4TlXIgLMkyj5TrHcrmLv90Ec2
   OAh2bvRTjOTvxzBYJVV2z6ayI1SW/hQpBhnn18BcpuJKRRMC6OETYSbvh
   cW/94/PTGHMV029IeWiGnhjtwf7mt1TIDpbupB05aIlvk//SKAWg4VTvb
   02RBTFqsJBkIZyThctxC+Za2nCRARrUMuGOYystTBjoQyWXChIVksTyeo
   Q==;
X-CSE-ConnectionGUID: WxpdyhK+Rq2tv13bI7/5Eg==
X-CSE-MsgGUID: VOR+D0T8SnSM5UypCTGvqQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6570081"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6570081"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 14:49:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="16454185"
Received: from soralee-mobl1.amr.corp.intel.com (HELO [10.255.228.178]) ([10.255.228.178])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 14:49:34 -0700
Message-ID: <a144b96b-6ec4-4a62-b2ab-1ed631d81544@linux.intel.com>
Date: Wed, 27 Mar 2024 14:49:34 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Update pci_find_capability() stub return values
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20240327180234.1529164-1-helgaas@kernel.org>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240327180234.1529164-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/27/24 11:02 AM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> f646c2a0a668 ("PCI: Return u8 from pci_find_capability() and similar") and
> ee8b1c478a9f ("PCI: Return u16 from pci_find_ext_capability() and similar")
> updated the return type of the extern declarations, but neglected to update
> the type of the stubs used CONFIG_PCI is not enabled.
>
> Update them to match the extern declarations.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

This change looks fine to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

But the callers of these functions still seems to use int declaration to store
the output. Any reason for not changing them? Like the usages in
drivers/pci/pci.c?

>  include/linux/pci.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b19992a5dfaf..6a09bd9636d5 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2011,10 +2011,9 @@ static inline int pci_register_driver(struct pci_driver *drv)
>  static inline void pci_unregister_driver(struct pci_driver *drv) { }
>  static inline u8 pci_find_capability(struct pci_dev *dev, int cap)
>  { return 0; }
> -static inline int pci_find_next_capability(struct pci_dev *dev, u8 post,
> -					   int cap)
> +static inline u8 pci_find_next_capability(struct pci_dev *dev, u8 post, int cap)
>  { return 0; }
> -static inline int pci_find_ext_capability(struct pci_dev *dev, int cap)
> +static inline u16 pci_find_ext_capability(struct pci_dev *dev, int cap)
>  { return 0; }
>  
>  static inline u64 pci_get_dsn(struct pci_dev *dev)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


