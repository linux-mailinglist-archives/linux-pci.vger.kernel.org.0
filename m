Return-Path: <linux-pci+bounces-37102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 471EABA435D
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 16:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B42887BD264
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 14:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0CD1F560B;
	Fri, 26 Sep 2025 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A1POXBgd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5D71F460B;
	Fri, 26 Sep 2025 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896843; cv=none; b=MQW54c7KkBFuffmMS7GOYPDTlEsm6k9Fg/VK/IsZ7AOW01P1M8EAcY6EvR60eTMxPpLXWc1IZEGDbf5oiob6M7UGHAX0d5qBzBVFh7sXkyEk/eXZMkTWhD6ONR/7BZ2l6XfeeOm+deHTeETvXLURh7aX99alr7EF+H5qvX6eU1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896843; c=relaxed/simple;
	bh=u54T70t2/NPnIH1JLcp1TDGROghHZrCaOS3b0VSL4fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hbx/3alISGkbhj9BdBynwNbFO4tZk/DdTqJdCrMKVDdRailRhOYAobzoWKE7Z6lTXN/AQTEvcMzgkQh3ntY5Z4GqOmUxJ5x6drNKYfaOCSs206ohaVaaK26DZTbrEWEB8fZ/7g4vJQzPJAtgBzULjFrVNBSDk2kH/Sg6ZdeVjPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A1POXBgd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q7DG09029856;
	Fri, 26 Sep 2025 14:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=R35Gxu9tgHOmxci6XRkN5tK9g9p8bMq5zSdxG/8afJw=; b=A1POXBgdHX8j
	nwEfRH0JKVNRajXP3825SFJxEzSJ9EyO2zNZMesqJqpcM1JK6O83oeKtzd00u4hL
	iX7qzWU/IPaS6Ipmb55juOQrqSee38+CVY1qpo+HxttQP01/mJ+Fe5omw1QB/zcx
	2IHrM2XcMKU91UqLGB1j+ypGz3qUsvuszA0oKTIdbPFKJVeAlHTWO2Dndvlpl9HC
	kG60HxwsQEwx2jx8fYPfURpXDCLYlwbx7CUEi8kmadh2Biz5GffnbQtuZoHkBkU3
	xAwHpu2E0jtd5iSiqGJIR1r8TcLaxyE83+FwpEJkZPhh3cEehkL+Se71dHXPa8ZC
	ImSkd1zI+w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbbamyeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 14:27:20 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58QEMLof017627;
	Fri, 26 Sep 2025 14:27:20 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbbamyec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 14:27:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58QEDD8Q030034;
	Fri, 26 Sep 2025 14:27:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49dawmcgav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 14:27:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58QERF8941812428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Sep 2025 14:27:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 281202004B;
	Fri, 26 Sep 2025 14:27:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 152E920043;
	Fri, 26 Sep 2025 14:27:15 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.152.212.182])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 26 Sep 2025 14:27:15 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.98.2)
	(envelope-from <bblock@linux.ibm.com>)
	id 1v29Pm-000000028X7-3SYj;
	Fri, 26 Sep 2025 16:27:14 +0200
Date: Fri, 26 Sep 2025 16:27:14 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: s390: Expose the UID as an arch specific PCI slot
 attribute
Message-ID: <20250926142714.GB17059@p1gen4-pw042f0m.boeblingen.de.ibm.com>
References: <20250924-uid_slot-v1-1-09ae04f48c57@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250924-uid_slot-v1-1-09ae04f48c57@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7Ow6O-5xT9bJWZY2QIoR0fgdJIV1moGj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3NCBTYWx0ZWRfX629BQMJNe9b3
 Kh5sFw4/tstXt397kDjJDsKztqQqKbMErCxyNM1lzRZQBZE9sQ/r7zRuIOnheTG2m/x+AdLekoR
 VnCgk1iL/CNkirZt3ZnpY2964rlmX1J9YnR13id+fjEhC3rFGTyKARYpPZGqpdCpPsZyeRCh2ds
 M3GUxU4k/FQZMOOlfz6rsV1XXAedMv9cYhhHN3xrXrBpTfB83Engp5xZ4/DS5BMulhre8n4Wyoz
 j6wLUq6sWONkHycXlNsRuPEp5vxONJ0EjXAfab906C8jfux9XyOqDtz1PcP4LvICiw35xE6tyo4
 pkE5gGXp2MCLK3lFDYh0U4FQNXj+Ta15cTTOUQRztchSXEYqACHMVLnitCEiC6n+HjscToT6Kak
 4x74ARspZ6TLHjU/KeA71U/0JH6hmg==
X-Proofpoint-ORIG-GUID: a3rG87gkYAlXMzNmAeR-q2lI5lXtlU5b
X-Authority-Analysis: v=2.4 cv=B6W0EetM c=1 sm=1 tr=0 ts=68d6a2c8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=iu2MVtCyA_F__U3CG2QA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_05,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250174

> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 41f900f693d92522ff729829e446b581977ef3ff..23eed78d9dce72ef466679f31c78aca52ba00f99 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -207,6 +207,10 @@ extern const struct attribute_group zpci_ident_attr_group;
>  			    &pfip_attr_group,		 \
>  			    &zpci_ident_attr_group,
>  
> +extern const struct attribute_group zpci_slot_attr_group;
> +
> +#define ARCH_PCI_SLOT_GROUPS (&zpci_slot_attr_group)

I don't know the history exactly, but this can't be easily extended like the
other group above `ARCH_PCI_DEV_GROUPS`.

    (&zpci_slot_attr_group,  \
     &zpci_slot_attr_group_b)

Won't compile. The way `ARCH_PCI_DEV_GROUPS` does it, attaching a different
group is just adding a new line.

> diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
> index 0ee0924cfab7e5d22468fb197ee78cac679d8c13..997dff3796094680d9a3f0b6eb27a89fa1ed30b2 100644
> --- a/arch/s390/pci/pci_sysfs.c
> +++ b/arch/s390/pci/pci_sysfs.c
> @@ -178,6 +178,17 @@ static ssize_t index_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(index);
>  
> +static ssize_t zpci_uid_slot_show(struct pci_slot *slot, char *buf)
> +{
> +	struct zpci_dev *zdev = container_of(slot->hotplug, struct zpci_dev,
> +					     hotplug_slot);
> +
> +	return sysfs_emit(buf, "0x%x\n", zdev->uid);

Do we need a special case for when `uid` is 0? That would imply the uid is
invalid, right? Would we want to return an error in that case (-EINVAL, or
smth)? 

Also, do we want to use the same format as in `zpci_setup_bus_resources()`
with the 4 leading 0's (`0x%04x`)?

> +}
> +
> +static struct pci_slot_attribute zpci_slot_attr_uid =
> +	__ATTR(uid, 0444, zpci_uid_slot_show, NULL);

__ATTR_RO()?

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Böblingen     /    Registergericht: AmtsG Stuttgart, HRB 243294

