Return-Path: <linux-pci+bounces-25100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4414DA78426
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 23:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417C0188E83D
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 21:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C551EE033;
	Tue,  1 Apr 2025 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npplZUrZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3821E571A;
	Tue,  1 Apr 2025 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743544241; cv=none; b=tk0B3zPUCX6qfstdLZvmiVBaIAIT0NesPLYV4XSA0C2TLc0qmMQ0yw4WpdobsDi67+1zjfm2/eOrjDMbXVCsZ6PJ+77zAePf4s/8DExX9tH6iatHg5BkPyN3Oes+HBfW2y5AdruL188fPeSjvTmUA9yCymiFFRgqfC6+n3fe26w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743544241; c=relaxed/simple;
	bh=0bHJkuaxrPpTEFxxHbou9jaHnQg7M1F2cklQwab28n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqiEWTWk7dhaG0zpJYeCMx8R1pR7nABUPpCd9PLM0L8G5Fjj1CUnP6tHKU6l4UfKngQPNaT5UYOv25rWcFicVvOWsRvsVROcPfxSGYsod4+c3M6V0EfqJyD3gyC9KSBD2kgB0KWBtEra+RH4sBFVAV4T4pRMVZxrenOgLhyNqwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npplZUrZ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac345bd8e13so1013566866b.0;
        Tue, 01 Apr 2025 14:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743544237; x=1744149037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3S0YzyTLyxubq2gCXJ73TBG5EBDT2YJnQ9lVn/xP6m8=;
        b=npplZUrZLQmJaGsf4Ypa6cy4aDLX7AZyp7Xfe0eDoVNdAdY8ECGg9KppZtZ4bfelaJ
         IRtykUhmD2ld6j2OgNRDnkVxNGLayyXs/9zOczT60tFPDpIqV/JSpIw56ucscREwJZss
         7c/+c6qOZkhAWd7dLO58n6JIARDVLjxU/Q0LD/pm4xbuA0mpNTFlnJ9N6s/5HxmGEEi7
         ItnnMgkCT4jNjR9v81WzUDQgiZz/IM7N5/ITgK6ODU81jn1gfJeY807TpUdPTyYmOhZ/
         k/+ihmMFIIAFtBk3lJ8u90O6DnvDiXy3a1X4IaYnEhm1ICkWkCo5whVP7D/MZKOLAN/Y
         FeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743544237; x=1744149037;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3S0YzyTLyxubq2gCXJ73TBG5EBDT2YJnQ9lVn/xP6m8=;
        b=bQUTDe2zS+2qYTz7hzsZtpjbklsn0zVSwXhWqfSBnTeciYakbtvmKg+DPly8+pw0oO
         D+kJRHzUO0XeFBpx6HxRtu8MRAM1CC/snMVfO3VQzSCABlXXYEQgbjXtHXKV43MeNaWf
         OQmdHaHMf4cR4bWta95N3vBdmK9Ypazmwdaw6xz9U5hM/JUSEeDZPyrQU13BGDPimOtP
         PaK17knxFycfQjCeR501WNpxIUN2mRqb12j4nGEvqzGNmmEvUzIH0PaeZeC1LOdp1bBE
         JnXBvJfl5iDnlUJiB2DoCxy//F+cXr9rS4fvgyA780LNx8yyHDOYvgTzW+7M6NgOmh2K
         Jliw==
X-Forwarded-Encrypted: i=1; AJvYcCVLdSEjy9Cu+wRZ/jQrr3+XcPYh39MJOW5h/CeEyThTcbihsywflwPDkVvVa7NLMus+MNA4uOcpCT6FBho=@vger.kernel.org, AJvYcCVje6VpRRaVNokt8quxUOCqwzdIgHlJznXEn+s9gyIklIWSBuOX839MgzvGcCQAVLt6CTxDPJ7VSydj@vger.kernel.org
X-Gm-Message-State: AOJu0YwfNnBeQ0qKR+PGsLcJyheTbKjj+XkQMk5Nx8z287BLQDNCsbo2
	mpnRwBKMowAjcrkVXz8AJdI+a47Y+S+BkvCMj7NqE2403SFMxcTR
