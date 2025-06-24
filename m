Return-Path: <linux-pci+bounces-30513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA45AE6A9B
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 17:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3111C27FC9
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 15:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387BC2ECD3E;
	Tue, 24 Jun 2025 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci3fiVp7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A732ECD0F
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777719; cv=none; b=pnXP1SGtGlzat/QYRAFNRRI3u+wopvca8adneF3VDqMvdVD+hY15TPVuGk2nWbzllDXn9KsIbiFCGu5Ityom/xmqS0aJgbTI39a42MXzb8nKpmgkToIqQIU7ZDJJSVTQEwffz9ORV8WmJfszohfDyXzp8IzHMsUn06zdjeJMjc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777719; c=relaxed/simple;
	bh=uH2AZGtjE58eszZ1WMtgyH4tcUczHVZcdGvJK/Ru9Ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSnuF1Ovvi9BC7Qb1d/FJ8Foy0CxncEA+Xf00pQaUyKCkS0fnO06H3GYvPcV4MWK3txaDbVZL6iLe98n74ELJX30buJyx2zyyBADeMEV+un4kqFGrdmKBw9NiHktaItpP96UbFfgM+PbDYHfRj7TjhjL7Z8PBPrEjEIrLdv0IgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci3fiVp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDD9C4CEF0;
	Tue, 24 Jun 2025 15:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750777718;
	bh=uH2AZGtjE58eszZ1WMtgyH4tcUczHVZcdGvJK/Ru9Ek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ci3fiVp7rYwgsprSSdNG9LeUBHSO4IwgTA9hTNkdq74sbccJPUMd5YJ7Ds9qKG+RD
	 j84REUru0jRKyE8oN45gB0aFV7FBBAZMN2FNiUndLdqejjQ85PUOjGey/4EF6AgrV1
	 Yzj0yErWwAa4e1lmpQuqwygXdwvVCOG6iCvfh4QW5DJJPp5k85OVXTreWswd95ho/8
	 HEA2kGHSAQIfPBdtD1jlxPzv9Nvgeh6ARK/wf1VlaVtTfsOb4yokdus4WjeeWOEIKB
	 yafNhXjCGgfd7WkcRFqNWk5es++M+xNminuJ0ELRAA3H/qXMj63Uqakcy/wPsggWd6
	 Q+0/qipDUAyZQ==
Message-ID: <b21f3d5a-bc46-4e04-8dcc-657f1146378e@kernel.org>
Date: Tue, 24 Jun 2025 10:08:37 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI/PM: Skip resuming to D0 if disconnected
To: "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: mario.limonciello@amd.com, linux-pci@vger.kernel.org,
 Mika Westerberg <westeri@kernel.org>
References: <20250623191335.3780832-1-superm1@kernel.org>
 <aFpSTT_UHakY91_q@wunner.de>
 <CAJZ5v0gjCdpARy5NzCZ71xb_M0-LU0110F_eGaPZsuCHGWWARg@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0gjCdpARy5NzCZ71xb_M0-LU0110F_eGaPZsuCHGWWARg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/24/25 5:24 AM, Rafael J. Wysocki wrote:
> On Tue, Jun 24, 2025 at 9:22 AM Lukas Wunner <lukas@wunner.de> wrote:
>>
>> [cc += Rafael, Mika]
>>
>> On Mon, Jun 23, 2025 at 02:13:34PM -0500, Mario Limonciello wrote:
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> When a USB4 dock is unplugged the PCIe bridge it's connected to will
>>> issue a "Link Down" and "Card not detected event". The PCI core will
>>> treat this as a surprise hotplug event and unconfigure all downstream
>>> devices. This involves setting the device error state to
>>> `pci_channel_io_perm_failure` which pci_dev_is_disconnected() will check.
>>>
>>> It doesn't make sense to runtime resume disconnected devices to D0 and
>>> report the (expected) error, so bail early.
>>>
>>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Reviewed-by: Lukas Wunner <lukas@wunner.de>
>>
>>> ---
>>> v4:
>>>   * no info message
>>> v3:
>>>   * Adjust text and subject
>>>   * Add an info message instead
>>> v2:
>>>   * Use pci_dev_is_disconnected()
>>> v1: https://lore.kernel.org/linux-usb/20250609020223.269407-1-superm1@kernel.org/T/#mf95c947990d016fbfccfd11afe60b8ae08aafa0b
>>> ---
>>>   drivers/pci/pci.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index 9e42090fb1089..160a9a482c732 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -1374,6 +1374,11 @@ int pci_power_up(struct pci_dev *dev)
>>>                return -EIO;
>>>        }
>>>
>>> +     if (pci_dev_is_disconnected(dev)) {
>>> +             dev->current_state = PCI_D3cold;
> 
> Why not PCI_UNKNOWN?

It was following what other situations of failure did:
* existing error in pci_power_up()
* error in pci_update_current_state()
* error in pci_set_low_power_state()

I view all of these cases as unrecoverable failures.

So perhaps if changing this one to PCI_UNKNOWN those three should those 
also be PCI_UNKNOWN?

Bjorn, Lukas, thoughts?

> 
>>> +             return -EIO;
>>> +     }
>>> +
>>>        pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>>>        if (PCI_POSSIBLE_ERROR(pmcsr)) {
>>>                pci_err(dev, "Unable to change power state from %s to D0, device inaccessible\n",
>>> --
>>> 2.43.0


