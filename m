Return-Path: <linux-pci+bounces-19094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3829FE783
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 16:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D84718826AF
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 15:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7861AA1D0;
	Mon, 30 Dec 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="GjjHRQhU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01826195
	for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735571845; cv=none; b=oKkwHwwG9pHoero/qam2cTOz5TBDWJ5hXuSItHxfaKEMOWT7WFs0lg9oqsKmvY7ItHhBw99WANe9qf5f/7FB8W7j57FYkyRK4XOp+lcl4PM1zM3QzAIyxnJUqHsgO0xJ72BrRxQzE8TxWUmw3hqcCgEOLdmp87mXkTIrlYFcSfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735571845; c=relaxed/simple;
	bh=HAQA/Enav3SavCmKWeG/KR74QlUe7Zfsv6ZliGy5vmA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UOQkluS+Mq3VwxI4JNhtFPWvCZEQ1KbAbfRjcsGcUrJp1nMeFwVXZCTn1rZZUkOsJuV0XKWrRUGMrRedGnBgXhvr2A6oaUlPxzzCExzio/mqvZhWxu4TZEnv+0XJO6qN/iLdl2qiyEHVfqJ7m3NPivPkwCUnnPeOf78jL7TLFaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=GjjHRQhU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-215770613dbso87871365ad.2
        for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 07:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1735571842; x=1736176642; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/G3POGFafGG1+bjxG34MCpil78PS4641U5Pxi3q+JQ=;
        b=GjjHRQhU5ZjFuq1loR/06fnHvytwdRFVGS40MCUS7dJ+A6Sr6WqV5T5X13yec+ehnc
         vtQAxavTFqIyOlpfzbQWd9+SC0UfuoHF5NLZLc5qbQCcrry73o2UgiT9btEXhqsj6FHh
         nFhahYX6JLEo+DRq43HXrLM7YavcuCtmzttTLvaZ9FD5/alkYFOrdZyIgufDuFI59sV7
         oqFB6gNlB8v+r5/cWIluETEpUyVkjfCkxDV89dlf6MnKfs0UMHDarUNbLFnQC9Wwn4jS
         kDM15h4iMZDrlKP6YpYE+cGgiPtBCucGpOhq7RkIWQ7nJBwy7/Go3TZl4Th7xDejktmx
         NWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735571842; x=1736176642;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/G3POGFafGG1+bjxG34MCpil78PS4641U5Pxi3q+JQ=;
        b=EtabrAtYnMKMbeNCgEi/2b+g7mcHTf35prAto43YkbNP70R44Bh8ddRZVMTqofa0FX
         tDMYwcW+SuZVNLEjT3l8DBrQrHgn3/bE7jnPo2fZo6plsooGJtsj6ZyeCEY/HoFQ5IOx
         gMT9lTcZOpsjkZKjOYlNOerzlSLtC9vUWMje+juY4Ql8mgixg1+QnArT3Rj7EZb6ROH0
         jRsdYKazgWqKfX9l/Wv5CzdY2xiisJ3g/Xn7/qSuXg4NqzkF7jaa/ccW4xIr4umCs6W1
         v46AO9A4voCeXhIedxVXBEZRAgLvTf+gMoz2L6EBt0LQI51fcG6FN5uCv5MJCtcUyOY1
         JInQ==
X-Forwarded-Encrypted: i=1; AJvYcCW68N8qgsrB288+f9z5kvjp6cZ+KqB3tNRB5CvrHC4ycWrS2fsphbRYlwSCVwLghx1SZ6l7Ru5U31M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgsZDXNocnq+NYQb49B4gbsV0HXH4Ak026/1p7AU8PiiXD0kKX
	ZHcVd97IfSuT/TLOVRNYMtq4h6CK5Dx1IXFeSIWu2/K9qJRVtRpPs5uv+Nqj4A==