X-Gm-Gg: ASbGncvuF+sOfMNuO3sZApcpKKZzMTWtrOWNv4R+VU2g2J7KeXf2FLPWByN5jNaqrK4
	FyXo5R2lqEiXrfr7mjp8DHRl9/fRrPeL2XepYX6DEoFiP6DHMtXKoEiTW5P4OWilK+Bl3wWkvIM
	VLdompPK/rm1PdiTw47i7D21GhtpAUlMKfraeG4hPl0uSlSaqLqISJ1wAbbk4oABpLyUv0PR0Tz
	X0O9gt189lWC7tauMJlbRK5a1BYG1mPvwHIXqltmEND6BXzgTTKClpklFXXj7c0nkZxHxa4KDI9
	1Rz2zUf3tCa8DiXMM6526GzgKaXeNlSQQ0PASMU/v3LG7JWUWqQnZFgb0iMQ5hNbHGkCmxeX5xV
	yBeQnnLW8JSK4SzDMCKB+rCryrmVno2vxOAVxijq/T7J4iTwpYTHDvMlSHhbcFHeIt3X9JSwlU9
	dMPVhVQZ6DHWUQAme1XilW1u5qwsODgsuzPQ==
X-Google-Smtp-Source: AGHT+IEWB7aBQCtTaCyJTTXsXAljyXb7sUoqMsYhh97/3p8dB/tEp5YdCjaS2D73xDdc2ZVvex/Row==
X-Received: by 2002:a17:906:6a16:b0:ac4:3cd:2cb2 with SMTP id a640c23a62f3a-ac7a166daf9mr7262166b.1.1743544236765;
        Tue, 01 Apr 2025 14:50:36 -0700 (PDT)
Received: from ?IPV6:2a02:3100:b371:b100:1948:369:4ff8:2106? (dynamic-2a02-3100-b371-b100-1948-0369-4ff8-2106.310.pool.telefonica.de. [2a02:3100:b371:b100:1948:369:4ff8:2106])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac7196c8174sm829080666b.148.2025.04.01.14.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 14:50:36 -0700 (PDT)
Message-ID: <b37b02ec-59fb-4b3b-8e51-ae866eb8ecc9@gmail.com>
Date: Tue, 1 Apr 2025 23:51:07 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PCI VPD checksum ambiguity
To: Bjorn Helgaas <helgaas@kernel.org>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>
Cc: netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250401205544.GA1620308@bhelgaas>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250401205544.GA1620308@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01.04.2025 22:55, Bjorn Helgaas wrote:
> Hi,
> 
> The PCIe spec is ambiguous about how the VPD checksum should be
> computed, and resolving this ambiguity might break drivers.
> 
> PCIe r6.0 sec 6.27 says only the VPD-R list should be included in the
> checksum:
> 
>   One VPD-R (10h) tag is used as a header for the read-only keywords.
>   The VPD-R list (including tag and length) must checksum to zero.
> 

This requirement I don't find in the PCI 3.0 spec, not sure with which
version it was added. Interestingly this doesn't even require the
presence of a RV keyword. Or the presence of the RV keyword is
implicitly assumed.

Maybe this part isn't meant literally. I can imagine they wanted to
clarify that checksum calculation excludes the VPD-W area.
And unfortunately they weren't precise enough, and introduced the
ambiguity you found.


> But sec 6.27.2.2 says "all bytes in VPD ... up to the checksum byte":
> 
>   RV   The first byte of this item is a checksum byte. The checksum is
>        correct if the sum of all bytes in VPD (from VPD address 0 up
>        to and including this byte) is zero.
> 

This one can be found identically in the PCI v3.0 spec already:

The checksum is correct if the sum of all bytes in VPD (from
VPD address 0 up to and including this byte) is zero.

I don't think they want to break backwards-compatibility, therefore
this requirement should still be valid.

> These are obviously different unless VPD-R happens to be the first
> item in VPD.  But sec 6.27 and 6.27.2.1 suggest that the Identifier
> String item should be the first item, preceding the VPD-R list:
> 
>   The first VPD tag is the Identifier String (02h) and provides the
>   product name of the device. [6.27]
> 
>   Large resource type Identifier String (02h)
> 
>     This tag is the first item in the VPD storage component. It
>     contains the name of the add-in card in alphanumeric characters.
>     [6.27.2.1, Table 6-23]
> 
> I think pci_vpd_check_csum() follows sec 6.27.2.2: it sums all the
> bytes in the buffer up to and including the checksum byte of the RV
> keyword.  The range starts at 0, not at the beginning of the VPD-R
> read-only list, so it likely includes the Identifier String.
> 
> As far as I can tell, only the broadcom/tg3 and chelsio/cxgb4/t4
> drivers use pci_vpd_check_csum().  Of course, other drivers might
> compute the checksum themselves.
> 
> Any thoughts on how this spec ambiguity should be resolved?
> 
> Any idea how devices in the field populate their VPD?
> 
> Can you share any VPD dumps from devices that include an RV keyword
> item?
> 

I have only very dated devices which likely date back to before
the existence of PCIe r6.0. So their VPD dump may not really help.

IIRC there's an ongoing discussion regarding making VPD content
user-readable on mlx5 devices. Maybe check with the Mellanox/Nvidia
guys how they interpret the spec and implemented VPD checksumming.

> Bjorn


