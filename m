Return-Path: <linux-pci+bounces-5130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A44C88B2FF
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 22:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8A0EB3B068
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 21:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712A06EB49;
	Mon, 25 Mar 2024 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="bihn7DHA"
X-Original-To: linux-pci@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0BF6E611;
	Mon, 25 Mar 2024 21:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402842; cv=none; b=iKElFwqO1Xignk7E54Wnf10jhZBhNQVXLWgrrM7x2qOHshmzR+PHqp6SbkqaBWtJob44Lra3zMEQI2QuIzQ1dD3ckNF1AP2hCaS7UqJlYCsvsQP4DPycVkq5J0YQ7bRkV/2Ma2W9lmdaao74OWF32I5QWO+D9TUD18QqpEl+R8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402842; c=relaxed/simple;
	bh=SfhDpy1gBjb0secvYDmVDcNH0yEOBTw0RQ+3z7mvlJc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UAe83fG7IUWNuwGODnyN9Aj2INapt7N+Y1+Cz5GWBlA1VzRw2nBSKrgaNTK4cuPsqalai9ztfLYaySzW9Uf/1GlWPcHLugIX7jD0r+CF2qEoe8+GxqxOfFrEeDEl3IL6XyqRPUt9fG2gUEllPjUoLtVjSJ5E8A+3PGWrK7FXky8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=bihn7DHA; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1711402838;
	bh=SfhDpy1gBjb0secvYDmVDcNH0yEOBTw0RQ+3z7mvlJc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bihn7DHAYDcY37C5lrOcOftrxdZ1EPXXSiq6fBsNAcsPIyrwVsVgYHDc8fYgwn0T+
	 SzHj5CmEzoByIzE+O5BHN3D1riTfQAEsX20mZy66cJK9vEc0NUIWvduk07JG3NEoNM
	 9ve7gzfAMQbokgSDNw01wRs+EYu7IoTUG4YXlSgU=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 3D21A67071;
	Mon, 25 Mar 2024 17:40:35 -0400 (EDT)
Message-ID: <70e3b9cac305d157396c99355339008e8cf97c62.camel@xry111.site>
Subject: Re: [PATCHv3 pci-next 1/2] PCI/AER: correctable error message as
 KERN_INFO
From: Xi Ruoyao <xry111@xry111.site>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, Bjorn Helgaas
	 <helgaas@kernel.org>
Cc: Grant Grundler <grundler@chromium.org>, bhelgaas@google.com, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, mahesh@linux.ibm.com, oohall@gmail.com, 
	rajat.khandelwal@linux.intel.com, rajatja@chromium.org
Date: Tue, 26 Mar 2024 05:40:34 +0800
In-Reply-To: <ba78805af8b39237b22a0ff87c4ba3c614a43910.camel@xry111.site>
References: <20230918193913.GA203601@bhelgaas>
	 <0a44fd663e93ac5b36865b0080da52d94252791a.camel@xry111.site>
	 <38601aef-b082-463f-8e41-f73a4307de21@linux.intel.com>
	 <ba78805af8b39237b22a0ff87c4ba3c614a43910.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-25 at 18:15 +0800, Xi Ruoyao wrote:
> On Mon, 2024-03-25 at 16:45 +0800, Ethan Zhao wrote:
> > On 3/25/2024 1:19 AM, Xi Ruoyao wrote:
> > > On Mon, 2023-09-18 at 14:39 -0500, Bjorn Helgaas wrote:
> > > > On Mon, Sep 18, 2023 at 07:42:30PM +0800, Xi Ruoyao wrote:
> > > > > ...
> > > > > My workstation suffers from too much correctable AER reporting as=
 well
> > > > > (related to Intel's errata "RPL013: Incorrectly Formed PCIe Packe=
ts May
> > > > > Generate Correctable Errors" and/or the motherboard design, I gue=
ss).
> > > > We should rate-limit correctable error reporting so it's not
> > > > overwhelming.
> > > >=20
> > > > At the same time, I'm *also* interested in the cause of these error=
s,
> > > > in case there's a Linux defect or a hardware erratum that we can wo=
rk
> > > > around.=C2=A0 Do you have a bug report with any more details, e.g.,=
 a dmesg
