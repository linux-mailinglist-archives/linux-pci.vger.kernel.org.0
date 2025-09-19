Return-Path: <linux-pci+bounces-36477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F699B89AE2
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 15:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996E33B4D3C
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 13:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB601E8320;
	Fri, 19 Sep 2025 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UwZH8Wkw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Is6FkuHY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1999330FC0C;
	Fri, 19 Sep 2025 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758288624; cv=none; b=GHwnbTUDUd+QutMmxTiVQKm7AOpfhY/jVXtaRSKbtBifHRru9J0N7/Axl9ouG8SCDg2uPnVa4mAbwvJ8Q7+ca3JIngMTPKSCyGftKkQmUWo60DQ8kgwGHFk/+VA8MOEvjODv2LpA4eHbJweIl1TAObOsyti5NKeqZy14QIenJYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758288624; c=relaxed/simple;
	bh=LjMAgSqzHT2jVCoMUEf15a1PpZUbC/qcUdEscqbqwEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqyc4xGhQrNUiA3ut2/ugHkIglx/e2qnX6loWEVet/JxWuroYPxklq16pDDLv3w+d5dtt9ILT1fYTxeqCF7Ol0KK7uHK8Q08gihMBGfCCk8enQr8+iGz0uwWgImX//cTHy4qTg5vGHOcU7p/pTY/lnrt7+tz84s249A4kWkcmBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=UwZH8Wkw; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Is6FkuHY; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cStfh0Bzfz9t6m;
	Fri, 19 Sep 2025 15:30:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758288620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IURTeqqTjduSTnwx7LDzSNH9H6AyP3UiSbRBPX8HLUo=;
	b=UwZH8Wkwb1hAk3bfC6+nUFe13NHpC+cIn4QasCtH6MmlDAUwA0mIJZtsX1nGblILYTgbJk
	XXNxH4AgZ89NI6z7Fdh3qBjXSrrZ6+EFjnUO261dloAOZOgIvr2BV9PRxvhc8gQzW/EWz9
	p6VnOr9jAKc8CZg+7g1hbDN5XRF2gSCmWrLVEcfAL+Z9iJ/9UAXslu8cpJ8h8fTEfcZhYy
	pLWxbYoUCNsG1To2TIMCdhRlddgtkUIAPoASu5pg4nrO56rdwwRNhcEFCN8m5XHMkOdTjd
	wwp0pOsEmmKFdDD4DPkbGhh4U8l3WhfqmbDUYKES97BAEF1kOs9w0CUqpnhZ1g==
Message-ID: <475cfd27-54d2-44b3-9b26-5de4b75033ff@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758288618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IURTeqqTjduSTnwx7LDzSNH9H6AyP3UiSbRBPX8HLUo=;
	b=Is6FkuHYwvAr7/ph+xvdYFzXK/2fFYI+Upi/4cydhh2gfPnfJRJfAPUqNTX9fKz08ENC0R
	3A0rwVydBzfIQVxfT75OrmJf5MTY6d8G9yHJrKbs1ekXVBAP4x1J9xfIc3hVPVu00lo9CR
	fl99+qx9Gl0lbbLrdeCdYkSXwyrgDAjGyG8I0YBl4RGnzEYq22f1Yu95Lm1ryVR65HOZ9V
	f7E5twIc3EDiAB1tuOaUVsJu4oG8QbGjq3wfzrJkYu/6lAaScs8fDaav9Ie711Q0iwzXhx
	tKGs0XE0A/Ugreqhx7d/c2rYD0UA5V4V+YuBtg09D+/eLYLrQEBHSANUm4ZUyQ==
Date: Fri, 19 Sep 2025 15:30:14 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] PCI: rcar-gen4: Add missing 1ms delay after PWR reset
 assertion
To: Manivannan Sadhasivam <mani@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-renesas-soc@vger.kernel.org
References: <20250918231253.189906-1-marek.vasut+renesas@mailbox.org>
 <20250919100038.GA3918632@rocinante>
 <3h3tkv6jmkwqqsb6bdotdx4bcnnzqqqzgl5digryxo5bc4qpm6@np76zatxj6ff>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <3h3tkv6jmkwqqsb6bdotdx4bcnnzqqqzgl5digryxo5bc4qpm6@np76zatxj6ff>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: fb68b355c9e47a5e3f5
X-MBO-RS-META: 45qi1xcbz9enx5o1c8hdcmzec4qf4jxn

On 9/19/25 2:33 PM, Manivannan Sadhasivam wrote:

Hello Manivannan,

>>> Because it is the controller driver which can determine whether or not the
>>> controller is in HSC domain based on its compatible string, add the missing
>>> delay into the controller driver.
>>>
>>> This 1ms delay is documented on R-Car V4H and V4M, it is currently unclear
>>> whether S4 is affected as well. This patch does apply the extra delay on
>>> R-Car S4 as well.
>>
> 
> What are the implications of not having the delay? Just asking to determine if
> this patch is a stable candidate or not.

Observable, thus far, none. However, the current behavior does not 
follow the reference manual operations chart, so I think this should be 
in stable, else the hardware is operated out of specification.

>> [...]
>>> -	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc))
>>> +	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
>>>   		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
>>> +		fsleep(1000);
>>> +	}
>>
>> Would it be a prudent thing to do here to add a comment over the fsleep()
>> or over the if-statement to document briefly (and for posterity) why we
>> sleep here?
>>
> 
> I can add the quote to the reference manual while applying.
I'll send a V3 with a comment shortly.

