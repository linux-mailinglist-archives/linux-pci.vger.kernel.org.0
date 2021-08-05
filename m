Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52FA3E13D6
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 13:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241017AbhHEL1B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 07:27:01 -0400
Received: from foss.arm.com ([217.140.110.172]:43118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241022AbhHEL1A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Aug 2021 07:27:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 604E11FB;
        Thu,  5 Aug 2021 04:26:46 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F3753F719;
        Thu,  5 Aug 2021 04:26:44 -0700 (PDT)
Date:   Thu, 5 Aug 2021 12:26:39 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nadeem@cadence.com
Subject: Re: [PATCH v2 5/6] misc: pci_endpoint_test: Do not request or
 allocate IRQs in probe
Message-ID: <20210805112639.GA20438@lpieralisi>
References: <20210803074932.19820-1-kishon@ti.com>
 <20210803074932.19820-6-kishon@ti.com>
 <20210803095839.GA11252@lpieralisi>
 <02c1ddb7-539e-20a0-1bef-e10e76922a0e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02c1ddb7-539e-20a0-1bef-e10e76922a0e@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 04, 2021 at 07:32:44PM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On 03/08/21 3:28 pm, Lorenzo Pieralisi wrote:
> > On Tue, Aug 03, 2021 at 01:19:31PM +0530, Kishon Vijay Abraham I wrote:
> >> Allocation of IRQ vectors and requesting IRQ is done as part of
> >> PCITEST_SET_IRQTYPE. Do not request or allocate IRQs in probe for
> >> AM654 and J721E so that the user space test script has better control
> >> of the devices for which the IRQs are configured. Since certain user
> >> space scripts could rely on allocation of IRQ vectors during probe,
> >> remove allocation of IRQs only for TI's K3 platform.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  drivers/misc/pci_endpoint_test.c | 19 +++++++++++++------
> >>  1 file changed, 13 insertions(+), 6 deletions(-)
> > 
> > I don't claim to understand the inner details of the endpoint test
> > device but it looks like this approach should be redesigned.
> > 
> > I don't believe using devices quirks is the best approach to
> > expose/remove a feature to userspace, this can soon become
> > unmaintenable.
> > 
> > Maybe you can elaborate a bit more on what the real issue is please ?
> 
> The actual reason for introducing this patch (affects only AM654 and
> J721E) is due to Errata ID #i2101 GIC: ITS Misbehavior
> (https://www.ti.com/lit/er/sprz455a/sprz455a.pdf). So if more than 5
> devices use GIC ITS simultaneously, GIC fails to raise interrupts.
> 
> Though this patch is not an actual workaround for the issue (the
> workaround is in GIC ITS driver provided in the errata document), it
> helps to keep testing PCIe RC/EP using pci-endpoint-test even when
> multiple pci-epf-test endpoint devices are connected (Normal test-setup
> having J721E-J721E back to back connection can support 21 pci-epf-test
> devices). So this patch lets user to individually enable interrupts for
> each of the devices and could disable after the interrupt test.
> 
> Since pci_endpoint_test is used only for testing PCIE RC/EP
> communication and pci-endpoint-test has already implemented
> PCITEST_SET_IRQTYPE for the userspace to enable interrupt, tried to not
> enable the interrupts of all the devices by default in the probe (for
> AM654 and J721E where this errata applies).

I understand - what I am asking is:

is it possible, instead of applying this patch, to make

pci_endpoint_test_alloc_irq_vectors() and pci_endpoint_test_request_irq()

fail in the target platforms instead of preventing to call them ?

My worry is that you may end up with more corner cases in the future
and peppering code with is_() calls to work around them which does
not look right.

Thanks,
Lorenzo

> Thanks,
> Kishon
> 
> > 
> > Thanks,
> > Lorenzo
> > 
> >> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> >> index c7ee34013485..9740f2a0e7cd 100644
> >> --- a/drivers/misc/pci_endpoint_test.c
> >> +++ b/drivers/misc/pci_endpoint_test.c
> >> @@ -79,6 +79,9 @@
> >>  #define PCI_DEVICE_ID_RENESAS_R8A774C0		0x002d
> >>  #define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
> >>  
> >> +#define is_j721e_pci_dev(pdev)         \
> >> +		((pdev)->device == PCI_DEVICE_ID_TI_J721E)
> >> +
> >>  static DEFINE_IDA(pci_endpoint_test_ida);
> >>  
> >>  #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
> >> @@ -810,9 +813,11 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
> >>  
> >>  	pci_set_master(pdev);
> >>  
> >> -	if (!pci_endpoint_test_alloc_irq_vectors(test, irq_type)) {
> >> -		err = -EINVAL;
> >> -		goto err_disable_irq;
> >> +	if (!(is_am654_pci_dev(pdev) || is_j721e_pci_dev(pdev))) {
> >> +		if (!pci_endpoint_test_alloc_irq_vectors(test, irq_type)) {
> >> +			err = -EINVAL;
> >> +			goto err_disable_irq;
> >> +		}
> >>  	}
> >>  
> >>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> >> @@ -850,9 +855,11 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
> >>  		goto err_ida_remove;
> >>  	}
> >>  
> >> -	if (!pci_endpoint_test_request_irq(test)) {
> >> -		err = -EINVAL;
> >> -		goto err_kfree_test_name;
> >> +	if (!(is_am654_pci_dev(pdev) || is_j721e_pci_dev(pdev))) {
> >> +		if (!pci_endpoint_test_request_irq(test)) {
> >> +			err = -EINVAL;
> >> +			goto err_kfree_test_name;
> >> +		}
> >>  	}
> >>  
> >>  	misc_device = &test->miscdev;
> >> -- 
> >> 2.17.1
> >>
