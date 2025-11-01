Return-Path: <linux-pci+bounces-39987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2085AC276D5
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 04:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122C31A25542
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 03:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E9D25A64C;
	Sat,  1 Nov 2025 03:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="boKYvFta";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C9J11lE0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737AB25C6F9
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2025 03:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761968297; cv=none; b=EiNtBLgKohjMwSSBTJwF7wY5fh8Q5iSRNSc9PTsf4eCBsO8dngCIay3+mMxLmZF3t7Ue2MwuDodw45HMVYh85ElAIsWD0TTL288sewZlvdZoC10XPnOqi9JtDPunad3c6T12T325ceYpHcv4PtYUmIddj/WnoPQTVgbtyca8kVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761968297; c=relaxed/simple;
	bh=QOV4s441pUMcnd5W23H/g9SGPLto9keaiax99h+lJMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q2T3Xctkk0aaWSTsD45vRL7Uug+PRvQ8oa2zJzlHRvurfAEZTCq3GlMlJdwBormLaMOd80JxC3tXNIvJJDw+CUQ9dK3jyZMReKpwjzVNH/8mwYFuZgQk/mK/NGEFpD17oN19K+1239UwnyyjRkwBQOfGSi5IH/9l4flNdwG9xSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=boKYvFta; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C9J11lE0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VHGkUG898461
	for <linux-pci@vger.kernel.org>; Sat, 1 Nov 2025 03:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j+MSSJNAnzhdO1DSldaGMP+f7736jkHHfxLd+CmKemI=; b=boKYvFta7QfNPlSX
	a8XeodXvIm/ciqgQ6avwi0jcO6Y12EQAPWIG105GUhI6dXv5tlXeWeOopsmVYb36
	aUcdL49VKGbMMCD3YuiYixcNws712f0CNJpB8fz44w2khLY0XzUakC5RbeU0FUQW
	6jPI9PCRzZQ05q4JtOD7RMxUBJ2W2EaH8Y+APaEWUcpL1sxQFU+csg5rGjS4Bg86
	rP3g/5d9X88J+v56NtOhWx0JyJA8Wyj48Avw2Yodxkjcz9AaT9FWqczj/NtO8tWX
	LFqAf2UOl7Ad8AsYpLNy/A7FDJt0pOvg+L5lKNk7bu437bH1wig3PoJPH8DKkVSi
	s69Wuw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4gb2408r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 01 Nov 2025 03:38:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2952cb6f51bso28344515ad.2
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 20:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761968294; x=1762573094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j+MSSJNAnzhdO1DSldaGMP+f7736jkHHfxLd+CmKemI=;
        b=C9J11lE0jNeHoxoHsbyzm7xrJOqBJqIewKy9y/VpkeF6BR+9xpPLD/YfXeifnURADH
         b7j9cICvXLH71w077xHn+wEMBBJ1XgzGdg6gWrIUlZs+ydAyL++Fm8DwJSZvzF/CZPJl
         umcbOtvLKYefBqBQKOaKFhUwGGCbMg25zmbCPDEKTk2Qrr6ab9GFSF1GF19qsLXc1c1m
         Do4+UrP3xMorA101P2GDWc0fMZ43BlKlnMdquohv21typ9GO+mVxnwnB0gm4qwsUvDLI
         EW+g91xwroj8Zp7IUoK5gFZ9bCF2vD9uvC887ZwZ4kARoXd9oHbFM1GMyN0akYaS6MRi
         BR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761968294; x=1762573094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+MSSJNAnzhdO1DSldaGMP+f7736jkHHfxLd+CmKemI=;
        b=WE158v/Cr4Ar9bjdxBilLUO6Mib+9ymHp9DCUhMGr8mHIF5n03B6RGAWphq+SdWyNY
         4FkVj3Fw6jUgyjJEx6nyhTcidPUPNmgYvdoIjmzFtKQib4h2MF015LRkZE0+4vmmZndd
         c4k+DF+7GxWKqpUB5Oc/tcd00KtuKHOtkm55nPyUTGYShWw3avded+J3pOIDebHIDFMn
         V+lB3ZwPv/W4htJI2cOHLJafmgcRDDA8ZLG1zKL22ZTRNTLYGU3x0BmQfGS4/1pyGFNH
         fD2tgV+LX15U9uWGvOBhcdzbKASrjT3QQFC85MLmYO6g/2YC1njwftqiMVe1oT1dghqw
         RuBA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ6KSKgmvy4s0/GnoyWQ7R80gSvCVQKMKGmrma0vsoeaqs5muFLs2FzV/Hah6UxONxzgvQdlkxJxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzukZTK4pIeh36XO9B7XpbtlDGMgHW7XkeP6kbrI6YxU6+UPLpZ
	kv/grQhG+wXCVPvgmI8gul2LcaReIy7fjKsbkfvO0+C4wNLKYq93+635712AvcXVVfWnbJTiIga
	vrBIsSp2qmi+z8oV3ixSZyvceiK9/L/nb26z+cvblsSZBx1dhCt6CsWRqwX8HunU=
