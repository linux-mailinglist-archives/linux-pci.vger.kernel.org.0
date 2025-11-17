Return-Path: <linux-pci+bounces-41432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EF2C65774
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 18:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B203B4E72F9
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 17:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7390B32ED4A;
	Mon, 17 Nov 2025 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="SrXRGYrZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E760B32C93C
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399569; cv=none; b=Dlqjd6wSlWuOHmk0BzY/x8N13yY1U6jfb5Xe4bpjZ8RjDlno0+hukjb+zP9YPzWyrNlQjyxIRw2j5/bqcu7/0HvJRooitoL7D5qau28Y+IL7YCkDwkR04lUHTIdts1sGTuV1xLvZUJhlkHoGVj2vxZESiS6peJrV2uUJRs8cXMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399569; c=relaxed/simple;
	bh=nmhM4LSVMsUor5QeIBHpH3224iyADx1BLXHEi4pE9A8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3H0F7RJcZ6vqRQ354X/V8nFURbPQNREvVkafXOF6Vz68l/F0Ax647kyLpeYgNFH4oTwmBvsU7u+MyQOPuY16uNpCKmp31mxWOXJu5tkI+uAUaFG7RyW3UNqGp7mLmSzeDv+knKDDAnvxVMDOg+AvegkkDBTZQuITSudsjCQl+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=SrXRGYrZ; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-94822ad1baeso332549839f.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 09:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1763399565; x=1764004365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVyQ1lgChGCDzR3SsqjIRgL3e2y5+BZfD9Zpt6v7tGs=;
        b=SrXRGYrZXXbnrJRWeIKeGeL/8WDjcUC4s6ncilqvNzfFQD/U4xbwiJuaqK/NOh0DA0
         o0IxFFtF7eOHVHyCoJ05YXoNPJem7yxHTwjLj1ZI5MBT3kY+8D/zMX7cxTBDZmBUudWE
         hazUieVJvXz5FjNrYYLZKjnhiDuUHWr+BLsG8QQs9CkQfOdbwD61XhlqQ/Ni8WtnWrFv
         TR/kiv62OEFZChU1LGT25IGmMqI+r1PVBLur1MP+nDlDbA9q5THVc/EAa4rpqO19EgNL
         632NrtfRprRL4oSMqhBYS5Tu92z2zMExnCUnWr1aYxTJS0EB8W9WvmCdpfY8SkA85RyQ
         woDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763399565; x=1764004365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVyQ1lgChGCDzR3SsqjIRgL3e2y5+BZfD9Zpt6v7tGs=;
        b=R4jfMEH+AWYyEvqB1giuG3fRO4q4KoltPthJz9JAiOUyc/pBQsKdhlg4nvLTkt7byu
         sYVgOwZ3NcEzhnaqc6Z94u+TNBTzw+jNcVVV4G5Gsl/lzHpnw7CVPQfmS7N3JLK/vFCF
         8XEL8WMCQ7EU7uZqBty0T6mjrujeAoCQ8Q0r1LD2ZySSCaVOREJ871SX5pxtOfk+UqwI
         RWTO8CF6gTjz8Wio+Dt9tz2XqPNeqkey7Hg+OHXvQDUlf1XnQMQbszYVebuAota0ErZC
         9Bw4nl3e6hINCFpkpJlCfTjQLxyAJk48l02YZvTnBPkbHJv+RWw3c0iB18GUKGTM8lk2
         pZuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlION+5WV/725EzUI4ibRV2PgRuzZE7HLR/jeHOODYTME6MS597A5o3UB2dLmVt0T4cvv2fZYQQ34=@vger.kernel.org
X-Gm-Message-State: AOJu0YygnMfNO12oo7BE8/WMExzArIPAucuwnxU2x2H2JyLyz5PEcca1
	7YKfLWX9JptutqE0HBRjNj3X5fIZTNrfsBZnq+1AGFjHKyflNc3VkInfG+7aGm0ShDE=
