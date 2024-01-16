Return-Path: <linux-pci+bounces-2229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0161782FC71
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 23:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFC11B26A94
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 22:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2FA1F5F3;
	Tue, 16 Jan 2024 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ku5hiOO1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EB925108
	for <linux-pci@vger.kernel.org>; Tue, 16 Jan 2024 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705438096; cv=none; b=ZrVJTD3rsT3M8cSKYdyc2zkimGmZiUnRQclnbD9CcuEHxhsexcMbrkozoBxXZmj7bD1Dih0YQbF6kUpkF9pifRfEwyOX8JlMTtqwj0UCrOOGNsaTYYMAoaWkU+qjXxeu8U1OD6hpjHcZE8kRVs7sAvyv4aUqGgTai2gkngllrX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705438096; c=relaxed/simple;
	bh=7benuWqupBCboa3ph34seVZToF2dtPkArPnJE5bf6Ys=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=D2MRrnmyTVs2/+PkXST9ylz1vfmyYS1wMI85QuVuyfKYozFgNFPFiM4Gc1iU32jWyNhsFhRl10SbEj36dbIAvfLD25fNdOCg88b4I9jmES5Wb55tdQ3IZqr7EZljeEqiMckWb+gtxJ0+S4nQzGu4aJQKYfK+qBmWQYSW+PFEoEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ku5hiOO1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2eb5c4dad6so11203066b.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Jan 2024 12:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705438092; x=1706042892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=by8AuvFz6BVmUoJyIFJ8qbDCQBnbPcx5ySE/x2/ZhdY=;
        b=ku5hiOO1hjUe6Ivi1E0O3zS2s6VDbYjdNTa47fUYJf9bOrBUGsK3B472D5v+NGOcun
         v6xzoWlt91Auxwb+APuZsf8ET51mclBQIMIr+q5ZqnMpYKKZ7llLxXlC3FsrXdQboG5E
         FcgS6EQGVFyV9zqtuHvS+f4pNzkEvcD+i9nDtEvs1fA3Hqk8t3Ha9vcRR8eCjCQk49Yu
         G3eLGP0WLC2BhMDtJFIM+PMW0Q+j7MnwMR+bdw2Fro1OyUZv5gqMv4/5AfTjYMy1Ytv9
         JIbRPOLkB/VrnSLBaJ0g16wypFrEFQ3/C3KFgSBDFWOswWm4yeHpQiEWo10RzwqPT6TB
         +thQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705438092; x=1706042892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=by8AuvFz6BVmUoJyIFJ8qbDCQBnbPcx5ySE/x2/ZhdY=;
        b=kjSgJllkEf3SPTJx1IwCu0Epfo2nJzFca7a/kNLRY0/CAWItd3dpVE+lTbrjBuPfeK
         X7syy9TIZAf+F3cXFUYRcbC+trtizcwVXODxk9FGtdmXPLOUfxdCzmlK8Zb1j3qdAcBL
         uVSmh8cfrrHYKksmczwbp6F35iYBzVcH4CTW8ZDYMrsLNPOCAK5xrt6GTl5fdkLqY3O8
         Jblvj1N1yBUgISb5qBNRoLbMRW//5lTfcntEFwphx9Hrz0/nIGEqycgIscqnv0dwkQYy
         jBZXAmrNUbKWLbicD+EfV5Np7QL+1he2gkzXNayYhJ+caQpXK5RgEzTSLU2wv498apvh
         s7Bw==
X-Gm-Message-State: AOJu0YyhRUOSJ8pADGNWJoS23GsjPvbxyDGb07VfCRMWbZ2kf27aRY7m
	ULCSwSYg4ivbDKIrSe+DRj9b5qqo8TquCiMpIuEJu20ErhWp
