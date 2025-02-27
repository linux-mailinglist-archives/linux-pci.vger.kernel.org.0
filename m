Return-Path: <linux-pci+bounces-22513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B0FA473FB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 05:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3BF17A2CBB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB711C84AD;
	Thu, 27 Feb 2025 04:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AR5b7VId"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB671922D4
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 04:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740629512; cv=none; b=lEFe6SZQBmK8dKhb2GY1cAjE1xg4i+wOswbfOvPhXHrPN6SBBeQvrnNqcwLNOCtTPzg9HRAfo2xokIUPPH9T/VWtIvvrH17HjRHgn0I6qUEDGT0BtUqwPthP0cxNnGKzkMNns1AOQVZaNzDjkzaPm8Q/GNZbVbGWLvW7qk3iFaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740629512; c=relaxed/simple;
	bh=5vRVGr82CGiZh2Cbzj7pVxhSTU8sAZM5XF2eIwvjp+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WyXt2u4sUDGyEgeS3GVHmWAxOzvIj6euTY2FnASgKeeLO86z2iy9sSa3xDtOZVpA+MKoVrpFdBEXXp2s1PtXmLiHDne6xWN6ZhXZjwkKGP7xYTWYU+UrNeUw7skX4Mu866qId97P5z3caynKQeaheXcGbDaRuXQjohtMg6OJg9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AR5b7VId; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QJTPiV000821
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 04:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FSAQvsYR3iMFmPabg5DWf8ziRODUsEKRzX7L+bsEUbE=; b=AR5b7VIdGtyIxdIO
	XDWqh9b7PfITf0ErrUajHIGBZdCP8V2Bbqolk9ju1NQwt7g4ZTzmqnbsuAXl7Bbs
	v8Ozs3ZToV2PMga0T3uFFJsr+uDDzEty6BG1Hzn34uS0zui/Ag2uLlvOxAxmBFzt
	BOdrvPeSW0ypR1FW5Wr9nNWq4VNe0IE0t52zPZRnjmWe+RQZok2nKwTq+Z/LEsSr
	JEWNroukeRz2iL6CycYLUJ9omVapte/XPS8c8OMcMg+m4YV9hxq1gdnwpsHlffnc
	hKbGNF7kr8KD0DZVe8bPD3DcbwGC8TJ+azLWLF93f/Nfw7eMcbU+UmgXRLCKzyEF
	BVvOMg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451pu9c7w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 04:11:49 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fe8fa38f6eso1202033a91.2
        for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2025 20:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740629509; x=1741234309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSAQvsYR3iMFmPabg5DWf8ziRODUsEKRzX7L+bsEUbE=;
        b=mlqsJ9LQ9Xz7SdwUE3SnbKd9Wydqx5OFj4AHUcoc/9ryNw+a/IlVX/pvO8wuJ8V7iP
         rQFCAJQhGsZfbymj/ru4Ij3bGnwL+lzWb302hP8KVPgnaNk3yFABJE5uheIJ4WBWA27u
         cdI+2MJIRPxoNmeOjVDQxlzj//Ed+CuxxrUnwsxOnBZ1LE9ivzr5AkUG7mM49tGtVAsD
         MEe//zq/5lesTcwwv03QJFmI/ujiPn3y/Jc+Fcu1GKsqOtRcBYOj6zXgzO8G7VhJHo5w
         MKMVsBIyW2T43QGSHSF47xg77pswGndCNOQyKTteaFfZ050p9NYPhZeZjjH1p/ApUbmI
         7k/A==
X-Forwarded-Encrypted: i=1; AJvYcCUQBljkZkzP1NqWzYFKquklBTeyXUJCoNMRviTZ5RYf2qxX46SwPo8FeztWTZhxCncp/ZTDTJhWtzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOUil/8B2rNppXQkV/5PYhavVeQNsRUArdX2PAxc6iDQUmwNu9
	kX+rnzjDFQgdZHKkz8JvWVQL7xvh4nu81Kt/8Ztl4W1PE+BP5Q/uh02nJNb2hWnjdOWS5ZRfjI+
	bmhFYlKei0WiJebuWowufsVZ/C5EnYPdGApUUFiiMht4/YoHSrQ4L700Wks4=
