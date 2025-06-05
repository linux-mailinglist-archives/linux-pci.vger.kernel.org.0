Return-Path: <linux-pci+bounces-29053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8B6ACF611
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 19:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5520B16FF21
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 17:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5586827C877;
	Thu,  5 Jun 2025 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YKnCut+c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B827C857
	for <linux-pci@vger.kernel.org>; Thu,  5 Jun 2025 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749146201; cv=none; b=arL7MrQb9YEhbowHFik+gtvX/RatzN2HeVo504/Cvzqkni7A47hjn3E2tqMSvakxoq6Yu4sbZwL5W7zquRhiFNs7DNX2OrUTEBDTyC54AZednmfHIRZzojU8i2OW2rupIGfXHLmrzzv7ZSGhJAPWe+9Fw6rBy/ZURaAsw9s2MXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749146201; c=relaxed/simple;
	bh=gMroWcHjboWrDGM0ZLdaI8dfCuaAXIz3Ryz9wJRs4Y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLqKUP3WqgsSq6+9xk5TKhS33yWaBO0OXZ3ZZpjcPV7dm4TnrPKjd4gAV434JcW7kC3WPtmrEjJ2WMVXwkHt0yJDcyLLLGsxEW9Ld8hfbYqz2RiH8JF++2+a8pKoVyodFl0rPBVBbKoaNTNQ8z4JMLUbaxdqmJaqmeLwLwY1tGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YKnCut+c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555AUsaR031915
	for <linux-pci@vger.kernel.org>; Thu, 5 Jun 2025 17:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kZcQKtQ1ov37yB/aXsBXEWGJWFPqRd9laCgmUZnxfnI=; b=YKnCut+cQlT0BUlC
	qNGULUZb/+z9n5FK3yZoJ+Bj27zW8a3gB3yrKhR7mkXvcTikrfk9nk2OhpZ3vREW
	Lf0N0+lEVYq4PqtJFMgwkssNpI601/0HRIQNg7IIUm+jR7jOi/Xtxar/xFlYd9I3
	YQhLsH3EllhEOuCy4J26MFt76M1t2Qb3A9iQ2kk3OXvUcdz3OUlejgnsyKUhcYfQ
	l7MQUCO+kqhV1W/HaN4m/ZL4/n4LtXCpO6s+BiXxm96nAQdSSFeOp/nldRJoGt+/
	4LhtrKYLGnAfczR1acA7h7/tDBHoppU2dDs4HtQkaEp2ZDUPge0w7RVj40WcP8SU
	eYQl9w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 472be85x6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Jun 2025 17:56:38 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fafb22f5daso2120796d6.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Jun 2025 10:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749146197; x=1749750997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZcQKtQ1ov37yB/aXsBXEWGJWFPqRd9laCgmUZnxfnI=;
        b=N+bd+9tm44ODbKYc4oB+QCk5tcpmVMMA37KD0Uj/fr+zarESQcuK14XMVSnLkdEEBa
         OsWcdTVLOMAj1r8a9mf0IMw9we/fr4oW7JLf0WBJUdewNcBG3AGFqBXT4JQDKc/O78YH
         uwD2MwpRAdU58pMl5JJjjxbrVU049FTNS2YySlWi3pjDFAlbi591xSCKlZjSm1VNJLy5
         cdXJh4qFeE7CvVbvzq3toHblDVJgF4iUwclClaRi1zeZkZMi24bY7Ad4RCakXP/sf8ou
         II4nKhpydfXVu3d2/JKzGVWdzcJExsJSwtyyrAOnCho9AESSuYCre1zeS5ze7reGqQPl
         wiZg==
X-Forwarded-Encrypted: i=1; AJvYcCVd2xCyoEurBl9coT9GJVnUcIYdtc4bxdsGTm39jItbZIIVrYVEktG2nToM9CGRXM92y9UhZNJ+0dE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlovW0JmplHrdVO6hGoc7O1ltY69Ueq+gXZDs4AzJGbvv58iHV
	v4hCUSoUNdLkpUqL7ils0loyJ/LSM56e3XHZuB9E02bxzRlSPEQWRaiKOCcQOUwiPlErmZEj33B
	3aGCJgxTAMWGmE2JbO7ux6kd/ifBgW/f5tahRUERDZ2SS/g4XEZTmmlizAFvJuos=
