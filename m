Return-Path: <linux-pci+bounces-33225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF2FB16CC7
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 09:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11AB03BD79D
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 07:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ECA23F271;
	Thu, 31 Jul 2025 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CmNQCKQK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DE72222B0;
	Thu, 31 Jul 2025 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753947156; cv=none; b=UUA43S4O+gedzTMK0A1so63XDAvLbVJzS9mEeXYbkMZTMGsLrWcVTkcYyRm+8yQBo3yY1CC/jVtX718ufZPys0zawaZEK/Vndy/esGFvmAuUW4hl/YMHyUJMJ0GD553XQPwzOLxFBt0AYpBoORaPVoVC3LzSmvtqSt9abIHEb6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753947156; c=relaxed/simple;
	bh=z7pFjNjWDih41OQ9FQcNBxcFQyVnR4OoYFkigAzEPrA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QumBmvIyj5UuniFUFy7aKQuy9s5VJQCmHh0k8tXj9bWKUANbpiNK9kQkQyc66vWTxMH0IcHy2MGhyRsHe96lsW5un/PjiG6zx5J5IW4hl/vep0jTTMgWW5CmF85uLVC4zFhs6eOE32OUENn7JIfu0N2FRgYbwbTUyPW82LZ+qDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CmNQCKQK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V0sdKe025684;
	Thu, 31 Jul 2025 07:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uUyTXj
	Zkvc90WIHFyUhU8UK3/I+tu9+4DNIOI8WmYAw=; b=CmNQCKQKSIVPSccOVa1fFK
	8e9SzWp9W37pDFWMVpj+tbajFFX1hHbb6I7IEszN0FAov8dm3SoScHpN28EfqBUb
	6PbLBi62fGhCfByYMbtCWvq0LPiTZuJMBwZEDZcLoKH25+Hzj1m99fvW/Dv2X62w
	Z8UYqDNAcpYIymYhr0k0yMU2eIoQ7w/4exzNAJjjK9LB6+J7ct3uSfAZ9K6VodkJ
	HAcqjocY4zjeFftgAKcdx16RhPRaW2vBKxy7GhsBRaYWnFvbPtMW+mjqa9dfun3I
	xLEnY3+2/MIOEY4n9Xjs5xh+LFb/JJvFrl8oQC0e3hvLwRuxNQYOKXDLqHWSer2A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 487bu06st2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 07:32:30 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56V7O90c003745;
	Thu, 31 Jul 2025 07:32:29 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 487bu06ssv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 07:32:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56V3eRbP015956;
	Thu, 31 Jul 2025 07:32:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 485aumuapm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 07:32:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56V7WPmV32113070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 07:32:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0722420040;
	Thu, 31 Jul 2025 07:32:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B776220043;
	Thu, 31 Jul 2025 07:32:23 +0000 (GMT)
Received: from [9.87.159.242] (unknown [9.87.159.242])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 31 Jul 2025 07:32:23 +0000 (GMT)
Message-ID: <4e10bea3aa91ee721bb40e9388e8f72f930908fe.camel@linux.ibm.com>
Subject: [REGRESSION] next/master: suspect endianness issue in common PCI
 capability search macro
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Hans Zhang <18255117159@163.com>,
        linux-next@vger.kernel.org
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
        jingoohan1@gmail.com, mani@kernel.org, robh@kernel.org,
        ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, schnelle@linux.ibm.com
Date: Thu, 31 Jul 2025 09:32:23 +0200
In-Reply-To: <20250716231121.GA2564572@bhelgaas>
References: <20250716231121.GA2564572@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZNPXmW7b c=1 sm=1 tr=0 ts=688b1c0e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=A4e6Yjo2IE6HYS_LnI8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: z7Hr9UIe-v1TsjJvsnV0WSNS8tsmGhhn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA0OSBTYWx0ZWRfX4oHyLBjs5Gz7
 pbDZrHfAYKG0IsJDaXw9ejyhncre6oHqN1XwwVNDI7qmfg0N4PjOCPmOF5zp0hv2fjT7dIOUOj8
 RxnQR9yRw5t6mS3X/j5Nu2QDu3P74m2pg1KMGrbclpmKByMWDNHd+bZgPtnE3n9p86gPiWreV9g
 HMFEPVs1mx/uu8hVdPY3QhwlLoTyha5y6IEbXhchJl2fh/+NGgiEpWUrrxwcSCSqIt8WdVIdJRr
 tovrfu1uJU3Tw1lUioFsdgbp7Nwl6/UDy63FeDcFQQ1/idm8MOjrzQuKdC7Eg7ZjZwGRe0/T6J8
 bjzmiLZmpm4Yc1uMw7BArC4pNgcqn16+4FipHKeIUbV2vOWxch4dIGSYTy7NH0qnXWP4D+z0d3u
 llgWXILxqcMh50K3dFJTQnVsuZXjTwMVF3NmFRgj2ETeRBQ2pEdAncZ+fkEpJi29x5NqQ1YX
X-Proofpoint-GUID: mkxtLzpKjxBiUzBb4HUef2V94zeF9hrv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507310049

On Wed, 2025-07-16 at 18:11 -0500, Bjorn Helgaas wrote:
> On Thu, Jul 17, 2025 at 12:11:56AM +0800, Hans Zhang wrote:

<--- snip --->

> >=20
> >=20
> > Hans Zhang (7):
> >   PCI: Introduce generic bus config read helper function
> >   PCI: Clean up __pci_find_next_cap_ttl() readability
> >   PCI: Refactor standard capability search into common macro
> >   PCI: Refactor extended capability search into common macro
> >   PCI: dwc: Use common PCI host bridge APIs for finding the capabilitie=
s
> >   PCI: cadence: Use common PCI host bridge APIs for finding the
> >     capabilities
> >   PCI: cadence: Use cdns_pcie_find_*capability to avoid hardcode
> >=20
> >  drivers/pci/access.c                          | 15 ++++
> >  .../pci/controller/cadence/pcie-cadence-ep.c  | 38 ++++----
> >  drivers/pci/controller/cadence/pcie-cadence.c | 30 +++++++
> >  drivers/pci/controller/cadence/pcie-cadence.h | 18 ++--
> >  drivers/pci/controller/dwc/pcie-designware.c  | 83 ++++--------------
> >  drivers/pci/pci.c                             | 76 +++-------------
> >  drivers/pci/pci.h                             | 87 +++++++++++++++++++
> >  include/uapi/linux/pci_regs.h                 |  3 +
> >  8 files changed, 196 insertions(+), 154 deletions(-)
> >=20
> >=20
> > base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
>=20
> Applied to pci/capability-search for v6.17, thanks for all this work!

Dear all,

with this series commit 2502a619108b ("PCI: Refactor extended
capability search into PCI_FIND_NEXT_EXT_CAP()")
has landed in linux-next.

This breaks PCI capability search on our s390 test systems - that
showed through mlx5_core's error while binding:

[   27.158991] mlx5_core a000:00:00.0: mlx5_load:1355:(pid 998): Failed
to alloc IRQs

apparently, due to struct pci_dev not showing that it is MSI-X capable.
With this commit reverted, mlx5_core binds successfully again.

I'm sending this as a heads-up while I'll continue to debug this
further - presumably an endianness issue in the macro
PCI_FIND_NEXT_EXT_CAP.

Thanks,
Gerd

