Return-Path: <linux-pci+bounces-39880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21979C22D9B
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 02:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 855A04E3886
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 01:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12766225762;
	Fri, 31 Oct 2025 01:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="iMipLv1m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB9813635C
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 01:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761873384; cv=none; b=Lwvaha5ny5Z7espvLyWF2lu77RXnCtRtsTJqVoRM6I/SVaez6bY5aJaDNGGvyUKCF5VIOcXx6RCqJa9MYS7mzHNSrdbsqeQfC/wuot5yOvyT5En8GJ4cb5YrrcxRUCunZw4BkZqofHHy+/oxnfoxBagSeafxFqbZIBXFpdBvYEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761873384; c=relaxed/simple;
	bh=4Q2e8S4JOkL/lipbI1pDbE41ejOeT3F2JXftXOKS9SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aaP6pHDRmPCRh3C99jN4Fq7p6xFrWwNpjGF5utRCpV1zFWvAD1lwW1zWdglyyZuKNRBT7Cav/ZfwNcdZBR2LfJf3M64+FcRuS1wntlVxBqxlGdX2h8fDN2GAnHsNGM8008uyIF+ld9Eo2mcM2iLalctRQTotcLBAKLLEitDE8oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=iMipLv1m; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-945a5731dd3so67178139f.0
        for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 18:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761873381; x=1762478181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BNmWvB1sse+ll8fu7wLpbE6Pu2iBxbQUEY600bj95+Y=;
        b=iMipLv1mDx1Fjt+5AFoaW4WjxKtXSuyHyYXkC83im8Gj1CbZa7RQwQ42uDzZz8zRhS
         DDbhxScj3qaRPRvOP0ylTegZtYsy+dEOUnGcyKSPZS4pS/X1VfCqjjIKtoAIYGUAl//0
         wpAQalYv+W/bT3Ms0YrrCGF1ftueNbupOGSomXaOOjuNPDDJZG5rc/oE+TsRANIVvFZU
         ZG32wP4gXin7xFEsWfDtdQ3mRxO3om7AJDqaLxN3IAch/UJoEKCM6zgoe5+CNaWyq6tT
         1GyjcX+/lmgqDbbkt3fX1ZUVWpMNylQGmFxHmAsLUwIPNUd/2TwXjqeypIFI/G1anWs/
         kNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761873381; x=1762478181;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BNmWvB1sse+ll8fu7wLpbE6Pu2iBxbQUEY600bj95+Y=;
        b=oRmMXURHEzOOpxj6KHcIBypC1kOAAib+e3XLsnciWfbQe3sJlhfMdThCvlqUFuj7AN
         G7/v3z0EiqCyutZEykEPyejGn4o72vDUOeGxFttV1TWCSgLbw30crf9ibjQO7S8PugtC
         V8i4Q/2Xa6xbgnuodSowDD9DvatVHIUjLNjg6B492VjkOmV3bj1AiWMi25nvBv+rDCn/
         2eCbkNbIuL4+MQ0U3QEIvi1d+3ChtAxBhJrD0CMcTW+dez405/YmvrkUdshL3hobWXjS
         D7ymjNu9qsNhpezpCT3v0HIYfDtbuvFb/XZAAnnTuXR2YZD+BDtidXdcQrgRzJKPHQX5
         NJxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAoOel/A9tEMWu4Ul9Nwvy82mN5vkb8d1vPb1HYymJcYyL7p2BBhlVAxCdf0N77hF2vYCACQvHBUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo0In4ct6cNtoFodJ3tS3LKCG0Tb/6vW5mzpcy3zfFweE/6rfL
	/qp2LDjcDKDnvXA+Rxx7c1FHqD2B3V4L3WTlFJZ5Iqx2lYr899DAaysctZiULRFWTgI=