X-Google-Smtp-Source: AGHT+IHhF4aJBCvB+f97agpYExwZXAz4YF1txAVKN46u17jFJpY6rLG4ICQQGbgxc5wyk8kQ+EgWT3MmH7RxrdCXaiE=
X-Received: by 2002:a17:907:d041:b0:a2d:4d2:d38b with SMTP id
 vb1-20020a170907d04100b00a2d04d2d38bmr3509922ejc.66.1705438092360; Tue, 16
 Jan 2024 12:48:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111042103.392939-1-ajayagarwal@google.com> <b1ef4ad8-99c4-46ba-90fd-d57bd17163b9@arm.com>
In-Reply-To: <b1ef4ad8-99c4-46ba-90fd-d57bd17163b9@arm.com>
From: Sajid Dalvi <sdalvi@google.com>
Date: Tue, 16 Jan 2024 14:47:58 -0600
Message-ID: <CAEbtx1=9rTaJ5xafhUEf9ugL-Lk9qbKUY=aV_=19g9No0Zizvg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: dwc: Strengthen the MSI address allocation logic
To: Robin Murphy <robin.murphy@arm.com>
Cc: Ajay Agarwal <ajayagarwal@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Manu Gautam <manugautam@google.com>, William McVicker <willmcvicker@google.com>, 
	Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 7:30=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2024-01-11 4:21 am, Ajay Agarwal wrote:
> > There can be platforms that do not use/have 32-bit DMA addresses
> > but want to enumerate endpoints which support only 32-bit MSI
> > address. The current implementation of 32-bit IOVA allocation can
> > fail for such platforms, eventually leading to the probe failure.
> >
> > If there is a memory region reserved for the pci->dev, pick up
> > the MSI data from this region. This can be used by the platforms
> > described above.
> >
> > Else, if the memory region is not reserved, try to allocate a
> > 32-bit IOVA. Additionally, if this allocation also fails, attempt
> > a 64-bit allocation for probe to be successful. If the 64-bit MSI
> > address is allocated, then the EPs supporting 32-bit MSI address
> > will not work.
> >
> > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > ---
> > Changelog since v1:
> >   - Use reserved memory, if it exists, to setup the MSI data
> >   - Fallback to 64-bit IOVA allocation if 32-bit allocation fails
> >
> >   .../pci/controller/dwc/pcie-designware-host.c | 50 ++++++++++++++----=
-
> >   drivers/pci/controller/dwc/pcie-designware.h  |  1 +
> >   2 files changed, 39 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/driver=
s/pci/controller/dwc/pcie-designware-host.c
> > index 7991f0e179b2..8c7c77b49ca8 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -331,6 +331,8 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp =
*pp)
> >       u64 *msi_vaddr;
> >       int ret;
> >       u32 ctrl, num_ctrls;
> > +     struct device_node *np;
> > +     struct resource r;
> >
> >       for (ctrl =3D 0; ctrl < MAX_MSI_CTRLS; ctrl++)
> >               pp->irq_mask[ctrl] =3D ~0;
> > @@ -374,20 +376,44 @@ static int dw_pcie_msi_host_init(struct dw_pcie_r=
p *pp)
> >        * order not to miss MSI TLPs from those devices the MSI target
> >        * address has to be within the lowest 4GB.
> >        *
> > -      * Note until there is a better alternative found the reservation=
 is
