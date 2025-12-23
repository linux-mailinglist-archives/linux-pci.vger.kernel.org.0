Return-Path: <linux-pci+bounces-43579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B4DCD9474
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 13:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F2C330019EA
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 12:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5D0338917;
	Tue, 23 Dec 2025 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cAgLW6ix";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MVvTi1T8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2155128C860
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766493319; cv=none; b=YFj/u9s2shmIDla+CdaghAVqD9f9el8WAXtk9NaFJ1uRRzZWM3I6ellg9fBK4lbyCAJ4xobcLMfpzseN3mTmJVgWPniqwOwDpSCNYBLayHX8C9Eaq4Zinn+b38YMPzUac5NJeMgExPPV4QwQ183hQmb2/+3y7Sr+l1PJx0y9tv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766493319; c=relaxed/simple;
	bh=XObOU1tEztAAXwr8c6+N4w3p3kx/Ap5jdnHQitH8gHE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ENZBmWROpNSNhTnglJ+UlRPvVwnSguw1+zEsklkTIRdLF/bdArV6J++/vqgT4rKBRTnUplvr/MPP3jQocQYNrJ07rpaNxey7ZvOtjsGvCEkVv1onhJLqzEm0jOlh7vJg8RbjWnXGYwg7UFsbD+JxJateXlz7JOwAIpkOvh72Ck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cAgLW6ix; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MVvTi1T8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNCUeMX1903861
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 12:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3besvCe3+rw8IwX8njwzUQkyMTKwMEQbkR6vw3/xUlI=; b=cAgLW6ixYruoNWrd
	ibsU+dchJ5vfjdDxoL8JD2QmijCzl5+E04VKEScXa2c9EOwpahruDRSoIVjyvB2n
	OgVtZRydnEIY1D3letMEuXQi3tBvwA2mJU48I3/Htwp9nif/Dkm/aEb1E0ZkvX+s
	zkwjSkKYlZFmTOnenI88XMXNMVOQO0Av2lvclDrHwOK4VE8ucyUmC/EpVY3WBfKm
	3eg++2CfsYHIUOcpmULsU6XtN9OpO7pdIG8JlEynjpg6OPbMk0PwbVV+s/zE2l8q
	FxJKEo7byvQEWeds+FiPVReTGJHOGJYMhc6lkztRADRiTozkaXpD6qut2gkR0xLh
	+GpX0g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b79w8k12u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 12:35:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29f25a008dbso45735905ad.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 04:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766493316; x=1767098116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3besvCe3+rw8IwX8njwzUQkyMTKwMEQbkR6vw3/xUlI=;
        b=MVvTi1T81nzqJGablcdmxkMj3SSTFL9eRUw8vfOk7fNqQ9bnavEzZIIOqwJa+p0Y3w
         iq2W1y6eOjsSRc+oM8uWze8O/YAnUD6QC/5i3lvfG5nSgME3+BAajTYmqTxyyoJ2nsYH
         XMHxyW+Gyd+uc1c80rF1gBUld3dclPXRLwjBl599gHKUVl2fPepJv64OG64nc8w0ffPb
         1YmbxSbQEB0/OYMR4ywmDIF4mtWICsFehEk4LJSiShO74FOblMfHeRWbWSn+GYzuiJik
         j6NUgPWCJ4OGrifr3g6rR7+syfJMG4ZxNZNDpGyKtIRcKdEWvwp+K0pbJjyafXyUy85j
         IRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766493316; x=1767098116;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3besvCe3+rw8IwX8njwzUQkyMTKwMEQbkR6vw3/xUlI=;
        b=s4qdKneYDJRPWu3jcCwellKRFW13Joc7Deyx4HAwYG39tPs28L+eSFbHbY1a4gGwI/
         PPi+18HIcqM6vYlwzVxvnaJu7eJKHA/WskfkewlZKmAWdmZOYe/J/26uVDdrmd1cmWJe
         FSFfJYhMobFu67oVXz6Bpjl8mGzen3oBdtlsc3VPmxJU3Xly77W1S+4JXhySPVx546Uv
         GzgkpxSgNTr5R4Gkd6BIUqLMeLRW7B5tqTVhvs7Ltv6zojfAwVd1rwcw7n1FENZVagDK
         E38XwJqv9pIkB6iD0dM+qe5aNtJmQpjZ+kKfn90u8tULGooK3esYAoz+7xFe1FESrBln
         mAnw==
X-Gm-Message-State: AOJu0YwHtzMHGPhscOwsuR2Ilv7Gk5rO9DokyWHHOjeJIRbCTMzj73uW
	jeNnF6LC+p6i4j1OAmmSR9anU7EXZfaJxuDT1ecVXMShhmqPJI66RmYcgMDMNl0PV4H3Km/HigN
	h6ES5DWvroDKkfql+o4KPz9yYxRfaDuJLisbFt4/RD/9Bj0EyD18NuUsqYSDJeNg=
