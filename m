Return-Path: <linux-pci+bounces-32064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF3CB03C04
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 12:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B952F7ABF33
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 10:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBF0244684;
	Mon, 14 Jul 2025 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iPJvzfiv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC663244666
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489510; cv=none; b=Ca4WW72EYl36h5aQrbhPKc8Z6t37gP2wMmyIJcA7gVHT/DLqNttdx/4AFfK6AY3UFv+wcKm3RE9ty+xzlLRkNoX/GVWnn33fJM9Yj7af5OGRsrOuOhKB3GxGgd0SvOo/UIH/txKEmkR+jRGLIZaiFk/tOcJPntEgUqKzw0sCpqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489510; c=relaxed/simple;
	bh=GZ2HGTWvnUJlQg65o+LqMmyqo5eSrqABc5KMQTX++6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n316r35jJTry17c7qR0KNP6t3/SYToYXXLZ8fxU6qK7JeGFNzTBuXHROW7G7DaGTYtJ55MUzUgCZDTmcBTJ3RP+XuZvfbOeKHJHAOFe6uU44zU+dyEoPoTojf4MQ5dTgL6xYaG6OKH6q4M3XK0mDUoKoDeDnXlhHeuhmWJ765og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iPJvzfiv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EA18js032000
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 10:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L+pEamc9vV5xI2V2tpf5IYZyBkoyhwgtCvGmaF6cxpY=; b=iPJvzfivcslC8vxF
	9HUN3hO3mzFF0ee/o0RcLf+koZZ0vn4aaILSc8EtMtXNLduA35GhRDuQG8oi/7u5
	GtSqOK1iB5MHE3z/HSMtsqrake91ZwyYx94wK3F4DTY6hAt6E5IFQ7ACAmw9sb2X
	zKtdp8Vh9eh64wSe/qX4NBj4l/oUbjUFXcv3/RWi0d8Jb5xyUHGDwd7jmbB2XM+g
	BQ+ebwUaVSa4PxKGYxqTHqNRsII0irpgYgdYZ/b+9wuAsy+CSxYMBNzJKNiHNiBH
	LmxfDj+0nXQbN6NVfhjvjZfqMtT+rwOOY89Rogh/xlLVF405bVjl30MfjVRDrWSc
	9q3GbQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ugvmvcyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 10:38:27 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7df5870c8b1so44027785a.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 03:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752489506; x=1753094306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+pEamc9vV5xI2V2tpf5IYZyBkoyhwgtCvGmaF6cxpY=;
        b=vuij0HYGgrrZ2UIQteJYB1/WX/7D3e+HEJL08nwQq2T/U92T1pNxVQatDjRHA2rJ6B
         tYKzdJmKGugF8SEOCSueWXngNc86XfIMTXv3aDwDeKJgs2fSeO0u6CIBXIemQIata7My
         ZbyXEoF16n5SzwUzRkxP0wk+ABXbojS4/KkTQ0qw1W1PlPlCbWyFpsty0uNF6HufAAUh
         0REAAj1yXWIE8tj1i63XF0sOTsi/xMf4cU90dSQq+zcjJ7P0AyES0xNLHfePTBIL2lHv
         vbFccX6f5FPzpbf3zwcK2iYMQM35YDcJcSsIO/9Oz/ym2xlvSnrbhCPzljdANawW6jg0
         7MrA==
X-Forwarded-Encrypted: i=1; AJvYcCW89cfnG1AFM+zaJd+N+PBw/TtInfbf4HWkJ9FE6cYOPuGU8RFYo+e4Vrncc11Bl7RsM7Mtw5gcTxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVYoBrcYq4YE/W344VhYF8wPC4I8/2EeIXqo+/Jd3JHME89ecY
	6d1uM7ePXP1vu8QoxPoO9w7qU5QsHp2U+odKIVyUGSVvoQByRk0DDa6sda5N0pMJjgWnR8VDh60
	ZJmnVT+68se13Hr76XbRO2YQp8Vy20PqRKuE7vqGoZdnvqK1f2Uw75z/+LtvpDDA=
