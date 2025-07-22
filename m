Return-Path: <linux-pci+bounces-32716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DEDB0D7A7
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 13:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92BE06C7F54
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 11:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66E42DEA87;
	Tue, 22 Jul 2025 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gTRM5A+Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AB2242D89
	for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2025 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182241; cv=none; b=JJ2pWsyUV3M/WLUidrIXd7uDoZVE+quabYk6j0PHGLYn0S8Zls4r5kxQYGm95s2tD/JWERnyxOKAg4hj6Fd9ypP001D6qBKeREFNDi8I56gk3Ck9/1UxfJ9qms6CPqqE6eUZslIvJUVopSahsYC/+Er7hp4R/k3hkeKn/Pn7xc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182241; c=relaxed/simple;
	bh=kWCUG31bkJ6dZkQu4ecUTQJmDb9akcJNyNVIFUvX4So=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bK0J6osCHzV5bgJqQRY0rH7xKD9+98ezjisldnqfCkhgbOxooV1zAZ5VALywx1q/3wkY/t7GoMTCzMq5lgNw0yQap66lHHHbvCNJd0HoE1L1EF2IZJ/9Rv7cu2GAM9gruqccK1eY3O6AdYMg9Qk73dczWtRRf3p4Hk2soaiU3rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gTRM5A+Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M78AA3009627
	for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2025 11:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jCcIy69ciDOUcVdtD2bZCMzRk/SyBUFRLG70HN1E2+Q=; b=gTRM5A+ZXBV1LYZH
	oVBmEosxHP33U+7/2sCjFSscWe4nGK/f+gXjn5xNeKKUV1yqF6yNb7EFMn0i8LRR
	16mhIwk9iplEJHanlgtA783cn44423NPSDypNTK0L/GbZUsgmTL96QEYBUm2ko7+
	CCrwFohoQJjQPt91kyCR0aCn/iyGBgFhB9XNH2kIRlEqGPsCnkJC7LxqSY4jPrOK
	iKo5zANUOwW6Vw3jcKypisxjmS7VHgiZciDZS5sxKjBkPOG7Frg4d/zFg28Spfp2
	khieEqYk/0ri3+2XImGWUKMe1zVosO5/wq3L5wzBpx7TPhMmX8RXHM7QrMGYc6kr
	cbL36g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045vyh7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2025 11:03:59 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-75494e5417bso5051858b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2025 04:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753182238; x=1753787038;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCcIy69ciDOUcVdtD2bZCMzRk/SyBUFRLG70HN1E2+Q=;
        b=vf10HPNabZkHQuG/JnR6uZPJ3BrLpYzj1b9MgKfw9STVvJ/hbONU3BqQnU2pnz+in+
         pedG+5prfGn7DVKc1wEESsIZeDtyf6rW2f1G1bnzT9LqMaojkYFyPjJSYtNEZN6FJTJ0
         dvGzeqVGCOMuKTtUEDXZ5RK5qPSrK++uB1xnLXz4ofPIsAIkI1EuX3LJpA4KKNsqnZ8Z
         JoIZK8LfIQ6xM+d2+Zz2cvuWyBB+ByxEnVcwdrE57qIWnIJBDeF51v/czrpMv0KWr0CJ
         PFF6WL3L0tGgFA78+g/8GrTBqF/lEFyJVVbSGLVgl2pJCaRPlfSGy+ugyz14gqWJ+61Z
         Ybmg==
X-Forwarded-Encrypted: i=1; AJvYcCVjzxeBdCh6/ODGwxGY1Hn2sNIAPMz16UIL7As5B7edFa+jPc3jZqtQiivJOlneOYCYevwoF8Qi60k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsarCL5+ZUhfffCwHt9VsEJkkXjWKIFPTu3m0GCTdj6SxJkQ6F
	Dd1HTp9O/Rxee310yQ8ceaEpGNF7vKytPvMjWXhpPt5tFvcOkStBgEcvLlfpJFtzzxN0cbgDpwZ
	r2sJPcNo898z1dYkxN3BAh0fltb4rgco+K7WDx6/b2m4eIWIb7xLTE22OQ2ENOr0=
X-Gm-Gg: ASbGncvisOAaQKehgxIETLb6wBY3dwuA2sz5e4Uf+1T9+tSDR70X7dAelUkfCyGd13I
	V/ssDk1IVULXX1vNcX71GAea1V4ttCCfB2mRwm7jgNUveneYBh/cbi9n9kcPXNsFIadGgRhaTzq
	pQcer/HED2OF4CsVOBz2zISsKjZbF4GDcwXaLxbHHIkZs8/geDsL9mpxpHwN6sGeH7qNEKyvYHc
	/ms1ZgFSeyvN2kvQoPE8LbJhmKhbRMQMvJD3YkVvgJHbjsx2hx4vABOgaa0CIurH+0e/b8skZxY
	qNy7p/6os0Flkeo2td+0XRVWMVGoLRVy5E0Hhl2B2eMuvpk+/wrEsJRzA1Y9lasP70QWlnXulg=
	=
X-Received: by 2002:a05:6a00:1817:b0:736:5969:2b6f with SMTP id d2e1a72fcca58-75ed156d03bmr3761921b3a.6.1753182238349;
        Tue, 22 Jul 2025 04:03:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgZIDkCUV2AXz/9PK4/a4NCij1DJxFB71Da611o7fAf8jI0CKXgwVrcrLnlMSH3ym9h+L+Lw==
X-Received: by 2002:a05:6a00:1817:b0:736:5969:2b6f with SMTP id d2e1a72fcca58-75ed156d03bmr3761869b3a.6.1753182237848;
        Tue, 22 Jul 2025 04:03:57 -0700 (PDT)