X-Gm-Gg: ASbGncvpDT7dbPBWEHUtQmUeu6kv6dFyrxBHdsAhaEPOTyYXufmmF9xrY2MRDLlSMZz
	dtcMSoDWvanaGXca1o3G55oCGjTXmCNWKmPYgEmfJBOsu1mxZQCsBgJOlG/DSeM8v18SIkDYyeK
	XcGRk/am0fG/8gbGONfzN1TRugFm+QbCLEE9qJ025ZFkw2Jd+YR+PuDH59a3VUyHmseQuyMr8cq
	caPD1Nhg7PmNBuS5JjJlpUOgebQ23F8U2qx1EPqZCUYVWKg2oqwIb+AI6wS06tG31aTFNV8o8PD
	CkOe+Cf9qSVHUyzu1fs3Unei
X-Google-Smtp-Source: AGHT+IH+GOsSDVjQzS2seAWPLhbKwZlxnBLaMVe2X715y0bfN9Kh1SNDP35pmzOIbbKPOYVQW1uKPA==
X-Received: by 2002:a05:6a20:6a25:b0:1d9:6c9c:75ea with SMTP id adf61e73a8af0-1e5e0448930mr56405023637.5.1735571841193;
        Mon, 30 Dec 2024 07:17:21 -0800 (PST)
Received: from smtpclient.apple (76-10-188-40.dsl.teksavvy.com. [76.10.188.40])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-8c3a45926e5sm8408662a12.61.2024.12.30.07.17.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2024 07:17:20 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH 0/1] PCI/ASPM: Fix UAF by disabling ASPM for link when
 child function is removed
From: Daniel Stodden <dns@arista.com>
In-Reply-To: <ddd7bf5e-9580-4ea1-a2fe-bd4fb689f6fb@sangfor.com.cn>
Date: Mon, 30 Dec 2024 07:17:07 -0800
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 david.e.box@linux.intel.com,
 kai.heng.feng@canonical.com,
 linux-pci@vger.kernel.org,
 michael.a.bottini@linux.intel.com,
 qinzongquan@sangfor.com.cn,
 rajatja@google.com,
 refactormyself@gmail.com,
 sathyanarayanan.kuppuswamy@linux.intel.com,
 vidyas@nvidia.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <EB81AFE1-E054-4316-980A-ACBA7AE849A9@arista.com>
References: <20230507034057.20970-1-dinghui@sangfor.com.cn>
 <cover.1734924854.git.dns@arista.com>
 <ddd7bf5e-9580-4ea1-a2fe-bd4fb689f6fb@sangfor.com.cn>
To: Ding Hui <dinghui@sangfor.com.cn>
X-Mailer: Apple Mail (2.3826.300.87.4.3)


Hi!



> On Dec 27, 2024, at 9:00=E2=80=AFPM, Ding Hui <dinghui@sangfor.com.cn> =
wrote:
>=20
> Sorry for late reply.


No problem at all.
Wasn=E2=80=99t really expecting to make much of a wave when when sending =
this out a day before the holidays.

Thanks for picking it up!

> Thanks for pointing out the release order issue that I indeed =
overlooked.
>=20
> I'm not an expert in PCI, so I'm not sure if there's a similar PCI =
topology like this:
>=20
> [00]-+..
>     |
>     +--03.0-[01-03]--+-00.0  Endpoint
>                      +-00.1-[02-03]--+-02.0-[02]--x
>                                      \-0d.0-[03]----00.0  Endpoint
>=20
> If this is possible, I think that even after applying your patch, =
removing 01:00.0
> individually by
>  echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove
> maybe still lead to a Use-After-Free when =
pcie_aspm_exit_link_state(<02:02.0>).

Now, my main problem is that I=E2=80=99m not super familiar with ASPM =
details.
But let=E2=80=99s start from what PCIe has. And I=E2=80=99m just =
assuming that ASPM does not apply outside PCI Express.

(It=E2=80=99s called drivers/pci/pcie/aspm.c after all. And =
pcie_aspm_sanity_check appears to agree with me (?))

Outside of legacy support, the main PCIe devices are root complex, =
switches, and (PCIe) endpoints  (spec: "PCI Express Fabric Topology=E2=80=9D=
)

These in turn yield 4 essential PCIe types of _functions_: root ports, =
switch upstream ports, switch downstream ports, and endpoints.

All except endpoints are represented as virtual PCI-to-PCI bridges in =
the conventional PCI.

