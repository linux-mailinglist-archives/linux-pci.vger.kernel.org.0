Return-Path: <linux-pci+bounces-22129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3876EA40DC7
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2025 10:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A097A3B13FD
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2025 09:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949971FCFE6;
	Sun, 23 Feb 2025 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kJLbt2Js";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xsxgmOz/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fo/IjFYR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zsjMbEHO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34941FE463
	for <linux-pci@vger.kernel.org>; Sun, 23 Feb 2025 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740304253; cv=none; b=knKibSLcNmf0Xc4KAJgBZ7R8Mk3H0ByNKTryrrsSY0xb4rAF7pirOViqz0jYO8LPs/I7+D0BFvZ85QHSNG/3DcyX3pNEhk2BO0ALd9sC2A1yWE1i5/Z5IYY1HdBePkMy4kPjuQ7iECnkbuq4DhK71hn//v0j3yACLKU7u4lL6XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740304253; c=relaxed/simple;
	bh=T9pnBacHbZ6P1TFzHIAAhpyq5oJlCwPOvblWHdk1Yhs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BbUPbEjJRDSjgQwNvlgURERGOtIBm6s6N9aKhmdW04gvEMM4ungJkjCNRHh05xy4G8iAlEjNxSpCJyvp7ZAo5lrTG3iejiVBQEJ+wvbe7SwzjNab9E6vGkTOfqIXfL1JPQKRYR5CDrBJzfJmOpDn9WJAZVnjs/b2NcXFm/cInIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kJLbt2Js; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xsxgmOz/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fo/IjFYR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zsjMbEHO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E5E7D1F37E;
	Sun, 23 Feb 2025 09:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740304250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=djse259YTnhDms5McSAmpRcrWC+2iQCSXuUmQU1/lDo=;
	b=kJLbt2JsMqy8skemnQUIO3cn2f38jvDaXfV2zZoUuTt8Et2JJ1lFffHiCBaPRTwFdwUB8v
	AjX9v53rfiQ3JK9F4BXnhH9RBZj9N0STMpHFeLllI3mLExqnGkmjnoIKS9otK93jG+ogQp
	hYFtpwV+N0f3lNU3Q56oFLFO1Vd0UtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740304250;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=djse259YTnhDms5McSAmpRcrWC+2iQCSXuUmQU1/lDo=;
	b=xsxgmOz/UaN6Bp3jyOFIvTswSpdb1CXE5hw4JAUPnzWQEaufLDK/sK5+wVvunA23rKANoc
	AzT6KYTOFmfaOwBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740304249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=djse259YTnhDms5McSAmpRcrWC+2iQCSXuUmQU1/lDo=;
	b=fo/IjFYRrNwTS0Gs2LfcRHQMN1T7cnM4/leNUw61kEhw6Xxma7lUENxYFKe1U5PZHT57P4
	XWxHU5KCCafomZu8T0m37mHCaloESNPpjpmqae/lUFuW+0SG8IAoCkq4pcoEFMiklIT+ln
	Ik/CYPWf9JjsRZnALOfZWChoZZA9vR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740304249;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=djse259YTnhDms5McSAmpRcrWC+2iQCSXuUmQU1/lDo=;
	b=zsjMbEHOSR2EljAZ369HEjeCvKDF/L1YBLsjWaAKN45tfUO5t5PC9hUVQb3E0LLY2CwpMR
	eao2x1pkLzG2JNAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8A2213A42;
	Sun, 23 Feb 2025 09:50:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2RQULnjvumfFCgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Sun, 23 Feb 2025 09:50:48 +0000
Message-ID: <e6dc990a-81bb-4185-848e-4202aa7bb839@suse.de>
Date: Sun, 23 Feb 2025 11:50:48 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Stanimir Varbanov <svarbanov@suse.de>
Subject: Re: [PATCH v5 -next 07/11] PCI: brcmstb: Adjust PHY PLL setup to use
 a 54MHz input refclk
To: Bjorn Helgaas <helgaas@kernel.org>, Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner
 <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250221213311.GA362736@bhelgaas>
Content-Language: en-US
In-Reply-To: <20250221213311.GA362736@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,broadcom.com,linutronix.de,kernel.org,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Hi Bjorn,

On 2/21/25 11:33 PM, Bjorn Helgaas wrote:
> On Mon, Jan 20, 2025 at 03:01:15PM +0200, Stanimir Varbanov wrote:
>> The default input reference clock for the PHY PLL is 100Mhz, except for
>> some devices where it is 54Mhz like bcm2712C1 and bcm2712D0.
>>
>> To implement this adjustments introduce a new .post_setup op in
>> pcie_cfg_data and call it at the end of brcm_pcie_setup function.
>>
>> The bcm2712 .post_setup callback implements the required MDIO writes that
>> switch the PLL refclk and also change PHY PM clock period.
>>
>> Without this RPi5 PCIex1 is unable to enumerate endpoint devices on
>> the expansion connector.
> 
> This makes it sound like this patch should be reordered before "[PATCH
> v5 -next 06/11] PCI: brcmstb: Add bcm2712 support".
> 
> We don't really want a driver to claim a bcm2712 controller before
> it's able to enumerate devices, because that would break bisection
> through this.

I absolutely agree with you in regards to bisect-ability. But to satisfy
this I have to squash "Adjust PHY PLL ..." into "PCI: brcmstb: Add
bcm2712 support" to avoid a warning about not used function. If that
works I'll send a new rebased controller/brcmstb version (v6).

~Stan


