Return-Path: <linux-pci+bounces-29236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05490AD22DA
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 17:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62604165B52
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 15:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F7B215779;
	Mon,  9 Jun 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1cl5UOA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346CE215767
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483941; cv=none; b=oR8Agi3C/Jwqj6Iajzq88dVKVeEv0nb7lUm4esc2Np46/ywSU+ciYYNyX6uEqwUlaeCoBZowQQIsDGCjYk3PS8G5RooL9Cbkiaomk7+Oe3j5u1z40gZehoWY5U+ert2CUSujcKVcfNXKdQB1bLEgVZFHCR4qkbIA8hPEvwFiASU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483941; c=relaxed/simple;
	bh=nfyzHKIc34sbDcFeXhBqW6mxzi85ePCarzAsLlEaHkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s06Jphs+SIRXQeo0Z8D4u4BG3/R7e2dQlWvskmUC0FHNIXhrdPigFQAYj5tCpNP/4k3kidWxSDiiywstEJY6QwtsL+K/eckuNUO+stw0+OOg884Eg5DzxWFyWF095+dGQNAQosY7UVwlJxx1yqEzp6InPO4X0p5/mCNLPzoncCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1cl5UOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B654C4CEEB;
	Mon,  9 Jun 2025 15:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749483940;
	bh=nfyzHKIc34sbDcFeXhBqW6mxzi85ePCarzAsLlEaHkg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X1cl5UOAXlK6KC8flqgHNR+OHuav/C4G1KPQVujbODeeziltHNCfMbKDmewQN259F
	 1q8o5aT7wGvrfY4sqIv/qlwk9uy+yuhPprg9EWHAPmtEaNzeXYkEA/aGgM6xup62M6
	 Vr2UD4oKbPALspEAg8HwdGh8vIICTmTAtJ6XBEtECwM3O5VfuIdUUkFE7TYMeI4M88
	 KhylEPV4D4+1yTAcfWlAQJyoavcKb0aGvd6tEWQGq+ZX++bcifFcMRQbKoDarYHv4x
	 p2pBhlTHE6rs5tz0U1sog5jiBXQDf+aKPPPe7l0ywScpObUEl1rur9BCf85UNKisn6
	 S2PB9fOh2m7KA==
Message-ID: <8a45bf3f-5f30-4aed-85d5-b93d38d47a92@kernel.org>
Date: Mon, 9 Jun 2025 10:41:00 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] PCI: Don't show errors on inaccessible PCI devices
To: Lukas Wunner <lukas@wunner.de>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20250609020223.269407-1-superm1@kernel.org>
 <20250609020223.269407-2-superm1@kernel.org> <aEb5HjRQ6OHZj_hS@wunner.de>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aEb5HjRQ6OHZj_hS@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/2025 10:09 AM, Lukas Wunner wrote:
> [cc += Rafael, Mika]
> 
> On Sun, Jun 08, 2025 at 08:58:01PM -0500, Mario Limonciello wrote:
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1376,8 +1376,9 @@ int pci_power_up(struct pci_dev *dev)
>>   
>>   	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>>   	if (PCI_POSSIBLE_ERROR(pmcsr)) {
>> -		pci_err(dev, "Unable to change power state from %s to D0, device inaccessible\n",
>> -			pci_power_name(dev->current_state));
>> +		if (dev->error_state != pci_channel_io_perm_failure)
>> +			pci_err(dev, "Unable to change power state from %s to D0, device inaccessible\n",
>> +				pci_power_name(dev->current_state));
>>   		dev->current_state = PCI_D3cold;
>>   		return -EIO;
>>   	}
> 
> Instead of merely silencing the error message, why not bail out early on
> in the function, i.e.
> 
> 	if (pci_dev_is_disconnected(dev)) {
> 		dev->current_state = PCI_D3cold;
> 		return -EIO;
> 	}
> 

Thanks for the suggestion.  That sounds good to me, I'll have a try.


