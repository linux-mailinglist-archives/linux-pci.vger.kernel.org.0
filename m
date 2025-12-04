Return-Path: <linux-pci+bounces-42616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C487CA3004
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 10:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7365A308A3AC
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 09:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0B729D26C;
	Thu,  4 Dec 2025 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QyYszx8K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFD21F1313;
	Thu,  4 Dec 2025 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764840461; cv=none; b=N0pIPW22DuQRVNZcVaM91vbX/fSqSwKayRSNXLJbFYaSCtVs/A9TvN+WR1aueq+bOKTsCReDf34jjFSHC0L8xzQ9LlmO5gpnM1vjTneegC7//IO5OoByGmyp+kaMY0MRrZ3q47DyZemYoz0ppf6wT7itws0D1jDy5wJDZZeqPQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764840461; c=relaxed/simple;
	bh=4R0/kdq1kDrH9rlTa5HdrwtuUwjK5q8Niro2tS5+znQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BHuuIKpcAZwaPb9P/j/srHIyHU4KN/QeZ2N88gL4AJ7XKNcgfSYDr4qRjFaQULep3mU2jYZCCftAOV69zfHwDk5LPwEcqTlA8NDKvQLwrewMETZ/Xh3CZAgkJ1U5Oa706/vaTBa1GMh9lUDvd/Rokrc0gz6Ac5tVqYeoTOq6OIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QyYszx8K; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3LWijQ021298;
	Thu, 4 Dec 2025 09:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4R0/kd
	q1kDrH9rlTa5HdrwtuUwjK5q8Niro2tS5+znQ=; b=QyYszx8KTiaD9h4BvwUnQ+
	Z4FyOmD966/EslMl+SHtkZA0Zl2t6ZjcqDXF3fjAso0S8V5OzD2nB4muf0wOJtbM
	dc3Ee7mtiixgD4zGiMhQI+Q5eq5ijLPd1RetEvIXtJt6ypkAL5LftEom3F8pDAMA
	tPhhk4cj0LFOPNwR3VefkNVIEBMLeKMd0mQaShXe4kN22eAdLiZj5+9vGw0CouwG
	N/9JKv9185CqXYinofmCoxn4Wyup8py/qme6iq+C3oH3w24gaWuVK6AiUWps7iIY
	LJqs8g3AYHK+roqL6K68KOGOsTFcPP+5HzlOvBvSjuFFNuCjFeSGx3RWxKRuRXwA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrh77jqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 09:27:38 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B49Q6Eq030902;
	Thu, 4 Dec 2025 09:27:38 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrh77jq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 09:27:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B49HVqV003853;
	Thu, 4 Dec 2025 09:27:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardcjxr22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 09:27:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B49RXUN10617280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Dec 2025 09:27:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3993E2004B;
	Thu,  4 Dec 2025 09:27:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D46A20043;
	Thu,  4 Dec 2025 09:27:32 +0000 (GMT)
Received: from localhost (unknown [9.111.15.26])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Dec 2025 09:27:32 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Dec 2025 10:27:32 +0100
Message-Id: <DEPBQ734VDZG.34XHQ5Z0KKLLQ@linux.ibm.com>
Cc: "Gerald Schaefer" <gerald.schaefer@linux.ibm.com>,
        "Christian
 Borntraeger" <borntraeger@linux.ibm.com>,
        "Gerd Bayer"
 <gbayer@linux.ibm.com>,
        "Matthew Rosato" <mjrosato@linux.ibm.com>,
        "Heiko
 Carstens" <hca@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Sven Schnelle"
 <svens@linux.ibm.com>,
        "Julian Ruess" <julianr@linux.ibm.com>,
        "Peter
 Oberparleiter" <oberpar@linux.ibm.com>,
        "Ramesh Errabolu"
 <ramesh@linux.ibm.com>,
        <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3] PCI: s390: Expose the UID as an arch specific PCI
 slot attribute
From: "Julian Ruess" <julianr@linux.ibm.com>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Bjorn Helgaas"
 <bhelgaas@google.com>,
        "Lukas Wunner" <lukas@wunner.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251015-uid_slot-v3-1-44389895c1bb@linux.ibm.com>
In-Reply-To: <20251015-uid_slot-v3-1-44389895c1bb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dK+rWeZb c=1 sm=1 tr=0 ts=6931540a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=nQX62fO2evfF4vuxvpEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gsZTTdGf4k7COCdSwmJNW6dWDAADTqLE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX7XEpTzeQE4I8
 aCh8tT6Y1Sg3eIWWgeQFpKyMl18IoPTl6MS4Z1pRAN4jA6HjEvJa923W+ly/9RZfWykeStYBI6D
 LrOu5rXM3KezFxb0FXVjxovP4bRVieHPDsN/tKCdxI71pir11HfoAqSBbZ4+pnX/pgMgtHyiwZh
 fPGVcmbEY8ijSrscwTmpu38TVGh3FAiHhh8BXbYoEwo3SG9ICH70SEfAeMUIMqcw74V/sBGoCxv
 NNaKKLe4j3zqxGEyfwa2zXVzwAw73EBGS5d7aikxrH2I2ZXphsXJR/VU+77oiPpQ0j9l4WGW1fP
 cfFtLGSA/3IAZPG9B+JCNvSxbrdzza77347F+3BcgiugbQhiHCneQu7gPuLhsv4dYb16LP1H07L
 rdLMlryz9Spy8shDgSkPbM8zxnIvZA==
X-Proofpoint-ORIG-GUID: TsS-lKvLY2UzPSwCKxngYMulZrmYrWzL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

On Wed Oct 15, 2025 at 3:42 PM CEST, Niklas Schnelle wrote:
> On s390, an individual PCI function can generally be identified by two
> identifiers, the FID and the UID. Which identifier is used depends on
> the scope and the platform configuration.
>
> The first identifier, the FID, is always available and identifies a PCI
> device uniquely within a machine. The FID may be virtualized by
> hypervisors, but on the LPAR level, the machine scope makes it
> impossible to create the same configuration based on FIDs on two
> different LPARs of the same machine, and difficult to reuse across
> machines.
>
> Such matching LPAR configurations are useful, though, allowing
> standardized setups and booting a Linux installation on different LPARs.
> To this end the UID, or user-defined identifier, was introduced. While
> it is only guaranteed to be unique within an LPAR and only if indicated
> by firmware, it allows users to replicate PCI device setups.
>
> On s390, which uses a machine hypervisor, a per PCI function hotplug
> model is used. The shortcoming with the UID then is, that it is not
> visible to the user without first attaching the PCI function and
> accessing the "uid" device attribute. The FID, on the other hand, is
> used as the slot name and is thus known even with the PCI function in
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
> slot driver but felt like there is probably too little commonality on
> format and usage patterns.
>
> v2->v3:
> - Rebase on v6.18-rc1 and resolve conflict with recent s390 PCI sysfs cha=
nge
> - Link to v2: https://lore.kernel.org/r/20251008-uid_slot-v2-1-ef22cef277=
41@linux.ibm.com
> ---

-- snip --

Feel free to add my
Reviewed-by: Julian Ruess <julianr@linux.ibm.com>

Thanks,
Julian

