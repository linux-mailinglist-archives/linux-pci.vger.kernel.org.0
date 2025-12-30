Return-Path: <linux-pci+bounces-43864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EB619CEA45D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 18:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53DC7300752D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 17:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF1130B53F;
	Tue, 30 Dec 2025 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JXGZfnXN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QIbQcJGj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2030E32B9B8
	for <linux-pci@vger.kernel.org>; Tue, 30 Dec 2025 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767114271; cv=none; b=t2K+wItgagmWNpD6dJTOoHV5lNkkuWOl6qAuxcq7hkm8i1Llag31DhkREUbV39iSXcKkCqpb1hnchP+FqVY8//DK4uaio3TM0yAgXjLU+6FZJ9oWVxcJhGrwCkRRHDLW1eWnetOeFdAvo1ArZdmYTqiwc55NlfmowPI8ho+KcHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767114271; c=relaxed/simple;
	bh=6sSH8eEy/V/LbtFHwav5NOYw6tPgPJDb53fy6b2Vi+s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QMSmP+n5spESlFf7apG3/RxBJB5eHvifM/qXb+SNdqFvEgV7ggP3WtL6MAOUHppAzNN+7l3gET4Jt8yKlcuRj2QW/BLj9R7lax+uYjfZVxqh/Df/8yQqEuCxMRgUr2l4M4K8tmHdUKjq2qpSDe5VHIPSvZjCdBGV4ItG6LkjG6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JXGZfnXN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QIbQcJGj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUBPkic3018711
	for <linux-pci@vger.kernel.org>; Tue, 30 Dec 2025 17:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oahDzZtKp4aKLWOPEag8A9pjZDWXjStTAMgcucgxXPI=; b=JXGZfnXNfLVFmMON
	bIOd9bLLjqETvvUvWjMIwTVw82vA3dmQa1Y+HwVdUF3PomATZSd94eB4jg7E6v0h
	iGe1ff1Avvl8N815zbLxJi0i1gqB01ivEw/q+3TZcAtqF13Labnu//Rov+HuLVJg
	P+Vz6yGeaY83s28TuYRGrEva9YKj5UTTeZ6D8CD7AkS11B2mpDmfErbPFbRMqlGF
	PxxZEvwzDTYGopvQNw4Nw+6I/l97LBfD6xMuitrjEC1X16/3YnH5/t2MFNqvErGo
	5cyBl6PAQnhH3qYENbn6EUTBwRK1Rcrqt4AAvJ0A/KsAJhn9Pj/eOFTZei9heWlU
	Qz1WGg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc0vdjf7n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 30 Dec 2025 17:04:28 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34ac819b2f2so11998281a91.0
        for <linux-pci@vger.kernel.org>; Tue, 30 Dec 2025 09:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767114268; x=1767719068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oahDzZtKp4aKLWOPEag8A9pjZDWXjStTAMgcucgxXPI=;
        b=QIbQcJGjHRn1PtZYO7LIMRBkz+VwQztC5KyL+q2Y3GMIBuo+CWt6URFeijVuOL+pMn
         ouV6v7O4KX4Sv40zQVvcvi5E8UYLmFjUsD2pkSs86ra3mQN3Ymj/YBYY0vOk6SjaepdV
         44MkafZ/4w1gRIUyR+tkYqzGvKebs3X5MpmW5qChwHykKEic8XtWxveNzGiYKZ1JunKx
         9Ca6c61+ET8K5CoMMaFZe0ii1M0lSxQvENIeizHslbVcGcNrqh02o6IS6MJP7XfWfKDQ
         5Szghrq+DhMHxzwyOFdfZsIZTWg6u5wjcchxMKOtz0PPI2fothmEW6wybzPnfvUlvETj
         aEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767114268; x=1767719068;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oahDzZtKp4aKLWOPEag8A9pjZDWXjStTAMgcucgxXPI=;
        b=u+HByIgz0Y+M25DWV7xaFKkdtvRbqNdjnwPN8BW8EtiVvCMnZXTAbf+5r8Q4J0Bay0
         x+KW6rZA34igI/T64naig0vBs6F//U+pLXb1ReRZjgayMu85Rg8Jgsr9T/L/CUIMGJ76
         HLQsx21CYNfybzG+c22ZTqmh7yrWa9n56r9/AF9XUs0Vwy9hEbAhvGbhw7o76G7jHuqG
         L0HhtWw8SlFS5rYxZHQCRgUjWm70gN6q1l5ZtkJVo99WpxlNYvqAi3k9r+bdLMbwW2Rp
         czKQyGWRlRAZflZrvQQ8oIE4tvdXj/tn3zcom+T97V3LFXxc5Q5Gib41tFlkCcMZOclF
         0CzA==