X-Gm-Gg: ASbGnct3pJYCloXPDV23/2VOKI+6f4o72V5uZ4rStppMg06uOSzYTr28aNi77BYW0zf
	+Ir6FvQc234gvWVjHvRdYsmyJ6JlzYYpmqkimD//ft/jDuef45uRjS3QS3J37xUyp5W69H3r+zk
	4K6N0TzkS81qwoTQk7QYKiwRYT2S2uB2G9AWe5XCRUUCPdd0YPXj7pWf/xSaymq1jqnq7/SqlrC
	7oExyrR+XItll85yQnfoVXxvJycp8BFVxzqMZc0UCtTakQ2oZj0yUZGOfNTJkhovfAP60cVy6JV
	OOSKnR86zqadkwUkm6UAc4Dk6SlRQE3E4rpE5973pPXG+x9AvmETjuH/8LpNt6o35ztKm1+5PqF
	vBgAHaRkf2XpOPSmc9lZ8O4BzLBdY0IgFGQ==
X-Received: by 2002:a17:902:e803:b0:295:5da6:600c with SMTP id d9443c01a7336-2955da66315mr875365ad.2.1761968293828;
        Fri, 31 Oct 2025 20:38:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhZKxQBBnG78bpCeGKL4Lw7oZMFbVF3Qy60/ZWNH7pX/qvw+SoCu2WjYCu2EsGiLa3sETv3Q==
X-Received: by 2002:a17:902:e803:b0:295:5da6:600c with SMTP id d9443c01a7336-2955da66315mr874975ad.2.1761968293290;
        Fri, 31 Oct 2025 20:38:13 -0700 (PDT)
