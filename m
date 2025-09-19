Return-Path: <linux-pci+bounces-36453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358FBB8799D
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 03:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D2A5825AB
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 01:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95134246BB6;
	Fri, 19 Sep 2025 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEG7TPKb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9F5244693
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758245389; cv=none; b=UV8+keQAANytzm+GluBMCUH7kEn3Sj+PPytYG5yQsZG+VLaSd0NY8TfCfvx9QEAFzC7BKJkIBPfk3eS9Jpgel+v7eHbJ7YCXqg/Mdciqkr01qqUZksg4MPqYhdq123m1bxBz1YXsh677pkXCjQsC2nx/QbvwjhPUyw4rGUtuHK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758245389; c=relaxed/simple;
	bh=Nutc32t51hXO4w65NfAzVkCX7fU+u2mM/1dvotV+NYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hO9Kkw8tCrvoP3384Yv9wjTKfOBY3rcXCBe4UnQNu9hMIozG8lHGb3YVDiciBhjwTtkLyG/cfrJqqCaSW1VfMJNH8e95WvuyY+5GBUljbSP6/9E9WauJUbzXO51EQUNiRGqS26OrhuOFRn0ugc/wOqg5bwcChMsdbZ9YGBHlu2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEG7TPKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3455EC4CEEB;
	Fri, 19 Sep 2025 01:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758245388;
	bh=Nutc32t51hXO4w65NfAzVkCX7fU+u2mM/1dvotV+NYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eEG7TPKbD6LvpXbNx9Q8J6NxNiGW6MGwDKE/+sB3sO/RUqBfbXQ/7nVCCoBjn7Dhx
	 SFd5XBrkIJFWLvXkyjZay4BE/BhSU0XCqwvNBfzTAlIXJevwVZJPVTKIyVBw4lVc5/
	 9Wr+EIuc9id6D7y+ArKdgWmS6JqUulGCE9cCB9leabcWTAhvPi46sHz6DtQit124cl
	 8kmveUx+ZxVF338BaagKFFm7TaS3l3AO+fL812xWOVmiuX1BwAVz69ONzKkpB5gOLk
	 KEBVx0xO9kjL0BIxwO+XyBDdcVzZOx0PsEicReVY7CSRewBAzzMOYQLMLMHvk7PbS7
	 PoDIikX8Xta0Q==
Message-ID: <328740e7-f08e-44d1-a851-b2697de017c4@kernel.org>
Date: Thu, 18 Sep 2025 20:29:46 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] PCI/PM: Skip resuming to D0 if device is disconnected
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
 Lukas Wunner <lukas@wunner.de>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 linux-pci@vger.kernel.org
References: <20250918220816.GA1925068@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250918220816.GA1925068@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/18/25 5:08 PM, Bjorn Helgaas wrote:
> On Mon, Sep 08, 2025 at 10:19:15PM -0500, Mario Limonciello (AMD) wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> When a PCIe device is surprise-removed (e.g., due to a dock unplug),
>> the PCI core unconfigures all downstream devices and sets their error
>> state to `pci_channel_io_perm_failure`. This marks them as disconnected
>> via `pci_dev_is_disconnected()`.
>>
>> During device removal, the runtime PM framework may attempt to resume
>> the device to D0 via `pm_runtime_get_sync()`, which calls into
>> `pci_power_up()`. Since the device is already disconnected, this
>> resume attempt is unnecessary and results in a predictable error.
>> Avoid powering up disconnected devices by checking their status early
>> in `pci_power_up()` and returning -EIO.
> 
> Hi Mario,
> 
> I forgot to ask if there are any characteristic dmesg logs and user
> activities that we could include here to help users recognize this
> problem.  I suppose it results in messages like this?
> 
>    pci 0000:01:00.0: Unable to change power state from D3cold to D0, device inaccessible
> 
> Maybe especially when undocking?  Although oddly a google search for
> that message and "undock" finds nothing.
> 

Yes spot on.  The dock needs to be TBT3 or USB4 and the host has to 
offer PCIe tunneling for it to occur.

>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>> Reviewed-by: Lukas Wunner <lukas@wunner.de>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v7:
>>   * Reword commit message
>>   * Rebase on v6.17-rc5
>> ---
>>   drivers/pci/pci.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index b0f4d98036cdd..036511f5b2625 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1374,6 +1374,11 @@ int pci_power_up(struct pci_dev *dev)
>>   		return -EIO;
>>   	}
>>   
>> +	if (pci_dev_is_disconnected(dev)) {
>> +		dev->current_state = PCI_D3cold;
>> +		return -EIO;
>> +	}
>> +
>>   	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>>   	if (PCI_POSSIBLE_ERROR(pmcsr)) {
>>   		pci_err(dev, "Unable to change power state from %s to D0, device inaccessible\n",
>> -- 
>> 2.43.0
>>