X-Gm-Gg: ASbGncvN1jvYX9P3Ec5qTYrfAAwFdPNKJ4QUtRjBIMPcZryfnK3FBarkknIfE78AWL0
	8NmoaBtyTaBiL5svwh2LjK41GRWvdcgp8yWo513MzqqrC93cacLwGQPXf8UVFCbI7McVtNGhOaI
	TCVitc+1SRYKs3o7jaBO0dXs1XxBZdnxLqloC59Ly0w8wnIfey1kT1Vdj8GT21lYYVmZmpo287x
	iGFAA6+LAoLKbZCF20pj24c3BXmUQIWnWxHy8V5//qPDMfM5lNjEhPeJckj9YjR24WXf8Y55AyL
	T43VLSi4Ji8pkNgAd/iTLNgcp3hN9wkgzBKGoXYZ4FnE
X-Received: by 2002:a05:6a21:32a8:b0:1ee:c598:7a90 with SMTP id adf61e73a8af0-1f0fc99bf90mr16869078637.39.1740629508934;
        Wed, 26 Feb 2025 20:11:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRIX3IkvZiOUdHKEbb1/zqOV6uSSXIJDZqwMP6rxtAvZaceoDHFXvQadYXggDDykHwRSrVbA==
X-Received: by 2002:a05:6a21:32a8:b0:1ee:c598:7a90 with SMTP id adf61e73a8af0-1f0fc99bf90mr16869027637.39.1740629508534;
        Wed, 26 Feb 2025 20:11:48 -0800 (PST)
Received: from [10.92.199.34] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003eb65sm458168b3a.149.2025.02.26.20.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 20:11:48 -0800 (PST)
Message-ID: <0dffeb3b-63b3-266e-d1e9-b8adda7cc0ec@oss.qualcomm.com>
Date: Thu, 27 Feb 2025 09:41:41 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 00/10] PCI: Enable Power and configure the TC956x PCIe
 switch
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, dmitry.baryshkov@linaro.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jorge.ramirez@oss.qualcomm.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250227035737.q7qlexdcieubbphx@thinkpad>
 <20250227035924.p43tpbtjmqszdww6@thinkpad>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250227035924.p43tpbtjmqszdww6@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4v3YGAvzt8jZp2CN27oA-ZAbQ7Q_5L7Y
X-Proofpoint-ORIG-GUID: 4v3YGAvzt8jZp2CN27oA-ZAbQ7Q_5L7Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=836 malwarescore=0 suspectscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270029



On 2/27/2025 9:29 AM, Manivannan Sadhasivam wrote:
> On Thu, Feb 27, 2025 at 09:27:47AM +0530, Manivannan Sadhasivam wrote:
>> On Tue, Feb 25, 2025 at 03:03:57PM +0530, Krishna Chaitanya Chundru wrote:
>>> TC956x is the PCIe switch which has one upstream and three downstream
>>> ports. To one of the downstream ports ethernet MAC is connected as endpoint
>>> device. Other two downstream ports are supposed to connect to external
>>> device. One Host can connect to TC956x by upstream port.
>>>
>>> TC956x switch power is controlled by the GPIO's. After powering on
>>> the switch will immediately participate in the link training. if the
>>> host is also ready by that time PCIe link will established.
>>>
>>> The TC956x needs to configured certain parameters like de-emphasis,
>>> disable unused port etc before link is established.
>>>
>>> As the controller starts link training before the probe of pwrctl driver,
>>> the PCIe link may come up as soon as we power on the switch. Due to this
>>> configuring the switch itself through i2c will not have any effect as
>>> this configuration needs to done before link training. To avoid this
>>> introduce two functions in pci_ops to start_link() & stop_link() which
>>> will disable the link training if the PCIe link is not up yet.
>>>
>>> Enable global IRQ for PCIe controller so that recan can happen when
>>> link was up through global IRQ.
>>>   
>>
>> Move these patches to a separate series.
>>
> 
> Or you can just drop them. I have a series that adds global IRQ to most of the
> SoCs and sc7280 is one of them.
> 
> - Mani
fine for me, I will drop.

- Krishna Chaitanya.
> 

