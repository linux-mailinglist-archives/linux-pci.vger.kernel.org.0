Return-Path: <linux-pci+bounces-31943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC33B02392
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 20:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD4E3A8329
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 18:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC722F2C7F;
	Fri, 11 Jul 2025 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="Tx7WS/5h"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE78F2F2C79;
	Fri, 11 Jul 2025 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258264; cv=none; b=GB0LaY35z135zAadoV5xx/BYVqd57JBQk0yhOxNNKjQTtEfWokf/Ktu2zRWqpqqIrEAPlfh+PfFUv0uMxuHdzenXU75mh/vd0SSCs1Z9dzNZb8S0+gtEzGM0+ZOwTRmD3Hx4e9QVhIpFu9cu014dYvb30jdV59K8jscL2sojyJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258264; c=relaxed/simple;
	bh=gDvvHLrpt3dz96vtuXPeitVvNGkl1snbkwkvTEkVWRs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Cx6hMMA9DVype2CgIHCzg50/zihAG8e+BMddoxy4GoPPO9S0+PmOK7R/+gPWC93i3Yd+2NC9Ng72GnWDE/tWtHLQRrooI6Z6LQDYbP+iM4tjspivq07Elbs8EUN12UcpW8LhB6XgmmBXHObMFCHV4NXn/McacyeSy8t5K2p4BxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=Tx7WS/5h; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 09EC68288F33;
	Fri, 11 Jul 2025 13:18:11 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id LAf6JLA7DNBy; Fri, 11 Jul 2025 13:18:08 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 4AE358288F5B;
	Fri, 11 Jul 2025 13:18:08 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 4AE358288F5B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1752257888; bh=gDvvHLrpt3dz96vtuXPeitVvNGkl1snbkwkvTEkVWRs=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=Tx7WS/5hHtYSqCL0ma/RGV4lSu2Vyo6m7H34ory4crMJXHc8d52/u9xIguWn4y1o9
	 5cu+EMP+ju0P3U5QlWHY9TunjkH4Deb9ZJIH08+dmrFQbM8cR2JMEqGE29yk8ejeiY
	 bTz7snrmwfnlmI/yX9G6zVessZwW1+AWCLUl4eZY=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cTUq5L-Av43w; Fri, 11 Jul 2025 13:18:08 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 0E4DF8288F33;
	Fri, 11 Jul 2025 13:18:08 -0500 (CDT)
Date: Fri, 11 Jul 2025 13:18:07 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Krishna Kumar <krishnak@linux.ibm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	christophe leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Shawn Anastasio <sanastasio@raptorengineering.com>, 
	Lukas Wunner <lukas@wunner.de>
Message-ID: <1841754281.1353162.1752257887865.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <3ebe82c1-d9ae-419e-9e49-61fcb71abe34@linux.ibm.com>
References: <20250624223413.GA1550003@bhelgaas> <3ebe82c1-d9ae-419e-9e49-61fcb71abe34@linux.ibm.com>
Subject: Re: [PATCH v2 6/6] pci/hotplug/pnv_php: Enable third attention
 indicator
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC138 (Linux)/8.5.0_GA_3042)
Thread-Topic: pci/hotplug/pnv_php: Enable third attention indicator
Thread-Index: 1THlEb9At+uVSeMvjMGLUwEw4YbY8A==



----- Original Message -----
> From: "Krishna Kumar" <krishnak@linux.ibm.com>
> To: "Bjorn Helgaas" <helgaas@kernel.org>, "Timothy Pearson" <tpearson@rap=
torengineering.com>
> Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel" <linux=
-kernel@vger.kernel.org>, "linux-pci"
> <linux-pci@vger.kernel.org>, "Madhavan Srinivasan" <maddy@linux.ibm.com>,=
 "Michael Ellerman" <mpe@ellerman.id.au>,
> "christophe leroy" <christophe.leroy@csgroup.eu>, "Naveen N Rao" <naveen@=
kernel.org>, "Bjorn Helgaas"
> <bhelgaas@google.com>, "Shawn Anastasio" <sanastasio@raptorengineering.co=
m>, "Lukas Wunner" <lukas@wunner.de>
> Sent: Monday, July 7, 2025 3:01:00 AM
> Subject: Re: [PATCH v2 6/6] pci/hotplug/pnv_php: Enable third attention i=
ndicator

> Thanks all for the review and Thanks a bunch to Timothy for fixing the PE=
 Freeze
> issue. The hotplug issues are like you fix N issue and N+1 th issue will =
come
> with new HW.
>=20
> We had a meeting of around 1.5 -2.0 hr with demo, code review and log rev=
iew and
> we decided to let these fixes go ahead. I am consolidating what we discus=
sed -
>=20
>=20
> 1. Let these fixes go ahead as it solves wider and much needed customer i=
ssue
> and its urgently needed for time being. We have verified in live demo tha=
t
> nothing is broken from legacy flow and
>=20
> PE/PHB freeze, race condition, hung, oops etc has been solved correctly.
> Basically it fixes below issues -
>=20
> root-port(phb) -> switch(having4 port)--> 2 nvme devices
>=20
> 1st case - only removal of EP-nvme device (surprise hotplug disables msi =
at root
> port), soft removal may work
> 2nd case=C2=A0 - If we remove switch itself (surprise hotplug disable msi=
 at root
> port) .

Just a quick follow up to see if anything else is needed from my end before=
 this merge can occur?

Thanks!

