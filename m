Return-Path: <linux-pci+bounces-40637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D60C42FB4
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 17:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFC864E04E9
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 16:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39701E8329;
	Sat,  8 Nov 2025 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T5wWA3En";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LaH+dIG7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4584A1482F2
	for <linux-pci@vger.kernel.org>; Sat,  8 Nov 2025 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762618690; cv=none; b=JbFRuNn4ewWUY1alcm6rAyUMGiw0aMbeJL7OGWdX1YvnOASFfnNYD4YAFH7Houh+ilL6JzqmL9d7GrCeosm8p8h9lScvuWm55WDdXeBSw4jmqQQUE3SSP5VqBbaK+0RaZN2fD+rR/bEEcM7z5zjpEB+iL2byJYtVOE6CILcpo4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762618690; c=relaxed/simple;
	bh=KfS1aINBmDG9n1Ht1jQ+g3Uz+CAnBWGpxp7yztMXbO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGp/juPwu4b49BnnugEFf+ihudHvMmwkj1Y9WAhZxvo8v5AsziT82EzO0UzNWVBPpCFhTNGbYUdr69DGHIurXPxjVYS5m7OJIomt2tJxxW0nliy5eF64oTKzekzPuhyW93/Gp27gIKgAPnohTl/GS0sFl5iBXY/jjdE2h+ianLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T5wWA3En; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LaH+dIG7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A88RDUZ1410794
	for <linux-pci@vger.kernel.org>; Sat, 8 Nov 2025 16:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Py00xPDir31YyU79HXmqWuCZ
	FlALcJqzV/HA9C6gi4Y=; b=T5wWA3EnSiakaRbwstD/6GyVkDWKYVM1kK0rYEau
	5nGVAKxhOl+0hlPG0l27oHKfz65EAURJfSGakBLXfRmSQEn4UACPJJ+5c+HJOVvD
	xc2JAWDsZD2D6Z5L/Uh09EZbeZIGEqYgpdA7Kbcys+0gr13EVGV1xajX4eIbMhPV
	tA4aFirUtLquOi6adh2k5xAlV/sr2eLX3Okwn0s81NU59LuM5Gd9HgmzWwcQaFSR
	LqEpX+BVQQShedvSDCrHnNSXcm0P9ZLwuXsimNPMbb3vawUNeZcdFpAwJLOfDbYE
	gGtef/gGD+L3GFpx5oonViZD+ATNw7HanXJ9fzFReHkJHA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xsg0tq5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 08 Nov 2025 16:18:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed782d4c7dso39174991cf.2
        for <linux-pci@vger.kernel.org>; Sat, 08 Nov 2025 08:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762618687; x=1763223487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Py00xPDir31YyU79HXmqWuCZFlALcJqzV/HA9C6gi4Y=;
        b=LaH+dIG7JmdBVkTpyUDLknoUm/h+H4RpYpT6+TMr9PThjdioPVshU42ocLV+6yuo66
         OTF5ZiWLSGuGMpgW7UBpSnJ/OnOKORMFGIlz7du3j8Hb6ABth617AF0WasQMhBxYDHO4
         Cl8WexuROfdgXMjr2n03AGe/bV16jFF2eYongAthNIa96XqDJeLYl/MiReSYwO+wvhNX
         CVZvugw1NLTNvAAYCLr0CQTjP0JERQLBAQPwezD6p3LlMwPx/jiHZ0zY3xpj1Y0XTN4K
         KKti/dTpTQrxnV2ZzeK6suJA8OfioT0oTd3CKTlJBCjX/BxnhZPUSY8vs9YrD1m0g/Wy
         9D/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762618687; x=1763223487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Py00xPDir31YyU79HXmqWuCZFlALcJqzV/HA9C6gi4Y=;
        b=S+bID3SlKeOLa5I4Yd7aDPLmP2QEDbyTzFaLlICHzRaAb/k2yZ5ZV+9iPvlPbpIIqY
         3E13BX8PMOdEn9Domic23fgxXf9xy21Gyw26wAwCtzWylFTF9NMTPdCkMfIvbf+LQSrf
         tT4zZKjKX5e5OBtDRSF63Kzwu7AZP1mNP/NNZjua4oFJlw9rdoJqLxqAddPDvCA3HlXN
         0/UCCB+a797k0c4//wdr/m9Z9JDciavc0p/vlruJEbSafjVnVlYtTMA+asTtlTAScBGs
         B07DO/7YtYrEsshLix00panml5NwZQuwifAIHkVmqgmL43Dy+S3mFnQ9R7CwHKfxi8aM
         /vOA==
