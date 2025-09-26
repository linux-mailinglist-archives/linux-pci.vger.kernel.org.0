Return-Path: <linux-pci+bounces-37087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F972BA3206
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 11:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01DBD1B22A87
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 09:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F610271475;
	Fri, 26 Sep 2025 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fNTWZCjn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94484207A;
	Fri, 26 Sep 2025 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758878721; cv=none; b=Je3S+uQXB6srtEnsuHNnB0zB4qfSVV98aIn5txbry6o7GdmfykaD3tP/LXR3oEo/+aZJh63mIz/q2gMwpcBaOu1+fGyOVW0dSereJE+48AHijjWIYTnTiMjkuwd3Ikiq+gyFTOI2MCVMjc+3Ftc7AdBzXs2EiMf+bO0HvYArYgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758878721; c=relaxed/simple;
	bh=OtqMBGvJqRuEI+r26Adgr+3QR76ztiv29otfii/Jm0A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qGDYmaEfNa5yIvparliHvG2ki4zk5cpRNG9ea/XlnUTQ1+ux/zojA14fTHV50sdLA4R63lpDl4p7MI/NwDWye6DALls4cVUKMiOS6QEUQ+DhiHhaRz7CsYJodXJWzawtJdvkGkTy/407ZmUK+88CVDYmKFUoeTWjCVNvPB6INfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fNTWZCjn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q6Ud1K028794;
	Fri, 26 Sep 2025 09:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=al3aQf
	G/mnUqk77Tg1qoK5H2G+QguZmcUISkGRTNzJo=; b=fNTWZCjnhwi10jpmLgPMuI
	YxpDlQrEPHBeOZmZMrfbuO4BgweNjKUxj6slM8SlnMWAAKsebt+9r/7PyuUXnk8l
	225l3WFgDPR3MuteC25mpCBXBiwpLbL8M+/eGT+McMk16A6jJkeAVy5MJj98btJr
	bIAniz6XIkyT3po2AmorFGoiOs2mh30jiswh6OdpOPuwapojBg9xpdeiztyiePWo
	lE3MPmRg+/joRQj0HDe/wKH6y4YKaCpYG4M439Cib5+wdHVVKl42+E4KmK/pZiSA
	eIyURfW67DeOO4Pgv4z8TlnSoiefTxsWYbj6Xhkeg8DJgOi5lwfV8oDGze4z3ecQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbbbkkgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 09:25:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q65057025794;
	Fri, 26 Sep 2025 09:25:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49dawpuaka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 09:25:15 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58Q9PBMC30606048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Sep 2025 09:25:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD3C720043;
	Fri, 26 Sep 2025 09:25:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D105D20040;
	Fri, 26 Sep 2025 09:25:10 +0000 (GMT)
Received: from localhost (unknown [9.111.81.227])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Sep 2025 09:25:10 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Sep 2025 11:25:10 +0200
Message-Id: <DD2MGSSNDP6Y.3KSEFVRU4RL4Y@linux.ibm.com>
Cc: "Keith Busch" <kbusch@kernel.org>, "Gerd Bayer" <gbayer@linux.ibm.com>,
        "Matthew Rosato" <mjrosato@linux.ibm.com>,
        "Benjamin Block"
 <bblock@linux.ibm.com>,
        "Halil Pasic" <pasic@linux.ibm.com>,
        "Farhan Ali"
 <alifm@linux.ibm.com>,
        "Julian Ruess" <julianr@linux.ibm.com>,
        "Heiko
 Carstens" <hca@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: Add lockdep assertion in
 pci_stop_and_remove_bus_device()
From: "Julian Ruess" <julianr@linux.ibm.com>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Bjorn Helgaas"
 <helgaas@kernel.org>,
        "Lukas Wunner" <lukas@wunner.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250826-pci_fix_sriov_disable-v1-0-2d0bc938f2a3@linux.ibm.com>
 <20250826-pci_fix_sriov_disable-v1-2-2d0bc938f2a3@linux.ibm.com>
In-Reply-To: <20250826-pci_fix_sriov_disable-v1-2-2d0bc938f2a3@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Lsb87kpzRMZdRMBrthPY6qAChWqm3fn2
X-Authority-Analysis: v=2.4 cv=LakxKzfi c=1 sm=1 tr=0 ts=68d65bfc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=F53kh5m_LVtqdGsIIDMA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: Lsb87kpzRMZdRMBrthPY6qAChWqm3fn2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3NCBTYWx0ZWRfX8tY9DiFMlGo4
 wv2UM81pTeXt1mgsk5yaFuO74Ee/OkEFbFnwV8LqdhmLuWrhpU5U/q493Ek9O9VIlIgrYwqDbDj
 3hpbxt0L437sxws+yyhztP+Q2K0oVuU7jy0J87A/WzptQ4/pIXzkbOc+udNrRw0BUrYj7ozturl
 wD4jz+dYUphOmI2BSe8QEtBoC2c8qYZB5Rjohu+y1hfveud0FabRueY9aQED1wPDBb0jcyk8JIn
 +lbOIlQB5h+qInjLPcEzhhPbK1cc6NM0x85F5jV3i9Uh905ToTh63YAsDcB1xt0eA5y7Z7G9l+e
 P2iZidPHafmP0rsqSFNHHxUplpAV80/1HhSiHwCW5rwSYx+SB2EXcWQ+WyTl3qCEKMZZmfOtLa/
 PrOO0Pp9fLUeagSsgOpZFaKBYiZO3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250174

On Tue Aug 26, 2025 at 10:52 AM CEST, Niklas Schnelle wrote:
> Removing a PCI devices requires holding pci_rescan_remove_lock. Prompted
> by this being missed in sriov_disable() and going unnoticed since its
> inception add a lockdep assert so this doesn't get missed again in the
> future.
>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/pci/pci.h    | 2 ++
>  drivers/pci/probe.c  | 2 +-
>  drivers/pci/remove.c | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
>
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

Feel free to add my
Reviewed-by: Julian Ruess <julianr@linux.ibm.com>

Thanks,
Julian

