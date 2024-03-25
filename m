Return-Path: <linux-pci+bounces-5079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB3B88A421
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 15:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962BF2E18FA
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 14:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE19D12F5BD;
	Mon, 25 Mar 2024 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="UUcDbdjZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D4E13E6C8;
	Mon, 25 Mar 2024 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361767; cv=none; b=oNtn2J3qRERhGOR5ZAo7BrpxJTqkg2125fABrfFfS5MaM/Ijoik2NSxDGW8VDgOqLjnsnU2lSdPHuzrw8WuVcgYATCYCIjlg8CSZFEKBUuA82Wj3FNkYz6qdcQyVOCHWq4YvdrJsgk/ku0aqInqpTT+dEpMX2IJp1vh6/J60xNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361767; c=relaxed/simple;
	bh=sKKRdrTurFaHKczVM5dueoW5ihUbWtXhk0VglFkeCWI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vs6uxQ0PYB9LZJoV5vbGOpsjbGg+0n4xvd6UItnOlwZRzeo9nxGDTYEvkihLxh9Z2FhmYqfWzQpoIkB/xEdtFo67fA/p2leZfxrRs+rCeZi6KSLB9W4fHkFyQeNXQPMusqj4+bmBQ05qQnGQ6BKs1I/P+KioD/oNE9/Wog9SO1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=UUcDbdjZ; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1711361760;
	bh=sKKRdrTurFaHKczVM5dueoW5ihUbWtXhk0VglFkeCWI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UUcDbdjZes5HxI4JaxjU8oNwuRs4pvOz4nITFL0SMNyQV+qc0rFFNv3NlDQDofF/l
	 PBzKemeloUIJ+UR1KuTuJjOcvVMn/KEHzXjiYgV2ZRTTc102GUuUNcecorHw9InFuX
	 hjQebatvwiSqyN6j+KHY7SO8D9myXjtNQjUXM4q0=