X-Forwarded-Encrypted: i=1; AJvYcCXRTW0eFhBj8b8LrUQSxsbAzIYrPumGBevCi5hmW50TmZ0tKPTiUFoCwfsxoru5eUrFxihYsincQYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz44Ce13vyIgAQt/g1//DbLfiZ0WCDQzMmsYG6Zq/vhzBaFoMR+
	4OWCgjO7eIvRGyk6kR9O+go6Uu9frJjNKLHrGao03OmhmiYArUJIwI1XYta+Bx1w7hxG8VNImbv
	qq/xig70gkfVAIWQqPkV3U5W7YxHb8S3d92MufxrwAi/dKKDbc3SKs9nLt4tVnPU=
X-Gm-Gg: ASbGncuKbUw+TvvsR08m/r7fh3EK3JYh1jHbPgRq35mPWRo4yfnW0n4Jemwxc3olfVM
	IChBHuAQqm6Gt+KBrWec8Qn1gIwHOOVLM5dTexLcH4ww/sNfdurwqN2K9TokWjqj9jsT5ySO4Nk
	YGEMPru+/pBJalj/V0+thS/8Y1MrqGpsp44FSsdTeH6nRyFDVb+a5J3uXm3cNYD90WwozYCzCuy
	zIIhoU0IEpfo7vHyGS3wgLXQLhZyZZlK3AKwOhKKMu7Tgsh9V0Fuf8uQ0Wyazls1BSo08vn1LQ9
	2mQ56pd5IPK8mUbqHwYo2YO/XuKNTfWAnj65nVr1oh1tMzDRNJ4bD829b6sNy6YvffGVGHR2BmA
	SIurqCIaYKezS5QRSYsowRezBEmBZmtThtioquVt7QJ61US6hsuvia2xYi08pwHKmMzBfBpVsnV
	ikJ/QZ25Xvx/Hf
X-Received: by 2002:a05:622a:46:b0:4ed:4548:ac74 with SMTP id d75a77b69052e-4eda4fd2c4fmr37056351cf.40.1762618687393;
        Sat, 08 Nov 2025 08:18:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEtOM0UAMNLO8z3Kc+CTbZr6goeR/evQn274D8c+axM4oynKJuYSlJ6L7YV2IzKethULeCRw==
X-Received: by 2002:a05:622a:46:b0:4ed:4548:ac74 with SMTP id d75a77b69052e-4eda4fd2c4fmr37055831cf.40.1762618686873;
        Sat, 08 Nov 2025 08:18:06 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a0b75f2sm2270521e87.54.2025.11.08.08.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:18:05 -0800 (PST)
Date: Sat, 8 Nov 2025 18:18:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: manivannan.sadhasivam@oss.qualcomm.com,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Vignesh Raman <vignesh.raman@collabora.com>,
        Valentine Burley <valentine.burley@collabora.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "David E. Box" <david.e.box@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Chia-Lin Kao <acelan.kao@canonical.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 0/2] PCI/ASPM: Enable ASPM and Clock PM by default on
 devicetree platforms
