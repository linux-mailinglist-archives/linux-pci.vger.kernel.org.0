Return-Path: <linux-pci+bounces-16340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D22D9C2215
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 17:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2202B2847B7
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 16:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9640D192584;
	Fri,  8 Nov 2024 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZHNQ5and"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2207F187FE4;
	Fri,  8 Nov 2024 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083393; cv=none; b=rXjdTIYs1m8K8FjLzTv583SJms3Nt09WC9zMLPx0wmhSsYZVJDL3qT76Re+ZZyxGjkFHcls0Rdh+dpcNHhJm0CtdVRDdryiUAS3XoOrHxeNWCXn8U0tUpQbvEJLCfgUT1iw/+wvI3JZ4wqWcucWotrjFwu0X0jZfsKeOog42MFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083393; c=relaxed/simple;
	bh=DNG0fhk9qlX9wvnac6CmQX+5HHoCd1PixPcukAAxAbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqiL0epFq2Uu9eukWiBlLEcpmygAiqNcHqxFsmu6ZKBW/jYxzuwOVt+VrVN5M1RIyNvMCJH/0/3Cyv09Q/cKDxc4Nq0uHyzp1IZ56HEU6rOeT4/irNUhJWfM8GWu2g08gg7fCYc9+9YZyNYvxjI9ZEH341VuLNVMh56WM2CQ4z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZHNQ5and; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5C1771C0003;
	Fri,  8 Nov 2024 16:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731083388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNv0XZ9+/yD94EzPzcVjyKNuEO41gbMIYl9M0TKDnlY=;
	b=ZHNQ5andb//fQ6/+jxYn/+OPoSdSGOeFUiiZNi6z26S/XjrKcFCTYfH8z0sDGohKEpdDNF
	XnsKSi0776p2f/hOyHZtURKABa7emm8YbXZ8I4gEo03qZiV5TKQG+eSoguH/gn6MhfFO+R
	kbo4W/uhXmETgZgmaHOIDU12xGRg0e6v7OXTBFl/IEV6pECCnLp7HnjtIfAYw+Us7cF40d
	XEeuCyEbOXnIYggWSAQHpihdQhqMl/fxXX9RF5o+C5lLbZYywL8KD8LY5sbGE+JfWhe+DM
	Yy4CC1NpdwEosL/1GPGaAx8V2MdX6NJsBTvw6c/ZJ7M6n7fwT3CHYWbTa856Pg==
Date: Fri, 8 Nov 2024 17:29:46 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Saravana Kannan <saravanak@google.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 5/6] of: Add #address-cells/#size-cells in the
 device-tree root empty node
Message-ID: <20241108172946.7233825e@bootlin.com>
In-Reply-To: <CAL_JsqJ-05tB7QSjmGvFLbKFGmzezJhukDGS3fP9GFtp2=BWOA@mail.gmail.com>
References: <20241108143600.756224-1-herve.codina@bootlin.com>
	<20241108143600.756224-6-herve.codina@bootlin.com>
	<CAL_JsqJ-05tB7QSjmGvFLbKFGmzezJhukDGS3fP9GFtp2=BWOA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Rob,

On Fri, 8 Nov 2024 10:03:31 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, Nov 8, 2024 at 8:36 AM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > On systems where ACPI is enabled or when a device-tree is not passed to
> > the kernel by the bootloader, a device-tree root empty node is created.
> > This device-tree root empty node doesn't have the #address-cells and the  
> 
> and the?

#size-cells properties.

Will be updated.

> 
> > This leads to the use of the default address cells and size cells values
> > which are defined in the code to 1 for address cells and 1 for size cells  
> 
> Missing period.

Will be updated.

> 
> >
> > According to the devicetree specification and the OpenFirmware standard
> > (IEEE 1275-1994) the default value for #address-cells should be 2.
> >
> > Also, according to the devicetree specification, the #address-cells and
> > the #size-cells are required properties in the root node.
> >
> > Modern implementation should have the #address-cells and the #size-cells
> > properties set and should not rely on default values.
> >
> > On x86, this root empty node is used and the code default values are
> > used.
> >
> > In preparation of the support for device-tree overlay on PCI devices
> > feature on x86 (i.e. the creation of the PCI root bus device-tree node),
> > the default value for #address-cells needs to be updated. Indeed, on
> > x86_64, addresses are on 64bits and the upper part of an address is
> > needed for correct address translations. On x86_32 having the default
> > value updated does not lead to issues while the uppert part of a 64bits  
> 
> upper

Will be updated.

> 
> > address is zero.
> >
> > Changing the default value for all architectures may break device-tree
> > compatibility. Indeed, existing dts file without the #address-cells
> > property set in the root node will not be compatible with this
> > modification.
> >
> > Instead of updating default values, add required #address-cells and  
> 
> and?

#size-cells properties in the device-tree empty root node.

Will be updated.

> 
> >
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  drivers/of/empty_root.dts | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/of/empty_root.dts b/drivers/of/empty_root.dts
> > index cf9e97a60f48..5017579f34dc 100644
> > --- a/drivers/of/empty_root.dts
> > +++ b/drivers/of/empty_root.dts
> > @@ -2,5 +2,11 @@
> >  /dts-v1/;
> >
> >  / {
> > -
> > +       /*
> > +        * #address-cells/#size-cells are required properties at root node
> > +        * according to the devicetree specification. Use same values as default
> > +        * values mentioned for #address-cells/#size-cells properties.  
> 
> Which default? We have multiple...

I will reword:
  Use values mentioned in the devicetree specification as default values
  for #address-cells and #size-cells properties


> 
> There's also dtc's idea of default which IIRC is 2 and 1 like OpenFirmware.

I can re-add this part in the commit log:
  The device tree compiler already uses 2 as default value for address cells
  and 1 for size cells. The powerpc PROM code also use 2 as default value
  for #address-cells and 1 for #size-cells. Modern implementation should
  have the #address-cells and the #size-cells properties set and should
  not rely on default values.

In your opinion, does it make sense?

> 
> > +        */
> > +       #address-cells = <0x02>;
> > +       #size-cells = <0x01>;  
> 
> I think we should just do 2 cells for size.

Why using 2 for #size-cells?

I understand that allows to have size defined on 64bits but is that needed?
How to justify this value here?

Best regards,
Hervé

