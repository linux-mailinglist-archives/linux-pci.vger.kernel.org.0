Return-Path: <linux-pci+bounces-6960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C60F8B8D6F
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 17:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0DC1C20E9E
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 15:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1DF1311BC;
	Wed,  1 May 2024 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JA9s74oB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB4B12FF8E;
	Wed,  1 May 2024 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714578227; cv=none; b=nAXp5gt+KlHUTOXy00nLml/J13ccPnJjdjZUw/rKxWMIfO3yHiB4Jm7MrNQ93c9XWn37bViELOUpZCZyytdo0MXRb7IVfW7CKNdr8ZYjRZx3jsUvV9XrDx0/h6DUb5RsLYylJVitEghuLFRJ9z7gSkzhsDb17WBHspFpYg9wO4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714578227; c=relaxed/simple;
	bh=+j1MhO27oq6Z2k/UMaKrknwIvc97IqQ6TsLfVDaEsVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qyqHUn9/qS8y2+Uy3jGPXY7m39VXKdc5UARjtyhMiDpzOr4jLMLC52AG6JiStD/kdGgErik428W3Jnn7MhiReOiH+zlYHXPtm2XFQTrWz0K4XkXWwam/w+b1kbercJtTYrPDLTFdJXFeAVXoPMkyQFwUPdSgKRi+ARM10yfrxbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JA9s74oB; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6eb93ec8804so3900805a34.2;
        Wed, 01 May 2024 08:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714578225; x=1715183025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WYyt1RBKP+5wqyIqwmy5cnYZMq9VEpLdANc4tFv/eOc=;
        b=JA9s74oBcNhi3U2CLmWURFd2W5GdVotI852dwp5wy4qkLb9GyiWPWdpugf7kz7MW6E
         uKZWDIiY0JEnRDSOqLvnNbiKOVGX9Cay0hMMkXh6CCX1JSkpSBvvXppcQMyUvVnAgt27
         1At1IHqX60vNNwkGVfooe7HYdNu06bt0lKLKpxXhk0JsuAYDnshjylmagbYVcYr063kh
         Eu0u4Lgl7kSgj5vpE+460LrdweO8fEAhZObQ8YQf82nENILEgeorKAKkBb+oe/sCSWic
         i+yebGfIl0n05zCGgeH3lWtlqq1dmKJUHc5/Z+6NZFS5asC9A9AtlAoTGuzxL1H4NDg0
         3dHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714578225; x=1715183025;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYyt1RBKP+5wqyIqwmy5cnYZMq9VEpLdANc4tFv/eOc=;
        b=M4KFwDFTu3QR1CL34FJwpH9nEk0kFOh3OdR2ET/unwrX7l0QXyXhLRQuLg+DcSrAkD
         N5cNSFttCQa+8G6c/5CLMUkPZNbnT4ifHjfh73BJRBpYyO3KBaqp+b7Ze5hzkupiLvUx
         r88IuXJ1OjMkLPW2ucz0peWrpnHYLnYLOZpRUqXj/LHg1amn6RGoVkImCQUSWovOXAhT
         HFSjYuabt9el7zl+u5FSTae1m2tGWsGvyl1xiSCVQqqbs3ryFwmfGYEgUUaaeLNTF4aW
         9Woyc+A5eVLSnnPSynau7AWGkAbbnVluqf0MY9EaVQ3iCXof9Q+fZUIHeVcf2dHuz3Oq
         B4Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXZc/zJJK20mf4MAOolUl5RGUabcWO/oQ81cA7hQILnu0xzRammqSu71FsJCElrLt6nih/h0FVtdrl+ZjbElCF/w84Hw2efCN5kbMBWZ9uphC1bKzZhquaEsWmgQ2PLxfwIEGBPjvwJxlvppwhKwQwEIEeDUdiMKZDYrO7KGgto79QXfDvCHfqdrxQ3njUpvZz8sDGLSVY40R5D4EnIl3vi9+8gQr/7H7Vjsxh8ZCOWpR5YKUQBOSX2wxh2uck=
X-Gm-Message-State: AOJu0YxBxuSGh2DEyXATfYyi8wVS9hwPlWTl3Qzi644LVcoTx96tiHZh
	2NHrzS4tIIvIC/idCnjUAoAfgGp4zvUBDpdkbP3m8rJDbvzCNHw2
X-Google-Smtp-Source: AGHT+IEVAUBi8gaQAQaPiF+BdK+POH9BTZIvS3fio856v721oE2NZNnhywEs1M2R3KrsTS8RWdtRpg==
X-Received: by 2002:a05:6830:1284:b0:6ef:a0a4:b601 with SMTP id z4-20020a056830128400b006efa0a4b601mr1830971otp.36.1714578225542;
        Wed, 01 May 2024 08:43:45 -0700 (PDT)
Received: from [192.168.7.169] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id fc12-20020a056830498c00b006ee0d82d41dsm1595872otb.71.2024.05.01.08.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 08:43:45 -0700 (PDT)
Message-ID: <f7176c82-3702-4667-b68b-a8b7e3ad8690@gmail.com>
Date: Wed, 1 May 2024 10:43:43 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RESEND 5/8] PCI: qcom: Add support for IPQ9574
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-clk@vger.kernel.org
References: <20240501042847.1545145-1-mr.nuke.me@gmail.com>
 <20240501042847.1545145-6-mr.nuke.me@gmail.com>
 <a973f67b-de7f-4e21-b6b4-3b85d056456d@kernel.org>
Content-Language: en-US
From: mr.nuke.me@gmail.com
In-Reply-To: <a973f67b-de7f-4e21-b6b4-3b85d056456d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 5:21 AM, Krzysztof Kozlowski wrote:
> On 01/05/2024 06:28, Alexandru Gagniuc wrote:
>> IPQ9574 has four PCIe controllers: two single-lane Gen3, and two
>> dual-lane Gen3. The controllers are identical from a software
>> perspective, with the differences appearing in the PHYs.
>>
>> Add a compatible for the PCIe on IPQ9574.
> 
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
> 
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
> 
> If a tag was not added on purpose, please state why and what changed.

I had an Acked-by tag from Rob for what is now patch 6/8 -- previously 
5/7. Due to last-minute info from QUIC Inc, Dmitry and I decided to move 
the "snoc" and "anoc" clocks out of the PHY and to the PCIe controller.

This change resulted in a 6/8 patch that is substantially different from 
what Rob acked. I felt it was inappropriate to keep the tag.

Alex

