Return-Path: <linux-pci+bounces-19806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87169A1161E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 01:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0803163CD6
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 00:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1783C0B;
	Wed, 15 Jan 2025 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ASx/nabi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CED28EA;
	Wed, 15 Jan 2025 00:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736901309; cv=none; b=d8yyJRs2Ptmcp9VMbr2XHY25xEsiWo7+aKGj5LvWi9gKl33W40B7PSj/Ai6mkwcBxXDC1DEKdX9kMti3hToXr7IvEl2/LRoBORg8RReEuWqPu1A97eUS9fe/OzRHl+b91EGw/45wE1vKzdP8kesupdf3NjuaYoqB+HdEHJmJslY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736901309; c=relaxed/simple;
	bh=ECO4qpmSJlE9ZrIdPgBqlilqz53/5XbOeu+M+cXzv1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9hWs97srAoTYg0NMO+qdb7vx7klW0zPzqjU96TkBaOroA9iyjUT4IZbDQuXmrXOp8vPdGz2+Bp4QUrgGVeBync8+8bo7btpDr7cuOMntMnldeIrxZdm8o5DzSOrnWoL6Gn9uRIzGtA3vW8twSSBhi1nu46eUYms/CLI8+uKqpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ASx/nabi; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736901308; x=1768437308;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ECO4qpmSJlE9ZrIdPgBqlilqz53/5XbOeu+M+cXzv1U=;
  b=ASx/nabivxSHi4HaGljH2lyCFHHZM452oG+L4m7rVV13RiozyhWdBlrH
   YOHkPEvUQx8gDTmdNxhXBzQ273ej9njjB7VTfVGww6VCYwVI7PeRc7/pO
   l5ovXNn0gkyJtKjORvXbF8rZdunFjT2D9Jdx1x6BMKyI7X/s2nVn/NmaT
   1EzwbqOii6ePqselEGcB8KNNS/TphRujoVTb2UULQstWT1T3lgTrh6tZo
   MyfA2LBFqF/TIs7uDnBMWXxsolElGmXAydbTxwpKEmwd7njmIi2hP7wY7
   ntcySWuUIlE1g4qDIzMcBF6l/ukSMx9ogibnzEbCfiulLOhXYNpIzKY8t
   w==;
X-CSE-ConnectionGUID: tFDpimVDTtqWZsFLhod/Eg==
X-CSE-MsgGUID: CQnXU2b0RiGlor7zZalRqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37334013"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37334013"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 16:35:06 -0800
X-CSE-ConnectionGUID: EnQHlOvaSsOCLSUlC+NqkA==
X-CSE-MsgGUID: q69ZtDVeRYqYC4sL1IuFQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="105503957"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.124.220.21]) ([10.124.220.21])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 16:34:43 -0800
Message-ID: <fe7fa357-aca2-4f10-89cd-a435a591a6ed@linux.intel.com>
Date: Tue, 14 Jan 2025 16:34:44 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] sparc/PCI: Update reference to
 devm_of_pci_get_host_bridge_resources()
To: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20250113231557.441289-1-helgaas@kernel.org>
 <20250113231557.441289-5-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250113231557.441289-5-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/13/25 3:15 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> 5bd51b35c7cb ("PCI: Rework of_pci_get_host_bridge_resources() to
> devm_of_pci_get_host_bridge_resources()") converted and renamed
> of_pci_get_host_bridge_resources().  Update the comment reference to match.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: Andreas Larsson <andreas@gaisler.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

>   arch/sparc/kernel/pci_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
> index 5eeec9ad6845..2576f4f31309 100644
> --- a/arch/sparc/kernel/pci_common.c
> +++ b/arch/sparc/kernel/pci_common.c
> @@ -361,7 +361,7 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
>   	int i, saw_mem, saw_io;
>   	int num_pbm_ranges;
>   
> -	/* Corresponding generic code in of_pci_get_host_bridge_resources() */
> +	/* Corresponds to generic devm_of_pci_get_host_bridge_resources() */
>   
>   	saw_mem = saw_io = 0;
>   	pbm_ranges = of_get_property(pbm->op->dev.of_node, "ranges", &i);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


