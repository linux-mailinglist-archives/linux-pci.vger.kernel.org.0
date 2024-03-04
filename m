Return-Path: <linux-pci+bounces-4424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F63B8703D4
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 15:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA50D281245
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 14:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2CB3FB19;
	Mon,  4 Mar 2024 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8/aE0Qy"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A333B3F9EA
	for <linux-pci@vger.kernel.org>; Mon,  4 Mar 2024 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709561778; cv=none; b=VnpXrdALHOfyhzIFfsyuxUqXyN3V1CRgACJaLDFlwDZk1MnohfcUKWixfwGnz3G3Tcx8w2GvnStGkV+8A6FrtdxRceYrQmdIEaYfEO25GOfIuYyozRcGwLsgiOUzt2IfyaVzG0tV6wpb829TzMhtyXcGpZi+TLi9YKA1zzTgeD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709561778; c=relaxed/simple;
	bh=KHNz2RYwATc3OtXz1l2KR+wVmumlv5GSAIgrQHnt4qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAP/85L9gc2MXlx4H3rkZmiZ7wDzTKuOKQd1lwDzjRfXRTmkPvLOfFH4R67tFxjLtZ5QCMKXlfi3Tah3ni2RN7VDBvQsfxrJT1OKyGg9RskGVxPwd1T6AnBTVbQBTjo95h4iuNqH5EVp+qSe1LqJF/zW04WnRbc1WexwIeW1wvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8/aE0Qy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709561775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AxMA1ITHY58KdY0/RTYbDwf0iWBCMb91k01WfPC4I+Q=;
	b=N8/aE0Qyb5z5IrKTaTQ5v3UvuS2k1wF0j3juBZE7ewrXCtDf8kcoaDrg2LGlOXexyv7loo
	XYM2n+B5HVhpu58w+/L1GNfFMqvgYcpPUpOs+0EobfxVyfFVLuzbHjPA0QMiLRN3rU2Txg
	koEGApNS46i4ZrOyjFNyMemOSJs4CB0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-pL8ZCJ5lNyuFQBZg_3lINw-1; Mon, 04 Mar 2024 09:16:14 -0500
X-MC-Unique: pL8ZCJ5lNyuFQBZg_3lINw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5134251ef6eso1890278e87.2
        for <linux-pci@vger.kernel.org>; Mon, 04 Mar 2024 06:16:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709561772; x=1710166572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AxMA1ITHY58KdY0/RTYbDwf0iWBCMb91k01WfPC4I+Q=;
        b=D6b0wZWJwQ04sHc6S6LhbAPIhFfGSgw9lLx83xM7ZurpW6ubTDGzM7vwLWFd1VdSHE
         TVrUEsGjGd2T5kyUj0Ru1NwfWiPPi5uykP6+cfM5fi/wAiiJUvH8Cn9mo3PttNCGkqJt
         muFk1atoR18Np99aidJSVDNXyt6r/boaBkp2/gT7IzGe7KMEebjjoFqk+jTz0DEeWGFb
         FRyvTftNArKQKibkN6EDSU32bKMuFMVe1goTabfl53IRMLzECQIaBD6HHVTZBbI+7Zlk
         T1sE1UUJ2/tqTdxUBTGLpp7xWLWAZrD7ETw3l95cINypJMYBxCo+JENpALDogm3cgH/D
         cmdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnZxmAoZXB9isHon/D8pmGonvJoYYvUkKQ/l6qPas326uVUj2+btaRbMrABHBUSrGh74u5w+/qUhhetnr+aGsI2qaBQU076aI7
X-Gm-Message-State: AOJu0YyvR+3UdtfXyR5ALdfFwr9rZ0D4/mE+lk5pJ0Sx8e9d1PqKKfsw
	rQWm7m1lm3jZwCXuHyWPzaRk7KX462iXW9obEBtVKw327i9ls4EQm+ng976viDd1oH71Cfz3cwv
	11oMFXUi/Ic1U0TKeYy7UAYDJ5+ySneZgpN59q0hQRo5+05tPJyGEGPz4I2ut21D4yA==
