Return-Path: <linux-pci+bounces-45196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC53D3B3D7
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 18:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03BA030DE981
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 16:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5674F2D0C99;
	Mon, 19 Jan 2026 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dzgbg+ok"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019A22C158F;
	Mon, 19 Jan 2026 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841814; cv=none; b=OaiSbjyZbfvZrSsgw4+Z6uOipIn9eeSDsgir6JMV5Q/vGNyuVq/w1+8JzFszngTz1H4sOmD7IsredLa/GQU/yTzeARXyYzTwL2qHCA+3uzmB4qjOKR9pdkddwvQmxAOoSTcC26ECzBhxdM2HfIMXHQNaxml517oyNH1IhCcHJ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841814; c=relaxed/simple;
	bh=GYLwx0Hne15W5ZSKTaTY96zz6Id4CzMzEygkuRoJRGI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eMxKEL1hE0U1HbV5nE5RX65JSpnzXMHifoWXngiimF5n6WYtBzameub00KtXfUAh+eFRVTLWDV1CvYfEvAasRX56jIhfvgS+t4qoc3/u285vqAqLg3Y/22CvTEHfpcdw/QEqlAbQaCjJbzJV/AFdzvO2BvSjzgRus6Sv9l4Ntk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dzgbg+ok; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60JDcHpb012605;
	Mon, 19 Jan 2026 16:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fVQAwn
	ZY3xGcrB47UXLurStptNlnnObHCmQwjyhqQK0=; b=Dzgbg+okFzoC3e5YXfxg97
	25+9a8+WELWr4ZfvbJ1O0Hzba2Q/AKrhOuUqf/rSNR8sGPQW97ro+nIwj0yYrD6z
	r6VGRbnyfsafZWNQyyvp71JR4EAhiC3lUoT7to1Sp7BY/HVckMLByV04zUWGNTdc
	wYoupwIXqc+Nh5m3gawlQZOni+4RUmQZrG5hRuWXiRZFSNwZnIgi740efmUzvl6M
	OYYLGbp9KuZYjrl1bUBk7RNS6iKoHH9trxROQ9XQ7SntpIwoJS3KskWf4VKX2CHi
	00v6Y89Fbt4B2wgLcrskkVMP9hGDKBcpxpnLJ0WGVXwadRFeeB21ctEKfna1ZXcg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br1x51f1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 16:56:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60JGCjXc024583;
	Mon, 19 Jan 2026 16:56:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brxareb6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 16:56:45 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60JGufBf56295776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 16:56:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D1D520043;
	Mon, 19 Jan 2026 16:56:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F0682004B;
	Mon, 19 Jan 2026 16:56:41 +0000 (GMT)
Received: from localhost (unknown [9.52.203.172])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Jan 2026 16:56:41 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Jan 2026 17:56:41 +0100
Message-Id: <DFSQ35HIT6YT.3DTUUNUOEEDHM@linux.ibm.com>
Cc: <helgaas@kernel.org>, <lukas@wunner.de>, <alex@shazbot.org>,
        <clg@redhat.com>, <stable@vger.kernel.org>, <schnelle@linux.ibm.com>,
        <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v7 9/9] vfio: Remove the pcie check for
 VFIO_PCI_ERR_IRQ_INDEX
From: "Julian Ruess" <julianr@linux.ibm.com>
To: "Farhan Ali" <alifm@linux.ibm.com>, <linux-s390@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260107183217.1365-1-alifm@linux.ibm.com>
 <20260107183217.1365-10-alifm@linux.ibm.com>
In-Reply-To: <20260107183217.1365-10-alifm@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=R8AO2NRX c=1 sm=1 tr=0 ts=696e624e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=Okk2yIgg9Z9Hp2RjL0IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: QzRipjxLbY9YVaDZM2Fkn7cNSMc88EjY
X-Proofpoint-GUID: QzRipjxLbY9YVaDZM2Fkn7cNSMc88EjY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE0MCBTYWx0ZWRfX2qlhnSxI8lYN
 64rpgvPsXZnrxCNPsQNMp3dBb+j2mqVYVDz8/83NwKlu8BmqgbKzpzt3vQfLkl54MPDcgs3Wr93
 1IkZMdEACUdzFn/lV67iNMilfQpFoenS8UNGX4Aavko4j9sbaEuk1kkLJ+GCzDxz/ZfCOlHlbKz
 u60LV3pbRv+mpNhwsgFB0CiK4ntnVZz951/eGDaipaIQyz7U8XdXTlKAStEPcBdseQY6tp6gtXb
 S/525lc1B4CQFHltL2ORIcaruSIKj9V36VvLXgITRYUBkbzfs3OsN/Ie8RN4MKLjEEBJyRvO7JW
 p/8nIzgsYs9o8ey81D/Tc0/AVxZMaXOOu0/6vdQUvvlvMRUV3ph95TqcpACrUKuay2XB7ZfZam4
 I0vU+NEqDe7bP7FzUsAKvmjPyt3upyUbfXLAwXaMKpSIsYhjZQ0HCeFlt79M6OpdSJryvJphGGm
 l9X2TNOhDGCfSbSxpow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601190140

On Wed Jan 7, 2026 at 7:32 PM CET, Farhan Ali wrote:
> We are configuring the error signaling on the vast majority of devices an=
d
> it's extremely rare that it fires anyway. This allows userspace to be
> notified on errors for legacy PCI devices. The Internal Shared Memory (IS=
M)
> device on s390x is one such device. For PCI devices on IBM s390x error
> recovery involves platform firmware and notification to operating system
> is done by architecture specific way. So the ISM device can still be
> recovered when notified of an error.
>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c  | 6 ++----
>  drivers/vfio/pci/vfio_pci_intrs.c | 3 +--
>  2 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index c92c6c512b24..0fdce5234914 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -778,8 +778,7 @@ static int vfio_pci_get_irq_count(struct vfio_pci_cor=
e_device *vdev, int irq_typ
>  			return (flags & PCI_MSIX_FLAGS_QSIZE) + 1;
>  		}
>  	} else if (irq_type =3D=3D VFIO_PCI_ERR_IRQ_INDEX) {
> -		if (pci_is_pcie(vdev->pdev))
> -			return 1;
> +		return 1;
>  	} else if (irq_type =3D=3D VFIO_PCI_REQ_IRQ_INDEX) {
>  		return 1;
>  	}
> @@ -1157,8 +1156,7 @@ static int vfio_pci_ioctl_get_irq_info(struct vfio_=
pci_core_device *vdev,
>  	case VFIO_PCI_REQ_IRQ_INDEX:
>  		break;
>  	case VFIO_PCI_ERR_IRQ_INDEX:
> -		if (pci_is_pcie(vdev->pdev))
> -			break;
> +		break;
>  		fallthrough;

Isn't the fallthrough unreachable now?

-- snip --

