Return-Path: <linux-pci+bounces-38810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFEDBF3D27
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 00:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167BA483C45
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 22:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011742EBB8F;
	Mon, 20 Oct 2025 22:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BfUtVR8y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3DF1C695;
	Mon, 20 Oct 2025 22:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760998056; cv=none; b=D7qhEVUO53332Mye0g1lGNr7s8OgjxPInVPqT/OJ2ydF7etikvTAXapNBUW0T6uQWCM5ObyLNrCZhTw4IZ4MoyqlVpBwXqKzJufSwatsaig6A988MEHChBMXpiFpyxhZ9DO0IFhz9XA5wGl6VrtsXitJkNDf4WP6i7A3xJwsFM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760998056; c=relaxed/simple;
	bh=H5Sx8VCAi4uDZTrCoyLCZeTCEAQROEY7HE/dz3M3F4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4iwIbpGPW8hYgqIEnjdnCKIuc25MZvQLvFNGcBjkmMkexqg/DgFZTfhujg8AVitxAzkDRpZi9f6c0wPO/a57qoPxSyejKujn8V28O3x5HFEhMLG1r/J2Iv3ZPossg2MB97ai8rZEr0lIb0kepfIvIC5TiOVWCLet8BgSZduxf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BfUtVR8y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KFURnH026789;
	Mon, 20 Oct 2025 22:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=r6sUFF
	eWnIrjGTAl4MBZvysEDk1VUIyRSBaJopdfdgs=; b=BfUtVR8ycv5UpzMVxmIFKY
	BQbYhmzulPF+80NwDj8AaBn3+GwL5zg9qclU8cux+dgEt0Fvf0BibbTSIyho9fAW
	Fl1EKzJkdQrIrRg4CWn3XKchEK8PgfDsklxWb1BQ9+mt/fWVL3IWM+Yz6NuYg5Gm
	7BGJWMPrkA5Mn5P9AU2YUqNZlCFmhbTAtDjL3fIrWaQBwaxjtsJYEbu5xehxEWP7
	0oTzalfN5aLHlVGBmWnVpbYxmw5TosYgSVaywDfwD+xxaf9gS726itZgVlaraXRf
	rB/O1XcPwdZBMG/MgfnKtfcWUPU8etFgKYG98vRkU9dmWyDG8iMV6PlNppGfpyNg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vjnca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 22:07:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KLEsLT014779;
	Mon, 20 Oct 2025 22:07:07 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7s01mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 22:07:06 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59KM76CI31720118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 22:07:06 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2391C58058;
	Mon, 20 Oct 2025 22:07:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C617358059;
	Mon, 20 Oct 2025 22:07:04 +0000 (GMT)
Received: from [9.61.241.180] (unknown [9.61.241.180])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Oct 2025 22:07:04 +0000 (GMT)
Message-ID: <25435d82-575d-495f-ae61-bd38570ff9ad@linux.ibm.com>
Date: Mon, 20 Oct 2025 15:07:01 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] PCI/sysfs: Use runtime PM guard macro for
 auto-cleanup
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        Ulf Hansson
 <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
        Dhruva Gole <d-gole@ti.com>, Niklas Schnelle <schnelle@linux.ibm.com>
References: <6196611.lOV4Wx5bFT@rafael.j.wysocki>
 <2323750.iZASKD2KPV@rafael.j.wysocki>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <2323750.iZASKD2KPV@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bhUE52pihM2-hnvxydHCN2Rc_tCGvwvn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX57jXW+8zLtMi
 7PrDbm0hKnsV78siKRz9+/b07CC+/Xv6Fukkspad3M0w+zS9jBVqzyhEEKfw1JlL9VLwo5xxfRV
 PhNrDiJ83nlCgpx48MY68E+FEDFySquZ11A2HVF3wPvYSsYMP7x2T4p8nrfs01PDL9Oz5TcUQIf
 AIskfnB2Fc/rxHxgQnDWO5YjL8FJPY7vZgjn0GLzHUF6B3zrEZ907ED+d+seKyRbfl/i6I3R4fX
 cBzV2VW+0nsHowxYXd4j6yydd/hiXpx7tGw9r7rOF0z5vrUE7GRcCO0fWYRAKhImIcYhDD0dT/z
 1yJ1WinElwCKtE68oabMU53yMAdQuiZi145sbiI9KOGx7TRxSiFG4dyobr3N2h+CFXLTn9vnZAh
 IVs5gu32bEn7PvAOz9uRSK1bA+mthA==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f6b28b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bC-a23v3AAAA:8 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8 a=hqneplKKMpFo2bd696AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-ORIG-GUID: bhUE52pihM2-hnvxydHCN2Rc_tCGvwvn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022


On 9/26/2025 9:24 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Use the newly introduced pm_runtime_active_try guard to simplify
> the code and add the proper error handling for PM runtime resume
> errors.
>
> Based on an earlier patch from Takashi Iwai <tiwai@suse.de> [1].
>
> Link: https://patch.msgid.link/20250919163147.4743-3-tiwai@suse.de [1]
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v3 -> v4:
>     * Use ACQUIRE()/ACQUIRE_ERR() (Jonathan)
>     * Adjust subject and changelog
>     * Take patch ownership (it's all different now)
>     * Pick up Bjorn's ACK from v3 (Bjorn, please let me know if that's not OK)
>
> v2 -> v3: No changes
>
> v1 -> v2:
>     * Adjust the name of the class to handle the disabled runtime PM case
>       transparently (like the original code).
>
> ---
>   drivers/pci/pci-sysfs.c |    5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1475,8 +1475,9 @@ static ssize_t reset_method_store(struct
>   		return count;
>   	}
>   
> -	pm_runtime_get_sync(dev);
> -	struct device *pmdev __free(pm_runtime_put) = dev;
> +	ACQUIRE(pm_runtime_active_try, pm)(dev);
> +	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> +		return -ENXIO;
>   
>   	if (sysfs_streq(buf, "default")) {
>   		pci_init_reset_methods(pdev);
>
>
Hi Rafael,

This patch breaks updating the 'reset_method' sysfs file on s390. If we 
try to update the reset_method, we are hitting the ENXIO error. eg:

echo 'bus' > /sys/bus/pci/devices/0007\:00\:10.1/reset_method
-bash: echo: write error: No such device or address

I don't think s390 does anything different in this path, so this could 
also impact other platforms? Changing this to something like this fixes it


diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9d6f74bd95f8..d7fc0dc81c30 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1517,8 +1517,8 @@ static ssize_t reset_method_store(struct device *dev,
                 return count;
         }

-       ACQUIRE(pm_runtime_active_try, pm)(dev);
-       if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
+       ACQUIRE(pm_runtime_active, pm)(dev);
+       if (ACQUIRE_ERR(pm_runtime_active, &pm))
                 return -ENXIO;

This changes the logic to what it was previously which used 
pm_runtime_get_sync and pm_runtime_put. But I am not familiar with the 
PM runtime code, so not sure what would be the right fix here.

Thanks

Farhan



