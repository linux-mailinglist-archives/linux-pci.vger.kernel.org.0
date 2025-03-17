Return-Path: <linux-pci+bounces-23908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D808EA646AD
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 10:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28BAD169468
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 09:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A722C221F18;
	Mon, 17 Mar 2025 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RX6VarsU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E8C18C03D
	for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202592; cv=none; b=o6LdapWX9pfp9+z+Jd7VX7LM4lhjSWKsAXUJ+6ZWSf/GUKTOZ7ZIs6keHvIYwdAgJcuo/scPsPKc2UTOrRiRuaQLoT4Da0dEyrwHEcTZ+oUpgEfMe0rLuwt9b1hJ0VuY/osL7HYt6pMT0aSZ6bdXGdn/alwzWObwSYZRqQ1Z3iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202592; c=relaxed/simple;
	bh=/6+sTkr6a3ceKu/fxq9OWBAkUr2gpzahEt538B5Vjlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4HI3+0ISQQjGwuQEryH1EPULodoMCXrjcvrqMDAjR/lYbk9CO5AkmM3BdQXAPQEADMJoopYl7XawwgTAdSjr98Q/ble/20S/xS2iaGfxew9NZfGDmD1wfZZKlgSsTrloVQxQ2sMDoxFsWJ0zzW21Tb6bhSR/YFU3WvPb6/OSpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RX6VarsU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52GMMqj8006164
	for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 09:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ahQItqeoUmWIKu5Zx43vnqgKrtzrhBRX2qch9IykP+M=; b=RX6VarsUXJVJCoJM
	QA8l/3hkOpysMUyo19acn8fHjbnucwFU9HghBirLGNs1UjHKG83DcWn9oLbbhiwc
	Us7olQDYJGKFnoaydGAGIZjO1FzbPCdK1Sa9poZn3YRlgMCqFVIfWZIVWTQ7Nodb
	cUluH6cauFZpEBZ9XNj97rmUy7kYZsImy5jSmfiO+/OsaD6Yj4X8zF46HxLx9lQ6
	TY3YwgAy1Nt1l7gjvHWan7bPFkWeAO+GBI7669M3o834GP0IKK/2jKBfmBgZUDPf
	Z3x78yiD9mBrjZm+0mhStittj3aJPxGWy9iSfW0A5agHqWqPkmSXnEWo3uAlun53
	R8MXFQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1r142my-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 09:09:49 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2242f3fd213so63164485ad.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 02:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742202588; x=1742807388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahQItqeoUmWIKu5Zx43vnqgKrtzrhBRX2qch9IykP+M=;
        b=N+BjDcZqONOAY+9wc1TQVS2RJ3YTQkKcIu6UhBfhCiIaWYj1/cZ4sEn4Zv8CIswMo2
         DjyjHGdBiGfjmROvbQQT+Xw/l9rs5aV93Yy6a/K3tEcjBr6qG4ArK3DVwkB6Z9CfbbfP
         1AvmtC+UChMbsJLQb/5RN2Ix2jeDTmwsQr7ocO0cC+zfpaGNtkovR50p5tRjqFQgwGru
         hp1ucTMtf0TUyaDdb+Uo8t0jJS+vt7QpLJYVeoN1sNiLw0TWN4nZqeGFNJn44fZWKPqI
         uE7cFTRO1U5ITgIjUCfLSiL7IjTBoUKO0+bi8pAevvVYww8yp0zDRBj9/zJIrUddx1sv
         erEg==
X-Forwarded-Encrypted: i=1; AJvYcCXLzLYHbtG5W+BZIMZmeFTjKa3dHtVLlkOPgSf7vPHMQYLtTKcAcPY2KYP+vhMFm0jobDbnmoZmn2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4MHdVEdCskW+xErZ/2N80OFKM61sy3p03lcwePK1hlhl4fkaF
	/oCoaAMIK3em5zit4qMsKgavCAnArjUWMdLN47Ktg0gn+M9uFXFbVjKwNJ9SlxqaSVEuf8vH8u3
	9egi95LR1B6F6Lxr/cY2Wu7+oIDloxYAIzGnEc2APPmSGxkmkpLr9LiutT9Q=
X-Gm-Gg: ASbGnct3f//gbjuV/KwxzQYfJijdkRaxqofUMNPjHaI+YsG7G0a5M3Eb9dEKaP0QS6m
	z+9TL20o10krRdRaXVWb8UxNvlucyLN0dNLl7wmRKvrbYMDcrvQZiPKWLlPE/uFZPnFyxU9Mko5
	uxABjffsbQod9gkevUiIARkRqGhbpZtLAs5swipyuGh7TgODkiaAJmm7iTGgh8IkAChl1KYg6HW
	GQAMclIn7DbweNanTUSzOn/2jnViI7Plbosdd/Rn+lUhHwq21oS/bxDaqQhMt5V9ZZpe6mHxJKA
	khNt7B+klCUp+hvsMHP4AkuVq7HW2M00qSAubRxH0iDWXw==
