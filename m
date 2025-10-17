Return-Path: <linux-pci+bounces-38493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34090BEAEB3
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 18:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E31964F8E
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 16:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F1E2C178D;
	Fri, 17 Oct 2025 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="IeJ3VWnC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756252C11C3
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718048; cv=none; b=ZsUGtzdypk37Mi+tRESDg7p4WaPKf1+aqwOdp4x9mdJlr6IWcQYq4RZDYMGBxzcpvBd9BDeMw+8efn6C1r6feQtjqmDo6a3xH4bgvLdGpf1H7ILT/wtqhT0Nt5qqvRthrHny8HJM268GvcVOpRPGppyrEHLryyqUM3K9U39yhkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718048; c=relaxed/simple;
	bh=V5+G6D9gYoHyycj/8QJCp/qEQ29MEhUI3xvN2kUgks8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+1Gm/pBLc24xi/IG301kPoCpCQhlsMWS5CToG8fwsUL8zST9fHAI04E9NPDg71F3g9sT4KAUhnT3ZGNGxrqTUA6d1Gj4hX0tPQIEE70swLIGg4OqzAIqA8E8aZW32vpZEiFrX5wh6FFZSztb49eV0PX918mk1QQgSu4I5HrroE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=IeJ3VWnC; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-9298eba27c2so122845939f.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 09:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760718045; x=1761322845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lrl9ZQZl0dfsXGeKo4b0s0yUNEi86+tLTNDIOrpaa44=;
        b=IeJ3VWnCWqcMx3x6GNydwUfIGAP29psMhh0YA9KI23ZpTMz0Tp1xk8SNZiWF6JRhym
         ufpT+K+c9IadtxhOLeb1Qvwh6ShO+GxWi/IxiPceCN6+u+WWeawYcfp4crcApVq91ctb
         SgNOTj4pP3fhQ5yNAHN62XTqM7QFKpPJlv97pP5EcFl9s7FIdcIkajaaQdD5IQgFujw+
         ma5j70dntTe+pfZTcXNHM5/rGTGvq87Zd8/RAhQPUxcoz4GqY2bRVwjNrzpVWpUp3zm+
         567vVP7jZIsgdlv/ELgL/p2+ONpHySW0uDtT++wC/TLn+/WLEUiKDdmch6+yQ25Xp27b
         Cajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760718045; x=1761322845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lrl9ZQZl0dfsXGeKo4b0s0yUNEi86+tLTNDIOrpaa44=;
        b=OG0mJ2NX5gicLcwDhamS38OgIF4vwJp/mMpfWyLUB2PrgZZz7lKJwpvJlGt2QcdunS
         DYZICug2DUpuFrJxHxv4o8k/+olFcWFkxlRjlHgU4YGhmsFXcNbaleVAhIcHkeMLdU1X
         64WT8tGHV0NUaPHEVccgBqDxD7psNoadHTFt2e1bnEYiLkWNaxF0IvwMk+aEyck1CoKo
         M0WA3Hqhm+fp7XZsCwAMSiar5IiqQ7J8q+n48iMcSiHiPCYPjluS1qw1BhCZ40OwMqZJ
         kg+n6eHGHiGf5A5jKfPgrt04vHyts9QfJ474BstsKHPbCPTMoR9pi6cBqFAKB77vuiA8
         c1jA==
X-Forwarded-Encrypted: i=1; AJvYcCVbye4JE+eYLKxUPZ5TyWSer3qH3UVFB8wRHN7v+N+Kz6tkd4fdoxWbohdCN2oSteSHvdS1yU26iqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxafcx1gEmdebcqOjlrtcpsUsemhtCeqJNoO1izmH9xraCOQd7J
	pwMXZqN5GgtutdJg6yL60H4TMiu9N+RgzRDoqQXHjQCL4PkjRNcyJzH3vm1+vyhhT3A=
