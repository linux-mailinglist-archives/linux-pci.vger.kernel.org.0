Return-Path: <linux-pci+bounces-44615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 884A0D19A1F
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 15:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 191A73024D58
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 14:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F42B2BF3F3;
	Tue, 13 Jan 2026 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LmmQocyz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GI459ntq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F01E26E6F8
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768315911; cv=none; b=Hst70oe9uPLWSas9iBr7B1xf86I9eWL6TslqaRxbzzSYR/TQK7RpVxhbnoiv3xTSX1uft/lKnKgQHgNIWT7JUXHyCbXY7BwS0a5nEEg8rlVKN3apvgF522bLOts9CJUTwfW/vuW0cMe8T+y/elAvV/yxM9yhh9kOQcBbZOSEsNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768315911; c=relaxed/simple;
	bh=+JAI9VnHIBX00B46wh31e/5xxd26d7m1SDaNEyut3Cc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OBCEWBIgWJ3uO6mqYwfWorgEgntpLgK3YByjABcD2U05qCRtytfeP5RgFtnfAPKuj/O1eueBj331upVwTJuBYN5QYkBPsgNGzPSHrJul3FdUTdq6rdSe3f8LA2pCdj1uksC5aGq6lCCMa5cG6kI2PivbDTAP9KzyTgy3oXR1a8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LmmQocyz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GI459ntq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D8Yw5T3727114
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 14:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6bIAA5jpDbLy42+i72oOADm6AmGYV3kdImVw7xhJJag=; b=LmmQocyzwI3vxIQ0
	6R7fSlmdKnmMSP/UUsw3rs7aFgWECrb8gIeEuPnccdNsn86JBgA+YNNW9+jWueHa
	aLdMUx3tV0BRXJf6GMCnqPqcCc7BdVpde8TXvJ9hKK2xvTmCUbyEWuMZ71Xp45hf
	5hEOv/CM4m/FeBWHZcqJfru6tOLUzT5DKWNG0wE7AB5ZTHN1d03DYnueuIofCsC7
	KJsYtbvtJlrwoLoXLr+VXr5ONU4WPz//eE3FSzuWKaAdUhAUEcjOt3oVretvLReV
	iliPTRS0AZFmuuvl14dFf++9CMSSxtYOeg33Poo/L5IpKNw0As+49FWe8/F0DdSx
	87c3yA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnjnu170v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 14:51:49 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c7d0c5ed2so6863425a91.0
        for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 06:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768315909; x=1768920709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bIAA5jpDbLy42+i72oOADm6AmGYV3kdImVw7xhJJag=;
        b=GI459ntqHAiUODSbycSuGKKX9AZv47g0G5jkZNP3Bp4h+Ehk65co3GTdSSSlyWsfYj
         7uL47xVtgrDUcXyeI9d4f1NyQ2rwiD6JsHAwly9dX3JY8yZr6R0aYfwzIsnzFBf2qbJ/
         FoIdQRY7Y6FxPwgPKJWi6KA8zhPVmbj8dNlyUFGLIPI/XnINUVrsBmOamWgypLMMLYha
         Ket+HPNCPcL1k8rDgyvlo7xI5dYtySplqzBR22fE9FXgjgNSy/VgnfTVTcyRpFfECBIj
         wXu4QIEnfRrneVu4tpP6VpO2QBj+EeG4+3tqoCvQRk8LlwVxduCJHRiA8Hlt7WuVa87B
         OEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768315909; x=1768920709;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6bIAA5jpDbLy42+i72oOADm6AmGYV3kdImVw7xhJJag=;
        b=TNC5JYjlATeTEVctjlbDxQZkj2EPUg5Ex+8byVPKg/rUotr9cmACzhg08uGf1LHRC7
         N+yo6AannK8EhmAsL6KMfprYofv72YvOAvE0DjrQGsq881WcynwN02oFF93i9umD8iLV
         h0r4asjGY887qSOVX+7Hr9ltFbvbnWtB0Q9B2rJxG+BAOjDHi5mxx7rxjuH857yJpeLJ
         zuWTijSXFQewpXq5U4VUwTO5/mouEuYUQagGeDA/3v1ZAEbXGKl1/wK83g9d1Jc1CQv2
         jT6KxHGh/TvW0SzkMF9yZbG6h8PMGhguRzuavwrwSwiqQ5sGqHvZw+nX350a54Ikz96G
         YB5w==
X-Forwarded-Encrypted: i=1; AJvYcCXCy5T8LbeY7CaPBKMYFTmUlP4CMTNQlK++Xyk8VLU5/DWzf+fKfnFPrrYdKslICxL9wPrFKujIpi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC6S7Z9jdE6SMhjd9he1O0cuFOtNj1uATT3cbXAJeyli1oyzjm
	Ylc7YZqIXn8fxYTwDTc38nvf/TbCJvdNYemovYTPzWxNHu83YrxhCAju3mpI5yMj++I7Hi0NztX
	l4RyNIPo+k1YMe0Il3Nrx54kYkSBLIw3KbJsFsUxoFcMjZPnNsqN3lsTm5AUtPYA=
