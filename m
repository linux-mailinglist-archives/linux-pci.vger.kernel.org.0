Return-Path: <linux-pci+bounces-39577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F437C16D17
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 21:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53BE81C20D8C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 20:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0AD33DEE8;
	Tue, 28 Oct 2025 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="bs8NDvL4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com [209.85.166.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29894502F
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761684600; cv=none; b=MaE6rU5NqnnFxayZPQtT2Ni6wZ7Qh8+mGLHju+9bHYJEJ7EJxEvEUEi5IqAHbW6eJyk6cAWGeM3ldZ1ZC+rdOszhy1rO/QG9H/S5w10V+4MPYlTQby6hN1KJeSojIcwnvOhgxqgPCOhErUkQmFxarCwqIR9bcBzRMP+eOaGxUN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761684600; c=relaxed/simple;
	bh=FKJWPmS5QgnY3R2AdTz5RMSJOELWW0vWKsMJbBFymPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4Mmwvg8Jbb0SNPQenZb92ob8p82nO7H79jJzXXNtLPxkRmSKRhyB3yrGJYswTuDmQHu+t5qbp3640aJXVHgPupfJdpgm9FqdI9nlONQKZz+0rTifJrVvGnBLE/YUw++v9x9NK7QEdki9E2906dsZ8fA95RMbdQo4yxamCCXgkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=bs8NDvL4; arc=none smtp.client-ip=209.85.166.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f196.google.com with SMTP id e9e14a558f8ab-430c151ca28so28071145ab.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 13:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761684598; x=1762289398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6TldsVLxc7ZpZ3BCidhfMeu0Nkd2dELKLkuMBzPbjk=;
        b=bs8NDvL4TkV9Yr5/sWWuZbbaScMYRyQzo52bR75MPu1Vjyqm0fxOFiumx8WfDGHkea
         XA7c2cAxbgPa1Ee6NQJzOTcIzUHaZbbun1lW0K/kqB37llWGHTCR6hOK4UHpXNicxgDm
         J7konW3qL9+6LUf57Z0Wun92PbW/RDsxiTyanwYMwacdEPiNZEW7l1LfH9E1PcYtLryt
         lWCd7L/eugWwjlgb7eHuMLpPO9yW4g4x5X9o+b39nsDjTojl/vjrZ+DxH0cLdEAPIqvL
         t3L20gswBakNJBERZaXkG7NIVhBc6+SttNbX5OpDNtBny5QMlUWfhnQnJMhqVWV9CKJD
         qBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761684598; x=1762289398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6TldsVLxc7ZpZ3BCidhfMeu0Nkd2dELKLkuMBzPbjk=;
        b=Q2r2mDXNIKBM5SF+QoIujhyuUvbODW9u5XKT5z2Ow1NLSEMRBJjgjTmWbMw/MOGS0G
         go4biEak3J9NBUa8L/82FtbRnt7720KYcPIVStBSHirBnxzguW12BD3uwA2bIhe12FU6
         DOWRr9PvAwnU9JxJGKjDo4gZI5OgnTzhjDhphjbwoojnOWC5d+rdfSDlMqLsEzGPUmc4
         36qf8PiK2Gp+sN3I/F5EfQSec2ABx6bSIW53Ihr9YZvNkizcDDQtC1/C0gD+sS3/8h4C
         f2qpWDJZ+qhx1HnCgs5kc+O5Qtk9qCFF6l3ovK+Sof4+GQCxGQrtkxWPxJGfkLlawxZU
         bBpg==
X-Forwarded-Encrypted: i=1; AJvYcCUFnNRB5RrnL2CxpkdxamFy+Q+66+u3no2XmVwg50XifKw53aO2Etuf+Mu6o8IMMtkW7lIHdIS//RU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN6H/2zWENYrOLYv1i2ABkqgfWlPNEmABc2BurzWfzHXGRl88z
	+xQegJE1SRRc++HcydJn/698dpEk8+zG2svMJ6+0fOGXceeKzduHHE1dMMgU1Hz2I1c=
