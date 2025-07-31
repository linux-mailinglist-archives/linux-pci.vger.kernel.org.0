Return-Path: <linux-pci+bounces-33254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC087B17620
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 20:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805B43AF213
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 18:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D278B24679D;
	Thu, 31 Jul 2025 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiEw67OV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685E524336D;
	Thu, 31 Jul 2025 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753987147; cv=none; b=UE/Xuxg4CNz4YK5WUh2bfWMCuGUR7x6gv9n5WNJt6Yr5r7puZRrHsysGo1eN3CFBGfGrCOuQCGUMHQsW9xRfZ2Oqk2U8oS+0htsHz74+gVZX8AyGwZzaZwiFFH3cctp2XrOCjB5mWyDqFjAQxMIqoLLjqW7iT7J0Da4/BUyjp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753987147; c=relaxed/simple;
	bh=19i1H+jg8DTHBF04f9mNfMa3d6xhnHrDWbZEzvaBIaI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=asIZCEtC2VDUyDJ9EkjOvFTju2O8am0pMREqqJa3llWxkJ4v+4W/LqpP4jXsVxnxuszeb17MjyYTJvbzlEdQpFVrWH7hQNkrqzk74HEafY6+POQI3Xi4p9reVF+ce2RMjvmVJf+2gUUjQb2jPX09rkyHDmBu327DR06wIQsJrnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiEw67OV; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-73c17c770a7so146338b3a.2;
        Thu, 31 Jul 2025 11:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753987145; x=1754591945; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08+kTVK5TnP77fGcL4psx1wkPldZFq12gIluqSusvjE=;
        b=LiEw67OVyeiuFqiSxJhlbjxxumT2EtQAgriDtAWlFFxB9ToMqo32cNGHbte3MSBwXI
         +tgXKCobwIJyqO9n+8tkG63j4w3JPIbN+7NgZcLYMhGOFUWmJJOwTG3NOzNqEvc4Xr/w
         gnQkXbeW3OlKade3uJlZRxoZ92eX1YgQldDhyJ3t1zJ9RnCPzyhByQQsCisXD/QGhzeN
         ChyM0ZOFtvEi0nD6Kbt3mI7VI6tcBtq0915Z/zoxYLTvye+qSjjdcgSdY8a9s8EPjwiY
         alXkvt/Vnp3VtfBnpUI9nm8yIGrqGDV1RFQCXW0R3AWKLdDtxbHukBHSib+mveGtnUbI
         h9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753987145; x=1754591945;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=08+kTVK5TnP77fGcL4psx1wkPldZFq12gIluqSusvjE=;
        b=qvE0JF3nvxjQCdb3bvfK6wcnnshTqRV1k6cCq7YB/RdZG+ib2p6823pdYKkuGtuRQa
         6Og+GXz9xy6ZJ7/KrM8RHs3Wjh+gBEu4BDzjX+yQ+d/P91tS+afFsPcYIsSljkeypQ3V
         BTUbtIPXeGoLYY7ns5QaW9fyU9d4vFp2MR89Y77PNKaoeBk45DyhqKMkID9iPhS4TUuz
         oLlgExsbvi+EkIBoxn6Jr923431tG/sC9PZxCwJ4ouTY52ksc08i3Xkn5X/VKgHUlVnV
         yinNGzGL9RQLcWvUvGAH+vs2fslWj6QsAihnb75xHaPwG/oHpGqLLE6zQ2wOHhqmrP0n
         8Qgg==
X-Forwarded-Encrypted: i=1; AJvYcCUn+eOQmnKiejw4mHsqyHAXOBdkz5n/2e1dpHkfn3fVoD5/5CiwPN7UB8TexLm1R87KGOMVBTxZsws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+zN+dbzTu8/zH8emtXbcuvtaSW/1oqkg2j+4X6QKjYfeMGEV5
	dInKjUWPfxRP8eNH+pNUJhHwNM+8GrHToFVKX00ufJDnvIG0AmSbtm0e4PwJ2X5C5iE=
X-Gm-Gg: ASbGnctLeV/y11ogAnYMEWBGmYeB1zCBp8Q8OtQk0lnW7jyWDI1i+jlP5s0C3TnhQmb
	kTnwHb1dEpBzfziypWqxicIhAxLEeNhtyZB2nc4vQ5lsvZ6G1VDWZBiOeD3RRrUy/Vj/gTe+SQM
	cVLUELpb1O2QP/ZbPQk0xloyYy5+npAFODSPrrBeEaodyU+EROMkcq+AbMtv3nTETTMEY5wDe33
	+ipT3cwIcY3rJ4ImbcDqtSQg20IRDG+e6MGijHlEuveK5uMIVm9eZBKD8yOamwU5nz8aaVzrvBD
	oTjQvWUncWVLTfwnIT2yks3PGcvYbQIPpIj0fFPpaJdT01mmAXMszgO0Uj/B/QMSM+kbxzk7Xos
	8BhqAs6y2t9pX8p9f97mAkr3c5ae/2jvC1m9kClcGwsJo
X-Google-Smtp-Source: AGHT+IHj63wzFIZza3bhFHHm2SuHQrXkq+NcdithZPzDBHtJMrcMqRLH/EYYvu3LV+cDzB36l9LcKA==
X-Received: by 2002:a05:6a00:1486:b0:76a:d724:d71d with SMTP id d2e1a72fcca58-76ad724dd83mr13778547b3a.8.1753987145482;
        Thu, 31 Jul 2025 11:39:05 -0700 (PDT)
Received: from [192.168.0.119] ([115.187.48.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfecf2fsm2238064b3a.129.2025.07.31.11.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 11:39:05 -0700 (PDT)
Message-ID: <2b41300c-2034-4cad-8549-2622c224330f@gmail.com>
Date: Fri, 1 Aug 2025 00:09:01 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org,
 ath10k@lists.infradead.org
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
Subject: Packet loss with QCA9377 (ath10k) on ASUS VivoBook E410KA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I'm helping someone who was having trouble with their Wi-Fi on Asus 
VivoBook E410KA. The device uses the QCA9377 Wireless Chip.

The device suffered from a single packet loss within 33 seconds while 
running a continuous ping. There might be some PCIe-level communication 
problems too.

All the relevant logs can be found here in a redacted form:

First part (ping, hostnamectl, ip addr, lspci): 
https://gist.github.com/BandhanPramanik/7eefd192c3a728d2473687a786fbbc01/raw/e77f0fa1cf35c748730df220b0057399ac78f539/miscellaneous

Second part (cat /proc/interrupts, modinfo ath10k_pci): 
https://gist.github.com/BandhanPramanik/7eefd192c3a728d2473687a786fbbc01/raw/e77f0fa1cf35c748730df220b0057399ac78f539/miscellaneous%25202

dmesg: 
https://gist.github.com/BandhanPramanik/7eefd192c3a728d2473687a786fbbc01/raw/e77f0fa1cf35c748730df220b0057399ac78f539/dmesg

We’re not sure if this is a driver issue, a firmware problem, or maybe 
something hardware-specific.

Has anyone seen something similar with this chip? Any tips on how to 
troubleshoot or fix the packet loss?

Thanks,

Bandhan Pramanik

বন্ধন প্রামাণিক


