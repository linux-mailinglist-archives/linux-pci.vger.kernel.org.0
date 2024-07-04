Return-Path: <linux-pci+bounces-9771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC1C926D4D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 04:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E86F281195
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 02:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6568F6E;
	Thu,  4 Jul 2024 02:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="JKs7+zda"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FFC23BB;
	Thu,  4 Jul 2024 02:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720058482; cv=pass; b=DXQN/iNnHS+fqTaJK9RSHLJ4AO1sTEQQ1EQ14amTo9LJ+e6VaPO5UN5Bvc8RMhTuZZqrqfrij+rYbjWn3lRlP8szD3mDL2NE8Y5FoBogXzST42ejCpXFQ13olxuIABFSKkzaf0VUk2GUqS4mjgYxctje6pZ9WStaqSfpAtkBxss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720058482; c=relaxed/simple;
	bh=W9OqunnTPDg38IVBRFQeGAZEa+FOMhVSSOueR/HZRCM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u676BY893ZXdgMAAZ3ionCjCnFd9eL2J6u5lboFxQL0BhQhLu7FmGGO8qKUh5WALBigFxgRPUeuu9aSWpb0ODVuFDyP1aVdiVXVMt5Fr7024fBUblxVyU0GZtO+BpqIDoTa36u3NdKIw8XJX6BlZiNU7UjeepOyJZ2dRb73XdWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=JKs7+zda; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1720058458; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jTPPN3UWqhQUDqQtg3DjdoaPCUaAPjQz1EhA4whcnVIT9tLBl4ph0YhVUVe8l79AmG+cXYpWr/cI5wdVk9MYsCIDVjI34Ns4aLWgkK6Lg1JYJKsCz0cMHStP1tMyBwjvQLxz90jzw0RymHF77jIWlgisR28c1Rsyk88uH1zIk6A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1720058458; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=W9OqunnTPDg38IVBRFQeGAZEa+FOMhVSSOueR/HZRCM=; 
	b=ljpvD26QvxfwKCCSx1FyIOscIXBDcoDhM0Be1ehzJ/BF+tY7nTjJ6dhNc/YFnGDYLC8wzDVrhD1RUVCWZ9ZDgAk9SnjnYtuQfBjOX7Cgc6E69vBQXgOHTpFXG+gNQvitNKgWP8ssw/xnKed6whao/Zr0URPTW3jqU4eeBO2VG1U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1720058458;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=W9OqunnTPDg38IVBRFQeGAZEa+FOMhVSSOueR/HZRCM=;
	b=JKs7+zda2gRlGQPNroBAk6XPtG+JU6IsNrK8x6DlfWcwUEZH5QLZUposwTfB9Jgx
	5vCmgJpE/b3EStejE0mRewFRXW1GW+/CniuIFQ0NbNbufeoUpDt6hbU5n3rQak3rBmm
	te3iTzjZg6ptiWXnJg1QhaosWyLU9RRnnwPhfkKQMYHGWOOUZJwhKfdOZ4wkI91Vlg6
	iDLKv3cXcD2nDAgZKd6uySxMaSXmyX6MG0N1VS0DY1milWSdVRXiFfuUPkwAUone5l2
	tiB65K0RkQ0DtKokAIPo8lvEP0ou+DHMj31aH2TkLho69N6iEfimtOXEUrtACmneu0B
	5A6s2i1zFg==
Received: by mx.zohomail.com with SMTPS id 17200584565631004.9071576656763;
	Wed, 3 Jul 2024 19:00:56 -0700 (PDT)
Message-ID: <99ff395019901c5c1a7b298481c8261b30fdbd01.camel@icenowy.me>
Subject: Re: PCIe coherency in spec (was: [RFC PATCH 2/2] drm/ttm: downgrade
 cached to write_combined when snooping not available)
From: Icenowy Zheng <uwu@icenowy.me>
To: Bjorn Helgaas <helgaas@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Huang Rui
 <ray.huang@amd.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
  Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,  Daniel Vetter
 <daniel@ffwll.ch>, bhelgaas@google.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date: Thu, 04 Jul 2024 10:00:52 +0800
In-Reply-To: <20240703210831.GA63958@bhelgaas>
References: <20240703210831.GA63958@bhelgaas>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2024-07-03=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 16:08 -0500=EF=BC=
=8CBjorn Helgaas=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, Jul 03, 2024 at 04:52:30PM +0800, Jiaxun Yang wrote:
> > =E5=9C=A82024=E5=B9=B47=E6=9C=882=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=
=E5=8D=886:03=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
> > > =E5=9C=A82024=E5=B9=B47=E6=9C=882=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=
=8B=E5=8D=885:27=EF=BC=8CChristian K=C3=B6nig=E5=86=99=E9=81=93=EF=BC=9A
> > > > Am 02.07.24 um 11:06 schrieb Icenowy Zheng:
> > > > > [SNIP] However I don't think the definition of the AGP spec
> > > > > could apply on all
> > > > > PCI(e) implementations. The AGP spec itself don't apply on
> > > > > implementations that do not implement AGP (which is the most
> > > > > PCI(e)
> > > > > implementations today), and it's not in the reference list of
> > > > > the PCIe
> > > > > spec, so it does no help on this context.=20
> > > > No, exactly that is not correct.
> > > >=20
> > > > See as I explained the No-Snoop extension to PCIe was created
> > > > to help=20
> > > > with AGP support and later merged into the base PCIe
> > > > specification.
> > > >=20
> > > > So the AGP spec is now part of the PCIe spec.
> >=20
> > Hi Bjorn & linux-pci folks,
> >=20
> > It seems like we have some disputes on interpretation pf PCIe
> > specification.
> >=20
> > We are seeking your expertise on the question: Does PCIe
> > specification mandate Cache coherency via snoop?
>=20
> I'm not qualified to opine on this.=C2=A0 I'd say it's a question for the
> PCI SIG protocol workgroup.=C2=A0 https://forum.pcisig.com/=C2=A0is a pla=
ce to
> start.

Sorry for the disturbance.

As individual hacker, I am not eligble of being a PCI-SIG member and
join the discussion there.

So I here want to ask a question as an individual hacker: what's the
policy of linux-pci towards these non-coherent PCIe implementations?

If the sentences of Christian is right, these implementations are just
out-of-spec, should them get purged out of the kernel, or at least
raising a warning that some HW won't work because of inconformant
implementation?

>=20
> Bjorn