X-Gm-Gg: ASbGncu9lnKUGLcbB6Mx10jafeI3Y19K/fk7fxYEn/jn7MprZyWlJ9A9qcskHJKhvS1
	1vkrzNukhPr4bQPjy2F3tSP2W/NOFy1JaCTKFMPWXX8T8M+R20TSzNYHOT7kV12VgZt/Oj54a1l
	3envYv199nH5Z4JCQp1Usyw4qTeJyk0VssxU4UQU2oXmgZrC5xyyzNFnQZee4amkkmeSToozO5U
	fiQVNR5yK3a5VFkt3rTsovXj7ZaTWkgaN2vhc5Ygynd6yHIoDEXRFDUlLogJBSOPnMGvYK3eJdT
	ZA6xC3J+rmpIbGBTpw/pFUD9qEXbQk1s5pJ4wwDgqUlMo6QSPb8LHIIFYmykwbEBPBK3Qi2ESPr
	Jpf46WxSwdfsIZBXnEk0KZZrk0xRORNYXOicDUk+HAWGImpGNgZB+NDKLz05Ku29Axl0gaL4vnS
	rUYobt8uwXt1GHTim6SgGIOz8kPGSZ7c+onE6jRV+2
X-Google-Smtp-Source: AGHT+IF4xxWwH/4LfxxdEtp/ZJLyhKDeHy5QKQAhJFjWBy4txu4y5k6mqZ7NiiibuaIjhND7W09bcg==
X-Received: by 2002:a05:6602:2c01:b0:940:d7cb:139a with SMTP id ca18e2360f4ac-948228fff16mr371985839f.7.1761873380679;
        Thu, 30 Oct 2025 18:16:20 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b6a5a981f5sm144822173.46.2025.10.30.18.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 18:16:20 -0700 (PDT)
Message-ID: <f1bec6f4-bf44-4cbf-a676-fa81d81531d4@riscstar.com>
Date: Thu, 30 Oct 2025 20:16:17 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] PCI: spacemit: introduce SpacemiT PCIe host driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, dlan@gentoo.org, aurelien@aurel32.net,
 johannes@erdfelt.com, p.zabel@pengutronix.de, christian.bruel@foss.st.com,
 thippeswamy.havalige@amd.com, krishna.chundru@oss.qualcomm.com,
 mayank.rana@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
 shradha.t@samsung.com, inochiama@gmail.com, guodong@riscstar.com,
 linux-pci@vger.kernel.org, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251030230801.GA1660222@bhelgaas>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20251030230801.GA1660222@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 6:08 PM, Bjorn Helgaas wrote:
> In subject, capitalize "introduce" to match history.  Or you could
> just use "Add ...", which has the advantage of being shorter.

OK.  I'll capitalize all of them in this series.

> On Thu, Oct 30, 2025 at 05:02:56PM -0500, Alex Elder wrote:
>> Introduce a driver for the PCIe host controller found in the SpacemiT
>> K1 SoC.  The hardware is derived from the Synopsys DesignWare PCIe IP.
>> The driver supports three PCIe ports that operate at PCIe gen2 transfer
>> rates (5 GT/sec).  The first port uses a combo PHY, which may be
>> configured for use for USB 3 instead.
>> ...
> 
> I guess this doesn't support INTx interrupts at all?

It can, but I removed that support first to simplify the task
of converting the original code, and second because I had no way
to test it.  I planned for it to be added at a future date.

>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -509,6 +509,17 @@ config PCI_KEYSTONE_EP
>>   	  on DesignWare hardware and therefore the driver re-uses the
>>   	  DesignWare core functions to implement the driver.
>>   
>> +config PCIE_SPACEMIT_K1
>> +	tristate "SpacemiT K1 PCIe controller (host mode)"
> 
> Move this to keep the menu items alphabetized by vendor.

OK.  I was going by Kconfig option name, but now I see
what you mean.

I'll put it between PCIE_SOPHGO_DW and PCIE_SPEAR13XX.

>> +	depends on ARCH_SPACEMIT || COMPILE_TEST
>> +	depends on PCI && OF && HAS_IOMEM
> 
> I don't think you need PCI or OF.

You're right.  PCI for sure, but it doesn't look like I make
an direct OF calls either.  I'll drop them both.

>> +	select PCIE_DW_HOST
>> +	select PCI_PWRCTRL_SLOT
>> +	default ARCH_SPACEMIT
>> +	help
>> +	  Enables support for the PCIe controller in the K1 SoC operating
>> +	  in host mode.
> 
> Most help text includes both the vendor and the product line names.
I guess I didn't include "SpacemiT".  I'll add that, and will try
to come up with a few more words in the description.

Thanks for your quick response.

					-Alex


