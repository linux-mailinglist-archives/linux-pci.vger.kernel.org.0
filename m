Return-Path: <linux-pci+bounces-20307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5D5A1ACA1
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 23:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D1CD7A19A3
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 22:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871F01CF5F2;
	Thu, 23 Jan 2025 22:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JAxbiRPT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EF21B0F2F;
	Thu, 23 Jan 2025 22:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737671113; cv=none; b=DGhE8nKQ6TU+D2HiC6K1KUEaOrVOIytX60nYmpwqu92FOzaceAdd2GVqjwlJl6EwbM5QBp8hTJeKz0IrJbLZxlEf6HBlzbom9EVaVJH8aMyesE+lUWMTH/um0Eqq391ogUrUmE/ooKDs+pw66XSvg19ZmiAJu8EsLDvGg9M3sYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737671113; c=relaxed/simple;
	bh=2jb7XVwyxsYRUqUbjVpdYJ8DEJERMyMgxxHC3BUJAgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atZoAV2WJrvyKZoH7SnTK7s6JGVBcdFrtSbjAPObDlmdXnIkTJs2IRpQExbrVUONVgU98iOOhjN1hWsiK54zfFseIejRtx0mQhb27xnqEtZ3uWQ10A0t8kI646/6A/TuL5gnqESJcS5xYCI3N1dX46EOEpWUV97jnDlC2e60gFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JAxbiRPT; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737671111; x=1769207111;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2jb7XVwyxsYRUqUbjVpdYJ8DEJERMyMgxxHC3BUJAgI=;
  b=JAxbiRPT3772D9G0l5Imfbofq0IKfSvD+lXnTpJreMjKSCfqWpAOBHCh
   b8sq4eTMC5HFrnWBy6CI1YZsCc2K0rBo+GECkE8eneW35HpFpnLsIXpb5
   juq6y4eZAj//CfCpQKtuYCWXJhC8b2O5BNC10wQDMgudsDC7PL8PBKLd5
   RyOukX7TsOb/csEUOfP9l7DboSvnXCUZPx4Ivn9gl2AX//YRR86cGw0mP
   KkkpL9+YRHfvsHYC0q+fgKR3YPoznriC+BlTdfgNUb48FNZFZ6RFQc/pP
   MCfNkmtRKBZqn9HXIyGEfGmgSPxcGDrdx+TtoEXwUJ0GOTvVYFSX3eARr
   w==;
X-CSE-ConnectionGUID: Ts/Oziz2SbKMCl5NEl5JXg==
X-CSE-MsgGUID: eZT7cursR/qDooBfaGGgbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="38227048"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="38227048"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 14:25:11 -0800
X-CSE-ConnectionGUID: AY6H+YdiQ5i6gkVhSE0x/g==
X-CSE-MsgGUID: MUuxFnpBSYSX25N0YEIOfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138464018"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.124.223.78]) ([10.124.223.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 14:25:10 -0800
Message-ID: <98e3eda7-4d8c-46af-b8ae-9bdcdce33608@linux.intel.com>
Date: Thu, 23 Jan 2025 14:24:52 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Fix Extend ACS configurability
To: Tushar Dave <tdave@nvidia.com>, jgg@nvidia.com, corbet@lwn.net,
 bhelgaas@google.com, paulmck@kernel.org, akpm@linux-foundation.org,
 thuth@redhat.com, rostedt@goodmis.org, xiongwei.song@windriver.com,
 vidyas@nvidia.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: vsethi@nvidia.com, sdonthineni@nvidia.com
