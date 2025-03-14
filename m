Return-Path: <linux-pci+bounces-23768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC28BA61782
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 18:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7403BF490
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 17:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCCF202C55;
	Fri, 14 Mar 2025 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sA8CbSgw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0A878F2E
	for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973160; cv=none; b=B8rSTHV7VXQ9t9G2xSr6pKircbI6kdqijW6LUsciXVRPJga96gVbXwQPK0THdP5/+qavtXUVNMMPWdt0ZyYY425HxUiIpiOuQ/iCqLH240R5WvQV7B+k92Sw8KZhKFdZ3oxDuTkENCNXijU4tfjF3QI+LLH1YmSrNrsno5X3m74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973160; c=relaxed/simple;
	bh=UIJXNolUGtJfcKywP8uH0tGGNZVAqDCIpjVKL+n0aYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N754rSxO2EFM9Sxt+1WHdHnVNLtd6czLrkM47A20+SXfHBGyTCkwqncGZhHp0I6b+O5RdvYspt6f94d51K5zr8EC0EdingFqNNidTJq8JA2DCT9rVHo0L/6kVw0x9xHwmlHH52cDKFLcGIl1pRj2jLo1rWmmdfhegagePtsF0Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sA8CbSgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE989C4CEE3;
	Fri, 14 Mar 2025 17:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741973159;
	bh=UIJXNolUGtJfcKywP8uH0tGGNZVAqDCIpjVKL+n0aYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sA8CbSgwCiXt1+XeENj4l1v79xz5IwtVN7Q2PzEsdiH91yJiwlZpbntv+YXry3kMY
	 5RN7tY4T4IgUOf97XxbJPFAJAbGC5oEHvpC4Kcuaog+q5WGlJ0Onm79UXo+LTucUrt
	 yymykQfGfNA6X4EbVh98EYVlyOG8aCs/ULYSyO/4a/7koJeFfOmA130/9q0Cr0VNKc
	 xVB4jfF/qDqqOR6BebAq/T1z9FkY2Jkab+HSoVSssfpztHeULi3mtJasj8zmuDvYhq
	 ViofhMTc1y9CKMg4Lvm+z9bl3PjeZ0mpN6+pk8ueht7mmrXXkHddneQKh6jdeU+FV9
	 IIGaZZBW5e0uw==
Date: Fri, 14 Mar 2025 18:25:54 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 7/7] misc: pci_endpoint_test: Add support for
 PCITEST_IRQ_TYPE_AUTO
Message-ID: <Z9Rmoh_vtrXzFG0X@ryzen>
References: <20250310111016.859445-9-cassel@kernel.org>
 <20250310111016.859445-16-cassel@kernel.org>
 <20250314124548.inffbk3c4kw22rwb@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314124548.inffbk3c4kw22rwb@thinkpad>

Hello Mani,

On Fri, Mar 14, 2025 at 06:15:48PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Mar 10, 2025 at 12:10:24PM +0100, Niklas Cassel wrote:
> > For PCITEST_MSI we really want to set PCITEST_SET_IRQTYPE explicitly
> > to PCITEST_IRQ_TYPE_MSI, since we want to test if MSI works.
> > 
> > For PCITEST_MSIX we really want to set PCITEST_SET_IRQTYPE explicitly
> > to PCITEST_IRQ_TYPE_MSIX, since we want to test if MSI works.
> > 
> > For PCITEST_LEGACY_IRQ we really want to set PCITEST_SET_IRQTYPE explicitly
> > to PCITEST_IRQ_TYPE_INTX, since we want to test if INTx works.
> > 
> > However, for PCITEST_WRITE, PCITEST_READ, PCITEST_COPY, we really don't
> > care which IRQ type that is used, we just want to use a IRQ type that is
> > supported by the EPC.
> > 
> > The old behavior was to always use MSI for PCITEST_WRITE, PCITEST_READ,
> > PCITEST_COPY, was to always set IRQ type to MSI before doing the actual
> > test, however, there are EPC drivers that do not support MSI.
> > 
> > Add a new PCITEST_IRQ_TYPE_AUTO, that will use the CAPS register to see
> > which IRQ types the endpoint supports, and use one of the supported IRQ
> > types.
> > 
> 
> If the intention is to let the test figure out the supported IRQ type, why can't
> you move the logic to set the supported IRQ to
> pci_endpoint_test_{copy/read/write} functions itself?

