Return-Path: <linux-pci+bounces-39738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE16CC1DD90
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 01:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4FCE4E2F1E
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 00:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0EF1C695;
	Thu, 30 Oct 2025 00:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AZzOjsly";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EINaNLbc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098A5523A
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 00:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761782667; cv=none; b=DzedMf8g1vlB4e89URLFS3UtT+o56G1IkI5jd0BEcp/1TiNSFA5LcOIRcxL5wwC3Q8xXAnjTssrwVT2lryZpUDPIF2dSoEWnxZIpxgGv4qSLFAdbPh2BJUCbJ3GH8TBvAIiG5RTOQVaUwnBsGcBfnXacNokoKd6fogZu2fzqcgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761782667; c=relaxed/simple;
	bh=e8La3PhKLAY0yqATjn4W+M/31632+mqbSgzSPOUT1ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRcCOkHvVzRf60ioR0jhhLcSGbbpuXnc6rp0noU64zYwJNYOQVB4G2g+ZmJPcwGXhHCAhpnBEtAPbH1wmUsa3TsjNpiPLBhaLwAm5Ica7/+vdhCw9TSvvWPP4esAV1e8W/vPEHTlyC44TFiyMWGzUalIXt+/ijlEGKodrTI0pHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AZzOjsly; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EINaNLbc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TL7BRR1578910
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 00:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LmQr/nvqXK+zOFXNOeHfnc6G
	NLUHSfAv8AGMrlOSOR4=; b=AZzOjslyn+AP6WLjvmjMX420G6Qvsy/DISlzjLw0
	KWQZA6TKF17Aacb5Yu0QWeHZNnFlDO8+ALvD935093QNgc5fHMGJIQa9rIL42NHA
	Z29JVa2n1aMfQ4W13LLfkdbMt/y1dvpw6dwF1YBoZ/rWD/p1GmOCQwp1HfQ5Y742
	Kbq8EDDEu3XZdPe6vCMQnMU+MEGf+/LRKcx69w9xQr1gpOsKFSoE0JWwS3dgc7ny
	XoiSMn7IWGZ1WKYmmn/RwNEmKx1veRy2eQj8Z0Hpojunh8GOOK3sZ68VXFt260Yr
	EC1bQWqL2WDAVvEfplslbFtQO/q/q7rldwf8ND5+ww72HA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3tjegerd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 00:04:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8a89c9750so10507201cf.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 17:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761782664; x=1762387464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LmQr/nvqXK+zOFXNOeHfnc6GNLUHSfAv8AGMrlOSOR4=;
        b=EINaNLbcqOUBfky6XcwD4C4eecPBr93cgiqtbiaJkSw2xbUjZQl2W3BukyjjhzsTt7
         gsM4GCVepkRJdRkQ8ZQv1QQHU9vsrzDeTr8i34QnrKiF5A4J/5/bm/CFXViEL0v+4bIr
         L/Q4+Hr1xQNdQUR5K2dXkQFxEJS0WqIRzpc4gz1ixYz1jFO8emGfrWZdFq6aMK2ovG5f
         NnARPlWFTs6lZ3t8wWnpU9Ng8wdSt3RP4iIqyx9E/kn0dLS9v4zffMtQsML4BHOQiv34
         2hhWNlNG9hyYRtabPjv55k3IJ6Kg3ShEAtlEJl1UqnbbV9uqyvLB2ECgLa5KCQTQynqx
         lErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761782664; x=1762387464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmQr/nvqXK+zOFXNOeHfnc6GNLUHSfAv8AGMrlOSOR4=;
        b=L6VK/ruDp3quRKU+yCak8pEcaTidFHu8Wz6COYKv3QtIbylV3xycMxtSys7AikeG7T
         yb5H7nSyHvtfM3engYmqREvSXJX1jGjbF0YFdApNm5FbrkW4kWVz+vxXLKCPwZmACTei
         7XR0i8Pch0V+PalQYalBvrRJaJ9MktI+maWPhEKJBS4sHPUDZKycWuUxajLJzjMUnGCD
         F4UDvJjzaN5tSDbXe7KT8mABVhBzRgNf9PP9Eut9gjx3wzPlwmr9FYXpvO5OttoEjz/R
         Pe9DA9VlTD6wumLspe1BCiBEh/Z25eZ3Im6QR+vm97QKB5gEJctd0z4S3RXgqaQfD6i5
         4lhA==
X-Forwarded-Encrypted: i=1; AJvYcCXyKL2EkbTONBxXcDP+t10cEDOEOO5ox7qMoBAhNpCJZOfpNI01OtvwNgLqekAmWe4sYg0FdJ7HyJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YysrjAwg8UywkLEYYtFnee2zuZY1JOuegqWCSV1hxx/27TDkzVr
	oeoMFN4tetFw7sL7CQziyEsICEgOKtyal1hMkysd40ImuJrgzx8q/BlBtu2XHPATfSyy0QlqgHX
	DvggbKktbwIxXyUMYSj26OBqj2FZZeSPvqvfsX1QzJ3ttCEHvrIncU/ekqJRR7eI=
