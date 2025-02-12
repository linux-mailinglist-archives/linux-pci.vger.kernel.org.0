Return-Path: <linux-pci+bounces-21271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9828A31E02
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 06:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95E8167283
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 05:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E402A1F8AC8;
	Wed, 12 Feb 2025 05:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uz0IJMSX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB04C271837;
	Wed, 12 Feb 2025 05:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739338583; cv=none; b=SKOnHjvE7oloerWlMCqcVES0PF1bKoZ4iQvN+8iL+nBWQSPFP/ROsjAvNbM1CdT/3uClehCqUvdwOHk0GFNQ3GjmjsNp+HRWDDY21BVWYMAcXaFZETuCw8VasQP8EM6oyj4nOYkW2dUZqNPUnO3A74URi5tNzs10p19uS5Jb+DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739338583; c=relaxed/simple;
	bh=RBcuD/ENGFYSayznVyThEkO7GUD8HBS8E4dDcSHfPhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+Z1l0RQ4KOk4ruZYn2JQqLvngH2feXm39GTHTQKwlD25bLYphpXQCxBxmIle4Uf3X+CGHb5lETmZ0T7XVdv5MlQJ3l6a03bEBmkDWTJytk3m6fl6jCwuWJLPrw/02/jTpwVqImO0rZmK6IBf4HX32aV0S7CdxGfd18wFgd1xMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uz0IJMSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E96BC4CEDF;
	Wed, 12 Feb 2025 05:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739338583;
	bh=RBcuD/ENGFYSayznVyThEkO7GUD8HBS8E4dDcSHfPhU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uz0IJMSX3veX0py61eYQILomLlEgA+nyBPp3jvgs5PP0J3A2UN6ITne73WyLa1Eco
	 bXFKsyKc/QBHHDhxLIFu+CEdKShyYAdMzYswx2y2L1wMtaakBYET4YYTUYyT2z+a3i
	 wHpzPXgrVBS9PFnVaWNpcllu0UgMkWOXZUQ0+JfhcJyeX+MAsD8MJeUP6Rfi1G4ELH
	 XyGcN/tRJNFD51Bak9p6j54FoOSnwIoZ47ZtZw0AcY4s/xS+waT7pe+kYu9TSuVgpu
	 x98OXtUSJ80JbFe4FWeRsVYifT9UzZXhZ7uWauAhA+LQeS6A9lvIr09/svuetxvpgy
	 8Oj1JBR1U4F2A==
Message-ID: <1eca92c0-9dc8-42fd-8149-390fcb91f4f6@kernel.org>
Date: Wed, 12 Feb 2025 06:36:16 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>,
 Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Peter Zijlstra <peterz@infradead.org>
References: <20250211231646.GA58828@bhelgaas>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250211231646.GA58828@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2025 00:16, Bjorn Helgaas wrote:
> On Fri, Feb 07, 2025 at 07:39:03AM +0100, Markus Elfring wrote:
>>> I don't *really* like guard() anyway because it's kind of magic in
>>> that the unlock doesn't actually appear in the code, and it's kind of
>>> hard to unravel what guard() is and how it works.  But I guess that's
>>> mostly because it's just a new idiom that takes time to internalize.
>>
>> How will the circumstances evolve further for growing applications of
>> scope-based resource management?
> 
> I'm sure it will evolve to become the typical style.  Right now, it's
> not quite there yet, as evidenced by the fact that the only reference
> to them in Documentation/ is this somewhat ambivalent note:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-netdev.rst?id=v6.13#n380
> 
> We do already have a few uses of guard() and scoped_guard() in
> drivers/pci, and I don't really object to more, including in this
> amd-mdb case.  Whatever we do, I *would* want to do it consistently
> throughout the file.


Bjorn,
There is little point in discussing anything with Markus. It's a person
known to waste our time.

Best regards,
Krzysztof

