Return-Path: <linux-pci+bounces-34071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E118CB2703C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 22:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4EB624605
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 20:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19480266B59;
	Thu, 14 Aug 2025 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UIc5ogp2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0C226657B;
	Thu, 14 Aug 2025 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755203839; cv=none; b=t94JEFqIhmO2wwN5ptnhlqBXIrDVX3EJxTnaoXjJ8kPHlbFyuhQs0dyn5OMAosway9Oa54Ol4wktZGEErXUQsGoCZJVcP6mvKgq4ThDEf7xgTAu5s/xVry7V+bYkpNgFT15v7VsYuFzMCJ1+ED2ncpQKlu3wxJigBrwa4ct2v2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755203839; c=relaxed/simple;
	bh=CsTGCaFEa0M8a9vf+3fRZ8vdr9KeNpa95yrdsyyEIuw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XDgpjavTHHsi1OEbMb4BvD0b1cTg1QUWb5R6oHnQfCKg8tEuzYeTLal9knuefdUuYtVpYJ1loQDW8+7LUwx9jw1UpESsiDC0H1aBpRXwok6PzJ5VXUZ6GNB3DKsYrENIbeX6iOpsOt3Zfw2nYYS1qOBx+oxEO2IyoasMOjySWds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UIc5ogp2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EEVTbA029871;
	Thu, 14 Aug 2025 20:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=igYJE+
	jIx2kgg88T3sUY+j2eGFqr8sHlLJYHmWNNWB8=; b=UIc5ogp2rW07b7WzZJglBa
	2bqjHw6h4oopNoniGpV6riG+0hvOLm/t6N/WI85GSk6Im9bl7y4ySpZX4jRZgLl0
	X1dMUicAjxhhIsxfk0pdVC6FvBG8eBNDDX7UV6dDii5Hxy+5idAQ9bxK/MXrVrcN
	+LLy4c/9twJCD2HldfJ8kFeIt+Q+5IZp/p4SLqrejCorchADClCROZTTJ3Sp3Zgk
	qkd3TgexsVff/kDx+yXNcxgBuDyw76/RWftoeLWNapTrzhzzAx2tGhAdUnbWz+vs
	55K3samT7QIh4ZNaybyT1yWwaAzvvgBEjHaFSSSop5mNkKdT4BgO+OGTnWE/xHDw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrpc470-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 20:37:09 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57EKb8kI009172;
	Thu, 14 Aug 2025 20:37:08 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrpc46v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 20:37:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57EJ17QR017617;
	Thu, 14 Aug 2025 20:37:07 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc3wk5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 20:37:07 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57EKb7Cf24642192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 20:37:07 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC8E758055;
	Thu, 14 Aug 2025 20:37:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A06A558043;
	Thu, 14 Aug 2025 20:37:04 +0000 (GMT)
Received: from [9.87.142.31] (unknown [9.87.142.31])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Aug 2025 20:37:04 +0000 (GMT)
Message-ID: <fbc95b8020a152d487ada00e9751c2b3f602c11d.camel@linux.ibm.com>
Subject: Re: [PATCH v15 0/6] Refactor capability search into common macros
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
        jingoohan1@gmail.com, mani@kernel.org, robh@kernel.org,
        ilpo.jarvinen@linux.intel.com, gbayer@linux.ibm.com, lukas@wunner.de,
        arnd@kernel.org, geert@linux-m68k.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Thu, 14 Aug 2025 22:37:03 +0200
In-Reply-To: <20250814202519.GA344690@bhelgaas>
References: <20250814202519.GA344690@bhelgaas>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIxOSBTYWx0ZWRfX5qIsWOFrKYv9
 Shi8GV5/1i23taZadhstB9u0eo8h8gkX7jPHT4if5FquP/GYdWb7eaIh5q8oPybfyAhftJhZ5PR
 VGytS0QJ7IZUdsdiZiNaYSHS4Mkmg3LKGN48olj5DQvhiQi7ORIRslet6KKKDg5+qCj5wWBeIbq
 jVRRcV7fb44WNP+aNl0w+ItDYQ0Mp0gc3jObrLhQ3dB49/iNzetqGjGKhGU9qqGKOLE4YaeZXod
 XPbYak5U3I3shscDeVJnRU84eF1IVuhrEMWDZ/o33MBBPEiSayoSh4PMEFCYxPdo3Dvf5zRP7HB
 n4W9YEWSR6H/BqesCyJcnpU9X8lJRSqGL3Iq027dYmDxHTH3IyizwUi09vSAAumPRtyMTJerBcG
 O4svqrsi
