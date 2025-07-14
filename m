Return-Path: <linux-pci+bounces-32065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 658BFB03C07
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 12:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC8E189EFA5
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 10:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A07244669;
	Mon, 14 Jul 2025 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fhvsdayl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B182248A4
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489628; cv=none; b=nppl5SP8rH7cfChALUzFhZ8kWyhNFXhKEGMzPww6ya+CIyH5VADlsAbbjgBvYY7WeRyPcDCVAhgTnVU+Crmy/7xKlkyyUXcdGJNFWj3CllTuFad2PH9dtP+C1MLnthQqWh2NPday12aO1qwnM50bpVW2JAZWg3iPE13e6dAPM+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489628; c=relaxed/simple;
	bh=deZbUNhBldTby3M4tmLgYzlvbCM8uzYYDc0Bw4Lpp40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSc7L9UO1R+HcLCdph71DZ6xHUFn53aCU3Kky2adpBpp6hJ40bqJH6AtgObqwCI2eKYgYeuVnAgZyymz6T6zgg7bx/8WaRtiQ8aDJhg18NSGh1Ab9s1AxiTjH1fR7p+72vXKk9kRoRCELXV78V7O11iaXLXMTIsVNLkHjQJcrz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fhvsdayl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9x9CR011602
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 10:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tB2e5ggL3fY/edqtAXsgpHxBwZZ4IBQnGq8lX0Jlges=; b=FhvsdaylWjE9WdO/
	y9Kqvwxd4vIrZXsI0F+phgyrnZ0TQRrAAhf/ecx2QOgtEhGcXx8FtjgdSm3+ABQ/
	m9TK1RSYL64LDGwcc80A0+7g2RQlq65ZDaV+i8Gigb+BvRMWzQMsstWUPWzH7R2C
	iwTFirkgI7kISQwbRFKW4mndZQGF9wuJLNxctbx9RRxH3vrKsKchDgBbHRFE+EMy
	k5IKBdLq9g5TDUvIBdYSIK0SJy1oSp9fHqezROJbd7Yfs4j9X8AAiBLJoAeb/sSy
	4aafdxsrHsQjOZQt2c0bJWcFbF1svbXYQrXrWPchvgxIAycUsdG1sZFvhCmC3q56
	dHj+VA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ugfhcd0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 10:40:26 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fabbaa1937so15166106d6.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 03:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752489625; x=1753094425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tB2e5ggL3fY/edqtAXsgpHxBwZZ4IBQnGq8lX0Jlges=;
        b=pKC+Uxs9CLeuxxEZ9aZDOCQgZ419I4H4jwq52mGq3/cgSb0HfFuIQDXIf+x6vA8w0M
         YJkFww1NhRY5zcpTgo9lUPmQ9GrgT/ADguuPqpdRGe7bhRf7a3xIf40SIjN4FvWUmKR4
         BMvNPfXBboeCNTue5xK3HthhkxBqaHAjlO1/fvVI60GSHYeeG41BHqpT5Zt6s7X8XepC
         yi3rhH9JYEh+3LHyRTuHR/HbH1x8t3PJH0SKQLpnEszDktT/giADhRhh4K7paR88mEcd
         MCUNbs6IvbSZrCvBilvnxfHkYUIou6KuSvJqTpnQH0yRuTxjZO04gQL6EW0sBtI9wYXY
         wfpA==
X-Forwarded-Encrypted: i=1; AJvYcCWLJEiFH7cf8HBWEuyD7ke8YaNXAhYmmVts635jRo5xrSGPBWTmOHhBonlkLHCUnahtDTEhl3I0TRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxwD3lR2YaMkHg/iXXtlEm7IDV4BaFFPmJlKU/KJsANIpE3LBE
	+CtlhYM/dESHpqpqvqJFuWw8xkt1NxnnMuIqKTgqz93edwlNFlqKpuq90SsIh0N8RJ7GZWHMBJN
	WJ6WhO8ePwQ9Jx77K0R4mo67YuLFkQwvPlr2P2/hPffK1r1J9XqORTFjP9bJV+Kk=
