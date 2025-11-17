Return-Path: <linux-pci+bounces-41436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87904C65825
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 18:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCE654E3BB2
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 17:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3752749D6;
	Mon, 17 Nov 2025 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m/VQdyy6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HVRuI0hx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F942417C2
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763400323; cv=none; b=eCAlkYcteMtgPajsC5pw+jRMAQ0GiQJ+xbbwwJM8qUBiwwFx3emhcQ8O5MP6KWs8RCx89uBc0lG31wnTLlN9xD0EvlrREGzK+flP7l+hco5ve6WR4SeUE5iqldEZRXaerMPBlvlXECIP1ExUx73Fx5rRmTnrRgEGg/2ShwlMVis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763400323; c=relaxed/simple;
	bh=8e/aC8umN0IL0mPoGw0ONH1HIJigz/puqKTOuLkmpEk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SSYfcyog0NxD7gIM9wW77+/slWtTMSP7OCkK9FhN7gYkYE8Q7qy8XfHkw95uKW7CR3v0UW9lJLb1NdluZ8y78S7awPzf67P2f1SThgTxXg2kwrakw0lNBXKMX8MSdsiswubGIxYZDQ3+Im9jryJ48epH1J8WltrYG+Dxkg/NfMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m/VQdyy6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HVRuI0hx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AHECtcx374153
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 17:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hNNfTGr7kgbAQ6vgZf/r6MXWZA9L+L3ktznkm8Grd0Q=; b=m/VQdyy6LHYXE9FS
	GyTIhMk//YEyt+c3soryuizmDV1cimW7z6Tkl59p1XUHSNohtSVRmeKo/x89zAjv
	FFjeX9dcEdq13Dzm/Hi2ZunTcoXAAsAz/d+FdtsVuwx/DVl0+L9DPzL08FSZs96c
	8aTWmRdcXSCUTXaPEJkWeiXdaj4vLrhV8xTllqz4xmZLw4ewgTSFaYDLDBVgJdf4
	ybbJ1GOc8OEqU+R2EqJyEvBeuaJLc3dSRYuffBGuJSSsvt1ylXu5Cyns+65FZkz8
	bLojOc7To46HOaH3emAfnDuLCMiLBWi/4r3BrG4SavjK8H8h3VUBw2iIaKmhoxyp
	qEL78g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag5998k4p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 17:25:21 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7b9321b9312so11620481b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 09:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763400320; x=1764005120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNNfTGr7kgbAQ6vgZf/r6MXWZA9L+L3ktznkm8Grd0Q=;
        b=HVRuI0hx1lUaq8J07jZL9KbZjG1A4v49R56XTM1TJGIWmwoj+Hom1MCpPJAQ30V9tZ
         JVbwYzzkqCGRVqYs/SsEeBPWCBCDNMMV8eKEGf+nVxM4LaNo2HZqCaeKAJG5VQtTypbQ
         tYwoiypuQuRM6FI8muhBk9i74lo3B/KG0mz3+LWqEm8OBDgm94YL2XGqHFS/O8qzswuy
         aiKNbamqVPaLWIvKyCpcYs86iZJO/jojh6oxAnyxMILT//rIZzl211Sk0Oy28JOX3Qs+
         LZzAvQBi3flfFTJGmH9g1lRdqfAhxNiTa5UHVEVgmqmFdqkT7ZYkdQxqnlR1pyndfe9Q
         nBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763400320; x=1764005120;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hNNfTGr7kgbAQ6vgZf/r6MXWZA9L+L3ktznkm8Grd0Q=;
        b=QAW7oDX3RYvIV7vor91AcMOmz7jfgkKSY3XzfjJs9E0659N2iN7/6Ey4ISuF7s5EDb
         ibSrcHAtSaFJNCOgrxBPSHh9ClvTs70bVSHqSatAuuIhvL2cS/LoDx0Kd2Dvj7ZUrFMw
         2ddIx5kYoviGyg5rl3c0bXgeQwfoD19e3yiRIg2rV8TLaH4V1znjj1Rk9A2MQm5mOgx1
         RZPuByW5Adh5WcXGljpsASn8c2zGkS6s7pMciciDBAMk0socSDWr0apRFvgTWY1EOEfu
         t4cD5CXpPBo9DknltRGpYAwdibo6ALX3Oe0R1yIkQnYDnxU16sXC8MvMe4suCh/tBk/g
         E77w==
