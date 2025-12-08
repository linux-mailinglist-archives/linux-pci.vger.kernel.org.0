Return-Path: <linux-pci+bounces-42766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB54CAD8C5
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 16:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA27F301B2EA
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 15:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7802BE032;
	Mon,  8 Dec 2025 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="He/yxqEF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8EB27602C
	for <linux-pci@vger.kernel.org>; Mon,  8 Dec 2025 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765207128; cv=none; b=Y1gyBeRxrEZslOZq34SbgoCBBkSaU2M1bId1akI5tsEki8GCRkbHybMHkFjRBhClbQtsiF7sR4IM/rUKTJq5N0h9OiYzp/6ZRh3zv9piPR2SOBlIAl0KN3kFTjOhaaCaJMEVlTaQMinMQbu+uX18U+zJXbzgB+G0/N+Por3DImk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765207128; c=relaxed/simple;
	bh=vrMgUbPiviHCE/vtM5qKgmAf1NEAPRzc7KsDqfydLp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ckTvkvuHlEPrxSQPTJaa2l8gf7Fgry63CmpW9uu8P7fXiWC59qqTdvygUV4d0l7dQCIwY5mMD2A/7UrhW5QxHRC42loxASSf6H4dC4ImIX/fA5GEJK9K17W73REwEDNoZ9r2nBKcH5evKs9cjnqq1ZebNsWFoAwW6uJ9rv1K6WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=He/yxqEF; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b73161849e1so1087923966b.2
        for <linux-pci@vger.kernel.org>; Mon, 08 Dec 2025 07:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765207124; x=1765811924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EyKkwg9npizIf2XwQV5tQ96E9Oa/5ROifR9l0/m15Fs=;
        b=He/yxqEF0ROYMeBxeVjeHz8V6N96/gHInOf/SbLGYNcWfuUvBUlhmH0fXJLBJ9ulPH
         cwxMaiQMO2nKr70N4Ja091awPZcgdG08knifXabrUecM1IHP5DhORGfj4Zkv1w2oWtvl
         cV9sqSSuXFBjs2rW2PxbLtnwERWwGmCLkFdr4YJKQizhIFCR1DIol4cP6L7GHt5KyciD
         2J1vSm3efYsIGsS/wY77KHzZP1FD0ji895ghgg/w29YmlXK1Nxc0RGFNCYJdE0I4C0PC
         s3zQ02m+hLLo7vwzW+lTywRsihy+ettpzYwLfBCywtBrCuBqJKpKOUwWDaHGK4H2pmBE
         awKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765207124; x=1765811924;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EyKkwg9npizIf2XwQV5tQ96E9Oa/5ROifR9l0/m15Fs=;
        b=DjG7HLXn8OeO+IMrD/PpnceDQU1a/Dljd8zGLu3AGviAtrb9sLoJGzuufCaV0YbCCj
         +Fymhjui6X8PZ5SxN9Lq4Gr8vvtzGSUW7kMmtQUMoxG2YDVizq3TMvs2UyHp13Qqj2df
         xjzHmzVD2wcTFwXpSmNsLYg/P54XKxfbcOvq95qqnIZ2UGBCwoM+XLlWRDZv5O4YhwBt
         xi5VbrioFBKkSVsPsGjxLFvjuAGQSLCR2m2jkgyXUrapdkl1GgTOLwRDP6BGWDkIXPWL
         SxQ63svACe9vEEFNLj8KTUJ4qdzzJBLywfC80agCvvK/ZgaJNC1KtEsFHZJeSJloD38P
         lqPQ==
X-Gm-Message-State: AOJu0YzFl5bWtXYIDZ4v7R8rDFTMyHZEhB/KsRDozezD55OPM74NK6gc
	ySRLy3rys1ygDARPkyvTKGUynvRUEnjSkqk8QvaFd6kq+nS99lV51ZluwgMvHrmcN/Q=
X-Gm-Gg: ASbGncsht0zMp2pPrlAzyKLzl0ZQ5/kKTB21esYAy932nJQmRmewDKw+RAMcwyYh5uG
	fJXVEMIk+IRFqvtZhxYU8NwInohN50XFrpFCSX6ieDeJorY/bKPErBDvx/EvXRIQIe5va5v87st
	XHPnmGK9DlFPwfoymDNV9Xu3QSyEvTT/88ZcDyUUkm3RbMib/iOf0vE8FJgHXIbuzZVgcED3OiI
	eJQ2l3GTpti4BOPyEgPzkNzlJjT/eufexmekenNhkCCUb/xmlS1oSJLx5FUr3cTdztxyQHiomGn
	cbXqXUZwpTfij6XjPoN+Zi796ilvThjdcXrqs56Wre8YoeV3aCJwQPl/st9JqI2nwIBFy9Mg7TD
	zJ4OuE00o3rhtKkvDHS2eCEqFe3iOLpE76Lqjt3LRBLwuyblgXScGwb6fFv9j5Q7054hxyUP9bg
	QpGuMfauPBbXtC4E9O5ygQJD815IuyWQ==
X-Google-Smtp-Source: AGHT+IHmHAEWZzpXs1rtpanOldqfAtwXfDY30WfUvr0qkz0J9ZX8JM3l3XG0gNeJ1TSMmiLgbzx9AA==
X-Received: by 2002:a17:907:5cc:b0:b76:25fd:6c26 with SMTP id a640c23a62f3a-b7a243047b5mr747928266b.6.1765207124126;
        Mon, 08 Dec 2025 07:18:44 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f49c94fbsm1100880866b.53.2025.12.08.07.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 07:18:43 -0800 (PST)
Message-ID: <ce0d29be-bdc5-415d-b6c0-00bd76d9919b@tuxon.dev>
Date: Mon, 8 Dec 2025 17:18:42 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: rzg3s-host: Use pci_generic_config_write() for
 the root bus
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Bjorn Helgaas <helgaas@kernel.org>
References: <20251205112443.1408518-1-claudiu.beznea.uj@bp.renesas.com>
 <20251205112443.1408518-2-claudiu.beznea.uj@bp.renesas.com>
 <a9b02517-0743-4716-8ffe-e2120d9c611a@oss.qualcomm.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <a9b02517-0743-4716-8ffe-e2120d9c611a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Krishna,

On 12/6/25 03:29, Krishna Chaitanya Chundru wrote:
> 
> On 12/5/2025 4:54 PM, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The Renesas RZ/G3S host controller allows writing to read-only PCIe
>> configuration registers when the RZG3S_PCI_PERM_CFG_HWINIT_EN bit is set in
>> the RZG3S_PCI_PERM register. However, callers of struct pci_ops::write
>> expect the semantics defined by the PCIe specification, meaning that writes
>> to read-only registers must not be allowed.
>>
>> The previous custom struct pci_ops::write implementation for the root bus
>> temporarily enabled write access before calling pci_generic_config_write().
>> This breaks the expected semantics.
>>
>> Remove the custom implementation and simply use pci_generic_config_write().
>>
>> Along with this change, the updates of the PCI_PRIMARY_BUS,
>> PCI_SECONDARY_BUS, and PCI_SUBORDINATE_BUS registers were moved so that
>> they no longer depends on the RZG3S_PCI_PERM_CFG_HWINIT_EN bit in the
>> RZG3S_PCI_PERM_CFG register, since these registers are R/W.
>>
> Don't you need fixes tag and back port to stable kernels, this patch looks
> like a bug fix.

I consider it was not a functional fix. The driver was just accepted for
v6.19 and though it will be included before the pull request is issued. Due
to this I haven't added it. If any, I'm adding the tag here.

Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")

Thank you,
Claudiu