References: <20250123033716.112115-1-tdave@nvidia.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250123033716.112115-1-tdave@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 1/22/25 7:37 PM, Tushar Dave wrote:
> Commit 47c8846a49ba ("PCI: Extend ACS configurability") introduced
> bugs that fail to configure ACS ctrl to the value specified by the
> kernel parameter. Essentially there are two bugs.
>
> First, when ACS is configured for multiple PCI devices using
> 'config_acs' kernel parameter, it results into error "PCI: Can't parse
> ACS command line parameter". This is due to the bug in code that doesn't
> preserve the ACS mask instead overwrites the mask with value 0.
>
> For example, using 'config_acs' to configure ACS ctrl for multiple BDFs
> fails:
>
> 	Kernel command line: pci=config_acs=1111011@0020:02:00.0;101xxxx@0039:00:00.0 "dyndbg=file drivers/pci/pci.c +p"
> 	PCI: Can't parse ACS command line parameter
> 	pci 0020:02:00.0: ACS mask  = 0x007f
> 	pci 0020:02:00.0: ACS flags = 0x007b
> 	pci 0020:02:00.0: Configured ACS to 0x007b
>
> After this fix:
>
> 	Kernel command line: pci=config_acs=1111011@0020:02:00.0;101xxxx@0039:00:00.0 "dyndbg=file drivers/pci/pci.c +p"
> 	pci 0020:02:00.0: ACS mask  = 0x007f
> 	pci 0020:02:00.0: ACS flags = 0x007b
> 	pci 0020:02:00.0: ACS control = 0x005f
> 	pci 0020:02:00.0: ACS fw_ctrl = 0x0053
> 	pci 0020:02:00.0: Configured ACS to 0x007b
> 	pci 0039:00:00.0: ACS mask  = 0x0070
> 	pci 0039:00:00.0: ACS flags = 0x0050
> 	pci 0039:00:00.0: ACS control = 0x001d
> 	pci 0039:00:00.0: ACS fw_ctrl = 0x0000
> 	pci 0039:00:00.0: Configured ACS to 0x0050
>
> Second bug is in the bit manipulation logic where we copy the bit from
> the firmware settings when mask bit 0.
>
> For example, 'disable_acs_redir' fails to clear all three ACS P2P redir
> bits due to the wrong bit fiddling:
>
> 	Kernel command line: pci=disable_acs_redir=0020:02:00.0;0030:02:00.0;0039:00:00.0 "dyndbg=file drivers/pci/pci.c +p"
> 	pci 0020:02:00.0: ACS mask  = 0x002c
> 	pci 0020:02:00.0: ACS flags = 0xffd3
> 	pci 0020:02:00.0: Configured ACS to 0xfffb
> 	pci 0030:02:00.0: ACS mask  = 0x002c
> 	pci 0030:02:00.0: ACS flags = 0xffd3
> 	pci 0030:02:00.0: Configured ACS to 0xffdf
> 	pci 0039:00:00.0: ACS mask  = 0x002c
> 	pci 0039:00:00.0: ACS flags = 0xffd3
> 	pci 0039:00:00.0: Configured ACS to 0xffd3
>
> After this fix:
>
> 	Kernel command line: pci=disable_acs_redir=0020:02:00.0;0030:02:00.0;0039:00:00.0 "dyndbg=file drivers/pci/pci.c +p"
> 	pci 0020:02:00.0: ACS mask  = 0x002c
> 	pci 0020:02:00.0: ACS flags = 0xffd3
> 	pci 0020:02:00.0: ACS control = 0x007f
> 	pci 0020:02:00.0: ACS fw_ctrl = 0x007b
> 	pci 0020:02:00.0: Configured ACS to 0x0053
> 	pci 0030:02:00.0: ACS mask  = 0x002c
> 	pci 0030:02:00.0: ACS flags = 0xffd3
> 	pci 0030:02:00.0: ACS control = 0x005f
> 	pci 0030:02:00.0: ACS fw_ctrl = 0x005f
> 	pci 0030:02:00.0: Configured ACS to 0x0053
> 	pci 0039:00:00.0: ACS mask  = 0x002c
> 	pci 0039:00:00.0: ACS flags = 0xffd3
> 	pci 0039:00:00.0: ACS control = 0x001d
> 	pci 0039:00:00.0: ACS fw_ctrl = 0x0000
> 	pci 0039:00:00.0: Configured ACS to 0x0000
>
> Fixes: 47c8846a49ba ("PCI: Extend ACS configurability")
> Signed-off-by: Tushar Dave <tdave@nvidia.com>
> ---

LGTM

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
> changes in v2:
>   - Addressed review comments by Jason and Bjorn.
>   - Removed Documentation changes (already taken care by other patch).
>   - Amended commit description.
>
>   drivers/pci/pci.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 0b29ec6e8e5e..19fbdd8643bc 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -955,8 +955,10 @@ struct pci_acs {
>   };
>   
>   static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
> -			     const char *p, u16 mask, u16 flags)
> +			     const char *p, const u16 acs_mask, const u16 acs_flags)
>   {
> +	u16 flags = acs_flags;
> +	u16 mask = acs_mask;
>   	char *delimit;
>   	int ret = 0;
>   
> @@ -964,7 +966,7 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>   		return;
>   
>   	while (*p) {
> -		if (!mask) {
> +		if (!acs_mask) {
>   			/* Check for ACS flags */
>   			delimit = strstr(p, "@");
>   			if (delimit) {
> @@ -972,6 +974,8 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>   				u32 shift = 0;
>   
>   				end = delimit - p - 1;
> +				mask = 0;
> +				flags = 0;
>   
>   				while (end > -1) {
>   					if (*(p + end) == '0') {
> @@ -1028,10 +1032,13 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>   
>   	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
>   	pci_dbg(dev, "ACS flags = %#06x\n", flags);
> +	pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
> +	pci_dbg(dev, "ACS fw_ctrl = %#06x\n", caps->fw_ctrl);
>   
> -	/* If mask is 0 then we copy the bit from the firmware setting. */
> -	caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
> -	caps->ctrl |= flags;
> +	/* For mask bits that are 0 copy them from the firmware setting
> +	 * and apply flags for all the mask bits that are 1.
> +	 */
> +	caps->ctrl = (caps->fw_ctrl & ~mask) | (flags & mask);
>   
>   	pci_info(dev, "Configured ACS to %#06x\n", caps->ctrl);
>   }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


