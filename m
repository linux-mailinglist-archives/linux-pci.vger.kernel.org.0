Return-Path: <linux-pci+bounces-33136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B95B15227
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 19:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F6E67A4F53
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 17:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B244293C5C;
	Tue, 29 Jul 2025 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKVoOatt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0B2149C6F;
	Tue, 29 Jul 2025 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753810509; cv=none; b=q2HpkhZ0Mm0T1JR2Z3LYBRrpqaIJ5Xgid//xPxTfYBg4VWZHwRWm2NAgfXHttoRt+/Q6xiRrRQWJidxXFyL9df44a5/DkXC+RI1mSOYUq3xhmWRJzTCBeDbiDafASlJPO6ivw4PLAXgAoW+dL2hRzHTSUlbLtTtGOZGrFekJfSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753810509; c=relaxed/simple;
	bh=3NmNtZa5VeYSHqANC2TqiMMYhQFfpOOqO+8oQm71evE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=N2hFpI09BASGkTMFl5o6+XYs+J20/Xg8k/GVoOaDx9fD3pjJT2AVlTMOUih4/I/5d55nq4J76k8CaTpvvmmYzr7uUuMqbyFMPr/Z0my6QfsgUwiWVJf6Up5VsatDeRKwk0O3I7h1ypa5+PK8WPFiTqwvCiFYeFzTYdIpvPg9APY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKVoOatt; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso3471917b3a.0;
        Tue, 29 Jul 2025 10:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753810507; x=1754415307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HwA1RlZ6wO9TlQ9boahv87HHJljaAP2dy/gW/a+blhQ=;
        b=OKVoOatt+tzq5lY0BrURCTUkMNcN7G1Z6UANtnd499ZWuptdoHKHBcJpE/RrVsWANc
         66dLn/MLhW9euvzm7yrZEV4TjWe2z6agpbiibriOxdLN9eO7+JT9WUxWiPYVlvSXkVLd
         3GLjczCsPxkD2uRcc7PPPdsM+U3Ha3xG8y0iotfDwhIBu8KxsyGkbZlQvM9uqabmBNyZ
         t2BUb7lz830Tso/Wl8Ilkh7ttVHAgBi70ZF3p0U0E1EW1Mau2IDj2OCOVufSRw4Dl49m
         qUXTqEmVYq2PKIbYPCsKX3u4bK2WcVDVRyTzQBdmjO++qnpjqycHl11iUi0qgLa2XY2r
         tJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753810507; x=1754415307;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HwA1RlZ6wO9TlQ9boahv87HHJljaAP2dy/gW/a+blhQ=;
        b=Jr1dqqrjd64mrNNg7erPESayOd9UC5NB45Pn9+dZIm0RwTZjA/ZLzfzqCmYMJNk+Vl
         dmRe5bOxSrfSBxX/kaFLQyUM9nwLp6S+h+wsZT5ihQjUJSQisxmZBTWRmUvQJaWycVbu
         tO2gObg6QTINrscy9ibdfqjI93enn3j8v4KJIS1+sFug0tLNByV6ykfTIFPw/O8L7Q65
         gLydnCyAhNKcF0tIugYxbR0TjV0zTb6gS68GZi0m9CbDiRgmTTjT3Mfs6oswePN45xap
         QCTDfXemWp3AhV5s0zz5hKObuy71Ppn02yHSVicKvMd9BYz3vTWTdlJei0bGQbZh75zM
         XQnw==
