Return-Path: <linux-pci+bounces-17305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDF39D90F7
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 05:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF422892B4
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 04:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89C013BAE3;
	Tue, 26 Nov 2024 04:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FsuDURRr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1295012CDA5
	for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 04:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732594498; cv=none; b=B4Rbb9X77iysQdnvy508SyZ72hROJbzSRiFySW8cWl0IeHUCXSsHibGucZ42cVoHWK3ZS+Ea4G9KUJNbGNEfr1C1jWggMAU+M54e3IJ3uXl7M505synSuCCgZQx3hWE2KjfZvBy1g+fBK7q7+NzbdAUqN9pPf1f1+MinQHHQNKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732594498; c=relaxed/simple;
	bh=IVJScJ5LLOG2ZZe5UUUCNU3AFBhVFaRuJQr7LpEuu7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPSnwlYZgzXSFbstaa2FEsjYJnBJCuFldFzPQ/8aU/m8SKh8irSWIGHkGRF6s6Lhl35cmXn36LfqHS9GIf/9RPCJXKGQQM6YxVuiFF6FyWxjh/Kpeu9tTHKS/0bRx9/FhS3Sqxh9YHtrhM8W8O/Ani9HHwgKfwp1EqpeJcTvCZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FsuDURRr; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7f4325168c8so2856364a12.1
        for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2024 20:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732594495; x=1733199295; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bjfYZcfFoIgejKOTai2BXSjSoln7dLiZ6K/mQw5KOGs=;
        b=FsuDURRr+YnhHWB2FhXBlUzWV93SK6L6tUCfsCyfhRSHKOsGZJBR2srP8t0CibHqKh
         OCeYuoTdW0MCs8j4nu/6RG8GD6z2qcbC4t5RKDlW/k3/mpStMFE0IIa1eQBUGuGIlaGE
         uE/d6bvEe5zhKF3mF3mYp6TIFSHnKcq2mRjOqq696gatuIWe/06IyzLJR7iS9HXfVYXd
         DkQlCnFa5eolW1KaH5w5Lxtpt6XXn4gDtkZNNdBLokhI4QBJsW6eVgnajsNTiC8AfYrh
         V3k2WOAyVXtuxzzCjQkxK3L3gkenHso2UGf8GPknUMfeflIZBW6FtYy9Kkip1lRqgult
         4ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732594495; x=1733199295;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bjfYZcfFoIgejKOTai2BXSjSoln7dLiZ6K/mQw5KOGs=;
        b=KY5FLiU8X5qKHk9mL7KwRFrr0aLSLFrOHVVWESC0Ml15RqIIRrbUdhcb6iKdhgzPzF
         EKgQ21aj52nylWEf3SUUTD5N7n+m/PnIBNcl/rmw6MYnHlxmBkzCd9jrHtYtvWk7qyMz
         xdwxfdHE/67hP6WScWgkSVoNZfOpzJLqNPsYxfxCeGS46g7Bdg3AKLQNwikPBTh2GlXR
         fEZkmxMINqXZCQtyNSq/AXErt0MwiSQjJ5GNh7TsxJeG1g3acnd0iNIa+yUs7+g+jNDi
         B6yLTzY5Fd0jRbu4aabwns+v18wVDAj/J7qapdXuUwBAFdHL0aG4WC2o3PGRw6pVVDMa
         QGrw==
X-Forwarded-Encrypted: i=1; AJvYcCVznGbpivadH0bMs0sCNBPbwU58/Pae2s6C5YXAD6oFPMtJ3JQmAKVyT6+blYk+sFJlNGFvmig55RA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvkXycdLO/r+KAWfCAiHpOGqYm583zYYH4yUPdhGU+qjUa06gZ
	mybqzxMjI6MkFXsEJ/kRi7cRhJYmb/82ZZKYuXL8EItqpJhMunvOuGrTLPMlDKTWq9r+21VN74w
	=
X-Gm-Gg: ASbGncsXC4YoOTvkCCjNj0j78aY41J6EnjJXWDJkryb2xXFo8eVDQqko3gppNgpCyl5
	kaZbgBqCVaUHaOG7AXgo+lKlJPfAm0TQr63rJmA2EMhQ4ncG6kFrzoE5okALOZQCqivJ3tHqSMe
	IDGcPzVIkbISp4cA9or1cLb6rsU4Nscw3FiDCNqxmGF+J/BBnxkgPLJ60ZK1pogA4Hxt4/VB1+T
	X+bKd0XoiqAJUMKRpgQEcCbeVZSdnxGYb3jq66Qj/vdxqpNdjxQG0jxjkW9rb0=
X-Google-Smtp-Source: AGHT+IGBN2N4F1GfDt8KuzITj8DNuTr31Dc8O0N+EbL438LAAPd1KGs/DWjPbgnEJWryxXsx8CfJ2A==
X-Received: by 2002:a05:6a20:7349:b0:1db:e870:7b19 with SMTP id adf61e73a8af0-1e09e3f9cf5mr23633557637.10.1732594495290;
        Mon, 25 Nov 2024 20:14:55 -0800 (PST)
