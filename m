Return-Path: <linux-pci+bounces-12196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D04EA95EEB1
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 12:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A471F23170
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 10:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A21714A4D9;
	Mon, 26 Aug 2024 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r9Ikr3Ct";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BAxxJn6a";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r9Ikr3Ct";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BAxxJn6a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60328149E1A;
	Mon, 26 Aug 2024 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724668984; cv=none; b=cr+J7tjkxjAcuI/02aq4z2SB5qObObdMsTeHkGwVVRrwR2ERFBF1decMAD0aB7Ks0MFa0itMBvfgUeIH5YytZWNWqBWJQdzqqXKQvhYCXA9FbTw1lADQxziqoOtKVsWD9XY4V2OlvCb7k99xfm+qnPbX7APGgPYEILXd9BMmTCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724668984; c=relaxed/simple;
	bh=1brX3O7x4wkvzi0J22DQwcBg4eRs8a8tbYnzdpvAW6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpNEgpQ4ahAOlXzIPJFawhXBDS9xIEi0xZQR+Bjg/XUvpmBigT+g0T1om0SiBcUIbBXyHsI8RC0ovWdd0/PKUIs6y8Fs95A/NuBcOMQzzjvIFutGpgyVxo7mqFn/jUgsWpQm37WsdYPSsyRb8EzXwt7EkB+Xfr3ha7jGcd5hwc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r9Ikr3Ct; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BAxxJn6a; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r9Ikr3Ct; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BAxxJn6a; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 79D571F84E;
	Mon, 26 Aug 2024 10:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724668981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8o4dfymYY/wib3L9jCOJLwWWj+pNHwBE6TGr3wDvdME=;
	b=r9Ikr3CtvlxgOUbCPsfQeCAbOIBv38TZPe1XteitqhFoxmQFbd7aY8yAqEbCEEh2xRsqdn
	XjBdeutawKH9OAHU24L0HCpbEsVig3SnmX4zEqQv2ePmulPDNQEUXOxOYhXmVBJ8ls79cA
	gXnn6AF9qisy5csGzxngcARJn+/5Lms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724668981;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8o4dfymYY/wib3L9jCOJLwWWj+pNHwBE6TGr3wDvdME=;
	b=BAxxJn6acrcSse7W9zFjVxOgvP07ZnpIBhIEIAT6a9MoK7oeO65KrSPjWVYXjcrbysp7Qs
	3Z94xHXKroT5a6Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r9Ikr3Ct;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BAxxJn6a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724668981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8o4dfymYY/wib3L9jCOJLwWWj+pNHwBE6TGr3wDvdME=;
	b=r9Ikr3CtvlxgOUbCPsfQeCAbOIBv38TZPe1XteitqhFoxmQFbd7aY8yAqEbCEEh2xRsqdn
	XjBdeutawKH9OAHU24L0HCpbEsVig3SnmX4zEqQv2ePmulPDNQEUXOxOYhXmVBJ8ls79cA
	gXnn6AF9qisy5csGzxngcARJn+/5Lms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724668981;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8o4dfymYY/wib3L9jCOJLwWWj+pNHwBE6TGr3wDvdME=;
	b=BAxxJn6acrcSse7W9zFjVxOgvP07ZnpIBhIEIAT6a9MoK7oeO65KrSPjWVYXjcrbysp7Qs
	3Z94xHXKroT5a6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8378C13724;
	Mon, 26 Aug 2024 10:43:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2UOBHTRczGaJCAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 26 Aug 2024 10:43:00 +0000
Message-ID: <3bb5c6db-11d9-4e65-a581-1a7f6945450a@suse.de>
Date: Mon, 26 Aug 2024 13:42:59 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/13] PCI: brcmstb: Use bridge reset if available
To: Jim Quinlan <james.quinlan@broadcom.com>,
 Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
 <20240815225731.40276-6-james.quinlan@broadcom.com>
 <1a6d6972-f2db-4d44-b79c-811ba44368f0@suse.de>
 <CA+-6iNxFotwXW4Cc31daT+KwE_LEdAR=pcpsg_3Ng0ep1vYLBA@mail.gmail.com>
 <76b528f8-88e2-4954-94cf-7e0933b4ad03@suse.de>
 <CA+-6iNykVzd1do=dHDVD3_prJkvfRbA2U-DsLFhSA2S48L_A8A@mail.gmail.com>
 <87b38984-0a54-4773-ba20-3445d9c9c149@suse.de>
 <CA+-6iNwJZ+OfYaCBBx04-hO1FmpDE36uJWd1jYvaVs_o4iwWqA@mail.gmail.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <CA+-6iNwJZ+OfYaCBBx04-hO1FmpDE36uJWd1jYvaVs_o4iwWqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 79D571F84E
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,google.com,arm.com,debian.org,linaro.org,broadcom.com,gmail.com,linux.com,pengutronix.de,lists.infradead.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi Jim,

<cut>

> 
> Hi Stan,
> 
> Most of the clocks on the STB chips come up active so one does not
> have to turn them on and off to have the device function.  It helps
> power savings to do this although I'm not sure it is significant.
>>
>>>
>>> Perhaps you don't see the dependence on the PCIe clocks if the 2712
>>> does not give the PCIe node a clock property and instead keeps its
>>> clocks on all of the time.  In that case I would think that your
>>> solution would be fine.
>>
>> What you mean by my solution? The one where avoiding assert of
>> bridge_reset at link [1] bellow?
> 
> Yes.
>>
>> If so, I still cannot understand the relation between bridge_reset and
>> rescal as the comment mentions:
>>
>> "Shutting down this bridge on pcie1 means accesses to rescal block will
>> hang the chip if another RC wants to assert/deassert rescal".
> 
> I was just describing my observations; this should not be happening.
> I would say it is a HW bug for the 2712.  I can file a bug against the
> 2712 but that will not help us right now.  From what I was told by HW,
> asserting the PCIe1 bridge reset does not affect the rescal settings,
> but it does freeze access to the rescal registers, and that is game
> over for the other PCIe controllers accessing the rescal registers.

Good findings, thank you.

The problem comes from this snippet from brcm_pcie_probe() :

	ret = pci_host_probe(bridge);
	if (!ret && !brcm_pcie_link_up(pcie))
		ret = -ENODEV;

	if (ret) {
		brcm_pcie_remove(pdev);
		return ret;
	}

Even when pci_host_probe() is successful the .probe will fail if there
are no endpoint devices on this root port bus. This is the case when
probing pcie1 port which is the one with external connector. Cause the
probe is failing we call reset_control_rearm(rescal) from
brcm_pcie_remove(), after that during .probe of pcie2 (the root port
where RP1 south-bridge is attached) reset_control_reset(rescal) will
issue rescal reset thus rescal-reset driver will stuck on read/write
registers.

I think we have to drop this link-up check and allow the probe to finish
successfully. Even that there no PCI devices attached to bus we want the
root port to be visible by lspci tool. This will solve partially the
issue with accessing rescal reset-controller registers after asserting
bridge_reset. The other part of the problem will be solved by remove the
invocation of reset_control_rearm(rescal) from __brcm_pcie_remove().
That way only the first probed root port will issue rescal reset and
every next probe will not try to reset rescal because we do not call
_rearm(rescal).

What do you think?

~Stan

