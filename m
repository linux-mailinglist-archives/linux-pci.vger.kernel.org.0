Return-Path: <linux-pci+bounces-9799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC669276AB
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 15:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A030B21A40
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 13:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8881422B7;
	Thu,  4 Jul 2024 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sbEWGAbJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rFTWPRpZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sbEWGAbJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rFTWPRpZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391D37E9;
	Thu,  4 Jul 2024 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098060; cv=none; b=YuRmi1RaKjeokVNPp+1zLVoWP552vF3TZ4fPR+6I1iZiM/pQWerH97L3G5j/WGzfEfJxSoU+4d+/+DyIOGtrjJ1Xo4DTOhCm1Q0asoQ6PCrFDR5hy3pPSRmy8TQ+pBUGlCHf1LZmqTeYUxHwh43w6ztMF2sCvu59lzqqHxkrRrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098060; c=relaxed/simple;
	bh=c+fU3icWBiTQt4AHFwhZp2eFHRMUlRaZydFPjgyQ5jA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oCNb6xHcq3b5bX1aUfWHm2QUEi+eN59L+LpMa6p+BD3CpfW7RPl64KOA6HwTFF40nHbky2jFzwpfjhtOWiYW8VlV/+/XRcKjcT+mDEQ+5v+CfrM7nr9XNdUwl2BvCx/ejH4o42xad3yPxbUdA77sgWiZMOjIc5dhkVcNNXtQDjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sbEWGAbJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rFTWPRpZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sbEWGAbJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rFTWPRpZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 568891F7BC;
	Thu,  4 Jul 2024 13:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720098057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqxVYzgl/rHw+s+BWRzpBzVsp4eAcq71WWPLsHaqS/s=;
	b=sbEWGAbJf/UiX1Wrrarr4Nxjngefo/RdlQE4ZJgXs7O6AY3zQ0gcAfjDCmVGdst49OX1Jw
	O+uBId4Ym5x1DUht09eSx9GWAlgA4s93qXwR9B4yKjJDWcaZ9QyT9oosEHp/6OtVcJ301R
	SAAsgmI23FDonVlHOOYELtD80kgB3XA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720098057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqxVYzgl/rHw+s+BWRzpBzVsp4eAcq71WWPLsHaqS/s=;
	b=rFTWPRpZDi0a3VLPq9Th75eyAo5Wt2zzmmsprTfuTFp1JSN1DeD4Rp5M0ZbzghAB/iuc3E
	/3PJwxa8nIZuseAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720098057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqxVYzgl/rHw+s+BWRzpBzVsp4eAcq71WWPLsHaqS/s=;
	b=sbEWGAbJf/UiX1Wrrarr4Nxjngefo/RdlQE4ZJgXs7O6AY3zQ0gcAfjDCmVGdst49OX1Jw
	O+uBId4Ym5x1DUht09eSx9GWAlgA4s93qXwR9B4yKjJDWcaZ9QyT9oosEHp/6OtVcJ301R
	SAAsgmI23FDonVlHOOYELtD80kgB3XA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720098057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqxVYzgl/rHw+s+BWRzpBzVsp4eAcq71WWPLsHaqS/s=;
	b=rFTWPRpZDi0a3VLPq9Th75eyAo5Wt2zzmmsprTfuTFp1JSN1DeD4Rp5M0ZbzghAB/iuc3E
	/3PJwxa8nIZuseAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4387013889;
	Thu,  4 Jul 2024 13:00:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lCspDgidhmbqFwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 04 Jul 2024 13:00:56 +0000
Message-ID: <c3576d2a-53c8-41f9-a825-13e9bc6417ee@suse.de>
Date: Thu, 4 Jul 2024 16:00:51 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] PCI: brcmstb: Get resource before we start
 asserting reset controllers
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
References: <20240703180300.42959-1-james.quinlan@broadcom.com>
 <20240703180300.42959-6-james.quinlan@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240703180300.42959-6-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.28
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.28 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.974];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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

Hi Jim,

On 7/3/24 21:02, Jim Quinlan wrote:
> Place all of the devm_reset_contol_get*() calls above the calls that
> assert the reset controllers.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 69926ee5c961..59daa4b2e6c5 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1644,6 +1644,11 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  		ret = PTR_ERR(pcie->perst_reset);
>  		goto clk_out;
>  	}
> +	pcie->bridge = devm_reset_control_get_optional_exclusive(&pdev->dev, "bridge");
> +	if (IS_ERR(pcie->bridge)) {
> +		ret = PTR_ERR(pcie->bridge);
> +		goto clk_out;
> +	}
>  

This change must be merged in 3/12 - "PCI: brcmstb: Use bridge reset if
available"

~Stan
>  	ret = reset_control_assert(pcie->swinit);
>  	if (ret) {
> @@ -1662,12 +1667,6 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  		goto clk_out;
>  	}
>  
> -	pcie->bridge = devm_reset_control_get_optional_exclusive(&pdev->dev, "bridge");
> -	if (IS_ERR(pcie->bridge)) {
> -		ret = PTR_ERR(pcie->bridge);
> -		goto clk_out;
> -	}
> -
>  	ret = brcm_phy_start(pcie);
>  	if (ret) {
>  		reset_control_rearm(pcie->rescal);

