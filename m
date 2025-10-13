Return-Path: <linux-pci+bounces-37900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5C9BD3864
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 16:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72003A9E3F
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 14:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D5624A044;
	Mon, 13 Oct 2025 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFcnATOV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8096C239562
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760365879; cv=none; b=pXjz4/U7nzba2hquGIDzbyU3prkCNMVdrcUdTxKxpGVMKmpdoreP3dfW/fN5k69+zk7Qd9M82JX4mNVg03pMhEHJEWS7KS1IUjIUHf2jIX9vIDUgjmN3rDtWeG0MUZttqHQ0k4fWidoZfueQJWHOlRs3JV609DE8E5atiK9qiI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760365879; c=relaxed/simple;
	bh=ctLswUQpQ04BT9zYZz6CLqUVdfYf5DqOLtv2BTH+xqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZiWi7rMQE1EHBHmbo9p7RM+9FCCNU8LH+5UR5kA9VWZ4KcLMRn/jwFJCOdKXZHpLofhOyC4jSsmc2DEFdajpsQmTBdhoWtY1IKdxcgQlmmgxrREnudSwS/3EwQIjlxqRZWBVrjZ4bGZW51+SqsnqeyDSZt+tGuKzRV0+DD2BZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFcnATOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8489FC4CEE7;
	Mon, 13 Oct 2025 14:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760365878;
	bh=ctLswUQpQ04BT9zYZz6CLqUVdfYf5DqOLtv2BTH+xqU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cFcnATOVWUCMv/Y5Gd/h7abKkHRALZ/kkOaOwPxwqQRirmH1j1iI5KHVzasD/aVQM
	 kPxR3gtngaS/ub6HAeqEFUGs0GXyowuQyKpQKnUjBb+qSpLryKmVbtzVpGX+KeUtit
	 MsEREVDbOhHiKlp2MWH3Mbh2SoQHBEPi5IhwjIgiYbWfyKPPv6vUzOr/spbJSoC7it
	 ClxCLJNjLoQkD00QNm5q+zqcMCkEda+CCTUnOSqtHhVvncngM1KX/beJ5tNpYxef/c
	 3GyPciqqQ/ad+SF6AIoGOO2K+9T77zfFQuWPAFVaOyRrNYq2dnp5nUeITmEPrjSzMb
	 Oo/jQygqQlbpA==
Message-ID: <6dd53ff9-2398-4756-9c13-c082f1c01d4b@kernel.org>
Date: Mon, 13 Oct 2025 09:31:16 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/VGA: Select SCREEN_INFO
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: mario.limonciello@amd.com, bhelgaas@google.com, tzimmermann@suse.de,
 Eric Biggers <ebiggers@kernel.org>, linux-pci@vger.kernel.org
References: <20251013135929.913441-1-superm1@kernel.org>
 <f36a943e-73bb-97ce-83bc-56aa0e1b5267@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <f36a943e-73bb-97ce-83bc-56aa0e1b5267@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/13/25 9:16 AM, Ilpo Järvinen wrote:
> On Mon, 13 Oct 2025, Mario Limonciello (AMD) wrote:
> 
>> commit 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with
>> a screen info check") introduced an implicit dependency upon SCREEN_INFO
>> by removing the open coded implementation.
>>
>> If a user didn't have CONFIG_SCREEN_INFO set vga_is_firmware_default()
>> would now return false.  Add a select for SCREEN_INFO to ensure that the
>> VGA arbiter works as intended.
>>
>> Reported-by: Eric Biggers <ebiggers@kernel.org>
>> Closes: https://lore.kernel.org/linux-pci/20251012182302.GA3412@sol/
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Fixes: 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with a screen info check")
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/pci/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> index 7065a8e5f9b14..c35fed47addd5 100644
>> --- a/drivers/pci/Kconfig
>> +++ b/drivers/pci/Kconfig
>> @@ -306,6 +306,7 @@ config VGA_ARB
>>   	bool "VGA Arbitration" if EXPERT
>>   	default y
>>   	depends on (PCI && !S390)
>> +	select SCREEN_INFO
>>   	help
>>   	  Some "legacy" VGA devices implemented on PCI typically have the same
>>   	  hard-decoded addresses as they did on ISA. When multiple PCI devices
> 
> The commit 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with
> a screen info check") also changed to #ifdef CONFIG_SCREEN_INFO around the
> call, but that now becomes superfluous with this select, no?

Thanks! Will adjust.

> 
> Looking into the history of the ifdefs here is quite odd pattern (only
> the last one comes with some explanation but even that is on the vague
> side and fails to remove the actual now unnecessary ifdef :-/):
> 
> #if defined(CONFIG_X86) -> #if defined(CONFIG_X86) -> select SCREEN_INFO
> 
> Was it intentional to allow building without CONFIG_SCREEN_INFO?
> 

You mean in the VGA arbiter code?  Or just in general?  There is a lot 
of other places that conditionalize code on CONFIG_SCREEN_INFO.  You 
don't "have" to build in the the VGA arbiter and presumably those are 
correct.

