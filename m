Return-Path: <linux-pci+bounces-22043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D41AA40297
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 23:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180171882F82
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 22:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DB5204F70;
	Fri, 21 Feb 2025 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqh1IjkR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE17D2046B9;
	Fri, 21 Feb 2025 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740176615; cv=none; b=ig2GPo+O/8MbZPZOWxyF17JVKG/YTfaruQCqUB/DSb8L8VngP6LvK2zLhhD6lGhrk5gcGyFnO6B8wn98igtOQrk2rgwwDrNykk+LO2h8jr0PVZpmSWFqjUc9jizijY8vOYEEc4O+/fqHG7Pi9L/BJVzv8RJjA6vkS58i1YA7CvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740176615; c=relaxed/simple;
	bh=ydTbxNnzF9NHjhJuiLRmY8kGI9DwJQg51taLMTOt+pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fZ5cGSPn/hMp4673aKf4oEfSJqGSWQJjGMVH58Pim0MWlVNDm1EYtLCR2gVhY25A/akv+69oHT1WTWKoDdob8o8m9cz6vpgQQYGx7ZUVaBUn8u2G2G8k9Ve8B273NDQOkijykiUiv5vmhJNxGGa1V7t4jqjArnSR1eEuvCvhJB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqh1IjkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA53C4CED6;
	Fri, 21 Feb 2025 22:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740176615;
	bh=ydTbxNnzF9NHjhJuiLRmY8kGI9DwJQg51taLMTOt+pQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nqh1IjkR1NMlmWGZV2dvFo8IaKW5UyNM6oJS8o1MsjauOfDwF8we2+QdpY9fUicfY
	 u4fSgE6eXF57pCpG0akZqQS5paxmuhT4WiYOPOpoJ1hoXmp13eToShcTb4sNkXAFSk
	 kpji1yFMSNh1VuCw4BbJHhtbUBM+G7jx35npItdEfQ55dSTJrq/KAh4HoUh/mrR9ep
	 SQIKvhWP04coRSd+2YXAK9fCd6IaBImT9vV/3eHPPabfw2kblC2c8qEU/MzNI5HB5O
	 4GGNGFwTwENoxoDL21AkjpciFJCLvt5dQSQ9jMmef9O8A6G1Mw67v5ySXQ+XlvXx/U
	 fZI7QKhBd9Jvg==
Date: Fri, 21 Feb 2025 16:23:33 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tushar Dave <tdave@nvidia.com>
Cc: jgg@nvidia.com, corbet@lwn.net, bhelgaas@google.com, paulmck@kernel.org,
	akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
	xiongwei.song@windriver.com, vidyas@nvidia.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com,
	sdonthineni@nvidia.com
Subject: Re: [RESEND PATCH v2] PCI: Fix Extend ACS configurability
Message-ID: <20250221222333.GA368134@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207030338.456887-1-tdave@nvidia.com>

On Thu, Feb 06, 2025 at 07:03:38PM -0800, Tushar Dave wrote:
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

Applied to pci/acs for v6.15, thanks!

> ---
> 
> changes in v2:
>  - Addressed review comments by Jason and Bjorn.
>  - Removed Documentation changes (already taken care by other patch).
>  - Amended commit description.
> 
>  drivers/pci/pci.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..c1ab5d50112d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -954,8 +954,10 @@ struct pci_acs {
>  };
>  
>  static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
> -			     const char *p, u16 mask, u16 flags)
> +			     const char *p, const u16 acs_mask, const u16 acs_flags)
>  {
> +	u16 flags = acs_flags;
> +	u16 mask = acs_mask;
>  	char *delimit;
>  	int ret = 0;
>  
> @@ -963,7 +965,7 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>  		return;
>  
>  	while (*p) {
> -		if (!mask) {
> +		if (!acs_mask) {
>  			/* Check for ACS flags */
>  			delimit = strstr(p, "@");
>  			if (delimit) {
> @@ -971,6 +973,8 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>  				u32 shift = 0;
>  
>  				end = delimit - p - 1;
> +				mask = 0;
> +				flags = 0;
>  
>  				while (end > -1) {
>  					if (*(p + end) == '0') {
> @@ -1027,10 +1031,13 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>  
>  	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
>  	pci_dbg(dev, "ACS flags = %#06x\n", flags);
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
>  	pci_info(dev, "Configured ACS to %#06x\n", caps->ctrl);
>  }
> -- 
> 2.34.1
> 

