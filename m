Return-Path: <linux-pci+bounces-15945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F599BB43B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 13:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28D21C2029D
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 12:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD881B4F0A;
	Mon,  4 Nov 2024 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="b/lJ1GZY"
X-Original-To: linux-pci@vger.kernel.org
Received: from sonic314-13.consmr.mail.bf2.yahoo.com (sonic314-13.consmr.mail.bf2.yahoo.com [74.6.132.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E20E7C0BE
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722223; cv=none; b=kRHFuS2Wllrb956JoCmTQL+5kLRrOVtPfmagzGp9RnfhbfD7qjhteZeDEtDGSW2ILZZutfSUiIKIMPBGRBXl3bOGyuzLbm5ygmmslWE/Wd4BjzqeiulyzD3CP8p7Ev2U825uAlavSxQQ+2Jf3Go2Y1N/2glnSko0h0NogacJ1xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722223; c=relaxed/simple;
	bh=FldXILWzWY07EtXv/SRtvQpX+GIvMUI6P7kJY2tiWwI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type:
	 References; b=JnGQNr0qBbg6xH9BXx24YwOgCe3nTFpaTPpUuU6pmTNkbYIFOc69vvmhbSTuCXNKwQOu/jFncv8PP2dRqnmT3uwIG+0LPaNZ6TOh1yypxp6gbC/5VYv9gsH9bJoKNgbQkDZGXGYeAX4pvIIBR8NPt2hocGHgpOO23YpmLmuZ2Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=b/lJ1GZY; arc=none smtp.client-ip=74.6.132.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1730722221; bh=xnuu0VNGoKG9cEmMS7zoTpNtBtoXO4IgEf/opEOn014=; h=Date:From:Subject:To:References:From:Subject:Reply-To; b=b/lJ1GZYoTArzpLSIMKE77J0LP0zgFNgs2BLbIFTXzlj+nc/OgK76D5AZC+qKg/VOpaRdJsgkdyrXfr/d2yyj9RlH9cyVPyRbcWe88AYTGPwFqhlQ5AdjRkNz7+hb8snlqr4h+bB36SO9kc1hm/K+AgQYFNz7eg3/0jhxiVa3uL/6+pldqGuFfk1g4AoHIDk54T+t4UBeq/wC0gNJOFrq+6/isBdY9CfhHEMgBgO1EfwcMK8FWICI46UZy6ntRA77yqRkfcHRy8I7rQ4SmRzSDPQ7C23t9rZLIARWKvumzR0MdMJLypvm55s1PhctY4zRu8YIk0SmjY8RqaipXA4mQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1730722221; bh=IbNDMYkm3rESW5ZNiU+UI5gmXW33I4LS41tczgQMqtU=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=tj1R1JNesPd0F0iqu2Xlyzh/ABgLdHvii3Jk2XhESepZDRYUaBzsZ1dmz5kZS7wYi8MHOMgv8eEDwAiaEOWFtEJBilkl6vdCjj0MOQiPR/EAJVWO5NbYxtsnOGDrul4X5S3SpRP0avV57TjauK9fRe4IYLiztSY+dUD5mYP7BxRVhSl+Yc0/aVNcojGB56lfk/zCupetDSA6zPwVoQav3cN8LXyMtuxkrjuZkpY6wkIKdY6Q7KUmS+TNbEs5Jnol6mj7jpeA7Aj9S+mHi4WvGT/5lmnPjyNMlrvFnteC6azZExV0jlT+WjiniDZ99hjsz46Gs4G9l+r4g9vUccxEVg==
X-YMail-OSG: 6C0oxpgVM1mUPJgoBxwJCVkIxTFGGlg7Epfxti4.1iDycDayw5iytxIf.3H5i25
 p3qlBUZqMDmCVxfTnLIgd0IS2Riwey4PwfbfhNPqVmaHIb56DhPFOZaH3_og55FMEq8ZgUyi1wYY
 X6W_rDtHa69GzUDqu_cLe3hUuv342J0us.897CYjRcMdSXEfH_RTQvoGLAGjhlyvH4ASQWel0iYK
 M110mDgW_hTE.vTKXXYm4yaKWKWaDTZMWezVhzVtQYPMfY2pzIdOGiyhL6aOgXipoyZRY_I.8eA2
 ZG9jaxtinki72ZVlzxHOwmjnFYUp0bjHdEJ8LsBUi1_TTpCiCZ4RvLVUB7.r7w4SSDTJvFZ1y_3w
 SHTvc5.21OKeyCe2yToj0A03VkkCsuVwGKm0htn4WbwI7IELKmIj91V8fr2_xnksoBKu8RTLNwF9
 kIStk3aDiPnU7FrjVLUmfg92.6AdoUIbXT0KpPYpzhX_KqK9jVmvXe1KiuZdo8DVc6vNKSanMJ30
 j0y2wpKcGDebmk6VmwgibstR8rDwJYppigoMoG7Pm.kqnBFnWAlebKmH9qA2jUv479p8dLZPN3F7
 8UWtENVMYtYckMAwTXzrtD79VSrwR6vuyyJgeYTXE304RkxDXxnfwRiJ8fJRIOecivtS4QAOUM4i
 KjvDP_XqmJ1eAF2vBUgXn7iwYebNVbViFXyVD9prN35lYnI5HGF16C1VxWjoWODYH8JcN12KOlbg
 BVylPYkAe37Ul4vNy0PmA6NOMDvq0w8Jb2PQJqhWopYCs0fikRWgvYgfNK13rGnSJ8nvqeb2EQRH
 DpIJPQz6wAC2Qk05FGgZ_43yoji.xSrgwI3NrzKblDgPoeKIHSDIjEop8o9K_18KcdAe5Etj2tm9
 qQwLPG8HGAeA8BPzR0QeG17ktiwgZlIXNW760UQMwzRgd129IhLJbjAcQcchYvuLqItPhthviK2h
 Cas3S6TSDrN8T46ZsvjhwaqKyl6YA6lkos5U20kZ9Gb2w_niCP4jpeeh0GtEOrpWLiEf9tMAGFl9
 XnyIzs_rxB1IeKOpY4jEYj4sPbE_QpEeZfRy.fdxKT.bK.0fInHAvSfrN5M3AmDcRG1mmRRVcpoE
 mZ_zTBTkhvcPhIexC8fxPHWXxSuJKRrCJm0UcNsMHXa90Q5K3V5tImeSGfjYekEEXsDPzSa6Gn0j
 0gDqxQDkTOx1IKyZs53GpakdrNwSiGYi92cOBDz083h5QRRlG_dIAoR4CvSNaqw_ISGQZgHtjIoZ
 Hwe.shZRIMaA2uQnfoTMLnFg7qFXOAOeeXtIq3CcQN0lYYffiqOXP4xGtXE2BWmwApg.nPOC5DMU
 g0qnXiWp9DvY_VlpM79CAzbaiaLJckebaBCzgpj3D3BdiZQVoIae3_w9.2Jo0E_c4f303qpOvPAd
 PZwGiIlGkcMsczPMoDEz8LQrCWZ45eg4H6dUbiQ4ECmDgwyyjqCABah4Q5ZIUmU1vFsBfqq6w96K
 .4C7zhH0USBCuh_ZvFknTgYC_mlqbNrrAYlO0tkZcTamuf0deDV6jHSRGdZTu1epoG2pssar6r3Q
 TMeKCQLY_UBkJBu3tTYOvOEZScvahWljJoK00w8x3NU8dm1umKDYKBtl78DK3Y7yten04AeAmXgp
 Htr7PjQUHi8QIZ2nrF0yZgUjQ7CHKS8ZGhDY7ubciqHOxJ9ikR0mwF865Wp6QZo.JD5DTqTpBlBt
 VVNSxYhoiOT22ktHTaaIDgrrbvRxk3F6uu9s8oJV3QA1Q.jeKvux4Z.eYZx.E3ZTK9fBipiTjLSU
 LHIaL4wkHRcWyTNSgrYaHLVwS.SMggHr2xtifL7cW4bbUjf32ym1TYuUHuHJeTGPoeo0oHG5NviP
 cLAX5kav1bU.ajcLcH_4Izue4byVLMaR8XeAFSt_FT1jrHjcLIugmY3VoVRLUIvVTiFd69i4rqbg
 JSIvvCB7I0fpjB_UkNRPOHKsWkJ_0Qm87S7ATP7iUwcs1iu7QPG87vxV_.fZmUl7ymz3PX1OsrU6
 9RSq2_TygdoBhG5Of9dcO1nK2bbdwEciqi0o6QSqD7NlnpwF_LedmlypHcN3PYGFaTDHd8maZQr2
 QoPB4qKVYe68xoBiVfwJo9jSQpax58M9YB8.ZpDo09BOBYpxz8xMlg_AOOWnZch_.jE5mp4bLPyw
 oYL134XMQnH_Gld2es30lnv4eY5BJ4OORDVfJF2Bq5mYqqYZfhpQUHi4SBpfJQ7smh0IW_xoJ4mO
 eLzmHHbY_wRSTL_CIYozTigzrUUapDNpCnGjTfmpcRHepXLkqXApcBHesUgPAtwjafA--
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: 8537fcc7-3c7f-42cf-b245-83a4b26012c0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Mon, 4 Nov 2024 12:10:21 +0000
Received: by hermes--production-ne1-bfc75c9cd-2wx42 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2a7edba291e48226fc2fd13ff57f133b;
          Mon, 04 Nov 2024 11:50:02 +0000 (UTC)
Message-ID: <f7c43842-270e-48f8-ba89-9b5e67910131@yahoo.com>
Date: Mon, 4 Nov 2024 05:34:42 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Dullfire <dullfire@yahoo.com>
Subject: Kernel panic with niu module
To: davem@davemloft.net, sparclinux@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <f7c43842-270e-48f8-ba89-9b5e67910131.ref@yahoo.com>
X-Mailer: WebService/1.1.22806 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hello,

I am working on a set of patches that address a panic on bind in the niu
module. However, none of the approaches I see integrate well with the kernels
frameworks, so any feed back you could provide would be appreciated.

On sparcv9 systems (and possibly others), when the niu drivers sets up the
MSIX IRQ vectors, a fatal trap[0] is encountered. I have done a number of
tests[1]. From these tests I have believe that any read from a specific MSIX
table entry must come after a write to it's PCI_MSIX_ENTRY_DATA field,
otherwise it will cause a fatal trap.

I see types of approaches:
1) Add writes to the ENTRY_DATA field to niu before it call into the 
    msi(x) code.
2) Adjust the MSIX code to either skip the read, or write to ENTRY_DATA first
3) Add a PCI quirk for this device to "initialize" the MSIX vector table.