X-Received: by 2002:ac2:4893:0:b0:513:22f0:c3af with SMTP id x19-20020ac24893000000b0051322f0c3afmr6072297lfc.4.1709561772694;
        Mon, 04 Mar 2024 06:16:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJrE3JSerS8k/W2Kt4MFUp9LcduuGkElUIYhAed+Ir/06A784XjIl30mR47e2I7vMUje739A==
X-Received: by 2002:ac2:4893:0:b0:513:22f0:c3af with SMTP id x19-20020ac24893000000b0051322f0c3afmr6072283lfc.4.1709561772382;
        Mon, 04 Mar 2024 06:16:12 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id bo12-20020a170906d04c00b00a456f7628b7sm679712ejb.27.2024.03.04.06.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 06:16:11 -0800 (PST)
Message-ID: <0f195fe9-834e-495c-a071-18a66aa98b37@redhat.com>
Date: Mon, 4 Mar 2024 15:16:11 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: p2sb: Defer P2SB device scan when P2SB
 device has func 0
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "danilrybakov249@gmail.com" <danilrybakov249@gmail.com>,
 Lukas Wunner <lukas@wunner.de>, Klara Modin <klarasmodin@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20240302012813.2011111-1-shinichiro.kawasaki@wdc.com>
 <gl7rsalwdwdo4rdes6akcnd7llrz75jjje2hchy5cdvzse6vei@367ddi3u6n2e>
 <a26554d3-bee9-4030-a06c-f886ba2fffb0@redhat.com>
 <r6ezdjqb5hz5jvvaj2beyulr2adwht2sonxw3bhcjdvwduyt66@2hlsmnppfsk2>
 <7935add6-a643-43dd-82a8-b7bcfb94d297@redhat.com>
 <6sbllfapnclmu5sjdtjcs4tyzkkr76ipg3i3rtqyyj7syhtkwd@d2l6zq2co7zt>
 <a5dac02b-c16a-45d1-8157-0dae1b034418@redhat.com>
 <d6a95bd9-dac2-4464-af84-9394a36b7090@redhat.com>
 <2c3gyhvwncqgfa6t3tb6fj3fk3nkbzpmlgfyzwjgwmmlnhxssu@d25ihdnpwado>
 <8afa1f78-8b89-4bbc-95e5-35eea76356e4@redhat.com>
 <ZeXWLVHxOAZCHoJZ@smile.fi.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZeXWLVHxOAZCHoJZ@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andy,

On 3/4/24 3:09 PM, Andy Shevchenko wrote:
> On Mon, Mar 04, 2024 at 02:59:57PM +0100, Hans de Goede wrote:
>> On 3/4/24 1:13 PM, Shinichiro Kawasaki wrote:
>>> On Mar 04, 2024 / 12:04, Hans de Goede wrote:
> 
> ...
> 
>>> Thanks for sharing the insights.
>>
>> Looking closer at the actual unhiding I don't think accessing func 0
>> is the problem. The unhiding is always done on function 0 even when
>> retreiving the bar for function 2 (the SPI function).
>>
>> So taking that into account, as mentioned in the bugzilla, I think
>> the problem is probing the other functions (1, 3-7) by calling
>> pci_scan_single_device() on them.
> 
> So, why we can't simply call pci_dev_present() on the function in a loop?
> 
> Will be even simpler fix, no?

pci_dev_present takes a set of ids and then looks for those in already
detected devices. That will not work for devices which we have just unhidden.

Also it is unclear what exactly is tripping the hw up. We already have
a separate code-path for Goldmont, on other platforms only the P2SB
itself is scanned instead of all functions on the PCI slot.

This patch makes the Goldmont code closer to the other platforms by
only scanning the one extra function instead of scanning all functions.

As such this patch also mostly removes code :)

Regards,

Hans