Received: from [IPv6:240e:358:11fe:a000:dc73:854d:832e:8] (unknown [IPv6:240e:358:11fe:a000:dc73:854d:832e:8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id C812866D53;
	Mon, 25 Mar 2024 06:15:55 -0400 (EDT)
Message-ID: <ba78805af8b39237b22a0ff87c4ba3c614a43910.camel@xry111.site>
Subject: Re: [PATCHv3 pci-next 1/2] PCI/AER: correctable error message as
 KERN_INFO
From: Xi Ruoyao <xry111@xry111.site>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, Bjorn Helgaas
	 <helgaas@kernel.org>
Cc: Grant Grundler <grundler@chromium.org>, bhelgaas@google.com, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, mahesh@linux.ibm.com, oohall@gmail.com, 
	rajat.khandelwal@linux.intel.com, rajatja@chromium.org
Date: Mon, 25 Mar 2024 18:15:50 +0800
In-Reply-To: <38601aef-b082-463f-8e41-f73a4307de21@linux.intel.com>
References: <20230918193913.GA203601@bhelgaas>
	 <0a44fd663e93ac5b36865b0080da52d94252791a.camel@xry111.site>
	 <38601aef-b082-463f-8e41-f73a4307de21@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-25 at 16:45 +0800, Ethan Zhao wrote:
> On 3/25/2024 1:19 AM, Xi Ruoyao wrote:
> > On Mon, 2023-09-18 at 14:39 -0500, Bjorn Helgaas wrote:
> > > On Mon, Sep 18, 2023 at 07:42:30PM +0800, Xi Ruoyao wrote:
> > > > ...
> > > > My workstation suffers from too much correctable AER reporting as w=
ell
> > > > (related to Intel's errata "RPL013: Incorrectly Formed PCIe Packets=
 May
> > > > Generate Correctable Errors" and/or the motherboard design, I guess=
).
> > > We should rate-limit correctable error reporting so it's not
> > > overwhelming.
> > >=20
> > > At the same time, I'm *also* interested in the cause of these errors,
> > > in case there's a Linux defect or a hardware erratum that we can work
> > > around.=C2=A0 Do you have a bug report with any more details, e.g., a=
 dmesg
> > > log and "sudo lspci -vv" output?
> > Hi Bjorn,
> >=20
> > Sorry for the *very* late reply (somehow I didn't see the reply at all
> > before it was removed by my cron job, and now I just savaged it from
> > lore.kernel.org...)
> >=20
> > The dmesg is like:
> >=20
> > [=C2=A0 882.456994] pcieport 0000:00:1c.1: AER: Multiple Correctable er=
ror message received from 0000:00:1c.1
> > [=C2=A0 882.457002] pcieport 0000:00:1c.1: AER: found no error details =
for 0000:00:1c.1
> > [=C2=A0 882.457003] pcieport 0000:00:1c.1: AER: Multiple Correctable er=
ror message received from 0000:06:00.0
> > [=C2=A0 883.545763] pcieport 0000:00:1c.1: AER: Multiple Correctable er=
ror message received from 0000:00:1c.1
> > [=C2=A0 883.545789] pcieport 0000:00:1c.1: PCIe Bus Error: severity=3DC=
orrectable, type=3DPhysical Layer, (Receiver ID)
> > [=C2=A0 883.545790] pcieport 0000:00:1c.1:=C2=A0=C2=A0 device [8086:7a3=
9] error status/mask=3D00000001/00002000
> > [=C2=A0 883.545792] pcieport 0000:00:1c.1:=C2=A0=C2=A0=C2=A0 [ 0] RxErr=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 (First)
> > [=C2=A0 883.545794] pcieport 0000:00:1c.1: AER:=C2=A0=C2=A0 Error of th=
is Agent is reported first
> > [=C2=A0 883.545798] r8169 0000:06:00.0: PCIe Bus Error: severity=3DCorr=
ectable, type=3DPhysical Layer, (Transmitter ID)
> > [=C2=A0 883.545799] r8169 0000:06:00.0:=C2=A0=C2=A0 device [10ec:8125] =
error status/mask=3D00001101/0000e000
> > [=C2=A0 883.545800] r8169 0000:06:00.0:=C2=A0=C2=A0=C2=A0 [ 0] RxErr=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (First)
> > [=C2=A0 883.545801] r8169 0000:06:00.0:=C2=A0=C2=A0=C2=A0 [ 8] Rollover
> > [=C2=A0 883.545802] r8169 0000:06:00.0:=C2=A0=C2=A0=C2=A0 [12] Timeout
> > [=C2=A0 883.545815] pcieport 0000:00:1c.1: AER: Correctable error messa=
ge received from 0000:00:1c.1
> > [=C2=A0 883.545823] pcieport 0000:00:1c.1: AER: found no error details =
for 0000:00:1c.1
> > [=C2=A0 883.545824] pcieport 0000:00:1c.1: AER: Multiple Correctable er=
ror message received from 0000:06:00.0
> >=20
> > lspci output attached.
> >=20
> > Intel has issued an errata "RPL013" saying:
> >=20
> > "Under complex microarchitectural conditions, the PCIe controller may
> > transmit an incorrectly formed Transaction Layer Packet (TLP), which
> > will fail CRC checks.=C2=A0When this erratum occurs, the PCIe end point=
 may
> > record correctable errors resulting in either a NAK or link recovery.
> > Intel=C2=AE has not observed any functional impact due to this erratum.=
"
> >=20
> > But I'm really unsure if it describes my issue.
> >=20
> > Do you think I have some broken hardware and I should replace the CPU
> > and/or the motherboard (where the r8169 is soldered)?=C2=A0 I've notice=
d that
> > my 13900K is almost impossible to overclock (despite it's a K), but I'v=
e
> > not encountered any issue other than these AER reporting so far after I
> > gave up overclocking.
>=20
> Seems there are two r8169 nics on your board, only 0000:06:00.0 reports
> aer errors, how about another one the 0000:07:00.0 nic ?

It never happens to 0000:07:00.0, even if I plug the ethernet cable into
it instead of 0000:06:00.0.

Maybe I should just use 0000:07:00.0 and blacklist 0000:06:00.0 as I
don't need two NICs?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

