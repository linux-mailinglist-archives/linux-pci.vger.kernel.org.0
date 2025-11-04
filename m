Return-Path: <linux-pci+bounces-40223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A167C32188
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 17:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3FA189E9A2
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 16:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A05128816;
	Tue,  4 Nov 2025 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i+MZG+D9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SJ/ro4sE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BC1199252
	for <linux-pci@vger.kernel.org>; Tue,  4 Nov 2025 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274327; cv=none; b=RCoRaAeXrnja5ps/0fx2zdUnNUFMb96QTbEhrZmsj8h3Xn6aW8x7TvJRPCaFv5QA3wSTCDcDQR7uciVBzql0QPoZDv0TQNp6GuqeX8ZVFCAKEUx4gYmyVg7dBMIlfpq5yexCqJFkVyJE2VQvAGPLJV4Z9fq6+0A9q2AZsrPlgFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274327; c=relaxed/simple;
	bh=WP9gc6aoabGI8uiHDARaHICukxcNlD501b4UKexOpVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+VS7M0RUYdfVuq2XR+3Sde/aC4rjDk+SoPsjdQBCthaKcRJnh/L1o5WhlPfLTQXGKuGyeLrt8kKXEAwsVkTXSaFIoHR6rVm/ifTfbOWXwrwTAy76WWEtytUiAXHpxz0dOw5vTpL1OKD7X7Y0OtLWOddjEFLKVw1Stt/pjlOmM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i+MZG+D9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SJ/ro4sE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4Cfk771974141
	for <linux-pci@vger.kernel.org>; Tue, 4 Nov 2025 16:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WP9gc6aoabGI8uiHDARaHICukxcNlD501b4UKexOpVc=; b=i+MZG+D9QijvQiYs
	E5oTiPE4X7OJCHpTaXS8W6BbOL9JuFfBzOSGrV2EXRABaM22NisFXwPEN5KJI0xF
	EI12SU2ybN7gCw/QqXjRaZ8PoTKD1Uc2nNt50nbhn6nwPwWxIaGUfRTKzHIXjO4b
	/vRJr5oTbNd15FiAOl7e+DdUe9HaMNoeOl5J9ec9XOf2iAH27ny9OcYtLayrqno5
	OAt/XXaWJHJDfqAcOW0UWlLG882Io6b2C3UGWVrtlUBsCOLmQ9RnJpO6y7yD2tWo
	x4UuvD+Jsrrc8zP/0tLA8fcUKVwUEZJjAQIITOqsZnLz3Udrmy0ikMr/T5Z1T3UZ
	QVuu8Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7heagqwy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 04 Nov 2025 16:38:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2904e9e0ef9so132514305ad.3
        for <linux-pci@vger.kernel.org>; Tue, 04 Nov 2025 08:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762274325; x=1762879125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WP9gc6aoabGI8uiHDARaHICukxcNlD501b4UKexOpVc=;
        b=SJ/ro4sEwYIQXCEJTaNHZy7nrFSWgXneNxXPfnzkN5KzhwQgclVLVOLJ0uZ1RnbP1T
         qDs6bJxcj2BN5zApJ1+AZY51nvvcP7nJhBIz/BMumdkHKxZPQD6SL/XIIvNEAkYkERPa
         jMEh32eT4mjd+Es9TTcZ16CeUKIc//QbluxyU0ZFbsH5gdmH8y99qknRTlxdsOyZTDOP
         zzWcagl9y/bkdwZ9nOBvVWF5efX4ex9rFkPL8yLMJj4zNX2M/i297qULkSRYq2X6szFx
         ADoZmwCKkjtze+RNZsvQjaHJIwL1dyvff2lkZ4Xq8VgZiaBjMEdiMQsjyMiCNCWmvXU4
         WazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762274325; x=1762879125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WP9gc6aoabGI8uiHDARaHICukxcNlD501b4UKexOpVc=;
        b=CZffIHtWWlcQuQaM0MgsYCrLvA/MRECQKNGoLjqJ+O+V/6wwSGUUEHSuHk54vXSFFH
         OGiC5gru39az1GJUvK5xfG7yGp9iF2TFItzZb7lYLuaeTi7wnHnbv4ImBx3stoHDJwBv
         IRfj/+coIG2ZvTZ3P202nl3cjs2cQ0eByOuUOeZIPmtTCPPucLi1iLbjp/YwJa4ikLHs
         5IHC17H3qf081b+nUZkM8AbIc2r+HxZWhsk9UaYgF0IKCQh/VJtftuscLYLK/qU7gLVp
         GTElx+SEXbjV9m1++hBCRovw8S9HZ3iqkslBMhJOvmwXbucesTOrgJpIWf8Z1xBo3JE0
         sTvA==
X-Gm-Message-State: AOJu0Yyco6Chrb+CqWy1xlxdOmFrOU/YW8rIxBimRZJdMvXfn6dDUb/J
	RYUT8lAD6xT6uYx7iT70ncAuD0ytlCW8Cjh5MJpi3ve+pJQ8/A8k4VVlZeCju7slBAufbnKV5q8
	Z27LUzu8biAOqOLfk+uoTfFgmnBVPWAxa8P12cLCOkgW9Gs1gnY39RWA0Ppsp4N4=
