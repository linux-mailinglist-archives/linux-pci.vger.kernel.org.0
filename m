Return-Path: <linux-pci+bounces-9802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5469276DA
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 15:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F1D1C20922
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 13:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1684F13BADF;
	Thu,  4 Jul 2024 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UM58ipex";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uwFPuFSt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UM58ipex";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uwFPuFSt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777AA1E507;
	Thu,  4 Jul 2024 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098495; cv=none; b=KMUz8ESzIXUgxiF4C2KdMHrM+HbZT3LysAKcFESJc6v+cFJHfxv/XRIZDene3m4VHb168NyxSA2wd69Sj54+C9bnImhLowO2wLSW/7eE2LlfCSSxnuBh2VxhvnQJpIYPQlIpTYU+gmM//KMciCCAgSBgAx+/tZ2eSo2Uxl2tQNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098495; c=relaxed/simple;
	bh=16VrZBErTD146vQu/aKXiccnd7n3RPjwuiPreYGNt6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ke7toUSr1I2LEadjyCzFf36nvmgY3ZrvI6WR7XuvYwqbh8LZW3DY2eaTmzbFpbCDl5MxFzAEqRGsnZ1iDA3VEGXzTe8HZmWZkX5nEMeZfukVvIHRRNuwPfSbsr7b4SkeU/s76ttf610WAbpwRKFzVfVddMmQzYT0bt6KuNd7yVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UM58ipex; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uwFPuFSt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UM58ipex; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uwFPuFSt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 93AA61F7C0;
	Thu,  4 Jul 2024 13:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720098491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5kl0J7BZG559ce4+Nlj/455w9qo5G54P1ACweVuwSs=;
	b=UM58ipexMjnXHpT75p9mORqpnGxxYHUY2Cvs+UY5QjSBy5rKfDVOCEpY8zT62IEAi0yHKT
	nGkTGhYAIPgr5crNxXbmx303bc0l4ezdv79eEy/6SP85fodtdLnQnWxrF/CfAeh/8R+RXY
	ITSn/QrCDd1J0CQ1BgsYeJjxx6hzKZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720098491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5kl0J7BZG559ce4+Nlj/455w9qo5G54P1ACweVuwSs=;
	b=uwFPuFStyv8p0g9P3l8l/Y1RMsHqxhhPY9eOZ8rOyejLVMkh2khazpSV11gC4QBWHOG6Pd
	Oc821XhkQjqEZyCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UM58ipex;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uwFPuFSt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720098491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5kl0J7BZG559ce4+Nlj/455w9qo5G54P1ACweVuwSs=;
	b=UM58ipexMjnXHpT75p9mORqpnGxxYHUY2Cvs+UY5QjSBy5rKfDVOCEpY8zT62IEAi0yHKT
	nGkTGhYAIPgr5crNxXbmx303bc0l4ezdv79eEy/6SP85fodtdLnQnWxrF/CfAeh/8R+RXY
	ITSn/QrCDd1J0CQ1BgsYeJjxx6hzKZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720098491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5kl0J7BZG559ce4+Nlj/455w9qo5G54P1ACweVuwSs=;
	b=uwFPuFStyv8p0g9P3l8l/Y1RMsHqxhhPY9eOZ8rOyejLVMkh2khazpSV11gC4QBWHOG6Pd
	Oc821XhkQjqEZyCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D36C713889;
	Thu,  4 Jul 2024 13:08:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BIglMbqehmbuGQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 04 Jul 2024 13:08:10 +0000
Message-ID: <6e46418f-e0a6-46bf-8490-c261cf95edb0@suse.de>
Date: Thu, 4 Jul 2024 16:08:10 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] PCI: brcmstb: Don't conflate the reset rescal
 with phy ctrl
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
 <20240703180300.42959-9-james.quinlan@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240703180300.42959-9-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 93AA61F7C0
X-Spam-Score: -5.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[16];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[broadcom.com,vger.kernel.org,kernel.org,google.com,arm.com,debian.org,suse.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hi Jim,


On 7/3/24 21:02, Jim Quinlan wrote:
> We've been assuming that if an SOC has a "rescal" reset controller that we
> should automatically invoke brcm_phy_cntl(...).  This will not be true in
> future SOCs, so we create a bool "has_phy" and adjust the cfg_data
> appropriately (we need to give 7216 its own cfg_data structure instead of
> sharing one).
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)

Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>

~Stan
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 3aa82871e9b3..ffb3e8d8fb2a 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -222,6 +222,7 @@ enum pcie_type {
>  struct pcie_cfg_data {
>  	const int *offsets;
>  	const enum pcie_type type;
> +	const bool has_phy;
>  	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
>  	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
>  };
> @@ -272,6 +273,7 @@ struct brcm_pcie {
>  	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
>  	struct subdev_regulators *sr;
>  	bool			ep_wakeup_capable;
> +	bool			has_phy;
>  };
>  
>  static inline bool is_bmips(const struct brcm_pcie *pcie)
> @@ -1311,12 +1313,12 @@ static int brcm_phy_cntl(struct brcm_pcie *pcie, const int start)
>  
>  static inline int brcm_phy_start(struct brcm_pcie *pcie)
>  {
> -	return pcie->rescal ? brcm_phy_cntl(pcie, 1) : 0;
> +	return pcie->has_phy ? brcm_phy_cntl(pcie, 1) : 0;
>  }
>  
>  static inline int brcm_phy_stop(struct brcm_pcie *pcie)
>  {
> -	return pcie->rescal ? brcm_phy_cntl(pcie, 0) : 0;
> +	return pcie->has_phy ? brcm_phy_cntl(pcie, 0) : 0;
>  }
>  
>  static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
> @@ -1559,12 +1561,20 @@ static const struct pcie_cfg_data bcm2711_cfg = {
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>  };
>  
> +static const struct pcie_cfg_data bcm7216_cfg = {
> +	.offsets	= pcie_offset_bcm7278,
> +	.type		= BCM7278,
> +	.perst_set	= brcm_pcie_perst_set_7278,
> +	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
> +	.has_phy	= true,
> +};
> +
>  static const struct of_device_id brcm_pcie_match[] = {
>  	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
>  	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
>  	{ .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
>  	{ .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
> -	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7278_cfg },
> +	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7216_cfg },
>  	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
>  	{ .compatible = "brcm,bcm7435-pcie", .data = &bcm7435_cfg },
>  	{ .compatible = "brcm,bcm7425-pcie", .data = &bcm7425_cfg },
> @@ -1612,6 +1622,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	pcie->type = data->type;
>  	pcie->perst_set = data->perst_set;
>  	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
> +	pcie->has_phy = data->has_phy;
>  
>  	pcie->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(pcie->base))