Approach 1 encounters issues in needing to write to the MSIX table. The
functions needed to do this are internal to msi.c (or drivers/pci/msi/msi.h),
so they would have to either be reproduces in niu, or exposed in a public
header. Neither of those seem like a good approach to me.

Approach 2 can be done in a small amount of code, but it would either require
the addition of a struct pci_dev flag of some sort, or it would be invasive
to lots of other devices.

While approach 3 seems to be the most correct location, it suffers many of
the same issues as approach 1.

I have also bisected the kernel, and determined that  upstream commit
7d5ec3d3612396dc6d4b76366d20ab9fc06f399f revealed this issue. This commit
adds read to the mask status before any write to PCI_MSIX_ENTRY_DATA, thus
provoking the issue.

If you have any suggestions, please let me know.

Regards,
Jonathan Currier


[0] The trap looks like this:
-----------------------------------------------------------------------------
[   25.166817] niu: niu.c:v1.1 (Apr 22, 2010)
[   25.166952] niu 0001:04:00.0: enabling device (0144 -> 0146)
[   25.174100] niu: niu0: Found PHY 002063b0 type MII at phy_port 26
[   25.174559] niu: niu0: Found PHY 002063b0 type MII at phy_port 27
[   25.175004] niu: niu0: Found PHY 002063b0 type MII at phy_port 28
[   25.175449] niu: niu0: Found PHY 002063b0 type MII at phy_port 29
[   25.176298] niu: niu0: Port 0 [4 RX chans] [6 TX chans]
[   25.176405] niu: niu0: Port 1 [4 RX chans] [6 TX chans]
[   25.176507] niu: niu0: Port 2 [4 RX chans] [6 TX chans]
[   25.176548] niu: niu0: Port 3 [4 RX chans] [6 TX chans]
[   25.176590] niu: niu0: Port 0 RDC tbl(0) [ 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 ]
[   25.176757] niu: niu0: Port 0 RDC tbl(1) [ 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 ]
[   25.176890] niu: niu0: Port 1 RDC tbl(2) [ 4 5 6 7 4 5 6 7 4 5 6 7 4 5 6 7 ]
[   25.177053] niu: niu0: Port 1 RDC tbl(3) [ 4 5 6 7 4 5 6 7 4 5 6 7 4 5 6 7 ]
[   25.177185] niu: niu0: Port 2 RDC tbl(4) [ 8 9 10 11 8 9 10 11 8 9 10 11 8 9 10 11 ]
[   25.177349] niu: niu0: Port 2 RDC tbl(5) [ 8 9 10 11 8 9 10 11 8 9 10 11 8 9 10 11 ]
[   25.177483] niu: niu0: Port 3 RDC tbl(6) [ 12 13 14 15 12 13 14 15 12 13 14 15 12 13 14 15 ]
[   25.177649] niu: niu0: Port 3 RDC tbl(7) [ 12 13 14 15 12 13 14 15 12 13 14 15 12 13 14 15 ]
[   25.245863] NON-RESUMABLE ERROR: Reporting on cpu 64
[   25.245973] NON-RESUMABLE ERROR: TPC [0x00000000005f6900] <msix_prepare_msi_desc+0x90/0xa0>
[   25.246106] NON-RESUMABLE ERROR: RAW [4010000000000016:00000e37f93e32ff:0000000202000080:ffffffffffffffff
[   25.246215] NON-RESUMABLE ERROR:      0000000800000000:0000000000000000:0000000000000000:0000000000000000]
[   25.246291] NON-RESUMABLE ERROR: handle [0x4010000000000016] stick [0x00000e37f93e32ff]
[   25.246335] NON-RESUMABLE ERROR: type [precise nonresumable]
[   25.246373] NON-RESUMABLE ERROR: attrs [0x02000080] < ASI sp-faulted priv >
[   25.246435] NON-RESUMABLE ERROR: raddr [0xffffffffffffffff]
[   25.246476] NON-RESUMABLE ERROR: insn effective address [0x000000c50020000c]
[   25.246517] NON-RESUMABLE ERROR: size [0x8]
[   25.246544] NON-RESUMABLE ERROR: asi [0x00]
[   25.246573] CPU: 64 UID: 0 PID: 745 Comm: kworker/64:1 Not tainted 6.11.5 #63
[   25.246625] Workqueue: events work_for_cpu_fn
[   25.246671] TSTATE: 0000000011001602 TPC: 00000000005f6900 TNPC: 00000000005f6904 Y: 00000000    Not tainted
[   25.246729] TPC: <msix_prepare_msi_desc+0x90/0xa0>
[   25.246771] g0: 00000000000002e9 g1: 000000000000000c g2: 000000c50020000c g3: 0000000000000100
[   25.246815] g4: ffff8000470307c0 g5: ffff800fec5be000 g6: ffff800047a08000 g7: 0000000000000000
[   25.246861] o0: ffff800014feb000 o1: ffff800047a0b620 o2: 0000000000000011 o3: ffff800047a0b620
[   25.246906] o4: 0000000000000080 o5: 0000000000000011 sp: ffff800047a0ad51 ret_pc: 00000000005f7128
[   25.246951] RPC: <__pci_enable_msix_range+0x3cc/0x460>
[   25.247004] l0: 000000000000000d l1: 000000000000c01f l2: ffff800014feb0a8 l3: 0000000000000020
[   25.247049] l4: 000000000000c000 l5: 0000000000000001 l6: 0000000020000000 l7: ffff800047a0b734
[   25.247094] i0: ffff800014feb000 i1: ffff800047a0b730 i2: 0000000000000001 i3: 000000000000000d
[   25.247138] i4: 0000000000000000 i5: 0000000000000000 i6: ffff800047a0ae81 i7: 00000000101888b0
[   25.247182] I7: <niu_try_msix.constprop.0+0xc0/0x130 [niu]>
[   25.247321] Call Trace:
[   25.247346] [<00000000101888b0>] niu_try_msix.constprop.0+0xc0/0x130 [niu]
[   25.247442] [<000000001018f840>] niu_get_invariants+0x183c/0x207c [niu]
[   25.247536] [<00000000101902fc>] niu_pci_init_one+0x27c/0x2fc [niu]
[   25.247630] [<00000000005ef3e4>] local_pci_probe+0x28/0x74
[   25.247677] [<0000000000469240>] work_for_cpu_fn+0x8/0x1c
[   25.247726] [<000000000046b008>] process_scheduled_works+0x144/0x210
[   25.247782] [<000000000046b518>] worker_thread+0x13c/0x1c0
[   25.247833] [<00000000004710e0>] kthread+0xb8/0xc8
[   25.247874] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[   25.247931] [<0000000000000000>] 0x0
[   25.247961] Kernel panic - not syncing: Non-resumable error.
-----------------------------------------------------------------------------

