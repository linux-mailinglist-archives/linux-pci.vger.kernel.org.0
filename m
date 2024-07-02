Return-Path: <linux-pci+bounces-9590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A567A923E71
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 15:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC2F286D6D
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 13:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C621C19DF71;
	Tue,  2 Jul 2024 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v9idc0sU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jcCohWJu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v9idc0sU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jcCohWJu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D7819DF6D;
	Tue,  2 Jul 2024 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925834; cv=none; b=T1wOvZPO/NV3OF27fqvnkufPzPUuMXwY94D9zzsWA4wxmfa0hfFWA2Kf2lBe39xcxdSjmDTma6gaCVI7vUD9iCyEycrs96FboX0ISEA8h+PoSXJXlBEO0gOkgswbBW2Z3zE5ajsjSyLaSB23V1EAa/qeQJCrlSnC/xvz5104M8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925834; c=relaxed/simple;
	bh=P3cp8IJtgtmIub/xSe/UL2lL3aks1sGYZXk/3W932Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1FzLJIj7YAgjF/OKTJXWF2bKwAZsgCQUiIFvcWsMfiVFG0uACJpb14GUkgZUpvESskTqsrq6mmgz/7yY1NySr7JelNznfN054qdL9Mk+6+KnxLf90VDTHpUnEUaYghTB9Q04S0HPKQtmwJ9mFZjEL+zRt3ThplJBKW50GJ3YPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v9idc0sU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jcCohWJu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v9idc0sU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jcCohWJu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3463921ADC;
	Tue,  2 Jul 2024 13:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719925829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYMtXZ1g8F5fUhJTOUjtdim923MxbFczW9hfSAUjd3E=;
	b=v9idc0sU9beceIEnQ8fh6qG6DfAeaNVxAnJmWdyQKUTSyijf8FuUfr6veEnZxbCCtwNb57
	GDtP+fYEDOjHKFRao4TYKmtjACeqMDtglXJoL0IvxFQ06NZnu6VqWvpR0P37nfksSiJ7WN
	DKEGrc8Yc9bE1WMuvMVbySPIC7xN3/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719925829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYMtXZ1g8F5fUhJTOUjtdim923MxbFczW9hfSAUjd3E=;
	b=jcCohWJu0d/VvnqeZXmtYvQ1ogddhQ4GxECzBBsvnXcagysCLAmp0Fv97pWZrHYTLehCob
	gwltakN3yn8gUGDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719925829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYMtXZ1g8F5fUhJTOUjtdim923MxbFczW9hfSAUjd3E=;
	b=v9idc0sU9beceIEnQ8fh6qG6DfAeaNVxAnJmWdyQKUTSyijf8FuUfr6veEnZxbCCtwNb57
	GDtP+fYEDOjHKFRao4TYKmtjACeqMDtglXJoL0IvxFQ06NZnu6VqWvpR0P37nfksSiJ7WN
	DKEGrc8Yc9bE1WMuvMVbySPIC7xN3/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719925829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYMtXZ1g8F5fUhJTOUjtdim923MxbFczW9hfSAUjd3E=;
	b=jcCohWJu0d/VvnqeZXmtYvQ1ogddhQ4GxECzBBsvnXcagysCLAmp0Fv97pWZrHYTLehCob
	gwltakN3yn8gUGDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F80A1395F;
	Tue,  2 Jul 2024 13:10:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7RaDGET8g2YAeQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 02 Jul 2024 13:10:28 +0000
Message-ID: <c4633d7a-11a4-4c1c-954b-45f631cb2563@suse.de>
Date: Tue, 2 Jul 2024 16:10:19 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/8] PCI: brcmstb: Don't conflate the reset rescal with
 phy ctrl
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
References: <20240628205430.24775-1-james.quinlan@broadcom.com>
 <20240628205430.24775-7-james.quinlan@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240628205430.24775-7-james.quinlan@broadcom.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]



On 6/28/24 23:54, Jim Quinlan wrote:
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
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 4e0848e1311f..e740e2966a5c 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -227,6 +227,7 @@ enum pcie_type {
>  struct pcie_cfg_data {
>  	const int *offsets;
>  	const enum pcie_type type;
> +	const bool has_phy;
>  	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
>  	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
>  };
> @@ -277,6 +278,7 @@ struct brcm_pcie {
>  	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
>  	struct subdev_regulators *sr;
>  	bool			ep_wakeup_capable;
> +	bool			has_phy;
>  };
>  
>  static inline bool is_bmips(const struct brcm_pcie *pcie)
> @@ -1316,12 +1318,12 @@ static int brcm_phy_cntl(struct brcm_pcie *pcie, const int start)
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
> @@ -1564,12 +1566,20 @@ static const struct pcie_cfg_data bcm2711_cfg = {
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>  };
>  
> +static const struct pcie_cfg_data bcm7216_cfg = {
> +	.offsets	= pcie_offset_bcm7278,
> +	.type		= BCM7278,

This "type" field is confusing, maybe it would be good to rename it to
"family"? For example BCM72XX family.

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
> @@ -1617,6 +1627,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	pcie->type = data->type;
>  	pcie->perst_set = data->perst_set;
>  	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
> +	pcie->has_phy = data->has_phy;
>  
>  	pcie->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(pcie->base))

~Stan

