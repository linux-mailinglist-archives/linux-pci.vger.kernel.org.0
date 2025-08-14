Return-Path: <linux-pci+bounces-34070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AF9B2703A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 22:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B72F1C85535
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 20:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ABF262FD8;
	Thu, 14 Aug 2025 20:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzRPpHCc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8A223D2B1;
	Thu, 14 Aug 2025 20:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755203774; cv=none; b=lDZqAZgeeYRQvjqGjtwA9LguBhceYX6dluHSoSuJNwRDKJXRsiiB/l+4vJpBn92Y8LK2nJkySL88NEjVs2tSnrFZr0FQeZfLdIq+vK2nsZbTgwBhWe9AmcGmCNJwPTYdvdAr4i5CmkQYy4O1/J8VOITP9Nie24kHQJjeca852/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755203774; c=relaxed/simple;
	bh=9wiK8c6N+Dkrf3xCToSd4vuPjuP5RWsB/pt0fzN5T3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TYQT4CE5ikhYtcCmziidJSKkgvhLMNNPq5Igvg5AGSYrmKu7//hI3Tqqw93UCT+UZWQqRWrl92FqgqpJE0mhW4Hb82QgChyp4YYMlC/nDm11Ilxri7WMQ4iVmEGQhLuMeVA1Uc/Sw2Jl7miF3NPYvM8NVdq4Gsi7X+3vtYaBhZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzRPpHCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9FBC4CEEF;
	Thu, 14 Aug 2025 20:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755203774;
	bh=9wiK8c6N+Dkrf3xCToSd4vuPjuP5RWsB/pt0fzN5T3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RzRPpHCcVi+BRqk5X/8b70yj3cmOEN7laBFyyrxHsuYb4ZfTEuPfLpzy/7LZv4ary
	 r1UEGXdgPonZyovkcG+TfiWGomM3yUVgJ9XZzNRK8QtKES0wYVFT//XidFOk01kt6f
	 mpgoiuptvw7Aqzp/cFgqzZdF8NjXhjMgREhy0znrY0Qz9RHqx1RnT69mpaFbwFVJME
	 SumcPZJiv50UU6mjr5rGRtGwhkASnWwJCtjS1zmFcHvZ6RXobi2RevHQRXEG8IYifv
	 2AZtc3gReLqa4863mSP6le6b95qgi07JiR3wo6wMIKT21v6j4S9c4fE5u/asnTlRVo
	 VcHdCxw0hsMjA==
Date: Thu, 14 Aug 2025 15:36:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rui He <rui.he@windriver.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Prashant.Chikhalkar@windriver.com,
	Jiguang.Xiao@windriver.com
Subject: Re: [PATCH 1/1] pci: Add subordinate check before pci_add_new_bus()
Message-ID: <20250814203612.GA346111@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814093937.2372441-1-rui.he@windriver.com>

On Thu, Aug 14, 2025 at 05:39:37PM +0800, Rui He wrote:
> For preconfigured PCI bridge, child bus created on the first scan.
> While for some reasons(e.g register mutation), the secondary, and subordiante
> register reset to 0 on the second scan, which caused to create
> PCI bus twice for the same PCI device.

I don't quite follow this.  Do you mean something is changing the
bridge configuration between the first and second scans?

> Following is the related log:
> [Wed May 28 20:38:36 CST 2025] pci 0000:0b:01.0: PCI bridge to [bus 0d]
> [Wed May 28 20:38:36 CST 2025] pci 0000:0b:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [Wed May 28 20:38:36 CST 2025] pci 0000:0b:01.0: PCI bridge to [bus 0e-10]
> [Wed May 28 20:38:36 CST 2025] pci 0000:0b:05.0: PCI bridge to [bus 0f-10]

Drop the timestamps (since they don't contribute to understanding the
problem) and indent the logs a couple spaces.

> Here PCI device 000:0b:01.0 assigend to bus 0d and 0e.

It looks like the [bus 0f-10] range is assigned to both bridges
(0b:01.0 and 0b:05.0), which would definitely be a problem.

I'm surprised that we haven't tripped over this before, and I'm
curious about how we got here.  Can you set CONFIG_DYNAMIC_DEBUG=y,
boot with the dyndbg="file drivers/pci/* +p" kernel parameter, and
collect the complete dmesg log?

> This patch checks if child PCI bus has been created on the second scan
> of bridge. If yes, return directly instead of create a new one.
> 
> Signed-off-by: Rui He <rui.he@windriver.com>
> ---
>  drivers/pci/probe.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index f41128f91ca76..ec67adbf31738 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1444,6 +1444,9 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  			goto out;
>  		}
>  
> +		if(pci_has_subordinate(dev))
> +			goto out;

Follow the coding style, i.e., add a space in "if (pci_..."

>  		/* Clear errors */
>  		pci_write_config_word(dev, PCI_STATUS, 0xffff);
>  
> -- 
> 2.43.0
> 

