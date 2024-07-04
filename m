Return-Path: <linux-pci+bounces-9807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB6F92777D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 15:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968882818CF
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 13:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F571411F9;
	Thu,  4 Jul 2024 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rm5zWawA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jEKcehOI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rm5zWawA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jEKcehOI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551601822E2;
	Thu,  4 Jul 2024 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101096; cv=none; b=iqpuN0xzD8VpFqNWYKjAMNh5DTvKk5WpnJjlqSvOsG0TkpTmPLoxq8CPLTl8JKjnBosT6l96KqCLtE2vrunAsVoh1/C8ySHRGDyBNEaqnUKtHVkbvuZdw7xsuYREkb/z644JzFNIJYMyLH+XEQwjnJu/2f+Qrt+qU203aJJ8CG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101096; c=relaxed/simple;
	bh=+O+y5QdPN80z5fv8mWzZ0GG5KG9s3k/1cGLfxmwxkXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=citpLKxZtEYc/74pYH+KcS2n1H9Bsxh8mAEBokrMs6CUjFioPped2OK2R/bktDFCM/JRfhne4JCRLWgxudi8CG1xiwkzAknEAvsMFTYXG0Soi66lkREg/77JiJDA83je3W/ACTR1nq9+Modf7zcN5uvoQ2IoyGfET1hIcqXX5Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rm5zWawA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jEKcehOI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rm5zWawA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jEKcehOI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 89E0E1F7DA;
	Thu,  4 Jul 2024 13:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720101092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3fJXbnT02eDQyoivQSk4Ej7vugA+zzAv/AFaDuj4jXw=;
	b=rm5zWawA43TloSyZ43YWPtLdNOBzGgy2ee9i91oLQf7oP/rPKG7A8AqSYqd03oOUZtX5kt
	0j++N//zCeW4I0jLAKwMrrCyQalr3jcawzMs0+UHpM2CEU4MEciGNpuI27axeNEu6WQaOB
	0CQ4+ZCnYIgcjALEwKK5xb2Ke6LJ4DA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720101092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3fJXbnT02eDQyoivQSk4Ej7vugA+zzAv/AFaDuj4jXw=;
	b=jEKcehOIIwc5FC/xCYAxPHeAgEye666qL2E4nmm4ue8t0/Sdwhd11qsuofQPebXLxbMlrC
	jJrm+XEKO+PfKuAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720101092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3fJXbnT02eDQyoivQSk4Ej7vugA+zzAv/AFaDuj4jXw=;
	b=rm5zWawA43TloSyZ43YWPtLdNOBzGgy2ee9i91oLQf7oP/rPKG7A8AqSYqd03oOUZtX5kt
	0j++N//zCeW4I0jLAKwMrrCyQalr3jcawzMs0+UHpM2CEU4MEciGNpuI27axeNEu6WQaOB
	0CQ4+ZCnYIgcjALEwKK5xb2Ke6LJ4DA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720101092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3fJXbnT02eDQyoivQSk4Ej7vugA+zzAv/AFaDuj4jXw=;
	b=jEKcehOIIwc5FC/xCYAxPHeAgEye666qL2E4nmm4ue8t0/Sdwhd11qsuofQPebXLxbMlrC
	jJrm+XEKO+PfKuAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE0991369F;
	Thu,  4 Jul 2024 13:51:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wAPsK+OohmaiJgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 04 Jul 2024 13:51:31 +0000
Message-ID: <ed3f2b70-fc71-4bde-b4d6-c9ad4bb0f715@suse.de>
Date: Thu, 4 Jul 2024 16:51:31 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] PCI: brcmstb: Enable 7712 SOCs
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240703180300.42959-1-james.quinlan@broadcom.com>
 <20240703180300.42959-12-james.quinlan@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240703180300.42959-12-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[broadcom.com,vger.kernel.org,kernel.org,google.com,arm.com,debian.org,suse.de,gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]

Hi Jim,

On 7/3/24 21:02, Jim Quinlan wrote:
> The Broadcom STB 7712 is the sibling chip of the RPi 5 (2712).
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 1c3ce0c182d1..39d7dea282ff 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1216,7 +1216,9 @@ static void brcm_config_clkreq(struct brcm_pcie *pcie)
>  		 * atypical and should happen only with older devices.
>  		 */
>  		clkreq_cntl |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK;
> -		brcm_extend_rbus_timeout(pcie);
> +		/* 7712 does not have this (RGR1) timer */
> +		if (pcie->type != BCM7712)
> +			brcm_extend_rbus_timeout(pcie);

I'd move the check in brcm_extend_rbus_timeout() function.

Otherwise:

Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>

>  
>  	} else {
>  		/*
> @@ -1628,6 +1630,13 @@ static const int pcie_offsets_bmips_7425[] = {
>  	[PCIE_INTR2_CPU_BASE] = 0x4300,
>  };
>  
> +static const int pcie_offset_bcm7712[] = {
> +	[EXT_CFG_INDEX]  = 0x9000,
> +	[EXT_CFG_DATA]   = 0x9004,
> +	[PCIE_HARD_DEBUG] = 0x4304,
> +	[PCIE_INTR2_CPU_BASE] = 0x4400,
> +};
> +
>  static const struct pcie_cfg_data generic_cfg = {
>  	.offsets	= pcie_offsets,
>  	.type		= GENERIC,
> @@ -1686,6 +1695,13 @@ static const struct pcie_cfg_data bcm7216_cfg = {
>  	.has_phy	= true,
>  };
>  
> +static const struct pcie_cfg_data bcm7712_cfg = {
> +	.offsets	= pcie_offset_bcm7712,
> +	.perst_set	= brcm_pcie_perst_set_7278,
> +	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.type		= BCM7712,
> +};
> +
>  static const struct of_device_id brcm_pcie_match[] = {
>  	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
>  	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
> @@ -1695,6 +1711,7 @@ static const struct of_device_id brcm_pcie_match[] = {
>  	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
>  	{ .compatible = "brcm,bcm7435-pcie", .data = &bcm7435_cfg },
>  	{ .compatible = "brcm,bcm7425-pcie", .data = &bcm7425_cfg },
> +	{ .compatible = "brcm,bcm7712-pcie", .data = &bcm7712_cfg },
>  	{},
>  };
>  

