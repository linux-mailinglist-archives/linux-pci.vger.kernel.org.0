Return-Path: <linux-pci+bounces-24053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76894A677EE
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 16:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F9207A9559
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 15:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67113211464;
	Tue, 18 Mar 2025 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qs+29R09"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9D820E6F6;
	Tue, 18 Mar 2025 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311910; cv=none; b=XUCsKIQY1CZAFa7JxU4v+fFiMiLCBBkAUeSvmfjupo7hLLFNe2TTeFLMJE2Q4iu3Y/nTtkhR0W9XnICE/Upgg2W5Bvd2PnEmHiiV51HetRof9b5TBkRgrV3i7ol/tUJa9i7osDatj3jj0GwP7fsLzuWQFM2dxXecGFDHexuXbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311910; c=relaxed/simple;
	bh=xfVP5X6JUhbI8KG9gpiy9o/m49qsXUbi7Lo3C+GZ7vY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ArdthW8tPrw0AADhvEfac1VVZVtanQgUwssxpv1/tE0GJ899lifqfCqOwScotL8RQmZ/+weqFPdpr/YOsPv7vd6ut/IrO+x0zibyaJwgooXAvhog6SgDegIoJLuszBuJK3RT8o7xEwz6IZWqmGDbMsj7TRCnqA0tYL+Ni/+BFr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qs+29R09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D57C4CEDD;
	Tue, 18 Mar 2025 15:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742311909;
	bh=xfVP5X6JUhbI8KG9gpiy9o/m49qsXUbi7Lo3C+GZ7vY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Qs+29R09M/HjOvbEO9IttVjrc2c7gUuI2msCv+/OQoRlHDeU037m8qOF2+baNjxjx
	 ckPCjPUDjqkT4EZAdSzhjb1OeFFedsNLEB9S64U+XnxuCBovC0Z7OkloLNjMUClMfp
	 TSb8WkMOF3ak7mjsSz5ybjEuUUTZBy9GCWYBeBIoqbnRv3HhdsF81JlXKfKisJevuP
	 03P/jP+g2o8GhXiq1wMl8+6WkeVC4tkkdTfXIRrPclVf93FiSUdgvz+hLYuZH/IVxP
	 sFuHGwYyqLYRQS+8xhKIgSq54DDAz77Q08p39dYJZjv1XHNI+jP3x7Fy/MEeCkFa7d
	 q8IpALC1sbbAA==
Date: Tue, 18 Mar 2025 10:31:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lei Chuan Hua <lchuanhua@maxlinear.com>
Cc: Frank Li <Frank.Li@nxp.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC NOT TESTED] PCI: intel-gw: Use use_parent_dt_ranges
 and clean up intel_pcie_cpu_addr_fixup()
Message-ID: <20250318153148.GA1000275@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY3PR19MB5076A8D664FAA83E7C168300BDDE2@BY3PR19MB5076.namprd19.prod.outlook.com>

On Tue, Mar 18, 2025 at 01:49:46AM +0000, Lei Chuan Hua wrote:
> Hi Bjorn,
> 
> I did a quick test with necessary change in dts. It worked, please move on.

What does this mean?  By "move on", do you mean that I should merge
the patch below (the removal of intel_pcie_cpu_addr())?

I do not want to merge a change that will break any existing intel-gw
platform.  When you say "with necessary change in dts", it makes me
think the removal of intel_pcie_cpu_addr() forces a change to dts,
which would not be acceptable.  We can't force users to upgrade the
dts just to run a newer kernel.

I assume 250318 linux-next, which includes Frank's v12 series, should
work with no change to dts required.  (It would be awesome if you can
verify that.)

If you apply this patch to remove intel_pcie_cpu_addr() on top of
250318 linux-next, does it still work with no changes to dts?

If you have to make a dts change for it to work after removing
intel_pcie_cpu_addr(), then we have a problem.

I do not see a .dts file in the upstream tree that contains
"intel,lgm-pcie", so I don't know what the .dts contains or how it is
distributed.