X-Forwarded-Encrypted: i=1; AJvYcCUe6x4NIlASrmfBEGhGBrUOHmxyu4Pwsl2w1z8EwyjfeNsxAfn4zw83VHDdzOBaCd+AgSj7vj17TXeH@vger.kernel.org, AJvYcCWWKiCoGpZivlyTjUAXO4x6fYXCoTG0Tf9ry662CoYZ8nbZmrPoLTAniTCWGH8kdijVEANLeWI7vX75soOmVwM=@vger.kernel.org, AJvYcCXRbGO2cjPMCSuO4IgyA30X32J6G4LjQynzxI/ubM/4O53WEjgsCEYTZQXKvcmAKWUvS0QfEacp@vger.kernel.org, AJvYcCXpzYwA/YFlj6SfoaM2ezE68It3g4HUvhDE5KA0PSb2AVuNxarNj7bZGb2gP82yoK4i4VYkW5supAmd@vger.kernel.org
X-Gm-Message-State: AOJu0YwsIS7ibmLSQW4bqHlc8OIzzlTXz81WgwmLgdG4VsJl4mwxkYm2
	YnK3Qq5g0v3S9fUhSECcbSJ/pGhznLd/lkhnHc6FKdO/tOQYALzJ2Uy1
X-Gm-Gg: ASbGnctGwClGYMHNordS+AKuY8yUtOOuRSM4xSiSQhOt7zC4nlZxr38euuxDIEnlgKI
	2GiT5ZlyH4bPutCI1z3WX/UIDrS3viHb5doP0c5vGLvJp8z/UeFfWfpQaX/AdfC5otf1HRresRy
	xTPEY096KmWhmlto+/RnTmSuHk3mWonSVhKBC4rya3DsHIzxIFkde/9pg93bgXZaEYyrjIuBfc8
	WiBmFmmXNPbOZHRt29EwJqQwSw16p1k3tmJOFMsEnbCrTygVzYmOHogOg2aEy2LsQjX+OHRdGSI
	8brdlJO8RbB+fY8elfk41bjmdWJIVbHhc/nPAOtWuN6d7S1aST9XTh6RJPt+VfoGK9o7ZzNbBDm
	MHjCqYd/Q/Pc9cTzNWxO1DpWDbq6Cu7KnI9SPOdl0E0iK2cODH5HpCUs=
X-Google-Smtp-Source: AGHT+IE1dmaZoFNOYX+Gigetj57fT95zLeVxN+Drcy30z0zJ7kHrKOg7qJ05QcxUEd5gYQTYuwqFlQ==
X-Received: by 2002:a05:6a20:7346:b0:237:de39:7ebb with SMTP id adf61e73a8af0-23dc0d32203mr451871637.6.1753810507358;
        Tue, 29 Jul 2025 10:35:07 -0700 (PDT)
Received: from [192.168.0.119] ([115.187.48.187])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b41fda7b737sm5233638a12.66.2025.07.29.10.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 10:35:07 -0700 (PDT)
Message-ID: <04489490-aca2-4e67-8eb2-e95f223ead3c@gmail.com>
Date: Tue, 29 Jul 2025 23:05:02 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Instability in ALL stable and LTS distro kernels (IRQ #16 being
 disabled, PCIe bus errors, ath10k_pci) in Dell Inspiron 5567
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org, stable@vger.kernel.org
References: <FB546B0D-2209-4FA0-9DC9-A75C0BC9FA4F@gmail.com>
 <20250711163645.GA2294895@bhelgaas>
 <CAEmM+QiSZBoJV2n6944tYU7fcrzKRTUgsKRdqwDEkKkZiPVCMw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEmM+QiSZBoJV2n6944tYU7fcrzKRTUgsKRdqwDEkKkZiPVCMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello everyone,

I hope this email finds you all in good health.

This short email is being made as a humble request to look at the logs I 
sent previously, and if anything can be done to them.

Thanks,

Bandhan Pramanik

বন্ধন প্রামাণিক


On 7/12/25 12:18 PM, Bandhan Pramanik wrote:
> Compiled the usual way: the bzImage compiled within 4-5 minutes
> (compared to 1 hour previously), and the modules compiled within 1
> hour (compared to 8 hours previously). Also, the congestion strangely
> didn't happen. It was instead silently followed by "No Internet".
>
> Didn't add the kernel-level journalctl because I'm sure that the
> normal journalctl includes the kernel-level stuff too:
> https://gist.githubusercontent.com/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832a16180/raw/07b34aa3fa19da5afa4bb161454e3cb2081b9880/journalctl%2520v6.16-rc4-PATCH1
>
> Please let me know what you think of the logs.
>
> Bandhan

