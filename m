Return-Path: <linux-pci+bounces-42579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1A4C9F782
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 16:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA9173007952
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 15:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C7B309DC0;
	Wed,  3 Dec 2025 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="QZq1Gg/b"
X-Original-To: linux-pci@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E87305067;
	Wed,  3 Dec 2025 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764775617; cv=none; b=Rf1tP5N7fk6P9RQvJXxndM+gRhczgUKnuINtAjDWvP72xeh/KrbIoPJmgGX+oQ7Ith4svQQCZYzuh5q2VlRtIyCYfnvG3GQjB/RUgpnUuLuQiSv88WfTQVv8WC9u+1xwFJyRa3qYxzO7Arz3+ctGii6xTYRb5XmLpm2sCojaR+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764775617; c=relaxed/simple;
	bh=s9C8KEZYYv+bwqtZSrusUWhXtVcOHgDYqWCHJxDbuWc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LnBMXxFb3xg/B8okDDUrlSpsdCAq29RyfymAJVfaPY7EGvt86/mMKM+P2ULdr3SOj7RHQdIZ5Lxb3Z0LsDcIUQRe3xnumFVDjuR2wBPSFJmB+0X3AMvY6qvQoQeExuAJuS+8LVnWfLV78SMGyi7pn/uh32IJSpq55CQKUW73iUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=QZq1Gg/b; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To
	:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZSBcUziqxb7/UOVacmX2QzBWF8wVwdTGLPRp+JrOlhA=; b=QZq1Gg/bAxrCSu6cjXCF9FwTsi
	f3rMPEBqYVODvLTHM9Eh9HW7V4LUoj047TcMs17zSxLtNoDr4SXN0mVLu1t3tMhWwJtWAAohg+e1D
	NkMjOiV0qnE6P6It9kI+1dFDDJQsDP2ZBRXJaeJzEoTf2rl0ALI6DU6hk5eE/HpAvpNQ1yhVe1NCO
	c2yr7AzyixlRzjsHZrTeNwnobGNHAOc+FS1xEwCAeLL8posc/f5119LQFiJi7uwFSgifEkAB8WTez
	QB9eePNbS1qBW6Hgk+OD9NIlsFbgkyWdBn/Ga9vRUZH6In6vEB91RM703jgOOLiVZHXrVgVPifgSj
	ExK0Dwaw==;
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] PCI: Fix PCI bridges not to go to D3Hot on older RISC
 systems
From: =?utf-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
In-Reply-To: <CAJZ5v0ighf93oi7peW7jRf4XsvBQe3ryLcnFqkL7aWN5TmBqsw@mail.gmail.com>
Date: Wed, 3 Dec 2025 16:26:50 +0100
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 Brian Norris <briannorris@chromium.org>,
 Bjorn Helgaas <helgaas@kernel.org>,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Riccardo Mottola <riccardo.mottola@libero.it>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A6C6B078-16D7-4BBB-8E9C-3F599EADF84C@exactco.de>
References: <20251202.174007.745614442598214100.rene@exactco.de>
 <20251202172837.GA3078292@bhelgaas> <aS9f-K_MN0uYUCYx@google.com>
 <aS_BYeSApI2XuPcD@wunner.de> <20251203142743.GD2580184@black.igk.intel.com>
 <E5E42CF4-7D6B-4081-AD59-CAC09FCB1890@exactco.de>
 <CAJZ5v0ighf93oi7peW7jRf4XsvBQe3ryLcnFqkL7aWN5TmBqsw@mail.gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

Hi,

> On 3. Dec 2025, at 16:22, Rafael J. Wysocki <rafael@kernel.org> wrote:
>=20
> On Wed, Dec 3, 2025 at 3:48=E2=80=AFPM Ren=C3=A9 Rebe =
<rene@exactco.de> wrote:
>>=20
>> Hi,
>>=20
>>> On 3. Dec 2025, at 15:27, Mika Westerberg =
<mika.westerberg@linux.intel.com> wrote:
>>=20
>> =E2=80=A6
>>=20
>>>> A Thunderbolt controller exposes a PCIe switch.  Daisy-chained
>>>> Thunderbolt devices are thus visible to the OS as nested switches.
>>>> If we followed the approach you're suggesting, users would have to
>>>> manually allow runtime PM on every Switch Upstream and Downstream =
Port
>>>> as well as the Root Port and they'd have to do that upon =
hotplugging
>>>> a device.  Yes, yes, users could add a udev rule to allow runtime =
PM
>>>> automatically by default, but that's exactly the policy we have =
hardcoded
>>>> in the kernel right now, so why the change?
>>>>=20
>>>> I expect massive power regressions for users (not least Chromebook
>>>> users) if we made that change.
>>>>=20
>>>> The discrete Thunderbolt controller in my machine consumes 1.5W
>>>> when nothing is attached.  Some laptops have multiple of these.
>>>> Recent CPUs with integrated Thunderbolt/USB4 may fail to transition
>>>> the package to a low power state unless the Thunderbolt ports go
>>>> to D3hot.
>>>>=20
>>>> So I don't think this approach is a viable option.
>>>=20
>>> I agree.  If this is limited to some older RISC machines (based on =
the
>>> $subject) perhaps this could be solved by adding udev rules to block
>>> runtime PM on those certain ports?
>>=20
>> Let=E2=80=99s not overcomplicate it for now. All we have are a couple =
of old Unix
>> RISC workstations. Let=E2=80=99s see if we can somehow fix them for =
real first.
>>=20
>> Given the feedback that D3Hot =E2=80=9Cshould=E2=80=9D more often =
work I went ahead
>> and changed the patch in T2/Linux removing the 2015 check and all =
arch
>> except SPARC and let our prosumer enthusiast users find out if =
something
>> else breaks first to gather more data points.
>>=20
>> I=E2=80=99ll try to find time to debug the SPARC64 Sun Blade 1K =
issue, but I have
>> some other TODO first, so it might be January for more work on that.
>>=20
>> Maybe we should push a patch to only disable this for SPARC64 to =
stable
>> In the meantime?
>>=20
>> =
https://svn.exactcode.de/t2/trunk/package/kernel/linux/hotfix-legacy-pci-b=
ridge-d3.patch
>>=20
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 2b53219fda3b..869d204a70a3 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3067,10 +3067,9 @@ bool pci_bridge_d3_possible(struct pci_dev =
*bridge)
>>                        return false;
>>=20
>>                /*
>> -                * Out of caution, we only allow PCIe ports from 2015 =
or newer
>> -                * into D3 on x86.
>> +                * It should be safe to put PCIe ports to D3.
>>                 */
>> -               if (!IS_ENABLED(CONFIG_X86) || dmi_get_bios_year() >=3D=
 2015)
>> +               if (!IS_ENABLED(CONFIG_SPARC64))
>>                        return true;
>>                break;
>>        }
>=20
> I would prefer
>=20
> if ((IS_ENABLED(CONFIG_X86) && dmi_get_bios_year() >=3D 2015) ||
> !IS_ENABLED(CONFIG_SPARC64))
>         return true;

Sorry for any confusion, I did not mean the above for upstream, but as I
tried to express for us downstream in T2 to gather more data (if any) =
from
our users for for pre 2015 x86 machines.

Should I send your proposal which matches mine for stable in the
meantime?

	Ren=C3=A9

--=20
https://exactco.de =E2=80=A2 https://t2linux.com =E2=80=A2 =
https://patreon.com/renerebe


