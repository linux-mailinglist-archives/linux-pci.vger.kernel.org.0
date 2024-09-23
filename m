Return-Path: <linux-pci+bounces-13360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0408497E98D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 12:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F917B21E5F
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 10:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB97198E6F;
	Mon, 23 Sep 2024 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Gn8Zuav4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961A1195F17;
	Mon, 23 Sep 2024 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727086079; cv=none; b=B7/MRuRapQkeEL5Pu8OPzXfz+yFek+XJ0yBnjVHj+8wKRuRdQC1gMJ7Nj/z7IQMlzzqwCANkqC1nFqzbJDmEYRgayAyC/8x6hOjIBwnPmgF1VwjN8TJcHI2y0X5tcezntS/yxzeY+ZoGf1Yj+KWexuKDtfyLKYOaJveaD5ahnU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727086079; c=relaxed/simple;
	bh=g7FAc9OYW1op9fQgfvmM6BytK9IwD6jCDZ0xkaq076I=;
	h=Message-ID:Date:MIME-Version:From:To:CC:Subject:Content-Type; b=i7sKC2ggAFvm28OTyMGXRtLIQZVQswhfquLyKMrLS9rLod/3sJqa0Z49xAlGpVE+lAKdGXh1XlAfuJVUKQGPlpprFtINjHtt6+nUWhSpuCwx6nkPMolRyXJCRAlAUXIz1a5nJsYE2g/SPn8Tt7j32W/PYkwFWPxgxLebzDihDGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Gn8Zuav4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48MMkVXc008558;
	Mon, 23 Sep 2024 10:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=End3JsuI3AjzcoV07bmLrz
	l5uJ2BjznpOwfc+5yP960=; b=Gn8Zuav4+Tk/RH3MhRH0KxLhW0Rni5ZX9JiQ2M
	Mq3KAisgCOkgkbOheLs1hEfsPMpsXW4k/DJeKbueoUIzhjo9cUEwgYOSMeEnN7EA
	Z6vDc1vcXLl90NAZ/2ntkowehlNKZR6qbQ6wIFFDRx8IPetKepRDdModdlTp3yW2
	nPRmHzvEO+fIgtGzbmGbZk6dcZ0g0gAHLnK5U1NQX0ykaDGBBFVpgHDiEPcHsAqU
	h9EuWoFfh9ZOgZS00sYhdsHlPAu+0J9iGkUHGcnc1oa3ql9xlriu42OCF0snL/jv
	IUg2xoi3lvmRuWrAHQ/h3Ydg+eTPanUfumirpfe+niBAWTvA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sph6mju7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 10:07:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48NA7f50007981
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 10:07:41 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 23 Sep
 2024 03:07:38 -0700
Message-ID: <370d023e-ec53-4bf2-a005-48524c9cb4b2@quicinc.com>
Date: Mon, 23 Sep 2024 18:07:36 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <rafael@kernel.org>, <mika.westerberg@linux.intel.com>,
        <ulf.hansson@linaro.org>, <bhelgaas@google.com>,
        <Basavaraj.Natikar@amd.com>, <Shyam-sundar.S-k@amd.com>,
        <mpearson@lenovo.com>, <markpearson@lenovo.com>,
        Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <linux-acpi@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
Subject: unexptect ACPI GPE wakeup on Lenovo platforms
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: T8CvMl7AuuKOzCoV-KFOANAyj1yL6-RU
X-Proofpoint-ORIG-GUID: T8CvMl7AuuKOzCoV-KFOANAyj1yL6-RU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxlogscore=949
 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409230074

Hi,

recently it is reported that on some Lenovo machines (P16v, Z13 etc.) unexpected ACPI event wakeup is seen with kernel 6.10 [1][2]. To summary, the unexpected wakeup is triggered by simply unplug AC power or close lid of the laptop. Regression test shows this is caused by below commit, and with that reverted the issue is gone:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/ath/ath11k?id=166a490f59ac10340ee5330e51c15188ce2a7f8f

Well what confuses me is that this commit basically resets WLAN hardware before going to suspend. that said, WLAN target maintains limited functionality (PCIe link handling etc...) during system suspend and is thus not expected to wakeup system.

kernel log shows this is an ACPI GPE event wakeup:

Sep 22 22:34:32 fedora kernel: PM: Triggering wakeup from IRQ 9
Sep 22 22:34:32 fedora kernel: ACPI: PM: ACPI non-EC GPE wakeup
...
Sep 22 22:34:32 fedora kernel: PM: noirq resume of devices complete after 693.757 msecs
Sep 22 22:34:32 fedora kernel: ACPI: GPE event 0x07
Sep 22 22:34:32 fedora kernel: ACPI: GPE event 0x0e

Consulting ACPI tables show GPE 0x07 is used by the EC and GPE 0x0e is used by GPP6 device:

Scope (\_SB.PCI0.GPP6)
{
    ...
    Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
    {
        M460 ("PLA-ASL-\\_SB.PCI0.GPP6._PRW Return GPRW (0xE, 0x4)\n", 0x00, 0x00, 0x00, 0x00, 0x00, 0x00)
        Return (Package (0x02)
        {
            0x0E,
            0x04
        })
    }
    ...
}

while GPP6 is the PCI bridge (the PCIe root port in this case) to which WLAN target is attached to:

Device (GPP6)
{
    Name (_ADR, 0x00020002)  // _ADR: Address
    ...
}

Scope (_SB.PCI0.GPP6)
{
    Device (WLAN)
    {
        ...
    }
    ...
}

and lspci also shows such relationship:

$ lspci -vt
-[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Device 14e8
           ...
           +-02.2-[03]----00.0  Qualcomm Technologies, Inc QCNFA765 Wireless Network Adapter
           ....

Based on above info:
#1 is that valid to get the conclusion that this unexpected wakeup is triggered directly by PCIe bridge?
#2 if this is related to WLAN (seems so based on the regression test), is it the WLAN wake pin (a GPIO pin?) that originally triggers this? and how does it affect the bridge?
#3 quick tests show that with GPP6 wakeup disabled this issue is gone. so a workaround is to disable GPP6 wakeup before going to suspend and enable it back after resume. But is it safe to do so?



[1] https://bugzilla.kernel.org/show_bug.cgi?id=219196
[2] https://bugzilla.redhat.com/show_bug.cgi?id=2301921

