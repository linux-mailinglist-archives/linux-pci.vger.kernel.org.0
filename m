Return-Path: <linux-pci+bounces-32200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8194B068BA
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 23:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A79564444
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 21:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF3E2BE64E;
	Tue, 15 Jul 2025 21:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="Q03P0n2o"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00941E501C;
	Tue, 15 Jul 2025 21:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752615707; cv=none; b=XDQwXRbBBVfroHsDslLrsijjx4iNEbgpT+s+z0Q8B2XzYCvJQl4pGbV6OVNPOPKgWUD0Nu1b4ptVfKyqEqni9zQne5bJLo5hgQS0X7uIa3ZY/plCsoCc4QniiSzsmlC8xO+8UDw43mXopXYT5gDuaaKa638eeYhA3fmh8UCqna0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752615707; c=relaxed/simple;
	bh=M5Ift1v+ZUimD/YMalh9viwpBYAb3l3h2WvSj2rorOI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qRztIMu9rfLp/6hSDEUGGKl+apuiPok9JKro1gx7PdXc8jhxfi78hDLAPH4H9Yfl3ajfIYKTKoFJ68C72Ole34Pd9tC5qtrhXNgSZ9ahFsey4O+L3EmgIHOb0d9NSh15b4OYHP81hQO2fYEFI7k9Dd89mrBFuWt+gzazP9fSdtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=Q03P0n2o; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 369908288591;
	Tue, 15 Jul 2025 16:41:45 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id iqoSxx4Q6xhh; Tue, 15 Jul 2025 16:41:44 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 08C7F82889A8;
	Tue, 15 Jul 2025 16:41:44 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 08C7F82889A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1752615704; bh=BfPy7LRI1toF8ejOsOO47z8yCeMj4a1Fzqorz5zeow8=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=Q03P0n2o8VlU+cE/NLr9MAtxXw8C3RT6dnR3N9S6mgUcihbhkKHAEfyXgoeJrmo0Y
	 wDTwAoMKOtbMpu8gUYTVNl/CLDTxO1g6qfnsEj23480vvOm8/D3I6CmBBM5l6R4avt
	 3BzBCGVcYjZe7OqzbXE1jS0cB62vL00wi5HcEpSI=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cY_b2tvbuzuc; Tue, 15 Jul 2025 16:41:43 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id AA4C68288591;
	Tue, 15 Jul 2025 16:41:43 -0500 (CDT)
Date: Tue, 15 Jul 2025 16:41:43 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Timothy Pearson <tpearson@raptorengineering.com>, 
	Krishna Kumar <krishnak@linux.ibm.com>, 
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
Message-ID: <493196553.1359869.1752615703480.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <20250711210510.GA2306333@bhelgaas>
References: <20250711210510.GA2306333@bhelgaas>
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
Thread-Index: 6SooTqQCeyH1hYIIUbItUL7oFqMqzA==

Apologies for that, I had meant to send v3 in and apparently it got dropped=
.  I believe I have addressed the comments in the v3 I just sent in.

Thank you!

----- Original Message -----
> From: "Bjorn Helgaas" <helgaas@kernel.org>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "Krishna Kumar" <krishnak@linux.ibm.com>, "linuxppc-dev" <linuxppc-de=
v@lists.ozlabs.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>, "linux-pci" <linux-pci@vger.kernel.org>, =
"Madhavan Srinivasan" <maddy@linux.ibm.com>,
> "Michael Ellerman" <mpe@ellerman.id.au>, "christophe leroy" <christophe.l=
eroy@csgroup.eu>, "Naveen N Rao"
> <naveen@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Shawn Anasta=
sio" <sanastasio@raptorengineering.com>,
> "Lukas Wunner" <lukas@wunner.de>
> Sent: Friday, July 11, 2025 4:05:10 PM
> Subject: Re: [PATCH v2 6/6] pci/hotplug/pnv_php: Enable third attention i=
ndicator

> On Fri, Jul 11, 2025 at 01:18:07PM -0500, Timothy Pearson wrote:
>> ----- Original Message -----
>> > From: "Krishna Kumar" <krishnak@linux.ibm.com>
>> > To: "Bjorn Helgaas" <helgaas@kernel.org>, "Timothy Pearson"
>> > <tpearson@raptorengineering.com>
>> > Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel"
>> > <linux-kernel@vger.kernel.org>, "linux-pci"
>> > <linux-pci@vger.kernel.org>, "Madhavan Srinivasan" <maddy@linux.ibm.co=
m>,
>> > "Michael Ellerman" <mpe@ellerman.id.au>,
>> > "christophe leroy" <christophe.leroy@csgroup.eu>, "Naveen N Rao"
>> > <naveen@kernel.org>, "Bjorn Helgaas"
>> > <bhelgaas@google.com>, "Shawn Anastasio" <sanastasio@raptorengineering=
.com>,
>> > "Lukas Wunner" <lukas@wunner.de>
>> > Sent: Monday, July 7, 2025 3:01:00 AM
>> > Subject: Re: [PATCH v2 6/6] pci/hotplug/pnv_php: Enable third attentio=
n
>> > indicator
>>=20
>> > Thanks all for the review and Thanks a bunch to Timothy for fixing the=
 PE Freeze
>> > issue. The hotplug issues are like you fix N issue and N+1 th issue wi=
ll come
>> > with new HW.
>> >=20
>> > We had a meeting of around 1.5 -2.0 hr with demo, code review and log =
review and
>> > we decided to let these fixes go ahead. I am consolidating what we dis=
cussed -
>> >=20
>> >=20
>> > 1. Let these fixes go ahead as it solves wider and much needed custome=
r issue
>> > and its urgently needed for time being. We have verified in live demo =
that
>> > nothing is broken from legacy flow and
>> >=20
>> > PE/PHB freeze, race condition, hung, oops etc has been solved correctl=
y.
>> > Basically it fixes below issues -
>> >=20
>> > root-port(phb) -> switch(having4 port)--> 2 nvme devices
>> >=20
>> > 1st case - only removal of EP-nvme device (surprise hotplug disables m=
si at root
>> > port), soft removal may work
>> > 2nd case=C2=A0 - If we remove switch itself (surprise hotplug disable =
msi at root
>> > port) .
>>=20
>> Just a quick follow up to see if anything else is needed from my end
>> before this merge can occur?
>=20
> I was waiting for a v3 to fix at least these:
>=20
>  - Subject line style matching history in drivers/pci/hotplug/ (use
>    "git log --oneline" to see it)
>=20
>  - Broken subject line wrapping into commit log
>=20
>  - Spelling fixes
>=20
>  - Comment reformat to match prevailing style
>=20
>  - Note attention indicator behavior changes in commit log
>=20
>  - Some minor refactoring
>=20
> Basically everything mentioned in the responses to the original
> posting.  Or was there a v3 that I missed?
>=20
> Bjorn

