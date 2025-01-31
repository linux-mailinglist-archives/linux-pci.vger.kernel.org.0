Return-Path: <linux-pci+bounces-20588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F29D8A23D96
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 13:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE9A3A3288
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 12:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E61D1BEF9C;
	Fri, 31 Jan 2025 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFlk5tVt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315F416D9AF;
	Fri, 31 Jan 2025 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738325460; cv=none; b=DR5JdZ//tG0PVWLRAjpB/eolQms1xk58ixnNJwdN6DTeqz5j7SgUXxySHPPN78X12ZZtMA7uGWo6gYLG2TadtM/s3jm5rfUcaGGENluaBqbdRLDfKJWgCY85+iC/cpAj5EBecjTTMwyFq6w2c2h1YqnRq8OTWdzqTCb9tsirHio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738325460; c=relaxed/simple;
	bh=w1qgVX6KVZi0y9FHyMyF0Xbn+fd2az8TY31OE1kbGRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miWAhSF7F7s3lWRYaWQuI9bbH5CRxmS0Ie8A33dcszFBgBR3hbRDt0xO09zNTno57mVEn8wm7SOpLjcocfw9sK3KcPZJMIjAA/ic6tSqlNoQu6yXFTFLDx3R0L4dm8zUlNvRG8TVFSzUK5FKRw1p+4av0Drg50V6dGYbN966JCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFlk5tVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D780C4CED1;
	Fri, 31 Jan 2025 12:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738325459;
	bh=w1qgVX6KVZi0y9FHyMyF0Xbn+fd2az8TY31OE1kbGRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFlk5tVte/xD/uhF1bTM9LL9ADBmm8jpKdGbSg4w8VexVxd02356CHTrvybJL23k6
	 ER5lMO/0bka6qv5mw1v7RguIMfiteT+UIFiS85xepIoeoLNlu+GPpu8Hy+7O9F+fiR
	 ZjV6OrWsE3AcMTx9cq90l+8EBulrDRIGPvW5h/Zx1yhpr0wjNDoSPETidyN64HS/Je
	 eFfPSb4d0uZvv6zv+RP2pP/jYiZXiIhzVscOOA6LwkX634ziV5z0As+6dpemM+fcDB
	 qdMkZO08b0TMKtUu+OuibP9ttRfckhJIbUHDIvHIkLvmSsGhwQI2TxXKiRdubYJM7f
	 PjzEzCeSPPPMQ==
Date: Fri, 31 Jan 2025 13:10:54 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] misc: pci_endpoint_test: Fix irq_type to convey
 the correct type
Message-ID: <Z5y9zpFGkBnY2TG1@ryzen>
References: <20250122022446.2898248-1-hayashi.kunihiko@socionext.com>
 <20250122022446.2898248-4-hayashi.kunihiko@socionext.com>
 <20250128143231.ondpjpugft37qwo5@thinkpad>
 <Z5oX5Fe5FY2Pym0u@ryzen>
 <fe8c2233-fa2a-4356-8005-6cbabf6a0e96@socionext.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe8c2233-fa2a-4356-8005-6cbabf6a0e96@socionext.com>

On Fri, Jan 31, 2025 at 07:16:54PM +0900, Kunihiko Hayashi wrote:
> Hi Niklas,
> 
> On 2025/01/29 20:58, Niklas Cassel wrote:
> > On Tue, Jan 28, 2025 at 08:02:31PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Jan 22, 2025 at 11:24:46AM +0900, Kunihiko Hayashi wrote:
> > > > There are two variables that indicate the interrupt type to be used
> > > > in the next test execution, "irq_type" as global and test->irq_type.
> > > > 
> > > > The global is referenced from pci_endpoint_test_get_irq() to preserve
> > > > the current type for ioctl(PCITEST_GET_IRQTYPE).
> > > > 
> > > > The type set in this function isn't reflected in the global "irq_type",
> > > > so ioctl(PCITEST_GET_IRQTYPE) returns the previous type.
> > > > As a result, the wrong type will be displayed in "pcitest" as follows:
> > > > 
> > > >      # pcitest -i 0
> > > >      SET IRQ TYPE TO LEGACY:         OKAY
> > > >      # pcitest -I
> > > >      GET IRQ TYPE:           MSI
> > > > 
> > > > Fix this issue by propagating the current type to the global "irq_type".
> > > > 
> > > 
> > > This is becoming a nuisance. I think we should get rid of the global
> > > 'irq_type'
> > > and just stick to the one that is configurable using IOCTL command. Even
> > > if the
> > > user has configured the global 'irq_type' it is bound to change with IOCTL
> > > command.
> > 
> > +1
> 
> After fixing the issue described in this patch,
> we can replace with a new member of 'struct pci_endpoint_test' instead.

