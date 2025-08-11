Return-Path: <linux-pci+bounces-33714-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B85C4B20605
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 12:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B278B188FF06
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 10:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFC324468C;
	Mon, 11 Aug 2025 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UCTMxnrd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEAD2253A7
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909183; cv=none; b=iPH1JF9w8EEvgh195qY9eyD4y7UlUSqGi9ACCKxmpLOzISJ2hHgdjeJ6gllm84rh6f9KbnOf9+aNzjzseSeaY507DRQYwVNvkzTInlgXZdoB/5pE6Mxqg2MzzKtZQ6Lyphc3cYVyB5y8xaWyAMQ62gnVZ7OZBb3chP4QqyqGm3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909183; c=relaxed/simple;
	bh=hIpIhI+Dq782DmocD1dRgsqRHVmepVB9EO1vCQZPW14=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A5c6oaqo/i3CzdZ6Y2MXV/h3nNLUKlyDauVqeg+9naDcprA3HoH6HR6v6strNclEY9D2mavhSzZdkV4LiAuQwcsIHAhK9euUKfq0g6h38tyG++awpikESHEhv8w8WhuVu+yK38jaSDJiJP1isAN7W7GJXdO4yfeZU2MJjvSUVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UCTMxnrd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dKNM018331
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 10:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f8htCJxgK9LamUpOqKUewYZZ+4H90QWTRJft0U76ZI4=; b=UCTMxnrd6/16AUhy
	XLcrUIybjNmdTrEQtLxEjTdW4kVnAemCiLZq1Mb4vvfvnAmsCNlcAJQG3gQSUDMs
	IOSmdOxRgDiuVv7zveTixoNo/0Qaz5OKOCf5D6/jESnWnMLkbMBJP/eupYp7dpzJ
	/TtzQn2IELXKMB3PbjaKubG6Ii02IgISs8x/crwXGbZ87WBvK9EUkMlqMBFV1o4L
	zV05exbfyrflL0Cs9+jwTuCnT4czWbvzB40Kvu/l/EWqR1yw6kV5pSSUu2bDq0Uh
	8aSFkWOFNUA+63BXErWgWMMawYjQ9uVeN7u1LlZwIcx+TDfyQkNSF8TzMvTeut4j
	fdpHfg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g41eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 10:46:21 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76be0be9ee1so4306186b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 03:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754909181; x=1755513981;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8htCJxgK9LamUpOqKUewYZZ+4H90QWTRJft0U76ZI4=;
        b=LlsYnPPvGmYCLSN1QucrcYuqhxHa961lCrtGQwqemmHl/VQ7UAqVRkpoU+r46k1X0z
         nEFJ0lCnS1XwczLRPu4k2kw8qr8DBzS9yzEeTLMCsZchTyGnateFYGSUCC5ghuWXiwnS
         ubd2p8Ha2mB3c5z4sHtOVIAk9KKnYgJc7+sG1vImof3/6Ipjd5h381oF5cysp2pefgV+
         /S+TDIklYlaQ24bNXQvUmaoNSH/pE86BbReY+pr6md624BAPFzmRUpQjwAUi1Qj/Z0+B
         PB5HTqby3aY/9WtHEhoWLDbfeN7Q/57qU1S5ODX3W0MQ3NOQ4l/3BNS4W6S+v1wc0UZG
         Mw0A==
X-Forwarded-Encrypted: i=1; AJvYcCXGA2NhZCbbBfhIDjMiAbUPCXRdiNDsRykRPuDiUdtiJV/1+cJuJ3pGc2YZwG5Gakh17QkqKpU9vTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2XcjwU2zhhoNslVD8+4x2DAw0TZu9soQTIH5I/HmwEKX8LS+N
	69P1YeP+HqY91A36UCcN7yZr/0GeIci2hr8aI2e4c+DywzXrMIxpp4StV9Md91GbW2P5S5G6DeH
	2D/i/3raYskzpPwyIMJxAUMiPUCqBP3ptpBZqngMEDlM5669kK0ODn9p78VExAkA=
