Return-Path: <linux-pci+bounces-33845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D009B22159
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 10:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5740D6E5E00
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 08:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CA52E7BBE;
	Tue, 12 Aug 2025 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P67iR1s4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F042F2E7BA5
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 08:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987440; cv=none; b=sf/bwJPtP8+7vsdqzlvnMnQhRJc0aFB3ilK3cJYaUWqctJeCrdenXdDxXJNNwxUup9mfdYIelHTkHr7/rqKC/Y8fkVDG1M4PDKPrlExU0znyWNkW+i85bJz6+NenX70BZ3vEnbhkJHbpGccKURqMYN+WKi1RHb/F7L1ZZrerO7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987440; c=relaxed/simple;
	bh=+sqrTc4xMmhxjfKGvwuLK8LNM1W7Vv0U5uedgRM+Aw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SxhrUhYiK33ikQXW/HZymdb0nMqa4KuKRkEtcvw3O98OmEyHfTiYkRVuOksET3LmAT8BhOHYPGPlR3LGcPmUp93qLsFoyya25SEzA5ZyuUSusIX+JpDT7rHOdjia9mbgiBXwVMs3wSEfO5AP4eBCeydEu9Ywqkm3o+9AdEBSb8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P67iR1s4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5ZfHF029197
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 08:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bi6m/pVb5jflsCkOfw1Mj9CvEgFoiG4pcGOpd9jiz1k=; b=P67iR1s47kYscGhe
	O9zPHi++k/NQUNH/o8RP2qBWJl9GSR6q1v1G21ewDaLPyGKKk0vLc5U0FDxKhwxZ
	e4QAa5XCyi7DBa4/cH25AAb0dNlcCsnKEsnbA5rxnyac8oShFH8wbnewkEZbP8kQ
	I80qC2cQqXRs2rIkm5Fl5vefmxlEiirQsirwsEGuYav6dkI0FQWQCHAknt5PibzS
	ch0QSs3SWR+NbcerQaMiG5SoIm1kMGLH7vXnqf7ybwUQsCEqP0Js1fvFnxjBryuj
	op21jpbUj/ADyEJf7dkoPjSvrimuYIqfLNmlcr1EAzFbyxI1X7G5Zj+7OYPiR4pb
	wuU6cA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygmfc18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 08:30:37 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76bb73b63d2so5459383b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 01:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987436; x=1755592236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bi6m/pVb5jflsCkOfw1Mj9CvEgFoiG4pcGOpd9jiz1k=;
        b=CqYMrbnkgTdKJFbLF+RRl7NazfUrPwLZZodRUBGVIrr+HkQOMKAmCu5uUbIYQWF7MA
         AGbTIB4IFV2e3iumvYkcXYoYm2Ymu7jEfgZnCpnevh/NknrhPrUSxczhZj0YV0gxtDXB
         KxJZxYbCXSoLPinbuiGWHKzjaQXvJPmUZsUktHus0PMs6yqi49Xui7TrN3+quooBKTm4
         eqsMpg62+97AWfKkT8jUb0zeKqlBChSNWYXudMkvpdUWV5pssCNs8X0y2LjyuiDxemlF
         lunc26qZ8pLFrpokdMFRVZAiuuWyY3z/Zeoy69akEueBaDruBQdLZA00IpjKRBcza3IV
         LFrA==
X-Forwarded-Encrypted: i=1; AJvYcCUB1MoHKglTQkQAH3NXx51OhWoeFOQL4K43nJ05ww624SA6EFT40xsAJq+v6Q0GwLRLgs13iMhCzCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ+0TOohM4e1qq4FPaD5Q4H/djGqmlVo19rkA4ivXMR9+o7u4y
	JZthukObnAf/lvU9HXKh67Y1w+vgHww9xuvVv3fLAeWCRpGpXLeh9e6iDFwWRss64umSUeEGewV
	QqhAABlfm4W75Bu/s4aeUfEHciXyopifbrK2IxZPalmyk7OV7VrDl1160ZltrDb8=
X-Gm-Gg: ASbGncukqRyhig4d24HS9DSkKPcfnPvMp0b8JkOsxE8RzX/0t0MKK97S/DYIIlCpHoS
	CsmFvz3P/wVquHjetwIClOz3nWs6HxaQ5aYgKjvUGmFuk1sd/GwtgMa8gc5TIJSAwhsW25odajk
	s3EUdX/CCenbFPHaQD/hwG/W0oHMFcV2JcQoahxmRdlSM2dvBNw40u15C0YvuvccgzRUSmZC2P3
	KYVYnVmSoC7iXpaA/x+Pr7aRGSIcuwwPCTvArIfytIWwHo0VDc/l071qstvUIQqssRj1rNjMVqk
	T/P04FRLukK6D3GUBiUUlGN5j9JR53cJRIisakuWKtD19+5FkKSzH4Ssv7GDUzqnPh4M564lHcb
	nSt979qZnLdmGCD6fwvuP3HA0l4G/
X-Received: by 2002:a05:6a00:c8d:b0:76b:d869:43fd with SMTP id d2e1a72fcca58-76e0df7bc58mr3529248b3a.18.1754987436120;
        Tue, 12 Aug 2025 01:30:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+FIkellPFGyuQhUX8ul7c/6NxlAJA9FFPnlvIXzr7SdxxThQEuj1bkyz/Lwsz4ovg36Gb4w==
X-Received: by 2002:a05:6a00:c8d:b0:76b:d869:43fd with SMTP id d2e1a72fcca58-76e0df7bc58mr3529190b3a.18.1754987435567;
        Tue, 12 Aug 2025 01:30:35 -0700 (PDT)