X-Gm-Gg: ASbGncseyQP9A3Fg46xD0kTmB2qRz8btdoiFbNAy8JK32rzTfPJ8b7ITBviJcSN2fhd
	+bFffzqS8VOcWzil6E1vj8TBFU5Js9cxWrj4Uv7QA1XmV8s8CGkw/s7UAOwoJnf+WxMZnYEeyBB
	iOwsm0mmHav/V5/jB54bV1o2HHElOx2Xy1HXkJo6plelIlTG3fd7aCX5WcIMBSbO+q60d+mL368
	l7YLgh40uVJA4LsddZ0OKntwOsDa5LiLX68GAf46VNB0T6WSKQ9chP6Y8oFRrKJl5Ri1zPZHqg/
	HHyqPD1VqJdlRwQAGuuzaIa7M726UtG1QOs20NhcRKEG9QLfFFBY8h//YREdfa+/qmD1a4FP2xt
	2zXj8iRh6DsuZcNgQIMAlHCF0l+9O4VKCW2j05nmjmfORiQ5mgLiEClgHvjTaMHliCvntcVDOe9
	Z0em0hvrVlYxWNavsW0C9pms+cI9LgrYNAGWm5o50=
X-Google-Smtp-Source: AGHT+IF6pUvJ0SrEEfDoT+rWcs5Ssj/49Pi6P7PUBjepw0T+yRtjC6wHKw2821+rzZKRbVJoL68B5Q==
X-Received: by 2002:a05:6e02:19ce:b0:430:bee3:34a with SMTP id e9e14a558f8ab-430c52b5b09mr52484505ab.20.1760718045271;
        Fri, 17 Oct 2025 09:20:45 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a97689basm12877173.49.2025.10.17.09.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 09:20:44 -0700 (PDT)
Message-ID: <e7bbbc92-871e-4155-a1b4-96929199a1dd@riscstar.com>
Date: Fri, 17 Oct 2025 11:20:43 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] dt-bindings: phy: spacemit: introduce PCIe PHY
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: guodong@riscstar.com, bhelgaas@google.com, christian.bruel@foss.st.com,
 krzk+dt@kernel.org, namcao@linutronix.de, aou@eecs.berkeley.edu,
 shradha.t@samsung.com, vkoul@kernel.org, linux-pci@vger.kernel.org,
 dlan@gentoo.org, pjw@kernel.org, linux-phy@lists.infradead.org,
 qiang.yu@oss.qualcomm.com, p.zabel@pengutronix.de,
 linux-riscv@lists.infradead.org, mani@kernel.org, palmer@dabbelt.com,
 kishon@kernel.org, kwilczynski@kernel.org, linux-kernel@vger.kernel.org,
 inochiama@gmail.com, devicetree@vger.kernel.org, spacemit@lists.linux.dev,
 alex@ghiti.fr, krishna.chundru@oss.qualcomm.com, lpieralisi@kernel.org,
 conor+dt@kernel.org, thippeswamy.havalige@amd.com
References: <20251013153526.2276556-1-elder@riscstar.com>
 <20251013153526.2276556-3-elder@riscstar.com>
 <176054651498.4032617.11231316454316691309.robh@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <176054651498.4032617.11231316454316691309.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/25 11:41 AM, Rob Herring (Arm) wrote:
> 
> On Mon, 13 Oct 2025 10:35:19 -0500, Alex Elder wrote:
>> Add the Device Tree binding for two PCIe PHYs present on the SpacemiT
>> K1 SoC.  These PHYs are dependent on a separate combo PHY, which
>> determines at probe time the calibration values used by the PCIe-only
>> PHYs.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>> v2: - Added '>' to the description, and reworded it a bit
>>      - Added clocks and clock-names properties
>>      - Dropped the label and status property from the example
>>
>>   .../bindings/phy/spacemit,k1-pcie-phy.yaml    | 59 +++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-pcie-phy.yaml
>>
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Thanks.	-Alex

