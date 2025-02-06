Return-Path: <linux-pci+bounces-20784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9377EA29F4F
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 04:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A613A72C3
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 03:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F24A70838;
	Thu,  6 Feb 2025 03:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Cte1lhGq"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688E2BA33;
	Thu,  6 Feb 2025 03:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738811945; cv=none; b=Gt8FrrmVnDVmLLD5/V1p2wsJoHR6Lwf9GedA0F/fKtpqjwHSSX2kEgGCPbpce5V0H/KxUs8bOx9cMTv33M8+XEVJNdvXSJ/QrEgTDlQZlZZ1FDAsu9lU9/HB3sIoVbOzERN/4rI7kCwK1XSOz9tb9TqHS1TRWM2A3yPkdeQk3uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738811945; c=relaxed/simple;
	bh=c9ou0wKHJc8RJ4SXUeYgRc+fmx1V/8+eRPumSgOuT7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgi1Zl3GxcOJREq6EX3vNsbQ1inYTusffpTe/Wl3iUWmuovGmVMazfZFsxB1sijShym85x6A4GSYsfp8ep5hoeqeKX2das2YIL3qbShxfo+IK0H1UG73OKHYKamZ5CM1xNgyu/DYx0kUYLGGEYiKPoc6h9K8US7DsKHA7wl0zOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Cte1lhGq; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738811930; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=YZ5n1XJ9+2OBem80bOrpZoJZQ6iinxivAYHPRnPkHK4=;
	b=Cte1lhGqCbMwPKiY5oCpIdhZjHQ4Cc5k/Yvc7badM0eNlrroXSW6i8OZYj3DjNakFYg4pTB5FsE4OKDlQSlJwfeMOCwkjPYR3xToSQpmdw4mRe1h3uHEbzW6/wRq9/2H0Md1M+ZxmF1XYZ9OoXU9oKoBH4PfI9Zii69UNT01so0=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WOuPi4K_1738811930 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Feb 2025 11:18:50 +0800
Date: Thu, 6 Feb 2025 11:18:49 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/portdrv: Add necessary delay for disabling
 hotplug events
Message-ID: <Z6QqGRNQ0UQZSKBB@U-2FWC9VHC-2323.local>
References: <20250204053758.6025-1-feng.tang@linux.alibaba.com>
 <7e5e9bad-b66b-4a7f-8868-af5f1ab2fda1@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e5e9bad-b66b-4a7f-8868-af5f1ab2fda1@linux.intel.com>

Hi Sathyanarayanan,

On Wed, Feb 05, 2025 at 10:26:59AM -0800, Sathyanarayanan Kuppuswamy wrote:
> 
> On 2/3/25 9:37 PM, Feng Tang wrote:
> > According to PCIe 6.1 spec, section 6.7.3.2, software need to wait at
> > least 1 second for the command-complete event, before resending the cmd
> > or sending a new cmd.
> > 
> > Currently get_port_device_capability() sends slot control cmd to disable
> > PCIe hotplug interrupts without waiting for its completion and there was
> > real problem reported for the lack of waiting.
> 
> Can you include the error log associated with this issue? What is the
> actual issue you are seeing and in which hardware?

For this one, we don't have specific log, as it was raised by firmware
developer, as in https://lore.kernel.org/lkml/Z6LRAozZm1UfgjqT@U-2FWC9VHC-2323.local/

When handling PCI hotplug problem, they hit issue and found their state
machine corrupted , and back traced to OS. They didn't expect to receive
2 link control commands at almost the same time, which doesn't comply to
pcie spec, and normally the handling of one command will take some time
in BIOS, though not as long as 1 second. The HW is an ARM server.

I will try to add these info to commit log in next version.

> 
> > 
> > Add the necessary wait to comply with PCIe spec. The waiting logic refers
> > existing pcie_poll_cmd().
> > 
> > Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> > ---
> >   drivers/pci/pci.h          |  2 ++
> >   drivers/pci/pcie/portdrv.c | 33 +++++++++++++++++++++++++++++++--
> >   2 files changed, 33 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 01e51db8d285..c1e234d1b81d 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -759,12 +759,14 @@ static inline void pcie_ecrc_get_policy(char *str) { }
> >   #ifdef CONFIG_PCIEPORTBUS
> >   void pcie_reset_lbms_count(struct pci_dev *port);
> >   int pcie_lbms_count(struct pci_dev *port, unsigned long *val);
> > +void pcie_disable_hp_interrupts_early(struct pci_dev *dev);
> >   #else
> >   static inline void pcie_reset_lbms_count(struct pci_dev *port) {}
> >   static inline int pcie_lbms_count(struct pci_dev *port, unsigned long *val)
> >   {
> >   	return -EOPNOTSUPP;
> >   }
> > +static inline void pcie_disable_hp_interrupts_early(struct pci_dev *dev) {}
> >   #endif
> >   struct pci_dev_reset_methods {
> > diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> > index 02e73099bad0..16010973bfe2 100644
> > --- a/drivers/pci/pcie/portdrv.c
> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -18,6 +18,7 @@
> >   #include <linux/string.h>
> >   #include <linux/slab.h>
> >   #include <linux/aer.h>
> > +#include <linux/delay.h>
> >   #include "../pci.h"
> >   #include "portdrv.h"
> > @@ -205,6 +206,35 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
> >   	return 0;
> >   }
> > +static int pcie_wait_sltctl_cmd_raw(struct pci_dev *pdev)
> > +{
> > +	u16 slot_status;
> > +	/* 1000 ms, according toPCIe spec 6.1, section 6.7.3.2 */
> > +	int timeout = 1000;
> > +
> > +	do {
> > +		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> > +		if (slot_status & PCI_EXP_SLTSTA_CC) {
> > +			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
> > +						   PCI_EXP_SLTSTA_CC);
> > +			return 0;
> > +		}
> > +		msleep(10);
> > +		timeout -= 10;
> > +	} while (timeout);
> > +
> > +	/* Timeout */
> > +	return  -1;
> > +}
> 
> May be this logic can be simplified using readl_poll_timeout()?

Seems this is what exactly I needed :) Many thanks for the suggestion!

- Feng

