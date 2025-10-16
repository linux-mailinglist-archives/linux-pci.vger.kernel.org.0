Return-Path: <linux-pci+bounces-38297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1B0BE1B68
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 08:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22B513517C7
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 06:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0702D3A94;
	Thu, 16 Oct 2025 06:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LjP+lTKq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5482F2D2491
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 06:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.160
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760595935; cv=pass; b=Duli3VuiyG22ps8tgGKoHzn9KOkZ/nIkbWsNBvHpaBzqjUxVq+BEJhcJ71WZ8GDy49ms+S92AP7SDO7mUfhoVb4K8zEMcxdgwB4sHSz2kGQZ6rP01FWYke8mO4950ORSGB+xfnjj+1tApe+KT8sZYZiU5/UOz9BvK4NlY6Yv3cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760595935; c=relaxed/simple;
	bh=4R5KBIQwxQTf5xrA/dCSeRQHenFIlzKjP2K7ZAml5yA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=FulhlIxHgQqBs+WxL43rQQfguYS7lMtyytSH2wcCWhBK+UE8bzE9Q7tur3DhjPSr2fUEVNrRGGyScz8asWWZx22sfBWhIQpjwoUVrX1O0BLbwVge49oBBHDJ3htk9+7riexO1UAP569cm6PFnTyYjTLIo6JKR6jSbHDQakCP49g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LjP+lTKq; arc=pass smtp.client-ip=81.169.146.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1760595924; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=heIW1sT57GHz2hD0w0o0lVeveflvpNFjT46KDpUj/pfgZ5oebdbvbWNaeT6UEPs0bF
    LnH+WcdvW5pvbaC57TDaf4leBYF5Jej+PIrEfmtBmGxptY5MLu1XncgrGpeTX4NeLdZB
    ocm7L9dwGUJ7mXqkYPak2/HotQuxS6aGj2DTVlYTcEzLRpOFKn3n3DugYvPFbIPXE+kC
    r63C8wyGtlDfuxZ/jZnw63mKsA9463SB5nvunI81noVQGZt+l8HUe+cmIn7IO/sQaF3E
    0t8VBi1U+FnujIW9ZMYu8Dyzva2W1uaonXxSct7bfY421rfgjtDVOWeXMlYgDOyZtHgo
    JThA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1760595924;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Cc:From:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=OzpKVqdGGCDRjbpDN2xFNyDAYnHE9tzc8p/XXd6XEr4=;
    b=sDeUC+cNU4zSRVoyQMnRm0ygTTHq88rYUwpxUsf2ikdchVY3oCtzOmgym5TuLmd6ue
    iYoBi4NvYVRS6sLdoFTdc73laFDbF8pPvCc9ZxmmbXCx9nuDJC6kb5GvB9bTfxBq4N1o
    buSsxRzJZBCjrd550n5xFSeGhKPdqdcSZRFdhWvvcrpeYATHNNSD2ycMPHI9a7eG266Y
    rVxz/6XeD48iwTDxgdk59BpB+wcQHLkG3V3iw8/ZwEt2/sU3N7H3djmFaWmjKyXsOZM7
    3AdNjW+VDmHhGCD26Zps38NqUYQMzI3RpaHyNeLvoXrI2mdnVKLHF447dPFRuXGuxOsX
    id1g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1760595924;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Cc:From:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=OzpKVqdGGCDRjbpDN2xFNyDAYnHE9tzc8p/XXd6XEr4=;
    b=LjP+lTKqwmh8zDazxtCCXYxKg8nbvidH1GFRJMTFZbeZ5rRtbsTjk/tHm6fDQwX61E
    NcK01bP1lVupU9os7W7mmjw4jUuMVvSSmz5utfDp78I2yvnGfEMo2j/nLqv6yBfgyLJd
    12IlyuGM7HHslvZFv9TjDBaiM9+5fh1uOyPuLqtqkGor1e/tEBRbGYaXejG8LHeffV8m
    ZmfwcbqjzaLdlPXifdu0kL/1Kd6cEE6ltuzPoR9RU6mo8cgS9hzCFuzZkswectTCBbH5
    9c2RqMqFPHehluutBXC4rsRC9D254Q4ee7x5su8DAdb0WlKcTRSoUL3te09hwKEtPJJK
    XxVQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6800::9f3]
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id Kf23d019G6POcIv
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 16 Oct 2025 08:25:24 +0200 (CEST)
Message-ID: <a0d664de-3ce2-4d6d-bd55-818b50fcecdc@hartkopp.net>
Date: Thu, 16 Oct 2025 08:25:17 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PCI/MSI: Boot issue on X86 Laptop 6.18-rc1
To: Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner
 <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org
References: <8d6887a5-60bc-423c-8f7a-87b4ab739f6a@hartkopp.net>
 <6qtkyvywsz3p7ajhxonw4kvu7tivk3ka2fahab4o3jrttttjk4@nvjztgc6s7w5>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Herve Codina <herve.codina@bootlin.com>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <6qtkyvywsz3p7ajhxonw4kvu7tivk3ka2fahab4o3jrttttjk4@nvjztgc6s7w5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/25 00:24, Inochi Amaoto wrote:
> On Wed, Oct 15, 2025 at 09:05:11PM +0200, Oliver Hartkopp wrote:
>> Hi all,
>>
>> my Lenovo V17 Gen 2 (i7-1165G7) does not boot since commit
>>
>> 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
>>
>> from the beginning of the 6.18 merge window.
>>
>> I've checked the discussion about the original patch "[PATCH v2 2/4]
>> PCI/MSI: Add startup/shutdown for per device domains" here:
>>
>> https://lore.kernel.org/all/qe23hkpdr6ui4mgjke2wp2pl3jmgcauzgrdxqq4olgrkbfy25d@avy6c6mg334s/
>>
>> where a fix has been suggested (which was later applied) that doesn't help
>> on my machine. So the Linus' latest tree 6.18.0-rc1-00017-g5a6f65d15025
>> still does not work.
>>
>> I was pretty lost when trying to follow the PCI quirk discussion about
>> "[PPC] Boot problems after the pci-v6.18-changes" here:
>>
>> https://lore.kernel.org/linux-pci/4rtktpyqgvmpyvars3w3gvbny56y4bayw52vwjc3my3q2hw3ew@onz4v2p2uh5i/T/#ma4425fd40ec041dcda2393a55bca5907887c2b52
>>
>> Any idea how I can support you to make my machine boot again?
>>
> 
> Can you try the following patch?
> https://lore.kernel.org/all/20251014014607.612586-1-inochiama@gmail.com

That fixed it!

I should have searched for the problematic commit message more 
intensively once I found it myself :-)

Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>

Many thanks and best regards,
Oliver