X-Received: by 2002:a17:902:e545:b0:224:2384:5b40 with SMTP id d9443c01a7336-225e0aa0c3fmr153573775ad.24.1742202588280;
        Mon, 17 Mar 2025 02:09:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF60BAHI99rtN5h8BxymtxkXdeGrP8liOg0J2LI+ZV9QRYEQpFc2bN8hoL4jPWB33wsovgGXg==
X-Received: by 2002:a17:902:e545:b0:224:2384:5b40 with SMTP id d9443c01a7336-225e0aa0c3fmr153573275ad.24.1742202587815;
        Mon, 17 Mar 2025 02:09:47 -0700 (PDT)
Received: from [10.92.192.202] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd5ae4sm70180935ad.229.2025.03.17.02.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 02:09:47 -0700 (PDT)
Message-ID: <75bd4685-a6ea-4852-f41f-fd4437383774@oss.qualcomm.com>
Date: Mon, 17 Mar 2025 14:39:41 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 01/10] dt-bindings: PCI: Add binding for Toshiba TC956x
 PCIe switch
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84s?=
 =?UTF-8?Q?ki?= <kw@linux.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, quic_vbadigan@quicnic.com,
        jorge.ramirez@oss.qualcomm.com, cros-qcom-dts-watchers@chromium.org,
        linux-pci@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, amitk@kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, dmitry.baryshkov@linaro.org
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-1-e08633a7bdf8@oss.qualcomm.com>
 <174048982895.1892984.13694169241426640158.robh@kernel.org>
 <f718ae90-237c-634a-111d-05f2f0240db9@oss.qualcomm.com>
 <20250313055657.ddrzqo2edx46az7b@thinkpad>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250313055657.ddrzqo2edx46az7b@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LuaSymdc c=1 sm=1 tr=0 ts=67d7e6dd cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=gEfo2CItAAAA:8 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=zHEVz4YWXsmZ1JJS7FsA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: aCV1JfPMAliGKkarIGgUqAWaCVeg7Kv2
X-Proofpoint-ORIG-GUID: aCV1JfPMAliGKkarIGgUqAWaCVeg7Kv2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_03,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 mlxlogscore=960
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170067



On 3/13/2025 11:26 AM, Manivannan Sadhasivam wrote:
> On Fri, Feb 28, 2025 at 04:26:23AM +0530, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 2/25/2025 6:53 PM, Rob Herring (Arm) wrote:
>>>
>>> On Tue, 25 Feb 2025 15:03:58 +0530, Krishna Chaitanya Chundru wrote:
>>>> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>>
>>>> Add a device tree binding for the Toshiba TC956x PCIe switch, which
>>>> provides an Ethernet MAC integrated to the 3rd downstream port and two
>>>> downstream PCIe ports.
>>>>
>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>>>> ---
>>>>    .../devicetree/bindings/pci/toshiba,tc956x.yaml    | 178 +++++++++++++++++++++
>>>>    1 file changed, 178 insertions(+)
>>>>
>>>
>>> My bot found errors running 'make dt_binding_check' on your patch:
>>>
>>> yamllint warnings/errors:
>>>
>>> dtschema/dtc warnings/errors:
>>> Warning: Duplicate compatible "pciclass,0604" found in schemas matching "$id":
>>> 	http://devicetree.org/schemas/pci/toshiba,tc956x.yaml#
>>> 	http://devicetree.org/schemas/pci/pci-pci-bridge.yaml#
>> Hi Rob,
>>
>> As we want to refernce pci-pci-bridge.yaml which is expecting compatible
>> as "pciclass,0604", we modified the compatible as "pci1179,0623",
>> "pciclass,0604". Now adding pciclass0604 is giving this warning. can you
>> suggest correct way to represent this.
>>
> 
> I think the PCI-PCI bridge compatible should be part of the actual bridge nodes
> inside the switch. I still stand by my view that the bridge compatible doesn't
> make sense for the top level switch node as this switch is a sort of MFD.
> 
> So you should do:
> 
> 	pcie@0,0 {
> 		compatible = "pci1179,0623";
> 		reg = <0x10000 0x0 0x0 0x0 0x0>;
> 		...
> 
> 		pcie@1,0 {
> 			compatible = "pciclass,0604";
> 			reg = <0x20800 0x0 0x0 0x0 0x0>;
> 			...
> 		};
> 	};
> 
Thanks mani for the inputs on this.
For child nodes I will make pci-pci-bridge as a reference and for the
main node( pcie@0,0) I will pci-bus-common.yaml as reference.

- Krishna Chaitanya.
> 
> - Mani
> 

