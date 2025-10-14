Return-Path: <linux-pci+bounces-38092-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6852BBDB877
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 00:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 946214F5587
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 22:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E46A2E2DD4;
	Tue, 14 Oct 2025 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrYiVryD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A07D2DCF6B
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 22:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760479329; cv=none; b=tYIJcsD6G8hf1FqwuIeeYh55ihElR+/XnaMp72zXLCgfFRBRJs02XP0Zd/1XXp+hR1EHRd2Qs/tywOxS0G6NlGppJV8wbxnyQDBtGD37/9x0syanozYKPop4YqSacvpKaCdxSpEeTqs300MMr6gRTRZTbTd5/XUcCECyxnILa8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760479329; c=relaxed/simple;
	bh=GErVoxMZK5sxg6yobVVq0+8Y2gif4lFDMhw0Y3mRPZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKOZ6Gem5mm5xXnwb+417tk7kONiDDTWWq+rIrmuIjzA0DteExueCsCM9npLGjvOl7r0FDncnQwynADLaRzz2etTfRs1JMqZE99YNyBvgl1O3uYJB7BVfwD6yy0yBqQwx2rXZ3Fm5hNeyCTpmmDXaztBXkyD0tXj2XKv1QpaQZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrYiVryD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B945C4CEF1;
	Tue, 14 Oct 2025 22:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760479325;
	bh=GErVoxMZK5sxg6yobVVq0+8Y2gif4lFDMhw0Y3mRPZo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HrYiVryD/f5kJBSGEOWn7j+GHb+8EaUeN4hY2Wg+s2/ae/P7IO2oRJF1SoFe+W2WM
	 gtVMOmGK2IcYH2q/kXGtefVkRr9ppQggNLF5etFqhMj2QLegjegEL+qWTinMzqtm1q
	 6iAtPLQs/sYymwEBM1TY3NEUXfnJ2iQ5TtVW0FMlZ5+rWiRzIjwVUbljzmjrZOmzjE
	 zq7E7lANdPBcYWK71femTB/Q9hFRmVtEU2JFU9Ze7PkYq994FQYLYZYxhHyrioS4Vd
	 hCwojV+vlOXuFKInr7VQcJInCL1WYZVz/gzfuqKzxOkkLmpJo1FloGefU9h5Tpx9bH
	 rZP5xFDuKaA0A==
Message-ID: <2f857940-ae89-4459-b10e-25fadd722d5a@kernel.org>
Date: Tue, 14 Oct 2025 17:02:04 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI/VGA: Select SCREEN_INFO on X86
To: Thomas Zimmermann <tzimmermann@suse.de>, mario.limonciello@amd.com,
 bhelgaas@google.com
Cc: Eric Biggers <ebiggers@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org
References: <20251013220829.1536292-1-superm1@kernel.org>
 <f05a530b-c5db-4db0-8458-1ba0443e4f2a@suse.de>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <f05a530b-c5db-4db0-8458-1ba0443e4f2a@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/14/2025 3:24 AM, Thomas Zimmermann wrote:
> 
> 
> Am 14.10.25 um 00:08 schrieb Mario Limonciello (AMD):
>> commit 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with
>> a screen info check") introduced an implicit dependency upon SCREEN_INFO
>> by removing the open coded implementation.
>>
>> If a user didn't have CONFIG_SCREEN_INFO set vga_is_firmware_default()
>> would now return false.  SCREEN_INFO is only used on X86 so add add a
>> conditional select for SCREEN_INFO to ensure that the VGA arbiter works
>> as intended.
>>
>> Reported-by: Eric Biggers <ebiggers@kernel.org>
>> Closes: https://lore.kernel.org/linux-pci/20251012182302.GA3412@sol/
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Fixes: 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with 
>> a screen info check")
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/pci/Kconfig  | 1 +
>>   drivers/pci/vgaarb.c | 6 ++----
>>   2 files changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> index 7065a8e5f9b14..f94f5d384362e 100644
>> --- a/drivers/pci/Kconfig
>> +++ b/drivers/pci/Kconfig
>> @@ -306,6 +306,7 @@ config VGA_ARB
>>       bool "VGA Arbitration" if EXPERT
>>       default y
>>       depends on (PCI && !S390)
>> +    select SCREEN_INFO if X86
> 
> On x86 screen_info comes from [1]. On other systems it's at [2].
> 
> You can try selecting CONFIG_SYSFB instead, but that will likely run 
> into trouble with CONFIG_EFI=n.
> 
> [1] https://elixir.bootlin.com/linux/v6.17.1/source/arch/x86/kernel/ 
> setup.c#L214
> [2] https://elixir.bootlin.com/linux/v6.17.1/source/drivers/firmware/ 
> efi/efi-init.c#L63
> 
> I guess, the current patch should work for the use case. I'll keep in 
> mind to make the screen_info state easier to select.
> 

Yeah I noticed these when I was putting this together and when I 
compared the pre-337bf13aa9dda code I decided KISS is the better 
approach, especially to fix the 6.18 regression.

> Best regards
> Thomas
> 
>>       help
>>         Some "legacy" VGA devices implemented on PCI typically have 
>> the same
>>         hard-decoded addresses as they did on ISA. When multiple PCI 
>> devices
>> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
>> index b58f94ee48916..436fa7f4c3873 100644
>> --- a/drivers/pci/vgaarb.c
>> +++ b/drivers/pci/vgaarb.c
>> @@ -556,10 +556,8 @@ EXPORT_SYMBOL(vga_put);
>>   static bool vga_is_firmware_default(struct pci_dev *pdev)
>>   {
>> -#ifdef CONFIG_SCREEN_INFO
>> -    struct screen_info *si = &screen_info;
>> -
>> -    return pdev == screen_info_pci_dev(si);
>> +#if defined CONFIG_X86
>> +    return pdev == screen_info_pci_dev(&screen_info);
>>   #else
>>       return false;
>>   #endif
> 