X-Gm-Gg: ASbGncsIuj67O9CgDZAvG1V65BeVjaWFgrJMAFwkFeOVQ0nchuRzPfmqMQhU4qGmKHy
	tFgB3HKSzSaQErbonVqCqyD9rhwMBZBrtg5WhB4kYP8s+lrHWiVbH24txNKOduqaYBsUrQWBKrV
	pHbMOCgzUHcGG2lhxL8qkHB3Bg769n0x0fOaq8Bou8F0euSdbgxNYuYM61Qf9UFnljiUOEuQ0kC
	EUG7qVMnhXn0QbGKPk/msv9wNlp2JpzoYe461HWVXD21m4NXjjyhh7fP8ODe6BLjkk/51LbXZOd
	jd2K2fJ+Zz+IcP2C7FOXWXQBGQw/2gMdjYJ/89BZ0I09xRRCtZjvjTTdsCWKzsa+jJbA58p6ei/
	5rRPDWE2zvu17SfMD+G4d3b4wgHWDBiRd14n4r2XwPdKgy3KdqaXzgFp+tyQvPAOuQigqP66wqI
	AwNUoJPhrF72/2
X-Received: by 2002:ac8:59d4:0:b0:4e8:9704:7c83 with SMTP id d75a77b69052e-4ed15b53e60mr59019471cf.14.1761782664166;
        Wed, 29 Oct 2025 17:04:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHls9al2XoteQcyohoS5y0Zyle0J/v2kM9a5LZVzgtA4jNe9zTqJ/FMEHsgEyEmUumiISYvUQ==
X-Received: by 2002:ac8:59d4:0:b0:4e8:9704:7c83 with SMTP id d75a77b69052e-4ed15b53e60mr59018991cf.14.1761782663698;
        Wed, 29 Oct 2025 17:04:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f7444bsm4248514e87.85.2025.10.29.17.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 17:04:21 -0700 (PDT)
Date: Thu, 30 Oct 2025 02:04:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v7 7/8] arm64: defconfig: Enable TC9563 PWRCTL driver
Message-ID: <jjbiamlcof6gttme3crotwyzsxtrguohaib73gcsaabpan5fqe@s5uroqqargti>
References: <20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com>
 <20251029-qps615_v4_1-v7-7-68426de5844a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-qps615_v4_1-v7-7-68426de5844a@oss.qualcomm.com>
X-Proofpoint-GUID: g0fW-sYzmP63wOPE9GvH6ZN974iGUmx2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE5NCBTYWx0ZWRfX+jFboZK0idz7
 KPPhbVwarNCGlaTws6q7nIeEHKVdNdfTFKyW/CksFa3L/gl9h/6VmfQPqZtZHCdX+9ftFaC8X3P
 IKBuD5ErzuJtd0n7AKDzrRciSiVqya+fSDNqy55foQKG/FZU11SVpdMUzDWnrHyqX1MZ3ohQc4E
 X+ZZOp62Q7qafDwMW9jDcCZD1UYQxnkiFztwowY0I03XcloWW1emcTxnlp89syL/Fwy/uB6vMhP
 IevqRnwKOIlKhfel1JVTG8pDcMS7NJNNl7PauG5A0Zuw3355yoWQuAvtAYgXnpF4wLoWI+Ilf4c
 maOLZb7wI21VegzDWQpnPblSCP1ADVznWu7PPbORbFkUrwqbYg+TTSPR2lwQd7lLM0DFs1NRxNW
 mLR93bYze7JxBbsEY3k1Dzptw19OSA==
X-Authority-Analysis: v=2.4 cv=a/Q9NESF c=1 sm=1 tr=0 ts=6902ab89 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=EhQ9wbuxbXqUBhoRm5MA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: g0fW-sYzmP63wOPE9GvH6ZN974iGUmx2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510290194

On Wed, Oct 29, 2025 at 05:00:00PM +0530, Krishna Chaitanya Chundru wrote:
> Enable TC9563 PCIe switch pwrctl driver by default. This is needed
> to power the PCIe switch which is present in Qualcomm RB3gen2 platform.
> Without this the switch will not powered up and we can't use the
> endpoints connected to the switch.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 

There is some broken logic in your commit order. How comes defconfig
changes come before the driver which actually defines that Kconfig
entry?

Please reorder your patches _logically_:
- DT bindings
- driver changes
- DTS changes
- defconfig changes

-- 
With best wishes
Dmitry

