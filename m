Return-Path: <linux-pci+bounces-10248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC87F931253
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 12:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F110B1C21E08
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 10:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24BD18732D;
	Mon, 15 Jul 2024 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xB1oIhFj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+Wo6LQrf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G0wVZUg8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wniD5IHn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F54186E3C;
	Mon, 15 Jul 2024 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039630; cv=none; b=g/dXHs4dNk6FMe7FpZg+sx9K5vK27c8PvQyyEwqYaPjLKWUfismxEJ03kyCxPM+8YL4Gw8UGiEnpsDe5KpLWN7qRH+F9H/EBlPOdrmucX8QyheV0uSTtKE7rAMxnQm9qxUKMbkqLnGwuRBVhkcq1ZC0xkCXmzy0DzJ2HPdiLD+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039630; c=relaxed/simple;
	bh=POqeKX6tEwuOryP7D8pPSvyzfo0os9dxBRg/ltXOz2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h77+fzyqiXToOHkAyxHemPd+HwhgOMPYb6jduAcTjQvjkP60HcozW4DTtle+/lB9yTiPuiFPFGdVvOl4Q6Ll6F4e6Q3xMVvaAImrhZsKfV8IGdoqW1CWmv2zbmKDF8GQldbdiSKajUeX3WO+E5NU7S65dgq20VpzLoDxU4fpa6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xB1oIhFj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+Wo6LQrf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G0wVZUg8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wniD5IHn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5E9171F7FA;
	Mon, 15 Jul 2024 10:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721039627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0wkpJ0yEL82EHMn/bNz7YBqqCMlkZSB87fuqhhgtD4=;
	b=xB1oIhFj5LaHU6XkOIrewi1cAfmZGxYnlyv7Cq1HHl7kqjUDnKl10mx1fxrJxoqAmElV+j
	JrS8QHJhTdlfrC7zG3gc45ttgYeQsjbEK/ib+7ZtmC9Qx4ArW0t3rsHeHoX0fRFcU3o/J/
	hMGHI3xKNJUQwGkk+LjTRES1UYk/iPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721039627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0wkpJ0yEL82EHMn/bNz7YBqqCMlkZSB87fuqhhgtD4=;
	b=+Wo6LQrf9leoiXz2iq/jR6P7tyBBk+qPhUm+Kw+JZLUC8qDCDsLSXE2dN9mxpYId1+8Mbz
	Ed9cREnOuVApEZAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721039626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0wkpJ0yEL82EHMn/bNz7YBqqCMlkZSB87fuqhhgtD4=;
	b=G0wVZUg89ATBGmrNIvjDhOWX8zbyCgLBNYc9wRsCrG1v56h2i0SI+VZHOKJYDK2AMrfLbw
	NJzgQDBWom8YPmbNJM/mqnyTcZnGsFFB4tWK44iRcmulIJ/LeMmy+WSYr83b88vw8UXLNr
	WU3LIArN/KfYhTmOGZBnuCNk9iEXQw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721039626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0wkpJ0yEL82EHMn/bNz7YBqqCMlkZSB87fuqhhgtD4=;
	b=wniD5IHnikPCcW5+cm+p52TV/Hj6ckSmnTvQE5fkYtKjjIMt/CXv3W+IclopZE7WYs3wbI
	9HM0ZZ0D+1elxlDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88317137EB;
	Mon, 15 Jul 2024 10:33:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FJGaHgn7lGaFIgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 15 Jul 2024 10:33:45 +0000
Message-ID: <e060f00e-c36c-465b-b9ae-5d6126d9c643@suse.de>
Date: Mon, 15 Jul 2024 13:33:45 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] PCI: brcmstb: Use bridge reset if available
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
 <20240710221630.29561-5-james.quinlan@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240710221630.29561-5-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -0.29
X-Spamd-Result: default: False [-0.29 / 50.00];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_TO(0.00)[broadcom.com,vger.kernel.org,kernel.org,google.com,arm.com,debian.org,suse.de,gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 



On 7/11/24 01:16, Jim Quinlan wrote:
> The 7712 SOC has a bridge reset which can be described in the device tree.
> If it is present, use it. Otherwise, continue to use the legacy method to
> reset the bridge.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)

Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>

~Stan