In your diagram, 00:03.0 is a bridge representing a root port of the =
root complex.
Bus 01 is a link.

To have more bridges, 01:* must be on the upstream port of a switch. =
That switch has a bridge on the upstream port, with the secondary bus =
being a virtual one representing the fabric connecting downstream ports, =
internal to it.

Now here the rub: the spec says that upstream port is represented by a =
bridge.
I wish I could just quote the spec also saying that that bridge is =
function 0 the bus representing the link upstream.

(Or, given how the aspm.c code works, at least some function 0).

But I think it doesn=E2=80=99t.

Now here is the practical side: I know about 3-4 switch families at the =
moment.=20
Broadcom/PEX, Diodes/Pericom, Microchip/Switchtec) and ASMedia.

 1. All model the bridge as :00.0. "Function 0=E2=80=9D.

 2. At least two of them (PEX, Switchtec) have additional functions as =
endpoints. For DMA, management, and/or NTB support.
   They=E2=80=99re at 00:{1..}. Your change broke PCIe hotplug for both =
of them. (But this is not a rant, just saying what it is.)

 3. Those sibling functions on the upstream port are very common.
   This is also because the PCIe spec is very specific about _not_ =
having anything but downstream ports, i.e. bridges,
    on the internal bus. Well, they have to go somewhere.

This is why the old code worked for so long, and why I think my patch at =
least works in practice.

So, to answer your questions: it=E2=80=99s not in the spec at a spot I =
can point at.  But no PCIe device I know about makes 01:00.0 and =
endpoint *and* 01:00.1 a bridge at the same time. Plenty of them the =
other way around.

Contrast this with what I=E2=80=99m gathering from aspm.c

 - The driver is following *link* topology. Not so much function =
topology.
 - Function 0 appears to be assumed to be the main downstream =
representative of the device for power management purposes.
   I did not find this in the ASPM spec (maybe to a fault), but plenty =
other sections in PCIe go similar ways. So this isn=E2=80=99t =
surprising.
 - I does, however, not explictly state that function 0 is also the =
bridge.

Now, the overall PCI layer is working on bridges and buses, not links. =
And so, removal, whether it=E2=80=99s coming from link state or sysfs, =
is following bridges and buses.

 - As long as function 0 is the bridge, the current code works.
 - If there is some PCIe switch where link->downstream is not the =
bridge, it breaks again.

One could go further in sanity checking. E.g. enforce that if function 0 =
is an endpoint, there are no subordinate links.

I=E2=80=99d be willing to add more sanity checks. But the only real idea =
I have to offer would warrant a separate patch, and it=E2=80=99s at the =
end of this mail.

> Additionally, Bjorn Helgaas also expects compliance with the PCIe =
specification r6.0,
> section 7.5.3.7, which recommends that software programs the same ASPM =
Control value
> across all functions of multi-function devices.

Yep. And I don=E2=80=99t disagree (although I=E2=80=99m not familar =
enough to be as decided about it.)

However, I deleted your comment regarding that. Didn=E2=80=99t mean to =
offend. My argument went roughly as follows:=20

 - Whether we program all functions is not up to =
pcie_aspm_exit_link_state().
 - It=E2=80=99s up to pcie_config_aspm_link(), called by =
pcie_aspm_exit_link_state().
 - That=E2=80=99s already happening, and apparently commented on =
accordingly,.
   Above pcie_config_aspm_dev().

The spot you edited just didn=E2=80=99t have much to add or remove =
there, afaict.=20

> Therefore, should we recursively release the link_state of child =
devices before
> the current device in pcie_aspm_exit_link_state()?

No.=20

.. if I may offer an opinion here. :)

 Beware, I=E2=80=99m not a maintiner. Just having opinions.

The PCI layer is already taking care of it. The link state removal now =
follows the bus removal.

 (Well, as long as that function-0-is-the-upstream-bridge assumption =
isn=E2=80=99t broken.)

The bus removal (pci/remove.c) is happening recursively already. So the =
link state removal now happens
in the depth first order you=E2=80=99re envisioning. =46rom that POV, =
it=E2=80=99s okay.

So why are we worried?

