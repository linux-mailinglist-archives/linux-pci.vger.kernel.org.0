Return-Path: <linux-pci+bounces-11609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0782994F950
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 00:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2068F1C221D8
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 22:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE8616DEAB;
	Mon, 12 Aug 2024 22:05:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D238274BE1;
	Mon, 12 Aug 2024 22:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723500326; cv=none; b=kLAjGbBzEwfwUw7XCEzlo7n0AGvbAkOziT8/USLH/kg/tiWho6tHbS4FP1UfsQ2yjvoaJIPgXECWHE5z6oYQNAd2vHufSJOmahnBRdbldt9+T+hs+HlGyeciKsPNqIjIY05N/Jj/ivJ2Zw6vvhNzdM0/F4QbkmYp+dsgbHJp3Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723500326; c=relaxed/simple;
	bh=F5tNJITgW7giTC7rYYdYOLepH5GN4oG/OGtKlfYS81g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZzB3ryMwY7MAwg1ens2ik8URK2/AORtEJ//f1RAEf9EjKkV4dCYbbD2mtf38Q3kX0O5Tk3V0rbBxvMVdarlHKKYijqHrLEnAavVJzjNfNi+/xj4Ic8vw390EUIRe0TatYG3WrgzySUu4527Tojfe4KHuYtK95GpieXt6JETIys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CEA2C2262B;
	Mon, 12 Aug 2024 22:05:22 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E82CD13983;
	Mon, 12 Aug 2024 22:05:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VqkoNiGHumYrEwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 12 Aug 2024 22:05:21 +0000
Message-ID: <11c2adaf-e60c-4690-bd78-af8a0dabc7e8@suse.de>
Date: Tue, 13 Aug 2024 01:05:21 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/12] PCI: brcmstb: Use swinit reset if available
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
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-6-james.quinlan@broadcom.com>
 <57f11aff-95f8-41fd-b35e-a9e5a85c68e3@suse.de>
 <CA+-6iNxd2txYOoeww3yPTPHRvZE_tVT+37Htkq=NUzbtzLkMRA@mail.gmail.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <CA+-6iNxd2txYOoeww3yPTPHRvZE_tVT+37Htkq=NUzbtzLkMRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: CEA2C2262B
X-Spam-Score: -4.00
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Hi,

On 8/12/24 16:43, Jim Quinlan wrote:
> On Fri, Aug 9, 2024 at 5:53 AM Stanimir Varbanov <svarbanov@suse.de> wrote:
>>
>> Hi Jim,
>>
>> On 8/1/24 01:28, Jim Quinlan wrote:
>>> The 7712 SOC adds a software init reset device for the PCIe HW.
>>> If found in the DT node, use it.
>>>
>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>>> ---
>>>  drivers/pci/controller/pcie-brcmstb.c | 19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
>>> index 4d68fe318178..948fd4d176bc 100644
>>> --- a/drivers/pci/controller/pcie-brcmstb.c
>>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>>> @@ -266,6 +266,7 @@ struct brcm_pcie {
>>>       struct reset_control    *rescal;
>>>       struct reset_control    *perst_reset;
>>>       struct reset_control    *bridge_reset;
>>> +     struct reset_control    *swinit_reset;
>>>       int                     num_memc;
>>>       u64                     memc_size[PCIE_BRCM_MAX_MEMC];
>>>       u32                     hw_rev;
>>> @@ -1633,12 +1634,30 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>>>       if (IS_ERR(pcie->bridge_reset))
>>>               return PTR_ERR(pcie->bridge_reset);
>>>
>>> +     pcie->swinit_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "swinit");
>>> +     if (IS_ERR(pcie->swinit_reset))
>>> +             return PTR_ERR(pcie->swinit_reset);
>>> +
>>>       ret = clk_prepare_enable(pcie->clk);
>>>       if (ret)
>>>               return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
>>>
>>>       pcie->bridge_sw_init_set(pcie, 0);
>>>
>>> +     if (pcie->swinit_reset) {
>>> +             ret = reset_control_assert(pcie->swinit_reset);
>>> +             if (dev_err_probe(&pdev->dev, ret, "could not assert reset 'swinit'\n"))
>>> +                     goto clk_disable_unprepare;
>>> +
>>> +             /* HW team recommends 1us for proper sync and propagation of reset */
>>> +             udelay(1);
>>
>> Hmm, shouldn't this delay be part of .assert/.deassert reset_control
>> driver?  I think this detail is reset-control hw specific and the
>> consumers does not need to know it.
> 
> This was discussed previously.  I pointed out that we use a reset

Sorry, I missed that discussion.

> provider that governs dozens of devices.  The only thing that the
> provider could do is to employ a  worst case delay used for all
> resets.  This is unacceptable; we have certain devices that may have
> to invoke
> reset often and require timely action, and we do not want them having
> to wait the same amount of worst case delay as for example, a UART device reset.
> 
> Further, if I do a "grep reset_control_assert -A 10 drivers"  I see
> plenty of existing drivers that use usleep/msleep/udelay after the call to
> reset_control_assert, just as I am doing now.

Yes, I saw them.

> 
> As far as my opinion goes (FWIW) I think the delay is more apt to
> be present in the consumer driver and not the provider driver.  To
> ascertain this specific delay I had to consult with the PCIe HW team,
> not the HW team that implemented the reset controller.
> 

Thank you for the explanation!

~Stan

