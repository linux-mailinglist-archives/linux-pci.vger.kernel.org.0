Return-Path: <linux-pci+bounces-10251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5298493126D
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 12:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84DBF1C21341
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 10:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7584218733F;
	Mon, 15 Jul 2024 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j02A0+ku";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lAetZ+uB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j02A0+ku";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lAetZ+uB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB46186E3C;
	Mon, 15 Jul 2024 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039945; cv=none; b=pnhEk6Dlysr/lDQa1wZBBxk6SjPDHlFHJt3+X6s4sgkvOiMa+dXvHnFqVA7WjOPJ84uBUi5oPG00n3SMWSN2PU9BlV1eRFuuUGUvB8B8UNW3PlQMl2RqrbOI4KFQDD5qHYDmwnZl2vhHkYVB7iDf4MJrORcalRcSPbK5R0ofQJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039945; c=relaxed/simple;
	bh=l++LJBD9K/4eZNMGZBHbp+qtFAiVccVccAah2cBZxwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDuPKmFpywXSI6+ajEMaUKe59nHZ3PiZ1i10KNmOyobpZQmO78VpjVSYPAuCD/xu7qgn86BZLmxE2itkvPtKp/VaBgikvjiWeTTqvig3BMiMc5fobKu5FEfhUaXSdmWRK9ovI3EuV5XPSPbtadeAoA6aA3rxm2GtyreDRufS6gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j02A0+ku; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lAetZ+uB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j02A0+ku; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lAetZ+uB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 05FC21F80D;
	Mon, 15 Jul 2024 10:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721039942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQ2txoh+5dL8NFW7j8yrrRJSV9eSjUtpYZCvibuXtlg=;
	b=j02A0+kuapVt26eAhnWphA5g5fdzOF29WHU9ykBhx6YOHt6HAyC10TmYvArQMa0FtvdxDa
	WYt6QBgHg48/p5SHDz+21L21nxlFsDy1a25qTRAi/IVqyi4wZQnMM5FXabynmqmQm+q/ZT
	oMAsP5w/qv8mcEMp2lJafZwstOgy9q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721039942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQ2txoh+5dL8NFW7j8yrrRJSV9eSjUtpYZCvibuXtlg=;
	b=lAetZ+uBJTYprQKP4R1jTDaCVVT4rWE82DbNY7CAF8+sNUKC/d85dBHnyYTTu2H12pWWek
	mx+deRWjR5nEqZDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721039942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQ2txoh+5dL8NFW7j8yrrRJSV9eSjUtpYZCvibuXtlg=;
	b=j02A0+kuapVt26eAhnWphA5g5fdzOF29WHU9ykBhx6YOHt6HAyC10TmYvArQMa0FtvdxDa
	WYt6QBgHg48/p5SHDz+21L21nxlFsDy1a25qTRAi/IVqyi4wZQnMM5FXabynmqmQm+q/ZT
	oMAsP5w/qv8mcEMp2lJafZwstOgy9q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721039942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQ2txoh+5dL8NFW7j8yrrRJSV9eSjUtpYZCvibuXtlg=;
	b=lAetZ+uBJTYprQKP4R1jTDaCVVT4rWE82DbNY7CAF8+sNUKC/d85dBHnyYTTu2H12pWWek
	mx+deRWjR5nEqZDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B5D7137EB;
	Mon, 15 Jul 2024 10:39:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n+I8AEX8lGbvIwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 15 Jul 2024 10:39:01 +0000
Message-ID: <326f51f7-bcb0-4214-ae0e-7dd1d96f5e97@suse.de>
Date: Mon, 15 Jul 2024 13:38:56 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/12] PCI: brcmstb: Refactor for chips with many
 regular inbound BARs
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
 Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240710221630.29561-1-james.quinlan@broadcom.com>
 <20240710221630.29561-10-james.quinlan@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240710221630.29561-10-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,broadcom.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 



On 7/11/24 01:16, Jim Quinlan wrote:
> Previously, our chips provided three inbound "BARS" with fixed purposes:
> the first was for mapping SoC internal registers, the second was for
> memory, and the third was for memory but with the endian swapped.  We
> typically only used one of these BARs.
> 
> Complicating that BARs usage was the fact that the PCIe HW would do a
> baroque internal mapping of system memory, and concatenate the regions of
> multiple memory controllers.
> 
> Newer chips such as the 7712 and Cable Modem SOCs have taken a step forward
> and now provide multiple inbound BARs.  This works in concert with the
> dma-ranges property, where each provided range becomes an inbound BAR.
> 
> This commit provides support for these new chips and their multiple
> inbound BARs but also keeps the legacy support for the older system.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 216 ++++++++++++++++++++------
>  1 file changed, 167 insertions(+), 49 deletions(-)
> 

Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>

~Stan

