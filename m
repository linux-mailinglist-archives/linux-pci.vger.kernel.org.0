Return-Path: <linux-pci+bounces-11908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BE095914E
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 01:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE4428397F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 23:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436D914A4F0;
	Tue, 20 Aug 2024 23:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zBy5xELC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NkzKRrVa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zBy5xELC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NkzKRrVa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7601370;
	Tue, 20 Aug 2024 23:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724197382; cv=none; b=Oct1BqSM6I5MMlvLMvQ/ntfhA1nmcZm7YL/bcAoirnC5ZlwMGBfOE68MDm5zm5/VM1uPzR2vdFHbi4dDLaxdqMQE69yblYINCIuD+M3SFzubGuQIG4ynKmd7IGFDVbMLX4k2xeQ3QMRX2uPKvDvnIZhPG+pdbTctByl4mniQNSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724197382; c=relaxed/simple;
	bh=Q/DxjpiGHH5L3b9f4qm2k7j72gIzmrUT1kkh6CSERm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HpuSnWoIEjlx0klPPyVHF7uLeIBl1oa7PlcCR3nmPBhA6oYaWwvgO4DT8+k2bEmrLd935W9glNVYl4b+XfQ/NbPZ6f1JiNJP1i1M+2EiGbkXoHZH8MhAZp4G23Dh9IxQeWuL3OSVjqL0HGJ+X1O72tmpzYwCD97cAzPbjx02MEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zBy5xELC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NkzKRrVa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zBy5xELC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NkzKRrVa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5026E22355;
	Tue, 20 Aug 2024 23:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724197378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rmj0RDHNlueuNIcIiARHy6t110NKC4+Qv6DdjGfueo4=;
	b=zBy5xELCQwlVacKAucMmzjL6NLnXrHanGWsLqq595wywecYZ4rDWOyX32OfneFjnziBaut
	EwvDqIYGChLr2PQ09SS2tKaqEjDK3VTcIRH4WAhtaj/vq54YGUVnA1aWXP1jaq3MfFj5za
	gLE/XmIKYm1Ve3msAdPGyDmMvbjAczg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724197378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rmj0RDHNlueuNIcIiARHy6t110NKC4+Qv6DdjGfueo4=;
	b=NkzKRrVawVQX6oIRajEdLBQtdjM0kNaRQ5Ln7dfCDF7u2J22KuRoYcD2/fc4pKX1gd9T6Y
	gXQdmneWEC4yQyBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zBy5xELC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NkzKRrVa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724197378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rmj0RDHNlueuNIcIiARHy6t110NKC4+Qv6DdjGfueo4=;
	b=zBy5xELCQwlVacKAucMmzjL6NLnXrHanGWsLqq595wywecYZ4rDWOyX32OfneFjnziBaut
	EwvDqIYGChLr2PQ09SS2tKaqEjDK3VTcIRH4WAhtaj/vq54YGUVnA1aWXP1jaq3MfFj5za
	gLE/XmIKYm1Ve3msAdPGyDmMvbjAczg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724197378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rmj0RDHNlueuNIcIiARHy6t110NKC4+Qv6DdjGfueo4=;
	b=NkzKRrVawVQX6oIRajEdLBQtdjM0kNaRQ5Ln7dfCDF7u2J22KuRoYcD2/fc4pKX1gd9T6Y
	gXQdmneWEC4yQyBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C8FB13A17;
	Tue, 20 Aug 2024 23:42:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id as9KGwEqxWa8NwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 20 Aug 2024 23:42:57 +0000
Message-ID: <87b38984-0a54-4773-ba20-3445d9c9c149@suse.de>
Date: Wed, 21 Aug 2024 02:42:52 +0300
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
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <CA+-6iNykVzd1do=dHDVD3_prJkvfRbA2U-DsLFhSA2S48L_A8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5026E22355
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,google.com,arm.com,debian.org,linaro.org,broadcom.com,gmail.com,linux.com,pengutronix.de,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi Jim,

