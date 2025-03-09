Return-Path: <linux-pci+bounces-23254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A3EA58763
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 19:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C3307A24FB
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 18:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370561DF279;
	Sun,  9 Mar 2025 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZnpkWK6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D4510E5;
	Sun,  9 Mar 2025 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741546501; cv=none; b=Kdgpj6v2CmlzihWeI9ueKE6oOkSN+eOiLff0k6+dE02X4rNMrlJ6RSw1hvrShW3WY/plBs1ccwHnG4ZHgG4uEn3TCYKYHUxCIfqH9ybbAnU6m1MIP1Ky9fCRqD3Qzqxl/KmX8oIHJfkWxEN1d1ESqBvsDJfYOhOcAzhX/pltJVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741546501; c=relaxed/simple;
	bh=VCI3PzOr8BVH3pnvOIpSd3z0MJw4AXBD0DZdGDMM+iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmFRXy92ptyWzsZpcghGo055U2K8yqU7b9fchPh9HugjLnA4Ztj7TGnV1pZ/HjcK4Pw4o+WF424F8odcSGpl+KsUCR390V6Ps1E01VjZDOafLzLD0o9ogz3hO57A3uBwzk2J9XhlIMw84ZKJ/sjZV1pd2nSTBQ/H248vZPpX2FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZnpkWK6; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e535e6739bso5481803a12.1;
        Sun, 09 Mar 2025 11:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741546498; x=1742151298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TvU0e2WHHQJk+uGY/Xu8xmGCC+8Y86v0MSPjlOl9HVs=;
        b=OZnpkWK6WajeOMtqS3kRDRo947ahzLFg4gYInB/jJavlENE5olDtdpGnmpnI6isHEa
         tT0uzNQ58DDGJDxpN+Y7uBPaT6YlDq5hkhvuX+YOwtiYXu8aDkoDuMh4gTF7DYnwb7wy
         L483NtNGOdxLV5jRbJFj9QENLYWIs1aze5OUb/Fey/asft9fWMrNAC4Se5dAvXUanQN0
         kL43SxyqLuhtoSFMpQPVgUjdhIdVbYIApCTV4LMokx3B7P6vYHraTpYJa1A6qu8stexo
         O+n5ymcY/wdFJtfEBO9WPpEE/Khhd5dQ+XG3/+J/+kc/pBwsD+02Ly8zVPvqKTQ2nctZ
         KPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741546498; x=1742151298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvU0e2WHHQJk+uGY/Xu8xmGCC+8Y86v0MSPjlOl9HVs=;
        b=KhtvrB9xruPzx+1jzwnL4P3DoGe5YJbWmnoNWeESUqjE38fQn38ws1Q+NYjkqOzApE
         rC8lohap/nkH6ZmxPteC6s4inqchqmZPa951Vc6TyIaFzyWftxaXEOIf8yjWb09BCVeU
         my/+E88NHR4dGPZheSsMm0iS6L6w/GgZIBLlWayQtErQETz5GQ0fp3SWxn3j5swR8P6p
         q5BNQYNcQ8VpZUjJ9tNOTOEdw7+Q3kptmxSBTTQfD6eXCEeuiM5uNsqmetS11tCjIjKB
         EX2B5tvLBWzZmuPWk/gi2qfGi6mJ7ps4GeyiHte4xgvkglWWatVTjTg6SdvscFa/hsnD
         4EHg==
X-Forwarded-Encrypted: i=1; AJvYcCV+0R2CbPRbAbVUk/nDNtLDMmvGoLk6cjweDaxny8E2+6J79EP+rzmahT8N1e6BL0WbJAo7sZwKbKj/CZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbAl3XCMGxoYq6BcS1RHDyRQLMpijRsbb89qlFBL/6/CEuOfmP
	Pji/gzp98Rr8wFfZnofe66u1mfQLtHtuTs9+F899x6M8R6WDKYKR
X-Gm-Gg: ASbGncubAv2VVdGaOoNjngt3dLI4qdp+Z7ijE13M9uyfXr9NpCzI1S6tLr38JoY3YOB
	7IyDdCcckK6zHY0fWWM9kesfRXpYHDqwN/Lp2Fq3bTn/leF26p2pU98NShUK0Lb+WgI0FS2ySMX
	CXJKSdqPW2D7iuJ1G845LQ7opc3BbQCODS8YqWstWpGzPx9FrBzO+5AVe4njdQmz7cdVTXRYOjd
	3DSG53LsA115sypRebm5eowUdziN7wjf69FncHEhvHTrUbZcD/kXgQKuk5/aJ/UzRjiNOg06M9w
	xxIyd7vISl1+URtJHNt21MunjLgN8H6bP0FtQ41myBCrVcJoYsT07yM5
