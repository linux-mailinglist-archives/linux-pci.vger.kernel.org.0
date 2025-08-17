Return-Path: <linux-pci+bounces-34137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7CEB29272
	for <lists+linux-pci@lfdr.de>; Sun, 17 Aug 2025 11:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3ADF1B2109A
	for <lists+linux-pci@lfdr.de>; Sun, 17 Aug 2025 09:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B341B424F;
	Sun, 17 Aug 2025 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDJk5aZ7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992D71D6BB;
	Sun, 17 Aug 2025 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755423515; cv=none; b=MS82D4PSnb9uDmfjXtJVxSpDRpisWHa6n2EIfWVrEK8keYDO/N6w7rNubeGiUrAErz9U/4JzQWMn27B39sZ5SXsiVRriC3EQVqOAg6LnMBE91wDgEYyo5vwyGTYbZhtgwFDcyxSFTPBF3aV0aL+Jkmo/kUdPvbo+5HC7wnRPD78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755423515; c=relaxed/simple;
	bh=c8YRrckfoSfijJ8+9Yeqa5yV4ks/1VCihLQAEoIt5LM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aW06BeHyPzutQrv7+SuAF9gpmAqwSZACcamvXOZAYYXWr7b3P/+7vGilkWeJ2g8B9RVPWYDEGcQ89/tbpPqlnROvmwoNXJ1D1kUNQb4mXA+FY/riM0HFZwFeXkXT6Cf9nF+XT5l5wJ0/WaEhKoWdr1saAvyRSc3sfFBXW4Ix0GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDJk5aZ7; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-24456f3f669so31185495ad.1;
        Sun, 17 Aug 2025 02:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755423513; x=1756028313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V+glvcUxBNLETyj4EbzaF6Mcl14MmSj24IXXGqr4BWU=;
        b=FDJk5aZ7IDQGla/M8atFp6I2vlUA25wSdhpURbZp0L39pDptwxJAqMqFMQ7PF74RfV
         txBTx5SPrP/yoslhdlGQRhk1xG9ALUOXkisNlXaHqg5CaY/+Oac0ifcEvuPbV01PwhKc
         fFZtjguOcXRr+tWo8141HDd945eEMKMML3cfYr9v/BlfKASTlaOefjRYn4FBvDMlLUgT
         g8Ldsk5AoXe0uuT7uzDGuACieCxToFMiIUw/Y15NkwqTXYVx2IYCAfDtoFC5xjDKjxGK
         ryegQ/o2Hz2T33hS2d0gwhdV4IpRCFALNI0m0LlE+t5jnL9waJTgZHxrlIgHl16R/vJB
         ofyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755423513; x=1756028313;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+glvcUxBNLETyj4EbzaF6Mcl14MmSj24IXXGqr4BWU=;
        b=gyouzOTv0w5uiDLU9QrjdgaSi84h8Cguf7kxnBWVrvO9EGclDEb8gRuKCNEu1W+9jV
         NTDPo86CAoOcpq2yru2dMVAb5nAnI3iOpvSrNXZaP007/7u/kFj7RGTDuNmOmAOvA52f
         yp48DnjE6NyDkbh1ZRkPl4zOpPB6LIZwmu+rEuTh03xU4yz1Nb9hrNMc+6Hm7fz0f6oM
         3erZ1ennEwyaP9qWNlNVdgUlxWX9kUi1KHtCmpWNuMAqH38dN/Tu/T0DgDHqd+2GT9HE
         rNUavvj2dxlF0DAHq5J2IWwXLIrKwJcu1vFo3RP8u1//U8m/KW6Jdl0X/l9PyOMA2FGr
         tGjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb1nqblZsT2oYBOpwa8L+nJhS3jOUmrxNfslkZk3VpcfyeLLcwfuakEtzAWPb2LYFUchz/jfqA@vger.kernel.org, AJvYcCVoc40OAZFBxXqoC4TKM1vvAo0SF72V4LGcECkgDgYu1h+GbYelMHDeTjfAHWa+vdtZiGACWAJdBWVylKp95b8=@vger.kernel.org, AJvYcCXkPWLBN0RweAs1hCW1RbiNkPEw/U+ALCFBXBKlNOvCXXIDNwL2dVpz5AfEz5FoL2cBLNCNCcgImYj4@vger.kernel.org, AJvYcCXs5tW9MxIb60DdceIphpFwtn9WrMLbC2T68VZL5lyGhtp1zL8NKOsPtfwTVCgbZHJONeTmSscXeEEL@vger.kernel.org