Received: from [10.133.33.66] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8a838sm28946654b3a.32.2025.08.12.01.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 01:30:35 -0700 (PDT)
Message-ID: <dc3dda22-34d3-4254-ba60-9037f3ccb368@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 16:30:26 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/5] pci: qcom: Add QCS8300 PCIe support
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
References: <20250811071131.982983-1-ziyue.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
In-Reply-To: <20250811071131.982983-1-ziyue.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfX8+Kj/dCRIDH6
 A13k+JStPq3jupGSU5JeOiGVt4R6gjIeEUZxy9w/06ZaPgeo9GvXajy1OpUCVwkoxtKhsKkPIa4
 CBMbU7DWFXbT2fRsApnFXAIhoteYhXRgl6szVlPB6fBDtISyiDCfS6QcffY7QuCQJvWmD9Se7f+
 fyc6h4VYncs0itrd77+oqEZkxPC30tlo1p+nmAmEMUz/fmZ5PAueLB1ly8CHUXe5aXM7ZyLW80/
 CHMsuFh1MUTbSRcVdEWz2EaEL5Cqm2IgyjZBqUMVySpTm7q7vhscxoTOxQBBA3/o8/t0fiPRYV3
 /ULlCcvAAWI10EzD1RUexC4vTuWgpKJBQ0jBHbKuksWn0y2WHoL8QmoxmcLBkfw30GLm/PK+tzD
 FSZ86vzW
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=689afbad cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=QyXUC8HyAAAA:8 a=TeDmwtwga0I2cO4QvJcA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: aIegHRQOx0GNVQEeHbN9lhhMrVN4iMN5
X-Proofpoint-ORIG-GUID: aIegHRQOx0GNVQEeHbN9lhhMrVN4iMN5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035


On 8/11/2025 3:11 PM, Ziyue Zhang wrote:
> This series depend on the sa8775p gcc_aux_clock and link_down reset change
> https://lore.kernel.org/all/20250725102231.3608298-2-ziyue.zhang@oss.qualcomm.com/
>
> This series adds document, phy, configs support for PCIe in QCS8300.
> It also adds 'link_down' reset for sa8775p.
>
> Have follwing changes:
> 	- Add dedicated schema for the PCIe controllers found on QCS8300.
> 	- Add compatible for qcs8300 platform.
> 	- Add configurations in devicetree for PCIe0, including registers, clocks, interrupts and phy setting sequence.
> 	- Add configurations in devicetree for PCIe1, including registers, clocks, interrupts and phy setting sequence.
>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
> Changes in v10:
> - Update PHY max_items (Johan)
> - Link to v9: https://lore.kernel.org/all/20250725104037.4054070-1-ziyue.zhang@oss.qualcomm.com/
>
> Changes in v9:
> - Fix DTB error (Vinod)
> - Link to v8: https://lore.kernel.org/all/20250714081529.3847385-1-ziyue.zhang@oss.qualcomm.com/
>
> Changes in v8:
> - rebase sc8280xp-qmp-pcie-phy change to solve conflicts.
> - Add Fixes tag to phy change (Johan)
> - Link to v7: https://lore.kernel.org/all/20250625092539.762075-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v7:
> - rebase qcs8300-ride.dtsi change to solve conflicts.
> - Link to v6: https://lore.kernel.org/all/20250529035635.4162149-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v6:
> - move the qcs8300 and sa8775p phy compatibility entry into the list of PHYs that require six clocks
> - Update QCS8300 and sa8775p phy dt, remove aux clock.
> - Fixed compile error found by kernel test robot
> - Link to v5: https://lore.kernel.org/all/20250507031019.4080541-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v5:
> - Add QCOM PCIe controller version in commit msg (Mani)
> - Modify platform dts change subject (Dmitry)
> - Fixed compile error found by kernel test robot
> - Link to v4: https://lore.kernel.org/linux-phy/20241220055239.2744024-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v4:
> - Add received tag
> - Fixed compile error found by kernel test robot
> - Link to v3: https://lore.kernel.org/lkml/202412211301.bQO6vXpo-lkp@intel.com/T/#mdd63e5be39acbf879218aef91c87b12d4540e0f7
>
> Changes in v3:
> - Add received tag(Rob & Dmitry)
> - Update pcie_phy in gcc node to soc dtsi(Dmitry & Konrad)
> - remove pcieprot0 node(Konrad & Mani)
> - Fix format comments(Konrad)
> - Update base-commit to tag: next-20241213(Bjorn)
> - Corrected of_device_id.data from 1.9.0 to 1.34.0.
> - Link to v2: https://lore.kernel.org/all/20241128081056.1361739-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v2:
> - Fix some format comments and match the style in x1e80100(Konrad)
> - Add global interrupt for PCIe0 and PCIe1(Konrad)
> - split the soc dtsi and the platform dts into two changes(Konrad)
> - Link to v1: https://lore.kernel.org/all/20241114095409.2682558-1-quic_ziyuzhan@quicinc.com/
>
> Ziyue Zhang (5):
>    dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
>      for qcs8300
>    arm64: dts: qcom: qcs8300: enable pcie0
>    arm64: dts: qcom: qcs8300-ride: enable pcie0 interface
>    arm64: dts: qcom: qcs8300: enable pcie1
>    arm64: dts: qcom: qcs8300-ride: enable pcie1 interface
>
>   .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |  17 +-
>   arch/arm64/boot/dts/qcom/qcs8300-ride.dts     |  80 +++++
>   arch/arm64/boot/dts/qcom/qcs8300.dtsi         | 296 +++++++++++++++++-
>   3 files changed, 376 insertions(+), 17 deletions(-)
>
>
> base-commit: e2622a23e8405644c7188af39d4c1bd2b405bb27
Hi Maintainers,

It seems the patches get reviewed tag for a long time, can you give this

series further comment or help me to merge them ?
Thanks very much.

BRs
Ziyue

