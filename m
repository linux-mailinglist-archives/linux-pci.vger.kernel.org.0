Return-Path: <linux-pci+bounces-4801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FC887B6E9
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 04:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F721C20615
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 03:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CBA4C9F;
	Thu, 14 Mar 2024 03:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVadQJjb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59339C13B;
	Thu, 14 Mar 2024 03:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710387579; cv=none; b=T9hLTrqtk1d8UaBVgFpJVQsbEUFTHj76Hvq+GmbL9W0DbQS/HJu9DFGx7i/+4SVju/3o9PxIl7u5dDdsz+MmS9dqmfSDsPjJqTajkyNCUgd9EV1zcLlNUhw+tX9GvmHxy/Z/SR+k6bjaO0uwf3PNkwWJxaweZx22HcahIAki7UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710387579; c=relaxed/simple;
	bh=TuxkWK7dMQI2KIPAcDcm4V21xNZ8im/k/MzYg+G5fkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDlWPR8z7wTFtbJ8teIuifCQEUqRV5ptaRi1TiK4aRXHM4y/U3EcDpEj33c261P5FdMWXlSZD9rtFWXs5uopUGMpl5GxSO0AlApu3FNwaxcKuIha4qZbBbteOGR7aXW9wxcW045HhFRyZM5zKa+IeT3QUcuLv8nmPYzBC/Pn30M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVadQJjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821A1C433C7;
	Thu, 14 Mar 2024 03:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710387579;
	bh=TuxkWK7dMQI2KIPAcDcm4V21xNZ8im/k/MzYg+G5fkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WVadQJjbFZWBHG8GHuRdNgykOmEZ6ttbZpUFa7bbjwG33qWdzE9Ps3YMtBVDcmDrT
	 AZhleZ2b5KGHZn6mlT+Ppl91rUD3fmzePpss0CcononvFMwAVQWsJueQXgOAcWisW6
	 17TNVXGujlARAFx0dOClWZVRo9M5ZdB8GrztoFCUfZ6mOc4ioQL7YyrbNJJYsMUY2q
	 2QHvBR6ErUNomLNV7PYbHWa+EUGBF8CzpjKQY9a4ulHPZ//c+BMcSOcLBEDYj5eXxA
	 4vVRN7V0xAFFYJtaN07PZu3jgBrVyMmttjepaDsCj0AJQlm/w3phUmnxLOKmeyXXra
	 IrNmeu+2wKGkQ==
Date: Wed, 13 Mar 2024 21:39:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kevin Xie <kevin.xie@starfivetech.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Conor Dooley <conor@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"daire.mcnamara@microchip.com" <daire.mcnamara@microchip.com>,
	"emil.renner.berthing@canonical.com" <emil.renner.berthing@canonical.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>
Subject: Re: [PATCH v15,RESEND 22/23] PCI: starfive: Offload the NVMe timeout
 workaround to host drivers.
Message-ID: <ZfJxdgd57oQwqNHt@kbusch-mbp>
References: <ZeCd+xqE6x2ZFtJN@lpieralisi>
 <mhng-87e7ef5a-d60b-4057-960d-41bc901b6c7f@palmer-ri-x1c9>
 <ZedAn8IC+Mpm4Sqz@lpieralisi>
 <ZQ0PR01MB0981BC562E837B232B419AC28229A@ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn>
 <ZfJmMcs2UThVSC4v@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfJmMcs2UThVSC4v@kbusch-mbp>

On Wed, Mar 13, 2024 at 08:51:29PM -0600, Keith Busch wrote:
> I suppose we could quirk a non-posted transaction in the interrupt
> handler to force flush pending memory updates, but that will noticeably
> harm your nvme performance. Maybe if you constrain such behavior to the
> spurious IRQ_NONE condition, then it might be okay? I don't know.

Hm, that may not be good enough: if nvme completions can be reordered
with their msi's, then I assume data may reorder with their completion.
Your application will inevitably see stale and corrupted data, so it
sounds like you need some kind of barrier per completion. Ouch!

