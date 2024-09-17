Return-Path: <linux-pci+bounces-13261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC72297AF02
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 12:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10DF1C211D0
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 10:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542F5166F2E;
	Tue, 17 Sep 2024 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xhipkrYI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fEVD+yXa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xhipkrYI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fEVD+yXa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3EC167D80;
	Tue, 17 Sep 2024 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569510; cv=none; b=KP9GAiNAxQZvMFnUrULEHIhoTSmhoWHPpEeDYJvfX4RatH/tZlpbx3ObSkSDHj8jJX6D00boptSL4sQsTgq6lPiR/QgSNIOy+9j5VwHgOmWuwI7ZUz6ZUjLLnvqyGKYJbhX/OUH7MeTwXOgjoS1RQrPLv5RZiTH9TtmsFdO4IT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569510; c=relaxed/simple;
	bh=HK4+QNzXimHDKGKcXLPgnls982dRYEHQ+jlHNA1CDcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePqCSnckA0ORhQeCHSid0MhGs0DmUC7Suio13AIQ0I6nDc087HQZFWdIOUwbgZeIT+ZF93jy8uzuDhdiX8djPy6g5cButo8IEva9TDY33mnRD8zdDihNfRvspWhv+G17WiN1MXpSoMsHCo674c+TwTpusNhbUKAJ7Qz6oC2o1Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xhipkrYI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fEVD+yXa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xhipkrYI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fEVD+yXa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1471E22143;
	Tue, 17 Sep 2024 10:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726569506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEoiY9zcBK/RWEUmYqIt2Lvhk8rkyIaVp9adytOJcfk=;
	b=xhipkrYI/SV+DF5pJ6kLzS7FHPF+T9JKzNC3bI1juA5Wa4MMgWGuKZuenAF1UXxMfyGpcA
	aVf4RZNTAnOVtD1IxcCTItx8t0saXih4Rl7FDBUcnBgzDL8qvozUmRRmiiuqGqzSrDnp5w
	l9gbDTT2KCm/uOAg6ulSfQ/+Grwx3J8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726569506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEoiY9zcBK/RWEUmYqIt2Lvhk8rkyIaVp9adytOJcfk=;
	b=fEVD+yXaWvdc1uQdMxiGja6+dqCsIu2z2q0sC67/sqFxOWUSoMUwEVzS3rXZ3yaltRVZUZ
	7nw5hrbzJO8xa7CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xhipkrYI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fEVD+yXa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726569506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEoiY9zcBK/RWEUmYqIt2Lvhk8rkyIaVp9adytOJcfk=;
	b=xhipkrYI/SV+DF5pJ6kLzS7FHPF+T9JKzNC3bI1juA5Wa4MMgWGuKZuenAF1UXxMfyGpcA
	aVf4RZNTAnOVtD1IxcCTItx8t0saXih4Rl7FDBUcnBgzDL8qvozUmRRmiiuqGqzSrDnp5w
	l9gbDTT2KCm/uOAg6ulSfQ/+Grwx3J8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726569506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEoiY9zcBK/RWEUmYqIt2Lvhk8rkyIaVp9adytOJcfk=;
	b=fEVD+yXaWvdc1uQdMxiGja6+dqCsIu2z2q0sC67/sqFxOWUSoMUwEVzS3rXZ3yaltRVZUZ
	7nw5hrbzJO8xa7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2327B139CE;
	Tue, 17 Sep 2024 10:38:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qid3AiFc6WbIeQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 17 Sep 2024 10:38:25 +0000
Message-ID: <7d8b4fc0-0b62-474d-8cff-12291b62a62d@suse.de>
Date: Tue, 17 Sep 2024 13:38:16 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next 04/11] PCI: brcmstb: Expand inbound size
 calculation helper
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20240910151845.17308-1-svarbanov@suse.de>
 <20240910151845.17308-5-svarbanov@suse.de>
 <1bc838ab-509a-4501-a141-35c1000f5f49@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <1bc838ab-509a-4501-a141-35c1000f5f49@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1471E22143
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 



On 9/10/24 19:59, Florian Fainelli wrote:
> On 9/10/24 08:18, Stanimir Varbanov wrote:
>> Expand the inbound size calculation in helper function
>> up to 64GB.
> 
> Nit, we could explain why, which is that BCM2712's memory map supports
> up to 64GB of DRAM. With that:

Sure.

> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thank you!

regards,
~Stan

