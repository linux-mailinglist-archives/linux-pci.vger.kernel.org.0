Return-Path: <linux-pci+bounces-24157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ADEA69916
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 20:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5B701883949
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 19:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F2C20C49E;
	Wed, 19 Mar 2025 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgdBjC8q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7822F37;
	Wed, 19 Mar 2025 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412166; cv=none; b=hG8ibZUauC8aHKVN+J45Sbiny8lkLvScP9FcGH+KEw5gDujbsUWyV7FZlqQfZJTPP/6P0fNy3/W/gF7ZB2N+xRxPciZ1slUdI9h7in+j7X5HTSz2a3mkWRQcCH+ZN/TVx+xQfCWPUIN9ZgVBWw6eY66y4hUCISmQGUCEeUjFKw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412166; c=relaxed/simple;
	bh=hp6/NGk818hWA31F/faP/QydOEsvoVm19SW4JKDcbkc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UsDwoLwu4pA+Rv/A2aT8VlNGmx3Fo9UYSRtjhYyMEq6xlY546qP/FZ6fHkuTe65xQi1BmHZf/rFq+2ssdbHgT98yUAQUkR4+ITAg4vDNF1IaplQYfHVl+aC4OpZ0zbxpEgzT4G++/xJ+pci9JWLXrmh2VUOE//1HmRwZvVfuM20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgdBjC8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4A6C4CEE4;
	Wed, 19 Mar 2025 19:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742412166;
	bh=hp6/NGk818hWA31F/faP/QydOEsvoVm19SW4JKDcbkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IgdBjC8qWDxFiltEAF/YNbtupLSeKeLHghpusBQFXZGM9Mye3xChIyVJVK1rhITJu
	 0rzls2eQWbcH6gEpQ61fckMpj6/BEhPPDm4Oqb5bRLQ9AemAr1BS49tSBkl8vV90qe
	 0thCQ6LIfSCR/Loc2JKE9cqNCy+IYcxbIcm0uXO+/cvhWrYFB8L8r+8zSYZsGdcRcC
	 O6g+YRi8iDVQDSpCcIB8TPTwvYg+BnSdYJIrmikBZ7UDeHajaqFevev5DIhVqKObzO
	 kS/Vrw0YOVSkjEMO5HrA0z/DVGiZPjWEMD+LvufqXg+TIYfwcVEn3w2iIUoTXc1f0c
	 QV94fNKE3QMmQ==
Date: Wed, 19 Mar 2025 14:22:44 -0500
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
Message-ID: <20250319192244.GA1053712@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY3PR19MB5076ADD0AC135D455D10B5CEBDD92@BY3PR19MB5076.namprd19.prod.outlook.com>

On Wed, Mar 19, 2025 at 06:10:57AM +0000, Lei Chuan Hua wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Tuesday, 18 March 2025 11:32 pm
> > To: Lei Chuan Hua <lchuanhua@maxlinear.com>
> > Cc: Frank Li <Frank.Li@nxp.com>; Lorenzo Pieralisi
> > <lpieralisi@kernel.org>; Krzysztof Wilczyński <kw@linux.com>; Manivannan
> > Sadhasivam <manivannan.sadhasivam@linaro.org>; Rob Herring
> > <robh@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>; linux-
> > pci@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH RFC NOT TESTED] PCI: intel-gw: Use
> > use_parent_dt_ranges and clean up intel_pcie_cpu_addr_fixup()
> > 
> > This email was sent from outside of MaxLinear.
> > 
> > On Tue, Mar 18, 2025 at 01:49:46AM +0000, Lei Chuan Hua wrote:
> > > Hi Bjorn,
> > >
> > > I did a quick test with necessary change in dts. It worked, please
> > > move on.
> > 
> > What does this mean?  By "move on", do you mean that I should merge the
> > patch below (the removal of intel_pcie_cpu_addr())?
>
>   I mean you can merge the patch with removal of intel_pcie_cpu_addr()
> 
> > I do not want to merge a change that will break any existing intel-gw
> > platform.  When you say "with necessary change in dts", it makes me
> > think the removal of intel_pcie_cpu_addr() forces a change to dts, which
> > would not be acceptable.  We can't force users to upgrade the dts just
> > to run a newer kernel.
>
>   Actually, intel_pcie_cpu_addr() did the address translation, so in our case,
>   Dts has to adapt to this change.
>
> > I assume 250318 linux-next, which includes Frank's v12 series, should
> > work with no change to dts required.  (It would be awesome if you can
> > verify that.)
> 
>   I will try 250318 linux-next and let you know the result once it is done.
> 
> > If you apply this patch to remove intel_pcie_cpu_addr() on top of
> > 250318 linux-next, does it still work with no changes to dts?
>
>   I think we need to adapt dts change. Even this series patch has dts
>   adaption part.
> 
> > If you have to make a dts change for it to work after removing
> > intel_pcie_cpu_addr(), then we have a problem.
>
>   We can update the dts yaml file.
>
> > I do not see a .dts file in the upstream tree that contains "intel,lgm-
> > pcie", so I don't know what the .dts contains or how it is distributed.
> > 
> > I do see the binding at
> > Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml,
> > but the example there does not include anything about address
> > translation between the CPU and the PCI controller, so my guess is that
> > there are .dts files in the field that will not work if we remove
> > intel_pcie_cpu_addr().
>
>   This driver is for x86 atom platform, no upstream dts file even in
>   arch/x86/boot Since upstream x86 platforms use acpi, even several
>   platforms use dts, but never create dts directory in
>   arch/x86/boot.
> 
>   As I mentioned earlier, dts needs a minor change.

