Return-Path: <linux-pci+bounces-16350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731AE9C242A
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 18:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F19C3B2651E
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 17:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD7620DD7B;
	Fri,  8 Nov 2024 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NwXAzx19"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E484E233D6D;
	Fri,  8 Nov 2024 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087610; cv=none; b=Xr5lMqgqbr3Ujd04C2MXQm9BoscjdYKsvoxJZhmx+hwL39pyY6O4z6avXLTRUIEaOC6JJQHHnfHjbmtCVz/1bdDdMm9PGbVwspk+mYqRAj7ue8kg++r8sEzezY3glxTz2IR3FLxCLyset3vMmJ3q0qLnr8Y7dYNGbilgoQEeQXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087610; c=relaxed/simple;
	bh=iiARu0Nk8CVwQ3QQGwPP6meCN98PtNxkPO57n5KBjcg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8XfrDEQkC1IgGk5QIutUQwP2qcnqp1iXcYxH/vCYWK6uKv3gTSpavyRo2vYBPqV6OdctSlaTHw5kvoZF1vKLqcXw+2wJVrkbyfxsgaFXy3tcpoyOFwLF/S7vjTA2Wt/8hXUywQcybio1LsZFV1KOZrxFRwSIbtUBwiXo8s44VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NwXAzx19; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E556FFF806;
	Fri,  8 Nov 2024 17:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731087599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKjz3h86srqcmGB/4sy6wbmzDtox3/nU1f7+fBVoTIw=;
	b=NwXAzx19offAOxoDGjSswAn7NfEKz//W0s4o79RGt3hwiTkahsETewN16ig6ShFREDru8S
	C1nLnyJJQsdEWHSAcSwYZ/vG9JdFtIMZzvYHP6H2vw+I8JQoEkYeKO38trMzHuvxo/urni
	YKJCffIOyETc+3i2SNGyxveinhfCwkP5f65yqJ20P8p+Dayhfn8gCqGPl0gxfD7nKOYsvq
	YVQo2PbUf8hvNZYA4StEpzUdPbzqpg6QwjSq5qKxj4JYCwGl2oeiYWO13htsEyYGv9GtFV
	cLIW3F1BL/kLGSaxdF1XVwMB+LnFwqTpJW2SgfvquhmCrhWiYGpEY3TNtP8Glg==
Date: Fri, 8 Nov 2024 18:39:58 +0100
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
Message-ID: <20241108183958.0f136e01@bootlin.com>
In-Reply-To: <CAL_JsqLWUSCJMU5LMz8X_0gU74YNy6-vRXGvY24ZpVj+EZW-sA@mail.gmail.com>
References: <20241108143600.756224-1-herve.codina@bootlin.com>
	<20241108143600.756224-6-herve.codina@bootlin.com>
	<CAL_JsqJ-05tB7QSjmGvFLbKFGmzezJhukDGS3fP9GFtp2=BWOA@mail.gmail.com>
	<20241108172946.7233825e@bootlin.com>
	<CAL_JsqLWUSCJMU5LMz8X_0gU74YNy6-vRXGvY24ZpVj+EZW-sA@mail.gmail.com>
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

On Fri, 8 Nov 2024 11:24:36 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, Nov 8, 2024 at 10:29 AM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > Hi Rob,
> >
> > On Fri, 8 Nov 2024 10:03:31 -0600
> > Rob Herring <robh@kernel.org> wrote:
> >  
> > > On Fri, Nov 8, 2024 at 8:36 AM Herve Codina <herve.codina@bootlin.com> wrote:  
> > > >
> > > > On systems where ACPI is enabled or when a device-tree is not passed to
> > > > the kernel by the bootloader, a device-tree root empty node is created.
> > > > This device-tree root empty node doesn't have the #address-cells and the  
> 
> > > > +       /*
> > > > +        * #address-cells/#size-cells are required properties at root node
> > > > +        * according to the devicetree specification. Use same values as default
> > > > +        * values mentioned for #address-cells/#size-cells properties.  
> > >
> > > Which default? We have multiple...  
> >
> > I will reword:
> >   Use values mentioned in the devicetree specification as default values
> >   for #address-cells and #size-cells properties  
> 
> My point was that "default" is meaningless because there are multiple
> sources of what's default.

I see thanks.
I will update the code comment.

> 
> > >
> > > There's also dtc's idea of default which IIRC is 2 and 1 like OpenFirmware.  
> >
> > I can re-add this part in the commit log:
> >   The device tree compiler already uses 2 as default value for address cells
> >   and 1 for size cells. The powerpc PROM code also use 2 as default value
> >   for #address-cells and 1 for #size-cells. Modern implementation should
> >   have the #address-cells and the #size-cells properties set and should
> >   not rely on default values.
> >
> > In your opinion, does it make sense?
> >  
> > >  
> > > > +        */
> > > > +       #address-cells = <0x02>;
> > > > +       #size-cells = <0x01>;  
> > >
> > > I think we should just do 2 cells for size.  
> >
> > Why using 2 for #size-cells?
> >
> > I understand that allows to have size defined on 64bits but is that needed?
> > How to justify this value here?  
> 
> Most systems are 64-bit today. And *all* ACPI based systems are. Not
> that the DT has to match 32 vs 64 bit CPU, most of the time it does.
> 
> It also doesn't actually change anything for you because you're going
> to have "pci" nodes and the "ranges" there takes #size-cells from the
> pci node, not the parent.
> 

Right.
I will set:
  #address-cells = <0x02>;
  #size-cells = <0x02>;

Best regards,
Hervé

