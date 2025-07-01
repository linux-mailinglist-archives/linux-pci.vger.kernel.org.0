Return-Path: <linux-pci+bounces-31140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA537AEEF7F
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 09:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07981BC31E0
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 07:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04B125C807;
	Tue,  1 Jul 2025 07:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WD2BpIAA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A011EC01D
	for <linux-pci@vger.kernel.org>; Tue,  1 Jul 2025 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751353873; cv=none; b=mtS/x8R/zL2gpIIoL/illU6vS8G1ryub+rCxzEj9h5RLzQCuCsxxrDeKR/CWDxOp0TDvuQTGvM0XXtQssshTE4L+42y2IV6jNecJBlKPKfH82LOsA+4z8uA5V7n+iKX/+FbiHozuPL2Af1yuDX+TJimlmlB35Myu7JAADDIA/NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751353873; c=relaxed/simple;
	bh=h5MWEqtHUKj2PF+IqplizVOIR/vVHfO8mEwzCVce22s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzsGb5EiwPOOnw9zI3emht6rQevI63cXhYkJDIgIeygrGNyGH7L3FxwcRWhoLK9QHOagIwisKxKnRZGObTiCzPX5xqlAYkyik2UAtUuJlpyvhA+IO9zHiEJegwoChp2tBKBB1Un31uSNlFSTRIBc6siIYWpPjyKdZyH0otGPWSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WD2BpIAA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5612woEu002176
	for <linux-pci@vger.kernel.org>; Tue, 1 Jul 2025 07:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LluoSfVDge3smiKNxCH02yv2
	NZgVKQU42eCr1T2l6ec=; b=WD2BpIAAcnu2V73mSqIsgARnO4H4lhPgo+lUBDxK
	u8dCJ4qUO8F81QE031ip6Mntgfmw/bS+LInklNCJjd/bS3t9SmXcgXqDPJkduPok
	MBxCEmzCmq9z4M1UXgtE6UnG/OFOMLYEwmKfL4gjGFBvzL6pj4xI1iSXzU768fRl
	1qiUBCtasHR+1sgU3QSqZtldhn1U47CpHPc9YX+wPO/Kk3tuI4OaNT9pE3WlP/dS
	FN/P5mXI+ew+/dmoMLW/zZ9Pm8gNCHXLR1Ec9kOq7zeccVkuqjBx70KTewkCw77V
	r6u/830cDodawzZJzqw6BVhwxrk3A1vU5tQxmFpK7kkOUQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j9pcqebw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 01 Jul 2025 07:11:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d15c975968so578093285a.2
        for <linux-pci@vger.kernel.org>; Tue, 01 Jul 2025 00:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751353870; x=1751958670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LluoSfVDge3smiKNxCH02yv2NZgVKQU42eCr1T2l6ec=;
        b=OoukIF4Y3PZ5g1yXbR8t/8cWoYR8vRm77CNngBZqyv3x+ft9rs/lBs+5jhrjRpcat8
         f2gFi4FPbB61LTgJrLFZEt3n6auHBRNYP8NEAiaICDS3jh8IfIFtlMXT6AREDeXkaD8N
         yn4dIqUzfhKFPQZUpUdbFBG3ZtreSvseMgAsYLpGKFzlns+YFROPB76ZE1WeX8sYfhws
         CLiX8/wF8ZOBIbVO/9apSe+LadliEhRPkiQf3wwfcRKU8vGH84aXvQEX9sAtDRcnTWAM
         H83rd6eaysD/qu8LVMUNAFUnannEF0AjM3jerhxFxEoHbJeu6TDb5gzqY2OBjFKne7Hl
         65hg==
X-Forwarded-Encrypted: i=1; AJvYcCVdDXksb3FFeEniXGx/PUy3yLJhkmkzMaBBCuNR/ywgTTx+xCju71HwXPEcCru6GPnnhCneuzVXRhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1g2V/eSeCrelWsmTVl/Q2clZSm53mbO1ZLaKU1nKz8cQNoxXE
	nFPaMCJHgfFT0AFO46/fnQInInHXBaA2rgPz1lSnDRHuaXG8rwmraSbcHNoKUWAF72Jkx6yqd9M
	HzqXK7nt0b3Yof1WAEE5ccWMhw+BPMfud0qdm4IoHS80cWWdF0W0PX+7AeSHzd2w=
