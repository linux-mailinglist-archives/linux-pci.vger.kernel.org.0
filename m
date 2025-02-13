Return-Path: <linux-pci+bounces-21341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D2FA34057
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 14:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223CE16A21F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 13:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C871221733;
	Thu, 13 Feb 2025 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/UUx3at"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2157723F417;
	Thu, 13 Feb 2025 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453210; cv=none; b=TnDF5/oLOacfu9RBMLeqVRSdghRMysBws0V0h6zJolZr8ulAstmUTX8LJImOOPv1wwLbOLT3HfyBM+EpV6cg/Ty41Kn9QkyH7qq/n16/uKrDv5ZNC7lx3LejunfpG8B003tmDNCzabbVOp4hINNc5rKweZMPugVTxFQYGpgqQss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453210; c=relaxed/simple;
	bh=ZKIHzO3MmoYTOlkYq7wpIbMxe+b5FuF0Cg59iiDAdz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gc7EGcZTBkLkgI1wY1Kos8pg/OYWDS+Q7Oj6/yv+mmdaAMkYP2VVx3vWc5EdWP2zx/oJkq2uTRft1I9STVxMMGXN/opRtAAYCFXzrsxtDZ3Oc9q2mQwL1/GmMxhSBYkCB7yw6wrrsgCLbjDcuEwT1wfrdUz7Kr6/0Xml9PYSTSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/UUx3at; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B13C4CED1;
	Thu, 13 Feb 2025 13:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739453209;
	bh=ZKIHzO3MmoYTOlkYq7wpIbMxe+b5FuF0Cg59iiDAdz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/UUx3atwiIbNuSprBKdrXNY1FKJK5o5lggdnt3LGge622e7qvDIu1pSc39IXnrzV
	 actNRAiam3iyq1AsBhMNPjoLzNqZgcmGjRlDP165L/mcRjp2oaNnf54Aaa6XZSQ+Tq
	 SkAWSpXsvCmJglX5TyMFIrbhz55AEzAVV6KW1M1s9DUfH+HQ6OFJDqs++cVJV7+Tkp
	 e+RHGPUnz/Dl5WrJsL9Lj32WvUadCxWtZ7ApzVmwpWKVScm58519VnXmllJEVBBW25
	 3yAVfaHnnjVksYUOfJTbpOV90IHbiUWEDRNfxTFA4kAplTnd5TwOxtKh7ibxHUxG02
	 XuRZwdBNX84xA==
Date: Thu, 13 Feb 2025 14:26:44 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 3/5] misc: pci_endpoint_test: Fix irq_type to convey
 the correct type
Message-ID: <Z63zFBn6jDZG4s9d@ryzen>
References: <20250210075812.3900646-1-hayashi.kunihiko@socionext.com>
 <20250210075812.3900646-4-hayashi.kunihiko@socionext.com>
 <Z6oi7lH7hhA3uN46@ryzen>
 <9c465e4c-ed43-4fd1-b7a7-b4c49a996fe4@socionext.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c465e4c-ed43-4fd1-b7a7-b4c49a996fe4@socionext.com>

On Thu, Feb 13, 2025 at 07:21:45PM +0900, Kunihiko Hayashi wrote:
> Hi Niklas,
> 
> On 2025/02/11 1:01, Niklas Cassel wrote:
> > On Mon, Feb 10, 2025 at 04:58:10PM +0900, Kunihiko Hayashi wrote:
> > > There are two variables that indicate the interrupt type to be used
> > > in the next test execution, "irq_type" as global and test->irq_type.
> > > 
> > > The global is referenced from pci_endpoint_test_get_irq() to preserve
> > > the current type for ioctl(PCITEST_GET_IRQTYPE).
> > > 
> > > The type set in this function isn't reflected in the global "irq_type",
> > > so ioctl(PCITEST_GET_IRQTYPE) returns the previous type.
> > > As a result, the wrong type will be displayed in "pcitest" as follows:
> > > 
> > >      # pcitest -i 0
> > >      SET IRQ TYPE TO LEGACY:         OKAY
> > >      # pcitest -I
> > >      GET IRQ TYPE:           MSI
> > > 
> > > Fix this issue by propagating the current type to the global "irq_type".
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: b2ba9225e031 ("misc: pci_endpoint_test: Avoid using module
> > parameter to determine irqtype")
> > > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > > ---
> > >   drivers/misc/pci_endpoint_test.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/misc/pci_endpoint_test.c
> > b/drivers/misc/pci_endpoint_test.c
> > > index f13fa32ef91a..6a0972e7674f 100644
> > > --- a/drivers/misc/pci_endpoint_test.c
> > > +++ b/drivers/misc/pci_endpoint_test.c
> > > @@ -829,6 +829,7 @@ static int pci_endpoint_test_set_irq(struct
> > pci_endpoint_test *test,
> > >   		return ret;
> > >   	}
> > > +	irq_type = test->irq_type;
> > 
> > It feels a bit silly to add this line, when you remove this exact line in
> > the next patch. Perhaps just drop this patch?
> 
> This fix will be removed in patch 4/5, so it seems no means.
> However, there is an issue in the stable version, as mentioned in the
> commit message, so I fix it here.

Ok. Having a small fix first that can be backported, which is then followed
by a bigger cleanup, makes sense in this case.

Reviewed-by: Niklas Cassel <cassel@kernel.org>

