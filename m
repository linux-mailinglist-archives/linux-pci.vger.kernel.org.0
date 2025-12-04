Return-Path: <linux-pci+bounces-42625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE6ECA3A60
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 13:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61BEF303267B
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 12:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705FC19F12D;
	Thu,  4 Dec 2025 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m/epDn9K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68F01758B;
	Thu,  4 Dec 2025 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764852360; cv=none; b=K+DrTY93l2ypW7OOtX4drHAS374QKFloxVFIqNIa26pPOqLCe/cdMSwTcUIfBA1a35WDU7Adtb1eNwgPDumGw6u2lYBXDo8FAPSfYBAvDFZtOcJJISYNjRHaXky7crwtKV3tluKOkT8GtXaHyVLc7j6mxGYxm4/q/iyoVVCqZ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764852360; c=relaxed/simple;
	bh=vEDPUwn+d/bVyKI+wm1SSV1kgLUwIpYpI4mcq8LBLkU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cAMlKb7SPoz3FwVykS+P1chLoROcPbGCZ+05uACM3dSRwCqs1eh0+Sfp4wsPYXZF2WcFguRyVNO38ajVKi2sIsnY6iCC/Gpm/PMB+1cPFC3/9AOwtdAsrHWsS0hsRZ4TK+49WH7GpRwFdWfAYQHblxMHsRUlewU+vQjQaZpVfbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m/epDn9K; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4ABZoC031345;
	Thu, 4 Dec 2025 12:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NdUAjK
	EacxILa48+rMzoE9raxluSaeAb05u/4dKSpvY=; b=m/epDn9Kwvg2tSE1a/SpnZ
	JHDsl/8XLawh4CWp4XD7N28MlLhfGWp3jZTVUUTEn+dcAIe3KV836ST3ZfQunB7U
	E8o6H9xKq00BT28V8o+RmGPU6CDDqe32UCf7UYuzLg+vRWxwhQW+AfT3xJi6MbBE
	bRG1g5EPF+QeilvLyvihGkaFdK9Gwui1H0EtCRMAOCFKNJJNFqnOtRxJOP12kclU
	aiAI+tCof/JdxKF65Ey8u1xmTjFvD80+cA/t5FxZMaTWg+rM/i9h4g6s50NMm/St
	xSNQdITWuj5Wc6yWkkl1o6xP0Z68hx52XNMRhfSgPu+yHg16/6opsVadxqx0dJ/w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8q7x1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 12:45:57 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B4CYpS5020581;
	Thu, 4 Dec 2025 12:45:56 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8q7x1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 12:45:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4BUxkc019035;
	Thu, 4 Dec 2025 12:45:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arbhy7tkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 12:45:55 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B4Cjpe727263472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Dec 2025 12:45:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0B112004D;
	Thu,  4 Dec 2025 12:45:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AAD42004B;
	Thu,  4 Dec 2025 12:45:51 +0000 (GMT)
Received: from [9.155.208.229] (unknown [9.155.208.229])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Dec 2025 12:45:51 +0000 (GMT)
Message-ID: <c66fe13cf2dbe9def72cbd5ae703538dcb770d7b.camel@linux.ibm.com>
Subject: Re: [PATCH v3] PCI: s390: Expose the UID as an arch specific PCI
 slot attribute
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas
	 <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger	
 <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev	 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Julian Ruess	 <julianr@linux.ibm.com>,
        Peter Oberparleiter
 <oberpar@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date: Thu, 04 Dec 2025 13:45:51 +0100
In-Reply-To: <20251015-uid_slot-v3-1-44389895c1bb@linux.ibm.com>
References: <20251015-uid_slot-v3-1-44389895c1bb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwMCBTYWx0ZWRfX5qh+4vafL3RR
 b272ppoR5FHEM+SNtpFBnizgLmnBVf6GWsIhvsWDWFh98qOjHhA3+x+jBDqNz/RQAxDfv9ySHNh
 1T+agEx9emF7B+uLv7g5Aeakx0u1tqmP86Oqt4izawUJo78v4X1EWvfDloZ/uhV+A9OZgyW2NaY
 0xGcFNc8yi6tW0ZcmEMbN8VeXhNNs4slNxjdOr+OyxDp7CTsRZ812C7M4kYBDxYqOPfHYX3FSU1
 lYIK/RtED8Z36HY0J51XZ8dNhCS2iyIQWguZWQRs9A+fh4N4y/b9/3NkJZaC/n6B2wCmtNXXUY7
 a24fhFtJOkgbR57Cc30hQyFs6ZO+EnZm9v5nOQKAmkHPq4Br9wHiZhKoaSEyw1iYF1IkpvQLxuE
 v7e7caKCbavii7uhuHjW7imSUJgFWQ==
X-Authority-Analysis: v=2.4 cv=dIerWeZb c=1 sm=1 tr=0 ts=69318285 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=aYzX5jylc00JjIcdlWIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: r_xGcC1VKhUQETblzt9LFXfxICZ07ZQx
X-Proofpoint-GUID: OMShF7CRcss18cak0RtUhzOvAk7V2ZKA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_03,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290000