X-Gm-Gg: ASbGncv8/GSlk5aYyfagsp4jPRzISEofIugXxXSng7W9nu7kFHPjOvec7nCBJ3mtbU9
	xQ4yyITOaW8/NCOkhkNOXRp8bVN0wl2p7+ySTrZFDEQI7Y6rafwmmgLx1BofNjGZwMXwQxibWCv
	lXr2qVn9pt0o18C+8oXelEcpe3Be4py2Q+5gghGV/QFCH+PoLbL4/Dxr5QNfz97dMhWFTGnoiuO
	4iKF/3XlOO4WJH+DAahoxeb0pP9ghukAkh8tJ/lkVc99QimOFRkjIUmCP2fX7AdAcBEw5kbJ9gA
	R/RwFxXNlnDJzUFo0mfW3FYK2qyC1VhOApN4YqSdQoxWaqiz0vd/5YENOmnfLmr89g==
X-Received: by 2002:a05:622a:607:b0:4a4:323a:2d76 with SMTP id d75a77b69052e-4a5b9f3c841mr3459151cf.10.1749146197313;
        Thu, 05 Jun 2025 10:56:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT3i6QouPUynjX4yzcxTQBbYY9kUpqtzwk6L8Pm4W1giH5Gphq0ngetzOJkdmxHBjlqVwyAw==
X-Received: by 2002:a05:622a:607:b0:4a4:323a:2d76 with SMTP id d75a77b69052e-4a5b9f3c841mr3458951cf.10.1749146196865;
        Thu, 05 Jun 2025 10:56:36 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82e80csm1283599666b.71.2025.06.05.10.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 10:56:36 -0700 (PDT)
Message-ID: <922180a7-ff39-4511-8640-ed8bfd777fc1@oss.qualcomm.com>
Date: Thu, 5 Jun 2025 19:56:34 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: sc7280: Add wake GPIO
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20250605-wake_irq_support-v3-0-7ba56dc909a5@oss.qualcomm.com>
 <20250605-wake_irq_support-v3-1-7ba56dc909a5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250605-wake_irq_support-v3-1-7ba56dc909a5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bNYWIO+Z c=1 sm=1 tr=0 ts=6841da56 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=lN5UOK94kOf-3Ws_NdwA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: KRWlhmFZXtCeRn7d_Y3Z2gLyTcG25iw5
X-Proofpoint-ORIG-GUID: KRWlhmFZXtCeRn7d_Y3Z2gLyTcG25iw5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE1OSBTYWx0ZWRfXznZ7ZyUpdwJU
 IdvFf4RI+b6QWspxh+lFiX3vL/YVcbDsqEYR8WEBPV574em42YF89fPtByFN2vcDchbrc+n82My
 aImYtrWg0Kb220rI01/UlIoxHSYd+UhX7LbHVJ03V8Io5iXoUuBYk3I+h0LgypnaIZhp16BidFw
 f2PBwHGeOTuVjd/plLRhzXpqbH0CgA/cEhh+YsqHzjMMlASjOfD3cAcOyR9/W1YQOqaytfmR9Uf
 SJaErOA64vXV9RbY8vinQ4YT2zNyFTsHpROYzsd4wv2IwNV0EaM0hS0fBLY8E/ewCXnAIE7GeXY
 DfjgbHoQrTSOQU8BTb8C3S4TzPKf67aHxDDpJuR1vHO2tGpgc5xMBISyA7fdcaPqM85fXxAQ1wO
 dIQkRd7Xstz+2xbF5G+w1lCOjYxjX7n7jpRL5PAOHjhEBH/n7pw2u2BjeNMrfcdLcwWtojcx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1015
 mlxlogscore=788 adultscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506050159

On 6/5/25 7:24 AM, Krishna Chaitanya Chundru wrote:
> Add WAKE# gpio which is needed to bring PCIe device state
> from D3cold to D0.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

