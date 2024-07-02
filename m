Return-Path: <linux-pci+bounces-9588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F42B923E3F
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 15:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84DC281C73
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 12:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AD315B0F0;
	Tue,  2 Jul 2024 12:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xPkTMri3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2DP3ipGL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xPkTMri3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2DP3ipGL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8211448E1;
	Tue,  2 Jul 2024 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925195; cv=none; b=m6nYIDnBrEucAmtI/ln8yChHwUuwO5Wak1zTiE0OY2ffPiVtUYae5WZeNZL6FWqlaYnzI5nAmPwGBELrViY82kpgZclUh6ilkiOFLz8xWn5v9AXGVt4c84nbYYOlB5hD8ifp8Uc6iCx1X2ULOxxt/ebjcmUehXqxCd1HLbtOIFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925195; c=relaxed/simple;
	bh=ga4N3slUlOIvVjZCWHcdxlKk5gVpLV9DNl+52cdJ/5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4+xyRyFsFam4AVaQcCQBawMcopdBmv63n2znrAplFBxIvR6/dKUdt8ypgHmf1zwL4DLwxNaDmqglVRFAdgWdXNh+RbaZ6bwjkgrqZMGFySIwAOyE8y3V1LGfV3YJ3LgwLvJXyQehDdJ9zNkIDu6DnQncpAnfWHDAPRP4G//8D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xPkTMri3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2DP3ipGL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xPkTMri3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2DP3ipGL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 874AA1FBA7;
	Tue,  2 Jul 2024 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719925191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eR5NxWokHUHWjOyBvJc7zsLIcXQ+TOp89uIORH+/44=;
	b=xPkTMri3lidn+neW5bcI0hvor7FYHwu+i8bohIxGgclYEmj6Rofp4X+/tdbIv91I5u9P6f
	AqGY1JL8FEXzs8U5XyK1P6Xzb37E61zzIw+ltZfLf9zjpsct5R34ZnMueYnfAA9t3v5cvw
	qI8hO08gn5+WNoPKBsgyqoRG7s7VRlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719925191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eR5NxWokHUHWjOyBvJc7zsLIcXQ+TOp89uIORH+/44=;
	b=2DP3ipGLPenWukucDabqcj4n+D/MpJiUiR0eVbpljpR+LF5KY75EWeHk+oBSf7odriasA7
	YRRSOdo7oAsPNVDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xPkTMri3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2DP3ipGL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719925191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eR5NxWokHUHWjOyBvJc7zsLIcXQ+TOp89uIORH+/44=;
	b=xPkTMri3lidn+neW5bcI0hvor7FYHwu+i8bohIxGgclYEmj6Rofp4X+/tdbIv91I5u9P6f
	AqGY1JL8FEXzs8U5XyK1P6Xzb37E61zzIw+ltZfLf9zjpsct5R34ZnMueYnfAA9t3v5cvw
	qI8hO08gn5+WNoPKBsgyqoRG7s7VRlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719925191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eR5NxWokHUHWjOyBvJc7zsLIcXQ+TOp89uIORH+/44=;
	b=2DP3ipGLPenWukucDabqcj4n+D/MpJiUiR0eVbpljpR+LF5KY75EWeHk+oBSf7odriasA7
	YRRSOdo7oAsPNVDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1DA81395F;
	Tue,  2 Jul 2024 12:59:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XsrDLMb5g2Z3dQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 02 Jul 2024 12:59:50 +0000
Message-ID: <48a3b910-e2c8-4faf-a8f0-d53b5ddcd5fe@suse.de>
Date: Tue, 2 Jul 2024 15:59:45 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/8] PCI: brcmstb: Use bridge reset if available
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
 <20240628205430.24775-4-james.quinlan@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240628205430.24775-4-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 874AA1FBA7
X-Spam-Score: -4.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[broadcom.com,vger.kernel.org,kernel.org,google.com,arm.com,debian.org,suse.de,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org



On 6/28/24 23:54, Jim Quinlan wrote:
> The 7712 SOC has a bridge reset which can be described in the device tree.
> If it is present, use it. Otherwise, continue to use the legacy method to
> reset the bridge.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index c2eb29b886f7..4104c3668fdb 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -265,6 +265,7 @@ struct brcm_pcie {
>  	enum pcie_type		type;
>  	struct reset_control	*rescal;
>  	struct reset_control	*perst_reset;
> +	struct reset_control	*bridge;
>  	int			num_memc;
>  	u64			memc_size[PCIE_BRCM_MAX_MEMC];
>  	u32			hw_rev;
> @@ -732,12 +733,19 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
>  
>  static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
>  {
> -	u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> -	u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> +	if (pcie->bridge) {
> +		if (val)
> +			reset_control_assert(pcie->bridge);
> +		else
> +			reset_control_deassert(pcie->bridge);

Please check reset_control_assert/deassert() calls for error. This might
need to change the definition of brcm_pcie_bridge_sw_init_set_generic()
to return error.

~Stan