X-Authority-Analysis: v=2.4 cv=GrpC+l1C c=1 sm=1 tr=0 ts=689e48f5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gQ27z8APxGeO8Qaxl6kA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: d_0algRA7TWPDigpYiIl381lCVkteyyi
X-Proofpoint-ORIG-GUID: ry_BiseFHOJhWaZtq--AlBs6DrYHGi_5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120219

On Thu, 2025-08-14 at 15:25 -0500, Bjorn Helgaas wrote:
> On Wed, Aug 13, 2025 at 10:45:23PM +0800, Hans Zhang wrote:
> > Dear Maintainers,
> >=20
> > This patch series addresses long-standing code duplication in PCI
> > capability discovery logic across the PCI core and controller drivers.
> > The existing implementation ties capability search to fully initialized
> > PCI device structures, limiting its usability during early controller
> > initialization phases where device/bus structures may not yet be
> > available.
> >=20
> > The primary goal is to decouple capability discovery from PCI device
> > dependencies by introducing a unified framework using config space
> > accessor-based macros. This enables:
> >=20
> > 1. Early Capability Discovery: Host controllers (e.g., Cadence, DWC)
> > can now perform capability searches during pre-initialization stages
> > using their native config accessors.
> >=20
> > 2. Code Consolidation: Common logic for standard and extended capabilit=
y
> > searches is refactored into shared macros (`PCI_FIND_NEXT_CAP` and
> > `PCI_FIND_NEXT_EXT_CAP`), eliminating redundant implementations.
> >=20
> > 3. Safety and Maintainability: TTL checks are centralized within the
> > macros to prevent infinite loops, while hardcoded offsets in drivers
> > are replaced with dynamic discovery, reducing fragility.
> >=20
> > Key improvements include: =20
> > - Driver Conversions: DesignWare and Cadence drivers are migrated to
> >   use the new macros, removing device-specific assumptions and ensuring
> >   consistent error handling.
> >=20
> > - Enhanced Readability: Magic numbers are replaced with symbolic
> >   constants, and config space accessors are standardized for clarity.
> >=20
> > - Backward Compatibility: Existing PCI core behavior remains unchanged.
> >=20
> > ---
> > Dear Niklas and Gerd,
> >=20
> > Can you test this series of patches on the s390?
> >=20
> > Thank you very much.
> > ---
> >=20
> > ---
> > Changes since v14:
> > - Delete the first patch in the v14 series.
> > - The functions that can obtain the values of the registers u8/u16/u32 =
are
> >   directly called in PCI_FIND_NEXT_CAP() and PCI_FIND_NEXT_EXT_CAP().
> >   Use the pci_bus_read_config_byte/word/dword function directly.
> > - Delete dw_pcie_read_cfg and redefine three functions: dw_pcie_read_cf=
g_byte/word/dword.
> > - Delete cdns_pcie_read_cfg and redefine three functions: cdns_pcie_rea=
d_cfg_byte/word/dword.
> >=20
> > Changes since v13:
> > - Split patch 3/6 into two patches for searching standard and extended =
capability. (Bjorn)
> > - Optimize the code based on the review comments from Bjorn.
> > - Patch 5/7 and 6/7 use simplified macro definitions: PCI_FIND_NEXT_CAP=
(), PCI_FIND_NEXT_EXT_CAP().
> > - The other patches have not been modified.
> >=20
> > Changes since v12:
> > - Modify some commit messages, code format issues, and optimize the fun=
ction return values.
> >=20
> > Changes since v11:
> > - Resolved some compilation warning.
> > - Add some include.
> > - Add the *** BLURB HERE *** description(Corrected by Mani and Krzyszto=
f).
> >=20
> > Changes since v10:
> > - The patch [v10 2/6] remove #include <uapi/linux/pci_regs.h> and add m=
acro definition comments.
> > - The patch [v10 3/6] remove #include <uapi/linux/pci_regs.h> and commi=
t message were modified.
> > - The other patches have not been modified.
> >=20
> > Changes since v9:
> > - Resolved [v9 4/6] compilation error.
> >   The latest 6.15 rc1 merge __dw_pcie_find_vsec_capability, which uses=
=20
> >   dw_pcie_find_next_ext_capability.
> > - The other patches have not been modified.
> >=20
> > Changes since v8:
> > - Split patch.
> > - The patch commit message were modified.
> > - Other patches(4/6, 5/6, 6/6) are unchanged.
> >=20
> > Changes since v7:
> > - Patch 2/5 and 3/5 compilation error resolved.
> > - Other patches are unchanged.
> >=20
> > Changes since v6:
> > - Refactor capability search into common macros.
> > - Delete pci-host-helpers.c and MAINTAINERS.
> >=20
> > Changes since v5:
> > - If you put the helpers in drivers/pci/pci.c, they unnecessarily enlar=
ge
> >   the kernel's .text section even if it's known already at compile time
> >   that they're never going to be used (e.g. on x86).
> > - Move the API for find capabilitys to a new file called
> >   pci-host-helpers.c.
> > - Add new patch for MAINTAINERS.
> >=20
> > Changes since v4:
> > - Resolved [v4 1/4] compilation warning.
> > - The patch subject and commit message were modified.
> >=20
> > Changes since v3:
> > - Resolved [v3 1/4] compilation error.
> > - Other patches are not modified.
> >=20
> > Changes since v2:
> > - Add and split into a series of patches.
> > ---
> >=20
> > Hans Zhang (6):
> >   PCI: Clean up __pci_find_next_cap_ttl() readability
> >   PCI: Refactor capability search into PCI_FIND_NEXT_CAP()
> >   PCI: Refactor extended capability search into PCI_FIND_NEXT_EXT_CAP()
> >   PCI: dwc: Use PCI core APIs to find capabilities
> >   PCI: cadence: Use PCI core APIs to find capabilities
> >   PCI: cadence: Use cdns_pcie_find_*capability() to avoid hardcoding
> >     offsets
> >=20
> >  .../pci/controller/cadence/pcie-cadence-ep.c  | 38 +++++----
> >  drivers/pci/controller/cadence/pcie-cadence.c | 14 +++
> >  drivers/pci/controller/cadence/pcie-cadence.h | 39 +++++++--
> >  drivers/pci/controller/dwc/pcie-designware.c  | 77 ++---------------
> >  drivers/pci/controller/dwc/pcie-designware.h  | 21 +++++
> >  drivers/pci/pci.c                             | 76 +++--------------
> >  drivers/pci/pci.h                             | 85 +++++++++++++++++++
> >  include/uapi/linux/pci_regs.h                 |  3 +
> >  8 files changed, 194 insertions(+), 159 deletions(-)
>=20
> I applied this on pci/capability-search for v6.18, thanks!
>=20
> Niklas, I added your Tested-by, omitting the dwc and cadence patches
> because I think you tested s390 and probably didn't exercise dwc or
> cadence.  Thanks very much to you and Gerd for finding the issue and
> testing the resolution!
>=20
> Bjorn

Thanks, yes leaving out dwc and cadence makes sense. Though I do often
also test on my private x86 systems this one was s390 only. Since I
have you here and as you applied this one now and Lukas PCI/ERR stuff
yesterday, is it possible that my series titled "PCI/ERR: s390/pci: Use
pci_uevent_ers() in PCI recovery" somehow fell through your mail
filters maybe due to not having any "PCI:" in a subject?

Thanks,
Niklas

