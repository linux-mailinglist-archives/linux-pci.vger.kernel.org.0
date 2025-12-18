Return-Path: <linux-pci+bounces-43245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7200DCCA66D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 07:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7029A301B82C
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 06:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B16231845;
	Thu, 18 Dec 2025 06:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QxCecsCm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dNl3ueZz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C951E520C
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 06:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037969; cv=none; b=dQcmdaPPliaaIsqYMfs+6anWftyikbFPR6N+ewSm+Pkin16PWzC0+C34n8FNGqdhISlojhr/1tndQtPF7n8NyPnHc803RVbpTS05ouIyw6EpN4LUmdeQRvfgCFL+KGP6rAAZWTsOmD/ko3YieaPvwLSVfOIqZHjA/jmJGw9i8ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037969; c=relaxed/simple;
	bh=lg4ux/qXMXWcEAofVJDj5W7+6fuplHF5ggyU43Des8w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UmTvDFBtsRfnnSw3nff+pecLIMCNmjqgNN/8okG7zIXW28H/zyhFuAYfKWxXEJlNHqgdhJT4yukA/owvv75HhGybxy/Sh4gQIZXKZ+SzlBvjzhMG2afnedN/c3Y02yq+diu8bgo0icNHDX9F4g3PrwU9JMD3NhGpdBeo7eDOjK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QxCecsCm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dNl3ueZz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1YjQ63717126
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 06:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MjYhNKTKp8oFFQ8K5luAyAyOx4SBt2zoxQ2yTKlGYwg=; b=QxCecsCm8onLOGsa
	iYRpZfZiryUV3xxJbjbOgke0QbM4opxOYcPEVwXZJV+J6iQ5c97vIfoDKSbkI1Lt
	PUXNwL64GTt59o5LufgUq6mId4uitv+4lZG3M2yFQTpMh92fOQRIpfCNhUjUwXmY
	OYYqlDwA6dz5gZ0iY/H/SIUldhAK2wEHE9UpBtxf2ml4sECXDmk//C7vfztHgOt4
	zcGfiXqtvMO2cdgttRbkzci2Fl7b3xK+RhKuNIzFU6eMiyq4SHd/3rdwilaG96FD
	HqMadCIPCzg7+MgNBYuMMymq4DWITBUljMrXgJkIT4hknAFMA8cGLyDZGTcW1HiE
	ZxiLmA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40n79xf7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 06:06:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f2381ea85so5892005ad.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 22:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766037967; x=1766642767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjYhNKTKp8oFFQ8K5luAyAyOx4SBt2zoxQ2yTKlGYwg=;
        b=dNl3ueZzXlroqSB4Xm0DVin3ZEhZd+R6R3fHjCZQnwYTY8fPqlLe/If4oth8vzqNfx
         cPzeg+4x4MIsdb6v1/6tPRl0ElZhrlq571vV4sBfmfVGdDqfNtdnQqq9nQTarF0APIgh
         uU6mPZueBrUOKZ//h6fi5tYDH4SGsDo1UL/NNZNMREl2HdkoHDdiUt1VQ/1Kezl8lBlR
         CdfVsH4tdv6pY10hOEKxF/nrDmxl124hQdVPuM/kbbt+T7Q/duUvWI3ophh4X62Iy8KV
         fGjF6Zo1k+MzO+FXegxvM8JmmiQcMqy2E5HiSM887GildskvRtKjBFH0oTlMQ1UtbAj+
         6KyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766037967; x=1766642767;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MjYhNKTKp8oFFQ8K5luAyAyOx4SBt2zoxQ2yTKlGYwg=;
        b=VS6XdTzbyNrwlmBF/Tg6bo1lBGTLQwpv0RV9fj59Px5jM+GbO4RxoiLppbdVv1irW+
         VqvqljMb+Evv/3co7oZnBf+VueFVwXcXwDcxfHfEJ0A4wvFXIoeQ9hKdd3SfN5v735+5
         BIZ8ubSBK/DTViQwO32gZEfF4R2TBvsOVqFrC5NfRf7j0DDBm7RO95EY7KX5LjabgPSQ
         e+r3h74K+2PM1l/KM337gj/5ukdCKwlYQDso3PODZvrMlIWgFN/4k0kAAQAU6xV6SZH9
         SmFiFYZPMkRVCGt+Pto4z73lY7w4d6NHoU6BKlF8Xm4F7/BYG65wOGCsXZc6d5Km2DJN
         QTeA==
X-Forwarded-Encrypted: i=1; AJvYcCXTIVkyK1lWpr/Hv8na24hNH+qe0KtN6kTkONbCZYlMvmVHXgzy6MtL2dt7/fPW/I+xE28O84eASto=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNWAj1BcZEvbYayd8PVgQ5S+4/oue2fk1+7OwaQ6bLkyq1/iQe
	mmsX9jfOpp5r3NBpAX9pQvRgvgfzgYcKUGs/7ETa0HOhlfimbj+VnYBj2jVwhVzhY4V4Jf9+fin
	F34Zg4Q1T4tXTCWpjo27RqlOWtf9SQTgOKtS39x5iBvvgYTWlkoK2Q+7ZwKOPGdw=
