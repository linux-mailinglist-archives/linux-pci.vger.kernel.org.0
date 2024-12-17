Return-Path: <linux-pci+bounces-18654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D5B9F50C1
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 17:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE177AB13B
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 16:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5D51F9F4A;
	Tue, 17 Dec 2024 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="RIzuAKKB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125B71F9428;
	Tue, 17 Dec 2024 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451692; cv=none; b=iLe0uNODz4X+K95AL7FOR03hI+Cj06zEoWty8oSRokLvWdS4a70Blc2VG1SxYsee9pERjYariEhe0rEq63g8op4KIqF7DmQopWe31nJlswJTD2H3DirAtH4QfsFpEEY9SRZjA90NaOdqumwiMxvfI3M0jV8ESGyKFz5HnFuxhGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451692; c=relaxed/simple;
	bh=5AGsLR3Hc8ztJEHetP6/py2T8/Je9jJMmNELRDyI/WA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=e7W1VremU9EoiWkGNnYriHUeqxrsLcvYdc8/rGrMOyoQNg1y1/9rgBai5ks7GYmt7e56uaWBTFtfkcDvD6W9eY60oLDTEEdZsC4D9o9W2+WVx49x3t+Attj7bvfl6tLMa+mHNLOQb0gX8YklNzH2iq4emMJL81xP4Z6k+5mp0L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=RIzuAKKB; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (p5de4533f.dip0.t-ipconnect.de [93.228.83.63])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 644C32FC0055;
	Tue, 17 Dec 2024 17:08:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1734451685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3jBKadfXlvv4WnJlaffwJLQGwPQzodC+VnQaCiq74hA=;
	b=RIzuAKKB1Rpy0en6Min2mN/y5fZs5A8MM2/IIJaivf0ROE8efChFf788APK+KPTF3hJQ87
	oTvDSq0a0J/okvT2uFS1CorjIua4f0wiyZVg/amUr1YLgTlEKmVlLivpqDnAcd066x3P9z
	dB0pFn1euBl4FnCe1WoRiRSPr7AcJhI=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <c6110fdb-cc43-4351-be43-63d251fefca5@tuxedocomputers.com>
Date: Tue, 17 Dec 2024 17:08:05 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Avoid putting some root ports into D3 on some
 Ryzen chips
From: Werner Sembach <wse@tuxedocomputers.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ggo@tuxedocomputers.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241209193614.535940-1-wse@tuxedocomputers.com>
 <215cd12e-6327-4aa6-ac93-eac2388e7dab@amd.com>
 <23c6140b-946e-4c63-bba4-a7be77211948@tuxedocomputers.com>
 <823c393d-49f6-402b-ae8b-38ff44aeabc4@amd.com>
 <2b38ea7b-d50e-4070-80b6-65a66d460152@tuxedocomputers.com>
 <e0ee3415-4670-4c0c-897a-d5f70e0f65eb@amd.com>
 <90631333-fda0-42cf-9e32-8289c353549f@tuxedocomputers.com>
 <4dac3ff2-e3ab-42c0-b39f-379d5badca42@amd.com>
 <7a9353d3-b9db-4499-a054-c7050bc7b4d5@tuxedocomputers.com>
Content-Language: en-US
In-Reply-To: <7a9353d3-b9db-4499-a054-c7050bc7b4d5@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 17.12.24 um 16:58 schrieb Werner Sembach:
>
> Am 17.12.24 um 15:11 schrieb Mario Limonciello:
>> On 12/17/2024 08:07, Werner Sembach wrote:
>>
>>>> '''
>>>> Platform may hang resuming.  Upgrade your firmware or add pcie_port_pm=off 
>>>> to kernel command line if you have problems
>>>> '''
>>> Yes, full log attached (kernel 6.13-rc3 one time without sudo one time with 
>>> sudo)
>>
>> Yes; I see it in your log.
>>
>>>> "quirk: disabling D3cold for suspend"
>>> On the fixed BIOS I see that line. On the unfixed BIOS it aborts the 
>>> functions at "if (pm_suspend_target_state == PM_SUSPEND_ON)". Skipping the 
>>> check on the unfixed BIOS it still hangs on resume.
>>>>
>>>> I'm /suspecting/ you do see it, but you're having problems with another 
>>>> root port.
>>>>
>>>> I mentioned this in my previous iterations of patches that eventually 
>>>> landed on that quirk, but Windows and Linux handle root ports differently 
>>>> at suspend time and that could be why it's exposing your BIOS bug.
>>>>
>>>> If you can please narrow down which root ports actually need the quirk for 
>>>> your side (feel free to do a similar style to 7d08f21f8c630) I think we 
>>>> could land on something more narrow and upstreamable.
>>>>
>>>> At a minimum what you're doing today is covering both Rembrandt and Phoenix 
>>>> and it should only apply to Phoenix.
>>>
>>> I also try to find out how many devices where actually shipped with this 
>>> very first BIOS version.
>>
>> OK.
>
> Ok found out that the initial bios actually works, then there is one in 
> between bios where it doesn't and the next one it works again.
>
> So i need to find out if the the in between bios was actually shipped, if not, 
> this issue is actually void.
>
Dang it: seems like it.

So should i create a v3 of the patch with the correct pci ids just for this bios 
version?