Message-ID: <4cp5pzmlkkht2ni7us6p3edidnk25l45xrp6w3fxguqcvhq2id@wjqqrdpkypkf>
References: <20250922-pci-dt-aspm-v2-0-2a65cf84e326@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922-pci-dt-aspm-v2-0-2a65cf84e326@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=SLVPlevH c=1 sm=1 tr=0 ts=690f6d40 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=8Yqsnq2At7iDAUDahdkA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: y7y739S_G_A148RHInVinmjLsccfaZ3y
X-Proofpoint-ORIG-GUID: y7y739S_G_A148RHInVinmjLsccfaZ3y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDEzMSBTYWx0ZWRfX3zCJZeENUOQw
 UzTNUdP5vXAOv9kiJGl8assX7egC37FbsL8cR8VBaPfCg0P1nILBQnXxndWX5DXvN5K8ztNZq02
 2992c6BtEwPLu2+GThAO3XrZ+H+zLqEFXnM513DeSpq4nAePiPT3BzJKanjeAZcAaTQByJRyJCC
 QIPUJ2zp/hIxdDuh1nM4D6B7qErUVWxPUjndLRMKLOnZ2NlovoggnwKgbIs07vfJwHSj8fAOWIA
 Am944vTTu2Cv4UCZXWvp0POU+8+Ay/tz5fCetDFPXYrVb9GVpOyETkzabjpvab4VwIR1WeruRX/
 +FTwciokMGIjeVMa3v1mcpEoSyQesW1SkPMlIHUwaMQyOY7jjO1rEa5nG+w4FsO+Cj7dI3WA/Jq
 2CMCBLYYqSEqNeY7Oty6SK0t/YL7Ew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511080131

On Mon, Sep 22, 2025 at 09:46:43PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> This series is one of the 'let's bite the bullet' kind, where we have decided to
> enable all ASPM and Clock PM states by default on devicetree platforms [1]. The
> reason why devicetree platforms were chosen because, it will be of minimal
> impact compared to the ACPI platforms. So seemed ideal to test the waters.
> 
> This series is tested on Lenovo Thinkpad T14s based on Snapdragon X1 SoC. All
> supported ASPM states are getting enabled for both the NVMe and WLAN devices by
> default.
> 
> [1] https://lore.kernel.org/linux-pci/a47sg5ahflhvzyzqnfxvpk3dw4clkhqlhznjxzwqpf4nyjx5dk@bcghz5o6zolk
> [2] https://lore.kernel.org/linux-pci/20250828204345.GA958461@bhelgaas
> 
> Changes in v2:
> 
> - Used of_have_populated_dt() instead of CONFIG_OF to identify devicetree
>   platforms
> - Renamed the override helpers and changed the override print
> - Moved setting the default state back to the original place and only kept the
>   override in helpers

The series breaks the DRM CI on DB820C board (apq8096, PCIe network
card, NFS root). The board resets randomly after some time ([1]).

Note:

- Reverting just the second patch is not enough ([2])

- Reverting the second patch and picking up df5192d9bb0e ("PCI/ASPM:
  Enable only L0s and L1 for devicetree platforms") is also nout enough
  ([3])

- Only revert of both patches results in a working pipeline ([4])


[1] https://gitlab.freedesktop.org/drm/msm/-/jobs/87321332

[2] https://gitlab.freedesktop.org/drm/msm/-/jobs/87476851

[3] https://gitlab.freedesktop.org/drm/msm/-/jobs/87482677

[4] https://gitlab.freedesktop.org/drm/msm/-/jobs/87481381

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Manivannan Sadhasivam (2):
>       PCI/ASPM: Override the ASPM and Clock PM states set by BIOS for devicetree platforms
>       PCI: qcom: Remove the custom ASPM enablement code
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 32 --------------------------
>  drivers/pci/pcie/aspm.c                | 42 ++++++++++++++++++++++++++++++++--
>  2 files changed, 40 insertions(+), 34 deletions(-)
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250916-pci-dt-aspm-8b3a7e8d2cf1
> 
> Best regards,
> -- 
> Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> 

-- 
With best wishes
Dmitry

