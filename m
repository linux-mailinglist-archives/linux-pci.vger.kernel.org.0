Return-Path: <linux-pci+bounces-36036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F21B5522B
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 16:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189EE16D926
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 14:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2804D30EF65;
	Fri, 12 Sep 2025 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s/E6eicp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC6E30E0E7;
	Fri, 12 Sep 2025 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688519; cv=none; b=Na+IR7Nh+cL2C8YwQNazLJcziGEArdwYKWFyB8ZAo8z4A36mwf2mxcluLbe5qHoQN23x6h8JWMGV9GFpVrpFmSzAiXPbn8wQv0chLuFnMCxJWC+5et+cZspxC0TO7HMXBkcSnHuvQr1OaHq7Cmsr5/VvLpDjssWP+Xikxov/rVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688519; c=relaxed/simple;
	bh=+ABVEeOXJ7mEOPyuEbFrriT4hhdZOvJZoXdR2qD/FPU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b45ROUkCdBwjdtE0ds5iqqPqmqo5YgLN8DYdM7PqLu5pFHqVX+usMkRxddn7p4InWVT5NQJnaz1950s7wlr9IM3hB1DUTV0WFRNVGdRlIzOsCSpx2lNiEt5lvcv4WT4Cnxj8H0rIog/kaxl1PyerUOHcYcF3zz42qvbLNRswku0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s/E6eicp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CBfSEs029066;
	Fri, 12 Sep 2025 14:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=poyrRa
	t3JE9zqE25yJdtT9U2kFZs0+N92cgc5yAxDs0=; b=s/E6eicpBTxWo1BsyKu0Bs
	a+EnLanGVv/Mi9i1MeVZJmuwGki+72crOd6rPLqcWochQ0d4CJqQeb622EE394va
	1CIdbh4AE/pwSu/CX+2zY+3/rH00wq3ZfOTwMnDWPm2NPasJmwBswMiReialewyd
	ufyNIPOxZN4IUciuHvblKC3kIDlw1H9QEw6CntomWtCg0i1rCrgUiFLERb3hZ24A
	VhLnrBAfcSf2hUkIbV2WTJ/Sk7tt+IEWmtuMm1Zltrqv80V7bOKYKV197oKoWXl4
	gwy6OKsPpXxSwHkpL6B/WUbyxw0HTiQFn8NmjB/rcc2uNPFJnkNsLWLZHLtyKCcw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmxc5r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 14:48:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58CCohRK011434;
	Fri, 12 Sep 2025 14:48:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9uupry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 14:48:33 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58CEmTQl59638174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 14:48:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E149A20043;
	Fri, 12 Sep 2025 14:48:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EBC820040;
	Fri, 12 Sep 2025 14:48:29 +0000 (GMT)
Received: from [9.111.56.142] (unknown [9.111.56.142])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Sep 2025 14:48:28 +0000 (GMT)
Message-ID: <5d94639d3db0827602e530639d699026ec092743.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] PCI: Add lockdep assertion in
 pci_stop_and_remove_bus_device()
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas
 <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: Keith Busch <kbusch@kernel.org>, Matthew Rosato
 <mjrosato@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Halil
 Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Julian
 Ruess <julianr@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Fri, 12 Sep 2025 16:48:28 +0200
In-Reply-To: <20250826-pci_fix_sriov_disable-v1-2-2d0bc938f2a3@linux.ibm.com>
References: <20250826-pci_fix_sriov_disable-v1-0-2d0bc938f2a3@linux.ibm.com>
	 <20250826-pci_fix_sriov_disable-v1-2-2d0bc938f2a3@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Yl01E8MMDRSN5r8Mq0Xhx2pKKloWE5Hr
X-Proofpoint-ORIG-GUID: Yl01E8MMDRSN5r8Mq0Xhx2pKKloWE5Hr
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c432c2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=F53kh5m_LVtqdGsIIDMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfX7Lsj9q8l41LL
 6jzB0d79hf7nRfdQBB8jxhVKE8mB8kMFH743SFIvNxQNtCxUm3vUmdVEGTwKobKlo4o2GiKl+HZ
 QtZnpkgnTF2AU3sw44RBR8hfkvRcz6XmmzRfbRl5zR2bQra1X6oBnB4SXvs8p6Nuz92ZmagH0kb
 RuZVeKZpqzt7N+djN6cEsOXFDWWTL12JltTEoqdquvyS8doYJ9HhNH+iOek1gamniFDwsU0Ll+g
 sdnvJQvRNGKvXXW6X+ThaGS6AhlPJcpivw1jRjuaZEkQ3TrVQnnxdi1qB/zs6MgxdYHCWndXfic
 UIGBWdOVU4mcbKg8B+Kex1oaMnQsmgsqvmfD1lbkYaOElp0ypCuqabhBe7bz6QLHe5lZVOsFo8I
 Ly3p56u8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_05,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

On Tue, 2025-08-26 at 10:52 +0200, Niklas Schnelle wrote:
> Removing a PCI devices requires holding pci_rescan_remove_lock. Prompted
> by this being missed in sriov_disable() and going unnoticed since its
> inception add a lockdep assert so this doesn't get missed again in the
> future.
>=20
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/pci/pci.h    | 2 ++
>  drivers/pci/probe.c  | 2 +-
>  drivers/pci/remove.c | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 34f65d69662e9f61f0c489ec58de2ce17d21c0c6..1ad2e3ab147f3b2c42b3257e4=
f366fc5e424ede3 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -84,6 +84,8 @@ struct pcie_tlp_log;
>  extern const unsigned char pcie_link_speed[];
>  extern bool pci_early_dump;
> =20
> +extern struct mutex pci_rescan_remove_lock;
> +
>  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
>  bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
>  bool pcie_cap_has_rtctl(const struct pci_dev *dev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index f41128f91ca76ab014ad669ae84a53032c7c6b6b..2b35bb39ab0366bbf86b43e72=
1811575b9fbcefb 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3469,7 +3469,7 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
>   * pci_rescan_bus(), pci_rescan_bus_bridge_resize() and PCI device remov=
al
>   * routines should always be executed under this mutex.
>   */
> -static DEFINE_MUTEX(pci_rescan_remove_lock);
> +DEFINE_MUTEX(pci_rescan_remove_lock);
> =20
>  void pci_lock_rescan_remove(void)
>  {
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 445afdfa6498edc88f1ef89df279af1419025495..0b9a609392cecba36a818bc49=
6a0af64061c259a 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -138,6 +138,7 @@ static void pci_remove_bus_device(struct pci_dev *dev=
)
>   */
>  void pci_stop_and_remove_bus_device(struct pci_dev *dev)
>  {
> +	lockdep_assert_held(&pci_rescan_remove_lock);
>  	pci_stop_bus_device(dev);
>  	pci_remove_bus_device(dev);
>  }

I'm totally in favor of adding this lockdep assertion, even if this
means that the mutex pci_rescan_remove_lock needs to be externalized
from drivers/pci/probe.c.

However, I was surprised that you didn't add the assertion to the
_locked() variant until I realized that here the naming of _locked vs.
not _locked variants of pci_stop_and_remove_bus_device() is just the
opposite to the naming in driver/pci/pci.c:
There _locked implies that the necessary lock is already held on
routine entry. But this change in semantics was already introduced with
commit 9d16947b7583 ("PCI: Add global pci_lock_rescan_remove()").

Looks like aligning the naming to the convention in driver/pci/pci.c
would touch quite a bit of code - but so does the introduction of this
lockdep assertion...

Sigh, Gerd



