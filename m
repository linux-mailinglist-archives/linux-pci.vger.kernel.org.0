Return-Path: <linux-pci+bounces-38492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6962BEAD4F
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 18:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14DFF5A6C3C
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 16:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839592C08BE;
	Fri, 17 Oct 2025 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="t0ucrUBL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CABA2C08AB
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718043; cv=none; b=pPTD4Ur32Y8dTbP+/sHXqJVAjYTOsXIOFhDGQsL47zhNHl4zCkJiw696Nyczmj2OdCnh9oklEenqr28f/RcBvz33Jpuz4mdQZa0TG0bfIlZdJA7S7V4/Qcw5PCqgSc9dcBzpWGfIACGQGmIxIiCg1Bj9TF5JBp8uFqUvl7IO2MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718043; c=relaxed/simple;
	bh=gxKOH8Xdwc40yMCcxjDPNybQvl0viUGO00L2ILr5yMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=For5skFiDnKhbKGWQhQnmJ0ukOhVryGC2NEdn3HD5YVlwv91vRBO6I4wDW5su3qrsJ9mcis3lI2GCh+Vb5gmej3ZAd82U13f3cbiT7D4UMS1Zrr5jyobNM4lGbDx0Fy0cX1VYmiVqOmt+lzE0C12A6W/DvP/h1vH6IeDt/aHt+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=t0ucrUBL; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-430ab5ee3afso18128225ab.2
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 09:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760718040; x=1761322840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CVQ6phuTO84kFBkRt8EnO28DbxtrTEoiT+THIp/h4p4=;
        b=t0ucrUBLoRssJrKtvP3DBh+uDh0k5SGtZBapjoXMoaMf7wd9frsENoYcYCQpU8V71Z
         VAbienV/ZTHNxuCs+GrjYtTpm5ODskSEp5yN3CbbjUvbiwFq4YjKkSZbVz26OJ+x3sLL
         1Y4D8a583G+VJe0QCabnO4va87db47AcNmDrHkSv88DP1ca+FJlPbR5AXuTWj42voQCr
         oxLnLapdNY3Q1OkCs+WmbG9fQXs2Gft53TNQX3xwnPWZBXg02vz5uL/HPVTn6TtAS7tf
         Hw6aHBUJWM+DFqyDyvnU5gUle0/7XcAwmuzhmrRNNLhMw4DQhvTYK2QXIjmkmeS/83Bc
         A2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760718040; x=1761322840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVQ6phuTO84kFBkRt8EnO28DbxtrTEoiT+THIp/h4p4=;
        b=m4NDSaBL+C+YHlGm7q5mKqCjcF89AbQKMuvIQGlAF3kYhUfnLe/mwHR+GzzuQbZblV
         SLnjY/DSoJiWgUwrcjc35W+hf830aVfcQ3eTfPBtIp9Uw2sgmNjBBMQbZS7YRh4774fS
         MR1j6l0m2AO7+L1B8TtZhVP33EKT+dMf85bbiRisTFiPlJS9gwA3Rx8Gk189FgL2M+ia
         J16GZN5ioMlwDJyTgk2j2Ju5ZfN/5wIlQA/rATt5SjgBImD1Vti+EwZdVeVEuiq2lKC4
         980innKfx73TmTnLr0uzCQhsrzS/HftKQZ+f1jN+blbcYybxyZft9hG5o1Naj0uPnWkf
         dEKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFO2qG+1HNcg0gpoJ3NgwdSpZLYJM9J/WUUJqspQ38UKK3/VO8EJNruF/4DsYR+ZZUk8C5D1zXZ4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7xy3hbyLmRLSSbFmszPNlcMZkz4E7O2YzSSVcUTjL/2bSfXa1
	ZiUif7/igo1bP+RYRv8wbJWGXrewqGrhr97+ehY6rnlQzonktj+Zx79bjB+JPfYUzOo=
X-Gm-Gg: ASbGnctQ/7O8EbtKS0qWjAUFPt1p619byq0aEOisOvGgQfjR3GPxTUhZiGmgNBTPBcK
	Mtp2wGBZG6jgBOI8AHn2nDgZIf4TJ8zr4MAGO3PcqUMWnSy6XtJ2zaJAK/ME+/Ucl0sbxtc99Hg
	CWEhoEAT4WbXgq07ZPFCSTcqY33OA+5zLKploEsPrAtO7hm808KY/QjwpR3jVcComOKg3hV/v+t
	EQwRq50EMGPzr9n/1PRst4fbeA4G6ag8Vp6ztNH65d6tnVMdBAVptcfaRRFxdRQFsihoCUpnUyd
	iETLuD4R70QrT50V2LUFrBdzlnwDQiygzxOc6tZFwF4E3DySNH+jgCyz1Zb/XZOThy/+uHk4GQd
	b89JHiJlpG17RHFPKZJkdDymmBaBwYWhzGLrZ9Y3VjqFBxmWrF/mQGEDrUI8K+x5fDKe36gg+/h
	i4LPRB2IgalIbxhEIWvnj2TkAmbVXuGVmaV6jeON4=
X-Google-Smtp-Source: AGHT+IHkLguz0srIwb9Y0kZ8Jj/SerEa4TnF03jUDSOPF34f5dBqn26UDMGx8TBiPYMDv2ZC0jD7cw==
X-Received: by 2002:a05:6e02:1d9d:b0:430:a65c:a833 with SMTP id e9e14a558f8ab-430c52ccf5fmr57021215ab.31.1760718039725;
        Fri, 17 Oct 2025 09:20:39 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a97689basm12877173.49.2025.10.17.09.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 09:20:39 -0700 (PDT)
Message-ID: <3ccf196c-aa57-4977-9dea-a54172e427fa@riscstar.com>
Date: Fri, 17 Oct 2025 11:20:37 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: phy: spacemit: add SpacemiT
 PCIe/combo PHY
To: Rob Herring <robh@kernel.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 vkoul@kernel.org, kishon@kernel.org, dlan@gentoo.org, guodong@riscstar.com,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 p.zabel@pengutronix.de, christian.bruel@foss.st.com, shradha.t@samsung.com,
 krishna.chundru@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
 namcao@linutronix.de, thippeswamy.havalige@amd.com, inochiama@gmail.com,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013153526.2276556-1-elder@riscstar.com>
 <20251013153526.2276556-2-elder@riscstar.com>
 <20251015145217.GA3554740-robh@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20251015145217.GA3554740-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/25 9:52 AM, Rob Herring wrote:
>> +  resets:
>> +    items:
>> +      - description: DWC PCIe Data Bus Interface (DBI) reset
>> +      - description: DWC PCIe application AXI-bus Master interface reset
>> +      - description: DWC PCIe application AXI-bus slave interface reset
>> +      - description: PHY reset; must be deasserted for PHY to function
>> +
>> +  reset-names:
>> +    items:
>> +      - const: dbi
>> +      - const: mstr
>> +      - const: slv
>> +      - const: phy
> I think phy should be first as that's the main one to the phy and the
> others are somewhat questionable. Otherwise,
> 
> Reviewed-by: Rob Herring (Arm)<robh@kernel.org>

OK I'll arrange them that way in v3.  Thank you.	-Alex