On Wed, 2025-10-15 at 15:42 +0200, Niklas Schnelle wrote:
> On s390, an individual PCI function can generally be identified by two
> identifiers, the FID and the UID. Which identifier is used depends on
> the scope and the platform configuration.
>=20
> The first identifier, the FID, is always available and identifies a PCI
> device uniquely within a machine. The FID may be virtualized by
> hypervisors, but on the LPAR level, the machine scope makes it
> impossible to create the same configuration based on FIDs on two
> different LPARs of the same machine, and difficult to reuse across
> machines.
>=20
> Such matching LPAR configurations are useful, though, allowing
> standardized setups and booting a Linux installation on different LPARs.
> To this end the UID, or user-defined identifier, was introduced. While
> it is only guaranteed to be unique within an LPAR and only if indicated
> by firmware, it allows users to replicate PCI device setups.
>=20
> On s390, which uses a machine hypervisor, a per PCI function hotplug
> model is used. The shortcoming with the UID then is, that it is not
> visible to the user without first attaching the PCI function and
> accessing the "uid" device attribute. The FID, on the other hand, is
> used as the slot name and is thus known even with the PCI function in
> standby.
>=20
> Remedy this shortcoming by providing the UID as an attribute on the slot
> allowing the user to identify a PCI function based on the UID without
> having to first attach it. Do this via a macro mechanism analogous to
> what was introduced by commit 265baca69a07 ("s390/pci: Stop usurping
> pdev->dev.groups") for the PCI device attributes.

Hi Niklas,

I like this addition a lot. Also, Lukas' method to add arch-specific
attributes to sysfs. Is there a reason why you didn't apply that
mechanism 1-to-1?

>=20
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Note: I considered adding the UID as a generic "index" via the hotplug
> slot driver but felt like there is probably too little commonality on
> format and usage patterns

Sorry for my ignorance but how is the hotplug slot driver defining an
"index" or how is used?


> v2->v3:
> - Rebase on v6.18-rc1 and resolve conflict with recent s390 PCI sysfs cha=
nge
> - Link to v2: https://lore.kernel.org/r/20251008-uid_slot-v2-1-ef22cef277=
41@linux.ibm.com
> ---
>  arch/s390/include/asm/pci.h |  4 ++++
>  arch/s390/pci/pci_sysfs.c   | 20 ++++++++++++++++++++
>  drivers/pci/slot.c          | 13 ++++++++++++-
>  3 files changed, 36 insertions(+), 1 deletion(-)
>=20

  [ ... snip ... ]

> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 50fb3eb595fe65e271b6b339d43c9677c61b1e45..b09e7852c33ed4957432ac73b=
36d181ecd8283a1 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -96,7 +96,18 @@ static struct attribute *pci_slot_default_attrs[] =3D =
{
>  	&pci_slot_attr_cur_speed.attr,
>  	NULL,
>  };
> -ATTRIBUTE_GROUPS(pci_slot_default);
> +
> +static const struct attribute_group pci_slot_default_group =3D {
> +	.attrs =3D pci_slot_default_attrs,
> +};
> +
> +static const struct attribute_group *pci_slot_default_groups[] =3D {
> +	&pci_slot_default_group,
> +#ifdef ARCH_PCI_SLOT_GROUPS
> +	ARCH_PCI_SLOT_GROUPS,
> +#endif
> +	NULL,
> +};
> =20

With the following diff you could avoid the #ifdef directive in the
middle of the definition of the attribute_group - shamelessly stolen
from Lukas' patch


diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 8e5e0f995e91..1d8105c4d2a6 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -208,7 +208,7 @@ extern const struct attribute_group
zpci_ident_attr_group;
=20
 extern const struct attribute_group zpci_slot_attr_group;
=20
-#define ARCH_PCI_SLOT_GROUPS (&zpci_slot_attr_group)
+#define ARCH_PCI_SLOT_GROUPS &zpci_slot_attr_group,
=20
 extern unsigned int s390_pci_force_floating __initdata;
 extern unsigned int s390_pci_no_rid;
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index b09e7852c33e..9ba7fc0066bf 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -11,6 +11,10 @@
 #include <linux/err.h>
 #include "pci.h"
=20
+#ifndef ARCH_PCI_SLOT_GROUPS
+#define ARCH_PCI_SLOT_GROUPS
+#endif
+
 struct kset *pci_slots_kset;
 EXPORT_SYMBOL_GPL(pci_slots_kset);
=20
@@ -103,9 +107,7 @@ static const struct attribute_group
pci_slot_default_group =3D {
=20
 static const struct attribute_group *pci_slot_default_groups[] =3D {
        &pci_slot_default_group,
-#ifdef ARCH_PCI_SLOT_GROUPS
-       ARCH_PCI_SLOT_GROUPS,
-#endif
+       ARCH_PCI_SLOT_GROUPS
        NULL,
 };

Thanks,
Gerd

