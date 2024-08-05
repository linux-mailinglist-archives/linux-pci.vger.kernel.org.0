Return-Path: <linux-pci+bounces-11274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1CB9475BD
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 09:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3C4280C45
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 07:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF10B6A01E;
	Mon,  5 Aug 2024 07:08:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from cloud48395.mywhc.ca (cloud48395.mywhc.ca [173.209.37.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAE8145FE2
	for <linux-pci@vger.kernel.org>; Mon,  5 Aug 2024 07:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.209.37.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722841690; cv=none; b=NzQoteYkWscBUSoBLHiULZFZFVCURpDEEsx975jIewZjxGduKRymtEXkzA4WvpGJTi1Of6bWNRT9UT0acFRex+xUk5t7EuZyFvn9ySQy6Zq7PjcUTeUyyYynj4R+WXN+6uIZVm5v7WbEXEvGOhTaUGekQ0rfJsELcLYCxttU52o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722841690; c=relaxed/simple;
	bh=O+Z/ad6Lh0bphu3fvTBZMAU2KCBu8g4+OPHRyCZ4/pA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T/JhWGT1afk5Y4+vd6AKa+D6b1OD8Ubyj4K60+oOt2Mv/lE0/zH9SAXSPU6d4Km/lueSLo/xRq9CU2MSpJWbjf0pDS7F1Y4hkNxLBdJtvIHt8aXYeKXFm3Wd3Iug2hPJf8RiJoRt7S0c9gmTe0cxvrVvHynZCSifhyJisAFJMuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trillion01.com; spf=pass smtp.mailfrom=trillion01.com; arc=none smtp.client-ip=173.209.37.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trillion01.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trillion01.com
Received: from [45.44.224.220] (port=41864 helo=[192.168.1.177])
	by cloud48395.mywhc.ca with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <olivier@trillion01.com>)
	id 1sarp9-0004tg-0T;
	Mon, 05 Aug 2024 03:08:07 -0400
Message-ID: <ac0ac2799fe78b1541faeb285ecac1cb8ab3f7e9.camel@trillion01.com>
Subject: Re: where is the irq effective affinity set from
 pci_alloc_irq_vectors_affinity()?
From: Olivier Langlois <olivier@trillion01.com>
To: linux-pci@vger.kernel.org
Cc: paulmck@kernel.org
Date: Mon, 05 Aug 2024 03:08:06 -0400
In-Reply-To: <ce4ce0bb8b083f1fa23c7231d809a05b7728ff53.camel@trillion01.com>
References: <ce4ce0bb8b083f1fa23c7231d809a05b7728ff53.camel@trillion01.com>
Autocrypt: addr=olivier@trillion01.com; prefer-encrypt=mutual;
 keydata=mQINBFYd0ycBEAC53xedP1NExPwtBnDkVuMZgRiLmWoQQ8U7vEwt6HVGSsMRHx9smD76i
 5rO/iCT6tDIpZoyJsTOh1h2NTn6ZkoFSn9lNOJksE77/n7HNaNxiBfvZHsuNuI53CkYFix9JhzP3t
 g5nV/401re30kRfA8OPivpnj6mZhU/9RTwjbVPPb8dPlm2gFLXwGPeDITgSRs+KJ0mM37fW8EatJs
 0a8J1Nk8wBvT7ce+S2lOrxDItra9pW3ukze7LMirwvdMRC5bdlw2Lz03b5NrOUq+Wxv7szn5Xr9f/
 HdaCH7baWNAO6H/O5LbJ3zndewokEmKk+oCIcXjaH0U6QK5gJoO+3Yt5dcTo92Vm3VMxzK2NPFXgp
 La7lR9Ei0hzQ0zptyFFyftt9uV71kMHldaQaSfUTsu9dJbnS2kI/j+F2S1q6dgKi3DEm0ZRGvjsSG
 rkgPJ5T16GI1cS2iQntawdr0A1vfXiB9xZ1SMGxL/l6js9BVlIx/CBGOJ4L190QmxJlcAZ2VnQzrl
 ramRUv01xb00IPJ5TBft5IJ+SY0FnY9pIERIl6w9khwLt/oGuKNmUHmzJGYoJHYfh72Mm8RQ1R/JS
 o6v85ULBGdEC3pQq1j//OPyH3egiXIwFq6BtULH5CvsxQkSqgj1MpjwfgVJ8VbjNwqwBXHjooEORj
 vFQqWQki6By3QARAQABtDJPbGl2aWVyIExhbmdsb2lzIChNeSBrZXkpIDxvbGl2aWVyQHRyaWxsaW
 9uMDEuY29tPokCNwQTAQgAIQUCVh3TJwIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBlaka
 GGsWHEI1AD/9sbj+vnFU29WemVqB4iW+9RrHIcbXI4Jg8WaffTQ8KvVeCJ4otzgVT2nHC2A82t4PF
 0tp21Ez17CKDNilMvOt8zq6ZHx36CPjoqUVjAdozOiBDpC4qB6ZKYn+gqSENO4hqmmaOW57wT9vII
 v6mtHmnFvgpOEJl6wbs8ArHDt0BLSjc8QQfvBhoKoWs+ijQTyvFGlQl0oWxEbUkR1J3gdft9Oj9xQ
 G4OFo73WaSEK/L9IalU2ulCBC+ucSP9McoDxy1i1u8HUDrV5wBY1zafc9zVBcMNH6+ZjxwQmZXqtz
 ATzB3RbSFHAdmvxl8q6MeS2yx7Atk0CXgW9z5k2KeuZhz5rVV5A+D19SSGzW11uYXsibZx/Wjr9xB
 KHB6U7qh5sRHaQS191NPonKcsXXAziR+vxwQTP7ZKfy+g5N/e6uivoUnQrl9uvUDDPXEpwVNSoVws
 Vn4tNyrGEdN11pHDbH5fSGzdpbY8+yczUoxMmsEQe/fpVwRBZUqafRn2TVUhV0qqzsUuQcTNw1zIZ
 JgvkqrHgd4ivd2b1bXBczmu/wMGpEnF6cWzSQDiwC1NF3i+gHCuD8IX1ujThWtzXsn0VtrMkrRCbn
 ponVQ6HcbRYYXPuK0HRRjCSuAKo5porVONepiOSmu0FBrpGqBkpBtLrzKXoi1yt/7a/wGdMcVhYGg
 vA==
Organization: Trillion01 Inc
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud48395.mywhc.ca
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - trillion01.com
X-Get-Message-Sender-Via: cloud48395.mywhc.ca: authenticated_id: olivier@trillion01.com
X-Authenticated-Sender: cloud48395.mywhc.ca: olivier@trillion01.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On Sun, 2024-08-04 at 16:14 -0400, Olivier Langlois wrote:
> I am trying to understand the result that the nvme driver has when it
> calls pci_alloc_irq_vectors_affinity() from nvme_setup_irqs()
> (drivers/nvme/host/pci.c)
>=20
> $ cat /proc/interrupts | grep nvme
> =A063:=A0=A0=A0=A0=A0=A0=A0=A0=A0 9=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0 PCI-MSIX-
> 0000:00:04.0
> 0-edge=A0=A0=A0=A0=A0 nvme0q0
> =A064:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0 237894=A0 PCI-MSIX-
> 0000:00:04.0
> 1-edge=A0=A0=A0=A0=A0 nvme0q1
>=20
> $ cat /proc/irq/64/smp_affinity_list
> 0-3
>=20
> $ cat /proc/irq/64/effective_affinity_list=20
> 3
>=20
> I think that this happens somewhere below pci_msi_setup_msi_irqs()
> (drivers/pci/msi/irqdomain.c)
> but I am losing track of what is done precisely because I am not sure
> of what is the irq_domain on my system.
>=20
> I have experimented by playing with the nvme io queues num that is
> passed to pci_msi_setup_msi_irqs()
> as the max_vectors params.
>=20
> The set irq effective affinity appears to always be the last cpu of
> the
> affinity mask.
>=20
> I would like to have some control on the selected effective_affinity
> as
> I am trying to use NOHZ_FULL effectively on my system.
>=20
> NOTE:
> I am NOT using irqbalance
>=20
> thank you,
>=20
I have found

arch/x86/kernel/apic/vector.c and kernel/irq/matrix.c

I think that matrix_find_best_cpu() should consider if a CPU is
NOHZ_FULL and NOT report it as the best cpu if there are other
options...

I'll try to play with the idea and report back if I get some success
with it...

Greetings,


