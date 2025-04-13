Return-Path: <linux-pci+bounces-25723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 944A5A870CF
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 07:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C976A189CE4B
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 05:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AA42F32;
	Sun, 13 Apr 2025 05:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWin0gDl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6530E7F9;
	Sun, 13 Apr 2025 05:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744521428; cv=none; b=VUkrGlh9GAGkrnTUuOAr2JcO7s79667JMzDAx90t2O+ojlk5ypJ0zJMlfCyd4oSASicfm07FMXVfgScPamssQuZ10Sr/8QHPb6oZ+L1IMB0vA+8EM2OXRI4ramfStJzC2WS1SrdqC1JhOWWs6PTstU0YCdcjkZfL3N36n36caJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744521428; c=relaxed/simple;
	bh=6WxhdAa4Khq/pSDhvYx8X8rPtS6/4ePYLlsJwwNawMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxjK8Uk7hACL0dJ8463iNIQW5+/9hfTGOE7oz1SCFDC1TBkgFw/1QXag2J8abgG6a3AGAaPqHhrBJmzOaSZcRuAQxZ/Y6lwiGGecJl0F/JVAz34mP/1Ous2tSMynHULf4GQcgAiLSdM2dCBTWBq+3HUi1ms6d90Mk+mJ5/WB1MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWin0gDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69163C4CEDD;
	Sun, 13 Apr 2025 05:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744521427;
	bh=6WxhdAa4Khq/pSDhvYx8X8rPtS6/4ePYLlsJwwNawMY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GWin0gDlSipVQxpj/xtX5CCYDqrSdKu2FNnuHgZ63ECmzF3odgUHVYcGnzrDyuWZg
	 dr8Ml8EE/QfLk53OvPLSERLbrbsGpatFcUeoZD/S+Pqctg5mLgOknzHUt9z6V3mTXT
	 AyRCBwzpbkoBpp2WGprmXy8kylDGIIw+J1Dz0moGD4u+ct4ImS5D52+y0AlOipg4IH
	 WjxVvHJOV+cKE9jk4KJalvu3mlL5CGu74ARM2qexq978ErwDB4kG7QoaWZ3k7IlTsw
	 tDQsfYaGETuQZnupaR8xKTRb90OBM7wWx4SYvfKJE+jhOOwTL9j9JgwDRkuJd9RVrU
	 OTBfdjBZ7Jpig==
Message-ID: <f56d8794-07a1-4040-8743-0599fb488dba@kernel.org>
Date: Sun, 13 Apr 2025 14:17:05 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: fix the printed delay amount in info print
To: Wilfred Mallawa <wilfred.opensource@gmail.com>, bhelgaas@google.com,
 mika.westerberg@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 lukas@wunner.de
Cc: alistair.francis@wdc.com, wilfred.mallawa@wdc.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, cassel@kernel.org
References: <20250412060934.41074-2-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250412060934.41074-2-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/25 15:09, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Print the delay amount that pcie_wait_for_link_delay() is invoked with
> instead of the hardcoded 1000ms value in the debug info print.
> 
> Fixes: 7b3ba09febf4 ("PCI/PM: Shorten pci_bridge_wait_for_secondary_bus() wait
> time for slow links")
> 

Please remove the blank line here and do not wrap the Fixes tag line.
With that fixed, looks OK to me. So feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..8139b70cafa9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4935,7 +4935,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  		delay);
>  	if (!pcie_wait_for_link_delay(dev, true, delay)) {
>  		/* Did not train, no need to wait any further */
> -		pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
> +		pci_info(dev, "Data Link Layer Link Active not set in %d msec\n", delay);
>  		return -ENOTTY;
>  	}
>  


-- 
Damien Le Moal
Western Digital Research