Received: from thinkpad ([220.158.156.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724e8abf2e9sm6637791b3a.146.2024.11.25.20.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 20:14:54 -0800 (PST)
Date: Tue, 26 Nov 2024 09:44:49 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
	dlemoal@kernel.org, maz@kernel.org, tglx@linutronix.de,
	jdmason@kudzu.us
Subject: Re: [PATCH v8 2/6] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
Message-ID: <20241126041449.qouyatajd5rie5o2@thinkpad>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
 <20241116-ep-msi-v8-2-6f1f68ffd1bb@nxp.com>
 <20241124071100.ts34jbnosiipnx2x@thinkpad>
 <Z0S7+U5W2DOmzdJL@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0S7+U5W2DOmzdJL@lizhi-Precision-Tower-5810>

On Mon, Nov 25, 2024 at 01:03:37PM -0500, Frank Li wrote:
> On Sun, Nov 24, 2024 at 12:41:00PM +0530, Manivannan Sadhasivam wrote:
> > On Sat, Nov 16, 2024 at 09:40:42AM -0500, Frank Li wrote:
> > > Doorbell feature is implemented by mapping the EP's MSI interrupt
> > > controller message address to a dedicated BAR in the EPC core. It is the
> > > responsibility of the EPF driver to pass the actual message data to be
> > > written by the host to the doorbell BAR region through its own logic.
> > >
> > > Tested-by: Niklas Cassel <cassel@kernel.org>
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > change from v5 to v8
> > > -none
> > >
> > > Change from v4 to v5
> > > - Remove request_irq() in pci_epc_alloc_doorbell() and leave to EP function
> > > driver, so ep function driver can register differece call back function for
> > > difference doorbell events and set irq affinity to differece CPU core.
> > > - Improve error message when MSI allocate failure.
> > >
> > > Change from v3 to v4
> > > - msi change to use msi_get_virq() avoid use msi_for_each_desc().
> > > - add new struct for pci_epf_doorbell_msg to msi msg,virq and irq name.
> > > - move mutex lock to epc function
> > > - initialize variable at declear place.
> > > - passdown epf to epc*() function to simplify code.
> > > ---
> > >  drivers/pci/endpoint/Makefile     |  2 +-
> > >  drivers/pci/endpoint/pci-ep-msi.c | 99 +++++++++++++++++++++++++++++++++++++++
> > >  include/linux/pci-ep-msi.h        | 15 ++++++
> > >  include/linux/pci-epf.h           | 16 +++++++
> > >  4 files changed, 131 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
> > > index 95b2fe47e3b06..a1ccce440c2c5 100644
> > > --- a/drivers/pci/endpoint/Makefile
> > > +++ b/drivers/pci/endpoint/Makefile
> > > @@ -5,4 +5,4 @@
> > >
> > >  obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
> > >  obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
> > > -					   pci-epc-mem.o functions/
> > > +					   pci-epc-mem.o pci-ep-msi.o functions/
> > > diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> > > new file mode 100644
> > > index 0000000000000..7868a529dce37
> > > --- /dev/null
> > > +++ b/drivers/pci/endpoint/pci-ep-msi.c
> > > @@ -0,0 +1,99 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * PCI Endpoint *Controller* (EPC) MSI library
> > > + *
> > > + * Copyright (C) 2024 NXP
> > > + * Author: Frank Li <Frank.Li@nxp.com>
> > > + */
> > > +
> > > +#include <linux/cleanup.h>
> > > +#include <linux/device.h>
> > > +#include <linux/slab.h>
> >
> > Please sort alphabetically.
> >
> > > +#include <linux/module.h>
> > > +#include <linux/msi.h>
> > > +#include <linux/pci-epc.h>
> > > +#include <linux/pci-epf.h>
> > > +#include <linux/pci-ep-cfs.h>
> > > +#include <linux/pci-ep-msi.h>
> > > +
> > > +static bool pci_epc_match_parent(struct device *dev, void *param)
> > > +{
> > > +	return dev->parent == param;
> > > +}
> > > +
> > > +static void pci_epc_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> > > +{
> > > +	struct pci_epc *epc __free(pci_epc_put) = NULL;
> > > +	struct pci_epf *epf;
> > > +
> > > +	epc = pci_epc_get_fn(pci_epc_match_parent, desc->dev);
> >
> > You were passing 'epc->dev.parent' to platform_device_msi_init_and_alloc_irqs().
> > So 'desc->dev' should be the EPC parent, right? If so, you can do:
> >
> > 	epc = pci_epc_get(dev_name(msi_desc_to_dev(desc)));
> >
> > since we are reusing the parent dev name for EPC.
> 
> I think it is not good to depend on hidden situation, "name is the same."
> May it change in future because no one will realize here depend on the same
> name and just think it is trivial update for device name.
> 

No one should change the EPC name just like that. The name is exposed to
configfs interface and the existing userspace scripts rely on that. So changing
the name will break them.

I'd strongly suggest you to use the existing API instead of adding a new one for
the same purpose.

> >
> > > +	if (!epc)
> > > +		return;
> > > +
> > > +	/* Only support one EPF for doorbell */
> > > +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> >
> > Why don't you impose this restriction in pci_epf_alloc_doorbell() itself?
> 
> This is callback from platform_device_msi_init_and_alloc_irqs(). So it is
> actually restriction at pci_epf_alloc_doorbell().
> 

I don't know how to parse this last sentence. But my question was why don't you
impose this one EPF restriction in pci_epf_alloc_doorbell() before allocating
the MSI domain using platform_device_msi_init_and_alloc_irqs()? This way if
someone calls pci_epf_alloc_doorbell() multi EPF, it will fail.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

