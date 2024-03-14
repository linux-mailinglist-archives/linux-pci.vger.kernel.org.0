Return-Path: <linux-pci+bounces-4800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A953B87B68A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 03:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6204628754C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 02:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D28138A;
	Thu, 14 Mar 2024 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0HeexND"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4338F55;
	Thu, 14 Mar 2024 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710384693; cv=none; b=mZgIgRfbrpSYACbXJjuSn0VY+QMZPVw5zZXrXGigVGBqOaRDLg2YjtQznf379y6rmYxtaK29dvbj/OQNgRE38R4NWEL/pVmARVIKe3So/6ozBigKJFVvaisX2MdHuPvf4l2PKPZCJ2ahxMRR629lxXJefc+fpLAYL+xQqVdMyHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710384693; c=relaxed/simple;
	bh=4odLktmp/nCGkS6wqpUh5pVSGO+4MNahhOcH2uJT5hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RR9tQTJ09MBLR+yEjk8JcUg9Aj4V1/MEg46w44ZBhWsy1/Am70paGx8rDOFK8rwtEgUEC5WFB25ob0N3es723v9KTlRBJE30vBVhff19cHrp/e3uxYvJV1IKS7ROo9KlDIaJZlWIYA9nA1wpZCvgCLBC0eNGO6/x0rx/fLJekpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0HeexND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD98CC433F1;
	Thu, 14 Mar 2024 02:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710384693;
	bh=4odLktmp/nCGkS6wqpUh5pVSGO+4MNahhOcH2uJT5hM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A0HeexNDAgwbgoYMvpeTm+qMmCVWRL6Oe61CkNkbuyctGpXmd0P3bUZ4cy/0AEeZk
	 Q2OWaDxG32trUQETBlNaPyXZmMapYFIwuJ3zbEUMk9lUTT39J3j0a93GSp4eM1np2A
	 Y5vm+ElQFFqQSX7VLJ8Mhe5a/3dBAFf49UgZdMqwJTm6DOPCGNe8Wany3HfIEQMURy
	 reDE7HNN5TjKJdy01Izl182GcmEWNc0BCR6LtFwjpcqWkQM4eyTh2YXw5lajNP+Kdl
	 EQsFJWIJOObZo75cpLdgZb9rOR5sY1ZeQhytJXLDjssOF0TVtEmYhQy+d3mOiHZUQS
	 BMvwbGqMwmgCQ==
Date: Wed, 13 Mar 2024 20:51:29 -0600
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
Message-ID: <ZfJmMcs2UThVSC4v@kbusch-mbp>
References: <ZeCd+xqE6x2ZFtJN@lpieralisi>
 <mhng-87e7ef5a-d60b-4057-960d-41bc901b6c7f@palmer-ri-x1c9>
 <ZedAn8IC+Mpm4Sqz@lpieralisi>
 <ZQ0PR01MB0981BC562E837B232B419AC28229A@ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQ0PR01MB0981BC562E837B232B419AC28229A@ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn>

On Thu, Mar 14, 2024 at 02:18:38AM +0000, Kevin Xie wrote:
> > Re: [PATCH v15,RESEND 22/23] PCI: starfive: Offload the NVMe timeout
> > workaround to host drivers.
> > 
> > On Mon, Mar 04, 2024 at 10:08:06AM -0800, Palmer Dabbelt wrote:
> > > On Thu, 29 Feb 2024 07:08:43 PST (-0800), lpieralisi@kernel.org wrote:
> > > > On Tue, Feb 27, 2024 at 06:35:21PM +0800, Minda Chen wrote:
> > > > > From: Kevin Xie <kevin.xie@starfivetech.com>
> > > > >
> > > > > As the Starfive JH7110 hardware can't keep two inbound post write
> > > > > in order all the time, such as MSI messages and NVMe completions.
> > > > > If the NVMe completion update later than the MSI, an NVMe IRQ handle
> > will miss.
> > > >
> > > > Please explain what the problem is and what "NVMe completions" means
> > > > given that you are talking about posted writes.
> 
> Sorry, we made a casual conclusion here.
> Not any two of inbound post requests can`t be kept in order in JH7110 SoC, 
> the only one case we found is NVMe completions with MSI interrupts.
> To be more precise, they are the pending status in nvme_completion struct and
> nvme_irq handler in nvme/host/pci.c.
> 
> We have shown the original workaround patch before:
> https://lore.kernel.org/lkml/CAJM55Z9HtBSyCq7rDEDFdw644pOWCKJfPqhmi3SD1x6p3g2SLQ@mail.gmail.com/
> We put it in our github branch and works fine for a long time.
> Looking forward to better advices from someone familiar with NVMe drivers.

So this platform treats strictly ordered writes the same as if relaxed
ordering was enabled? I am not sure if we could reasonably work around
such behavior. An arbitrary delay is likely too long for most cases, and
too short for the worst case.

I suppose we could quirk a non-posted transaction in the interrupt
handler to force flush pending memory updates, but that will noticeably
harm your nvme performance. Maybe if you constrain such behavior to the
spurious IRQ_NONE condition, then it might be okay? I don't know.