X-Gm-Gg: AY/fxX5qxsgHhy/IIakAckFfNSEbc9AyMJsD+gqpH6HUnop06am5LIVU/JOVpakkZq0
	ScEdEZSmWiLzrd+bjp/66Q1Nrg6HFr9l5TQCEoqkCoIs+HqfR1+akiUpKsU0R42Ye4/wxoMrdXR
	dqH8ryjHzSg1w/xcNiI5dA7eOMOtjGwbmRWdDUaUN+RFWUUDpUQqtgNWFtOhoSUZCfPt/9Qo45G
	69eTA914KfOhuOFSnge6en4HSKErDkuv5C+uUMd7UEM2uVudjrcuyl3jDo/nTLOgpDBlL9uh0qR
	2sJYYoB4vC7oQe838bAaff7HAcLBmc3rzbqeDwv0T/NyskLYbGr4uDm84i+FKYQTgzvuU9de9EO
	ElyFyceHy
X-Received: by 2002:a17:903:2a85:b0:2a0:c1f5:c695 with SMTP id d9443c01a7336-2a2f2223709mr154383955ad.16.1766493315932;
        Tue, 23 Dec 2025 04:35:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEK/WfPK7ehic7AykZDkqMohCsuORpQskp+MgJ/qxEP+NjSVB3+4rmjRKLgNtSu8ssfUpESfg==
X-Received: by 2002:a17:903:2a85:b0:2a0:c1f5:c695 with SMTP id d9443c01a7336-2a2f2223709mr154383625ad.16.1766493315435;
        Tue, 23 Dec 2025 04:35:15 -0800 (PST)
Received: from [192.168.1.102] ([120.60.139.28])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cbe5sm128637585ad.60.2025.12.23.04.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 04:35:15 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        bhelgaas@google.com, frank.li@nxp.com, l.stach@pengutronix.de,
        lpieralisi@kernel.org, kwilczynski@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org
In-Reply-To: <20251211064821.2707001-1-hongxing.zhu@nxp.com>
References: <20251211064821.2707001-1-hongxing.zhu@nxp.com>
Subject: Re: (subset) [PATCH v10 0/4] PCI: imx6: Add external reference
 clock mode support
Message-Id: <176649331066.523506.9443864112044699350.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 18:05:10 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDEwMiBTYWx0ZWRfXw/YhB1sA2D48
 3tyCOvqOBWFUdChZVgNghBt0TH/9QOWtPenog16RclkKjf1mDFJ8CIQE85VK2nMIuRLd2wlDrKr
 s5GIUWXV5NogbhHfPCh0dtYwXIKeOONTiLRvj4yNmHQQh8hJwg8QVe9TXQ64GyMGBOBbH1xsU8/
 qD/Bdc9wDGXi2DCiW2tlLu25rsHBAv7CfY+/PBKkwQQP25D1OZhqHUgoYOGuQax845DSgh4+L6Q
 ACR6qDMHNEAXJmAvbOySIHOL8AYXi7PLvhWuqlshQl65CgPwq7QoBSwTck/2np9YWlsPTQDK8NC
 zeOJkmOhss5wkafBifo9UA8vZqLfLoBbUEAM52K6yIPDwbMZm9QLylKCaWORGum8IlUQBEZmRnQ
 SV2pWCETE/IHJD+luyBo7kcucbFDHFuyGlbtnjgpBUBt9Bgtv2M9Cw0DRHiHKhCqiAQz4Pw5BWs
 Mwvqf0bBy4Y3f/iBoKQ==
X-Proofpoint-GUID: _uvS-OBww6nVuk0moZSR032PP2-VRnx6
X-Proofpoint-ORIG-GUID: _uvS-OBww6nVuk0moZSR032PP2-VRnx6
X-Authority-Analysis: v=2.4 cv=T/eBjvKQ c=1 sm=1 tr=0 ts=694a8c84 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=wbxd9xFQoh2bOL7BUxlcyw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EXx6v-oOm7wFthy7ysMA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512230102


On Thu, 11 Dec 2025 14:48:17 +0800, Richard Zhu wrote:
> I'm really sorry to send this version patch-set late, because that I was
> engaged in other emergent tasks in the past weeks. And didn't have time
> to continue this topic. Now, I have chance to continue doing this again.
> Sorry to bring the inconvenience to the patch review.
> 
> i.MX95 PCIes have two reference clock inputs: one from internal PLL.
> It's wired inside chip and present as "ref" clock. It's not an optional
> clock. The other from off chip crystal oscillator. The "extref" clock
> refers to a reference clock from an external crystal oscillator through
> the CLKIN_N/P pair PADs. It is an optional clock, relied on the board
> design.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: PCI: dwc: Add external reference clock input
      commit: 418970983059aa06302ddd5ca76d441973b537c1
[2/4] dt-bindings: PCI: pci-imx6: Add external reference clock input
      commit: 1352f58d7c8dfb6ba0fbd2041bfc8b4b3966ec67
[3/4] PCI: imx6: Add external reference clock input mode support
      commit: d8574ce57d760a958623c8f6bc3c55b5187a7bd7

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


