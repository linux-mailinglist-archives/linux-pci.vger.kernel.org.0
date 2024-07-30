Return-Path: <linux-pci+bounces-11029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD43C942128
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 21:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE4C1C234B2
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 19:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E7318CBE0;
	Tue, 30 Jul 2024 19:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ALJkCuIo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE3B83A17;
	Tue, 30 Jul 2024 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722369570; cv=none; b=RulvgzEdO5TS+plNz7sBsbYcf/UtmjcB3rCrFPRXriKNns+AmaHvn1f7+BVlsXaTILeTq9XpnO30m0ekeBRWipt2Z5zkTUMGVsAy3yIAEJ7gy2jRAoXhc6bjig2BBzXzcbt8TP6ZBk4RIKKd6bR3BzlDvKQoKqQPeo6UzVTEYN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722369570; c=relaxed/simple;
	bh=4hQkXi5WLs8pJ/Vq6vYswgN8fGBYwAM7n3n3GD5Mr/I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HGAsP/MP6HjeVrZRQjuOMZPBCipNLxBcqP4vcAWEhXcFuqfYqyirgMP9Fqn7u8duu51+S9wTj2E7jyWumq/ImBrugnpoocWDPTdRK5dr1YZrv8jtkn7KVzIeGYrmdMqW9l84msg3Q0RQxaRgFaDOQkvGdWT6k0E+JEjv746va8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ALJkCuIo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UGQRHM014799;
	Tue, 30 Jul 2024 19:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	qFEeWFv9Z5aPzQ0u6MCbEPw/esjJjzCYHGRQMjNTY7U=; b=ALJkCuIoxmhDtAwz
	SO5Kdhdxu/LqbInvG5dq9t24YNOR1Aa5f0zERQYYHkQWE+NTO5tlfLBq1ePVpzHM
	C1f4Todza+eAbbx2s9/e8KIygPnwVUCuA/nxWH7h5TzqNj7SPyu70G8DRe4vg8/D
	zAFJpzSqBdFSbAJVSOkqTM3uL2uu1jRji/Cielz76uOxb5cnPG0a5nOgZNMVkXXh
	dC2iodgwrTzh//daKEZIkcax6FsLr6BpE24aDolEn5ZjsaQ3+gYb9zKHwMOO4ftj
	kpRqpkildJNVkTMX3ohdDMytxwZwwKU1QniVe658nHUugvbNWdKrbowuvCUCS+7M
	mgyD3Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40q139rxv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 19:59:20 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46UJxKX9017102;
	Tue, 30 Jul 2024 19:59:20 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40q139rxv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 19:59:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46UJX0q0029103;
	Tue, 30 Jul 2024 19:59:19 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nbm0q0mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 19:59:19 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46UJxGck24838844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 19:59:18 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 554B05805C;
	Tue, 30 Jul 2024 19:59:16 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E1CA58059;
	Tue, 30 Jul 2024 19:59:14 +0000 (GMT)
Received: from [9.171.11.107] (unknown [9.171.11.107])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jul 2024 19:59:13 +0000 (GMT)
Message-ID: <b06e8e396d64d7202f9a8aae91e0c556b344cc5b.camel@linux.ibm.com>
Subject: Re: [PATCH] PCI: s390: Handle ARI on bus without associated struct
 pci_dev
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Date: Tue, 30 Jul 2024 21:59:13 +0200
In-Reply-To: <20240730-ari_no_bus_dev-v1-1-7de17676f9fe@linux.ibm.com>
References: <20240730-ari_no_bus_dev-v1-1-7de17676f9fe@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -b6LlMr7Qn-dK98s_PJpItgemZKagEe3
X-Proofpoint-ORIG-GUID: itKTzGb2PY6fWDGEesSyGX8RS-v_3Gpy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_15,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300136

On Tue, 2024-07-30 at 21:36 +0200, Niklas Schnelle wrote:
> On s390 PCI busses are virtualized and the downstream ports are
> invisible to the OS and struct pci_bus::self is NULL. This associated
> struct pci_dev is however relied upon in pci_ari_enabled() to check
> whether ARI is enabled for the bus. ARI is therefor always detected as
> disabled.
>=20
> At the same time firmware on s390 always enables and relies upon ARI
> thus causing a mismatch. Moreover with per-PCI function pass-through
> there may exist busses with no function with devfn 0. For example
> a SR-IOV capable device with two PFs may have separate function
> dependency link chains for each of the PFs and their child VFs. In this
> case the OS may only see the second PF and its child VFs on a bus
> without a devfn 0 function. A situation which is also not supported by
> the common pci_configure_ari() code.
>=20
> Dispite simply being a mismatch this causes problems as some PCI devices
> present a different SR-IOV topology depending on PCI_SRIOV_CTRL_ARI.
>=20
> A similar mismatch may occur with SR-IOV when virtfn_add_bus() creates ne=
w
> busses with no associated struct pci_dev. Here too pci_ari_enabled()
> on these busses would return false even if ARI is actually used.
>=20
> Prevent both mismatches by moving the ari_enabled flag from struct
> pci_dev to struct pci_bus making it independent from struct pci_bus::
> self. Let the bus inherit the ari_enabled state from its parent bus when
> there is no bridge device such that busses added by virtfn_add_bus()
> match their parent. For s390 set ari_enabled when the device supports
> ARI in the awareness that all PCIe ports on s390 systems are ARI
> capable.
>=20
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  arch/s390/pci/pci_bus.c | 12 ++++++++++++
>  drivers/pci/pci.c       |  4 ++--
>  drivers/pci/probe.c     |  1 +
>  include/linux/pci.h     |  4 ++--
>  4 files changed, 17 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
> index daa5d7450c7d..021319438dad 100644
> --- a/arch/s390/pci/pci_bus.c
> +++ b/arch/s390/pci/pci_bus.c
> @@ -278,6 +278,18 @@ void pcibios_bus_add_device(struct pci_dev *pdev)
>  {
>  	struct zpci_dev *zdev =3D to_zpci(pdev);
> =20
> +	/*
> +	 * On s390 PCI busses are virtualized and the bridge
> +	 * devices are invisible to the OS. Furthermore busses
> +	 * may exist without a devfn 0 function. Thus the normal
> +	 * ARI detection does not work. At the same time fw/hw
> +	 * has always enabled ARI when possible. Reflect the actual
> +	 * state by setting ari_enabled whenever a device on the bus
> +	 * supports it.
> +	 */
> +	if (pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ARI))
> +		zdev->zbus->bus->ari_enabled =3D 1;
> +

@Bjorn unstead of adding the above code to s390 specific code an
alternative I considered would be to modify pci_configure_ari() like
below. I tested this as well but wasn't sure if it is too much churn
especially the handling of the dev->devfn !=3D 0 case. Then again it
might be nice to have this in common code.

@@ -3523,12 +3524,18 @@ void pci_configure_ari(struct pci_dev *dev)
        u32 cap;
        struct pci_dev *bridge;

-       if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
+       if (pcie_ari_disabled || !pci_is_pcie(dev))
+               return;
+
+       if (dev->devfn && !hypervisor_isolated_pci_functions())
                return;

        bridge =3D dev->bus->self;
-       if (!bridge)
+       if (!bridge) {
+               if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI))
+                       dev->bus->ari_enabled =3D 1;
                return;
+       }

        pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);
        if (!(cap & PCI_EXP_DEVCAP2_ARI))


