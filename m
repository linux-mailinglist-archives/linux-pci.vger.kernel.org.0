Return-Path: <linux-pci+bounces-11450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8212594AD30
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 17:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFB71F2235F
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 15:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF1312C522;
	Wed,  7 Aug 2024 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ka56J3Tm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFD912FF72;
	Wed,  7 Aug 2024 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045510; cv=none; b=jb4tKKmgVu1N4gNzoFLEyHbnNNKXxQlYTM7AQafQwOOAX3R95cljEambjxEvMkJvORhwWkuPOGQuVnFB/ax1xsqzMEyR6T+KDO/YISFv/WLV8s+phPhUH/6xJDeTHB2I5pM5riwi7+3Xi/mCBg1WjAICeHkpz67+vECymNLqDnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045510; c=relaxed/simple;
	bh=bpvMt9LIzciZE04JdWRFLqfFnEpZKjKgZ9aZ7GnKAmY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FjIEWXqPEQzU3c17TYJGrLxbJsnEEAGIKRZ/UGzcHkix2dhxmIdORqG9CPEzE/lmZ+iGVTPHH13obYG0IFpSJ5BhL1Ef2RpUVvl/hpcrRIwknk0yW+x52r2dE9BgAjKBg91hpjIr0Sm1zKwj4lahhhAVEgVFMcBz1kbqpJDFeHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ka56J3Tm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47730R6m004548;
	Wed, 7 Aug 2024 15:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	19hE5IYkQM6sXsKXv8sX+JHZtrFY8OS8d+daPlHYI7I=; b=ka56J3TmM+5TEJQp
	yqMgNfC3i+fiFmYsx8dnrGi9pQTGC6Xdl9aJaWJDXUNjesaxPQNwgpsARZHwz77R
	PJ4Q+dZxI8JPL9xmTogwPy8ewHjraYygQXDY96NW798do9KtUshoU+PeLw/fn8pA
	jtOqMh0Hg97G5wm66erG03iWXXSthECtE/sivEAR2OM9kuKkKBXVv3YT27FrW/0y
	VERIF/9aWNtCijfpKEPZEP+p+XaXi30NMFAl8ElQq5Yi6ELVATRTnnJAawSsshxa
	Ur48SZL0Cco2GvirUo2xzC9ZR/HDzZfCs7Wo6AiAkdo+QjfFJzbX1dU/eLisGQZg
	nrCT9w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40uk02b7u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 15:44:35 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 477FiYjM002328;
	Wed, 7 Aug 2024 15:44:34 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40uk02b7u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 15:44:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 477EIK2d018615;
	Wed, 7 Aug 2024 15:44:33 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40sxvu9yd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 15:44:33 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 477FiUKd6947452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 15:44:33 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A67625805D;
	Wed,  7 Aug 2024 15:44:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A830C58054;
	Wed,  7 Aug 2024 15:44:26 +0000 (GMT)
Received: from [9.171.22.131] (unknown [9.171.22.131])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Aug 2024 15:44:26 +0000 (GMT)
Message-ID: <ff738a270fc5ad18310e10d4624955430c86e7a2.camel@linux.ibm.com>
Subject: Re: [PATCH] s390/pci: Stop usurping pdev->dev.groups
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Lukas Wunner <lukas@wunner.de>,
        Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        Alistair Francis
 <alistair23@gmail.com>, Jonathan.Cameron@huawei.com,
        alex.williamson@redhat.com, christian.koenig@amd.com, kch@nvidia.com,
        gregkh@linuxfoundation.org, logang@deltatee.com, chaitanyak@nvidia.com,
        rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>,
        Sebastian Ott <sebott@redhat.com>
Date: Wed, 07 Aug 2024 17:44:25 +0200
In-Reply-To: <7b970f7923e373d1b23784721208f93418720485.1722870934.git.lukas@wunner.de>
References: 
	<7b970f7923e373d1b23784721208f93418720485.1722870934.git.lukas@wunner.de>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s6heuq5bCSsOuiaSrCe7JIOD6W5Z0h4E
X-Proofpoint-GUID: H_TGPsjfV4z2OoNKSKYNG3kqyNsPEVJV
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408070107