X-Gm-Gg: ASbGnct7x38aKGJ4EMPUw//Te97MD2PEWRnoFZuoPwjH0or805TBjHfpWpwKWSBZ3VL
	5zDDi/VtFW4FE448Xh8Tx6zYWK44cVyCXP+FXlytQxGAwtqNt4O12tJuw2VUUEjPCzfsScyIkAw
	lQoKspyVEzYD6jgASpria3rctede5wYXy5vtDX4+G2WIFd+TW24BuJp+auijNmjxpwaAY7LChzV
	6uNMOR15kUbp2ytfW3SUBLjW91FFz7yP27DD82ULrVw7+9d7zi1V6cFGym7FqYcLhYpb5lgcuWe
	0DVqtGahc+715Sai2ej3ibVfjTaXBg3Doi6nj3hs
X-Received: by 2002:a05:6a00:b54:b0:746:27fc:fea9 with SMTP id d2e1a72fcca58-76c46199f56mr16736324b3a.11.1754909180974;
        Mon, 11 Aug 2025 03:46:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpgDICoR0/7ZRQgRFsc5NvAq3BwKQx1UQi1crXpDDjlFgdgbPP/mebGYu7Qi81XEuYnSVitw==
X-Received: by 2002:a05:6a00:b54:b0:746:27fc:fea9 with SMTP id d2e1a72fcca58-76c46199f56mr16736282b3a.11.1754909180581;
        Mon, 11 Aug 2025 03:46:20 -0700 (PDT)
Received: from [192.168.68.106] ([36.255.17.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8960dsm26421523b3a.34.2025.08.11.03.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:46:20 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "Rob Herring (Arm)" <robh@kernel.org>
Cc: Ray Jui <ray.jui@broadcom.com>, Scott Branden <scott.branden@broadcom.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250801200728.3252036-2-robh@kernel.org>
References: <20250801200728.3252036-2-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: Add missing "#address-cells" to
 interrupt controllers
Message-Id: <175490917553.10504.5537940155167451079.b4-ty@kernel.org>
Date: Mon, 11 Aug 2025 16:16:15 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=6899c9fe cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=tivzXH558BYE5qsfyb1zSA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=PmVlpWcjQJIy8_mLsCIA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX/r5DB9lk0HNV
 F61gSGTnA5VBI4c0xgZd2LBpLBdiiR7qluk1VPv6e9ghjlk89BxULGVPR63YHyee+orFqdOeYgX
 x2SXMFPIvNxFYyhyvPWz0CYJNW9Lx95SBUS4zsC/poQLqTKJzVhJ2/qaFU9mj7wqlDvJerjksUj
 FDf54nXGoDqMsEWq/JVskqpsnFRFCefExhzxvCMI5OjCMcIqrk3ztmVqqoIsjZB8lKBh2HUWTmX
 uVu3L2wDjLVbsshwRQztbKbXxlG60NSRql/XmDKZaWvkLNRJJEyu765J5Z1NmKC9nDoFJX4Ss1r
 rEcgceDkcgBsbMJRh5aAQw87pz0y0pDq9aMeZrbjU/PD7kRZyoV2pkNUMo2w5b0tvpmPExpI0gP
 CYHuder7
X-Proofpoint-GUID: -dJHThJxUNFhiiP1ZrIWSP4ROxZaCPMP
X-Proofpoint-ORIG-GUID: -dJHThJxUNFhiiP1ZrIWSP4ROxZaCPMP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031


On Fri, 01 Aug 2025 15:07:27 -0500, Rob Herring (Arm) wrote:
> An interrupt-controller node which is the parent provider for
> "interrupt-map" needs an "#address-cells" property. This fixes
> "interrupt_map" warnings in new dtc.
> 
> 

Applied, thanks!

[1/1] dt-bindings: PCI: Add missing "#address-cells" to interrupt controllers
      commit: ddb81c5c911227f0c2ef4cc94a106ebfb3cb2d56

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


