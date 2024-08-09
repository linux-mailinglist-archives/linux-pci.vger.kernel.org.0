Return-Path: <linux-pci+bounces-11530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E0594CF42
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 13:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1951C20F47
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 11:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60EA1591F3;
	Fri,  9 Aug 2024 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LxOw2go+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZVJmJnqj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LxOw2go+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZVJmJnqj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A4110A1E;
	Fri,  9 Aug 2024 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723202178; cv=none; b=PqTSh906GX0+ivsvsANbNYYqANyErA3reUNuNN79pQYf6El3VZugsEBGfSE6PXUaU5xbZ4DWUxUcJ/wLTOV9wohMKljD6mNEuS51odyoqsWqKY4KtNbATjgA+NcVjiWPQC55zLSAPFC+p18xflUG3yKojAyHcv+OxjilmN6w/sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723202178; c=relaxed/simple;
	bh=6Ym0oDETDrjgbvdG5mB7eZdQAUmgFHmwD4yMULqEwoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eg7/nPky2ILP86gyaqZNbPTLRsXlRIHZDKVaFWMbTSQLWVswid9JgcVfHsZMpq1Uy5IkF1qO1IybTMcCTfost2c6LB1P5wY+GIxa8S+k+4zaMSr5K5C98EMcxsxjmpcWhixeOsHCSJfmgKy5agzP+iTsYn1t1IW1xazideE9JrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LxOw2go+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZVJmJnqj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LxOw2go+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZVJmJnqj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 123DA1F7EA;
	Fri,  9 Aug 2024 11:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723202175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KoQephddyhrmFgErZqHzG4uceSyWf0Kb3FnNqXo2HNM=;
	b=LxOw2go+PQySyA91JrDxgpTJ0Hvnrs/hAM2TH4CxnHvXoIEdSf0A+K8UwWxavlzqUp5Uyz
	2iGJXSly3MR1HLPS8oqmc+C9VpGR078OChW3pAZucZQzwYLisDidQmkChvhtGe7PHqj2+5
	CX0mD37+/4M8BBTo2FnjZxrHTrJ+5B0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723202175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KoQephddyhrmFgErZqHzG4uceSyWf0Kb3FnNqXo2HNM=;
	b=ZVJmJnqjS8cUJdeToSKx8+joDIhYAIQ+Dq/CkIH9F26HEKjKV/SFjrpmIsY39dVb5Q6W0R
	jP4pV3+AyRLWPNCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723202175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KoQephddyhrmFgErZqHzG4uceSyWf0Kb3FnNqXo2HNM=;
	b=LxOw2go+PQySyA91JrDxgpTJ0Hvnrs/hAM2TH4CxnHvXoIEdSf0A+K8UwWxavlzqUp5Uyz
	2iGJXSly3MR1HLPS8oqmc+C9VpGR078OChW3pAZucZQzwYLisDidQmkChvhtGe7PHqj2+5
	CX0mD37+/4M8BBTo2FnjZxrHTrJ+5B0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723202175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KoQephddyhrmFgErZqHzG4uceSyWf0Kb3FnNqXo2HNM=;
	b=ZVJmJnqjS8cUJdeToSKx8+joDIhYAIQ+Dq/CkIH9F26HEKjKV/SFjrpmIsY39dVb5Q6W0R
	jP4pV3+AyRLWPNCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C9831379A;
	Fri,  9 Aug 2024 11:16:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wMpHAH76tWbCVwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 09 Aug 2024 11:16:13 +0000
Message-ID: <9c22a495-7b89-4df6-b57b-cb0f39b09c30@suse.de>
Date: Fri, 9 Aug 2024 14:16:09 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/12] PCI: brcmstb: Use bridge reset if available
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-5-james.quinlan@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240731222831.14895-5-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[broadcom.com,vger.kernel.org,kernel.org,google.com,arm.com,debian.org,suse.de,linaro.org,gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Jim,

On 8/1/24 01:28, Jim Quinlan wrote:
> The 7712 SOC has a bridge reset which can be described in the device tree.
> Use it if present.  Otherwise, continue to use the legacy method to reset
> the bridge.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 7595e7009192..4d68fe318178 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -265,6 +265,7 @@ struct brcm_pcie {
>  	enum pcie_type		type;
>  	struct reset_control	*rescal;
>  	struct reset_control	*perst_reset;
> +	struct reset_control	*bridge_reset;
>  	int			num_memc;
>  	u64			memc_size[PCIE_BRCM_MAX_MEMC];
>  	u32			hw_rev;
> @@ -732,12 +733,19 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
>  
>  static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
>  {
> -	u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> -	u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> +	if (val)
> +		reset_control_assert(pcie->bridge_reset);
> +	else
> +		reset_control_deassert(pcie->bridge_reset);
>  
> -	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> -	tmp = (tmp & ~mask) | ((val << shift) & mask);
> -	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> +	if (!pcie->bridge_reset) {
> +		u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> +		u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> +
> +		tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> +		tmp = (tmp & ~mask) | ((val << shift) & mask);
> +		writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> +	}
>  }
>  
>  static void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
> @@ -1621,10 +1629,16 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	if (IS_ERR(pcie->perst_reset))
>  		return PTR_ERR(pcie->perst_reset);
>  
> +	pcie->bridge_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "bridge");

Shouldn't this be devm_reset_control_get_optional_shared? See more below.

> +	if (IS_ERR(pcie->bridge_reset))
> +		return PTR_ERR(pcie->bridge_reset);
> +
>  	ret = clk_prepare_enable(pcie->clk);
>  	if (ret)
>  		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
>  
> +	pcie->bridge_sw_init_set(pcie, 0);

According to reset_control_get_shared description looks like this
.deassert is satisfying the requirements for _shared reset-control API
variant.
Is that the intention to call reset_control_deassert() here?

> +
>  	ret = reset_control_reset(pcie->rescal);
>  	if (dev_err_probe(&pdev->dev, ret, "failed to deassert 'rescal'\n"))
>  		goto clk_disable_unprepare;

~Stan

