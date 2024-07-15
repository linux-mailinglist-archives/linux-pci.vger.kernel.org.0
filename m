Return-Path: <linux-pci+bounces-10249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F5D931259
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 12:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34DFFB2179F
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 10:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DDF18733F;
	Mon, 15 Jul 2024 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GjjGrvh9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HXOp3J5L";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GjjGrvh9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HXOp3J5L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BABE186E3C;
	Mon, 15 Jul 2024 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039738; cv=none; b=fMssZqel3za7Z5mPwu8vNBjSC4ht5TxB5B3X+2e/PpHt3ncEjd/1jmRFP7avHv92rmgG5Gdz3Nk6YxrtYbWqlUzlE5/g5r+fLfUuKSha6aM5SbPxtCoypnEPPbHj+v6uxGcoIMKxoPr2leq62l0lCIkgD67Iz0sDa61n4+m2sTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039738; c=relaxed/simple;
	bh=tDcWBjimXxZ4qtvimF74fncLq3AKJmenG+wy9yggjoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0gk5YPAh5BDZDdO4XLditkYQGJAU6xS4qFYQf3pL0CnDxCU03SDefZ5XMvuntH8GUSn/PSLk57J4D4WT3E1g96loh/AzhQ4kSzPiSxAX4XkwjQ6lDMUbFA68t56c/eu+HBTkG3sXvSwkcBv2cxDzY8WSTic+vijw1PJciOHF2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GjjGrvh9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HXOp3J5L; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GjjGrvh9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HXOp3J5L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B69D1F80C;
	Mon, 15 Jul 2024 10:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721039735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B16PJA2vYg99WPSd7obdqJCidN5HGGJf6oYBxyxBLsE=;
	b=GjjGrvh9gRPOyu8uUEdBMi1q9vmzY2WJ/+ltv0TF2ir6CxR8NdGfHOA/X7DD6/vJ1I5k2i
	KDUCp9JOVEJRi6tzLVN4PrLe5IBRxxcEFZRkYQeejhV9N8ah3B+NX4aGWv57t0K9pW5Ucs
	PKjZxEdYY16+he44f5Sgy9g4/CKbbAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721039735;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B16PJA2vYg99WPSd7obdqJCidN5HGGJf6oYBxyxBLsE=;
	b=HXOp3J5LrH5xOV9OZyP/CUCUoyVWPIJwUqiaFTkjI1fb/AzqIOF80HhgWGNSSmE9LwqijW
	S00qczwBimY3TpBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GjjGrvh9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HXOp3J5L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721039735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B16PJA2vYg99WPSd7obdqJCidN5HGGJf6oYBxyxBLsE=;
	b=GjjGrvh9gRPOyu8uUEdBMi1q9vmzY2WJ/+ltv0TF2ir6CxR8NdGfHOA/X7DD6/vJ1I5k2i
	KDUCp9JOVEJRi6tzLVN4PrLe5IBRxxcEFZRkYQeejhV9N8ah3B+NX4aGWv57t0K9pW5Ucs
	PKjZxEdYY16+he44f5Sgy9g4/CKbbAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721039735;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B16PJA2vYg99WPSd7obdqJCidN5HGGJf6oYBxyxBLsE=;
	b=HXOp3J5LrH5xOV9OZyP/CUCUoyVWPIJwUqiaFTkjI1fb/AzqIOF80HhgWGNSSmE9LwqijW
	S00qczwBimY3TpBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5484137EB;
	Mon, 15 Jul 2024 10:35:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ngKRKXb7lGYDIwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 15 Jul 2024 10:35:34 +0000
Message-ID: <a3cc8853-5a2c-4961-a3fc-dfce508ec414@suse.de>
Date: Mon, 15 Jul 2024 13:35:26 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] PCI: brcmstb: Use swinit reset if available
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
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
References: <20240710221630.29561-1-james.quinlan@broadcom.com>
 <20240710221630.29561-6-james.quinlan@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240710221630.29561-6-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8B69D1F80C
X-Spam-Flag: NO
X-Spam-Score: -0.50
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.50 / 50.00];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[broadcom.com,vger.kernel.org,kernel.org,google.com,arm.com,debian.org,suse.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spamd-Bar: /



On 7/11/24 01:16, Jim Quinlan wrote:
> The 7712 SOC adds a software init reset device for the PCIe HW.
> If found in the DT node, use it.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 92816d8d215a..4dc2ff7f3167 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -266,6 +266,7 @@ struct brcm_pcie {
>  	struct reset_control	*rescal;
>  	struct reset_control	*perst_reset;
>  	struct reset_control	*bridge;
> +	struct reset_control	*swinit;
>  	int			num_memc;
>  	u64			memc_size[PCIE_BRCM_MAX_MEMC];
>  	u32			hw_rev;
> @@ -1633,12 +1634,27 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	if (IS_ERR(pcie->bridge))
>  		return PTR_ERR(pcie->bridge);
>  
> +	pcie->swinit = devm_reset_control_get_optional_exclusive(&pdev->dev, "swinit");
> +	if (IS_ERR(pcie->swinit))
> +		return PTR_ERR(pcie->swinit);
> +
>  	ret = clk_prepare_enable(pcie->clk);
>  	if (ret) {
>  		dev_err(&pdev->dev, "could not enable clock\n");
>  		return ret;
>  	}
>  
> +	ret = reset_control_assert(pcie->swinit);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "could not assert reset 'swinit'\n");
> +		goto clk_out;
> +	}

If there is a new version, please add blank line here.

Otherwise:

Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>

~Stan

> +	ret = reset_control_deassert(pcie->swinit);
> +	if (ret) {
> +		dev_err(&pdev->dev, "could not de-assert reset 'swinit' after asserting\n");
> +		goto clk_out;
> +	}
> +
>  	ret = reset_control_reset(pcie->rescal);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");