Received: from [10.218.37.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbd67ed2sm7293938b3a.135.2025.07.22.04.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 04:03:57 -0700 (PDT)
Message-ID: <d4078b6c-1921-4195-9022-755845cdb432@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 16:33:50 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] PCI/bwctrl: Add support to scale bandwidth
 before & after link re-training
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Content-Language: en-US
In-Reply-To: <55fc3ae6-ba04-4739-9b89-0356c3e0930c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LL1mQIW9 c=1 sm=1 tr=0 ts=687f701f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=UU_a8xXafIRJjp1WqNEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: cF0MUG4f4A95y3heBA5ayRBe3oxBlkFB
X-Proofpoint-ORIG-GUID: cF0MUG4f4A95y3heBA5ayRBe3oxBlkFB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5MCBTYWx0ZWRfXwtXlhfogaMZw
 f7YoSNRK38NUbEUtLry14O9etyOHhjQJ6cfiF/mz4IxzHh4Q9D3xTNequYpB2E63Sk0FdD9/fHI
 dTch/OI935mGDZX5R8SLpKS6CSwfVD2VYUN+TH6f9dlXoMo5IjBftlDKbDpjhbBkgedMWQvONH4
 LywXwsFeOdvoaGA6MXIo6mBowAbklT0MlAypDLwRhRsYmFNkkEWmXEHwSxwiViSBd1PERadk19r
 t2bOG2UjqPQQI4DGF4WkeJgNkdz1r2cKPQNk3/w8ZPb0XopCfkK/vMnKvRwtu1S9jOIv40z9gtH
 3wkVuZhsSTGY7gRXQGLSCSnZUffGDsD4Lu9I6BAxj608IIa4PquibuLFctTuO4a6ZKEn1Twzp8T
 TDmzFxDY7uE0CuVOOx3s9+tmqEVd9Lh16YLamXemJedSNqgCwcK6S+LrN0BeRejxkPvsdl2b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220090



On 7/12/2025 4:36 AM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 7/12/2025 3:06 AM, Bjorn Helgaas wrote:
>> On Mon, Jun 09, 2025 at 04:21:23PM +0530, Krishna Chaitanya Chundru 
>> wrote:
>>> If the driver wants to move to higher data rate/speed than the 
>>> current data
>>> rate then the controller driver may need to change certain votes so that
>>> link may come up at requested data rate/speed like QCOM PCIe controllers
>>> need to change their RPMh (Resource Power Manager-hardened) state. Once
>>> link retraining is done controller drivers needs to adjust their votes
>>> based on the final data rate.
>>>
>>> Some controllers also may need to update their bandwidth voting like
>>> ICC BW votings etc.
>>>
>>> So, add pre_link_speed_change() & post_link_speed_change() op to call
>>> before & after the link re-train. There is no explicit locking 
>>> mechanisms
>>> as these are called by a single client Endpoint driver.
>>>
>>> In case of PCIe switch, if there is a request to change target speed 
>>> for a
>>> downstream port then no need to call these function ops as these are
>>> outside the scope of the controller drivers.
>>
>>> +++ b/include/linux/pci.h
>>> @@ -599,6 +599,24 @@ struct pci_host_bridge {
>>>       void (*release_fn)(struct pci_host_bridge *);
>>>       int (*enable_device)(struct pci_host_bridge *bridge, struct 
>>> pci_dev *dev);
>>>       void (*disable_device)(struct pci_host_bridge *bridge, struct 
>>> pci_dev *dev);
>>> +    /*
>>> +     * Callback to the host bridge drivers to update ICC BW votes, 
>>> clock
>>> +     * frequencies etc.. for the link re-train to come up in 
>>> targeted speed.
>>> +     * These are intended to be called by devices directly attached 
>>> to the
>>> +     * Root Port. These are called by a single client Endpoint 
>>> driver, so
>>> +     * there is no need for explicit locking mechanisms.
>>> +     */
>>> +    int (*pre_link_speed_change)(struct pci_host_bridge *bridge,
>>> +                     struct pci_dev *dev, int speed);
>>> +    /*
>>> +     * Callback to the host bridge drivers to adjust ICC BW votes, 
>>> clock
>>> +     * frequencies etc.. to the updated speed after link re-train. 
>>> These
>>> +     * are intended to be called by devices directly attached to the
>>> +     * Root Port. These are called by a single client Endpoint driver,
>>> +     * so there is no need for explicit locking mechanisms.
>>
>> No need to repeat the entire comment.  s/.././
>>
>> These pointers feel awfully specific for being in struct
>> pci_host_bridge, since we only need them for a questionable QCOM
>> controller.  I think this needs to be pushed down into qcom somehow as
>> some kind of quirk.
>>
> Currently these are needed by QCOM controllers, but it may also needed
> by other controllers may also need these for updating ICC votes, any
> system level votes, clock frequencies etc.
> QCOM controllers is also doing one extra step in these functions to
> disable and enable ASPM only as it cannot link speed change support
> with ASPM enabled.
> 
Bjorn, can you check this.

For QCOM devices we need to update the RPMh vote i.e a power source
votes for the link to come up in required speed. and also we need
to update interconnect votes also. This will be applicable for
other vendors also.

If this is not correct place I can add them in the pci_ops.
- Krishna Chaitanya.
> - Krishna Chaitanya.
>>> +     */
>>> +    void (*post_link_speed_change)(struct pci_host_bridge *bridge,
>>> +                       struct pci_dev *dev, int speed);

