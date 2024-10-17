Return-Path: <linux-pci+bounces-14753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 209DC9A1CA1
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 10:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98DAE1F27072
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 08:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A641D54CD;
	Thu, 17 Oct 2024 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x3bnnhDL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wsQbUOwu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x3bnnhDL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wsQbUOwu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B0D1D278C;
	Thu, 17 Oct 2024 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152488; cv=none; b=ohmjhWXOe17t3utI6TezjuOgnYC1Thwgcca9Bw0Z/Q4fkVwWpTxwXAS+L6qLED0lSDMZ9cFqWIfJNWeO1XhY90sb9TevhOfFrrbPW9ifx0nuSumhHlAztx1iJCQBaJMKc9SDuutQL1NcSdwRh4nuO9BAtVGOUa6Pr+VYEfr67bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152488; c=relaxed/simple;
	bh=VqSFhgjvlu0CR53lYQpvXeqsmZtIl6reGOEgFZLzM7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Toi+dSFEznm/CbytB3P5XPRPYI0hX4qHmwIR0C3UHFimSvSRf7RgTIWf5c8Cb9DxGfpMo60PiLX/ROWDTyz64irgcrmg8lUSBqd6vECIAS+GFyaqmpponvFe4MA+7pftVnLP1I4LjhMmhgSFOuvhxvi/EDlIrE/GxgvU6/S67jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x3bnnhDL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wsQbUOwu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x3bnnhDL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wsQbUOwu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A32D01F840;
	Thu, 17 Oct 2024 08:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729152484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+bQbRnEie539ppAEs2KMPsVklAOelINjEuLtY5fZeTQ=;
	b=x3bnnhDLgCNNFepBQUact6FIRBNU7g0HOmhFfq5ulMBPSVYOmUZ/SAblt5ggqTBADA0x1H
	nEg528j/rDF1+D+NdMrtmKhzYLE+bPNN+fx/JEMYFxVHJ9vuHgUEnVr52BeJiztdRFRjfU
	nfRPVg01PUtshneQpfTRl9466TV/Iw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729152484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+bQbRnEie539ppAEs2KMPsVklAOelINjEuLtY5fZeTQ=;
	b=wsQbUOwuSN2Dro6IXED8gf2ejv7BDiwe4CwoNDVrA4Vf9ptCbReEfHboyEM21T4RCp8zRr
	3+HGXwUPlMOP/XAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729152484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+bQbRnEie539ppAEs2KMPsVklAOelINjEuLtY5fZeTQ=;
	b=x3bnnhDLgCNNFepBQUact6FIRBNU7g0HOmhFfq5ulMBPSVYOmUZ/SAblt5ggqTBADA0x1H
	nEg528j/rDF1+D+NdMrtmKhzYLE+bPNN+fx/JEMYFxVHJ9vuHgUEnVr52BeJiztdRFRjfU
	nfRPVg01PUtshneQpfTRl9466TV/Iw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729152484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+bQbRnEie539ppAEs2KMPsVklAOelINjEuLtY5fZeTQ=;
	b=wsQbUOwuSN2Dro6IXED8gf2ejv7BDiwe4CwoNDVrA4Vf9ptCbReEfHboyEM21T4RCp8zRr
	3+HGXwUPlMOP/XAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9217913A53;
	Thu, 17 Oct 2024 08:08:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TGjoIOPFEGfvMQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 17 Oct 2024 08:08:03 +0000
Message-ID: <f44850c7-9afe-4340-abae-c8c59116599a@suse.de>
Date: Thu, 17 Oct 2024 11:07:55 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/11] PCI: brcmstb: Avoid turn off of bridge reset
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner
 <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20241014170105.GA611115@bhelgaas>
 <b8616563-22e9-4c20-8bf7-0f51f303b3c7@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <b8616563-22e9-4c20-8bf7-0f51f303b3c7@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,broadcom.com,linutronix.de,kernel.org,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Hi,

On 10/14/24 20:02, Florian Fainelli wrote:
> On 10/14/24 10:01, Bjorn Helgaas wrote:
>> On Mon, Oct 14, 2024 at 04:07:05PM +0300, Stanimir Varbanov wrote:
>>> On PCIe turn off avoid shutdown of bridge reset,
>>> by introducing a quirk flag.
>>
>> Can you include something here about *why* we need this change?  I
>> think the RESCAL comment below would be a good start.
>>
>> I think this should be squashed with the next commit that adds the use
>> of CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN.  Otherwise this commit doesn't
>> have an obvious reason.
> 
> Agreed.

OK, will do. Thank you for the review!

~Stan

