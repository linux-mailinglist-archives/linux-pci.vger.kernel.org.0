Return-Path: <linux-pci+bounces-41404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EFCC6441A
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 14:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B881E28DF8
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 13:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4B232E6A2;
	Mon, 17 Nov 2025 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VVNpG5PB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hxoMoLBr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B2B32C955
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763384706; cv=none; b=bXdSU7KA7kRCXQfsjjU7ydiUaRWpA2ODzTHXd3zEC+5HJrIoPiGKWvMHwzWALTn/7hcDOYfFPCDdvEe+kr1zxM9ZwBn4k8F/9bLGErijvAV0QfIOK5yW52vrSAef1d7bxP17JhBisSB9ccH71V03n2oNcmciZasd5RVAp63b/qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763384706; c=relaxed/simple;
	bh=5yCRmdi0Tv9gpuifWOHlnijXJyxiJz4oS4TwD9D1yOU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d21Lj+5oBRxS7Vw4ZczcWj/J+tV1X+Gmld5jdmISU/9FU33e6kqvSZ4PfspnggViLZYQjGCpPjqmEVD1beU4m5hI5kuDtBZJtMvUT/ORqDB8YL7yClx98WCES3OzRw8AabALiYdrFrq5QrdAffY7FAcRNH1UmAYN6LqFv56BugQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VVNpG5PB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hxoMoLBr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AHB79pI3040296
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 13:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xpsxNYWPsMe/6TFTnTzP+C3Ff4+xereCCMFTVc8U9nY=; b=VVNpG5PBbjKRzcwE
	mY+1UxDsOEAS1RvrLKOHhIv8aGeuPazKMIB8fcPvnciJ1SztomCZ927pqb/12LCf
	fh5Z44+MKOpqMzIGIF3+5/0NIcgWqexasfTorHNocjTkCqdgFNIjdqTUhXuPG8aW
	i/gYxeo0G4ibimlaaVP0FyhUoQZov7bz4H/q5YICGJTxj3SIKUt0TzgXd3jcj0bb
	HjzcFBpLAUzPSLSue3iD8L7DSeSJrJ6CHJci8vyySw9R9kuk4Yoo4V9pmDT/KAzd
	0WZBVvE+X80VLkMWe3fvonV0TNFsywbRJmQljrxAmDb9K7wcR3/4+ycGmEFeXEx7
	MbzF2Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aejh04smk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 13:05:03 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-340c261fb38so8822182a91.0
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 05:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763384702; x=1763989502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpsxNYWPsMe/6TFTnTzP+C3Ff4+xereCCMFTVc8U9nY=;
        b=hxoMoLBrRM2geix+ElfwVajRocQQ5QeqZ0o8Alt0CEqU2gVPT23Rcs5MsO4maU09Wf
         DFmIS7Bp/n2eC0Qz0dHEsRi9YYP8mQ5cm2G4a7LmgvFHepXzu1je9U7vjC881VabiaIx
         KpSy39PYi8DM0OQx7wkzcg0mVwlltH+cRiDyVNoLjT+lTmFu0ANne84DZpdCr2gCWfkH
         uevpzUIX0nwQHBbNI2KZiDYIjmDsJJ+MB54nh+lKbWXZ0VxAv61iCnpVPEBN2ttAmdzG
         R/rPhXJdjG+AQJsROll4X1WV2TXnuwhOlRD7zT4Wd064d7j+rjWuL+Ef1uabr/3AsYjT
         3JhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763384702; x=1763989502;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xpsxNYWPsMe/6TFTnTzP+C3Ff4+xereCCMFTVc8U9nY=;
        b=VFLRC8gp/zslcpUfcPI6BuGO4ErTj4ec3M/aGfa3laqdLJnmp2J9HTbGABKCTd+vYt
         4rbwRzyKz1a9AXixP/w/gexKl0FffKLf+Fr7tv/BTYjfhLrERO/8Zee3R9avThopL1Xl
         lauLPAtf0svFBjh28bkIDN8GdP0b5Fbzxd3GwcNkaIV427XC6fN/wxecFcCIWxE2B182
         Bk69jV+e2rnX+Z6Q1qIUEJRUPpu4qXT2gxLEP63Z/644UxSiSuHCNOf4zHCkD3rE1zh9
         TtCLqrndOWviMeoS+teRFjTE4oCTXapTWIx/YcoqJwAYiVoULtzGIKH9WsFRADUi16iN
         hxQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfIWq561XQOeZeplRR5H4+CKlO6NjQbiqS2LpEViL7Jjkfid6OpB76iHLerKti+5UFpxVSDcFogWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKkFqpe/kfEv9gw5pmGGqlvZ9mfJeO4R9/ct0+l5RTupAllBIt
	ivg0WhHxTAaUObvxCdJHgN0jeHSWAYzBlYTyQiLPznjVNwqO4fw9XaX+ZUkUwnzRFJeRffqv1n/
	/K8UgkHOaLjSeT2qyBvHmj/egLY9O5MsSrqQts5jdbYE1QhiTi4KV00I3JkPq/Kk=