If you look at how things were before your commit 392188bb0f6e ("selftests:
pci_endpoint: Migrate to Kselftest framework"):

echo "Read Tests"
echo

pcitest -i 1

pcitest -r -s 1
pcitest -r -s 1024
pcitest -r -s 1025
pcitest -r -s 1024000
pcitest -r -s 1024001
echo

echo "Write Tests"
echo

pcitest -w -s 1
pcitest -w -s 1024
pcitest -w -s 1025
pcitest -w -s 1024000
pcitest -w -s 1024001
echo

echo "Copy Tests"
echo

pcitest -c -s 1
pcitest -c -s 1024
pcitest -c -s 1025
pcitest -c -s 1024000
pcitest -c -s 1024001


All three test cases were using MSI.


However, there was no error handling, so for a platform only supporting
MSI-X, the call to "pcitest -i 1" could fail, and the tests were still
going to use MSI-X (or whatever supported by the platform), and pass.



After your commit 392188bb0f6e ("selftests: pci_endpoint: Migrate to
Kselftest framework"):


TEST_F(pci_ep_data_transfer, READ_TEST)
{
	struct pci_endpoint_test_xfer_param param = {};
	int ret, i;

	if (variant->use_dma)
		param.flags = PCITEST_FLAGS_USE_DMA;

	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 1);
	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");

	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
		param.size = test_size[i];
		pci_ep_ioctl(PCITEST_READ, &param);
		EXPECT_FALSE(ret) TH_LOG("Test failed for size (%ld)",
					 test_size[i]);
	}
}

TEST_F(pci_ep_data_transfer, WRITE_TEST)
{
	struct pci_endpoint_test_xfer_param param = {};
	int ret, i;

	if (variant->use_dma)
		param.flags = PCITEST_FLAGS_USE_DMA;

	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 1);
	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");

	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
		param.size = test_size[i];
		pci_ep_ioctl(PCITEST_WRITE, &param);
		EXPECT_FALSE(ret) TH_LOG("Test failed for size (%ld)",
					 test_size[i]);
	}
}

TEST_F(pci_ep_data_transfer, COPY_TEST)
{
	struct pci_endpoint_test_xfer_param param = {};
	int ret, i;

	if (variant->use_dma)
		param.flags = PCITEST_FLAGS_USE_DMA;

	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 1);
	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");

	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
		param.size = test_size[i];
		pci_ep_ioctl(PCITEST_COPY, &param);
		EXPECT_FALSE(ret) TH_LOG("Test failed for size (%ld)",
					 test_size[i]);
	}
}


Each test case explicitly calls ioctl(PCITEST_SET_IRQTYPE, 1); to use MSI,
and unlike before, will fail the test case if PCITEST_SET_IRQTYPE fails.


Then take Kunihiko commit 9240c27c3fdd ("misc: pci_endpoint_test: Remove
global 'irq_type' and 'no_msi'")

Before your and Kunihiko commits, a platform that did set the kernel module
parameter 'irq_type' would, if 'pcitest -i 1' failed,  use the value set by
that kernel module parameter for the read/write/copy test cases.

There is no guarantee that an EPC supports MSI, it might support only legacy
and INTx, so I was trying to restore use cases that were previously working.



I guess one option would be to remove the
"pci_ep_ioctl(PCITEST_SET_IRQTYPE, 1);" calls from the test cases that you
added, and then let the test cases themselves set the proper irq_type in
the BAR register. But, wouldn't that be an API change? READ/WRITE/COPY
test ioctls have always respected the (a successful) PCITEST_SET_IRQTYPE,
now all of a sudden, they shouldn't?


Since your commit 392188bb0f6e: each test case calls PCITEST_SET_IRQTYPE,
and gives an error if the PCITEST_SET_IRQTYPE ioctl() fails.

See Kunihiko commit log:
"... all tests that use interrupts first call ioctl(SET_IRQTYPE)
to set "test->irq_type", then write the value of test->irq_type into
the register pointed by test_reg_bar, and request the interrupt to the
endpoint. The endpoint function driver, pci-epf-test, refers to the
register, and determine which type of interrupt to raise."

READ/WRITE/COPY test cases/ioctls use interrupts.


I guess we could modify the read/write/copy test cases to not call
ioctl(SET_IRQTYPE), and remove the verification that ioctl(SET_IRQTYPE)
succeded, and change the behavior from older kernel releases, and make
READ/WRITE/COPY ioctls from now on ignore the configured irq_type using
ioctl(SET_IRQTYPE).

(If the user is using a selftest binary that has the ioctl(SET_IRQTYPE)
and ioctl(SET_IRQTYPE) verification in these test cases, the IRQ_TYPE
will get changed, so the verification will pass, but the succeeding
ioctl will not use that irq_type.)

But...

Is that really simpler / less confusing that just adding IRQ_TYPE_AUTO,
to maintain the uniformity that all test cases that will trigger IRQs
call ioctl(SET_IRQTYPE) before the actual ioctl that will trigger IRQs?


Kind regards,
Niklas

