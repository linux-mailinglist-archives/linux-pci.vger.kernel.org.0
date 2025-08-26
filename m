Return-Path: <linux-pci+bounces-34778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46301B370F9
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 19:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD2C48E4442
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 17:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E1427991C;
	Tue, 26 Aug 2025 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YkKe68Vp"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9275C2DC35F;
	Tue, 26 Aug 2025 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228058; cv=none; b=fbWmKIt+pvJ5RX/N9bVUKCQ26EP2dBTfSOtlszhqGiN/smF4S1V7cih27PmUA6sXZkzd+3uGc7mmxcRN5Ws8Paft8sFly3+RAYZRaJq/OQ1i6Jb00+v0Fhluuz/QxVPKtqN+D9D1IHuAqu0AWLrj3RUuN614rAxktb1bS86TC5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228058; c=relaxed/simple;
	bh=3k8cO5OzLzkuErIIYdeaZZpOurRtdMlnBzr/II5vUtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YErtZOTGmUBPbm4EDG0ohYJB6fzbpM0WY8UzbQnGAM46Wr2xICB+nFT3L2P8rBGKtzEXMHN7/WblMtqChGGU6oPtB5NFeEgdSO+5bHutOQBH3ycQYTFn3wuHSP7rdzTOk54Dxznv+fFXEC/Uj0ilv6J/21Dd4BNE2apiyPFl/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YkKe68Vp; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=I563Bbo31n6nV/SklVskiKt8QsN4DGg0bHSFCTqvWAA=;
	b=YkKe68VpI+78K70I0zwMocD8Rzx0QIwkcC/C9+gdJXJ7mNoIfhn9rQCqkdxTxp
	jvjXNoqRrawBb1gK5ayFGmq8X0QCoFML6JDC7gX3wpwRhsiUyo1M2lKVWK3n4kgb
	5XZ9kuMyibDPZlxdKBcHSxUj8v2yfOzCKFAqQnus/3Lp0=
Received: from [IPV6:240e:b8f:919b:3100:3980:6173:5059:2d2a] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCnC4_L6a1orcehEg--.60535S2;
	Wed, 27 Aug 2025 01:07:24 +0800 (CST)
Message-ID: <c6efb55c-8ab9-4ccf-84c4-9a2a50102d15@163.com>
Date: Wed, 27 Aug 2025 01:07:23 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] PCI: Replace short msleep() calls with more
 precise delay functions
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250822164638.GA687302@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250822164638.GA687302@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCnC4_L6a1orcehEg--.60535S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr1xZw4kAryDWw17Jr1xGrg_yoW8Zryxpa
	y5Wr1qyw4UJ390kw12va1YkFykKayktayrtry5W34kJr98XrySyF4F9r4j9ryUXrZYya40
	qayUta95uayYvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRi0eXUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQwW1o2it56YxAAAAsl



On 2025/8/23 00:46, Bjorn Helgaas wrote:
> On Fri, Aug 22, 2025 at 11:59:01PM +0800, Hans Zhang wrote:
>> This series replaces short msleep() calls (less than 20ms) with more
>> precise delay functions (fsleep() and usleep_range()) throughout the
>> PCI subsystem.
>>
>> The msleep() function with small values can sleep longer than intended
>> due to timer granularity, which can cause unnecessary delays in PCI
>> operations such as link status checking, reset handling, and hotplug
>> operations.
>>
>> These changes:
>> - Use fsleep() for delays that require precise timing (1-2ms).
>> - Use usleep_range() for delays that can benefit from a small range.
>> - Add #defines for all delay values with references to PCIe specifications.
>> - Update comments to reference the latest PCIe r7.0 specification.
>>
>> This improves the responsiveness of PCI operations while maintaining
>> compliance with PCIe specifications.
> 
> I would split this a little differently:
> 
>    - Add #defines for values from PCIe base spec.  Make the #define
>      value match the spec value.  If there's adjustment, e.g.,
>      doubling, do it at the sleep site.  Adjustment like this seems a
>      little paranoid since the spec should already have some margin
>      built into it.
> 
>    - Change to fsleep() (or usleep_range()) in separate patch.  There
>      might be discussion about these changes, but the #defines are
>      desirable regardless.
> 
> I'm personally dubious about the places you used usleep_range().
> These are low-frequency paths (rcar PHY ready, brcmstb link up,
> hotplug command completion, DPC recover) that don't seem critical.  I
> think they're all using made-up delays that don't come from any spec
> or hardware requirement anyway.  I think it's hard to make an argument
> for precision here.
> 

Dear Bjorn,

Thank you very much for your reply.

I have revised version v3 based on your review comments. Please continue 
your review. Thank you very much.

Best regards,
Hans

> Bjorn


