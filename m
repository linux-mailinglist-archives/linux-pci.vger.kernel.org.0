Return-Path: <linux-pci+bounces-9589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C65B923E5A
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 15:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEF22B2608E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 13:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B383616F858;
	Tue,  2 Jul 2024 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kut7KqaY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dFg/KFgG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kut7KqaY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dFg/KFgG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D951891A7;
	Tue,  2 Jul 2024 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925385; cv=none; b=U7y4keY5Q+KLWY1h9YvWLUPJXvrFa6eWQRdCfXs6+py2GR2EQ2qd/b35BISujel0B7FJ0nemdKlVGjo2wCFdh1vYqtr4OpVseJHkM8OfoG9G0FJKRwkTQUHtFa+ACamtT4TicDQCV+0O1bneEEbtVWA0VhhwKhsUu2SKv/ZiT4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925385; c=relaxed/simple;
	bh=MZYlAMwNFiR6l3c5iIgEBT+7f18GbiYASC0FT+8UhZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9n4wwHJJPCubcnHliaRYPxC+jaQubI6MI+ZwcDCVc3xHF7bon0pOHSu2bTAmY9F3VB9exvazrMaTXVGlZ1/SYgta5ravg9/fT7kLdF4AHskS9Lq8Uys4klG4aD8qPvHBe8uzWO8JSScXWUCKeKu9Vmqx4LfN9Tm1BCqAebUc/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kut7KqaY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dFg/KFgG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kut7KqaY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dFg/KFgG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1CB8621B04;
	Tue,  2 Jul 2024 13:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719925381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hq4LU9E9VVqqFVOZgr3nZEC3R9cyqVmd/eG1ZDcn/oA=;
	b=kut7KqaYw/xdO0z9aSZGrDzVNxKOeayONJeE3o0fbSPaHg/rEVsAbu5MP8ZubUgWroqZ6Y
	HYIWk1mPIvJ8n7Q93EBRjeg7zprJ81vGqkd7PRHpmXXzLye4SkwgK8MuRokdEy0pCQgmVd
	6HKT41HurUCJdN0vcFpwTEpfQp8lTiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719925381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hq4LU9E9VVqqFVOZgr3nZEC3R9cyqVmd/eG1ZDcn/oA=;
	b=dFg/KFgGcs6dBb/rG6bXy1P1RXCQrE+lrKp4zhQOaT0So85ReN9NJ9+Jj5sxabS13TMR8r
	+uo89DrHJnDTZ9Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kut7KqaY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="dFg/KFgG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719925381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hq4LU9E9VVqqFVOZgr3nZEC3R9cyqVmd/eG1ZDcn/oA=;
	b=kut7KqaYw/xdO0z9aSZGrDzVNxKOeayONJeE3o0fbSPaHg/rEVsAbu5MP8ZubUgWroqZ6Y
	HYIWk1mPIvJ8n7Q93EBRjeg7zprJ81vGqkd7PRHpmXXzLye4SkwgK8MuRokdEy0pCQgmVd
	6HKT41HurUCJdN0vcFpwTEpfQp8lTiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719925381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hq4LU9E9VVqqFVOZgr3nZEC3R9cyqVmd/eG1ZDcn/oA=;
	b=dFg/KFgGcs6dBb/rG6bXy1P1RXCQrE+lrKp4zhQOaT0So85ReN9NJ9+Jj5sxabS13TMR8r
	+uo89DrHJnDTZ9Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56AB71395F;
	Tue,  2 Jul 2024 13:03:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wDbAEoT6g2a9dgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 02 Jul 2024 13:03:00 +0000
Message-ID: <348a2911-435c-4ffa-9da3-c9c4147df0c9@suse.de>
Date: Tue, 2 Jul 2024 16:02:59 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/8] PCI: brcmstb: Use swinit reset if available
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
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
References: <20240628205430.24775-1-james.quinlan@broadcom.com>
 <20240628205430.24775-5-james.quinlan@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240628205430.24775-5-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-5.49 / 50.00];
	BAYES_HAM(-2.99)[99.96%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[broadcom.com,vger.kernel.org,kernel.org,google.com,arm.com,debian.org,suse.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1CB8621B04
X-Spam-Flag: NO
X-Spam-Score: -5.49
X-Spam-Level: 



On 6/28/24 23:54, Jim Quinlan wrote:
> The 7712 SOC adds a software init reset device for the PCIe HW.
> If found in the DT node, use it.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 4104c3668fdb..0f1c3e1effb1 100644
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
> @@ -1626,6 +1627,25 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "could not enable clock\n");
>  		return ret;
>  	}
> +
> +	pcie->swinit = devm_reset_control_get_optional_exclusive(&pdev->dev, "swinit");
> +	if (IS_ERR(pcie->swinit)) {
> +		ret = dev_err_probe(&pdev->dev, PTR_ERR(pcie->swinit),
> +				    "failed to get 'swinit' reset\n");
> +		goto clk_out;
> +	}
> +
> +	ret = reset_control_assert(pcie->swinit);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "could not assert reset 'swinit'\n");
> +		goto clk_out;
> +	} else {
> +		ret = dev_err_probe(&pdev->dev, reset_control_deassert(pcie->swinit),
> +				    "could not de-assert reset 'swinit' after asserting\n");
> +		if (ret)
> +			goto clk_out;
> +	}

Could you move reset_control_assert() after get all resources.

~Stan

> +
>  	pcie->rescal = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
>  	if (IS_ERR(pcie->rescal)) {
>  		ret = PTR_ERR(pcie->rescal);