I do see the binding at
Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml,
but the example there does not include anything about address
translation between the CPU and the PCI controller, so my guess is
that there are .dts files in the field that will not work if we remove
intel_pcie_cpu_addr().

> ________________________________________
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, March 18, 2025 1:59 AM
> To: Frank Li <Frank.Li@nxp.com>
> Cc: Lei Chuan Hua <lchuanhua@maxlinear.com>; Lorenzo Pieralisi <lpieralisi@kernel.org>; Krzysztof Wilczyński <kw@linux.com>; Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>; Rob Herring <robh@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH RFC NOT TESTED] PCI: intel-gw: Use use_parent_dt_ranges and clean up intel_pcie_cpu_addr_fixup()
> 
> 
> 
> On Wed, Mar 05, 2025 at 12:07:54PM -0500, Frank Li wrote:
> > Remove intel_pcie_cpu_addr_fixup() as the DT bus fabric should provide correct
> > address translation. Set use_parent_dt_ranges to allow the DWC core driver to
> > fetch address translation from the device tree.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Any update on this, Chuanhua?
> 
> I plan to merge v12 of Frank's series [1] for v6.15.  We need to know
> ASAP if that would break intel-gw.
> 
> If we knew that it was safe to also apply this patch to remove
> intel_pcie_cpu_addr(), that would be even better.
> 
> I will plan to apply the patch below on top of Frank's series [1] for
> v6.15 unless I hear that it would break something.
> 
> Bjorn
> 
> [1] https://lore.kernel.org/r/20250315201548.858189-1-helgaas@kernel.org
> 
> > ---
> > This patches basic on
> > https://lore.kernel.org/imx/20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com/
> >
> > I have not hardware to test and there are not intel,lgm-pcie in kernel
> > tree.
> >
> > Your dts should correct reflect hardware behavor, ref:
> > https://lore.kernel.org/linux-pci/Z8huvkENIBxyPKJv@axis.com/T/#mb7ae78c3a22324b37567d24ecc1c810c1b3f55c5
> >
> > According to your intel_pcie_cpu_addr_fixup()
> >
> > Basically, config space/io/mem space need minus SZ_256. parent bus range
> > convert it to original value.
> >
> > Look for driver owner, who help test this and start move forward to remove
> > cpu_addr_fixup() work.
> > ---
> > Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-intel-gw.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
> > index 9b53b8f6f268e..c21906eced618 100644
> > --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> > +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> > @@ -57,7 +57,6 @@
> >       PCIE_APP_IRN_INTA | PCIE_APP_IRN_INTB | \
> >       PCIE_APP_IRN_INTC | PCIE_APP_IRN_INTD)
> >
> > -#define BUS_IATU_OFFSET                      SZ_256M
> >  #define RESET_INTERVAL_MS            100
> >
> >  struct intel_pcie {
> > @@ -381,13 +380,7 @@ static int intel_pcie_rc_init(struct dw_pcie_rp *pp)
> >       return intel_pcie_host_setup(pcie);
> >  }
> >
> > -static u64 intel_pcie_cpu_addr(struct dw_pcie *pcie, u64 cpu_addr)
> > -{
> > -     return cpu_addr + BUS_IATU_OFFSET;
> > -}
> > -
> >  static const struct dw_pcie_ops intel_pcie_ops = {
> > -     .cpu_addr_fixup = intel_pcie_cpu_addr,
> >  };
> >
> >  static const struct dw_pcie_host_ops intel_pcie_dw_ops = {
> > @@ -409,6 +402,7 @@ static int intel_pcie_probe(struct platform_device *pdev)
> >       platform_set_drvdata(pdev, pcie);
> >       pci = &pcie->pci;
> >       pci->dev = dev;
> > +     pci->use_parent_dt_ranges = true;
> >       pp = &pci->pp;
> >
> >       ret = intel_pcie_get_resources(pdev);
> >
> > ---
> > base-commit: 1552be4855dacca5ea39b15b1ef0b96c91dbea0d
> > change-id: 20250305-intel-7c25bfb498b1
> >
> > Best regards,
> >