If there are end users that have a dts that must be changed before
intel_pcie_cpu_addr() can be removed, we can't remove it because we
can't force those users to upgrade their dts.

If this driver is only used internally to Intel, or if the hardware
has never been shipped to end users, it's OK to remove
intel_pcie_cpu_addr() and assume those internal users will update dts.

> > > ________________________________________
> > > From: Bjorn Helgaas <mailto:helgaas@kernel.org>
> > > Sent: Tuesday, March 18, 2025 1:59 AM
> > > To: Frank Li <mailto:Frank.Li@nxp.com>
> > > Cc: Lei Chuan Hua <mailto:lchuanhua@maxlinear.com>; Lorenzo Pieralisi
> > > <mailto:lpieralisi@kernel.org>; Krzysztof Wilczyński <mailto:kw@linux.com>;
> > > Manivannan Sadhasivam <mailto:manivannan.sadhasivam@linaro.org>; Rob Herring
> > > <mailto:robh@kernel.org>; Bjorn Helgaas <mailto:bhelgaas@google.com>;
> > > mailto:linux-pci@vger.kernel.org <mailto:linux-pci@vger.kernel.org>;
> > > mailto:linux-kernel@vger.kernel.org <mailto:linux-kernel@vger.kernel.org>
> > > Subject: Re: [PATCH RFC NOT TESTED] PCI: intel-gw: Use
> > > use_parent_dt_ranges and clean up intel_pcie_cpu_addr_fixup()
> > >
> > >
> > >
> > > On Wed, Mar 05, 2025 at 12:07:54PM -0500, Frank Li wrote:
> > > > Remove intel_pcie_cpu_addr_fixup() as the DT bus fabric should
> > > > provide correct address translation. Set use_parent_dt_ranges to
> > > > allow the DWC core driver to fetch address translation from the
> > device tree.
> > > >
> > > > Signed-off-by: Frank Li <mailto:Frank.Li@nxp.com>
> > >
> > > Any update on this, Chuanhua?
> > >
> > > I plan to merge v12 of Frank's series [1] for v6.15.  We need to know
> > > ASAP if that would break intel-gw.
> > >
> > > If we knew that it was safe to also apply this patch to remove
> > > intel_pcie_cpu_addr(), that would be even better.
> > >
> > > I will plan to apply the patch below on top of Frank's series [1] for
> > > v6.15 unless I hear that it would break something.
> > >
> > > Bjorn
> > >
> > > [1]
> > > https://nam12.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore
> > > .kernel.org%2Fr%2F20250315201548.858189-1-helgaas%40kernel.org&data=05
> > > %7C02%7Clchuanhua%40maxlinear.com%7C1612d73ded5741bbd37508dd66320100%7
> > > Cdac2800513e041b882807663835f2b1d%7C0%7C0%7C638779087153570342%7CUnkno
> > > wn%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXa
> > > W4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=aIuZWzwFy2r
> > > rzsJ5KfbxWKMx%2BPn1WHx2KvpSR0nxsl8%3D&reserved=0
> > >
> > > > ---
> > > > This patches basic on
> > > > https://nam12.safelinks.protection.outlook.com/?url=https%3A%2F%2Flo
> > > > re.kernel.org%2Fimx%2F20250128-pci_fixup_addr-v9-0-3c4bb506f665%40nx
> > > > p.com%2F&data=05%7C02%7Clchuanhua%40maxlinear.com%7C1612d73ded5741bb
> > > > d37508dd66320100%7Cdac2800513e041b882807663835f2b1d%7C0%7C0%7C638779
> > > > 087153596851%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiI
> > > > wLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C
> > > > %7C%7C&sdata=mht19VSB24Znpvtz1pOlmtHYec%2BDBDH70zuLOZmwlSI%3D&reserv
> > > > ed=0
> > > >
> > > > I have not hardware to test and there are not intel,lgm-pcie in
> > > > kernel tree.
> > > >
> > > > Your dts should correct reflect hardware behavor, ref:
> > > > https://nam12.safelinks.protection.outlook.com/?url=https%3A%2F%2Flo
> > > > re.kernel.org%2Flinux-pci%2FZ8huvkENIBxyPKJv%40axis.com%2FT%2F%23mb7
> > > > ae78c3a22324b37567d24ecc1c810c1b3f55c5&data=05%7C02%7Clchuanhua%40ma
> > > > xlinear.com%7C1612d73ded5741bbd37508dd66320100%7Cdac2800513e041b8828
> > > > 07663835f2b1d%7C0%7C0%7C638779087153612764%7CUnknown%7CTWFpbGZsb3d8e
> > > > yJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiT
> > > > WFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=DUsGCW%2FZpvx4whLteoIjYqw
> > > > d6oOk9rXks%2BV40i5sovI%3D&reserved=0
> > > >
> > > > According to your intel_pcie_cpu_addr_fixup()
> > > >
> > > > Basically, config space/io/mem space need minus SZ_256. parent bus
> > > > range convert it to original value.
> > > >
> > > > Look for driver owner, who help test this and start move forward to
> > > > remove
> > > > cpu_addr_fixup() work.
> > > > ---
> > > > Frank Li <mailto:Frank.Li@nxp.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-intel-gw.c | 8 +-------
> > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > > b/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > > index 9b53b8f6f268e..c21906eced618 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > > @@ -57,7 +57,6 @@
> > > >       PCIE_APP_IRN_INTA | PCIE_APP_IRN_INTB | \
> > > >       PCIE_APP_IRN_INTC | PCIE_APP_IRN_INTD)
> > > >
> > > > -#define BUS_IATU_OFFSET                      SZ_256M
> > > >  #define RESET_INTERVAL_MS            100
> > > >
> > > >  struct intel_pcie {
> > > > @@ -381,13 +380,7 @@ static int intel_pcie_rc_init(struct dw_pcie_rp
> > *pp)
> > > >       return intel_pcie_host_setup(pcie);  }
> > > >
> > > > -static u64 intel_pcie_cpu_addr(struct dw_pcie *pcie, u64 cpu_addr)
> > > > -{
> > > > -     return cpu_addr + BUS_IATU_OFFSET;
> > > > -}
> > > > -
> > > >  static const struct dw_pcie_ops intel_pcie_ops = {
> > > > -     .cpu_addr_fixup = intel_pcie_cpu_addr,
> > > >  };
> > > >
> > > >  static const struct dw_pcie_host_ops intel_pcie_dw_ops = { @@
> > > > -409,6 +402,7 @@ static int intel_pcie_probe(struct platform_device
> > *pdev)
> > > >       platform_set_drvdata(pdev, pcie);
> > > >       pci = &pcie->pci;
> > > >       pci->dev = dev;
> > > > +     pci->use_parent_dt_ranges = true;
> > > >       pp = &pci->pp;
> > > >
> > > >       ret = intel_pcie_get_resources(pdev);
> > > >
> > > > ---
> > > > base-commit: 1552be4855dacca5ea39b15b1ef0b96c91dbea0d
> > > > change-id: 20250305-intel-7c25bfb498b1
> > > >
> > > > Best regards,
> > > >