Sorry, but I don't understand what you mean here.
You want this patch to be applied.
Then you want to add a new struct member to struct pci_endpoint_test?
struct pci_endpoint_test already has a struct member named irq_type,
so why do you want to add a new member?

Like Mani suggested, I think it would be nice if we could remove the
global irq_type kernel module parameter, and change so that
PCITEST_GET_IRQTYPE returns test->irq_type.


Note that your series does not apply to pci/next, and needs to be rebased.
(It conflicts with f26d37ee9bda ("misc: pci_endpoint_test: Fix IOCTL return value"))


> 
> > But I also don't like how since we migrated to selftests:
> > READ_TEST / WRITE_TEST / COPY_TEST unconditionally call
> > ioctl(PCITEST_SET_IRQTYPE, MSI) before doing their thing.
> 
> I think that it's better to prepare new patch series.

Here, I was pointing out what I think is a regression with the
migration to selftests. (Which is unrelated to this series.)

I do suggest a way to improve things futher down (introducing a
PCITEST_SET_IRQTYPE, AUTO), but I don't think that you need to be
the one implementing this suggestion, since you did not introduce
this regression.


> 
> > Will this cause the test case to fail for platforms that only support MSI-X?
> > (See e.g. dwc/pci-layerscape-ep.c where this could be the case.)
> > 
> > 
> > Sure, before, in pcitest.sh, we would do:
> > 
> > 
> > pcitest -i 2
> >          pcitest -x $msix
> > 
> > 
> > pcitest -i 1
> > 
> > pcitest -r -s 1
> > pcitest -r -s 1024
> > pcitest -r -s 1025
> > pcitest -r -s 1024000
> > pcitest -r -s 1024001
> > 
> > 
> > Which would probably print an error if:
> > pcitest -i 1
> > failed.
> > 
> > but the READ_TEST / WRITE_TEST / COPY_TEST tests themselves
> > would not fail.
> > 
> > 
> > Perhaps we should rethink this, and introduce a new
> > PCITEST_SET_IRQTYPE, AUTO
> > 
> > I would be fine if
> > READ_TEST / WRITE_TEST / COPY_TEST
> > called PCITEST_SET_IRQTYPE, AUTO
> > before doing their thing.
> > 
> > 
> > 
> > How I suggest PCITEST_SET_IRQTYPE, AUTO
> > would work:
> > 
> > Since we now have capabilties merged:
> > https://lore.kernel.org/linux-pci/20241203063851.695733-4-cassel@kernel.org/
> > 
> > Add epc_features->msi_capable and epc->features->msix_capable
> > as two new bits in the PCI_ENDPOINT_TEST_CAPS register.
> > 
> > If PCITEST_SET_IRQTYPE, AUTO:
> > if EP CAP has msi_capable set: set IRQ type MSI
> > else if EP CAP has msix_capable set: set IRQ type MSI-X
> > else: set legacy/INTx
> 
> There is something ambiguous about the behavior for me.
> 
> The test->irq_type has a state "UNDEFINED".
> After issueing "Clear IRQ", test->irq_type becomes "UNDEFINED" currently,
> and all tests with IRQs will fail until new test->irq_type is set.

That is fine, no?

If a user calls PCITEST_CLEAR_IRQ without doing a PCITEST_SET_IRQTYPE
afterwards, what else can the tests relying on IRQs to other than fail?

FWIW, tools/testing/selftests/pci_endpoint/pci_endpoint_test.c never does
an ioctl(PCITEST_CLEAR_IRQ).

> 
> If SET_IRQTYPE is AUTO, how will test->irq_type be set?

I was thinking something like this:

pci_endpoint_test_set_irq()
{
	u32 caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);

	...

	if (req_irq_type == IRQ_TYPE_AUTO) {
		if (caps & MSI_CAPABLE)
			test->irq_type = IRQ_TYPE_MSI;
		else if (caps & MSIX_CAPABLE)
			test->irq_type = IRQ_TYPE_MSIX;
		else
			test->irq_type = IRQ_TYPE_INTX;

	}

	...
}


Kind regards,
Niklas

