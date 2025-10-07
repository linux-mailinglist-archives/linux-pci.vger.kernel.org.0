Return-Path: <linux-pci+bounces-37692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 238C8BC2F4B
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 01:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B1CF34B15F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 23:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C340258EF3;
	Tue,  7 Oct 2025 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMIq3V9x"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC3034BA35
	for <linux-pci@vger.kernel.org>; Tue,  7 Oct 2025 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759879944; cv=none; b=EndoCotFUnPvt+irhWwEEMqSABqa/HiaxSanfc+bc99SB42HRWUI8tAzMA/XA7+1RdF817/aB+Ez878U/mUPyrDLofFDWM+5FWGZLm8IJopwHOd/bP+goyozniLIYNP6gIaslC49KPhOtsn92Lu5jvEmRtLId0astFMHjxdNPoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759879944; c=relaxed/simple;
	bh=bLQg2aOLe4NVfyI9GDwWK3IkQGghonCZb+jkOy5wtN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkOCppZh+EXuFnfp6cJjbhMiTnb+J7a9EXFLjLH4GesOGVS7Po7CRV2Ipkr+8hR8iRlJZ2s57mkAAvn+Jzw0lR+R2SmfEszspFf5aLqo3UJ51eIQ4onraeVVrNyyYVX4BkLHQHPN/aAn27kbBTt7PoRBgtwywDMiQ/Lf3stwnZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMIq3V9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A47C116D0
	for <linux-pci@vger.kernel.org>; Tue,  7 Oct 2025 23:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759879944;
	bh=bLQg2aOLe4NVfyI9GDwWK3IkQGghonCZb+jkOy5wtN8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QMIq3V9xMPAPAnRodoA5rD0kwJH5acy3F7RNlaI/pyvazed67N1qxHBRz9QDtyP57
	 Nv76zlMb9BLd1w93JxuLiwqN/vRsCUP3cn7J/msEScOzcSb0G8Hb8Zegyl1Km1fulE
	 gqqYzSimKUncyCyyFFRg30d/pJaTLKJr2rLdwWCwlI4Wingewy9nmNHllFQ995/jBZ
	 1nYMBTH35aQus+qiOiaO3iNnSwgpf1qZ8SH+nkKJvg68UEM8gPL7UyLCd1ctqrWH+q
	 EmvN69Br12+ZxsTLs0jOzcBvnCu+zQze1abwESF3twE+eiRqdPEQvE8d8+yKix+eCa
	 UKyQWvUeLYKhw==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d71bcac45so74912297b3.0
        for <linux-pci@vger.kernel.org>; Tue, 07 Oct 2025 16:32:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXakiTjKRlC6FoVkvYtjFW0Sh5tJvgrPCpzLeFYX/ZLMpLy/MLbh3/2iPqppcFjqlkkB6IyHZ2jFrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHC6xkM+LVaXwPAJ3lAJC9BdJnigMoM850wUZwDEaC/AE5OcFt
	9Glk/r7WqIOYs+Yu1Nm+HC4kgI8lNwKeYaWNrtskLYneDFK0HqfvnmHKDAiB0glqHT9q1Q10oHw
	86MzcScth3wR3njnyZVAUnY+H7A06tZLGBWePfFLkpw==
X-Google-Smtp-Source: AGHT+IF8Dg6uqR2RW1utm2WOx5D5ACNj4AR/alcGrKcg6aUAQ3ncvoBeR28wcJP7W/rj5XjZFGhFIuGm57r2c0sfe90=
X-Received: by 2002:a53:d607:0:b0:634:e9b2:eedc with SMTP id
 956f58d0204a3-63ccb8f1f80mr1223835d50.38.1759879943623; Tue, 07 Oct 2025
 16:32:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+CK2bAbB8YsheCwLi0ztY5LLWMyQ6He3sbYru697Ogq5+hR+Q@mail.gmail.com>
 <20250929150425.GA111624@bhelgaas> <CACePvbV+D6nu=gqjavv+hve4tcD+6WxQjC0O9TbNxLCeBhi5nQ@mail.gmail.com>
