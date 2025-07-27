Return-Path: <linux-pci+bounces-32976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4E0B12F90
	for <lists+linux-pci@lfdr.de>; Sun, 27 Jul 2025 14:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F48618958ED
	for <lists+linux-pci@lfdr.de>; Sun, 27 Jul 2025 12:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851241E7C03;
	Sun, 27 Jul 2025 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4WR59+W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB68D19C553;
	Sun, 27 Jul 2025 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753620522; cv=none; b=Bia9CYoV+TWiuP3Nw8lrW5ZnZhcfDfH4K3UWTmOaeJyp/Fpxbo6y3d/EzfgudWOYg06TIk5S4A7E5Um7GOZVq0ZrRPXI0Zy5QkxW6STLKZsLG3qHWVUYyRpnJ5QVkzM630lfOSCqXZeAJdSKqCgigUD3LvuDyXlbu/yKo+jlnuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753620522; c=relaxed/simple;
	bh=5q9r9ISVav2dz5XcKEk9jqfSVetd8J2R7nS/TEyhwJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2TCVkiPf/IYCpo2FlKw6JyhneGfX952/apf+fr9RMx9ws6P2bloucOHSBhheBwsC1ItUWrfT7N5MUtJfjrna/5JdTLyaOgU2mTeDSB4MOjmeUySCuQEEUg2AEHMCgdcyUL/uBlnOUCLCYtR+4fzp11u2BDT+/5scglJ1xUHvYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4WR59+W; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3b7886bee77so116681f8f.0;
        Sun, 27 Jul 2025 05:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753620519; x=1754225319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DRITpsqAlVQuup8a/seimyyXM3Zd5ZY8LDRlKD/FNoE=;
        b=m4WR59+WpvniVkBJTOBiJt/BJSyHDqEgaObMj92ldEeX6/mQPT/2PxGnTZ6sydQn5+
         +9qvS9vCb1MmHjouw4rKMC20ebRelZPkbYV0g6K5vrlfdHJzQX8oTOfu3pfOouy78lFa
         zepr+iCBLnrZI2PGdylMncnSeJP1VBuMXRokeePj88Uvu/9q9BFurSn5k9Z7H4Is6r4q
         23QJVEQajc0GdoxPdDfb15RbEzlRM244eGHjAGNdDDaCxiRwG1ZtaXX/h2s3vbwXv9VI
         +gq32OKd0O+2op8L5fNSwq54lQfK2Lf7ih55GHyeyKBiIdeNiOzznEoF/gI6JNFXcSV6
         GH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753620519; x=1754225319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRITpsqAlVQuup8a/seimyyXM3Zd5ZY8LDRlKD/FNoE=;
        b=iI9A1IwjQf+KADe63z8ORxJNr0uHKJb5oQi1MFe16idTRA9c6bMuoWVrGdUDJMn07f
         pke+HBWdlE7fqtACUNCmedEXsKzVM7NwSgrlIjbauLYzsmQYG6YOAJzcoNF90ccT+DTX
         DXYyRJ10XpBEpQXTSqKedlW0TUwN35Pyt9OtxNTC4h55cQGlHZyE29+vngQbVlpvUDUK
         co9b+4VUVNLcVxGfNuCE6crsx5RdR97d5EIadZ0Ihk9FmvSW8VQWyR2cJv3lcxWPRW5P
         GmllxOl20iVU+mblpG4FaG4rI+dl5xIdsSHNaQdM4jzwdPAO4u1k4R6ZwCkl4okKiuxe
         uGSg==
X-Forwarded-Encrypted: i=1; AJvYcCUDElSZiGFKPuVUWa3s/XyzLlUH8q88dg1gFdLcIvHs9rIsQgiJ/XLSMTUw+qdsYdis/Zr/Sqtl7CV/@vger.kernel.org, AJvYcCUr4F/g4rPbf9/f3ONmwHuBPV2ed/nGJxhsNKur8/MuMmhp6Ft4jAkaKBZBGCSLekCa0tRjo7viNoZotvhH@vger.kernel.org, AJvYcCXN5PfrCDNKQmZD/uaWQOXsgoeQ+x4Uq4F2vk3PkBfRUp/tBpp8+MedumAMZsh5VyOvh3Guh7pfeyvx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1yXBVSn1Lq8ad+sIdeTZklM/kjuy3UM9zQYWhoDXPLKwOLzXP
	bMbkNDvkcngUM62tQjRTevLnmqpgUBXKl2wXr/fIZYl0wo/VbubbiDaH