On Mon, 2024-08-05 at 17:24 +0200, Lukas Wunner wrote:
> Bjorn suggests using pdev->dev.groups for attribute_groups constructed
> on PCI device enumeration:
>=20
>    "Is it feasible to build an attribute group in pci_doe_init() and
>     add it to dev->groups so device_add() will automatically add them?"
>     https://msgid.link/20231019165829.GA1381099@bhelgaas
>=20
> Unfortunately on s390, pcibios_device_add() usurps pdev->dev.groups for
> arch-specific attribute_groups, preventing its use for anything else.
>=20
> Introduce an ARCH_PCI_DEV_GROUPS macro which arches can define in
> <asm/pci.h>.  The macro is visible in drivers/pci/pci-sysfs.c through
> the inclusion of <linux/pci.h>, which in turn includes <asm/pci.h>.
>=20
> On s390, define the macro to the three attribute_groups previously
> assigned to pdev->dev.groups.  Thereby pdev->dev.groups is made
> available for use by the PCI core.
>=20
> As a side effect, arch/s390/pci/pci_sysfs.c no longer needs to be
> compiled into the kernel if CONFIG_SYSFS=3Dn.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  arch/s390/include/asm/pci.h |  9 ++++++++-
>  arch/s390/pci/Makefile      |  3 ++-
>  arch/s390/pci/pci.c         |  1 -
>  arch/s390/pci/pci_sysfs.c   | 14 ++++----------
>  drivers/pci/pci-sysfs.c     |  5 +++++
>  5 files changed, 19 insertions(+), 13 deletions(-)
>=20
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 30820a6..9d920ce 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -191,7 +191,14 @@ static inline bool zdev_enabled(struct zpci_dev *zde=
v)
>  	return (zdev->fh & (1UL << 31)) ? true : false;
>  }
> =20
> -extern const struct attribute_group *zpci_attr_groups[];
> +extern const struct attribute_group zpci_attr_group;
> +extern const struct attribute_group pfip_attr_group;
> +extern const struct attribute_group zpci_ident_attr_group;
> +
> +#define ARCH_PCI_DEV_GROUPS &zpci_attr_group,		 \
> +			    &pfip_attr_group,		 \
> +			    &zpci_ident_attr_group,
> +
>  extern unsigned int s390_pci_force_floating __initdata;
>  extern unsigned int s390_pci_no_rid;
> =20
> diff --git a/arch/s390/pci/Makefile b/arch/s390/pci/Makefile
> index 0547a10..2c21f03 100644
> --- a/arch/s390/pci/Makefile
> +++ b/arch/s390/pci/Makefile
> @@ -3,7 +3,8 @@
>  # Makefile for the s390 PCI subsystem.
>  #
> =20
> -obj-$(CONFIG_PCI)	+=3D pci.o pci_irq.o pci_clp.o pci_sysfs.o \
> +obj-$(CONFIG_PCI)	+=3D pci.o pci_irq.o pci_clp.o \
>  			   pci_event.o pci_debug.o pci_insn.o pci_mmio.o \
>  			   pci_bus.o pci_kvm_hook.o
>  obj-$(CONFIG_PCI_IOV)	+=3D pci_iov.o
> +obj-$(CONFIG_SYSFS)	+=3D pci_sysfs.o
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index cff4838..bd9624c 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -587,7 +587,6 @@ int pcibios_device_add(struct pci_dev *pdev)
>  	if (pdev->is_physfn)
>  		pdev->no_vf_scan =3D 1;
> =20
> -	pdev->dev.groups =3D zpci_attr_groups;
>  	zpci_map_resources(pdev);
> =20
>  	for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
> index 0f4f1e8..1f81f6f 100644
> --- a/arch/s390/pci/pci_sysfs.c
> +++ b/arch/s390/pci/pci_sysfs.c
> @@ -197,7 +197,7 @@ static umode_t zpci_index_is_visible(struct kobject *=
kobj,
>  	NULL,
>  };
> =20
> -static struct attribute_group zpci_ident_attr_group =3D {
> +const struct attribute_group zpci_ident_attr_group =3D {
>  	.attrs =3D zpci_ident_attrs,
>  	.is_visible =3D zpci_index_is_visible,
>  };
> @@ -223,7 +223,7 @@ static umode_t zpci_index_is_visible(struct kobject *=
kobj,
>  	NULL,
>  };
> =20
> -static struct attribute_group zpci_attr_group =3D {
> +const struct attribute_group zpci_attr_group =3D {
>  	.attrs =3D zpci_dev_attrs,
>  	.bin_attrs =3D zpci_bin_attrs,
>  };
> @@ -235,14 +235,8 @@ static umode_t zpci_index_is_visible(struct kobject =
*kobj,
>  	&dev_attr_segment3.attr,
>  	NULL,
>  };
> -static struct attribute_group pfip_attr_group =3D {
> +
> +const struct attribute_group pfip_attr_group =3D {
>  	.name =3D "pfip",
>  	.attrs =3D pfip_attrs,
>  };
> -
> -const struct attribute_group *zpci_attr_groups[] =3D {
> -	&zpci_attr_group,
> -	&pfip_attr_group,
> -	&zpci_ident_attr_group,
> -	NULL,
> -};
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 40cfa71..5d0f4db 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -31,6 +31,10 @@
>  #include <linux/aperture.h>
>  #include "pci.h"
> =20
> +#ifndef ARCH_PCI_DEV_GROUPS
> +#define ARCH_PCI_DEV_GROUPS
> +#endif
> +
>  static int sysfs_initialized;	/* =3D 0 */
> =20
>  /* show configuration fields */
> @@ -1624,6 +1628,7 @@ static umode_t pcie_dev_attrs_are_visible(struct ko=
bject *kobj,
>  	&pci_dev_acpi_attr_group,
>  #endif
>  	&pci_dev_resource_resize_group,
> +	ARCH_PCI_DEV_GROUPS
>  	NULL,
>  };
> =20

Thanks for the patch and sorry for the delay I'll be on vacation
starting tomorrow and it's a bit busy. This makes sense to me and I
agree with Bjorn that this can go via the PCI tree, especially if it is
already useful there. I also gave this a compile and boot test on and
checked that the s390 specific PCI device attributes are still there.

Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>