X-Gm-Gg: ASbGnculKsJmzxaUtAdoxeScKXnJAcY0nKJfZ+HGNvMx+VPAK4OCtDAl5mmT8vW3U1W
	2dzcsPAFbH5vyDhst9gGsEWYn8T4fAWc8hfqdKlT4qNfMzhNRQPkprwqEjnYwyBURXYyLgKX+yq
	SIRe2yThKmfYIaPoy1e5H1z4j+465IxiqleCnJ5batDdeS/TGsrPZOdeL7A2puTMHtnzK3D6hVg
	eKDIqdHqoJOuoWodtKQhkNXHTeNg7L0Ufo6Zi1leYCRGclOViGr/tz9V4A8tzbPbMKjDunf1/s9
	D1mLrnS02PVuKFrymHMVgF7jQvmAfzclJR9iDohEA/IKHPQ6wkTnSO+VMLwEaZbb6TfJJbmbUEU
	alrHkVlGQ+dR4UXqJJ4/xe2wCe8099pKD7IoRRxLnffKyHtypciEaDTHlzQJxEVc0jSlDq9cCAn
	xfZNqunPepi2btlYH+OiPKNcinC/JqDzObkJiBC6btRyxiohG7sSROHvZj3DnG
X-Google-Smtp-Source: AGHT+IFGKqdRJLV9RQOyvs5MvCac0JQUqvPl4j+mCywXmiQhs/UBqawUJsZSrZzGsMyRTHumxUBE2g==
X-Received: by 2002:a05:6638:4b8b:b0:5b7:1ebd:4d11 with SMTP id 8926c6da1cb9f-5b7c9c45d2bmr9122365173.3.1763399564687;
        Mon, 17 Nov 2025 09:12:44 -0800 (PST)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd24d5e9sm4708226173.3.2025.11.17.09.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 09:12:44 -0800 (PST)
Message-ID: <b9769b9f-cbc4-459f-911e-f29f848b6ce7@riscstar.com>
Date: Mon, 17 Nov 2025 11:12:41 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] Introduce SpacemiT K1 PCIe phy and host controller
To: Jason Montleon <jmontleo@redhat.com>
Cc: dlan@gentoo.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
 bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, ziyao@disroot.org, aurelien@aurel32.net,
 johannes@erdfelt.com, mayank.rana@oss.qualcomm.com,
 qiang.yu@oss.qualcomm.com, shradha.t@samsung.com, inochiama@gmail.com,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 p.zabel@pengutronix.de, christian.bruel@foss.st.com,
 thippeswamy.havalige@amd.com, krishna.chundru@oss.qualcomm.com,
 guodong@riscstar.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251113214540.2623070-1-elder@riscstar.com>
 <CAJD_bP+AjhNCB6kCeKdnXERjP9j8dhbCejnS1OVmFf_VShti5Q@mail.gmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <CAJD_bP+AjhNCB6kCeKdnXERjP9j8dhbCejnS1OVmFf_VShti5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/14/25 10:21 PM, Jason Montleon wrote:
> On Thu, Nov 13, 2025 at 4:45 PM Alex Elder <elder@riscstar.com> wrote:
>>
>> This series introduces a PHY driver and a PCIe driver to support PCIe
>> on the SpacemiT K1 SoC.  The PCIe implementation is derived from a
>> Synopsys DesignWare PCIe IP.  The PHY driver supports one combination
>> PCIe/USB PHY as well as two PCIe-only PHYs.  The combo PHY port uses
>> one PCIe lane, and the other two ports each have two lanes.  All PCIe
>> ports operate at 5 GT/second.
>>
>> The PCIe PHYs must be configured using a value that can only be
>> determined using the combo PHY, operating in PCIe mode.  To allow
>> that PHY to be used for USB, the needed calibration step is performed
>> by the PHY driver automatically at probe time.  Once this step is done,
>> the PHY can be used for either PCIe or USB.
>>
>> The driver supports 256 MSIs, and initially does not support PCI INTx
>> interrupts.  The hardware does not support MSI-X.
>>
>> Version 6 of this series addresses a few comments from Christophe
>> Jaillet, and improves a workaround that disables ASPM L1.  The two
>> people who had reported errors on earlier versions of this code have
>> confirmed their NVMe devices now work when configured with the default
>> RISC-V kernel configuration.
> 
> I successfully tested this patchset on a Banana Pi F3 and also a
> Milk-V M1 Jupiter by making the same additions to k1-milkv-jupiter.dts
> as were made to k1-bananapi-f3.dts.
> I no longer have problems with NVME devices like I did when I tried v3 and v4.
> 
> Tested-by: Jason Montleon <jmontleo@redhat.com>

Thank you very much for testing this.  Your Tested-by is included
in Mani's commit.

					-Alex

