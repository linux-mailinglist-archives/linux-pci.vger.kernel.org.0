Return-Path: <linux-pci+bounces-36883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E4BB9B369
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 20:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843674E533D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 18:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C768320A14;
	Wed, 24 Sep 2025 18:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UvK+7s/z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE133320A0C;
	Wed, 24 Sep 2025 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737202; cv=none; b=u5j2sVLJwwNGW92b5xkKw690jWA+/sMaksp5PuO+llsbAkwl0C1eUmMW9/Eo9fFY2bcrd2BHykcIxEWmejSMlGQb92qtjDosr9XQ/qhjZjRUX/NYHhj3xpl3AOK8OFtWr8v1cX6yhBsZhAcRHmQzQbx0JSTO6iD7VOF94KG3nLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737202; c=relaxed/simple;
	bh=dazGZDRW7qAaKN44foyGkWr8uwdmrb/S5T6bijsNZOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3HMn0QJjIUEIf+BqVPPJGwc7E/wUAn+ewWDN2K8+BqY3Ju9JiMi+eNbJcFZ44rHnLEcje6VDmvd2WRd45B4OZWb4c5d8xJsvWB4TTmrhadWwDQ09B+9ofgyqaT8Oq4jN04h1IXS8SpAuljgDY1xwFlqTLOIuJUqGvn3IffkN4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UvK+7s/z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OFZI47014961;
	Wed, 24 Sep 2025 18:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aaxJas
	kaXOR0M5l1czBITqmXHpWHQ4BzOz02zcB6yu4=; b=UvK+7s/zZxfy2c4XenGRLM
	BoWXvQNL603aRNhFfkJBW7Imxco5Wn3AKeHSWhFxFqJgLHxW1Fm5ADO2SgcahSvu
	ArghVwWMghwBeMSr8XUlR7u6UGyNW9S6ZKlj/7mzl7sexkWmXckn53h1AZ48aj4G
	jlLV3hIsBAExTbyopFXQ6h7uM1z34gI4LCHk09xYpaClaG+uOVXRI/jHCTSe7tFM
	dNyOMo9IQPXkh0nkHPw0yF2YHqtkSni7QX+XgIJGbiavVLU0v+do/H+7AE1lTnZM
	nOWi+zPFAw8+KGxN2k7NkBW4H+Eo1fXLYBoEo2c6pdRseWJRJETNSAvkX+WSCYBw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpqgqqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 18:06:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58OI6BwP030336;
	Wed, 24 Sep 2025 18:06:36 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a19p0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 18:06:36 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58OI6Yb431392318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 18:06:34 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 301A958054;
	Wed, 24 Sep 2025 18:06:34 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C18DF5805D;
	Wed, 24 Sep 2025 18:06:32 +0000 (GMT)
Received: from [9.61.252.148] (unknown [9.61.252.148])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Sep 2025 18:06:32 +0000 (GMT)
Message-ID: <48360cde-81d9-4161-8c32-0029e193c685@linux.ibm.com>
Date: Wed, 24 Sep 2025 11:06:22 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: Add lockdep assertion in
 pci_stop_and_remove_bus_device()
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: Keith Busch <kbusch@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250826-pci_fix_sriov_disable-v1-0-2d0bc938f2a3@linux.ibm.com>
 <20250826-pci_fix_sriov_disable-v1-2-2d0bc938f2a3@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250826-pci_fix_sriov_disable-v1-2-2d0bc938f2a3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FrEF/3rq c=1 sm=1 tr=0 ts=68d4332c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=F53kh5m_LVtqdGsIIDMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HGLcPrf4wuJDEogZpyRV4eoNNGqNiWsr
X-Proofpoint-GUID: HGLcPrf4wuJDEogZpyRV4eoNNGqNiWsr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDIyNCBTYWx0ZWRfXyjh1glDtSlFL
 SUiwmzbNBrpRieCE/v0oBtzSv6UcUsRn0XcVai75PT68KbYRhiKBzFDpZEMTxd+VdKYaG0uviKQ
 cnfu9go0Kb7gBZz952rJgfgb9aX2C/pSrrsGxYeBQIqLQt4i7jQvBTv06T0R5kZvETANfbQP+no
 2LxkxebggD4JB00JrRrftTT/IDsWG0iQT+gGpgk4AkOeqds2qFd1df58/fmxyge7MFB85DI8m8o
 12oTfDlwGy+12fH/8dfyA4sFqnQnAaxUDMg5+WVb+CDknHi+phNORXvinquNS8yhIS1GRLJAGYI
 8BxxD0GZhRPP9T4OvZwW/xKTS05e0WNz1j7F4euaDoXCePjd0gxdTjM4KdrHVSTe6/qwFHJMFOy
 g246xgk4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1011 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509190224


On 8/26/2025 1:52 AM, Niklas Schnelle wrote:
> Removing a PCI devices requires holding pci_rescan_remove_lock. Prompted
> by this being missed in sriov_disable() and going unnoticed since its
> inception add a lockdep assert so this doesn't get missed again in the
> future.
>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>   drivers/pci/pci.h    | 2 ++
>   drivers/pci/probe.c  | 2 +-
>   drivers/pci/remove.c | 1 +
>   3 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 34f65d69662e9f61f0c489ec58de2ce17d21c0c6..1ad2e3ab147f3b2c42b3257e4f366fc5e424ede3 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -84,6 +84,8 @@ struct pcie_tlp_log;
>   extern const unsigned char pcie_link_speed[];
>   extern bool pci_early_dump;
>   
> +extern struct mutex pci_rescan_remove_lock;
> +
>   bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
>   bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
>   bool pcie_cap_has_rtctl(const struct pci_dev *dev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index f41128f91ca76ab014ad669ae84a53032c7c6b6b..2b35bb39ab0366bbf86b43e721811575b9fbcefb 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3469,7 +3469,7 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
>    * pci_rescan_bus(), pci_rescan_bus_bridge_resize() and PCI device removal
>    * routines should always be executed under this mutex.
>    */
> -static DEFINE_MUTEX(pci_rescan_remove_lock);
> +DEFINE_MUTEX(pci_rescan_remove_lock);
>   
>   void pci_lock_rescan_remove(void)
>   {
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 445afdfa6498edc88f1ef89df279af1419025495..0b9a609392cecba36a818bc496a0af64061c259a 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -138,6 +138,7 @@ static void pci_remove_bus_device(struct pci_dev *dev)
>    */
>   void pci_stop_and_remove_bus_device(struct pci_dev *dev)
>   {
> +	lockdep_assert_held(&pci_rescan_remove_lock);
>   	pci_stop_bus_device(dev);
>   	pci_remove_bus_device(dev);
>   }

We also have the function pci_stop_and_remove_bus_device_locked() as 
Gerd mentioned, so is pci_stop_and_remove_bus_device meant to be called 
without the rescan_remove_lock held? This is a little confusing as we 
shouldn't be adding/removing from the bus without the lock AFAIU, but 
maybe I am missing something?

Thanks
Farhan