I think I=E2=80=99ve seen people mention that the link_state contents =
could go into the pci_dev, earlier on this thread?
I don=E2=80=99t think not having a separate allocation is the problem =
either. Having the separate struct per se isn=E2=80=99t wrong.

Still, we=E2=80=99re worried for a reason.

The problem with the remaining aspm.c code, if there is any, is not that =
it=E2=80=99s not doing enough already.
It=E2=80=99s doing way, way too much. That=E2=80=99s how you ended up on =
this list, and that=E2=80=99s what brought me here.

That pcie_link_state is currently not only carrying ASPM attributes. =
It=E2=80=99s replicating the conventional PCI topology.
With those {downstream, root, parent) pointers. And once you have that, =
you=E2=80=99re either inconsistent, and crash, or =E2=80=9Conly" =
redundant.

I think if one wanted to improvie things further, it might be as basic =
as getting rid of those pointers between the links.
Then go by PCIe function types instead (root port, upstrea, downstream, =
endpoint). But follow the bus topology, not custom pointers.

(But it=E2=80=99s not like I tried yet.)

Daniel

> --=20
> Thanks,
> -dinghui
>=20
> On 2024/12/23 11:39, Daniel Stodden wrote:
>> About change 456d8aa37d0f "PCI/ASPM: Disable ASPM on MFD function
>> removal to avoid use-after-free")
>> Let's say root port 00:03.0 was connected to a PCIe switch.
>>       [00]-+..
>>      |
>>      +--03.0-[01-03]--+-00.0-[02-03]--+-02.0-[02]--x
>>      |                |               \-0d.0-[03]----00.0  Endpoint
>>      .                +-00.1  Upstream Port Sibling
>> And that switch had not only an upstream port at 01:00.0, but also a
>> sibling function at 01:00.1.
>> Let's break the link under 00:03.0, which makes pciehp remove the =
[01]
>> bus. Surprise effect: traversal during bus [01] device removal =
happens
>> in reverse order (for SR-IOV-ish reasons, see pciehp_pci.c
>> commentary). Fair enough, ASPM should probably not rely on any
>> specific order anyway.
>> Recursing through pci_remove_bus_device() underneath, the order in
>> which we pci_destroy_dev() will be:
>>    [ 01:00.1 [ 02:02.0 [ 03:00.0 ] 02:0d.0 ] 01:00.0 ]
>> Trivially, the above is also the order in which
>> pcie_aspm_exit_link_state() will be called.
>> Then note how, since above change removed the list_empty() exit
>> condition, we are now going to remove the pcie_link_state for bus =
[01]
>> (parent=3D<00:03.0>) during the first invocation, i.e. right at
>> pcie_aspm_exit_link_state(<01:00.1>).
>> Iow: with bus [03] removal only to come, we removed the
>> pcie_link_state upstream first, and only then will remove the
>> downstream pcie_link_state at parent=3D<02:0d.0>.
>> Eventually reaching that second link, it carries a ref "parent_link =3D=