X-Gm-Gg: AY/fxX62jf1caXJ7PT9998AZqtYr/uB7qFZK9qKtJhE0hOSZWrqR8h/U9Nv0HqG9T8G
	RGJjOevdg2/ps8K3EwyG19mjUsCBPpLLzjodHnbbHTPgxR0IawC3CvW15H5Iu/np01hUZCR9Cmo
	+bsqd78Pi5P1vx6jUpcIEW4Wyagr6KhNsBxCTUzywPU9yLPT8w2OR0HrcEAbNMemeZcXfKozHiF
	pxsa5lw6CjONat4OfGdbMJwcYbwcAfq301/MhxpGqtIXXw0PeNEixoOSljw5XhUrl4+mENT2006
	5TIJPaz7O9qnTE+01ksvgCjNjkjjHqRDuZLrXQCI2b62F0+1XFwxZ1CGgeTJtke5gLOhjqFx16K
	0KJp/54hp
X-Received: by 2002:a17:90b:540e:b0:33d:a0fd:257b with SMTP id 98e67ed59e1d1-34f68c48351mr18090579a91.36.1768315908880;
        Tue, 13 Jan 2026 06:51:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+nJvkNAJLGvmDDW2eJiVku4fA2nWosYNYM3zmKyiIIl2dn4BDA4tQWPsuNIqE+KRlpq0TGg==
X-Received: by 2002:a17:90b:540e:b0:33d:a0fd:257b with SMTP id 98e67ed59e1d1-34f68c48351mr18090539a91.36.1768315908245;
        Tue, 13 Jan 2026 06:51:48 -0800 (PST)
Received: from [192.168.1.102] ([120.60.62.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7c6f4dsm20552848a91.8.2026.01.13.06.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 06:51:47 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Inochi Amaoto <inochiama@gmail.com>
Cc: Han Gao <rabenda.cn@gmail.com>, linux-pci@vger.kernel.org,
        sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
        Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>,
        Han Gao <gaohan@iscas.ac.cn>
In-Reply-To: <20260109040756.731169-1-inochiama@gmail.com>
References: <20260109040756.731169-1-inochiama@gmail.com>
Subject: Re: [PATCH] PCI/sophgo: Avoid L0s and L1 on Sophgo 2044 PCIe Root
 Ports
Message-Id: <176831590431.500768.9251307274356703200.b4-ty@kernel.org>
Date: Tue, 13 Jan 2026 20:21:44 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: aaDFdAqe3ZvlLxl57FEfNUcSqrXsPJrm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDEyNSBTYWx0ZWRfX9QlDzI6ofgb6
 0pd7lYLT/Uw8hN3k3Dt9ulLMg+YyqzaEUZv3qnlEgVXVu1bBIESpuKpoPMkQ+ZPc5W+txSWCrKk
 FHi1Tc3ADTvCxF8dmAPCp6ZwcIQfQnnlF87zQuxKnWDghqnSzvvpic4+XbmTLKwGnGl5my/8qFm
 u7HdUGs0UU6JqxPZsHAEaqrQGlZHvyDpFq3qZAQm5u/8XVhL8olAMr4p5WmXaqFFUYvRNn3T5u7
 T7swWtn1XkQ5XHiEmtyIxNiMiV6cMQlPPspDOIEk3Dbf60CJjIJT/2pz0r2vok9hAZlPhDm2ZsX
 AEo7GpLdTt6Fu75VXIsqz8CZlp+rosdRMjNQNri9KbqtSxKk2/TIQZ4OZ6chlVgC6lv3i83BZLo
 Z5knK9Swxd53a59QJfc1zObnK6l9afOlZbpglREMsnI2AgSD2aGsIWof/t63Oxc5lJeIEDv9YWo
 qxX5uRCd/GkjJNfvyLg==
X-Authority-Analysis: v=2.4 cv=RMu+3oi+ c=1 sm=1 tr=0 ts=69665c05 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=tlgrONNCw2HA119KiuRAjA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=8rKNN5rFLlO33tCDVXkA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: aaDFdAqe3ZvlLxl57FEfNUcSqrXsPJrm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130125


On Fri, 09 Jan 2026 12:07:53 +0800, Inochi Amaoto wrote:
> Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
> states for devicetree platforms") force enable ASPM on all device tree
> platform, the SG2044 root port breaks as it advertises L0s and L1
> capabilities without supporting it.
> 
> Mask the L0s and L1 Support advertised in Link Capabilities
> in the LINKCAP register SG2044 Root Ports, so the framework
> won't try to enable those states.
> 
> [...]

Applied, thanks!

[1/1] PCI/sophgo: Avoid L0s and L1 on Sophgo 2044 PCIe Root Ports
      commit: 613f3255a35a95f52575dd8c60b7ac9d711639ce

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


