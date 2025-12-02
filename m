Return-Path: <linux-pci+bounces-42477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09177C9B75B
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 13:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B687F3A6C7C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 12:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8745D28AAEE;
	Tue,  2 Dec 2025 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QSzm78Bt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90083101B6;
	Tue,  2 Dec 2025 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764678028; cv=none; b=PdBOEgJmwwxK5kG0msJXDz1J945Om7cDn67AbmipHjAOOygwu4lyBrQ3Dbfwob2yM+ha+JCuHsDJuoEPEmsOsBl6Nl8BwFPQBucN8hvDxjJlIsMVtCIgpEDZQZp9BgfHrgyrRhDrPMUbW0mIOejwgXuHz+TZC0njVyeqKHVPbBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764678028; c=relaxed/simple;
	bh=Ym7PBfgMdXVevcf3wPUBmbdGE7dpAabaxTgPRKR6py0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VZPto8w5PjECJd7PqtskW/iOkR1puGtFVSNUOu6PD0TvMlXRDCNZH5X0MQdPKzg2enaA57yjQOzS43sli2geMuy94ze6EapiOjNZW7yOh77yYo386rj0hx/d1ogwWBnOcZN3cXQ6qzpH7gumikuaZUInM2CM+TApond+l/T0Lds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QSzm78Bt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2BNJ3r022200;
	Tue, 2 Dec 2025 12:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YX5sk0
	NdEy857E0HavqyYMtYTtglS0aofuAFAgBd2VM=; b=QSzm78BtojCVD8FmZzikxO
	5ZkAA4Ma4B59XcggGLIRaQbHtOHKvy/3jA+JmXs2Ybr4GrPr3qulKOBAse4EFdKJ
	5t4HoXWtpKfc27OtMVhHZplQoBXRv1XagbOAKrQIAjI3hv6xIjCX7jGA3zs8Ywun
	XOxAISjlYK48oaSEnDH6BtXZpThmm1kHis/403pHkY5JNGrwtLSx2ttrHOP3nwZH
	yHt8cLedX/G3/+molR0KSZkC3qVmC5MLQuBNV/mxydkqLrt41JL4GZHkORhwOsh5
	yOmvHrDzCZ9CJZVidWpqpA4azXcj9I+4FUBLIU0JrLdF9AiHwAhXj9IGLGMTVyEg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbg506w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 12:20:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2B2jCD008558;
	Tue, 2 Dec 2025 12:20:19 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arc5mv899-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 12:20:19 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B2CKISF31261216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Dec 2025 12:20:18 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEF8E58056;
	Tue,  2 Dec 2025 12:20:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4002258067;
	Tue,  2 Dec 2025 12:20:16 +0000 (GMT)
Received: from [9.87.137.209] (unknown [9.87.137.209])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Dec 2025 12:20:16 +0000 (GMT)
Message-ID: <2940d7cd662aed9d8b60f7c8fec9ced44f059166.camel@linux.ibm.com>
Subject: Re: [PATCH v6 3/9] PCI: Avoid saving config space state if
 inaccessible
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: helgaas@kernel.org, lukas@wunner.de, Farhan Ali <alifm@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: alex@shazbot.org, clg@redhat.com, stable@vger.kernel.org,
        mjrosato@linux.ibm.com
Date: Tue, 02 Dec 2025 13:20:15 +0100
In-Reply-To: <20251201220823.3350-4-alifm@linux.ibm.com>
References: <20251201220823.3350-1-alifm@linux.ibm.com>
	 <20251201220823.3350-4-alifm@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yoNM1ucUd2msG7ScfkrCeZUxDlSGou2T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxNiBTYWx0ZWRfX1AS6B3+OI8FN
 yhMpop2eFCNzneyb3hPhoeRtj8hMD3aiqpdXuMECinUrg5RXxZqPGKsWWL5TA/JEmN/XevZUhQJ
 7kK1mch4/mRcPqo/J6sn5LAnQLs1pLFBozNOR4rmgE6mrxDLbrF3Vx0KXAnH0i5NTu/ZqQKBMPb
 vSKQqAdN9LNW33iLrgZ4PPeQYD/2XHoImVOLMX1R0RY/I1OgbHNRcOChKUdhdyNRGXewm87uU9j
 S1qygIYdabIXFlAHeNp1Z3WDhGXYAmd0tsOh8iuXejZGYy1y3E261eZgoCGgJc5H1eO1OjMoiwS
 9rN2RMbjCKrXZZe01nQJETTWfBB99pnqDGub3555qi7tds6hKuidJ4v2KW5z5T2dXOXmriDpOP8
 ORKEc7h9YzxH8WLfQ/qnY5EiH6D7kw==
X-Authority-Analysis: v=2.4 cv=UO7Q3Sfy c=1 sm=1 tr=0 ts=692ed985 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=k13puS8DR2fOBvO5sp0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: yoNM1ucUd2msG7ScfkrCeZUxDlSGou2T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290016

On Mon, 2025-12-01 at 14:08 -0800, Farhan Ali wrote:
> The current reset process saves the device's config space state before
> reset and restores it afterward. However, errors may occur unexpectedly,
> and the device may become inaccessible or the config space itself may
> be corrupted. This results in saving corrupted values that get
> written back to the device during state restoration.
>=20
> With a reset we want to recover/restore the device into a functional
> state. So avoid saving the state of the config space when the
> device config space is inaccessible/corrupted.
>=20
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

I think the commit message needs more focus. Specifically I think the
main point is the case that Lukas mentioned in the following quote from
the cover letter of his "PCI: Universal error recoverability of
devices" series:

"However errors may occur unexpectedly and it may then be impossible
to save Config Space because the device may be inaccessible (e.g. DPC)
or Config Space may be corrupted. So it must be saved ahead of time."

That case will inevitably happen when state save / reset happens while
a PCI device is in the error state on a platform like s390, POWER, or
with DPC where Config Space will be inaccessible.

Moreover, I'd like to stress that this is an issue independent from the
rest of your series. As we've seen in your experiments this can be
triggered today when a vfio-pci user process blocks recovery, e.g. by
not handling the eventfd, and then the user tries to mitigate the
situation by performing a reset through sysfs, which then saves the
0xff bytes from inaccessible config space which may subsequently kill
the device on restore.

> ---
>  drivers/pci/pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 608d64900fee..28c6b9e7f526 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5105,6 +5105,7 @@ EXPORT_SYMBOL_GPL(pci_dev_unlock);
> =20
>  static void pci_dev_save_and_disable(struct pci_dev *dev)
>  {
> +	u32 val;
>  	const struct pci_error_handlers *err_handler =3D
>  			dev->driver ? dev->driver->err_handler : NULL;
> =20
> @@ -5125,6 +5126,12 @@ static void pci_dev_save_and_disable(struct pci_de=
v *dev)
>  	 */
>  	pci_set_power_state(dev, PCI_D0);
> =20
> +	pci_read_config_dword(dev, PCI_COMMAND, &val);
> +	if (PCI_POSSIBLE_ERROR(val)) {
> +		pci_warn(dev, "Device config space inaccessible\n");
> +		return;
> +	}
> +

Can you explain your reasoning for not using pci_channel_offline()
here? This was suggested by Lukas in a previous iteration (link below)
and I would tend to prefer that as well.

https://lore.kernel.org/all/aOZoWDQV0TNh-NiM@wunner.de/

>  	pci_save_state(dev);
>  	/*
>  	 * Disable the device by clearing the Command register, except for

