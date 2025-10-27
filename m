Return-Path: <linux-pci+bounces-39435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BD2C0E26C
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 14:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF0794F40EA
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 13:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC235283C8E;
	Mon, 27 Oct 2025 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="cipE4dE9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D029B1F19A;
	Mon, 27 Oct 2025 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572635; cv=none; b=dWlLRPmMh4heFQT4HhqYsUn/+7v+K1R7xL02SMllwQkdACtcqZiHPllNrKuIqniv0F7BpXNyzYn46HvoAgXPt5FywHgV0/itlMQWOBrQbe5NIHjAzJ7yuiYVmxAuA3FFPcJB9GouAXMPXcnnlcoN7jZktqDhLN22MNAmPMPs1Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572635; c=relaxed/simple;
	bh=Cm+yFJViixHd9wAfOWHpljKCynuqaQNI4yrc1Ij9MJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IM3QR9S4qQFNwXfWiDQe1y47Z5EtKvEt98WNMbGEacepVVRZsodIoIRFFV8UoZ6zXCR0n/b4DaEFKYCQ3+f9uJOixMXUoivWSa0qwsCvOnELXMar3yqVAdHA06XVTDAhn+eyncU2S3ccOeyY3UhuzaBFpSW2987V+/UMD1CgQhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=cipE4dE9; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761572602; x=1762177402; i=markus.elfring@web.de;
	bh=Cm+yFJViixHd9wAfOWHpljKCynuqaQNI4yrc1Ij9MJs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cipE4dE9lp0DBJia6gUISDsEB04OYVGEa5otG+fan10nNQs4j+6wazl3s6s1D/st
	 rikGkoqyfff5Hlca+jL2i6UBcgFv8ltUJoc1lw//9ufURyUjPCY2nmNPeSwFUPzc4
	 1oPkWYKiahYhZmr0MSqhs9IL5WqbXlvQKqfBZw6prQ1TacCgnYEr8qqnr8YhWuU2z
	 f3kCUQxk3DDQEhjnqpyXNXDZqm7Be0lT3xM4C0NNw+2RvwyHXaUQ9d4fg6n8azkSU
	 dggVpo/ccZ5/J6PQlFehsvVZlj8s5z0NZ7FxX50f9g4v+ariE3oYFzFrR3HdqKth5
	 WIdgon+jBxwEPW5fow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.179]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzCA5-1uHPGD1rrn-017HEI; Mon, 27
 Oct 2025 14:43:22 +0100
Message-ID: <f36a77b1-79ce-4bd4-ba4a-b9260bae7f11@web.de>
Date: Mon, 27 Oct 2025 14:43:20 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] PCI: j721e: Use inline reset GPIO assignment and
 drop local variable
To: Anand Moon <linux.amoon@gmail.com>, linux-omap@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20251027090310.38999-1-linux.amoon@gmail.com>
 <20251027090310.38999-3-linux.amoon@gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251027090310.38999-3-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZHLWrosy4s6wSgyqLDZKbw8qQKJD6M2dAE5JLRR5iJ/Na8Z77kG
 4bhabrJwSZPChYihoMrsVUz+/YYCF0z6mc47rOtOyi8XqlK48V8kzmKvTr+5VjMTDYzWcBj
 zPfttAQOuUxJSL65qqzDsoDRz0NqiclgG/jV/CNVyH8AObQyyxSJhA8lJ5MRpKnRshkKxyV
 L2hzNqtwR3zDZlD1kVJ2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W0X/4SKv7C8=;Fw08P2Mv7mXt3Uh27hzOYtul2VK
 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
 ibXvpjLa6e83AxBdCfHtHpazUY=

> The result of devm_gpiod_get_optional() is now assigned directly
> assigned to pcie->reset_gpio. This removes a superfluous local gpiod
> variable, improving code readability and compactness. The functionality
> remains unchanged, but the code is now more streamlined

Would a corresponding imperative wording become helpful for an improved change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.18-rc3#n94

Regards,
Markus