X-Gm-Gg: ASbGncu0VV7L+SCNW4okokO7qLVwFx9gce/XiuPJzY9KhmZ0R+hUXISQ8FE4wSMLwQr
	l00DN/aH9OszQe6Tt/IhHQ2seVETqfmKQ8A5xPXUklhXWT0jkq1gf6IMaSJOOaTw9ZM5kHdWZ1h
	+/xRA/YBhFaTbgUaJBHbPVVGWezTk+1w2QnfNHukY5QuFosD++LrGfkbS7b91wqtOCrtXTIEAcs
	/P2oVWIIZl6KDyrOVHTYfc/p4wumhG3wbz6+LJTiOCVzy5uGyjKX9c5uATN9Myx4b3S3/x5O0Gc
	nP6E+IqeSJAMN9FCp2SuRhmkzD/gnGei31CivVWQcClirSZfEZlBNmoY4Go9oRmOslWCA/1DJ7i
	suDv9EDQJ7TidM1BayzOLP2ixPOtg+VLy3lMjrD/GX8vAqayTi08OPU15WR1qarGgnE7zc28slj
	DR2ZdJzxX0/KvVww==
X-Google-Smtp-Source: AGHT+IFmiWlnd15B310vYferxTJyy/4API26r1cry41N+RH+lI6moXaK617td6bWARvvVi+3eLyhTQ==
X-Received: by 2002:a05:6000:1a88:b0:3b7:664a:8416 with SMTP id ffacd0b85a97d-3b7765f4e98mr5424057f8f.23.1753620518744;
        Sun, 27 Jul 2025 05:48:38 -0700 (PDT)
Received: from [26.26.26.1] (45.98.207.35.bc.googleusercontent.com. [35.207.98.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b7883228dasm642513f8f.50.2025.07.27.05.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jul 2025 05:48:37 -0700 (PDT)
Message-ID: <606f65e1-ccfc-4492-a32f-90343be654e7@gmail.com>
Date: Sun, 27 Jul 2025 20:48:26 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/4] Disable ATS via iommu during PCI resets
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
 patches@lists.linux.dev, pjaroszynski@nvidia.com, vsethi@nvidia.com,
 helgaas@kernel.org, baolu.lu@linux.intel.com
References: <cover.1751096303.git.nicolinc@nvidia.com>
 <4f7e4bfb-1bc7-4c87-a9f1-8c8b6ee9a336@gmail.com>
 <aIOz1bzgfK9q0n4b@Asurada-Nvidia>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <aIOz1bzgfK9q0n4b@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/26/2025 12:41 AM, Nicolin Chen wrote:
> On Thu, Jul 24, 2025 at 02:50:53PM +0800, Ethan Zhao wrote:
>> On 6/28/2025 3:42 PM, Nicolin Chen wrote:
>>> PCIe permits a device to ignore ATS invalidation TLPs, while processing a
>>> reset. This creates a problem visible to the OS where an ATS invalidation
>>> command will time out: e.g. an SVA domain will have no coordination with a
>>> reset event and can racily issue ATS invalidations to a resetting device.
>>>
>>> The OS should do something to mitigate this as we do not want production
>>> systems to be reporting critical ATS failures, especially in a hypervisor
>>> environment. Broadly, OS could arrange to ignore the timeouts, block page
>>> table mutations to prevent invalidations, or disable and block ATS.
>>>
>>> The PCIe spec in sec 10.3.1 IMPLEMENTATION NOTE recommends to disable and
>>> block ATS before initiating a Function Level Reset. It also mentions that
>>> other reset methods could have the same vulnerability as well.
>>>
>>> Provide a callback from the PCI subsystem that will enclose the reset and
>>> have the iommu core temporarily change all the attached domain to BLOCKED.
>>> After attaching a BLOCKED domain, IOMMU drivers should fence any incoming
>>> ATS queries, synchronously stop issuing new ATS invalidations, and wait
>>> for all ATS invalidations to complete. This can avoid any ATS invaliation
>>> timeouts.
>>
>> This approach seems effective for reset operations initiated through
>> software interface functions, but how would we handle those triggered by
>> hardware mechanisms? For example, resets caused by PCIe DPC mechanisms,
>> device firmware, or manual hot-plug operations?
> 
> That's a good point. But I am not sure what SW can do about those.
> 
> IIUIC, DPC resets PCI at the HW level, SW only gets a notification
> after the HW reset finishes. So, during this HW reset, iommu might
> issue ATC invalidations (resulting in invalidation timeout noises)
> since at the SW level the device is still actively attached to an
> IOMMU instance. Right? 

Yup, the situation is this: When the system receives notification of a 
DPC event, the reset action triggered by the DPC has already occurred. 
At the very least, the software has an opportunity to be notified that a 
reset happened – though this notification inevitably lags behind the 
actual reset behavior, creating a time window between the reset action 
and its notification.​​

​For DPC specifically, there is no notification mechanism before the 
reset behavior takes place. Surprise Hot-plug events likely operate 
under a similar constraint.​​ (while we do have good opportunity to know
a hot-plug action is about to happen after attention button was pressed
for standard hot-plug hardware, adding code there is okay for now).

​This becomes particularly thorny if an Address Translation Cache (ATC) 
Invalidation request occurs within this time window. Asynchronously 
cancelling such requests later would likely be problematic. Is this an 
accurate assessment ?

At least, we can do some attempt in DPC and Hot-plug driver, and then
push the hardware specification update to provide pre-reset notification 
for DPC & hotplug. does it make sense ?

Thanks,
Ethan

> 
> Nicolin