X-Gm-Gg: ASbGncuAXd7iWc8hba/ItgnHSUceU4cSeOuL9BLuYjcTAxqC7ijDsGvG0YQzpPC2R9/
	m9Yn+JGoyWrrL+PjllYOSyDOxV5X2q1N0i2NUtAVm+HEMeeeZa2zRqqrNHb85zY1d/FRV23jk93
	jySQvP6gxOOv4bZx5dXFTy5sTywuGtxdh8akpw96951KcTs8WMrcJApnCRxXu45k6vaGuNuTWPL
	O/hz3Z+i86jipBFQP0MGjA2eCudXZHBpXUP0ew9hnouHVc0ABLxWGzqUxQzToqBM+az2F5NE902
	evjBmgY1x/Bs+KEcE5GSo7cf/XaIXtZEA8R7w2bwCj+Upp1HpZJNiCgnBcWBvUFZPxlS6kOW
X-Received: by 2002:a17:90b:3b4f:b0:343:5f43:9359 with SMTP id 98e67ed59e1d1-343fa74d185mr13287227a91.31.1763384702104;
        Mon, 17 Nov 2025 05:05:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4PSvYzJhtndiMBVP5ykwZcA1Q4a12OTYS+nC1rxVRvYZGYVu65h2SVT8TcOdvzNUaA+mZMQ==
X-Received: by 2002:a17:90b:3b4f:b0:343:5f43:9359 with SMTP id 98e67ed59e1d1-343fa74d185mr13287191a91.31.1763384701546;
        Mon, 17 Nov 2025 05:05:01 -0800 (PST)
Received: from [192.168.1.102] ([120.60.57.34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36d842cb0sm12295125a12.3.2025.11.17.05.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 05:05:01 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
In-Reply-To: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-0-28c1f11599fe@linaro.org>
References: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-0-28c1f11599fe@linaro.org>
Subject: Re: [PATCH v2 0/9] dt-bindings: PCI: qcom: Add missing required
 power-domains and resets
Message-Id: <176338469470.49677.4156123055706530266.b4-ty@kernel.org>
Date: Mon, 17 Nov 2025 18:34:54 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=W9U1lBWk c=1 sm=1 tr=0 ts=691b1d7f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=SvArCPxluHhT4bP621h3eQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bC-a23v3AAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
 a=aYgwznu0jBjAPEED3YsA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22 a=poXaRoVlC6wW9_mwW8W4:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-GUID: x24GdwNMBL0m-2VyolvpslP55IgvPqS0
X-Proofpoint-ORIG-GUID: x24GdwNMBL0m-2VyolvpslP55IgvPqS0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDExMCBTYWx0ZWRfX5VycJ7V11zBB
 vtvC2qqG1W8MpFVraP2whpO0J6JfV0L57rJYtehrKKNqM7hD+rvGxm+fnXGCkmFOnTC92tyJcuq
 k7rerar7HmqQq1GUGGU1/P6QbKebkT5b/EakVi2OGZSBOuXWMhzgnsEnRz5XwoVr9osmUhIJJ8M
 DS7+U81tBugYnmFmJ4EwL4WGLUyE1GMDRlU40LubJEB4sQzVBqj4RJ7iAHY96vzC0B6F2U2P+h4
 VVpnyNmXoy1LNgsYwCIZLuIwQuJ9tZBWucROm0sOaxxWnsZG/Yw6qi/eXKsN4OliaRLFRNBFniB
 mDEY0NnzIH50/SVGyKWwhbf+BrdClUgpVKCZa9jliBCAygriZb4P8CP+6WvOEoiwnpH4XPZDGrJ
 X7SLLIdbIB8O+wu2R+sHKeQ/mSNL5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511170110


On Thu, 30 Oct 2025 09:50:43 +0100, Krzysztof Kozlowski wrote:
> Changes in v2:
> - Add also resets
> - Drop cc-stable tag in the last patch
> - Link to v1: https://patch.msgid.link/20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org
> 
> Recent binding changes forgot to make power-domains and resets required.
> 
> [...]

Applied, thanks!

[1/9] dt-bindings: PCI: qcom,pcie-sa8775p: Add missing required power-domains and resets
      commit: 2ca17727b3623228466d15a562c6c4f4bea8cc49
[2/9] dt-bindings: PCI: qcom,pcie-sc7280: Add missing required power-domains and resets
      commit: ef99c2efeacac7758cc8c2d00e3200100a4da16c
[3/9] dt-bindings: PCI: qcom,pcie-sc8280xp: Add missing required power-domains and resets
      commit: ea551601404d286813aef6819ddf0bf1d7d69a24
[4/9] dt-bindings: PCI: qcom,pcie-sm8150: Add missing required power-domains and resets
      commit: 31cb432b62fb796e0c1084542ba39311d2f716d5
[5/9] dt-bindings: PCI: qcom,pcie-sm8250: Add missing required power-domains and resets
      commit: 2620c6bcd8c141b79ff2afe95dc814dfab644f63
[6/9] dt-bindings: PCI: qcom,pcie-sm8350: Add missing required power-domains and resets
      commit: 012ba0d5f02e1f192eda263b5f9f826e47d607bb
[7/9] dt-bindings: PCI: qcom,pcie-sm8450: Add missing required power-domains and resets
      commit: 667facc4000c49a7c280097ef6638f133bcb1e59
[8/9] dt-bindings: PCI: qcom,pcie-sm8550: Add missing required power-domains and resets
      commit: e60c6f34b9f3a83f96006243c0ef96c134520257
[9/9] dt-bindings: PCI: qcom,pcie-x1e80100: Add missing required power-domains and resets
      commit: 3b83eea6334acd07ae5fa043442a6ade732d7a39

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


