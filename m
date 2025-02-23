Return-Path: <linux-pci+bounces-22130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9CCA40DEF
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2025 10:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1903B32F7
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2025 09:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BFD2036F0;
	Sun, 23 Feb 2025 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kSM0pZ34";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ghUcU/02";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kSM0pZ34";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ghUcU/02"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E13B202F60
	for <linux-pci@vger.kernel.org>; Sun, 23 Feb 2025 09:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740304743; cv=none; b=a8XfBJ8BhPbUQLZE/Mpp+fCPL9M7JG/gZ4KuLM1USZkuL+X9MIW9pB1ykM9wRrULJre5AbXaqWIh6EFZwPLzmEfNMagakCDggYKXL73UjjVy4KLXAIbMjeK+q9CaOatn4wOj73A80DV38oQ8i9l5eYKRTzCYmrR1Q3jHnCKaH4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740304743; c=relaxed/simple;
	bh=pKC3dcYZIR0rXYEMwqV3sLDFy7eQVXIaPlj4KXkyoxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LflXhJ6BP12hrdE4RnKzhhK5ngO185y0w47VYCt/dS/5+wzGHIJEHF5JriT1ghGSU/5+wdzudzphMvnBRzYsuyszEiXVpFj1h/iIR8ahF1GWbdp9bIoWzeuDoJ6t6MnpUrjIzAqWdmWZE5uzUnhS7wI23dF8eZPm+u0Z5m99jT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kSM0pZ34; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ghUcU/02; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kSM0pZ34; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ghUcU/02; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 02F722117A;
	Sun, 23 Feb 2025 09:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740304740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O07FM6hcpxOdydLw/5SoLU5xXndwpJbzAa2kj+R8kQY=;
	b=kSM0pZ344Cw9eVd+6G4n7Buoo5uufHhnOeY0eTfbZBjT90tZqHKkwVhLxXl/x0bcu2Ioao
	kUtmP8MXgSUHzn7TRCqzUpupKgtSidsiADPYAwHnUwk+s9hDe3puOHOTMFFLahM1Y4u8Cp
	Imx41wBiOGoEzUrAKgH9v/UfqIijJ78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740304740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O07FM6hcpxOdydLw/5SoLU5xXndwpJbzAa2kj+R8kQY=;
	b=ghUcU/02amKuIXnLMYsiFOqjsIWhK96myETomxMpMAldpEpbhEbMM6txTDfRJRC2ce5Nik
	uw/fLhZmaKex4ZBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kSM0pZ34;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="ghUcU/02"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740304740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O07FM6hcpxOdydLw/5SoLU5xXndwpJbzAa2kj+R8kQY=;
	b=kSM0pZ344Cw9eVd+6G4n7Buoo5uufHhnOeY0eTfbZBjT90tZqHKkwVhLxXl/x0bcu2Ioao
	kUtmP8MXgSUHzn7TRCqzUpupKgtSidsiADPYAwHnUwk+s9hDe3puOHOTMFFLahM1Y4u8Cp
	Imx41wBiOGoEzUrAKgH9v/UfqIijJ78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740304740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O07FM6hcpxOdydLw/5SoLU5xXndwpJbzAa2kj+R8kQY=;
	b=ghUcU/02amKuIXnLMYsiFOqjsIWhK96myETomxMpMAldpEpbhEbMM6txTDfRJRC2ce5Nik
	uw/fLhZmaKex4ZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB3EC13A42;
	Sun, 23 Feb 2025 09:58:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wTugMmLxumegDAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Sun, 23 Feb 2025 09:58:58 +0000
Message-ID: <f224ec07-cdd9-4f07-a1c6-985202c57f82@suse.de>
Date: Sun, 23 Feb 2025 11:58:54 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 -next 08/11] PCI: brcmstb: Adding a softdep to MIP
 MSI-X driver
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
References: <20250221214035.GA362971@bhelgaas>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20250221214035.GA362971@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 02F722117A
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,broadcom.com,linutronix.de,kernel.org,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Hi Bjorn,

On 2/21/25 11:40 PM, Bjorn Helgaas wrote:
> On Mon, Jan 20, 2025 at 03:01:16PM +0200, Stanimir Varbanov wrote:
>> In case brcmstb PCIe driver and MIP MSI-X interrupt controller
>> drivers are built as modules there could be a race in probing.
>> To avoid this add a softdep to MIP driver to guarantee that MIP
>> driver will be load first.
> 
> Maybe this one too?  Should this be moved to after the irq_bcm2712_mip
> driver is added, but before brcmstb will claim bcm2712?  I just want
> to avoid bisection problems when possible, and it sounds like if we
> lose the race, interrupts might not work as expected?

Makes sense, thank you.

~Stan

