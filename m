Return-Path: <linux-pci+bounces-31328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A5DAF6911
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 06:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD5A4E746E
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 04:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1BA28D844;
	Thu,  3 Jul 2025 04:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ODOEFZtG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8422F64A98
	for <linux-pci@vger.kernel.org>; Thu,  3 Jul 2025 04:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751516308; cv=none; b=gx+ZLdC4C/b9RHlTepWDU1TUeE8BSgKoBm4sIq0MmSYoI/J42SpXJKhw54c4666vuykEYkDFN2i8VLqI/YZx/k+Sr2CiwN9E9kowChZiViUIUDdb/sy2LgB6LYUMe09OgEs5SkF8JlHzxvL7MtklbmxjrnKMn6scfr792hx3TL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751516308; c=relaxed/simple;
	bh=yYuF9F6UXPe1+nRemOM3FS1DclLed2FkVUesNJnZsl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=paijBh2Gtxygc+6X9VrvohHhFi71Z0ZGzETmyOHaiGdvyxap6jZx8AiNYAEO5CV51D5BpVK4lGHJdzgCr7gzV8SqOSVm7casUHvOO8mAs28jmwqJnYlelVRHdu50inpZhhvAphxyxXuRI3HWpkMPhpvnAXalgYQCZ11sgiT2qDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ODOEFZtG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562N5Kwc032421
	for <linux-pci@vger.kernel.org>; Thu, 3 Jul 2025 04:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1NaW9HsleXJDnHysTKiBKa5wP27JduvuH7fRxzKY+H4=; b=ODOEFZtG4zyejscx
	uKOWP/fCjR/RvatpjE9PJ8m9hu75uZzUGzlmjrt7I+9ONy0ISBcnGDl6sktSwpRK
	fgpznk2h74l38h8CZ40GXIGP8FAHa/fRMyMyD8GXrfbUeilT3urXKEAhFM61Qns0
	GGHnJcpCjNjKTid91ThxBJo45j8KKLFGjlak0QF3MDsrprC+pPsR6qApWbSnwc0A
	u8UXqLfV8ST6tzvy5udKXHnqkzBAr7azkYm2RjOPyIicfUlOpoCKsGRhVpHVxRsl
	5/9HtbZo1IHMtsG45DUYRTZDvqeQmKHLFAnGHiE+YI7s6RpnoFYvTZv7JVlqrKfT
	TcOzhA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j63kf87y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 03 Jul 2025 04:18:25 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-236725af87fso98062225ad.3
        for <linux-pci@vger.kernel.org>; Wed, 02 Jul 2025 21:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751516305; x=1752121105;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1NaW9HsleXJDnHysTKiBKa5wP27JduvuH7fRxzKY+H4=;
        b=d/Wl7HDgo+bPRzM04u4dzIIfGbcnVnNBLu9YtACzTQccCW747e8/xAtxmqLw7G6cjZ
         ZaUWNyxVVSN9dyxDzIyyZqRHKH8ur9cqsx8RqVLYDaH/7jLFX2veIN6RX0hy92NzzTZx
         +/jOrT9flbzYT0pDsLUkyWWoMDhGQRzgW1MpnVl9zfEEk5AOfSXNOlkmu5AaNHogJb4p
         uaNF9I2UwD6c+B9obT8SNsFuV2zblx1wAegMOa3taF/rfoQsEjdGAFNx3a6y1cZZR1za
         ESIMWqhcATDx2soJN7EWeRWwLq7PipEefGddCdwe5Bq9GwiHBw29mXkUJNTNHPlr8eCM
         ocYw==
X-Forwarded-Encrypted: i=1; AJvYcCUi4JbvgPAIV27H+DZoQbNCdwYb7alEcN09572kXlfJgNf4aMQBl4xfArXmIOhPpcUDar5GXDNfKNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMIgltzfO3pbV+d6S4uimS9DxysqVTdGfYOdNiEN+IbSAxtyUb
	nveSB5r8BLF/+gensnW4wE9azjmJItRorYlQCTjcWYOt8vmI+VL99QoTT+657LH0s7KbgYVIewh
	2ATLsPBx6CUgb7YzNrcRU77tdx+sjJYtqQ+pc3eRrROjvgVPrLA7JRTYessnT+YM=
X-Gm-Gg: ASbGncu3NHVzrYxIsbNuxxr+2k/EMqtdITe/IjaCIzZWnJKSxQRrbD2Mv2Ra4NzX0TO
	UKhH93LXpFEojMInBfvYYfj4cTPO1VR7M6Wg6c0CSzrL0ngoXVDxzE0R4f/A16tY2nEEBLmRlUt
	PxEoYLJjv26iqd9LdC7P7IgFVTiKOvv9/JlHw2lLXjS8RPHPguPUeTJHJKpd+YmTUteq7cOoEgR
	CiXYEhiLCGeTO/F4ophBI9l/XcaoOofNgUHKYThSziMoC2tygRBd0Xfzyx7BgLAJCih0JboyQSW
	dCKhApWeuR3StcbJuWy+izPmeKPmDfUyiVTzUyIuBAXFMDaQBCeQ
