Return-Path: <linux-pci+bounces-30273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C6FAE2050
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 18:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935824A84B7
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 16:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DAF1E376E;
	Fri, 20 Jun 2025 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="RVqmFiu4"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70FA136988;
	Fri, 20 Jun 2025 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750437957; cv=none; b=XY6aVcoqWbMFRr2KEF+B9mgMzbUm+ZD27/aZgD9G+gAzKZS/p81onsU6i07dx2sLlksr0Cu6slMAQj2qCj/XlyK2TkOmG5LfpCJIphomKXzYnr6V3lcYqo9hs0o/tKI9qwR2oB2FgVI9W+T6UKcMJl1Ui0cifEu5cKNv83LgDmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750437957; c=relaxed/simple;
	bh=N68bI8SGJJ3SKPEabsdfy1Rw9X1WhzHFwhJV+Ya/LrU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fWG3FDZFkmd0FZTAqH39o1Fdu7VfyOL7eAyljX0rlBx7YAPRUPCTfIWS2KFS8YA6NcczfVDN8ioufXbNozrMWTpHTPDH/HiJCo/8pE1VY0U2CFDK4TNde3t/9UsAzyBAWF0wdLRr9onvr0IEtR4ak5x290y/Pyktyr+XDtN9K4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=RVqmFiu4; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 569668287484;
	Fri, 20 Jun 2025 11:45:50 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id wRjCNNNSGv1c; Fri, 20 Jun 2025 11:45:48 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 1CC8882883EB;
	Fri, 20 Jun 2025 11:45:48 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 1CC8882883EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1750437948; bh=qJI9vRVPG2JtxMF1nFpr43wzk4hpyWTFMAH0t4tQyfM=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=RVqmFiu4MxhddEf8TwOlqyM0KJG2onnFK2cigc4HlrrrTnigMsR14cDLSL/hK0Eni
	 MfdIYXLgpRCGLtrej9K0rpBfcns97K6O5zGp0t6StTDjXy1dHTjW8j7Pt9DRjm9S7V
	 1ZtkaUFez4tjhpcTeHtNI0pIDfIY+MIiaMVryOOs=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xyFpQtmjQd2c; Fri, 20 Jun 2025 11:45:47 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id BAEC08287484;
	Fri, 20 Jun 2025 11:45:47 -0500 (CDT)
Date: Fri, 20 Jun 2025 11:45:45 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	christophe leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Shawn Anastasio <sanastasio@raptorengineering.com>
Message-ID: <318974284.1316210.1750437945118.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <aFUTV87SMdpHRbt8@wunner.de>
References: <20250618201722.GA1220739@bhelgaas> <1155677312.1313623.1750361373491.JavaMail.zimbra@raptorengineeringinc.com> <aFUTV87SMdpHRbt8@wunner.de>
Subject: Re: [PATCH v2 2/6] pci/hotplug/pnv_php: Work around switches with
 broken
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC137 (Linux)/8.5.0_GA_3042)
Thread-Topic: pci/hotplug/pnv_php: Work around switches with broken
Thread-Index: zvrBWMc7bGiakDybKycWMKCNibeoAQ==



----- Original Message -----
> From: "Lukas Wunner" <lukas@wunner.de>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "Bjorn Helgaas" <helgaas@kernel.org>, "linuxppc-dev" <linuxppc-dev@li=
sts.ozlabs.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>, "linux-pci" <linux-pci@vger.kernel.org>, =
"Madhavan Srinivasan" <maddy@linux.ibm.com>,
> "Michael Ellerman" <mpe@ellerman.id.au>, "christophe leroy" <christophe.l=
eroy@csgroup.eu>, "Naveen N Rao"
> <naveen@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Shawn Anasta=
sio" <sanastasio@raptorengineering.com>
> Sent: Friday, June 20, 2025 2:52:55 AM
> Subject: Re: [PATCH v2 2/6] pci/hotplug/pnv_php: Work around switches wit=
h broken

> On Thu, Jun 19, 2025 at 02:29:33PM -0500, Timothy Pearson wrote:
>> To be perfectly frank the existing code quality in this driver
>> (and the associated EEH driver) is not the best, and it's been
>> a frustrating experience trying to hack it into semi-stable
>> operation.
>>=20
>> I would vastly prefer to rewrite / integrate into the pciehp driver,
>> and we have plans to do so, but that will take an unacceptable amount
>> of time vs. trying to fix up the existing driver as a stopgap.
>>=20
>> As you mentioned, pciehp already has this fix, so we just have to
>> deal with the duplicated code until we (Raptor) figures out how to
>> merge PowerNV support into pciehp.
>=20
> I don't know how much PCIe hotplug on PowerNV differs from native,
> spec-compliant PCIe hotplug.  If the differences are vast (and I
> get the feeling they might be if I read terms like "PHB" and
> "EEH unfreeze", which sound completely foreign to me), it might
> be easier to refactor pnv_php.c and copy patterns or code from
> pciehp, than to integrate the functionality from pnv_php.c into
> pciehp.

The differences at the root level (PHB) are quite significant -- the contro=
ller is more advanced in many ways than standard PCIe root complexes [1] --=
 and those differences need very special handling.  Once we are looking at =
devices downstream of the root complex, standard PCIe hotplug and AER speci=
fications apply, so we're in a strange spot of really wanting to use pciehp=
 (to handle all nested downstream bridges), but pciehp still needs to under=
stand how to deal with our unqiue root complex.

One idea I had was to use the existing modularity of pciehp's source and ad=
d a new pciehp_powernv.c file with all of our root complex handling methods=
.  We could then #ifdef swap the assocated root complex calls to that exter=
nal file when compiled in PowerNV mode.

> pciehp does carry some historic baggage of its own (such as poll mode),
> which you may not want to deal with on PowerNV.

At the root level we probably don't care about polling mode, but in terms o=
f nested downtream bridges polling may still be desireable.  I don't have a=
 strong opinion either way.

> One thing I don't quite understand is, it sounds like you've
> attached a PCIe switch to a Root Port and the hotplug ports
> are on the PCIe switch.  Aren't those hotplug ports just
> bog-standard ones that can be driven by pciehp?  My expectation
> would have been that a PowerNV-specific hotplug driver would
> only be necessary for hotplug-capable Root Ports.

That's the problem -- the pciehp driver assumes x86 root ports, and the pow=
ernv driver ends up duplicating (badly) parts of the pciehp functionality f=
or downstream bridges.  That's one reason I'd like to abstract the root por=
t handling in pciehp and eventually move the PowerNV root port handling int=
o that module.

> Thanks,
>=20
> Lukas

[1] Among other interesting differences, it is both capable of and has been=
 tested to properly block and report all invalid accesses from a PCIe devic=
e to system memory.  This breaks assumptions in many PCIe device drivers, b=
ut is also a significant security advantage.  EEH freeze is effectively thi=
s security mechanism kicking in -- on detecting an invalid access, the PHB =
itself will block the access and put the PE into a frozen state where no PC=
Ie traffic is permitted.  It simultaneously rases an error to the host (col=
loquially referred to as EEH) and punts the decision making on whether to r=
eset or resume the device to the kernel itself.  We've caught various cards=
 doing fun things like reading host RAM or trying to write to 0x0 via this =
mechanism, one of the most egregious was a Chinese telecom card that appare=
ntly tries to reset the host with a write to low memory on detecting an int=
errupt servicing delay (!).

