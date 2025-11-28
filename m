Return-Path: <linux-pci+bounces-42270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 068D8C92C66
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 18:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C557E4E3EC2
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 17:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995552E0401;
	Fri, 28 Nov 2025 17:16:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EDC23E34C;
	Fri, 28 Nov 2025 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764350212; cv=none; b=EA4fMs8gy3//cQikwRErCxk9oyZsM7Y4rnhA0TNpulsQNkuSqbDM2P+iYUSc4Opoxcawl/4PDMJxJT1zDCbOl3Y7pnSPZum4esJadhUjzKh3y/axHFLhZpaqut/SD6aiLOCI58EGcHGkfVrrFuXcbQBH/SzgpfjommVBOsdWP3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764350212; c=relaxed/simple;
	bh=3YDnKw4WOsV4HcQQ9rti2zBzy5hkLujDf8tBfYuNFc4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fcerOtCf5WB+asjgZYWlU0XU45HgwBA5s42EmiaFpESRFm6rL/u7Wxglf/OFD7oQXdgGM7BMVD7wMaZWFaFQ/A4PWswUqBLMXcQOJlI0lD42Rao9cK/ERsl+q2OCZpdl1x8YIw8fjKL4iALNFqd7f9inVFp6dU4Vwhe5oOfoFT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id CED5B92009C; Fri, 28 Nov 2025 18:16:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id BFC7492009B;
	Fri, 28 Nov 2025 17:16:47 +0000 (GMT)
Date: Fri, 28 Nov 2025 17:16:47 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
cc: Manivannan Sadhasivam <mani@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
    Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    Krzysztof Kozlowski <krzk@kernel.org>, 
    Alim Akhtar <alim.akhtar@samsung.com>, 
    Jonathan Chocron <jonnyc@amazon.com>, linux-pci@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 4/4] PCI: dwc: Support ECAM mechanism by enabling iATU
 'CFG Shift Feature'
In-Reply-To: <cabf4c20-095b-4579-adc1-146a566b19b9@oss.qualcomm.com>
Message-ID: <alpine.DEB.2.21.2511281714030.36486@angie.orcam.me.uk>
References: <20250909-controller-dwc-ecam-v9-0-7d5b651840dd@kernel.org> <20250909-controller-dwc-ecam-v9-4-7d5b651840dd@kernel.org> <alpine.DEB.2.21.2511280256260.36486@angie.orcam.me.uk> <c7aea2b3-6984-40f5-8234-14d265dabefc@oss.qualcomm.com>
 <alpine.DEB.2.21.2511280755440.36486@angie.orcam.me.uk> <cabf4c20-095b-4579-adc1-146a566b19b9@oss.qualcomm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 28 Nov 2025, Krishna Chaitanya Chundru wrote:

> >   I have no slightest idea why it should cause a regression such as this,
> > it seems totally unrelated.  Yet it's 100% reproducible.  Could this be
> > because it's the only device in the system that actually uses PCI/e port
> > I/O?
> Hi Maciej, Can you try attached patch and let me know if that is helping you
> or not. - Krishna Chaitanya.

 No change, it's still broken, sorry.

  Maciej

