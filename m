Return-Path: <linux-pci+bounces-24347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72538A6BBBA
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 14:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF10C189280B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 13:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B70622A7FF;
	Fri, 21 Mar 2025 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKc0s5xA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6703D22A7F4
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742563659; cv=none; b=HKEIrOgiM2O1/bPw6bXnNh9vfFwe4Au28oYOCfGXvFTVyxlNe2XIMA7PIJR6jJYhDGauK9aC1AkMb8SY1tgfM6IWi+Nj9BjAfIu0vzXjMYoHk4VJ51LSRZli0hmNWFfTY8iZk8PWPQabuU1BIu0WO+ACk/iAZifz0P0Y8to9xFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742563659; c=relaxed/simple;
	bh=AVxzUTP8MmtTvT1tmfx33iZtiXKdp2B3kyLrkrgPfL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFSQFCk0CfozTFffAl2cTAvBeauxmCFtY3gKoyM3AyCBWdXPUNnmkCCQx5l10VXTRaTfDuBpESQUak+GeES2RNChV8cEqMvDl3kjdb21FX4bwfnVrYu7I9byvRjxfo/OuOdNku204vOzcrvZqqVxGnRat+PnyX83Pc6eRBSP+jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKc0s5xA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE77C4CEE3;
	Fri, 21 Mar 2025 13:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742563658;
	bh=AVxzUTP8MmtTvT1tmfx33iZtiXKdp2B3kyLrkrgPfL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hKc0s5xATUY3asB6hnmBqq1o0JVXwgU/HEmr1howEc4mFbB8XfX/OsJ2JxYhozhXS
	 asm3aivfwscKA2gtNKET+JEt0ZIJNu9MUkvjL56P98ZHeS+3Olod+FhMLD1PKVFGR2
	 GJI6bcs3hhdzqgxCSKezXWsQiVvj3p+dtmhweiZNrsJ9B3IT1n9xA0KGZAcBpspM4I
	 ent3zTDWFgmwYGKSM+G0wwQlp1gmaxho9OunOcNqfJmWd9VE+pyLdGcPGx/ri1CywB
	 ZXUkdY/UnI/ZczdK7vAlYwB48xIRBpWG/cJ+a5y829MJ38I7K/v5aFQcrTDxLQaEXe
	 W/w9abP46n/+g==
Date: Fri, 21 Mar 2025 14:27:34 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 3/4] misc: pci_endpoint_test: Let
 PCITEST_{READ,WRITE,COPY} set IRQ type automatically
Message-ID: <Z91pRhf50ErRt5jD@x1-carbon>
References: <20250318103330.1840678-6-cassel@kernel.org>
 <20250318103330.1840678-9-cassel@kernel.org>
 <20250320152732.l346sbaioubb5qut@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320152732.l346sbaioubb5qut@thinkpad>

Hello Mani,

On Thu, Mar 20, 2025 at 08:57:32PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Mar 18, 2025 at 11:33:34AM +0100, Niklas Cassel wrote:
> > The test cases for read/write/copy currently do:
> > 1) ioctl(PCITEST_SET_IRQTYPE, MSI)
> > 2) ioctl(PCITEST_{READ,WRITE,COPY})
> > 
> > This design is quite bad for a few reasons:
> > -It assumes that all PCI EPCs support MSI.
> > -One ioctl should be sufficient for these test cases.
> > 
> > Modify the PCITEST_{READ,WRITE,COPY} ioctls to set IRQ type automatically,
> > overwriting the currently configured IRQ type. It there are no IRQ types
> > supported in the CAPS register, fall back to MSI IRQs. This way the
> > implementation is no worse than before this commit.
> > 
> > Any test case that requires a specific IRQ type, e.g. MSIX_TEST, will do
> > an explicit PCITEST_SET_IRQTYPE ioctl at the start of the test case, thus
> > it is safe to always overwrite the configured IRQ type.
> > 
> 
> I don't quite understand this sentence.

What I was trying to say is that it is okay if PCITEST_{READ,WRITE,COPY}
ioctls always overwrite the configured IRQ type, because all test cases
in tools/testing/selftests/pci_endpoint/pci_endpoint_test.c that require
a specific IRQ type, e.g.:

- TEST_F(pci_ep_basic, LEGACY_IRQ_TEST)
  will call pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_INTX);
  before calling pci_ep_ioctl(PCITEST_LEGACY_IRQ, 0);

- TEST_F(pci_ep_basic, MSI_TEST)
  will call pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_MSI);
  before calling pci_ep_ioctl(PCITEST_MSI, i);

- TEST_F(pci_ep_basic, MSIX_TEST)
  will call pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_MSIX);
  before calling pci_ep_ioctl(PCITEST_MSIX, i);

Thus, all test cases will still work, even if PCITEST_{READ,WRITE,COPY}
overwrites the configured IRQ type.


> What if users wants to use a specific
> IRQ type like MSI-X if the platform supports both MSI/MSI-X? That's why I wanted
> to honor 'test->irq_type' if already set before READ,WRITE,COPY testcases.

As I said, I don't think you can have the cake and eat it too ;)

Let me explain:
If you simply run pcitest, it will execute the test cases in the following
order:
1) pci_ep_bar.BARx.BAR_TEST
2) pci_ep_basic.CONSECUTIVE_BAR_TEST
3) pci_ep_basic.LEGACY_IRQ_TEST
4) pci_ep_basic.MSI_TEST
5) pci_ep_basic.MSIX_TEST
6) pci_ep_data_transfer.memcpy.READ_TEST
7) pci_ep_data_transfer.memcpy.WRITE_TEST
8) pci_ep_data_transfer.memcpy.COPY_TEST

Thus, when you reach 6) (READ_TEST), irq_type will already be set, and
READ_TEST will use whatever IRQ type that happened to be the last one that was
executed successfully. That unpredictability doesn't sound like very good
design to me.


To me, it sounds like what you want is actually what is already queued up on
pci/next.

Because with that, READ_TEST / WRITE_TEST / COPY_TEST test cases will always
call pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_AUTO);
(If you want the behavior that the READ_TEST / WRITE_TEST / COPY_TEST case
should automatically figure out which IRQ type to use.)

If you want to use a specific IRQ type for READ_TEST / WRITE_TEST / COPY_TEST,
it should be trivial to write a new test case variant (or new test case), that
does SET_IRQ(WHICH_EVER_IRQ_TYPE_YOU_WANT); (depending on the test case variant)
followed by the ioctl() for the test itself.

This determinism is not possible if you move the "automatic IRQ selection"
logic to be within the PCITEST_{READ,WRITE,COPY} ioctls. (As this series does.)


I'm travelling to a conference this weekend, and will be busy all next week.

I've sent two proposals, what is currently queued up on pci/next, and this
series.

As you might guess, I think that IRQ_TYPE_AUTO is the most elegant solution
with regard to the existing design.

But, if you want to make changes before the merge window opens, feel free to:
-Take over this series; or
-Write your own series on top of what is on pci/next; or
-Keep pci/next as it is.


I'm really (honestly) happy with whatever solution, as long as we, once again,
handle EPCs that only support INTx, or only support MSI-X.

(Because ever since your patch series that migrated pcitest to selftests,
READ_TEST / WRITE_TEST / COPY_TEST test cases unconditionally use MSI, which
is a regression for EPCs that only support INTx, or only support MSI-X,
which is the whole reason why I wrote this series.)


Kind regards,
Niklas