X-Gm-Gg: ASbGncvOXOocfK0yCXceri5TnqHGH2RQSG22a37BnfjVnEqwybYWLiBziA9cIcaN16r
	/fNqp2/eGTvMUJ2qhuArey+lInuSbMqQ3BMo7XksqiJGp2OB2uaWQAiWuzawcRe3gMYmK3taNjr
	NLZZd8+0TGFH+Uw1ayGhSQ8ES6HIn5pmO0Cy7/QdHKkTSnZYz3Ybj5Ypz34uOZWgHJgh+nYngzh
	UCdsZW6C26Qrd87seRYG0w4iuBFz2y82gepxldMfnLeXtJ2wrUflxJ1KoJ8+RW9MEV/MmieSFvG
	OTXybOjFxHRMvORsTQNSS4IY0B9FOZ9/G8wepTwHpELROfFMnc68iotzjWfyus5+KX/uJs81XgW
	/+1DUIEvCPR4/NXCzbXJRNbFtjFABPSVEkA==
X-Received: by 2002:a17:903:46c6:b0:295:39d9:8971 with SMTP id d9443c01a7336-2962ad0c936mr3416745ad.1.1762274324891;
        Tue, 04 Nov 2025 08:38:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGz6uJF0hcsIaWD0Bqp9R29GTarddruadQBQ56H22/WdcYPRdszrtsBx7nayDpricbv68SMYA==
X-Received: by 2002:a17:903:46c6:b0:295:39d9:8971 with SMTP id d9443c01a7336-2962ad0c936mr3416255ad.1.1762274324314;
        Tue, 04 Nov 2025 08:38:44 -0800 (PST)
Received: from [192.168.29.63] ([49.43.227.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972a9fsm31883835ad.20.2025.11.04.08.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 08:38:44 -0800 (PST)
Message-ID: <2d4a192f-45b2-4aee-bcc9-dbe0dce0aa93@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 22:08:35 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Program correct T_POWER_ON value for L1.2 exit
 timing
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com
References: <20251104-t_power_on_fux-v1-1-eb5916e47fd7@oss.qualcomm.com>
 <29b32098-39ca-440d-9b51-915157b752b5@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <29b32098-39ca-440d-9b51-915157b752b5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GekaXAXL c=1 sm=1 tr=0 ts=690a2c15 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ISmZZG41GQzdpg15mxjwIw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=WGPAbWhItJlpQzQmOdIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEzOSBTYWx0ZWRfX1mboY+/alC/r
 zoY6u1j0KRHC9nWfNGe17Rb3hD4V61bezPksyNnYXOnYAi/IvTQsJHwa/28YaVcEqU3IgPcTXjM
 9Nxcpq5xh0iMcZMRi4z7ImQZZ0dAiPv/paAUtkuSC9imKcJUEdtzwLMSEBS5ojSQ/iXgNaZPrmy
 ptOqkh0tZmEzxMd4AHtXnSzoU6/nT/VB1ns1yhl9VZ3v0184qxVlesFrtCFnzr66nvS0i3zFWFq
 DSXfSwMtuNtc44kWq15tcgfeYzU5xi4wGSXTyRkO5iu6ndpITrCIjZJy+vYtV5CxG1bvog2d4lM
 Jphetau/sflmvdADpSgPfK/JxHsxvT8U2C0hB1txfPnZ8UlqtOqWzhJpa6tWvlV6kgBIMABpjXi
 /8W2Y4BCS8rp899ChK00DdwwB0MaPg==
X-Proofpoint-GUID: 9E3BTMULWM2ymbUABK9QexLQQNc9l8Cl
X-Proofpoint-ORIG-GUID: 9E3BTMULWM2ymbUABK9QexLQQNc9l8Cl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040139


On 11/4/2025 5:59 PM, Konrad Dybcio wrote:
> On 11/4/25 1:12 PM, Krishna Chaitanya Chundru wrote:
>> The T_POWER_ON indicates the time (in μs) that a Port requires the port
>> on the opposite side of Link to wait in L1.2.Exit after sampling CLKREQ#
>> asserted before actively driving the interface. This value is used by
>> the ASPM driver to compute the LTR_L1.2_THRESHOLD.
>>
>> Currently, the root port exposes a T_POWER_ON value of zero in the L1SS
>> capability registers, leading to incorrect LTR_L1.2_THRESHOLD calculations.
>> This can result in improper L1.2 exit behavior and can trigger AER's.
>>
>> To address this, program the T_POWER_ON value to 80us (scale = 1,
>> value = 8) in the PCI_L1SS_CAP register during host initialization. This
>> ensures that ASPM can take the root port's T_POWER_ON value into account
>> while calculating the LTR_L1.2_THRESHOLD value.
> Is 80us a meaningful value, or "just happens to work"?

This value is given by hardware team.

- Krishna Chaitanya.

>
> Konrad
>