X-Gm-Message-State: AOJu0YxhWXqjrpsfl1+pptfj/6IL8rlmcjiKBPWs+rpHPbMovXLEqj8o
	sy8O2UlXQ723tl3dr29hG1PObUEEU+28YE3bDESc9AalrkgA2db2pGKKF+41UExSzLsrWgW5JZ7
	VLg8Cw+tYydeJTmwnjPxLE0mvUV7Qj7WLyrdfwybFnWmJGyhhoRBFdIVWOhNGqFA=
X-Gm-Gg: AY/fxX6pCQDaF8m7qw8BjX6XourO1SzcytOnEGO4gKyVM3p1x4+N10XBdG3PQCSBlb9
	RoeUQif/U5T76aYQLhO4OczqIpLu9PNpf6ZiIPZRkyG2mpIdQs4Rf/OPYYKCGI1Gv4OPoqpmcWS
	Db5pmreOJ0AWstFMKGeW2uMIqShMtSF96k6Nw1Y3s6v8AAZ8V9uyJUqzsjtVCBCC6bsGjeV/v7f
	pOyuJ5l2z3L+zVL3PZ0IIyTZRpyOP+NR88GQpIuj7gIgSdU5yxBGEETQZb7u0Vy7KgIkCT3Db0D
	OMHUN6Ne2nrowRu9TXEYDqmzRPR1D5aGK7NPyzyJwZUKsHYQA7UAGfBuT0sz0bKL8g6ubbFtRrP
	utJstMyQ=
X-Received: by 2002:a05:6a20:9392:b0:35b:4f5c:4adf with SMTP id adf61e73a8af0-376a96baae6mr27914901637.43.1767114267726;
        Tue, 30 Dec 2025 09:04:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2Rl5LfHDVkgfWMi9X/mea7YMMMGHUdRao3zak1EyBlsAdgBNCXkb1Y5Gc9zz6/BvvBV62jQ==
X-Received: by 2002:a05:6a20:9392:b0:35b:4f5c:4adf with SMTP id adf61e73a8af0-376a96baae6mr27914869637.43.1767114267222;
        Tue, 30 Dec 2025 09:04:27 -0800 (PST)
Received: from [192.168.1.102] ([120.60.65.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e921b1666sm30515521a91.7.2025.12.30.09.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 09:04:26 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251215212456.3317558-1-robh@kernel.org>
References: <20251215212456.3317558-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: socionext,uniphier-pcie: Fix
 interrupt controller node name
Message-Id: <176711426350.2039520.18416499850960877912.b4-ty@kernel.org>
Date: Tue, 30 Dec 2025 22:34:23 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=dfONHHXe c=1 sm=1 tr=0 ts=6954061c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=+SK5D59PVgoENw9OlSzWFQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=W_j9OZaKoQe7uW5gK9QA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDE1MyBTYWx0ZWRfX6XH5U9gCRH/Z
 yG4ibTUwr1FwwRItDO0TUePHbYEB4uozPbLeyHSbmKEfEsS8jqrI9RGRA1ouzLa3SjpoNVXFhcZ
 bFpLhf22n7b4HQHDtY3RtEeBvzdGT7TWezT4DR38WQG2Ijn4upktIJGpyMF6/+dc3c1xc401hxR
 PwX5NYgFdGGzfNgte3BsI+NnXB5Xh2NDFClMRPbzo0gfXdpvPpKhYOYBsM6mL7FlKGmkMumMylx
 IRBKnGz5X9zrVO7bniADIkxjbLlj7Y/H3b5miyE1J+rJjspyT/Vl//oqbl9c8hOIONvNmugoJfM
 f0P66xWbYRZmdPYMVpoLEfuoRWNN4AU19LxWX3yMSAJma6oKkuGhlbGWSyYGv2yvefGQ21TnEpE
 DmP6AWPvhKhSoqaOULtfct366NjTPf9My33l1CzWzd2kCHfi3TmrA+vyL4l5jCPR1LJHdFR0kRF
 zi+hUzfQfil4+51x9iw==
X-Proofpoint-GUID: SDAG8TAaigOOPcwcCUAVrNN5x9pwE_pb
X-Proofpoint-ORIG-GUID: SDAG8TAaigOOPcwcCUAVrNN5x9pwE_pb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_02,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300153


On Mon, 15 Dec 2025 15:24:56 -0600, Rob Herring (Arm) wrote:
> The child node name in use by .dts files and the driver is
> "legacy-interrupt-controller", not "interrupt-controller".
> 
> 

Applied, thanks!

[1/1] dt-bindings: PCI: socionext,uniphier-pcie: Fix interrupt controller node name
      commit: 2cca8d79709e1debd27da5dcae2abc859f41db70

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