> > > > log and "sudo lspci -vv" output?
> > > Hi Bjorn,
> > >=20
> > > Sorry for the *very* late reply (somehow I didn't see the reply at al=
l
> > > before it was removed by my cron job, and now I just savaged it from
> > > lore.kernel.org...)
> > >=20
> > > The dmesg is like:
> > >=20
> > > [=C2=A0 882.456994] pcieport 0000:00:1c.1: AER: Multiple Correctable =
error message received from 0000:00:1c.1
> > > [=C2=A0 882.457002] pcieport 0000:00:1c.1: AER: found no error detail=
s for 0000:00:1c.1
> > > [=C2=A0 882.457003] pcieport 0000:00:1c.1: AER: Multiple Correctable =
error message received from 0000:06:00.0
> > > [=C2=A0 883.545763] pcieport 0000:00:1c.1: AER: Multiple Correctable =
error message received from 0000:00:1c.1
> > > [=C2=A0 883.545789] pcieport 0000:00:1c.1: PCIe Bus Error: severity=
=3DCorrectable, type=3DPhysical Layer, (Receiver ID)
> > > [=C2=A0 883.545790] pcieport 0000:00:1c.1:=C2=A0=C2=A0 device [8086:7=
a39] error status/mask=3D00000001/00002000
> > > [=C2=A0 883.545792] pcieport 0000:00:1c.1:=C2=A0=C2=A0=C2=A0 [ 0] RxE=
rr=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (First)
> > > [=C2=A0 883.545794] pcieport 0000:00:1c.1: AER:=C2=A0=C2=A0 Error of =
this Agent is reported first
> > > [=C2=A0 883.545798] r8169 0000:06:00.0: PCIe Bus Error: severity=3DCo=
rrectable, type=3DPhysical Layer, (Transmitter ID)
> > > [=C2=A0 883.545799] r8169 0000:06:00.0:=C2=A0=C2=A0 device [10ec:8125=
] error status/mask=3D00001101/0000e000
> > > [=C2=A0 883.545800] r8169 0000:06:00.0:=C2=A0=C2=A0=C2=A0 [ 0] RxErr=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 (First)
> > > [=C2=A0 883.545801] r8169 0000:06:00.0:=C2=A0=C2=A0=C2=A0 [ 8] Rollov=
er
> > > [=C2=A0 883.545802] r8169 0000:06:00.0:=C2=A0=C2=A0=C2=A0 [12] Timeou=
t
> > > [=C2=A0 883.545815] pcieport 0000:00:1c.1: AER: Correctable error mes=
sage received from 0000:00:1c.1
> > > [=C2=A0 883.545823] pcieport 0000:00:1c.1: AER: found no error detail=
s for 0000:00:1c.1
> > > [=C2=A0 883.545824] pcieport 0000:00:1c.1: AER: Multiple Correctable =
error message received from 0000:06:00.0
> > >=20
> > > lspci output attached.
> > >=20
> > > Intel has issued an errata "RPL013" saying:
> > >=20
> > > "Under complex microarchitectural conditions, the PCIe controller may
> > > transmit an incorrectly formed Transaction Layer Packet (TLP), which
> > > will fail CRC checks.=C2=A0When this erratum occurs, the PCIe end poi=
nt may
> > > record correctable errors resulting in either a NAK or link recovery.
> > > Intel=C2=AE has not observed any functional impact due to this erratu=
m."
> > >=20
> > > But I'm really unsure if it describes my issue.
> > >=20
> > > Do you think I have some broken hardware and I should replace the CPU
> > > and/or the motherboard (where the r8169 is soldered)?=C2=A0 I've noti=
ced that
> > > my 13900K is almost impossible to overclock (despite it's a K), but I=
've
> > > not encountered any issue other than these AER reporting so far after=
 I
> > > gave up overclocking.
> >=20
> > Seems there are two r8169 nics on your board, only 0000:06:00.0 reports
> > aer errors, how about another one the 0000:07:00.0 nic ?
>=20
> It never happens to 0000:07:00.0, even if I plug the ethernet cable into
> it instead of 0000:06:00.0.
>=20
> Maybe I should just use 0000:07:00.0 and blacklist 0000:06:00.0 as I
> don't need two NICs?

Plugging the ethernet cable into 0000:07:00.0 and then
"echo 1 > /sys/bus/pci/devices/0000:00:1c.1/remove" work for me...

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