[1] Tests I have done (and their results)
All tests done on a T5240 (UltaSPARC T2).
In my test cases: niu driver tries to use up to 13 vectors (table size of 32 entries).
"SUCCCESS" - Test case booted with functional networking
"FAILED" - Test case experienced a fatal trap after loading the niu module 
 - writing 0 to all of the MSIX table entrys' ENTRY_VECTOR_CTRL: FAILED 
 - writing 0 to all of the MSIX table entrys' ENTRY_LOWER_ADDR: FAILED 
 - writing 0 to all of the MSIX table entrys' ENTRY_UPPER_ADDR: FAILED 
 - writing 0 to all of the MSIX table entrys' ENTRY_DATA: SUCCESS
 - writing 0 to only one MSIX table entry's ENTRY_DATA: FAILED
 - writing 0 to only the first 1/2 of the MSIX table entrys' ENTRY_DATA: SUCCESS
 - writing ~0 to only the first 1/2 of the MSIX table entrys' ENTRY_DATA: SUCCESS
 - writing 0 to only the first 12 of the MSIX table entrys' ENTRY_DATA: FAILED
 - writing 0 to only the first 13 of the MSIX table entrys' ENTRY_DATA: SUCCESS
 - reading ENTRY_DATA before writing it: FAILED 
 - reading ENTRY_LOWER_ADDR before writing it: FAILED 
 - reading ENTRY_UPPER_ADDR before writing it: FAILED