X-Gm-Gg: ASbGnctinRD+SI6ZqQtq4jY+RLn7ARmETDDQGU0r4yWYwyphk70aRKr5m9XLIUKowwV
	QJrry2H3hvXzxTyN6I+6ztSxC9yLRmOLNc1rm1omz4oXPYz1CnO7c6RCbzpMj0w7F5l9UNCZQAS
	7Qwj/CzCjD9y4KWJtcA01g70Ceb+FE/BDdRr0QxgLBGj6x4tTOEby2vIO15fylSw+zQKbmYyRqO
	b1jJDci74tC74vPH9CzxwkwXQY9YsJGiLaF52rMiZnEdYjK7PHVOQbEyc8xtqfvFUVC5ZkHEVs3
	olNqpOJXEL6ayN48Vi0lQSTITFwcMt+PocYwsdtMwSdS/JAyD7HsN+SNCdqL8EJu/pOWDangx5P
	BxlGM7mMJFBve1XLzU7qZLga5pTxuif83S6A=
X-Received: by 2002:a05:620a:408e:b0:7d4:3c27:9ec9 with SMTP id af79cd13be357-7d443934b1cmr2312815885a.1.1751353869844;
        Tue, 01 Jul 2025 00:11:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw2dLM0BgM14ZMVCoDmuy6rRO1Nps/VxplRanP7r9TWEDykcnmdIRzDbOLZq8cLuRIqvmbhA==
X-Received: by 2002:a05:620a:408e:b0:7d4:3c27:9ec9 with SMTP id af79cd13be357-7d443934b1cmr2312811285a.1.1751353869367;
        Tue, 01 Jul 2025 00:11:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32cd2dea844sm15447781fa.17.2025.07.01.00.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 00:11:08 -0700 (PDT)
Date: Tue, 1 Jul 2025 10:11:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v5 0/9] PCI: Enable Power and configure the TC9563 PCIe
 switch
Message-ID: <ps5ck23ubpo2vdxzko6yixujlf7mqppdssqrc5bz3vbupmn6cu@yc2ld2tb3r2b>
References: <20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com>
X-Proofpoint-GUID: IDMW1vccaJfemVufpYmTFqf78oOACbZh
X-Proofpoint-ORIG-GUID: IDMW1vccaJfemVufpYmTFqf78oOACbZh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAzOSBTYWx0ZWRfX1fq4FqWynG/C
 5aYEgyfl/Xl39lZV6YgcobHISHYxMWU9JJoM0qAV/8Psgj9QB8P0rHRe43yYiv/+dQkJ11ghCz1
 mp9o/z4XwIb3/eRgtQd3U1wvCNl8utgYrU52QFXKhadYD/f4/3fJAfF8hYzCS8aRt6eOnd9e+xl
 sL8juC6aEaRi/wYGrJvhOdcXDhn43AEW2EaHdkLijUdRPrD3zvHkrzbHC/njZPEHcVAudwbsgVT
 Nxt2YQ8W4h3fzBivstUvpHjaKPcBi/rD5lQKgeBCIUiSIc8+VmuzVEERqnDXNgHC0NVLumO0EFU
 1NtmEa1FO9X1bwu1bgNAIhA4DuiIWjyMBR7Wyzr5U3t0exPy/ac0hjUHTzAjlC3giCyJ/H0qfQA
 YeAOapH4wBi48FK+bLWpyIcSPQoBYbFO/TKtdhzpGcy/2GSh9/it3776A4HJrq1pqHvxv+Ev
X-Authority-Analysis: v=2.4 cv=QMFoRhLL c=1 sm=1 tr=0 ts=68638a0f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bjzph2yk5JCsPWVWffQA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=937 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010039

On Sat, Apr 12, 2025 at 07:19:49AM +0530, Krishna Chaitanya Chundru wrote:
> TC9563 is the PCIe switch which has one upstream and three downstream
> ports. To one of the downstream ports ethernet MAC is connected as endpoint
> device. Other two downstream ports are supposed to connect to external
> device. One Host can connect to TC956x by upstream port.
> 
> TC9563 switch power is controlled by the GPIO's. After powering on
> the switch will immediately participate in the link training. if the
> host is also ready by that time PCIe link will established. 
> 
> The TC9563 needs to configured certain parameters like de-emphasis,
> disable unused port etc before link is established.
> 
> As the controller starts link training before the probe of pwrctl driver,
> the PCIe link may come up as soon as we power on the switch. Due to this
> configuring the switch itself through i2c will not have any effect as
> this configuration needs to done before link training. To avoid this
> introduce two functions in pci_ops to start_link() & stop_link() which
> will disable the link training if the PCIe link is not up yet.
> 
> This series depends on the https://lore.kernel.org/all/20250124101038.3871768-3-krishna.chundru@oss.qualcomm.com/
> 
> Note: The QPS615 PCIe switch is rebranded version of Toshiba switch TC9563 series.
> There is no difference between both the switches, both has two open downstream ports
> and one embedded downstream port to which Ethernet MAC is connected. As QPS615 is the
> rebranded version of Toshiba switch rename qps615 with tc956x so that this driver
> can be leveraged by all who are using Toshiba switch.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Krishna, the series no longer applies to linux-next. There were comments
which required another respin. When can we expect a next revision?

-- 
With best wishes
Dmitry

