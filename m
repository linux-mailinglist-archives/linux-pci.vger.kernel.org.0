Return-Path: <linux-pci+bounces-37806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3749EBCD4D2
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 15:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B02CB34296E
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 13:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAE12F0688;
	Fri, 10 Oct 2025 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="QLPDb7Ws"
X-Original-To: linux-pci@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E97D264F96;
	Fri, 10 Oct 2025 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760103525; cv=none; b=luNGd9QrBuI7zbskzdo6hOMw/lfYvYrgI1YDImcU0FIALATViElyhGgl7ig4Ya5O9BxT0nrhS9/9bG6p7eKhMFlFMPHKKJOF3xRA6+3zazFIb6Gj6CjW9+BgS9cap4ARw1BeaAd3lSzu9FnI+wnlHJFRTztVHcjN20zmaHjTqCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760103525; c=relaxed/simple;
	bh=83UN0hzd8CiJbDXtGHGwxtEe48e/VlqBef7rMl8gp/A=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=c9SIuDV5/VqZ5fZbHB03evdNFMXed3b6SeHHfFuSDxzrF9yIW0icGS0NmHuXOsZGhTBLUV4NVlOid9NYV2IKFFjNIBnGV3oaRrLJLOFpTE4y3qoXm9n16rEGAsTqB4NlQN3zQ5hNo2g7q0f+GXoRbpNT58vtEBFRTUpn0TAVAdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=QLPDb7Ws; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1760103508; bh=uFQel1X7R06BLhx08hUll4E03N2/pdCw/fPAx+ksags=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=QLPDb7Wsc3hbrKFVi5KdNEsMU+WANVi4yg62CL3pas38ZWSmxa0b7S5do5iURnNP8
	 zVNGBoZODrQeZqTr0lMvnvqbn/LqcItNONC11DbSfi4wk9ywP5D6q51I20TEu+ndaW
	 TFnfEwm559yR6Nm+RAN8Wp6JN1ZYpe3PvCkiaPz8=
Received: from smtpclient.apple ([2001:268:9a74:5c3a:98e2:c178:7cc:f5cf])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 9992841E; Fri, 10 Oct 2025 21:38:25 +0800
X-QQ-mid: xmsmtpt1760103505t02uujl1q
Message-ID: <tencent_1FBE7C358261DAD78EEEB81A315F21C88D08@qq.com>
X-QQ-XMAILINFO: NGX5+lQVxpC+wEkmodSHDmoT+eLh33LMVdkm5q4XAvIihe/Qg5UGHqvDOcCqXo
	 GL2Eqc3msa1kfH6suF2JxGdowqP5ZME3Xz0DjoUg6I3SeRuHzwIWMJWEe/uZ1D4MzRnPKfUi+qX8
	 B/6gm+Ham0K4/krPagYyC31LUVLqgIGadP1aVeM2O9Xgl/GAusDKhFsCmm+0hhvffIEZq9AeAXeq
	 XbptFR2hLTJUw6m9wEB2YZ4m0AhgfEOGmCkuV5gRYvy8/eGLhB1zWGJQMqKvLKv2p6BNSvrTnPkC
	 DAAkfZ62KzS9/tbOAzCWrIMHKM1AJZnjH49Me0vUcG0kNp0nEZZF+2kaZjYw9BuoMU69p75IyqOn
	 hdxucaFs6PoBr3s/nmjHEPLJA2OOLnntqpXeiC/1dJ3Gn24JChOLQsPPifHgwcpalRpy5KbQDEdL
	 0wXBGz0W5g2iV0LJfptOyOkX9QJgcBU+RaZIDUSE1996lz9uGSJCWr2uyEacqxDjsLnCHf0/MUao
	 Tf9QocRLbZ1p0pUlDBwFWslQkVzD2G9TlGLDSPXUIzT2eNwACvsiDATQK1Yey8fSertythFm+v5J
	 SQmGJF+q+ukZifkYPIslqlrJOomrvexIV1STKIbnUy+eRB0bb8UG9JeQOpU18tZk3pr7JuiqFukj
	 +04KGnE1steHfzZ65uMPK/AIPMb7lg3NNR4UHoxErL9z6CO5G6ztA2Qt3zuSfrBIAESIiTE6G+F9
	 hU/kZSY4DdabqiqkhxdVbLhr/kwCooYyOSSrOs5AN6Hp3yXWM6a/p8tIJ/GDOho10keabyxUyNDX
	 898oocTMFinDeGvZDViVjtr20oekZtdsx5eIO6uW8li3cZCNNxvzb+8Z2l6hgzfBBtlUvmFWsFkH
	 OYYTTTR8tjcqp+VX2HBjYnUNHmeHjwnkbiXHIDtgSZx0a6c2sCo4mLS2f2WYza2TUCOANIdLODMC
	 qcfV1dAhY1dvomMm4Rl91YJ2JWGCFOP8mlZwFafa8VxT/EsVj3Unkqld5MJqIOfM9moHQ599oNpi
	 abxdf/OXJgPgT80CrgFEvt0WERldo=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH -fixes] PCI: Fix regression in
 pci_bus_distribute_available_resources
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <56429ac6-8188-ce6c-eec1-0de7f93e912c@linux.intel.com>
Date: Fri, 10 Oct 2025 22:38:15 +0900
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <FC3D98BB-8D67-48DA-B1C8-F65479F9A442@cyyself.name>
References: <20251008200930.GA638461@bhelgaas>
 <56429ac6-8188-ce6c-eec1-0de7f93e912c@linux.intel.com>
