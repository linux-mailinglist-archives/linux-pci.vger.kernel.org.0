Return-Path: <linux-pci+bounces-10161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E974092EB57
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 17:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8869D1F24600
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 15:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB3D16B388;
	Thu, 11 Jul 2024 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrSsgktt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79781684A8;
	Thu, 11 Jul 2024 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710646; cv=none; b=LqW1Hy2sDxQOq0D7IVK1yBeQVxMqiiGpYk1sSOHJU1V1E7r682QbMrCSbw8HURBPhAp8EaIGAke9DkTwkE+R9/oTwYNb0Gv2mszUKPsRd5aF3vZa9GP6BJ1QgJwl0ZQAQXFXeAlq9vGqnIK3ZRuc1QcHgSwO08L0jWOPLVCodi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710646; c=relaxed/simple;
	bh=kq070wDFSGkEJkksHI5NpvJYQDS1pUfXAVJqY4xUS18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FDBuajLeYoGkDVwDAjYiS84ZIqVxmd+todPvX6NB/02aQ3e+jqcZLUQlYxeFu3GOHeB2a4GGp/KOH1prdttSs91retUBPf+1RxFSY0mFPwvgY93gdbyS3O2ytoMTLAljK2RsYI63IAt7KC173/AEPmaIZBFEDz2pRnlAlc0gLt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrSsgktt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF2AC116B1;
	Thu, 11 Jul 2024 15:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720710646;
	bh=kq070wDFSGkEJkksHI5NpvJYQDS1pUfXAVJqY4xUS18=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TrSsgkttWW4owJY2LJMoroCTdINUAJb46AgltBnu+IxySoKNCUTiaund5qkd0mqvs
	 MT1ugqlMWgVT0e+MzYamP/VZUkjKQ6/poPwZA3kQMkkAPZVR13kUTliaw2lyg5qKF6
	 15fAUHy9YydPiQ/Vgg4DqoRgBtiir+Fnq8+2m9Y5U+MW+kUn9s8FzHh09JnyRdaxMS
	 VXA2sZOqTRnWXvwOAgbeDx2I1WBvowMS2ZmwvKNFtY5fSxAebenMaeJO3D39byMk3i
	 i/0ZZhJbNTmbW3tn0G0s8l551PRNmuo3MNpkRspaPy60vtgtM7x23IVOtQm0UPMXgc
	 ZCiBxDqHQagaQ==
Message-ID: <dcaefa84-09f5-4be5-9f66-aac6bf5fabf7@kernel.org>
Date: Thu, 11 Jul 2024 10:10:44 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] PCI: Check PCI_PM_CTRL in pci_dev_wait()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 Daniel Drake <drake@endlessos.org>, Gary Li <Gary.Li@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20240710205838.2413465-1-superm1@kernel.org>
 <20240710205838.2413465-2-superm1@kernel.org>
 <15091369-fc5c-af2d-7591-e1732097e84c@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <15091369-fc5c-af2d-7591-e1732097e84c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/11/2024 10:07, Ilpo Järvinen wrote:
> On Wed, 10 Jul 2024, superm1@kernel.org wrote:
> 
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> A device that has gone through a reset may return a value in PCI_COMMAND
>> but that doesn't mean it's finished transitioning to D0.  On devices that
>> support power management explicitly check PCI_PM_CTRL on everything but
>> system resume to ensure the transition happened.
>>
>> Devices that don't support power management and system resume will
>> continue to use PCI_COMMAND.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/pci/pci.c | 27 ++++++++++++++++++++-------
>>   1 file changed, 20 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 35fb1f17a589c..4ad02ad640518 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1270,21 +1270,34 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>>   	 * the read (except when CRS SV is enabled and the read was for the
>>   	 * Vendor ID; in that case it synthesizes 0x0001 data).
>>   	 *
>> -	 * Wait for the device to return a non-CRS completion.  Read the
>> -	 * Command register instead of Vendor ID so we don't have to
>> -	 * contend with the CRS SV value.
>> +	 * Wait for the device to return a non-CRS completion.  On devices
>> +	 * that support PM control and on waits that aren't part of system
>> +	 * resume read the PM control register to ensure the device has
>> +	 * transitioned to D0.  On devices that don't support PM control,
>> +	 * or during system resume read the command register to instead of
>> +	 * Vendor ID so we don't have to contend with the CRS SV value.
>>   	 */
>>   	for (;;) {
>> -		u32 id;
>>   
>>   		if (pci_dev_is_disconnected(dev)) {
>>   			pci_dbg(dev, "disconnected; not waiting\n");
>>   			return -ENOTTY;
>>   		}
>>   
>> -		pci_read_config_dword(dev, PCI_COMMAND, &id);
>> -		if (!PCI_POSSIBLE_ERROR(id))
>> -			break;
>> +		if (dev->pm_cap && strcmp(reset_type, "resume") != 0) {
> 
> Comparing to a string makes me feel reset_type should be changed to
> something that allows direct compare and those values only mapped into
> string while printing it.
> 

Thanks, that's a great suggestion.  I'll add a patch earlier in the 
series to make an enum of the types instead and a mapping function for 
them to get the string as needed.