X-Gm-Gg: ASbGncufwP0vjdqQFjyaFTvzCI/dwx1nZEXiDYc96J0FwHO/WTju0jbn9dYFk3E+xO2
	fbzjy/lcn5ZQoR2+mV9OD00hMcm0kLJWq2vboEpqC2iZ/QBIZn+9TDO5cvYXg75PRTYbI+3rDIN
	/2tjHTQlogHe05zXgI2nkSXEqEsHrOJO66Ts7xG41nwXC+T3/Fz18ZEFvgFBVfO3m6BVhDN67uK
	iPy+avR4zqOS2ZYbrMctt4pRWOVhmzfQ2fdc8RUgtxqrvjcq/avhQaJBiF2eRt+n9EMwwkjCKRT
	0gDb88uD3TWm5l7oBKnpL21I2I6u5R/5GB3EGUE6FCGaAQWB3E0grXe1RJO6t1URMakFBaIbHzx
	PYycuoCn+rB23jvws1CDESh0/2ejHbuHLwQ/trFwhbt5mBMjcjGrvB8fQBQY+aNbCTUD9qRBTcG
	vn9U5uURSWQrozc0rgO0Njzkz2JMp9GxfXAP7gFqIt
X-Google-Smtp-Source: AGHT+IEqrqUPdxyh6nYJQcfD3zvrLobFkCBCdnIEdI/83k2YFCmj2OXCJVPDfmu5Z5HhIeTYWdj2MQ==
X-Received: by 2002:a05:6e02:154a:b0:42f:9399:ce93 with SMTP id e9e14a558f8ab-432f9028b73mr8923535ab.20.1761684597966;
        Tue, 28 Oct 2025 13:49:57 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f67eb4b3sm47212635ab.12.2025.10.28.13.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 13:49:57 -0700 (PDT)
Message-ID: <a836c200-e079-424c-9fad-600f802e5220@riscstar.com>
Date: Tue, 28 Oct 2025 15:49:54 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Introduce SpacemiT K1 PCIe phy and host controller
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, vkoul@kernel.org, kishon@kernel.org, dlan@gentoo.org,
 guodong@riscstar.com, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
 christian.bruel@foss.st.com, shradha.t@samsung.com,
 krishna.chundru@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
 namcao@linutronix.de, thippeswamy.havalige@amd.com, inochiama@gmail.com,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013153526.2276556-1-elder@riscstar.com>
 <aPEhvFD8TzVtqE2n@aurel32.net>
 <92ee253f-bf6a-481a-acc2-daf26d268395@riscstar.com>
 <aQEElhSCRNqaPf8m@aurel32.net> <20251028184250.GM15521@sventech.com>
 <82848c80-15e0-4c0e-a3f6-821a7f4778a5@riscstar.com>
 <20251028204832.GN15521@sventech.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20251028204832.GN15521@sventech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/25 3:48 PM, Johannes Erdfelt wrote:
> On Tue, Oct 28, 2025, Alex Elder <elder@riscstar.com> wrote:
>> On 10/28/25 1:42 PM, Johannes Erdfelt wrote:
>>> I have been testing this patchset recently as well, but on an Orange Pi
>>> RV2 board instead (and an extra RV2 specific patch to enable power to
>>> the M.2 slot).
>>>
>>> I ran into the same symptoms you had ("QID 0 timeout" after about 60
>>> seconds). However, I'm using an Intel 600p. I can confirm my NVME drive
>>> seems to work fine with the "pcie_aspm=off" workaround as well.
>>
>> I don't see this problem, and haven't tried to reproduce it yet.
>>
>> Mani told me I needed to add these lines to ensure the "runtime
>> PM hierarchy of PCIe chain" won't be "broken":
>>
>> 	pm_runtime_set_active()
>> 	pm_runtime_no_callbacks()
>> 	devm_pm_runtime_enable()
>>
>> Just out of curiosity, could you try with those lines added
>> just before these assignments in k1_pcie_probe()?
>>
>> 	k1->pci.dev = dev;
>> 	k1->pci.ops = &k1_pcie_ops;
>> 	dw_pcie_cap_set(&k1->pci, REQ_RES);
>>
>> I doubt it will fix what you're seeing, but at the moment I'm
>> working on something else.
> 
> Unfortunately there is no difference with the runtime PM hierarchy
> additions.
> 
> JE

Thank you very much for testing.  I'll try to learn more
about this in the next day or so and will resolve it if
possible before I send the next version of this code.

					-Alex