X-Gm-Message-State: AOJu0YwmbfdiP9KxQZodKPnfo/dBaDrzKz9HMl2XoKUO3RAb18dNaMD0
	uaGhctPXTCW3htiwfWpkW4NUMl+7swauSMjsNHhXdL4ns9xZjZ/8DOTLcsfOVGrbnH8=
X-Gm-Gg: ASbGncv7q/aBqq98QQQGozmt9Ffi72XeasehPZODvUl7vziOqxL1+F6Op/dxJz/vWJC
	owZX8Frm9Mc7VyPsJhIT86V11xu5p3YEeB6Q53R4xUe1geNt2HxG1lizuW6pu1WoU4sAMmLjcmU
	uCQeGBn0dtW6GJhHq+JlwzgfG1zSzwesXQFBmYdhsx6uCkq7jJmgKKIN/rK4UNjTv39hdx++vHZ
	Cp+vngYJekk3tqcklfpgDLRUmheYnJZAWwR8m9H7Tt8SEbDT/afU80zxzJYl/jOK11v/tRENDb0
	PIJPFJhnu9Hr6P77Edg9dVCScGWKsKFZuZYf+AVUs0ZbxuWKAoKtxNk1l5hl1DrTYhPNRYiOCMC
	x0ZoddmeV079vWbu4UyblpAi6yLVUpp/sPw1lmOrZXteANewAZylPBIL4
X-Google-Smtp-Source: AGHT+IHkGdbvw5mBqyT/2JEfiXA/xt9ZKA48sqXHZkrOlalPiagbZZCBEljY1VqxFuyOzhpXRp8Wcw==
X-Received: by 2002:a17:902:da82:b0:242:b138:8119 with SMTP id d9443c01a7336-2445988787emr180301885ad.26.1755423512654;
        Sun, 17 Aug 2025 02:38:32 -0700 (PDT)
Received: from [192.168.0.218] ([116.206.223.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9d02csm51916845ad.7.2025.08.17.02.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 02:38:32 -0700 (PDT)
Message-ID: <db9749a0-9c6a-4781-b5fd-82eb129a9c36@gmail.com>
Date: Sun, 17 Aug 2025 15:08:27 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH TEST] ath10k: Testing Mani's ASPM patch (QCA9377, v6.16-rc1)
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org, stable@vger.kernel.org
References: <FB546B0D-2209-4FA0-9DC9-A75C0BC9FA4F@gmail.com>
 <20250711163645.GA2294895@bhelgaas>
 <CAEmM+QiSZBoJV2n6944tYU7fcrzKRTUgsKRdqwDEkKkZiPVCMw@mail.gmail.com>
 <04489490-aca2-4e67-8eb2-e95f223ead3c@gmail.com>
Content-Language: en-US
In-Reply-To: <04489490-aca2-4e67-8eb2-e95f223ead3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello everyone,

I was actually trying to build a kernel for someone else using build 
automation scripts. They still didn't compile. (Here's the relevant 
thread I'm referring to: 
https://lore.kernel.org/ath10k/176B76BC-6801-4C3F-A774-9611B43ED4AF@gmail.com/T/#t) 

Regardless, I tested the patches by Mani 
(https://lore.kernel.org/r/20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com).

Here are the logs:

Without pcie_aspm=off (did not work): 
https://gist.github.com/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832a16180/raw/84edf89740919e3cba2ac33e567110b14e2d3627/patch-dmesg

With pcie_aspm=off (worked, no issues observed): 
https://gist.github.com/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832a16180/raw/84edf89740919e3cba2ac33e567110b14e2d3627/patch-dmesg-pcie_aspm_off

I'm not fully sure what the logs imply, but thanks, it did work even 
after playing YouTube videos for two hours (might not even work in the 
future, cannot be certain). Earlier, my laptop had its Wi-Fi turning off 
within minutes because of IRQ #16 being flooded, in every kernel I 
tested so far. Now, it does work.

There can be seen certain stuff in the second log, where it took some 
time to connect to Wi-Fi, but I think it is mostly fine.

Thanks to those who have prepared the patches and those who did bear 
with me, but there's one request I still need to make.

For anyone who has built patched kernels for Ubuntu and exported in DEB 
files, I would appreciate any guidance or pointers on how to do the 
same, as my efforts to use "make deb-pkg" have been futile: 
https://github.com/BandhanPramanik/ath10k-patched-kernel-ppa/actions/runs/16975573959/job/48123563881


Bandhan Pramanik
বন্ধন প্রামাণিক