To: =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)



> On 9 Oct 2025, at 20:02, Ilpo J=C3=A4rvinen =
<ilpo.jarvinen@linux.intel.com> wrote:
>=20
> On Wed, 8 Oct 2025, Bjorn Helgaas wrote:
>> On Wed, Oct 08, 2025 at 10:36:52PM +0800, Yangyu Chen wrote:
>>> The refactoring in upstream commit 4292a1e45fd4 ("PCI: Refactor
>>> distributing available memory to use loops") switched
>>> pci_bus_distribute_available_resources to operate on an array of =
bridge
>>> windows. That rewrite accidentally looked up bus resources via
>>> pci_bus_resource_n and then passed those pointers to helper routines
>>> that expect the resource to belong to the device. As soon as we
>>> execute that code, pci_resource_num warned because the resource
>>> wasn't in the bridge's resource array.
>>>=20
>>> This happens on my AMD Strix Halo machine with Thunderbolt device, =
the
>>> error message is shown below:
>>>=20
>>> [    4.212389] ------------[ cut here ]------------
>>> [    4.212391] WARNING: CPU: 6 PID: 272 at drivers/pci/pci.h:471 =
pci_bus_distribute_available_resources+0x6ad/0x6d0
>>> [    4.212400] Modules linked in: raid6_pq(+) hid_generic uas =
usb_storage scsi_mod usbhid hid scsi_common amdgpu amdxcp =
drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm =
drm_exec i2c_algo_bit drm_suballoc_helper drm_display_helper cec rc_core =
drm_client_lib drm_kms_helper sdhci_pci sdhci_uhs2 xhci_pci sp5100_tco =
xhci_hcd r8169 drm nvme sdhci watchdog realtek usbcore thunderbolt cqhci =
atlantic nvme_core mdio_devres psmouse libphy mmc_core nvme_keyring =
video i2c_piix4 macsec nvme_auth serio_raw mdio_bus i2c_smbus usb_common =
crc16 hkdf wmi
>>> [    4.212443] CPU: 6 UID: 0 PID: 272 Comm: irq/33-pciehp Not =
tainted 6.17.0+ #1 PREEMPT(voluntary)
>>> [    4.212447] Hardware name: PELADN YO Series/YO1, BIOS 1.04 =
05/15/2025
>>> [    4.212449] RIP: =
0010:pci_bus_distribute_available_resources+0x6ad/0x6d0
>>> [    4.212453] Code: ff e9 a2 48 c7 c7 b8 b7 83 a3 4c 89 4c 24 18 e8 =
a9 2a fb ff 4c 8b 4c 24 18 e9 ca fd ff ff 48 8b 05 60 53 47 01 e9 94 fe =
ff ff <0f> 0b e9 5d fe ff ff 48 8b 05 55 53 47 01 e9 81 fe ff ff e8 4b =
87
>>> [    4.212455] RSP: 0018:ffffaffcc0d4f9a8 EFLAGS: 00010206
>>> [    4.212458] RAX: 00000000000000cd RBX: ffff9721a687f800 RCX: =
ffff9721a687c828
>>> [    4.212459] RDX: 0000000000000000 RSI: 00000000000000cd RDI: =
ffff97218bc8a3c0
>>> [    4.212461] RBP: ffff9721a687c828 R08: ffffaffcc0d4f9f8 R09: =
0000000000000001
>>> [    4.212462] R10: ffff97218bc8d700 R11: 0000000000000000 R12: =
ffffaffcc0d4f9f8
>>> [    4.212462] R13: ffffaffcc0d4f9f8 R14: 0000000000000000 R15: =
ffff97218bc8a000
>>> [    4.212464] FS:  0000000000000000(0000) GS:ffff973ee1ad9000(0000) =
knlGS:0000000000000000
>>> [    4.212465] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [    4.212467] CR2: 00005640b0f29360 CR3: 0000000ccb224000 CR4: =
0000000000f50ef0
>>> [    4.212469] PKRU: 55555554
>>> [    4.212470] Call Trace:
>>> [    4.212473]  <TASK>
>>> [    4.212478]  pci_bus_distribute_available_resources+0x590/0x6d0
>>> [    4.212483]  pci_bridge_distribute_available_resources+0x62/0xb0
>>> [    4.212487]  pci_assign_unassigned_bridge_resources+0x65/0x1b0
>>> [    4.212490]  pciehp_configure_device+0x92/0x160
>>> [    4.212495]  pciehp_handle_presence_or_link_change+0x1b5/0x350
>>> [    4.212498]  pciehp_ist+0x147/0x1c0
>>> [    4.212502]  irq_thread_fn+0x20/0x60
>>> [    4.212508]  irq_thread+0x1cc/0x360
>>> [    4.212511]  ? __pfx_irq_thread_fn+0x10/0x10
>>> [    4.212515]  ? __pfx_irq_thread_dtor+0x10/0x10
>>> [    4.212518]  ? __pfx_irq_thread+0x10/0x10
>>> [    4.212521]  kthread+0xf9/0x240
>>> [    4.212525]  ? __pfx_kthread+0x10/0x10
>>> [    4.212528]  ret_from_fork+0x195/0x1d0
>>> [    4.212533]  ? __pfx_kthread+0x10/0x10
>>> [    4.212536]  ret_from_fork_asm+0x1a/0x30
>>> [    4.212540]  </TASK>
>>> [    4.212541] ---[ end trace 0000000000000000 ]---
>>>=20
>>> Fix the regression by always fetching the resource directly from the
>>> bridge: use pci_resource_n(bridge, PCI_BRIDGE_RESOURCES + i). This
>>> restores the original behaviour while keeping the refactored =
structure.
>>> And then we can successfully assign resources to the Thunderbolt =
device.
>>>=20
>>> Fixes: 4292a1e45fd4 ("PCI: Refactor distributing available memory to =
use loops")
>>>=20
>>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>>=20
>> Tentatively applied to pci/for-linus for v6.18, pending Ilpo's =
review.
>=20
> Thanks to Yangyu for the patch.=20
>=20
> I see it already was pulled by Linus. No big objection to this as it=20=

> clearly seems to help and should cause no issue to move back to use=20
> pci_resource_n().
>=20
> However, that change to pci_bus_resource_n() was very much done=20
> intentionally as those two calls should have been equivalent. =
Initially
> I was perplexed how this change can fix anything but it seem one of my=20=

> pci_bus_resource_n() conversions was wrong...
>=20
>> Thank you very much for debugging and providing a patch!
>>=20
>>> ---
>>> drivers/pci/setup-bus.c | 5 +++--
>>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>>> index 362ad108794d..4a8735b275e4 100644
>>> --- a/drivers/pci/setup-bus.c
>>> +++ b/drivers/pci/setup-bus.c
>>> @@ -2085,7 +2085,8 @@ static void =
pci_bus_distribute_available_resources(struct pci_bus *bus,
>>> int i;
>>>=20
>>> for (i =3D 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++) {
>>> - struct resource *res =3D pci_bus_resource_n(bus, i);
>>> + struct resource *res =3D
>>> + pci_resource_n(bridge, PCI_BRIDGE_RESOURCES + i);
>=20
> Was this change actually necessary to fix anything or was it changed =
just=20
> due to noticing the other case?

It was changed just to align with the following code.

>=20
>>>=20
>>> available[i] =3D available_in[i];
>>>=20
>>> @@ -2158,7 +2159,7 @@ static void =
pci_bus_distribute_available_resources(struct pci_bus *bus,
>>> continue;
>>>=20
>>> for (i =3D 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++) {
>>> - res =3D pci_bus_resource_n(bus, i);
>>> + res =3D pci_resource_n(dev, PCI_BRIDGE_RESOURCES + i);
>=20
> This was misconverted by me, as dev is not same as bridge here, so it=20=

> should have been pci_bus_resource_n(b, i); (b is dev->subordinate).

Indeed.

I didn't figure out why pci_bus_resource_n fails at the time to
submit the patch. But I just chose the most confident way to fix
that since it breaks mainline.

Thanks,
Yangyu Chen

>=20
> --=20
> i.


