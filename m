Return-Path: <linux-pci+bounces-43098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4CCCC10A2
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 06:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCD1E301410F
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 05:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60E2334385;
	Tue, 16 Dec 2025 05:59:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A167B2D4813;
	Tue, 16 Dec 2025 05:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765864753; cv=none; b=igXLY9sKDs/hYS7RZ5QWaPxL1CpsB6PjguLPjOiM3Vn9/vwsuMWl22VfjI/dhjpNq6W6j3eQt8iBOvXb83KcGMhvqkTABnpHK4YIX+suT3LQpaqWf8Q4sAuGTRp8mERAQZXq4YO6ixleqyFvXGpCPM6t5i9fFqPz/fzOwzjY9rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765864753; c=relaxed/simple;
	bh=K+bkuIX2cbs7SKHiWG6fDmn5MKSzz/NXgTUlxB9NVSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oPDsqYL3SEqrzEjYXgQgqezIzWduyHwig0iD+c60qPyLIKRr0bq9cX7N62xV8HY7PuOs7RsD+cbSj3fXnI16I6TmeBYCj+2Kx3FHiFA/rsXIH7eZveAgt/XTbAzObeuW78gZhQWae6cnue0NzVy+UcRHPKLjkaX0uiW3jyaHL8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan3-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 16 Dec 2025 14:59:01 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by kinkan3-ex.css.socionext.com (Postfix) with ESMTP id D75D82069FC4;
	Tue, 16 Dec 2025 14:59:01 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Tue, 16 Dec 2025 14:59:01 +0900
Received: from [10.212.247.110] (unknown [10.212.247.110])
	by iyokan3.css.socionext.com (Postfix) with ESMTP id 342A410A00E;
	Tue, 16 Dec 2025 14:59:01 +0900 (JST)
Message-ID: <668f273b-5214-4f2d-b532-265e4fc6aaef@socionext.com>
Date: Tue, 16 Dec 2025 14:59:03 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: PCI: socionext,uniphier-pcie: Fix interrupt
 controller node name
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251215212456.3317558-1-robh@kernel.org>
 <3f1b7852-1494-4a73-8783-b578f9ad5d40@socionext.com>
 <CAL_JsqJKpQRMEac4e1T-s+6HWbR9mOZXRQCHVeTCnHqJYa=TYg@mail.gmail.com>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <CAL_JsqJKpQRMEac4e1T-s+6HWbR9mOZXRQCHVeTCnHqJYa=TYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/12/16 11:18, Rob Herring wrote:
> On Mon, Dec 15, 2025 at 7:21 PM Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
>>
>> Hi Rob,
>>
>> Thank you for pointing out.
>>
>> On 2025/12/16 6:24, Rob Herring (Arm) wrote:
>>> The child node name in use by .dts files and the driver is
>>> "legacy-interrupt-controller", not "interrupt-controller".
>> After your change commit bcd7ec2cd720 were merged, it was a long time
>> before I realized I needed to fix it.
>>
>> "interrupt-controller" is included in the list of Generic Names
>> Recommendation. Would it be better to apply (i.e. restore) this,
>> or fix the PCI driver and .dts?
> 
> It's an ABI. So we are stuck with it or have to support both names in
> the driver forever (and backport the driver change).

I understand.
If allowing "interrupt-controller", should allow both names in the
driver and bindings.

At this time, it's preferable to align the bindings definition to
remove mismatch warnings.

Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thank you,

---
Best Regards
Kunihiko Hayashi