>> link->parent" which now points to free'd memory again. One can =
observe
>> a rather high probability of finishing with a random GPF or nullptr
>> dereference condition.
>> > Above switches, with MFD upstream portions, exist. Case at hand is =
a
>> PEX8717 with 4 DMA engines:
>>   +-08.0-[51-5b]--+-00.0-[52-5b]--+-02.0-[53]--
>>                   |               \-0d.0-[54-5b]----00.0  Broadcom =
Inc. =E2=80=A6
>>                   +-00.1  PLX Technology, Inc. PEX PCI Express Switch =
DMA interface
>>                   +-00.2  PLX Technology, Inc. PEX PCI Express Switch =
DMA interface
>>                   +-00.3  PLX Technology, Inc. PEX PCI Express Switch =
DMA interface
>>                   \-00.4  PLX Technology, Inc. PEX PCI Express Switch =
DMA interface
>> Backtrace:
>> [  790.817077] BUG: kernel NULL pointer dereference, address: =
00000000000000a0
>> [  790.900514] #PF: supervisor read access in kernel mode
>> [  790.962081] #PF: error_code(0x0000) - not-present page
>> [  791.023641] PGD 8000000104648067 P4D 8000000104648067 PUD =
1404bc067 PMD 0
>> [  791.106041] Oops: 0000 [#1] PREEMPT SMP PTI
>> [  791.156151] CPU: 8 PID: 145 Comm: irq/43-pciehp Tainted: G         =
  OE      6.1.0-22-2-amd64 #5  Debian 6.1.94-1
>> [  791.279173] Hardware name: Intel Camelback Mountain CRB/Camelback =
Mountain CRB, BIOS Aboot-norcal7-7.1.6-generic-22971530 06/30/2021
>> [  791.421982] RIP: 0010:pcie_config_aspm_link+0x48/0x330
>> [  791.483548] Code: 48 8b 04 25 28 00 00 00 48 89 44 24 30 31 c0 8b =
47 30 4c 8b 47 08 83 e3 7f c1 e8 0e f7 d3 89 c2 83 e0 7f 21 c3 83 e2 7f =
21 f3 <41> 8b b6 a0 00 00 00 89 d8 83 e0 87 f6 c3 04 0f 44 d8 0f b7 47 =
30
>> [  791.708646] RSP: 0018:ffffa8cf8062bcb8 EFLAGS: 00010246
>> [  791.771254] RAX: 0000000000000000 RBX: 0000000000000000 RCX: =
0000000000000000
>> [  791.856772] RDX: 0000000000000000 RSI: 0000000000000000 RDI: =
ffff94bac3d56a80
>> [  791.942291] RBP: ffff94bac3d56a80 R08: 0000000000000000 R09: =
ffffa8cf8062bc6c
>> [  792.027808] R10: 0000000000000000 R11: 0000000000000004 R12: =
ffff94b9c0f61fc0
>> [  792.113326] R13: ffff94bbc0ae9828 R14: 0000000000000000 R15: =
ffff94b9c0ea6f20
>> [  792.198845] FS:  0000000000000000(0000) GS:ffff94c8ffc00000(0000) =
=E2=80=A6
>> [  792.295827] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  792.364680] CR2: 00000000000000a0 CR3: 00000001062fe003 CR4: =
00000000003706e0
>> [  792.450198] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
>> [  792.535717] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
>> [  792.621235] Call Trace:
>> [  792.650506]  <TASK>
>> [  792.675616]  ? __die_body.cold+0x1a/0x1f
>> [  792.722600]  ? page_fault_oops+0xd2/0x2b0
>> [  792.770625]  ? sysvec_apic_timer_interrupt+0xa/0x90
>> [  792.829068]  ? exc_page_fault+0x70/0x170
>> [  792.876051]  ? asm_exc_page_fault+0x22/0x30
>> [  792.926161]  ? pcie_config_aspm_link+0x48/0x330
>> [  792.980437]  pcie_aspm_exit_link_state+0xb9/0x120
>> [  793.036796]  pci_remove_bus_device+0xc8/0x110
>> [  793.088988]  pci_remove_bus_device+0x2e/0x110
>> [  793.141180]  pci_remove_bus_device+0x3e/0x110
>> [  793.193373]  pciehp_unconfigure_device+0x94/0x160
>> [  793.249733]  pciehp_disable_slot+0x69/0x100
>> [  793.299840]  pciehp_handle_presence_or_link_change+0x241/0x350
>> [  793.369742]  pciehp_ist+0x164/0x170
>> [  793.411524]  ? disable_irq_nosync+0x10/0x10
>> [  793.461632]  irq_thread_fn+0x1f/0x60
>> [  793.504449]  irq_thread+0xfa/0x1c0
>> [  793.545185]  ? irq_thread_fn+0x60/0x60
>> [  793.590085]  ? irq_thread_check_affinity+0xf0/0xf0
>> [  793.647485]  kthread+0xda/0x100
>> [  793.685096]  ? kthread_complete_and_exit+0x20/0x20
>> [  793.742495]  ret_from_fork+0x22/0x30
>> [  793.785314]  </TASK>
>> Daniel Stodden (1):
>>   PCI/ASPM: fix link state exit during switch upstream function =
removal.
>>  drivers/pci/pcie/aspm.c | 17 +++++++++--------
>>  1 file changed, 9 insertions(+), 8 deletions(-)
>=20
>=20
>=20


