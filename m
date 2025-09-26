Return-Path: <linux-pci+bounces-37112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F242BA4A68
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 18:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E784A29CF
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 16:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE47D202F7B;
	Fri, 26 Sep 2025 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cZJ/MAxH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C744425FA13;
	Fri, 26 Sep 2025 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904467; cv=none; b=Jph/sI9QiX6S6IMkQTuIdKCF5gtFqLx6kdEiuorR0+YzjpxB+n5jOoMe+15//9W7TH5VYPxBKr6m+AGGnMU5YqtU1UTOxDYnOiHech+LwIHaeyOxGFoU2i0MDQc0WZpsNlR0YmMvyHjAzfbQIQ18MPGsPQUW7ph4RwctecI0faE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904467; c=relaxed/simple;
	bh=G9EcpBzA81a9lePO6IcawUwdySqpPpvBtz6Dxsy3oM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLkWCuraj36EgThLPuzVEMR241mjR2kohFzf3ePoVARSN6gFCWuOtJZCZNIpF/Ld8i75bllp8u8rn5VoDzSk4j+Z4T1e7FtQchHVWV6MOEb1xOmfAX27589vYWaMRUmGR8zTMAFiA5UVCob3baZCXJ0bXnqe8y4rWRGe/FX5qI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cZJ/MAxH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QDDOpk010421;
	Fri, 26 Sep 2025 16:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=E8gv+2ZUCB2wSLEHOTp9c9xdIMRne/FcCsi/xwFCXEA=; b=cZJ/MAxH62Qg
	Xmns67ZH2Ya8QaEhJA3b9qHfh2oYHP5BDejEjZg3KBtUPCPah6WfjkUeHEvC7Bbq
	1V41By1Fh0/ABuzNq/ZNoZef9W2+9tRdBhb+5RL6BLY5v0BsmvlbjVhq1K9PaF2L
	74wZQ/HO7WxPt9I0Tij3KVyfejr4OVRQnUUckatwsGpWiE2sqHApjr8UMfekZE+7
	8mkaR2ObjRYKfPdQqUS/sIQsiWEYocN6fbq6V1RA3vveNK+Y7fnPKq1fOBj9TQvw
	cGTeDvIq1DbdA+WkRMPJH30RPiZL68B0OqEaE1W/JUjW30/ndawIQHv/A3r0sYDl
	NPejWFDQFA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbb4e18j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 16:34:24 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58QGLS8J019449;
	Fri, 26 Sep 2025 16:34:24 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbb4e18a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 16:34:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58QE8wj0014330;
	Fri, 26 Sep 2025 16:34:23 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49dawm528k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 16:34:23 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58QGYMYK20185732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Sep 2025 16:34:22 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E04D5805D;
	Fri, 26 Sep 2025 16:34:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A7455805F;
	Fri, 26 Sep 2025 16:34:20 +0000 (GMT)
Received: from [9.61.248.170] (unknown [9.61.248.170])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Sep 2025 16:34:20 +0000 (GMT)
Message-ID: <4dd8a92a-0843-4009-a9c6-3a1336dbf217@linux.ibm.com>
Date: Fri, 26 Sep 2025 11:34:21 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: ramesh@linux.ibm.com
Subject: Re: [PATCH] PCI: s390: Expose the UID as an arch specific PCI slot
 attribute
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20250924-uid_slot-v1-1-09ae04f48c57@linux.ibm.com>
Content-Language: en-US
From: Ramesh Errabolu <ramesh@linux.ibm.com>
In-Reply-To: <20250924-uid_slot-v1-1-09ae04f48c57@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BbvVE7t2 c=1 sm=1 tr=0 ts=68d6c090 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=hyw2YeqkD9vi0ihe8cAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: o5NCMSiOckL9N3sVLNeh2ImSfzbdogr6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3NCBTYWx0ZWRfXy0rz2qjjAsMm
 T6hyxvaHm8Sen6cda01M95JQbjk6ute/jOflFarFNeU/jfHGWEiKAcQXgTBFnTIYXrqxD/hX4Re
 6r78Fsyx/PE+GP0xLXYCZ5z1Pw/BGS96hTiZLJjhz91Qt0wdOMRMHp5leOqcWXSO4hZ/YsUcHor
 Yw5sNvAu1pYI59Kh1Otad1ws1lHFmFFNjE+eEkLQF6r1GDF/2EU/zGKDKaAcl2Q2sxmeU09SGUO
 NTt0tDRTvUuNWJ32Mnghz0h55YVm0FNVfUhKc9/DDrxyoj8mMIj7JOLYBfT9e4TzlvlwWnoEA6e
 tCiE6Tf+cNBlgAQOv0Yicd3UPDDTC5kgjFtoIAjAeyQimyxHALSzxprc4eX+5s0xBFAcunGDrab
 vN6AQswfquyKcu8GBnHOmRg/yCiIsQ==
X-Proofpoint-GUID: 1gBwm89w4hoMhQbuDEVLqCzFDKNAfyzS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_05,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1011 bulkscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509250174


On 9/24/2025 8:14 AM, Niklas Schnelle wrote:

> On s390, an individual PCI function can generally be identified by two
> IDs, depending on the scope and the platform configuration.
It would help to name the two IDs - FID and ???
> The first ID is the so-called FID, which is always available and
> identifies a PCI device uniquely within a machine. The FID may be
> virtualized by hypervisors, but on the LPAR level, the machine scope
> makes it impossible to reuse the same configuration based on FIDs on two
> different LPARs.
>
> Such matching LPAR configurations are useful, though, allowing
> standardized setups and booting a Linux installation on different
> machines. To allow this, a second user-defined identifier called UID was
> introduced. It is only guaranteed to be unique within an LPAR and only
> if the platform indicates so via the UID Checking flag.
The paragraph as I read is not clear. Your intention is to highlight the 
need for UID to allow standardized setups.
>
> On s390, which uses a machine hypervisor, a per PCI function hotplug
> model is used. The shortcoming with the UID then is, that it is not
> visible to the user without first attaching the PCI function and
> accessing the "uid" device attribute. The FID, on the other hand, is
> used as slot number and is thus known even with the PCI function in
> standby.
>
> Remedy this shortcoming by providing the UID as an attribute on the slot
> allowing the user to identify a PCI function based on the UID without
> having to first attach it. Do this via a macro mechanism analogous to
> what was introduced by commit 265baca69a07 ("s390/pci: Stop usurping
> pdev->dev.groups") for the PCI device attributes.
>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Note: I considered adding the UID as a generic "index" via the hotplug
> slot driver but opted for a minimal solution to open the discussion. In
> particular my concern with a generic attribute is that it would be hard
> to find a format that fits everyone. For example on PCI devices we also
> use the "index" attribute for UIDs analogous to SMBIOS but having it in
> decimal is odd on s390 where these are usual in hexadecimal.
> ---
>   arch/s390/include/asm/pci.h |  4 ++++
>   arch/s390/pci/pci_sysfs.c   | 20 ++++++++++++++++++++
>   drivers/pci/slot.c          | 13 ++++++++++++-
>   3 files changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 41f900f693d92522ff729829e446b581977ef3ff..23eed78d9dce72ef466679f31c78aca52ba00f99 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -207,6 +207,10 @@ extern const struct attribute_group zpci_ident_attr_group;
>   			    &pfip_attr_group,		 \
>   			    &zpci_ident_attr_group,
>   
> +extern const struct attribute_group zpci_slot_attr_group;
> +
> +#define ARCH_PCI_SLOT_GROUPS (&zpci_slot_attr_group)
> +
>   extern unsigned int s390_pci_force_floating __initdata;
>   extern unsigned int s390_pci_no_rid;
>   

Will this not lead to linking error when the patch is built on non-s390 
architecture. You could refer to zpci_slot_attr_group using a 
CONFIG_..... and discard the #define ARCH_PCI_SLOT_GROUPS. I didn't find 
a relevant CONFIG_... that could be used.


> diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
> index 0ee0924cfab7e5d22468fb197ee78cac679d8c13..997dff3796094680d9a3f0b6eb27a89fa1ed30b2 100644
> --- a/arch/s390/pci/pci_sysfs.c
> +++ b/arch/s390/pci/pci_sysfs.c
> @@ -178,6 +178,17 @@ static ssize_t index_show(struct device *dev,
>   }
>   static DEVICE_ATTR_RO(index);
>   
> +static ssize_t zpci_uid_slot_show(struct pci_slot *slot, char *buf)
> +{
> +	struct zpci_dev *zdev = container_of(slot->hotplug, struct zpci_dev,
> +					     hotplug_slot);
> +
> +	return sysfs_emit(buf, "0x%x\n", zdev->uid);
> +}
> +
> +static struct pci_slot_attribute zpci_slot_attr_uid =
> +	__ATTR(uid, 0444, zpci_uid_slot_show, NULL);
> +
>   static umode_t zpci_index_is_visible(struct kobject *kobj,
>   				     struct attribute *attr, int n)
>   {
> @@ -233,3 +244,12 @@ const struct attribute_group pfip_attr_group = {
>   	.name = "pfip",
>   	.attrs = pfip_attrs,
>   };
> +
> +static struct attribute *zpci_slot_attrs[] = {
> +	&zpci_slot_attr_uid.attr,
> +	NULL,
> +};
> +
> +const struct attribute_group zpci_slot_attr_group = {
> +	.attrs = zpci_slot_attrs,
> +};
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 50fb3eb595fe65e271b6b339d43c9677c61b1e45..7430c7df44e1beef7bcf0531491612734e0dd60c 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -96,7 +96,18 @@ static struct attribute *pci_slot_default_attrs[] = {
>   	&pci_slot_attr_cur_speed.attr,
>   	NULL,
>   };
> -ATTRIBUTE_GROUPS(pci_slot_default);
> +
> +static const struct attribute_group pci_slot_default_group = {
> +	.attrs = pci_slot_default_attrs,
> +};
> +
> +const struct attribute_group *pci_slot_default_groups[] = {
> +	&pci_slot_default_group,
> +#ifdef ARCH_PCI_SLOT_GROUPS
> +	ARCH_PCI_SLOT_GROUPS,
> +#endif
> +	NULL,
> +};
>   
>   static const struct kobj_type pci_slot_ktype = {
>   	.sysfs_ops = &pci_slot_sysfs_ops,
>
> ---
> base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
> change-id: 20250923-uid_slot-e3559cf5ca30
>
> Best regards,

