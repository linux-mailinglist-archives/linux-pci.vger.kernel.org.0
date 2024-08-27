Return-Path: <linux-pci+bounces-12280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BB8960A37
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 14:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC822B238C8
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 12:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BC21B5336;
	Tue, 27 Aug 2024 12:28:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC391A0B1D;
	Tue, 27 Aug 2024 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761690; cv=none; b=jCvNDxRSE4hrhD/+gygNaJcIaG96qtKVrWA7KebiI1RnmBKHDf0JermILtacQQ8dmmhlc+osnfNnjLd8fQEEmPx0u/JppQr8G2kvEIVMUDuyBKrL/Qm/jgS6zszDaBMEYBvo+GMFY0MvntErNAQxAprvX6Pqh+BeNdGZ0L5wjxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761690; c=relaxed/simple;
	bh=6fsIWFvAiWEYMCXofaPi8CMMAtphgdXaPI/TiGK15Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mj/umvI9WmjCL9Y04o5N8UFiouMw9e+dlhgmSQvq6iJ2UBYDYRyyrghUsJs73hCMUiFPLZ2znOj1fCyJ5iiXWxl0YF5SQXNiJHfnITwCZ6XVj4BqcDs1wrlfn6oTV5QSMyxv/ajWtnc8ViBLTUU2We6/fOqpHkWOljvlEiUSJ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 556F31FB66;
	Tue, 27 Aug 2024 12:28:06 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4298713A44;
	Tue, 27 Aug 2024 12:28:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QQI1DFXGzWZsYgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 27 Aug 2024 12:28:05 +0000
Message-ID: <9b7cff3f-7d22-4bb5-a56e-11d93bd11456@suse.de>
Date: Tue, 27 Aug 2024 15:27:56 +0300
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
 <3bb5c6db-11d9-4e65-a581-1a7f6945450a@suse.de>
 <CA+-6iNy7souF-BZHV1sBk2nx04LwshB=6amnOixfPPza96RmWw@mail.gmail.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <CA+-6iNy7souF-BZHV1sBk2nx04LwshB=6amnOixfPPza96RmWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 556F31FB66
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Hi Jim,

On 8/26/24 17:17, Jim Quinlan wrote:
> On Mon, Aug 26, 2024 at 6:43 AM Stanimir Varbanov <svarbanov@suse.de> wrote:
>>
>> Hi Jim,
>>
>> <cut>
>>
>>>
>>> Hi Stan,
>>>
>>> Most of the clocks on the STB chips come up active so one does not
>>> have to turn them on and off to have the device function.  It helps
>>> power savings to do this although I'm not sure it is significant.
>>>>
>>>>>
>>>>> Perhaps you don't see the dependence on the PCIe clocks if the 2712
>>>>> does not give the PCIe node a clock property and instead keeps its
>>>>> clocks on all of the time.  In that case I would think that your
>>>>> solution would be fine.
>>>>
>>>> What you mean by my solution? The one where avoiding assert of
>>>> bridge_reset at link [1] bellow?
>>>
>>> Yes.
>>>>
>>>> If so, I still cannot understand the relation between bridge_reset and
>>>> rescal as the comment mentions:
>>>>
>>>> "Shutting down this bridge on pcie1 means accesses to rescal block will
>>>> hang the chip if another RC wants to assert/deassert rescal".
>>>
>>> I was just describing my observations; this should not be happening.
>>> I would say it is a HW bug for the 2712.  I can file a bug against the
>>> 2712 but that will not help us right now.  From what I was told by HW,
>>> asserting the PCIe1 bridge reset does not affect the rescal settings,
>>> but it does freeze access to the rescal registers, and that is game
>>> over for the other PCIe controllers accessing the rescal registers.
>>
>> Good findings, thank you.
>>
>> The problem comes from this snippet from brcm_pcie_probe() :
>>
>>         ret = pci_host_probe(bridge);
>>         if (!ret && !brcm_pcie_link_up(pcie))
>>                 ret = -ENODEV;
>>
>>         if (ret) {
>>                 brcm_pcie_remove(pdev);
>>                 return ret;
>>         }
>>
>> Even when pci_host_probe() is successful the .probe will fail if there
>> are no endpoint devices on this root port bus. This is the case when
>> probing pcie1 port which is the one with external connector. Cause the
>> probe is failing we call reset_control_rearm(rescal) from
>> brcm_pcie_remove(), after that during .probe of pcie2 (the root port
>> where RP1 south-bridge is attached) reset_control_reset(rescal) will
>> issue rescal reset thus rescal-reset driver will stuck on read/write
>> registers.
>>
>> I think we have to drop this link-up check and allow the probe to finish
>> successfully. Even that there no PCI devices attached to bus we want the
>> root port to be visible by lspci tool.
> 
> Hi Stan,
> 
> What is gained by having only the root bridge shown by lspci?  We do
> not support PCIe hotplug so why have lspci reporting a bridge with no
> devices?
> 
> The reason we do this is to save power -- when we see no device we
> turn off the clocks, put things in reset (e.g. bridge), and turn off
> the regulators.  We have SoCs with multiple controllers  and they
> cannot afford to be supplying power to controllers with non-populated
> sockets; these may be products that are trying to conform to mandated
> energy-mode specifications.

I totally agree, although I do not see power consumption significantly
increased. Also I checked all other PCI controller drivers and no one
else doing this.

> 
>  This will solve partially the
>> issue with accessing rescal reset-controller registers after asserting
>> bridge_reset. The other part of the problem will be solved by remove the
>> invocation of reset_control_rearm(rescal) from __brcm_pcie_remove().
>> That way only the first probed root port will issue rescal reset and
>> every next probe will not try to reset rescal because we do not call
>> _rearm(rescal).
> 
> In theory I agree with the above -- it should probably not be invoking
> the rearm() when it is being deactivated.  However, I am concerned
> about a controller(s) going into s2 suspend/resume or unbind/bind.

In fact not calling rearm() from __brcm_pcie_remove() is not enough
because the .probe will fail thus rescal reset will loose it's instance
and next probed pcie root port will issue rescal reset again.

I'd stick with avoiding assert of bridge_reset from brcm_pcie_turn_off()
for now, and this will be true only for bcm2712.

~Stan