On 8/20/24 00:49, Jim Quinlan wrote:
> On Mon, Aug 19, 2024 at 3:39 PM Stanimir Varbanov <svarbanov@suse.de> wrote:
>>
>> Hi Jim,
>>
>> On 8/19/24 21:09, Jim Quinlan wrote:
>>> On Sat, Aug 17, 2024 at 1:41 PM Stanimir Varbanov <svarbanov@suse.de> wrote:
>>>>
>>>> Hi Jim,
>>>>
>>>> On 8/16/24 01:57, Jim Quinlan wrote:
>>>>> The 7712 SOC has a bridge reset which can be described in the device tree.
>>>>> Use it if present.  Otherwise, continue to use the legacy method to reset
>>>>> the bridge.
>>>>>
>>>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>>>>> ---
>>>>>  drivers/pci/controller/pcie-brcmstb.c | 24 +++++++++++++++++++-----
>>>>>  1 file changed, 19 insertions(+), 5 deletions(-)
>>>>
>>>> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
>>>>
>>>> One problem though on RPi5 (bcm2712).
>>>>
>>>> With this series applied + my WIP patches for enablement of PCIe on
>>>> bcm2712 when enable the pcie1 and pcie2 root ports in dts, I see kernel
>>>> boot stuck on pcie2 enumeration and I have to add this [1] to make it
>>>> work again.
>>>>
>>>> Some more info about resets used:
>>>>
>>>> pcie0 @ 100000:
>>>>         resets = <&bcm_reset 5>, <&bcm_reset 42>, <&pcie_rescal>;
>>>>         reset-names = "swinit", "bridge", "rescal";
>>>>
>>>> pcie1 @ 110000:
>>>>         resets = <&bcm_reset 7>, <&bcm_reset 43>, <&pcie_rescal>;
>>>>         reset-names = "swinit", "bridge", "rescal";
>>>>
>>>> pcie2 @ 120000:
>>>>         resets = <&bcm_reset 9>, <&bcm_reset 44>, <&pcie_rescal>;
>>>>         reset-names = "swinit", "bridge", "rescal";
>>>>
>>>>
>>>> I changed "swinit" reset for pcie2 to <&bcm_reset 9> (it is 32 in
>>>> downstream rpi kernel) because otherwise I'm unable to enumerate RP1
>>>> south bridge at all.
>>>>
>>>> Any help will be appreciated.
>>>
>>> Hi Stan,
>>> Let me look into this.  Why is one of the controllers turning off --
>>> is it not populated with a device?
>>
>> Yes, I enabled pcie1 but no PCI endpoint devices attached on the
>> expansion connector.
> 
> Hi Stan,
> 
> I looked at our similar STB chip that has a rescal controller and
> multiple PCIe controllers and it doesn't have this problem.  Our 7712
> doesn't  have this problem either, only because it only has one PCIe
> controller.
> 
> However, using my 7712 and unbinding the device (invokes
> brcm_pcie_remove()) shows me behavior similar to yours (2712).  What I
> do is read the rescal registers after the unbind, and they will either
> be dead or alive.  If I comment out the
> "pcie->bridge_sw_init_set(pcie, 1);" call, the rescal is still dead
> after unbind.  However if I comment out that AND the
> "clk_disable_unprepare(pcie->clk);" call,  the rescal registers remain
> alive after unbind.

Thank you. No idea why the clock is not used on 2712 (or at least it is
not populated on RPi downstream kernel.

> 
> Perhaps you don't see the dependence on the PCIe clocks if the 2712
> does not give the PCIe node a clock property and instead keeps its
> clocks on all of the time.  In that case I would think that your
> solution would be fine.

What you mean by my solution? The one where avoiding assert of
bridge_reset at link [1] bellow?

If so, I still cannot understand the relation between bridge_reset and
rescal as the comment mentions:

"Shutting down this bridge on pcie1 means accesses to rescal block will
hang the chip if another RC wants to assert/deassert rescal".

~Stan
> 
> Regards,
> Jim Quinlan
> Broadcom STB/CM
> 
> 
> 
>>
>>>
>>> As you probably know the 7712 only has access to PCIe1.  But we do
>>> have another chip with two controllers and I will try to reproduce
>>> your failure and get to the bottom of it.
>>
>> Thank you for the help.
>>
>> ~Stan
>>
>>>
>>> Regards,
>>> Jim Quinlan
>>> Broadcom STB/CM
>>>>
>>>> ~Stan
>>>>
>>>> [1]
>>>> https://github.com/raspberrypi/linux/blob/rpi-6.11.y/drivers/pci/controller/pcie-brcmstb.c#L1711