Received: from [192.168.29.63] ([49.43.227.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2955615d720sm8247975ad.65.2025.10.31.20.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 20:38:12 -0700 (PDT)
Message-ID: <bc7732aa-6958-4028-a3b3-a0c2ba3b0252@oss.qualcomm.com>
Date: Sat, 1 Nov 2025 09:08:05 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/7] dt-bindings: PCI: Add binding for Toshiba TC9563
 PCIe switch
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20251031221238.GA1711866@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20251031221238.GA1711866@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=efswvrEH c=1 sm=1 tr=0 ts=690580a6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ISmZZG41GQzdpg15mxjwIw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=BNVTMueYxggUNz7gLWUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyNyBTYWx0ZWRfXxgP5HWAMLaJC
 hwaCM8VCxep6iRZHraQxkmlT/pBB35//yA0nBiX/sOMA9S6XyZqqVSbBIqQl+wM0/tfIAD3M8z5
 /qQosgqskcec+MqW4S1PRAx3DmelKPgKEUbzG9vcI0Lh8yMtEdyPoA5lNDgJnp3GOiIyh6GYfk0
 Q8GmtolkJPiJgwOMeaZSBB7vwTsB7PD8MolctDA5LVZGVmH190YOS/ukBrSKJEGTwV5UE2TLkUy
 VetjB/jkkIIPuN3oMWqsfGvLwbI8fPaiOhlCzPs5V6zL9UE7XsWyhwufG4cw4mnlXiY9pke5m+A
 63LWN2eFIO9KvVom8g3pgKTPxCVfprijk7+OsPQUCsxOEZpvhvLU67xktkfcu0zZfU+9yovImpC
 9vqaqO10jhq94RDxWaIuU+vGCP8KTA==
X-Proofpoint-GUID: gczJQRdz9wPs3uxPmjwAVtveOOVc06lt
X-Proofpoint-ORIG-GUID: gczJQRdz9wPs3uxPmjwAVtveOOVc06lt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511010027


On 11/1/2025 3:42 AM, Bjorn Helgaas wrote:
> On Fri, Oct 31, 2025 at 05:00:13PM -0500, Bjorn Helgaas wrote:
>> On Fri, Oct 31, 2025 at 04:41:58PM +0530, Krishna Chaitanya Chundru wrote:
>>> Add a device tree binding for the Toshiba TC9563 PCIe switch, which
>>> provides an Ethernet MAC integrated to the 3rd downstream port and
>>> two downstream PCIe ports.
>>> +                pcie@1,0 {
>>> +                    compatible = "pciclass,0604";
>>> +                    reg = <0x20800 0x0 0x0 0x0 0x0>;
>>> +                    #address-cells = <3>;
>>> +                    #size-cells = <2>;
>>> +                    device_type = "pci";
>>> +                    ranges;
>>> +                    bus-range = <0x03 0xff>;
>>> +
>>> +                    toshiba,no-dfe-support;
>> IIUC, there are two downstream ports available for external devices,
>> and pcie@1,0 is one of them.
>>
>>    1) Putting "toshiba,no-dfe-support" in the pcie@1,0 stanza suggests
>>    that it only applies to that port.
>>
>>    But from tc9563_pwrctrl_disable_dfe() in "[PATCH v8 6/7] PCI:
>>    pwrctrl: Add power control driver for tc9563", it looks like it's
>>    applied to the upstream port and both downstream ports.  So I guess
>>    my question is putting "toshiba,no-dfe-support" in just one
>>    downstream port is the right place for it.
> Oh, I see, never mind.  You keep track of ->disable_dfe on a per-port
> basis, so each port has the *possibility* of using it, and you skip
> programming it if the port doesn't have it.
>
> I would assume the two downstream ports for external devices would be
> identical, so I do still wonder why you would specify this for only
> one of them.

Hi Bjorn,

As this is just an example, we just added here. In actually use case we 
are free
to add it for any port.

For remaining comments, you are right I didn't notice I am still using 
older one's
I will fix in next series.

- Krishna Chaitanya.

>>    2) I see a lookup of "qcom,no-dfe-support" in [PATCH v8 6/7] PCI:
>>    pwrctrl: Add power control driver for tc9563; is that supposed to
>>    match this "toshiba,no-dfe-support"?
>>
>>> +                };
>>> +
>>> +                pcie@2,0 {
>>> +                    compatible = "pciclass,0604";
>>> +                    reg = <0x21000 0x0 0x0 0x0 0x0>;
>>> +                    #address-cells = <3>;
>>> +                    #size-cells = <2>;
>>> +                    device_type = "pci";
>>> +                    ranges;
>>> +                    bus-range = <0x04 0xff>;
>>> +                };
>>> +
>>> +                pcie@3,0 {
>>> +                    compatible = "pciclass,0604";
>>> +                    reg = <0x21800 0x0 0x0 0x0 0x0>;
>>> +                    #address-cells = <3>;
>>> +                    #size-cells = <2>;
>>> +                    device_type = "pci";
>>> +                    ranges;
>>> +                    bus-range = <0x05 0xff>;
>>> +
>>> +                    toshiba,tx-amplitude-microvolt = <10>;
> Same question here about whether "toshiba,tx-amplitude-microvolt" is
> supposed to match the "qcom,tx-amplitude-microvolt" in the driver.
>
>>> +                    ethernet@0,0 {
>>> +                        reg = <0x50000 0x0 0x0 0x0 0x0>;
>>> +                    };
>>> +
>>> +                    ethernet@0,1 {
>>> +                        reg = <0x50100 0x0 0x0 0x0 0x0>;
>>> +                    };
>>> +                };
>>> +            };
>>> +        };
>>> +    };
>>>
>>> -- 
>>> 2.34.1
>>>