X-Gm-Gg: ASbGnctOUzkl0OXX+hvM3iTPpqeF0Dg9RrbTvn2hbGJHxV6gVlnhMjUcK/Gn+CILXD0
	5ux8sBX4BMljPdCg8Tx2EwKL24oFseuZwPIlHwKbYGH/nkDMVPaRDggz8pt4mywT506kabb0PJJ
	7WXexEAYObII81qTWdti8enD5DP2Xl2XCI8ZUr0p0TA10uhZKLstYOUqnOtx6F0bL3pQhnCvsmY
	TuBncjJrQtbb589eH5veLd1EGTgoyfN2IzhD+hDFuegMqP9Ps2wORPpf2RL0q902ZjVOt6YIRuT
	H42UBdWCHSs6oPao0ptlpzIRt7YWto1xd+b+xO71LddgdsYcNY2d5fGbYim5AaoEiXJdl3S8Ky8
	nhBbKdJsrTsCMXer69L9n
X-Received: by 2002:a05:620a:890c:b0:7e1:5c99:28ff with SMTP id af79cd13be357-7e15c993e83mr330822485a.5.1752489506577;
        Mon, 14 Jul 2025 03:38:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdHimNvkqNJF3cWwL5W/XfGk57FmjaL47RCsELpgNXpxCvIvqKwTIbW2FY0d+dH8dVZxn3QA==
X-Received: by 2002:a05:620a:890c:b0:7e1:5c99:28ff with SMTP id af79cd13be357-7e15c993e83mr330819885a.5.1752489506030;
        Mon, 14 Jul 2025 03:38:26 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9542fe5sm5779560a12.35.2025.07.14.03.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 03:38:25 -0700 (PDT)
Message-ID: <75cab14e-e57d-4d1f-aaf2-ca75dd37154f@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 12:38:22 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] PCI: qcom: Add support for ECAM feature
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com
References: <20250712-ecam_v4-v6-0-d820f912e354@qti.qualcomm.com>
 <20250712-ecam_v4-v6-5-d820f912e354@qti.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250712-ecam_v4-v6-5-d820f912e354@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _ZIKPM3np5JgE5jBxDtCK2pteRT_eWg7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA2MiBTYWx0ZWRfX6suQ+IyhQd5U
 j7LB0+PjnmW0MwbJwxwAt8gz7QmS5dHPRPtW8RVf2asEiEh2Ax5O2bX6yJfjCqL8FcS1A943avR
 vFbQkVIcepD0Kfcrbfwi8yN11kxHMi6wju8FXHPotIYSZAF/u9r2L04vISCqCRvCX5PDBX2WpLm
 khD3cG7LlTUAREeP89Mw7etwk1n/BZUObYZ69Zm7uptXM/049KWsMEpv4fNCJOI7IIZhtdbxgaX
 Q8pyheJYRqn2Kh5vwGD0elZrFGIzOD1zR1U1r4Lb7TqRNuSXrmBMOnB7iHeaMPIz/FJXQuAcGuQ
 hX7+kDQUPGcqlUzxHiBCTxetq5TxLbiTPzOXmyrom7q4YX9SW8KVOlZf30RQybQy0Pl3snawbqx
 sOm0hVfNgBSo3u9T7XOhdHcmjpXZRjplNa06sxb5G7gWQdaS/MXDQ7iQBoCWDY5rL41fKDBT
X-Proofpoint-ORIG-GUID: _ZIKPM3np5JgE5jBxDtCK2pteRT_eWg7
X-Authority-Analysis: v=2.4 cv=C4fpyRP+ c=1 sm=1 tr=0 ts=6874de23 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=obKXXINtG9EwW41erPwA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxlogscore=711 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140062

On 7/12/25 1:42 AM, Krishna Chaitanya Chundru wrote:
> The ELBI registers falls after the DBI space, PARF_SLV_DBI_ELBI register
> gives us the offset from which ELBI starts. So override ELBI with the
> offset from PARF_SLV_DBI_ELBI and cfg win to map these regions.
> 
> On root bus, we have only the root port. Any access other than that
> should not go out of the link and should return all F's. Since the iATU
> is configured for the buses which starts after root bus, block the
> transactions starting from function 1 of the root bus to the end of
> the root bus (i.e from dbi_base + 4kb to dbi_base + 1MB) from going
> outside the link through ECAM blocker through PARF registers.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

[...]

> +	if (pp->ecam_mode) {
> +		/*
> +		 * Override ELBI in ecam mode, as in ecam mode
> +		 * ELBI moves along with the dbi config space.
> +		 */
> +		offset = readl(pcie->parf + PARF_SLV_DBI_ELBI);

I see that the offset is supposed to take up 12 lower bits with the
remaining ones being reserved. Out of abundance of caution, please
add a #define SLV_DBI_ELBI_ADDR_BASE GENMASK(11, 0) and FIELD_GET it

no concerns apart from that, I think

Konrad