X-Received: by 2002:a17:902:ea0d:b0:23c:6cc2:feb9 with SMTP id d9443c01a7336-23c6e5d52ffmr79875425ad.45.1751516304619;
        Wed, 02 Jul 2025 21:18:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiJQOQ3rj9Z3Ib0vpUq3Vmcwr9EZOVs8di8axva0PyX0K2M8GE7BrJgKKE40SijB5rZCol7A==
X-Received: by 2002:a17:902:ea0d:b0:23c:6cc2:feb9 with SMTP id d9443c01a7336-23c6e5d52ffmr79875065ad.45.1751516304213;
        Wed, 02 Jul 2025 21:18:24 -0700 (PDT)
Received: from [10.218.37.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e3b40sm148262145ad.26.2025.07.02.21.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 21:18:23 -0700 (PDT)
Message-ID: <cbf32980-8608-42ba-99c7-deed56afae32@oss.qualcomm.com>
Date: Thu, 3 Jul 2025 09:48:17 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] PCI: qcom: Add support for multi-root port
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com
References: <20250702-perst-v5-0-920b3d1f6ee1@qti.qualcomm.com>
 <20250702-perst-v5-2-920b3d1f6ee1@qti.qualcomm.com>
 <ws2kdznvbrvuvb6k4jov5cd4qzvadeaffjqgeso7u72stormlg@2ffiexejkrk6>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <ws2kdznvbrvuvb6k4jov5cd4qzvadeaffjqgeso7u72stormlg@2ffiexejkrk6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZKfXmW7b c=1 sm=1 tr=0 ts=68660491 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=elFezDTcsRQGgYhLSLwA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDAzMSBTYWx0ZWRfX53KqRTc/xLmQ
 e21fOVm2bcXQkWnV6eho/zV+xmYSP8GjAfUqXy8NlnlQpfYK0AWFwPRL9QqZeM2fmK5OhSaVr/C
 zPr8qCO0+X8Ksj078s3FS3pvKkZ0dfg0SD5lb/H0EZ9ZRj7xLy7Y8AriOk4Puzd68JM4py3DZsq
 UghSbr+F07Ju5kizfAB7KGQMdkQIVibuImqsjVdMVMqEnQKaBc91uFox8B0t7LvZC/xIIkzwLtg
 yfVwrFfchgK3TMdbSvyPEgzDpIiNo6hckyjejbcoMPLH9itlXdWUNnoxSgnDZzgosX1S5wOvcT4
 By+06cfQ3YUtQGsQ4sAq8nz0FlEVxk0autym4QCY4cg3zsO3LWb00ilbqeVS2TKe/QV8XztObui
 D0RVYAWtMvBYkVHZCZ19ZzYl2YWp2SUTIiUGMefMGVB0GxX2959gCdwjVXrm1nzWRWlqtvKq
X-Proofpoint-ORIG-GUID: rOmRSbkc3OhbSsBBF8ht6bLb_FbBOK6i
X-Proofpoint-GUID: rOmRSbkc3OhbSsBBF8ht6bLb_FbBOK6i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_01,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507030031



On 7/2/2025 9:03 PM, Manivannan Sadhasivam wrote:
> On Wed, Jul 02, 2025 at 04:50:42PM GMT, Krishna Chaitanya Chundru wrote:
> 
> [...]
> 
>> -	ret = phy_init(pcie->phy);
>> -	if (ret)
>> -		goto err_pm_runtime_put;
>> +	for_each_available_child_of_node(dev->of_node, of_port) {
>> +		ret = qcom_pcie_parse_port(pcie, of_port);
>> +		of_node_put(of_port);
>> +		if (ret) {
>> +			if (ret != -ENOENT) {
>> +				dev_err_probe(pci->dev, ret,
>> +					      "Failed to parse port nodes %d\n",
>> +					      ret);
>> +				goto err_port_del;
>> +			}
>> +			break;
>> +		}
>> +	}
>> +
>> +	/*
>> +	 * In the case of properties not populated in root port, fallback to the
>> +	 * legacy method of parsing the host bridge node. This is to maintain DT
>> +	 * backwards compatibility.
>> +	 */
>> +	if (ret) {
>> +		pcie->phy = devm_phy_optional_get(dev, "pciephy");
>> +		if (IS_ERR(pcie->phy)) {
>> +			ret = PTR_ERR(pcie->phy);
>> +			goto err_pm_runtime_put;
> 
> Shouldn't this and below be err_port_del?
> 
This is a legacy way of parsing property, if the execution
comes here means the port parsing has failed and ports are not created.
so err_port_del will not have any effect.

- Krishna Chaitanya.
> - Mani
> 

