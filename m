Return-Path: <linux-pci+bounces-19004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F509FBCF6
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 12:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C27787A1419
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 11:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFD21B87C7;
	Tue, 24 Dec 2024 11:39:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BFA186E2E;
	Tue, 24 Dec 2024 11:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735040364; cv=none; b=DAhR2oV3Sg6KHh2x9vIuYeDwR322qH5OD3p2Hcw1X6nfwhnlUjt/NbAVsT5C+MzcoSRJ8Th745krgkpFI23qGk+FCb/b7edMUKTJlsY5AnnazO3I84d2N3v02R+s3RhwYqhajA7RpPZ/J1ewPXm1JOi6yauJFaHsz8CSmxg9JxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735040364; c=relaxed/simple;
	bh=fzN/OzO8doaWB7D+LGPRy7wI5rwv/eJ56x6dYlSCKz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5ExY8aNsRHVQqma30UKmReDJq+P9JUz2cJcis7jnuHeeuyOB7Npnq79/83tZP+PWa7eprFgFgtbkBY202K7VRbFTVI8H//dh93HtflYD/nxhUX1Fg5+Z+fu/HaoDaxB1EMSLF9IFdN/pxquYm8TWhtK1M/NVIa9Bt+wK8sqy9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 24 Dec 2024 20:39:20 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 817AF2007046;
	Tue, 24 Dec 2024 20:39:20 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Tue, 24 Dec 2024 20:39:20 +0900
Received: from [10.212.247.91] (unknown [10.212.247.91])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id F0830AB183;
	Tue, 24 Dec 2024 20:39:19 +0900 (JST)
Message-ID: <cfc95377-fe00-4a1f-abda-3b90571351e1@socionext.com>
Date: Tue, 24 Dec 2024 20:39:19 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] misc: pci_endpoint_test: Set reserved BARs for each
 SoCs
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241216073941.2572407-1-hayashi.kunihiko@socionext.com>
 <20241216073941.2572407-2-hayashi.kunihiko@socionext.com>
 <Z2E0EDC3tV76303d@ryzen> <56f1a6cf-40ad-4452-bce1-274eb3d124a9@socionext.com>
 <Z2QasXs0c9jQY8RL@x1-carbon>
 <5f978a20-3f28-4282-8688-b05f3a1f21b8@socionext.com> <Z2lSGcQCob6_upuT@ryzen>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <Z2lSGcQCob6_upuT@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Niklas,

On 2024/12/23 21:05, Niklas Cassel wrote:
> On Mon, Dec 23, 2024 at 08:51:42PM +0900, Kunihiko Hayashi wrote:
>> On 2024/12/19 22:08, Niklas Cassel wrote:
>>> On Thu, Dec 19, 2024 at 08:17:50PM +0900, Kunihiko Hayashi wrote:
>>>> On 2024/12/17 17:19, Niklas Cassel wrote:
> 
> [...]
> 
>> On the other hand, some other SoCs might have BAR masks fixed by the DWC
>> IP configuration. These BARs will be exposed to the host even if the BAR
>> mask is set to 0. However, such case hasn't been upstreamed, so there is
>> no need to worry about them now.
> 
> The three schemes are:
> BARn_SIZING_SCHEME_N =“Fixed Mask” (0)
> BARn_SIZING_SCHEME_N =“Programmable Mask” (1)
> BARn_SIZING_SCHEME_N =“Resizable BAR” (2)
> 
> Considering that the text:
> "To disable a BAR (in any of the three schemes), your application can
> write ‘0’ to the LSB of the BAR mask register."
> 
> says "in any of the three schemes", I would expect writing 0 to BAR_MASK
> should disable a BAR, even for a Fixed Mask/Fixed BAR.
The behavior in my case seemed suspicious "in any of the three schemes",
so I investigated and found it was an issue with specifying dbi2
address.

I confirmed disabing a BAR with writing 0 to the BAR mask.

Thank you for your explanation.
Again, this patch [2/2] will be withdrawn, and I expect that the
condition of the test and endpoint BAR reset for am654 will be fixed.

Thank you,

---
Best Regards
Kunihiko Hayashi

