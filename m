Return-Path: <linux-pci+bounces-33851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB66B22338
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 11:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D9862228D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 09:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94ED2E8E1F;
	Tue, 12 Aug 2025 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Llb51V61"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5852E8E1A
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990844; cv=none; b=najY1D8Ulp8BCPi8TXnZBFqPyoAUqkUAGrS/JBxsWkK5W/wFa06aHfcYv5qnzqJy3MI809nJvZck2bFmVRvK65sEec/rr0h8JT8k00sdlNguEdRZP8e7HERPWNET97IBsbWfCrJ6sSC6wUU/RcFAUi3/qBJnfrF3AzBJgJuHGoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990844; c=relaxed/simple;
	bh=c9w5DaCwevdS8Zl6bzjQ1GF90LNgwle0F+O5Q9ZhWPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IduM6/OA1+O0mrZ6zVjDyUzF7sqFSaQCV+t2yPILOalZHIal3z0TP5iXWBSa0aRrBWedzuX6u+Rd4pCQo103Uwxe3K950RuT486GJiL7EkXoUKPTp0dqNIJOU2ytkZj7Ry9xakAntg5/yQvmu2/ib0KVIKyZ5sBbC4Pk1XqrOKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Llb51V61; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C4Ze2Q013076
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 09:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x1XZQXAHzUdSPrv2me7BRJkLC13h5rEiUYCH9W9cUAY=; b=Llb51V61WCalqt3U
	csS5zlgRdsQaP9rirsXjehj9wFrRWoIpzwoN3a/ZvbQW6GSOFCKjVihIPpyiLtvi
	6ZvbckxLxMKjQliSiJ5d3aWZd/ToSK0xFP7AHWe2q5D5k5ltLLIEOyPyMIXtEcY8
	fF8Tkw12wXduLk07blc+IsIOn7Yf8XNNYMmPkxfVbBN8fIR4FH++rtxie/14+M8q
	cM2J/wm2q+gUKlWjcss4eTuc6D7iq9ukljkMQeLGpkLYLAj9jl176Z+z48HFvego
	XiIVlxp/hdhgqgcOoR0AzSl6mbmx5ixHr1ImmmGtd7N6Zt4OWa5CcbrCFZwE+wEY
	Ldg+Bw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dupmqqnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 09:27:21 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-707778f7829so8949636d6.0
        for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 02:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990841; x=1755595641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1XZQXAHzUdSPrv2me7BRJkLC13h5rEiUYCH9W9cUAY=;
        b=ggu8iJnRHJloLaN0Vb6Wf0rYiCV99+LIei+jFGmMFuwL1JvjTqi/JpydOsuqg6nCOZ
         1gQD+XhlQfvJkS4rz1Ybv2GXKvD6Hu+7f/OJMZJVgF5Dhi5OIjoySI55C6l3wce6NxS8
         kZdf0XoyaGCWoqtsByXgYiinz3StX+lrJ7Ty6OxrRAkbhIazKY5mqZ2uwkAm/q+BJHOJ
         GjYP/Nddq76tIWfioU/SxrpH86K5cM99bP2EV5VaWXIg4O88r56l+EwZLYsubXbC70+g
         yDyicon72UQIsM2hpP4w/VRwi/YyUD7uuJw81Hcq+oVVbIXgRNTvAgpSDVIa8/ZITq0Z
         TA1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZiC93w7ITpP40S2S31RgygdY8FGv7cp284unqkVsjzQz8AOZBUw+zgzZXLYb9PZVV84REF7jPI+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0aZTD1+gRa6y8Z1VehmSPT90WdgPcKjszxsPknkRmdgKrbmqs
	NAahbGmlbINsmXAvHhMTb9bMdQIBgnldwNDM7wUA7F/G599+uz0MKvz+gkIdFaSqP8Wr6tt3unS
	sqp5pBNYtfEnXsoa0cLPZdI6O0cVbmaJ3/xnaX6NDXAzjlZjUk65U1Y/rPVQs65M=
X-Gm-Gg: ASbGnctlqVuDt2oGEp9wnXLKEEXSriyToxTc26uD0HD4AKT7prosWycfGXS79PtZRgD
	tv0599mCPhp8N+HaQCaEmUMXHCgSB/pMKumZ7bW5tW3iHNBq/kS/TApo7aM6SI+JLJDYShQydYd
	6SJRgnHDl1X8UJ8n0HQ8XK5DMIB/vhaqgKEEURcslqDfuzNybY324rKg2CtAFUYlL6qv2hxHTSw
	lOqZS3JnQi6gxMa+mFX1eHYCwgmQvpFhV54iMvT7zBnbdGbOalPdGrA6h1ER3Ft7JyXv6h/L5ZC
	IweogMFOxKzm2TFP7taL8wYUw7tpRDL0tsOr4nAbJoiJZGJfZPrfp+Ru/G9GQaZbz+lDWAyfo4y
	g2cW+4L0XKZmsDbv+6Q==
X-Received: by 2002:ad4:5c6d:0:b0:707:4daf:62f with SMTP id 6a1803df08f44-709e250c0f5mr1924836d6.7.1754990840777;
        Tue, 12 Aug 2025 02:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJKGm+UhBSlPdpnKeF86J93B+AqDA/p+7hYFKAOley2I+WUeLVMJXey9VyfTdFfRU+b7jZRA==
X-Received: by 2002:ad4:5c6d:0:b0:707:4daf:62f with SMTP id 6a1803df08f44-709e250c0f5mr1924686d6.7.1754990840317;
        Tue, 12 Aug 2025 02:27:20 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2c265sm19700788a12.26.2025.08.12.02.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 02:27:19 -0700 (PDT)
