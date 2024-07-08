Return-Path: <linux-pci+bounces-9923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A18992A0C9
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 13:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D25C1C20EB4
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 11:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141996F2FB;
	Mon,  8 Jul 2024 11:14:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63998482DE;
	Mon,  8 Jul 2024 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437267; cv=none; b=q/OedEgOIYtooHJr/JcDNJYRElDWAgCtXxpey21GuLrM8oNmtLy7Ow9zFIhL4n2hz2CBc1DY2BgBl5uRdmzMSf1WToSjiuALbXNQjwADiuqvuJGC/I756mqp3J4O8v/Y6D7F0V+/M31KVNqhU62/r6DdTb5y7p/r5EDpu6sJzHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437267; c=relaxed/simple;
	bh=LhPjovSVZgqmN9GfmU1S+wlhD8gvlbotPiGGcn0WHgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azMSPW43k9wbEpJZhgb3pOFgREHrq15DBE9EkEu3zxrBOyeDV4NiTjtSqFWF2NrweemvYbX+yeC+fIw9fHEaJN4jhDwnzyEQP5h94juJf0HgXCgL2J1UAUpyfz89SnmB4Xd7bg2e85hTcvqhQ4B+JRmz47SOsgyaVR7TiVHfQb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A86D71FC0D;
	Mon,  8 Jul 2024 11:14:23 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6EB01396E;
	Mon,  8 Jul 2024 11:14:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EiMJNg7Ki2YXWAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 08 Jul 2024 11:14:22 +0000
Message-ID: <f89d7f45-5d2b-4d8b-9d6a-2d83cd584756@suse.de>
Date: Mon, 8 Jul 2024 14:14:18 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] PCI: brcmstb: Use swinit reset if available
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Jim Quinlan <james.quinlan@broadcom.com>,
 Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com,
 jim2101024@gmail.com, Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240703180300.42959-1-james.quinlan@broadcom.com>
 <20240703180300.42959-5-james.quinlan@broadcom.com>
 <362a728f-5487-47da-b7b9-a9220b27d567@suse.de>
 <CA+-6iNynwxcBAbRQ18TfJXwCctf+Ok7DnFyjgv4wNasX9MjV1Q@mail.gmail.com>
 <7b03c38f44f295a5484d0162a193f41b39039b85.camel@pengutronix.de>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <7b03c38f44f295a5484d0162a193f41b39039b85.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: A86D71FC0D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hi Philipp,

On 7/8/24 12:37, Philipp Zabel wrote:
> On Fr, 2024-07-05 at 13:46 -0400, Jim Quinlan wrote:
>> On Thu, Jul 4, 2024 at 8:56 AM Stanimir Varbanov <svarbanov@suse.de> wrote:
>>>
>>> Hi Jim,
>>>
>>> On 7/3/24 21:02, Jim Quinlan wrote:
>>>> The 7712 SOC adds a software init reset device for the PCIe HW.
>>>> If found in the DT node, use it.
>>>>
>>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>>>> ---
>>>>  drivers/pci/controller/pcie-brcmstb.c | 19 +++++++++++++++++++
>>>>  1 file changed, 19 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
>>>> index 4104c3668fdb..69926ee5c961 100644
>>>> --- a/drivers/pci/controller/pcie-brcmstb.c
>>>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>>>> @@ -266,6 +266,7 @@ struct brcm_pcie {
>>>>       struct reset_control    *rescal;
>>>>       struct reset_control    *perst_reset;
>>>>       struct reset_control    *bridge;
>>>> +     struct reset_control    *swinit;
>>>>       int                     num_memc;
>>>>       u64                     memc_size[PCIE_BRCM_MAX_MEMC];
>>>>       u32                     hw_rev;
>>>> @@ -1626,6 +1627,13 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>>>>               dev_err(&pdev->dev, "could not enable clock\n");
>>>>               return ret;
>>>>       }
>>>> +
>>>> +     pcie->swinit = devm_reset_control_get_optional_exclusive(&pdev->dev, "swinit");
>>>> +     if (IS_ERR(pcie->swinit)) {
>>>> +             ret = dev_err_probe(&pdev->dev, PTR_ERR(pcie->swinit),
>>>> +                                 "failed to get 'swinit' reset\n");
>>>> +             goto clk_out;
>>>> +     }
>>>>       pcie->rescal = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
>>>>       if (IS_ERR(pcie->rescal)) {
>>>>               ret = PTR_ERR(pcie->rescal);
>>>> @@ -1637,6 +1645,17 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>>>>               goto clk_out;
>>>>       }
>>>>
>>>> +     ret = reset_control_assert(pcie->swinit);
>>>> +     if (ret) {
>>>> +             dev_err_probe(&pdev->dev, ret, "could not assert reset 'swinit'\n");
>>>> +             goto clk_out;
>>>> +     }
>>>> +     ret = reset_control_deassert(pcie->swinit);
>>>> +     if (ret) {
>>>> +             dev_err(&pdev->dev, "could not de-assert reset 'swinit' after asserting\n");
>>>> +             goto clk_out;
>>>> +     }
>>>
>>> why not call reset_control_reset(pcie->swinit) directly?
>> Hi Stan,
>>
>> There is no reset_control_reset() method defined for reset-brcmstb.c.
>> The only reason I can
>> think of for this is that it allows the callers of assert/deassert to
>> insert a delay if desired.
> 
> The main reason for the existence of reset_control_reset() is that
> there are reset controllers that can only be triggered (e.g. by writing
> a bit to a self-clearing register) to produce a complete reset pulse,
> with assertion, delay, and deassertion all handled by the reset
> controller.


Got it. Thank you for explanation.

But, IMO that means that the consumer driver should have knowledge of
low-level reset implementation, which is not generic API?

Otherwise, I don't see a problem to implement asset/deassert sequence in
.reset op in this particular reset-brcmstb.c low-level driver.


~Stan

