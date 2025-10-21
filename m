Return-Path: <linux-pci+bounces-38940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6A6BF888A
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 22:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CB73B4E7D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 20:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7974279792;
	Tue, 21 Oct 2025 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eWugX/bA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15970279798;
	Tue, 21 Oct 2025 20:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077042; cv=none; b=h61bJEL4N/ud3HtN3thbmABN7MaTUdhHL9Km+ehtRXno4ASrfXZIYZTSaPBqmIznJXUagHbBBNMKPexA7hDllBLKHTfka/xwtSeNVoMzP3G3we1yZ7hmhs9SRbFDMmTLaLb1Quxa0TiPn34FXOXEEsnxobKeTeVBlV0aY7CnbI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077042; c=relaxed/simple;
	bh=uhSuasC7qgF2zmotCjudEp9V1eE0GEMNvRxw2MHVLKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBA1/qstMEKcrcFGhikxCbaDcE7m3v1dsuBXwhSNjmW+LQ5/jyHL1K8C/gksPzITJjIzP6L7kPqIFMuGpNM286C56OYC8Je60cb0AQclkJRuHWpt6pYBNsqzVn1sIzczv1OOnn86Qd9BLm3HRcydLb+PBiPi7TcGe6zgJLucO5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eWugX/bA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LDL3ii007202;
	Tue, 21 Oct 2025 20:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NRP0tC
	eYnVDlm62E339Oy5tdWhMiGMfV0Piwa5uDGM8=; b=eWugX/bAPc5iMFy91G2qLR
	KWVRHXmxtoc/fGA3VLEaL5V9hhtsZ0HByE8h+gOqUG5IFftGGWooFrK8DHoiw1aw
	YzfphMwPq5KSqeoXV8S8eIPqhxlGyu3ygM6M5yVqR9TvJRXdbj2Ku0Uea+UHDGtY
	gK0z34hlL1ZtvNqs5HwStp2I9ldhfpBob9Th+bjUOzkyov30p6xj1q8/d0d7U0Xl
	2GejBwnX70G0ELcUY8/Umvapr5H9xOXFg+Gfu5tKaHfe073NwhBIAaapnbgaThn7
	DaN6RrTMA/00IwDSXgVdTjhYBREk/YVI5k2Qd3Z5wuy6kvc2ZmQLh54kfbz3e8jA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vqpj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 20:03:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59LIeCPI032142;
	Tue, 21 Oct 2025 20:03:37 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7mvknt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 20:03:37 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59LK3aQl22414030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 20:03:36 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96BAE5805E;
	Tue, 21 Oct 2025 20:03:36 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B69D658043;
	Tue, 21 Oct 2025 20:03:35 +0000 (GMT)
Received: from [9.61.241.19] (unknown [9.61.241.19])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Oct 2025 20:03:35 +0000 (GMT)
Message-ID: <a4e7c14c-112d-4ac4-9ff7-74efebc26321@linux.ibm.com>
Date: Tue, 21 Oct 2025 13:03:30 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: runtime: Fix conditional guard definitions
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
        Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
        Dhruva Gole <d-gole@ti.com>, Dan Williams <dan.j.williams@intel.com>
References: <5943878.DvuYhMxLoT@rafael.j.wysocki>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <5943878.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 49au64DJ3FCr4lpbS1J-iqZbDEv48HrO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXyDaAPYrbJYNY
 MOYAheoFEBoTNzl4UsJ0NHtQ4haFSFCWwpEAMAEocD3/U9ATpwCFCa7GAi6lQfLev81MWqrUHka
 WEUWO+Yh/XwLC4zogxrxaUUxSvSANGWe/0BybNM9eDhJC4XYMak+4hKdWnvQTJ39hEVZH+6uWbW
 KlAxcsjXzPrkSETpIr5elguVBiqoS/uozg4S0uMibHMATc3VLj3ztykhDjnpimPvVp5lXIaBvn0
 AEs6ZZNoL30ymwW8Wt3xxxH3K0ovw55l7FwyXT1DRj8AKWYmejV6dOy0KcRXcd2aERjG3Wwa2t0
 b9oqD9IbXfoUL7fN1FVp2c0/BOCqbokLNRss6ddVjwZftuz1CJMSIT/YeGPiJjwjul2SumiuoHP
 BgpiLtqu2t245z65+AVF68ASlHdL6w==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f7e71a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=O-QSBXc3A0Oyl9V8qwYA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 49au64DJ3FCr4lpbS1J-iqZbDEv48HrO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022


On 10/20/2025 8:03 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since pm_runtime_get_active() returns 0 on success, all of the
> DEFINE_GUARD_COND() macros in pm_runtime.h need the "_RET == 0"
> condition at the end of the argument list or they would not work
> correctly.
>
> Fixes: 9a0abc39450a ("PM: runtime: Add auto-cleanup macros for "resume and get" operations")
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/linux-pm/202510191529.BCyjKlLQ-lkp@intel.com/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   include/linux/pm_runtime.h |    8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -629,13 +629,13 @@ DEFINE_GUARD(pm_runtime_active_auto, str
>    * device.
>    */
>   DEFINE_GUARD_COND(pm_runtime_active, _try,
> -		  pm_runtime_get_active(_T, RPM_TRANSPARENT))
> +		  pm_runtime_get_active(_T, RPM_TRANSPARENT), _RET == 0)
>   DEFINE_GUARD_COND(pm_runtime_active, _try_enabled,
> -		  pm_runtime_resume_and_get(_T))
> +		  pm_runtime_resume_and_get(_T), _RET == 0)
>   DEFINE_GUARD_COND(pm_runtime_active_auto, _try,
> -		  pm_runtime_get_active(_T, RPM_TRANSPARENT))
> +		  pm_runtime_get_active(_T, RPM_TRANSPARENT), _RET == 0)
>   DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
> -		  pm_runtime_resume_and_get(_T))
> +		  pm_runtime_resume_and_get(_T), _RET == 0)
>   
>   /**
>    * pm_runtime_put_sync - Drop device usage counter and run "idle check" if 0.
>
>
This does fix the issue for me mentioned here 
https://lore.kernel.org/all/25435d82-575d-495f-ae61-bd38570ff9ad@linux.ibm.com/

Feel free to add

Tested-by: Farhan Ali <alifm@linux.ibm.com>