X-Gm-Gg: ASbGncsBd3E8nBoINXQg8CVqLab7ixqc0em2eSODQrMIjFVWOdts7Z8oHB32OYzmwPd
	g0PP+xqVtER5Fd1qRXolEyFrkQGIWFJs78taCgfcCMHDzRzLlj3AbmNVInYZM81D1H746XIA42d
	AYKHejbtsw/i7Ny1vVdq214gbGrDQ1tYmdszW6l1zsorpsJmYRL3cRaorvZvGct2i5sLllwNmD3
	H1gxVz0HOUEOG+5HsKyrsRHJF5jUbOz8oLXqmdFohuSW4jnceMxldKy7jg/DL/fFtAHqhv8rbUb
	lVNi83stTnx4qtebOnJpqcK9s08HHnw8yHv5h6hV9vxfskvRMFkYn75BYyR60aiD0mFB9mVvgcv
	tQEIS5mY8m77Iju0sXq0/
X-Received: by 2002:a05:620a:472b:b0:7d3:b0a3:6aa7 with SMTP id af79cd13be357-7dde9953e8amr669331285a.3.1752489625155;
        Mon, 14 Jul 2025 03:40:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX6K17hMp2/ulIBMK4DVmm1PgjYLwQeegXlJ+Ljh38oeuRNcCU+4bDQLs8qGgRUtnPnOjJTw==
X-Received: by 2002:a05:620a:472b:b0:7d3:b0a3:6aa7 with SMTP id af79cd13be357-7dde9953e8amr669328485a.3.1752489624756;
        Mon, 14 Jul 2025 03:40:24 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9523b5asm5919012a12.23.2025.07.14.03.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 03:40:24 -0700 (PDT)
Message-ID: <03b0d4ba-a1ec-4196-90bf-0ba38d620815@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 12:40:21 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] PCI: dwc: Add ECAM support with iATU configuration
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
 <20250712-ecam_v4-v6-4-d820f912e354@qti.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250712-ecam_v4-v6-4-d820f912e354@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: yMkB90i4qHljQ9JVrmF3P2R7WhR60vQd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA2MiBTYWx0ZWRfXyOMwsSWgSYfv
 8IPjWxUk7QUuhYFc7mrwdB5G58lIDHYPSvITQAScw7Etal5pHLNPO9rZz8cA6d1JxVcEKq7GQDV
 iYuD3zakRKi8so2ZjtEIywOnic/obKY6a7UvKhgmBAEhAQxX9YnWJB96GLQRSfBx4U1ykBBHD8J
 lVcZBh54TfXI1/jFnSnpkS/hR+WROGnmhRlDws9BwO3Pu6fozvzYGNfuf5HZfLydnguEfGe//1f
 1e15IV8KaOvvqE1hBAtGnN1LbUGLODD4hEhzNbyDi8uFTBzAYSKfzGNDhiqtmNUoZvfEBeNhIGZ
 bS1YHseUQUE0kCRtanQOKyqMIt/lubziusQd7zrcGkBvy0T6L7uRbKTGp7eQclRbKr7gvTL8nvN
 xsJkda5g7DxDPff+xtSKnBY8jtWYn5rVoB0T2CHnj8kmkuabhOa3GFuZhS/2nbDsIF08G06e
X-Proofpoint-GUID: yMkB90i4qHljQ9JVrmF3P2R7WhR60vQd
X-Authority-Analysis: v=2.4 cv=HYkUTjE8 c=1 sm=1 tr=0 ts=6874de9a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=CBJoKf8DjQ7nWtifRjsA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 mlxscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140062

On 7/12/25 1:42 AM, Krishna Chaitanya Chundru wrote:
> The current implementation requires iATU for every configuration
> space access which increases latency & cpu utilization.
> 
> Designware databook 5.20a, section 3.10.10.3 says about CFG Shift Feature,
> which shifts/maps the BDF (bits [31:16] of the third header DWORD, which
> would be matched against the Base and Limit addresses) of the incoming
> CfgRd0/CfgWr0 down to bits[27:12]of the translated address.
> 
> Configuring iATU in config shift feature enables ECAM feature to access the
> config space, which avoids iATU configuration for every config access.
> 
> Add "ctrl2" into struct dw_pcie_ob_atu_cfg  to enable config shift feature.
> 
> As DBI comes under config space, this avoids remapping of DBI space
> separately. Instead, it uses the mapped config space address returned from
> ECAM initialization. Change the order of dw_pcie_get_resources() execution
> to achieve this.
> 
> Enable the ECAM feature if the config space size is equal to size required
> to represent number of buses in the bus range property.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

[...]

> @@ -430,6 +433,8 @@ struct dw_pcie_rp {
>  	struct resource		*msg_res;
>  	bool			use_linkup_irq;
>  	struct pci_eq_presets	presets;
> +	bool			ecam_mode;

nit: 'ecam_enabled' or something? I don't think it's necessarily a "mode"
of operation

Konrad

