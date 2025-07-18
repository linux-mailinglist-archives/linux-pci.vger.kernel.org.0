Return-Path: <linux-pci+bounces-32539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C65B0A873
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 18:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C05E5A310C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 16:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D2B2E62B9;
	Fri, 18 Jul 2025 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtjXb2xF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC861DE4EC;
	Fri, 18 Jul 2025 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856313; cv=none; b=JM8Qi7pInIuGvN00JHPLiXvyP2AhYS84IBnZfOSmKyaHiQVtBXim+orJuP+00ACYDl2beQfDmeHIjBm4QYEQPmvEQgSYHb83a6HkZz22hFuUS3LTVKWO3EeVz0J8xhQ36XIUBal1Dov+2SuWW3wCMtCuK/+WKvTbOfjC3tH9LKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856313; c=relaxed/simple;
	bh=PD4pP9ILVb/fcBlFNyRadGIvO6v48LllMGgTKHNZLRU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Pcfe+ioKRh5iYwe0+mdBcmaMoOtAQkronWYkzgVKQGYPTTSBqR11C5RlEy/8GKxm6Et9JdJUQZwZOaFD7c2NowCcOlicb1Md6x9lSli22csiFgrIP0ZfF9IYn0xuqcZ/AB39FFH1aQjeLveuYDbs9ruJgNpuAgWW/2UH2Tbph6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtjXb2xF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EF6C4CEEB;
	Fri, 18 Jul 2025 16:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752856312;
	bh=PD4pP9ILVb/fcBlFNyRadGIvO6v48LllMGgTKHNZLRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LtjXb2xFfBadxtooK9HyOD9OigkmJPVLI2gkEvDTSMdzL7uQzrnAvoJLYu+yl94rG
	 NI4qzrBHXZDoEtWd6xCRHXFCo7UKZqLxdDJKYYi+Vc3PwUd3mQZ2Ut8axfQ+4n+eZf
	 VBclaue12YkdtHObikJU6HuWeaqeNFPTjTuvqIn5eS6qF+vBDyxXTyfHElEenE/LNh
	 E7LwtMucX2gWjBdIMZVViOhqYmy/D7I8+PDkcFgsRqnLP7MMHRzJenPDt5eteV7cRW
	 0j8iZXCMVlcwhga9hSXlXQYUXA5En4dYGgPWbkwczf7lWSBJ4Wcr2ruRe2tHIVJZT7
	 RgVT2Kb6HxRBA==
Date: Fri, 18 Jul 2025 11:31:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
	"Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
Subject: Re: [PATCH v5 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
 signal handling
Message-ID: <20250718163150.GA2700763@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB6158DFAD4351A17E3523CA58CD50A@DM4PR12MB6158.namprd12.prod.outlook.com>

On Fri, Jul 18, 2025 at 04:30:32AM +0000, Musham, Sai Krishna wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Bjorn,
> 
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Saturday, July 12, 2025 4:49 AM
> > To: Musham, Sai Krishna <sai.krishna.musham@amd.com>
> > Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com; mani@kernel.org;
> > robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org; cassel@kernel.org;
> > linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>; Gogada, Bharat
> > Kumar <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
> > <thippeswamy.havalige@amd.com>
> > Subject: Re: [PATCH v5 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
> > signal handling
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > On Fri, Jul 11, 2025 at 10:53:57AM +0530, Sai Krishna Musham wrote:
> > > Add support for handling the AMD Versal Gen 2 MDB PCIe Root Port PERST#
> > > signal via a GPIO by parsing the new PCIe bridge node to acquire the
> > > reset GPIO. If the bridge node is not found, fall back to acquiring it
> > > from the PCIe node.
> > >
> > > As part of this, update the interrupt controller node parsing to use
> > > of_get_child_by_name() instead of of_get_next_child(), since the PCIe
> > > node now has multiple children. This ensures the correct node is
> > > selected during initialization.

> > > +      * If amd_mdb_parse_pcie_port returns -ENODEV, it indicates that the
> > > +      * PCIe Bridge node was not found in the device tree. This is not
> > > +      * considered a fatal error and will trigger a fallback where the
> > > +      * reset GPIO is acquired directly from the PCIe node.
> > > +      */
> > > +     if (ret && ret != -ENODEV) {
> > > +             return ret;
> > > +     } else if (ret == -ENODEV) {
> >
> > The "ret" checking seems unnecessarily complicated.
> >
> > > +             dev_info(dev, "Falling back to acquire reset GPIO from PCIe node\n");
> >
> > I don't think this is worthy of a message.  If there are DTs in the
> > field that were valid once, they continue to be valid forever, and
> > there's no point in complaining about them.
> >
> > https://lore.kernel.org/all/20250702-perst-v5-2-920b3d1f6ee1@qti.qualcomm.com/
> > has a good example of how to this fallback nicely.
> >
> > Otherwise looks good to me.
> 
> Thanks for the feedback. I've removed the fallback message and simplified the "ret"
> checking. Could you please confirm if this looks good for v6?
> 
>         if (ret == -ENODEV) {
> 
>                 /* Request the GPIO for PCIe reset signal and assert */
>                 pcie->perst_gpio = devm_gpiod_get_optional(dev, "reset",
>                                                            GPIOD_OUT_HIGH);
>                 if (IS_ERR(pcie->perst_gpio))
>                         return dev_err_probe(dev, PTR_ERR(pcie->perst_gpio),
>                                              "Failed to request reset GPIO\n");
>         } else if (ret) {
>                 return ret;
>         }

Looks good to me.  It's important to note that this -ENODEV fallback
uses the PERST# GPIO described in the host bridge, not in a Root Port,
but I think your comment above includes this.

Bjorn

