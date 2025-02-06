Return-Path: <linux-pci+bounces-20788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D3AA2A28F
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 08:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD80E161852
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 07:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ABE224AE5;
	Thu,  6 Feb 2025 07:44:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBCA2E64A;
	Thu,  6 Feb 2025 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738827855; cv=none; b=XN25sDOo3R5Kn9Jq4ctySNJija0byOpAqhXGqUZwD4J1/iNReNJ6zmueHRIkyDCiRkmQGbdMep3qaATgZr2Mw2DG8x4VmxP5S8qwu7XUmKSLGihUN5ORD3N3uYhjtpPojnReRPwWR7mNQLcdmKUQ3CFUESQCkgF4QjOqY3WLtAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738827855; c=relaxed/simple;
	bh=H4J90HwwvYoMaaB9zxa9TtYASQnFpOPtRX++W7y9Lts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKEh1EWfWinnaOdSUW4pG5fjtxNhxrnBaArZ35jcsWwmcMzsPzXahvaUX4pLS0A6XOgvuysds+G0ucF02c+T10dIvM8TLiEWBj26ZcskJ3OY8Cp+v0gNbP1qKPEWWrK+jbrXT6uarsLez7zu8B4vZ27/jAtXowG3EgfIOiBNwU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.59.18.202] (p4fff09b4.dip0.t-ipconnect.de [79.255.9.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id EAB0C61E647AE;
	Thu, 06 Feb 2025 08:43:31 +0100 (CET)
Message-ID: <7e9bc19e-1a9b-4875-907a-86196876ac4c@molgen.mpg.de>
Date: Thu, 6 Feb 2025 08:43:30 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux warns `rtsx_pci 0000:3b:00.0: PM: dpm_run_callback():
 pci_pm_resume returns -110`
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, regressions@lists.linux.dev,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>
References: <20250205233817.GA949434@bhelgaas>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250205233817.GA949434@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

#regzbot monitor: 
https://lore.kernel.org/linux-pci/20250131152913.2507-1-ilpo.jarvinen@linux.intel.com/

Dear Bjorn,


Thank you for your reply.

Am 06.02.25 um 00:38 schrieb Bjorn Helgaas:
> On Wed, Feb 05, 2025 at 10:48:24PM +0100, Paul Menzel wrote:
>> Thank you for your instant reply.
>>
>> Am 05.02.25 um 09:44 schrieb Ilpo Järvinen:
>>> On Tue, 4 Feb 2025, Paul Menzel wrote:
>>>
>>>> #regzbot introduced: b46c89c08f41..aa22f4da2a46
>>
>>>> On the Intel Kaby Lake laptop Dell XPS 13 9360, at least Linux
>>>> 6.13.0-07632-gaa22f4da2a46 logs the new warnings:
>>
>> (Just a side note, these are actually logged with level error.)
>>
>>>>       rtsx_pci 0000:3b:00.0: Unable to change power state from D0 to D3hot, device inaccessible
>>>>       rtsx_pci 0000:3b:00.0: PM: dpm_run_callback(): pci_pm_resume returns -110
>>>>       rtsx_pci 0000:3b:00.0: PM: failed to resume async: error -110
>>>>
>>>> These were not present up to including Linux 6.13.0-07078-gb46c89c08f41.
>> ...
> 
>>> Please try if this fix helps:
>>>
>>> https://lore.kernel.org/linux-pci/20250131152913.2507-1-ilpo.jarvinen@linux.intel.com/
>>
>> Yes, after applying the patch these errors were *not* logged in three ACPI
>> S3 suspend/resume cycles.
> 
> Thanks, I added your Reported-by to the patch, which should appear in
> v6.14-rc2.  Happy to also add your Tested-by if you feel confident
> enough.

Sure.

Tested-by: Paul Menzel <pmenzel@molgen.mpg.de> # Dell XPS 13 9360


Kind regards,

Paul