> > -      * done by allocating from the artificially limited DMA-coherent
> > -      * memory.
> > +      * Check if there is memory region reserved for this device. If y=
es,
> > +      * pick up the msi_data from this region. This will be helpful fo=
r
> > +      * platforms that do not use/have 32-bit DMA addresses but want t=
o use
> > +      * endpoints which support only 32-bit MSI address.
> > +      * Else, if the memory region is not reserved, try to allocate a =
32-bit
> > +      * IOVA. Additionally, if this allocation also fails, attempt a 6=
4-bit
> > +      * allocation. If the 64-bit MSI address is allocated, then the E=
Ps
> > +      * supporting 32-bit MSI address will not work.
> >        */
> > -     ret =3D dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> > -     if (ret)
> > -             dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices =
with only 32-bit MSI support may not work properly\n");
> > +     np =3D of_parse_phandle(dev->of_node, "memory-region", 0);
> > +     if (np) {
> > +             ret =3D of_address_to_resource(np, 0, &r);
>
> This is incorrect in several ways - reserved-memory nodes represent
> actual system memory, so can't be used to reserve arbitrary PCI memory
> space (which may be different if DMA offsets are involved); the whole
> purpose of going through the DMA API is to ensure we get a unique *bus*
> address. Obviously we don't want to reserve actual memory for something
> that functionally doesn't need it, but conversely having a
> reserved-memory region for an address which isn't memory would be
> nonsensical. And even if this *were* a viable approach, you haven't
> updated the DWC binding to allow it, nor defined a reserved-memory
> binding for the node itself.
>
> If it was reasonable to put something in DT at all, then the logical
> thing would be a property expressing an MSI address directly on the
> controller node itself, but even that would be dictating software policy
> rather than describing an aspect of the platform itself. Plus this is
> far from the only driver with this concern, so it wouldn't make much
> sense to hack just one binding without all the others as well. The rest
> of the DT already describes everything an OS needs to know in order to
> decide an MSI address to use, it's just a matter of making this
> particular OS do a better job of putting it all together.
>
> Thanks,
> Robin.
>
> > +             if (ret) {
> > +                     dev_err(dev, "No memory address assigned to the r=
egion\n");
> > +                     return ret;
> > +             }
> >
> > -     msi_vaddr =3D dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data=
,
> > -                                     GFP_KERNEL);
> > -     if (!msi_vaddr) {
> > -             dev_err(dev, "Failed to alloc and map MSI data\n");
> > -             dw_pcie_free_msi(pp);
> > -             return -ENOMEM;
> > +             pp->msi_data =3D r.start;
> > +     } else {
> > +             dev_dbg(dev, "No %s specified\n", "memory-region");
> > +             ret =3D dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> > +             if (ret)
> > +                     dev_warn(dev, "Failed to set DMA mask to 32-bit. =
Devices with only 32-bit MSI support may not work properly\n");
> > +
> > +             msi_vaddr =3D dmam_alloc_coherent(dev, sizeof(u64), &pp->=
msi_data,
> > +                                             GFP_KERNEL);
> > +             if (!msi_vaddr) {
> > +                     dev_warn(dev, "Failed to alloc 32-bit MSI data. A=
ttempting 64-bit now\n");
> > +                     dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
> > +                     msi_vaddr =3D dmam_alloc_coherent(dev, sizeof(u64=
), &pp->msi_data,
> > +                                                     GFP_KERNEL);
> > +             }
> > +
> > +             if (!msi_vaddr) {
> > +                     dev_err(dev, "Failed to alloc and map MSI data\n"=
);
> > +                     dw_pcie_free_msi(pp);
> > +                     return -ENOMEM;
> > +             }
> >       }
> >
> >       return 0;
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci=
/controller/dwc/pcie-designware.h
> > index 55ff76e3d384..c85cf4d56e98 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -317,6 +317,7 @@ struct dw_pcie_rp {
> >       phys_addr_t             io_bus_addr;
> >       u32                     io_size;
> >       int                     irq;
> > +     u8                      coherent_dma_bits;
> >       const struct dw_pcie_host_ops *ops;
> >       int                     msi_irq[MAX_MSI_CTRLS];
> >       struct irq_domain       *irq_domain;


Robin,
Needed some clarification.
It seems you are implying that the pcie device tree node should define a
property for the MSI address within the PCIe address space.
However, you also state that this would not be an ideal solution, and
would prefer using existing device tree constructs.
I am not sure what you mean by, " The rest of the DT already describes
everything."
Do you mean adding an "msi" reg to reg-names and defining the address
in the reg list?

Thanks,
Sajid

