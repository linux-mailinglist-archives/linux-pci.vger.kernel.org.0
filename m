Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4184A7E5276
	for <lists+linux-pci@lfdr.de>; Wed,  8 Nov 2023 10:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbjKHJN5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Nov 2023 04:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjKHJN5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2023 04:13:57 -0500
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE2410A;
        Wed,  8 Nov 2023 01:13:54 -0800 (PST)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 5FDED184639;
        Wed,  8 Nov 2023 10:13:51 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1699434831; bh=8YvlJP4iehF5VC4lYo9yr3Gk1KOKmHeLrYZG+pdLVxc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zQpYhRcZSsQhsdYt6OAMWjWj/1XvjsMN6ErRHy5DsAcVuH/fDLaBQHivbO9laMGOg
         2l85K13CiAFz0ifJan0FYClLvJ4MdyM3QMgKJvnIckZr7af1Y4dShgg3YbLsluuUBj
         VFggBmKgfCCmzHdzASRGg4uBDynoa3fATMSvLSKGZ5lj4DJMSanfaZBXvasKhuVOHr
         ak/inXItCQaK7proFvieb6/oI8qOZC9siRHqWp7czMu4J1L48W5mPM370dM84klnWh
         +r3Z65N2Uxq2ZPhi/7myR/u6xsbh0kA1YRgPRnelz9XmiTlnsgGQou1xggb6UFfPuZ
         gUiOfBkWe8ogg==
Date:   Wed, 8 Nov 2023 10:13:47 +0100
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Petr Tesarik <petr.tesarik1@huawei-partners.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Jianxiong Gao <jxgao@google.com>
Subject: Re: Memory corruption with CONFIG_SWIOTLB_DYNAMIC=y
Message-ID: <20231108101347.77cab795@meshulam.tesarici.cz>
In-Reply-To: <20231107182420.0bd8c211.pasic@linux.ibm.com>
References: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com>
        <20231103171447.02759771.pasic@linux.ibm.com>
        <20231103214831.26d29f4d@meshulam.tesarici.cz>
        <20231107182420.0bd8c211.pasic@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 7 Nov 2023 18:24:20 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Fri, 3 Nov 2023 21:50:53 +0100
> Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:
>=20
> > > In our opinion the first step towards getting this right is to figure=
 out what
> > > the different kinds of alignments are really supposed to mean. For ea=
ch of the
> > > mechanisms we need to understand and document, whether making sure th=
at the
> > > bounce buffer does not stretch over more of certain units of memory (=
like,
> > > pages, iova granule size, whatever), or is it about preserving offset=
 within a
> > > certain unit of memory, and if yes to what extent (the least signific=
ant n-bits
> > > of the orig_addr dictated by the respective mask, or something differ=
ent).   =20
> >=20
> >=20
> > Seconded. I have also been struggling with the various alignment
> > constraints. I have even written (but not yet submitted) a patch to
> > calculate the combined alignment mask in swiotlb_tbl_map_single() and
> > pass it down to all other functions, just to make it clear what
> > alignment mask is used. =20
>=20
> Can you cc me when posting that rework?

Absolutely. I mean, if it still makes sense after we clarify the
intended goals of the various alignment parameters. Because I believe
you have indeed found something!

> > My understanding is that buffer alignment may be required by:
> >=20
> > 1. hardware which cannot handle an unaligned base address (presumably
> >    because the chip performs a simple OR operation to get the addresses
> >    of individual fields); =20
>=20
> I'm not sure I understood this properly. What is "base address" in this
> context? Is for swiotlb "base address" basically the return value
> of swiotlb_tbl_map_single() -- I referred to this as tlb_addr previously?
>
> If yes, I understand that  satisfying 1 means satisfying=20
> tlb_addr & combined_mask =3D=3D 0, where combined_mask describes the
> combined alignment requirement (i.e. combined_mask =3D=3D min_align_mask |
> alloc_align_mask | (alloc_size < PAGE_SIZE ? 0 : (PAGE_SIZE-1)). Does
> that sound about right?
>=20
> Can we assume that if 1. then the start address of the mapping
> that is orig_addr needs to be already aligned?


No, not really. A very nice diagram can be found in commit 5f89468e2f06
("swiotlb: manipulate orig_addr when tlb_addr has offset"):

"""
  1. Get dma_addr_t from dma_map_single()

  dma_addr_t tlb_addr =3D dma_map_single(dev, vaddr, vsize, DMA_TO_DEVICE);

      |<---------------vsize------------->|
      +-----------------------------------+
      |                                   | original buffer
      +-----------------------------------+
    vaddr

   swiotlb_align_offset
       |<----->|<---------------vsize------------->|
       +-------+-----------------------------------+
       |       |                                   | swiotlb buffer
       +-------+-----------------------------------+
	    tlb_addr
"""

Here, the aligned address is outside the original buffer at
[vadddr; vaddr+vsize). This is what I referred to as "base
address". The N lowest bits of this address are zero. It may not
even be mapped in the SWIOTLB if N is greater than IO_TLB_SHIFT.
However, the exact values of the N lowest bits of the original
buffer's physical start address are preserved in tlb_addr.

> > 2. isolation of untrusted devices, where no two bounce buffers should
> >    end up in the same iova granule;
> >=20
> > 3. allocation size; I could not find an explanation, so this might be
> >    merely an attempt at reducing SWIOTLB internal fragmentation. =20
>=20
>=20
> Assumed I understood 1 correctly, I think we are missing something.
>=20
> 4. preserve the n (0 <=3D n <=3D 31) lowest bits of all addresses within =
the
> mapping.
>=20
> Was it just 1, 2 and 3 then we wouldn't need the whole offsetting
> business introduced by commit 1f221a0d0dbf ("swiotlb: respect
> min_align_mask"). Let me cite from its commit message:
>=20
> """
>     Respect the min_align_mask in struct device_dma_parameters in swiotlb.
>    =20
>     There are two parts to it:
>      1) for the lower bits of the alignment inside the io tlb slot, just
>         extent the size of the allocation and leave the start of the slot
>          empty
>      2) for the high bits ensure we find a slot that matches the high bits
>         of the alignment to avoid wasting too much memory
>    =20
>     Based on an earlier patch from Jianxiong Gao <jxgao@google.com>.
> """
>=20
> Do we agree, that 4. needs to be added to the list? Or was it supposed
> to be covered by 1.?

That's it. It's what case 1 is supposed to be. However, IIUC cases
2 and 3 don't need to preserve any lowest bits.

At least for case 3, I'm now quite confident that the intention
was to start big buffers on a page-aligned slot, leaving the gaps
for buffers smaller than a page.

Case 2 is not clear to me. Some comments suggest that it should
prevent exposing a single iova granule to multiple untrusted
devices. What the code really does now is prevent crossing an iova
granule boundary if the original buffer did not cross one. I'm not
sure whether it achieves the goal, because commit e81e99bacc9f
("swiotlb: Support aligned swiotlb buffers") also references
PAGE_SIZE, but AFAICS it should use the same logic as case 3
(page-aligned allocations).

To sum it up, there are two types of alignment:

1. specified by a device's min_align_mask; this says how many low
   bits of a buffer's physical address must be preserved,

2. specified by allocation size and/or the alignment parameter;
   this says how many low bits in the first IO TLB slot's physical
   address must be zero.

I hope somebody can confirm or correct this summary before I go
and break something. You know, it's not like cleanups in SWIOTLB
have never broken anything.  ;-)

Petr T
