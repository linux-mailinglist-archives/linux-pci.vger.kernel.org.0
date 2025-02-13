Return-Path: <linux-pci+bounces-21333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ECBA33A2E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 09:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A07188CDB3
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 08:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C71F20C469;
	Thu, 13 Feb 2025 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MsTGk3Dv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="brnM1jO4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MsTGk3Dv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="brnM1jO4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF9720C025;
	Thu, 13 Feb 2025 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739435909; cv=none; b=HzjLgXux2C6LI1hxBAbYuSzl6vLOkmW7XvFIGQdYVSl6geRfaABAwCcChytcUYg751ncQyE4P9mQDFzCRUVvp+eL7WSJduq/4VWoK8KvKzZH0jwN2feO6bBb8OQRnmylB3+RHcKqGEKGoAG+OkUNdVmV5x5IsRfsrZBMQxisZ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739435909; c=relaxed/simple;
	bh=HJpCxvhCY2DXuslYs2erMx1LynYtSqN+doSESQr/4a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FnSlHQN+p7eKA+IyOZjvEWZQQpH1H9rYERF6I69bFEq/pr6Qyzv1MzZhhs8EFETJYrohjdBwcD+2ym3t8KKKgSj5pjPYvAqOiLDqbJRcrvirOghpHGvamCvzKhkQ3EHM0LvnUPNZGYUfe6lTku+0NrxbDEpd1ApUe3ZYV9Q/vGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MsTGk3Dv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=brnM1jO4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MsTGk3Dv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=brnM1jO4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9CBD7220A7;
	Thu, 13 Feb 2025 08:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739435905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otOkzlJsKO7j/ah8zQ5Pm/e4WJCfWL+ivuU6UE+K9H4=;
	b=MsTGk3DvD05bVUFG2ykkdN4zNunbEDORKol2WEknEyOpVttQqeQLHazm69GChvn4YAs+ph
	Rhv3hQFewhKiHj1SM9Z9RMIqg/PvwsFfPOwDmoav7gHqQ3AF4TzlAPAl0t06lffN3Egw2V
	jjC4cOeOEcWCc/mNEvjOfixBYYCfEFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739435905;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otOkzlJsKO7j/ah8zQ5Pm/e4WJCfWL+ivuU6UE+K9H4=;
	b=brnM1jO4Ql8tmRw87+2n05FTeQU4ou6FHbMvtINPsyTN7mtOfCR0zvlhYCm3vrv2d646t9
	nS38fHLQOUjIWRDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739435905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otOkzlJsKO7j/ah8zQ5Pm/e4WJCfWL+ivuU6UE+K9H4=;
	b=MsTGk3DvD05bVUFG2ykkdN4zNunbEDORKol2WEknEyOpVttQqeQLHazm69GChvn4YAs+ph
	Rhv3hQFewhKiHj1SM9Z9RMIqg/PvwsFfPOwDmoav7gHqQ3AF4TzlAPAl0t06lffN3Egw2V
	jjC4cOeOEcWCc/mNEvjOfixBYYCfEFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739435905;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otOkzlJsKO7j/ah8zQ5Pm/e4WJCfWL+ivuU6UE+K9H4=;
	b=brnM1jO4Ql8tmRw87+2n05FTeQU4ou6FHbMvtINPsyTN7mtOfCR0zvlhYCm3vrv2d646t9
	nS38fHLQOUjIWRDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E7E9137DB;
	Thu, 13 Feb 2025 08:38:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1257EICvrWeybwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 13 Feb 2025 08:38:24 +0000
Message-ID: <1ff57101-9aa4-4508-b5e5-3f34a89888d8@suse.de>
Date: Thu, 13 Feb 2025 10:38:08 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 -next 00/11] Add PCIe support for bcm2712
To: Bjorn Helgaas <helgaas@kernel.org>, Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250212180416.GA86064@bhelgaas>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20250212180416.GA86064@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,broadcom.com,google.com,linutronix.de,kernel.org,gmail.com,linux.com,pengutronix.de,suse.com,raspberrypi.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Hi Bjorn,

On 2/12/25 8:04 PM, Bjorn Helgaas wrote:
> On Tue, Feb 11, 2025 at 03:30:22PM +0200, Stanimir Varbanov wrote:
>> Hi Bjorn,
>>
>> Do I need to send a new version with the collected Acked/Reviewed tags?
> 
> No need to resend unless you change the code.

At this point I have no plans to change the code.

> 
> Bjorn

Thank you!

~Stan


