Return-Path: <linux-pci+bounces-38583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3AABED123
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 16:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E048D4E0296
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 14:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E4B185E4A;
	Sat, 18 Oct 2025 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CHdGoOP0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9101D1C28E;
	Sat, 18 Oct 2025 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760797240; cv=none; b=MgQEziEf8dGQZt/2zvPJQMkDz9aAI6UZ5ThH0u1cBEyBYeFdBaHIhbBkwFkooBSVLt5Bt0fkB/84O/kTSZtxX4RhoHyxDwwLpyZp1I4yS1vp11kggwkLZhzPcQJdUh9zzYw6DF1emZtFwG73t6e83luFnawQw8YyklXkKdaPq/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760797240; c=relaxed/simple;
	bh=FCRpPbIuIU7PrxD6RjZ7c/CMKUdoPpKb15G1UY07C30=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DApdgl1O/wKffv/bE6SPEEw+fDin3n8uXk+0LdNqmn/kUwEEKx+AHEpdSb+AYt3a0sapIOW78LlCsYNqbX0h3j5yf9HT2M/nsvP0ne1ofivg+ha2Fv6AYQzYxFCpzLLNbhBKd6RFSluVAsWanrNqDINmk+EUgqmgdiO+sLmOOuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=CHdGoOP0; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760797226; x=1761402026; i=markus.elfring@web.de;
	bh=FCRpPbIuIU7PrxD6RjZ7c/CMKUdoPpKb15G1UY07C30=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CHdGoOP0FKKgMe83yuEbybIA+pqilmAY06DYoELHSf+iduaYRCAXw6VPH8F2Vv3t
	 Rf2IhUkHTtkNRAnRB8RrDLyPsU0/sMDpnHCSUjis6UNk1HYqwZCM7mAvT9/cVA4+P
	 JsVxx4ENhROQ2waYWGYfQMzuh2MtgLeuTje+M09b9h7miQK4hrX76cezTuFu60mOW
	 +OBqlWyN7lnU+qjMPF1D0UpzSKNFQ4Zkh1lVsrYV8hqVueZT66ySactgHnaauhh4o
	 oR0Z6bYc0bFlHJPJv0H1pYRKGZjzyUXk8TuLAgz4iFUx22jxXGeAiRTnzpKGDCTCP
	 9E8iIOC982fuSuIRrQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.233]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1d3k-1uCdPO1Wxc-012Gmo; Sat, 18
 Oct 2025 16:20:26 +0200
Message-ID: <8168ad35-4f2c-4082-b372-cfb8f75cc78a@web.de>
Date: Sat, 18 Oct 2025 16:20:16 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH 3/3] PCI: j721e: Use inline reset GPIO assignment and drop
 local variable
To: Anand Moon <linux.amoon@gmail.com>, linux-pci@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20251014113234.44418-4-linux.amoon@gmail.com>
Content-Language: en-GB, de-DE
In-Reply-To: <20251014113234.44418-4-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:KfLLoLBAwwQ4pEAv3b0FRw95Il3C89w4Sm/QfQr+2a9NB5bZo4P
 FjVqKf4N/2BmIDGykmINA+aGtCAJHe/2RjVprTk2WAFbMluyWFkWy5Bbxy+PbwzDegtybmz
 IXsQJh5MnzPNcqOGMClfKu4NI68hEQqYJ/lc4wuJqjw9W5h7QVkMZM6+I0WuerBQr1yM7ol
 dfDqGJ//xeM8sGOp4OVJw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gTd1ZD/FxKQ=;miLD90L2WR+O/U6DYYQKJv1a0es
 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
 DgsEQ==

> Change removes the unnecessary local gpiod variable and assigns the result
> of the devm_gpiod_get_optional() call directly to pcie->reset_gpio.
> This makes the code more concise and readable without changing the
> behavior.

Will another imperative wording approach become more helpful for an improved
change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.18-rc1#n94

Regards,
Markus