X-Google-Smtp-Source: AGHT+IF0Jox5sVpuCM0n5VW+dQfQ/Z14cDj+251hfTW9aIvIHfTAR1nkTjDO24Av1SG7JQD7YBrLZw==
X-Received: by 2002:a17:906:cecb:b0:ac2:8118:27e7 with SMTP id a640c23a62f3a-ac2811831a3mr594179066b.50.1741546497372;
        Sun, 09 Mar 2025 11:54:57 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.121.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac285211a00sm209386066b.36.2025.03.09.11.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 11:54:56 -0700 (PDT)
Message-ID: <acae4205-a7e0-4935-9a39-bbec3bc0c9c4@gmail.com>
Date: Sun, 9 Mar 2025 19:54:41 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/PM: Put devices to low power state on shutdown
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
 Kai-Heng Feng <kaihengf@nvidia.com>, bhelgaas@google.com,
 mika.westerberg@linux.intel.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 AceLan Kao <acelan.kao@canonical.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 =?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>
References: <20241208074147.22945-1-kaihengf@nvidia.com>
 <69ddda46-62cc-445f-a1ef-f4651ec0b138@app.fastmail.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <69ddda46-62cc-445f-a1ef-f4651ec0b138@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/01/25 21:31, Mark Pearson wrote:
> Hi,
> 
> On Sun, Dec 8, 2024, at 2:41 AM, Kai-Heng Feng wrote:
>> Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
>> connected.
>>
>> The following error message can be found during shutdown:
>> pcieport 0000:00:1d.0: AER: Correctable error message received from 
>> 0000:09:04.0
>> pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable, type=Data 
>> Link Layer, (Receiver ID)
>> pcieport 0000:09:04.0:   device [8086:0b26] error 
>> status/mask=00000080/00002000
>> pcieport 0000:09:04.0:    [ 7] BadDLLP
>>
>> Calling aer_remove() during shutdown can quiesce the error message,
>> however the spurious wakeup still happens.
>>
>> The issue won't happen if the device is in D3 before system shutdown, so
>> putting device to low power state before shutdown to solve the issue.
>>
>> ACPI Spec 6.5, "7.4.2.5 System \_S4 State" says "Devices states are
>> compatible with the current Power Resource states. In other words, all
>> devices are in the D3 state when the system state is S4."
>>
>> The following "7.4.2.6 System \_S5 State (Soft Off)" states "The S5
>> state is similar to the S4 state except that OSPM does not save any
>> context." so it's safe to assume devices should be at D3 for S5.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219036
>> Cc: AceLan Kao <acelan.kao@canonical.com>
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
>> ---
>>  drivers/pci/pci-driver.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index 35270172c833..248e0c9fd161 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev)
>>  	if (drv && drv->shutdown)
>>  		drv->shutdown(pci_dev);
>>
>> +	/*
>> +	 * If driver already changed device's power state, it can mean the
>> +	 * wakeup setting is in place, or a workaround is used. Hence keep it
>> +	 * as is.
>> +	 */
>> +	if (!kexec_in_progress && pci_dev->current_state == PCI_D0)
>> +		pci_prepare_to_sleep(pci_dev);
>> +
>>  	/*
>>  	 * If this is a kexec reboot, turn off Bus Master bit on the
>>  	 * device to tell it to not continue to do DMA. Don't touch
>> -- 
>> 2.47.0
> 
> Just a note that we've tested this in the Lenovo Linux team and confirmed that it reduces the power draw on a powered off Z16 G2 by 0.6W.
> This is enough to bring Linux inline with Windows, and more importantly allow the platform to pass e-star energy certification (which it otherwise fails). We suspect other platforms will show similar benefits.
> 
> Let me know if there's anything we can do to help get this patch moving along - I think it's important.
> 
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> 
> Mark

Hello,

I have helped an user affected by the issue this patch solves (FA507NV).

The issue has been solved by this patch.

I also tested this patch with two unaffected laptops: my own (G634JZ) and my brother's (FX507ZE): neither showed sign of any regressions.

Tested-by: Merthan Karakaş <m3rthn.k@gmail.com>
Tested-by: Denis Benato <benato.denis96@gmail.com>

