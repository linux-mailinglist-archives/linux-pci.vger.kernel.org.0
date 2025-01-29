Return-Path: <linux-pci+bounces-20534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711DDA21CE6
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 13:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC643A7947
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 11:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C45E1DCB24;
	Wed, 29 Jan 2025 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNYpZix9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42191DC99A;
	Wed, 29 Jan 2025 11:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738151913; cv=none; b=m118gbgTWAmb86RSZ8I0XStytaU/767Ux0xr7rgntFI2SXV16aZJmuYynwTqsUCVYiF3QxV70KCH16ESLgeIwM3g6wPbhSkDxTosyX6qRXJwtqdJ0mMJ4iwnTCPzlZ3VrX1aNKsVOqvkEOZ+rgUlS0Lcjkxc9lmZUKxCFEVnrhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738151913; c=relaxed/simple;
	bh=J6icmGxZaP+EWTQ2SsczxJniWo3NDYUWO1P6FrI4usQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtKV5SZCCIaEC+3fUcB9b9WEmUt5Y+9o0aH75A8jREZ2wH1JLReVJ2uo9/lnxdTBvA3pFU9XSACedoRkZKAHqjq8SviJLE5v0I9lbCqAPjub7S47W+cfqZOoCBVB2PcborNTf/pQDuhiqV0uPQiTnJA5BM8zwex0AR9AKmXHCRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNYpZix9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C54C4CED3;
	Wed, 29 Jan 2025 11:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738151913;
	bh=J6icmGxZaP+EWTQ2SsczxJniWo3NDYUWO1P6FrI4usQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KNYpZix9vwkLaNURDTusEXhIZaOx7nqEaUAtDGfmLLtpve6Q+eXy29D58GZ4NbaNo
	 0y9PG9ZKzuFmaNgoOK2nKQlegT6vubWJyo7YbrQSTXc6ZyezmW5iCcq6DDfCyDB2ha
	 g8YUxhNjngOqjIUXh80v1JN7eNB8j2Q8BPpzcnkzmyofLSJmiOyhjoj0OThy+27Lsg
	 hYZAgUzyys/76cC6w56M3Wm82ssyvU1lnri8fdhJ8GZz/iolB/w1tlQhu0akSIWX0v
	 lN8gq3UUSuXynJf/JBwXMuYvflh2DusXDuInyk1ZZ34J5AlgwymhPZeKk52Tm+PCcB
	 Jhm0jd1j14bxg==
Date: Wed, 29 Jan 2025 12:58:28 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Krzysztof =?utf-8?B?V2lsY3p577+977+977+9c2tp?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] misc: pci_endpoint_test: Fix irq_type to convey
 the correct type
Message-ID: <Z5oX5Fe5FY2Pym0u@ryzen>
References: <20250122022446.2898248-1-hayashi.kunihiko@socionext.com>
 <20250122022446.2898248-4-hayashi.kunihiko@socionext.com>
 <20250128143231.ondpjpugft37qwo5@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128143231.ondpjpugft37qwo5@thinkpad>

On Tue, Jan 28, 2025 at 08:02:31PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jan 22, 2025 at 11:24:46AM +0900, Kunihiko Hayashi wrote:
> > There are two variables that indicate the interrupt type to be used
> > in the next test execution, "irq_type" as global and test->irq_type.
> > 
> > The global is referenced from pci_endpoint_test_get_irq() to preserve
> > the current type for ioctl(PCITEST_GET_IRQTYPE).
> > 
> > The type set in this function isn't reflected in the global "irq_type",
> > so ioctl(PCITEST_GET_IRQTYPE) returns the previous type.
> > As a result, the wrong type will be displayed in "pcitest" as follows:
> > 
> >     # pcitest -i 0
> >     SET IRQ TYPE TO LEGACY:         OKAY
> >     # pcitest -I
> >     GET IRQ TYPE:           MSI
> > 
> > Fix this issue by propagating the current type to the global "irq_type".
> > 
> 
> This is becoming a nuisance. I think we should get rid of the global 'irq_type'
> and just stick to the one that is configurable using IOCTL command. Even if the
> user has configured the global 'irq_type' it is bound to change with IOCTL
> command.

+1


But I also don't like how since we migrated to selftests:
READ_TEST / WRITE_TEST / COPY_TEST unconditionally call
ioctl(PCITEST_SET_IRQTYPE, MSI) before doing their thing.

Will this cause the test case to fail for platforms that only support MSI-X?
(See e.g. dwc/pci-layerscape-ep.c where this could be the case.)


Sure, before, in pcitest.sh, we would do:


pcitest -i 2
        pcitest -x $msix


pcitest -i 1

pcitest -r -s 1
pcitest -r -s 1024
pcitest -r -s 1025
pcitest -r -s 1024000
pcitest -r -s 1024001


Which would probably print an error if:
pcitest -i 1
failed.

but the READ_TEST / WRITE_TEST / COPY_TEST tests themselves
would not fail.


Perhaps we should rethink this, and introduce a new
PCITEST_SET_IRQTYPE, AUTO

I would be fine if
READ_TEST / WRITE_TEST / COPY_TEST
called PCITEST_SET_IRQTYPE, AUTO
before doing their thing.



How I suggest PCITEST_SET_IRQTYPE, AUTO
would work:

Since we now have capabilties merged:
https://lore.kernel.org/linux-pci/20241203063851.695733-4-cassel@kernel.org/

Add epc_features->msi_capable and epc->features->msix_capable
as two new bits in the PCI_ENDPOINT_TEST_CAPS register.

If PCITEST_SET_IRQTYPE, AUTO:
if EP CAP has msi_capable set: set IRQ type MSI
else if EP CAP has msix_capable set: set IRQ type MSI-X
else: set legacy/INTx


Kind regards,
Niklas