Message-ID: <3939605c-7335-4401-ba32-b88ee900f1d5@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 11:27:16 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] PCI/bwctrl: Add support to scale bandwidth
 before & after link re-training
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250711213602.GA2307197@bhelgaas>
 <55fc3ae6-ba04-4739-9b89-0356c3e0930c@oss.qualcomm.com>
 <d4078b6c-1921-4195-9022-755845cdb432@oss.qualcomm.com>
 <68a78904-e2c7-4d4d-853d-d9cd6413760e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <68a78904-e2c7-4d4d-853d-d9cd6413760e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bY5rUPPB c=1 sm=1 tr=0 ts=689b08f9 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=PSSt48hOBszhu4C4aVgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: CDGhCknh943AzFGiohtE7UuejZwTY20r
X-Proofpoint-ORIG-GUID: CDGhCknh943AzFGiohtE7UuejZwTY20r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMCBTYWx0ZWRfXwvgjlXtNpYKF
 FqBWQ4sdCE1BvdSFp9uZURx7XrXjlBJjIP2BV5fwiGa6b9GCMeNeRrV/k/8/FWHp+6aI7OcVLUb
 X86r9hR1HtSz+n22IE61RVGu2h9Vv2ZsdP1RNRfouJD3xoTphve6JuexGvACMvfhlBpJQSq7uls
 +z2mrpm9YQLva25vhBP+HCy3OHL1KRnd1RN8fDPHWrm0ZM1Ov4xlg/F6T0b2GVLxZdavU75sF7H
 Am+M2HPuXQISysimeMKh3Hhd9mkndkcXqemSJNFQhls+TyOv2N4TcFTvf5JjpbuP+mPlnozOzCW
 6X57i0a5a0xb1iCRBKmu65QD9CR1KJlvYyDScBFQs2PF+H/J3D0wwQ+RnK3ETKEaH83B2mZEKQ1
 aAE3zFY1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090000

On 8/12/25 6:05 AM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 7/22/2025 4:33 PM, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 7/12/2025 4:36 AM, Krishna Chaitanya Chundru wrote:
>>>
>>>
>>> On 7/12/2025 3:06 AM, Bjorn Helgaas wrote:
>>>> On Mon, Jun 09, 2025 at 04:21:23PM +0530, Krishna Chaitanya Chundru wrote:
>>>>> If the driver wants to move to higher data rate/speed than the current data
>>>>> rate then the controller driver may need to change certain votes so that
>>>>> link may come up at requested data rate/speed like QCOM PCIe controllers
>>>>> need to change their RPMh (Resource Power Manager-hardened) state. Once
>>>>> link retraining is done controller drivers needs to adjust their votes
>>>>> based on the final data rate.
>>>>>
>>>>> Some controllers also may need to update their bandwidth voting like
>>>>> ICC BW votings etc.
>>>>>
>>>>> So, add pre_link_speed_change() & post_link_speed_change() op to call
>>>>> before & after the link re-train. There is no explicit locking mechanisms
>>>>> as these are called by a single client Endpoint driver.
>>>>>
>>>>> In case of PCIe switch, if there is a request to change target speed for a
>>>>> downstream port then no need to call these function ops as these are
>>>>> outside the scope of the controller drivers.
>>>>
>>>>> +++ b/include/linux/pci.h
>>>>> @@ -599,6 +599,24 @@ struct pci_host_bridge {
>>>>>       void (*release_fn)(struct pci_host_bridge *);
>>>>>       int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
>>>>>       void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
>>>>> +    /*
>>>>> +     * Callback to the host bridge drivers to update ICC BW votes, clock
>>>>> +     * frequencies etc.. for the link re-train to come up in targeted speed.
>>>>> +     * These are intended to be called by devices directly attached to the
>>>>> +     * Root Port. These are called by a single client Endpoint driver, so
>>>>> +     * there is no need for explicit locking mechanisms.
>>>>> +     */
>>>>> +    int (*pre_link_speed_change)(struct pci_host_bridge *bridge,
>>>>> +                     struct pci_dev *dev, int speed);
>>>>> +    /*
>>>>> +     * Callback to the host bridge drivers to adjust ICC BW votes, clock
>>>>> +     * frequencies etc.. to the updated speed after link re-train. These
>>>>> +     * are intended to be called by devices directly attached to the
>>>>> +     * Root Port. These are called by a single client Endpoint driver,
>>>>> +     * so there is no need for explicit locking mechanisms.
>>>>
>>>> No need to repeat the entire comment.  s/.././
>>>>
>>>> These pointers feel awfully specific for being in struct
>>>> pci_host_bridge, since we only need them for a questionable QCOM
>>>> controller.  I think this needs to be pushed down into qcom somehow as
>>>> some kind of quirk.
>>>>
>>> Currently these are needed by QCOM controllers, but it may also needed
>>> by other controllers may also need these for updating ICC votes, any
>>> system level votes, clock frequencies etc.
>>> QCOM controllers is also doing one extra step in these functions to
>>> disable and enable ASPM only as it cannot link speed change support
>>> with ASPM enabled.
>>>
>> Bjorn, can you check this.
>>
>> For QCOM devices we need to update the RPMh vote i.e a power source
>> votes for the link to come up in required speed. and also we need
>> to update interconnect votes also. This will be applicable for
>> other vendors also.
>>
>> If this is not correct place I can add them in the pci_ops.
> Bjorn,
> 
> Can you please comment on this.
> 
> Is this fine to move these to the pci_ops of the bridge.
> Again these are not specific to QCOM, any controller driver which
> needs to change their clock rates, ICC bw votes etc needs to have
> these.

Do you even need to set the OPP explicitly? The global irq handler
already does so on linkup, and you seem to toggle the link state in
the newly introduced helpers

Now not all DTs currently have a global interrupt, but that's a mass
fixup to be done anyway..

Konrad

