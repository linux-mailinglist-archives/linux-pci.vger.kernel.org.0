Return-Path: <linux-pci+bounces-35531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF413B45773
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 14:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B59C7AEBB4
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 12:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E4034A33E;
	Fri,  5 Sep 2025 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Iv9m+fzY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RCgZtvh3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803CE34AB0F;
	Fri,  5 Sep 2025 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074494; cv=none; b=DuPbC/QD9hKWAse8JxAf5DeAOLgews27awBKgeCvlHvcLymh1Gl9q2PCnil0WcEh07o/oGCNlOLL7UhCCNuRl9fJ1BXktPs9g2QIrRKcnGOdhkVEd05Mw9teJpa70TOxLmRc12gMsd53TrKS7+BSB0P6gmsK0GUe3EuLKoZmQkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074494; c=relaxed/simple;
	bh=8ds04XjGb4G3SLQo3Edkhd7NAoBCJhwTSnyssLuQBwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uM0es1SMAuOtUPONmf6uMU3FlXZ3E57gQwiXatEcsERkLrqRK6ZKreKs0ZIx2tPah4yMCNuacxt6jMnUzpLBdnhR6nheobqxvqWet5LEBwDgdAdbgdDaIfBI5YqYYAzOi70UH32gnHHc2F65dd/bcFiFoOoTlyfVPYcPbOH8H54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Iv9m+fzY; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=RCgZtvh3; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cJFf247hPz9t6b;
	Fri,  5 Sep 2025 14:14:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757074490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XN/fRqEiYtlayEBesAxR9TsT6/h5XgQP+y1PhI5KoO8=;
	b=Iv9m+fzYsVs3Jow37HoPisbjGbHvtqHt8+qKjSrBLOvZtgudjH2x2gckGS1M/CrLowrP8E
	DYsaMQpM5MNuQpkRaxv8RWHC3nWaTxo25O+fYmpFIIRSJrxFIIw/RCJLLciTAfcjJnvggN
	878He3jZm6g/gWvJDZqr73bXoC3pRcYKojKwSvMeWGOeLF1q7SQyM5w0jaOOVOSy+O2ACH
	Kdz/Yj/GIRznwSaksKyDA0jDaK8mXTQVdyicc0OZzBsi+O3jFpabORo/abiZm3MLD3k4xM
	HehjTNu7jZGxUlQ6FLawgirOEoWuzh5QkujJ/sd0679wmbNqT3GJ7F1Y2iZBIg==
Message-ID: <caa01cf5-1ae4-439a-ab70-18cfcfce7a92@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757074488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XN/fRqEiYtlayEBesAxR9TsT6/h5XgQP+y1PhI5KoO8=;
	b=RCgZtvh33Bu5yG435GwPZN59nC+G9S4DTRYcSBztpDxT2Kr4N6Rhg/DbIKFHsFDWqgbndJ
	ILbWX8M/L2Oi4mpfPiyvC7v9hHLNl46GBF0YBupULpVtXzNc14N9vnGXLZs5+MlEH0VIYX
	ddpSZmDQ2zNriD3mDz7XQ68vILl53HVmnJAntaWkLVoy6dl0obb0eT6P20GaHHs9uVDO8d
	tOZdlFzD890stUHV2+fl4Dsz9juowQZWOzJoEeE8BpOf/rnhwDpXrQmAfpuf4QocWzb0OF
	ag6nfboTabV3s6z3j5jvOJny9VYZiO4xZwXvAHlXdNg/KbIwlvmk8qwPLbViaw==
Date: Fri, 5 Sep 2025 14:14:44 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Limit PCIe BAR size for
 fixed BARs
To: Niklas Cassel <cassel@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Wang Jiang <jiangwang@kylinos.cn>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20250904023753.494147-1-marek.vasut+renesas@mailbox.org>
 <b3d5773d-c573-4491-b799-90405a8af6a9@kernel.org> <aLmGBYOVevP5hH0X@ryzen>
 <1jplc54aoc.fsf@starbuckisacylon.baylibre.com> <aLqg90KqEJ8wSEPi@ryzen>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aLqg90KqEJ8wSEPi@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d4e7a0328dfa46c6505
X-MBO-RS-META: o1unrme6t9rk56kzwrhfetokkhmoxp5m

On 9/5/25 10:36 AM, Niklas Cassel wrote:
> On Fri, Sep 05, 2025 at 09:32:03AM +0200, Jerome Brunet wrote:
>> On Thu 04 Sep 2025 at 14:28, Niklas Cassel <cassel@kernel.org> wrote:
>>>>
>>>> I think this can be simplified to:
>>>>
>>>> 		if (epc_features->bar[bar].type == BAR_FIXED)
>>>> 			test_bar_size = epc_features->bar[bar].fixed_size;
>>>> 		else
>>>> 			test_bar_size = bar_size[bar];
>>>
>>> +1
>>
>> It's what pci_epf_alloc_space() does too. so it makes sense but it also
>> means the side must stay aligned.
> 
> Not really, pci_epf_alloc_space() will give you 'fixed_size'
> if you request size < fixed_size.
> 
> If you request more, it will give you an error.
> 
>>
>> If a rework is needed, maybe it would be better to get size from
>> pci_epf_alloc_space() instead of recomputing it ?
> 
> The pci-epf-test driver is just a test driver and we can use whatever
> BAR size we want for each BAR.
> 
> However, I don't think that pci_epf_alloc_space() can always give us
> a BAR size. Sure, for fixed_size BARs, there is only a single size
> that is possible. But for Programmable and Resizable BARs, there are
> many possible sizes, so which size should pci_epf_alloc_space() then
> return?
> 
> And not all EPF drivers might be happy with an aribitrary BAR size
> (which is the case for pci-epf-test), some EPF drivers might have
> strict minimum sizes for a BAR.
> 
> So, I still think this proposal is the best thing we can do.
> 
> At least it appears that we only need to patch pci-epf-test.
In the meantime, I sent a tested V2, so it is on the list.

Thanks !