X-Gm-Gg: AY/fxX6oicyNxEn7mGgtnoOEPn91ctNsnFPdeKH29Zj/6qVGo4YCOoEurwxs4QaeZyo
	WsLf3J86tPGckaAOuwCDeokhIBCOm3NhGBTj4D23i6yYkqwuwF/70lU646W1xhq48KaQF0OZ9d1
	Lx86eeO2K6CRltGxzFIUh1J9YvZmOU+JumCCNyH2kNbpiov4Zw3GjXJcaYJSwV/srjqkzbrq42I
	YlCJu3zxDh54j6pprDa1JinLwCe5F/8rF8n5q0ugB7h+4cCwWRj1vwBl6l3T4VIG5AETmWQmXgj
	eMNZUe3uDa79Kr+wkJIj9KBzFtgOBDwnFgVdZdI7vUDZx6NdchnCx1xZaIbjGRuyxoibUGULo8b
	T9M8lzFKEVE4=
X-Received: by 2002:a17:903:1a2b:b0:297:e3c4:b2b0 with SMTP id d9443c01a7336-29f244aa9e9mr223285745ad.54.1766037966508;
        Wed, 17 Dec 2025 22:06:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXtU/Jq12UVhDJn8i4aPL9g1mtUoYuWCktraOpSdZBnZjjtbDml3pnPWFQ9a/qS+c2uVRDxg==
X-Received: by 2002:a17:903:1a2b:b0:297:e3c4:b2b0 with SMTP id d9443c01a7336-29f244aa9e9mr223285465ad.54.1766037965984;
        Wed, 17 Dec 2025 22:06:05 -0800 (PST)
Received: from [192.168.1.102] ([117.193.213.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe13d853a9sm1307489b3a.42.2025.12.17.22.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 22:06:05 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Yue Wang <yue.wang@Amlogic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linnaea Lavia <linnaea-von-lavia@live.com>,
        FUKAUMI Naoki <naoki@radxa.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        stable@vger.kernel.org
In-Reply-To: <20251103221930.1831376-1-helgaas@kernel.org>
References: <20251103221930.1831376-1-helgaas@kernel.org>
Subject: Re: [PATCH] PCI: meson: Remove meson_pcie_link_up() timeout,
 message, speed check
Message-Id: <176603796183.17581.9416209133990924154.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 11:36:01 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: W9edA3U3KE2w8F47IwPMbOf20cu8w0ky
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA0OCBTYWx0ZWRfX146AviLm/KMQ
 /g0gM0xPU5/MdaJYm7Q4HBXM1+r73PSlAA1MmWfqOw8NlcWeDjQVhXFoWNn4nM4Zk7nkXc8KdCP
 0MPfcHLxpQSb+AJxat/gwyNAhqyHAZnurqfM9359IimUM69wFMAVnD8/7YjVFzh0cFL47b0wNr3
 tJVngYbzIS/wLQkbbu++MN5h25MNaeix6fa4dMzg7pAcUxY2Belay0C6DIafS41+C126i6a+Xqz
 6WX1Bl9OirMvfl7OOoaGEwN1kJCR/uEDehvYqOjHN+xDnSCW+mP4+xkSVGPYQrte9ZZJbEMcnZn
 N5VoO28eyDC0gYd2tUCoORz93ou37VM/rTTopuzf4RKgDw+WL1wbJcutlF5yDQkQEmM9+Bpmxpc
 ciD1hUdKg4QKqrsS/qP/ZMKwruIq+Q==
X-Authority-Analysis: v=2.4 cv=TZebdBQh c=1 sm=1 tr=0 ts=694399cf cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=PLOdWElDzbaVVj/XHNhp9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=zrTfyjHbw98hyAFYeIwA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: W9edA3U3KE2w8F47IwPMbOf20cu8w0ky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180048


On Mon, 03 Nov 2025 16:19:26 -0600, Bjorn Helgaas wrote:
> Previously meson_pcie_link_up() only returned true if the link was in the
> L0 state.  This was incorrect because hardware autonomously manages
> transitions between L0, L0s, and L1 while both components on the link stay
> in D0.  Those states should all be treated as "link is active".
> 
> Returning false when the device was in L0s or L1 broke config accesses
> because dw_pcie_other_conf_map_bus() fails if the link is down, which
> caused errors like this:
> 
> [...]

Applied, thanks!

[1/1] PCI: meson: Remove meson_pcie_link_up() timeout, message, speed check
      commit: 11647fc772e977c981259a63c4a2b7e2c312ea22

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


