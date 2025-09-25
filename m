Return-Path: <linux-pci+bounces-36932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE09DB9DD82
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 09:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 111157A6AB3
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 07:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044242BB13;
	Thu, 25 Sep 2025 07:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lEZCB2kg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712311917CD;
	Thu, 25 Sep 2025 07:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758785121; cv=none; b=HV80UdkfMH4wqu0Fmokp4by2v2XbE1tz8/OSY0HzkyEN0CQI/0ACulHdNuYfoBcM7EXeOh/wOS8EkT3ols07P6vlA3lvH7lr1wV4g5NMSwkr8HNR633TSs8i3NB2UzEUZdVzrQm1pMO9+tTMnwXfPQAgLe8FSD7+/29jX+DOoVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758785121; c=relaxed/simple;
	bh=nxWFw1jl1j40mAPraFTeSf1jXNOafkVXS05FdGMnnDQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HM4+eY0uMY6L+4vdDF6SdYhBJMj+ttQAq2ISt02dtrrWYwxvAOqcgUtBixmKgXonOo2rLGz9Rcnk3g5nu8XXw2IeUWm5ZS51hNw8fdbxLruyP7vvpQZBStgafi/9onKhHbdAcjQN/kdknfVcBNmYQOywKSbZx6DHnP8ghPG0Voo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lEZCB2kg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OICfJ6017068;
	Thu, 25 Sep 2025 07:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oelXLP
	9S2Lvd2qZxyPFyJALvYp5VEJj9SFCRV8uEpdg=; b=lEZCB2kgudyDSUXje2/j8M
	VEgZwFDIhfovqKxeMYNkpfAAwxRNoCiuiO7bpmHSDvqSxi8Phj4M7qY7S9EHRS35
	YG/NdyyqD5l814g9ajybp6ZS+sfDRlAXxBMrG1nCWh9e0iF2HXySFNYTbVoScyJH
	Ad0srs3UHLVpQF1RJ+Th03BHfSgiI6Xy8jxHKnWGrAgnkykBL3Fj2pyMPCNV2ffR
	ZQRn1aOrQiE5rFd9PZVz81Y2rdI+UUdLlGBjXIzRjAbV3p42ph6xBCeWsx1F8J3J
	NiRn4Fq51cIkw9fs5eSmlGT6WggP/SOIphb3Uhk8TqbcAjRAw/NuMp8aZcUx+fCQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky6c7t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 07:25:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58P74vAl030345;
	Thu, 25 Sep 2025 07:25:15 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a1ccc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 07:25:15 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58P7P3dh27329242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 07:25:03 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18F8958061;
	Thu, 25 Sep 2025 07:25:14 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5772358043;
	Thu, 25 Sep 2025 07:25:11 +0000 (GMT)
Received: from [9.111.71.247] (unknown [9.111.71.247])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Sep 2025 07:25:11 +0000 (GMT)
Message-ID: <ac80630fda0c85ee1194ab08974aaf5f93e09cf9.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] PCI: Add lockdep assertion in
 pci_stop_and_remove_bus_device()
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Farhan Ali <alifm@linux.ibm.com>, Bjorn Helgaas <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Cc: Keith Busch <kbusch@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Benjamin Block
 <bblock@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Julian Ruess
 <julianr@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Thu, 25 Sep 2025 09:25:10 +0200
In-Reply-To: <48360cde-81d9-4161-8c32-0029e193c685@linux.ibm.com>
References: <20250826-pci_fix_sriov_disable-v1-0-2d0bc938f2a3@linux.ibm.com>
	 <20250826-pci_fix_sriov_disable-v1-2-2d0bc938f2a3@linux.ibm.com>
	 <48360cde-81d9-4161-8c32-0029e193c685@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
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
X-Proofpoint-ORIG-GUID: 6J7bma58VEgekfdFMDTKOyDUaeYB7oZQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfX4ln8H2+mjOuR
 ou6YFj+XANFG6EoILNDVuIfl05Nr2waFFUzUugWr6t+tE/OkGSe0Nf8/UD3onwGnJqph/ZxSGCH
 bA0y54G7Jb6+PTV82rn25ASkMoiV2rBYQanwaCwslaIbBcsjR8N3gGCqEm3cHR4CJ5BJwLgNPqC
 zSDw29LfSNWGLR/fv9wf+3iUch8WmA9o3EV9kDArwhCE50/9a8h5Ddu+Kx1sHc21Vr4vGrXinWu
 Ne0Gmtf4Gd9ARWYuQWURSjT6O4I5OD6BvUZvpoE/ndj4iSSsizC3zf0+ugOyI8CrJrZw0nRAApC
 jTzJXBseScDG515prV90mfhgrZNYcBVTxIOaompi0T/8erXmmHLSZSEaz0sEhIJB4vqV05PSOlo
 ogErLF06
X-Authority-Analysis: v=2.4 cv=XYGJzJ55 c=1 sm=1 tr=0 ts=68d4ee5c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=SWXGiXNOFDov8wDKaFwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6J7bma58VEgekfdFMDTKOyDUaeYB7oZQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020

On Wed, 2025-09-24 at 11:06 -0700, Farhan Ali wrote:
> On 8/26/2025 1:52 AM, Niklas Schnelle wrote:
> > Removing a PCI devices requires holding pci_rescan_remove_lock. Prompte=
d
> > by this being missed in sriov_disable() and going unnoticed since its
> > inception add a lockdep assert so this doesn't get missed again in the
> > future.
> >=20
> > Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >   drivers/pci/pci.h    | 2 ++
> >   drivers/pci/probe.c  | 2 +-
> >   drivers/pci/remove.c | 1 +
> >   3 files changed, 4 insertions(+), 1 deletion(-)
> >=20
--- snip ---
> > diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> > index 445afdfa6498edc88f1ef89df279af1419025495..0b9a609392cecba36a818bc=
496a0af64061c259a 100644
> > --- a/drivers/pci/remove.c
> > +++ b/drivers/pci/remove.c
> > @@ -138,6 +138,7 @@ static void pci_remove_bus_device(struct pci_dev *d=
ev)
> >    */
> >   void pci_stop_and_remove_bus_device(struct pci_dev *dev)
> >   {
> > +	lockdep_assert_held(&pci_rescan_remove_lock);
> >   	pci_stop_bus_device(dev);
> >   	pci_remove_bus_device(dev);
> >   }
>=20
> We also have the function pci_stop_and_remove_bus_device_locked() as=20
> Gerd mentioned, so is pci_stop_and_remove_bus_device meant to be called=
=20
> without the rescan_remove_lock held? This is a little confusing as we=20
> shouldn't be adding/removing from the bus without the lock AFAIU, but=20
> maybe I am missing something?
>=20
> Thanks
> Farhan

As far as I understand one would use pci_stop_and_remove_bus_device()
if one is already holding the pci_rescan_remove_lock and
pci_stop_and_remove_bus_device_locked() if one only needs to take it
for that call. I think this is kind of easy to get confused about so
this lockdep assertion is even more useful.