In-Reply-To: <CACePvbV+D6nu=gqjavv+hve4tcD+6WxQjC0O9TbNxLCeBhi5nQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 7 Oct 2025 16:32:12 -0700
X-Gmail-Original-Message-ID: <CACePvbUJ6mxgCNVy_0PdMP+-98D0Un8peRhsR45mbr9czfMkEA@mail.gmail.com>
X-Gm-Features: AS18NWDPalaS8O9DIQeC528cFS4jviFQWlDaGfaaeKicXkkFCNGwkwVkJLeplN4
Message-ID: <CACePvbUJ6mxgCNVy_0PdMP+-98D0Un8peRhsR45mbr9czfMkEA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] LUO: PCI subsystem (phase I)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks to one that provides good feedback on the PCI series.

I just want to give an update on the state of the LUO PCI series,
based on the feedback I received. The LUO PCI series should be called
from the memfd side and remove global subsystem state if possible.
Which means the PCI series will depend on the VIFO or iommu series.
I have some internal alignment with Vipin (for VFIO) and Samiullah
(for iommu). Here is the new plan for upstream patch submission:

1)  KHO series go first, which is already happening with additional improve=
ment.

2) Next is Pasha's LUO series with memfd support, also happening right now.

3) Next series will be Vipin's VFIO series with preserving one
busmaster bit in the config space of the end point vfio device, there
is no PCI layer involved yet. The VFIO will use some driver trick to
prevent the native driver from binding to the liveupdate device used
by VFIO after kexec. After kexec, the VFIO driver validates that the
busmaster in the PCI config register is already set.

4) After the VFIO series, the PCI can start to preserve the livedupate
device by BDF. Avoid the driver auto probe on the livedupate devices.
At this point the VFIO driver in stage 3 will not need the other
driver trick to avoid the auto bind of native driver. The PCI layer
takes the core of that. This series PCI will have very limited
support, most of the driver callback is not needed, no bridge device
dependent as well.

5) VFIO device will continue DMA across the kexec. This series will
require the IOMMU series for DMA mapping support. The PCI will hook up
with the VFIO and build the list of the liveupdate device, which
includes the PCI bridge with bus master big preserved as well.

So I will pause the LUO PCI series a bit to wait for the integration
with VFIO series.
Meanwhile, I will continue to fix up the LUO PCI series internally for
the other feedback I have received:
- Clean up device info printing, remove raw address value (Greg KH, Jason).
- Remove the device format string (Greg KH).
- Remove the liveupdate struct from struct device, move it to the PCI (Greg=
 KH).
- Remove LUO call back forwarding and hook it up with the VFIO (Jason, Davi=
d)
- Drive the PCI from memfd context on VFIO or iommu, no subsystem
registration. (Jason)
- up_read(&pci_bus_sem); instead of up_write (Greg KH)
- Avoid preserving the driver name, just avoid auto-probing the
liveupdate devices. Let user space do the driver loading in initrd
(Jason).

That will keep me busy for a while waiting for the VFIO series.

Thanks

Chris


On Mon, Sep 29, 2025 at 11:13=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote=
:
>
> On Mon, Sep 29, 2025 at 8:04=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org=
> wrote:
> >
> > On Sat, Sep 27, 2025 at 02:05:38PM -0400, Pasha Tatashin wrote:
> > > Hi Bjorn,
> > >
> > > My latest submission is the following:
> > > https://lore.kernel.org/all/20250807014442.3829950-1-pasha.tatashin@s=
oleen.com/
> > >
> > > And github repo is in cover letter:
> > >
> > > https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v3
> > >
> > > It applies cleanly against the mainline without the first three
> > > patches, as they were already merged.
> >
> > Not sure what I'm missing.  I've tried various things but none apply
> > cleanly:
>
> Sorry about that. Let me do a refresh of the LUOPCI V3 patch and send
> out the git repo link as well. The issue is that there are other
> patches not in the mainline kernel which luopci is dependent on. Using
> a git repo would be easier to get a working tree.
>
> Working on it now, please stay tuned.
>
> Chris