X-Gm-Message-State: AOJu0YyvKzp98j2r2WnQs8Fify0lsVzgOAgpSs/YKEzlcNybUdxNuj0B
	9GSevu23d3pij2TndAqqfwjwNDObLjLbn/8IjxfpTxRh8BAY9nnHaRD9ZlRgE1SAgYdHy0MfZ0V
	jamfnBcynGI+LQA7Du4At56/MZv0FRQmKugqZb9Q59Q9JNb82fONiTQvmakJMZ6w=
X-Gm-Gg: ASbGncufElSGuhHaJzJhx59XD7FGyVWV0P7oNIpJrphasBdGFkDSMhakXWgQ85In+vC
	KbrMenaFmzJeiuabbb4/qD3fsTP+Kan4woOjbR/u/PshYnfbdWerJUJhoiaC7eQwtm1MIl44VsU
	CidbPegn2hMSe9Ux6JgB7K+EWe8Vqqd1w8t6ezpISD/hfPMf880SSLUjP30+BqIqD5Dzm5Ighwj
	77i3A08yFpT/au/pNCfhx4ad/uEW0dMjq4SUpcUJ7FCgY6Mpo44n9+fk+r1OqUrfHdjoLG16MVD
	StRev+Jd2iT8KYs09MG9R0Zyds9LYprhh1ob5w0vxMmfqWp65ROteWzTlaz12WwBujvASR9U
X-Received: by 2002:a05:6a20:958e:b0:355:c208:b248 with SMTP id adf61e73a8af0-35ba2b85653mr13354846637.60.1763400320206;
        Mon, 17 Nov 2025 09:25:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExUK9Zo7ibeimToijzSxJkNXpJyE8BDQrszsQlwX0dWxBlugUPIHq/7L9txhS29+MA+L8rBw==
X-Received: by 2002:a05:6a20:958e:b0:355:c208:b248 with SMTP id adf61e73a8af0-35ba2b85653mr13354817637.60.1763400319715;
        Mon, 17 Nov 2025 09:25:19 -0800 (PST)
Received: from [192.168.1.102] ([120.60.57.34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36db22439sm13389690a12.4.2025.11.17.09.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 09:25:19 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <1763122140-203068-1-git-send-email-shawn.lin@rock-chips.com>
References: <1763122140-203068-1-git-send-email-shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2] PCI: dwc: Fix wrong PORT_LOGIC_LTSSM_STATE_MASK
 definition
Message-Id: <176340031752.14101.4725068813867484446.b4-ty@kernel.org>
Date: Mon, 17 Nov 2025 22:55:17 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: L7heyVqSbaZMiKUCym1Y2W6NeAWpr50U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDE0NyBTYWx0ZWRfX+hE/CQAI37SG
 2gysKiCdyjwR8Y9ZDV8wCx8QwnXZwPpMhycouBEMk5LKlhwGQPsBWbk5A7nqsoJ7mtrrhfe3q9t
 SSYMIkwrkenbim2mxdLl063INxE23MJfzv1G5xAyJVY1NU9egtf0rqGb6xp8WUh1hdVws3eskF+
 yz0kXW2dEezTY3N8k8PA4cBJB1A/PA7DZFJ4cjNkNFOJLjFTpIJ+o9Yu6QP6F11MkNv+yeP/2nG
 Rw9BfIxnpI5AGt1qoe3Bp+v/58iDUDp4pJUtuf++CxSMuMjUjxNVVMO84DwvT/aYfk88iDRHnDw
 9d3IaLYUE/gL3y8tawdC4B42yfoCv4LPPSK3hF9ufCE6T7hQlJcMxroaewbuHaEF861tw5IdxLx
 dcADWObGDipcC8Axfz4Jb8hBbunlIw==
X-Authority-Analysis: v=2.4 cv=HaMZjyE8 c=1 sm=1 tr=0 ts=691b5a81 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=SvArCPxluHhT4bP621h3eQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=P11NN5HXhNYvJMFK2ggA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: L7heyVqSbaZMiKUCym1Y2W6NeAWpr50U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511170147


On Fri, 14 Nov 2025 20:09:00 +0800, Shawn Lin wrote:
> Per DesignWare Cores PCI Express Controller Register Descriptions,
> section 1.34.11, PL_DEBUG0_OFF is the value on cxpl_debug_info[31:0].
> 
> Per DesignWare Cores PCI Express Controller Databook, section 5.50,
> SII: Debug Signals, cxpl_debug_info[63:0] says:
> "[5:0] smlh_ltssm_state: LTSSM current state. Encoding is same as the dedicated
> smlh_ltssm_state output."
> 
> [...]

Applied, thanks!

[1/1] PCI: dwc: Fix wrong PORT_LOGIC_LTSSM_STATE_MASK definition
      commit: f994ca5a3c812db6896ff04a5cf1fbd286d88799

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


