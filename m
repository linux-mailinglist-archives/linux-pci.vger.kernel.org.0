Return-Path: <linux-pci+bounces-34932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991C0B388A1
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 19:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1414602C8
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 17:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91AE2D4817;
	Wed, 27 Aug 2025 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQl9uu1F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3801821FF55;
	Wed, 27 Aug 2025 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756315745; cv=none; b=PuxwWw4GJn1Vcqab1WvQzlBDPYbPKF9ru3lDpCaipECZkrnVKWf6EYeQMmtXTbzD8IvVgKW3JpAgByJv5S9kCxLN1SW14XIfRFaEohp5Kn3PiAaQHCSqAm0MSOfvNkbqu8Bm7ogfsXh9uggymmtMDmMeW+AWc+gXuIlJCbDtpZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756315745; c=relaxed/simple;
	bh=AYHM00wFleqcrBgOnMBHJNnNIiarOCHgz0NP5habqhI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pmRWJT0WuSkiPFbjCMt3Lt0nmdc2+lk/phQN9fQU9h4ocuAMVWdDoeEzQJoogwtahPMh8VI5aX3B6UJsW5MZSQaRZSJVmlsuJRE9F/3WGqfMaaSAqZZc+jveXBSGiNFGtfCIxhDfpHK6P3Rpn+bra3LSQJplcJNskBuZaDLJBkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQl9uu1F; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-32326789e06so97730a91.1;
        Wed, 27 Aug 2025 10:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756315741; x=1756920541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8ajx9AAdwt0Apqi9zgj8i2I6x/YpQA6prHkvGVxl49g=;
        b=CQl9uu1F7IV0zvGjt96jDgcYrgCrlgkW5EA1+Xfir5YIwq1XA5/W8nGekU13Fzaozg
         6+pBjdZrczjOGBlyFjDdoSkftCePDluMxkyngoDB5NqGFesr5oyROYfAlzCfn/gnqzE2
         eDK1EUF6Fp2zjSGV/ibLpLXTmVcbpdiVDEvRSn2/sdKw8uUwY2Yib3zB99AjcUFV338H
         O67S0meTuRMm6fXWAFFM3tNi74hX6b8YNLLU2XFZyQQTi3XzgfIl17Bt/mv/MrLR4XNv
         2jhWfmPYtd8LgSg4nGsicxkHJRWpLCYaOR4YqDFXdf+DXcYLKR2ycMJx+EnMVmfKN/eW
         IQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756315741; x=1756920541;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ajx9AAdwt0Apqi9zgj8i2I6x/YpQA6prHkvGVxl49g=;
        b=hx183Lw8mzsHEC2/567tMdwrxbeOanl0SAX4/slnn5la84g1shUdhfY3zarP2vVoOU
         M3At08VqZWiPKQjkogokp/SwB/oOMTqjUJZNl5ie/7dd5B6pNhfgD5Z7gidQUK1gYSYQ
         II1It5b6MGSPtiMKd477idddvlzIfaZIdaoCyQKLsj+/1a/pVAaVhAQjkGClPaQ2ZtPf
         h+Y+/4ryIErHaOCLdMXSzW7t/7f7jazbKu7H07H4psZ7EUk9/ppvyvJdZkqBgieuOo+J
         laZIL3FpCBhrYlCNt7w4GvB4aJY1pE9FdEexwJjAJZLF045GSLO70m78S5xsqh8r2Qgw
         sgQg==
X-Forwarded-Encrypted: i=1; AJvYcCUQTkKS2vQkGmfxCGbZWUEMz0y6DLfoW+KKkP1boBIquy9eTJ/rs7uAyu/kuL5NzDUj2BLnEATTAJw=@vger.kernel.org, AJvYcCXTGCq/90TnmA6YeyM98ciuu7LsHlGLHd3lqSFZGf6NkTxhIzNdWiYtygpE/MjSvP3e7FN9Wi8iSh0BoT5Meug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbBlpqm2eFIk/1Bkc29DC+oWDXDqFGpGj/b637cx75Px65mbZY
	HXBpwcEg73CeI71EJjEgSjFbapgkmbtXiJyhl/OvcYU8dlsjtQsPEP+S
X-Gm-Gg: ASbGnctkSiFZNkPh9F2MtlgyxQeD/vK6PDZcgjKERfxSodBwUqCDujOXEbYTA/K5/Xh
	3rpav/ENAQspsMY1BOL1RtvSu2lHHepzYnvVyJLdvm0l3kSVa07vR/4hVwQlTyrFeg1MctlhkxW
	dyG+iDOfmO6DdipJMB7RZJBst8qjSMxgw/od7fiSewDjUSP842XWP1xYQb574clURU3ZVXW2PcJ
	N9ZOtyrTleaTsKw5oa1BaCs8LpXAL4ePyHEVxOv2OWNIyupPGxC9aDdQy9DLTMWuqQbnJKAdbRe
	pF3k08NIKTXC+xcCaXhBNrtPglIn29BxOzy+EsE0pa1po3ePqSt6Bu2IwEQDV7zIUDH4y9nQD5T
	qvMdzROCHOfPavI6qKSk0AL3BOjvNo3fNUu6ZKtJb/Y1dEcTjFMQ3AAp63a1BL/46BddA9NhkoP
	dQF/asKA3VoHMaFgYK7keTvjd8Wz7DfHneQKmLFGs0
X-Google-Smtp-Source: AGHT+IGyWJJnh9eNg1NCfpslvDaEk6L0UM0AifCGQaAdWKmcLwjLEEm1EH82Fa8C8fzuNPIE2G13Iw==
X-Received: by 2002:a17:90b:3ec5:b0:321:265a:e0b6 with SMTP id 98e67ed59e1d1-325177494ddmr24310399a91.20.1756315741411;
        Wed, 27 Aug 2025 10:29:01 -0700 (PDT)
Received: from [192.168.0.218] ([115.187.48.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3277c5af5absm800704a91.3.2025.08.27.10.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 10:29:01 -0700 (PDT)
Message-ID: <7fec1523-899b-4c0f-bec1-14742a2d3638@gmail.com>
Date: Wed, 27 Aug 2025 22:58:51 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Packet loss with QCA9377 (ath10k) on ASUS VivoBook E410KA
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org,
 ath10k@lists.infradead.org
References: <20250806204018.GA14933@bhelgaas>
 <BBAB0136-BB7C-4D59-B29D-2F35FC29D7AC@gmail.com>
 <l3iebypcyxpqxod5os3mn6465cwdlbnmlkbjnx3vu5bzyb4vhl@3dxnam2a7c2t>
 <176B76BC-6801-4C3F-A774-9611B43ED4AF@gmail.com>
Content-Language: en-US
In-Reply-To: <176B76BC-6801-4C3F-A774-9611B43ED4AF@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Sorry for the delay.

He executed it and found that packet losses are still prevalent:

1943 packets transmitted, 1942 received, 0.0514668% packet loss, time 
1944829ms
rtt min/avg/max/mdev = 51.186/244.746/7607.252/320.060 ms, pipe 8

----

On a different note, I just saw that we have gone to the v2 of the 
patch. In the meantime, we were actually struggling compile the kernel 
properly using Github Actions or Fedora Copr, that's why it was taking 
so much time.

Bandhan Pramanik

বন্ধন প্রামাণিক


