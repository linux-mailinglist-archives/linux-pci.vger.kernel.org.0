Return-Path: <linux-pci+bounces-32395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBB1B08DC6
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 15:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A2E1C2720B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 13:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED36B2D77FA;
	Thu, 17 Jul 2025 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FRtvwMoq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AAA2D94BC
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752757262; cv=none; b=lniu4IQT8MflANRkORbJpF+UmcZHGvSeChynBWMQkEJTPP5l0Yvjs8a45sMBLZWUO4cpt71lczMeIOz6ncV7OHJpsE3BzT0d/fLxvqRlGSbR7IgK7bAdTK7sq+BXRUtCIOLye16kVANqhBjC/NPGZTFd9GeV+OluAzVqGKu0vxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752757262; c=relaxed/simple;
	bh=2FDz199gARCxPZHvHvQq+5S1+U+85yaw+86rSG7u2hc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SH5IsAYK6Lumhv2tz5LeMSPO59LuWlsBIgCZAWqwmGecV5KAVxVHhuCg7iNxGnrINVfty1Q5J2Ov7hYnrVWLgZ7tzvOaZUch4aknAIoz4e8qazXXSktM7rtiL8Ele8k9liB7pbxFOKlQyGzOzUzASN0NCVNInyOAcJ7Ulyi6wgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FRtvwMoq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBjQ73002924
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 13:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hbhmXWPJY7pmHOFjqW3eX1bvP5tBeooNN1aFAxvXwOE=; b=FRtvwMoq0YR9Df2o
	xCEBfbJSCRwfBo1nRxKFf/v3wP2xzG6fKNUJkhaTxkh7vL0Q5ZuPF8YK8CzAvO2K
	qmDihKXlkXESsnvcFu0Ng7fYMHWLPhvV8GyI375FgPXsTogi2JgNov+c/4oXVZE4
	5fjv3CBAL33uHH+t4B4BrZVLgve90o4bB3hWMUzWJtItEHHogFEAn1FF9VMonUFo
	b4KvVTmpXxxfvctqxXfHw8RPXvCjsJSq6KsZXGhngPiT4hWOVwMcs8AggIInntqP
	uaWG2BQaOHMF78iByhdOrPqPKdJkMUQZ2zff6kCI8u0ESX6O6T8WPIyIXws6NNy8
	bmek1Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xsuksh5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 13:01:00 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31cb5c75e00so568244a91.0
        for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 06:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752757260; x=1753362060;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbhmXWPJY7pmHOFjqW3eX1bvP5tBeooNN1aFAxvXwOE=;
        b=PgC8T0dUjNYRkZ1Y/+bKLfvDiH1Atz/lMOJ0AaQNsmpqqtdNVwS15sYqp4SXIkfEzA
         nc6TVzIwoYowl4FnKEh9HLyDUA+9r5kKIzxCkkvAPxwNoZxsTgc6hwsNqASeJB7Quuqk
         po4kyOCgsqpkWQUI5FlFrrBoT+qTvaaapgIZFACvZBmMMZ2ta4jyhIU+qFUvdBDdn+Sc
         Wl++Emxu/JWak5zMCHhOelvGGBf3FXoum+8KS1fN5pYp+Q0/LVb35Jb3D4vL/jzY6fT/
         uywjv5D1x5jkQKYg0NxJ2qwRc06G7SdhAhxaxhS63ElMAk0Y/mGNaomOEraIRn4huw/I
         tWsQ==
X-Gm-Message-State: AOJu0YzUwWL8rBdKZKMy30BBGEL15Nrufo/zc2hYSdxjjUejlAZ9Yy0X
	ZUh5VCyUbq/Nj+riq0pqGelhit8r91ZRPOt6PBDG1YRkBdvsLjG6TsqLVC67SuKrnMySnRL9bLS
	GHFWZ3RmXHoCyhrr+jKup7kSge8M0NZsHt+KLnMplnTPxQFVfna7MrPH+erwswGY=
X-Gm-Gg: ASbGncvoNqeeb/BSW20VGLKiYaOgTQBGr+qQyo2c3I8f3xvd9W+riUai3v41tTqbDHa
	f/8wp3gTvX+O4csmxf98uwtE91LclPjLR/Pu6hlIwNxk9uyZ7UNmWaV5BtPtDnwiS2ZETJafJ2Q
	84SuV2/Hj5Lh0sbgQvyA+EGtT5Mmxeh3BoxGBceyXs4fTvJr/1m2BYtkYw7kEMtzn6Ps0ls5ORi
	+uJX2xFK91VTM9kKfMaLUrmNk+qj3dVhHKzOGZiJ5sr+T+OqLo6j9jyWSefkRfASuFNijwISy3o
	3Dtit6KCu8dcIbkTqt/RRw5hTiDtlrlGG5CJ
X-Received: by 2002:a17:90b:4d8d:b0:30e:6a9d:d78b with SMTP id 98e67ed59e1d1-31caeb969efmr4073952a91.12.1752757259480;
        Thu, 17 Jul 2025 06:00:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5PLDck2EGokNw2/kOyuLUXwXYjEIGyQ0OoopjlHKyIHHS+CdhEZJonc7VdXmvkZ+TmDh1Iw==
X-Received: by 2002:a17:90b:4d8d:b0:30e:6a9d:d78b with SMTP id 98e67ed59e1d1-31caeb969efmr4073883a91.12.1752757258849;
        Thu, 17 Jul 2025 06:00:58 -0700 (PDT)
Received: from [192.168.1.17] ([120.60.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42847casm147179855ad.14.2025.07.17.06.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:00:58 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250710180811.2970846-1-robh@kernel.org>
References: <20250710180811.2970846-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: Convert marvell,armada-3700-pcie to
 DT schema
Message-Id: <175275725510.8776.12544993424568474887.b4-ty@kernel.org>
Date: Thu, 17 Jul 2025 18:30:55 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: YYEfsK1eXPwLoYgYcIPCMNyzw_XFjVqv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExNCBTYWx0ZWRfX0U2f5QZ0DnCP
 8o3RAFJpeOcUbu1WliETY+omg/e26+YFfCI8eb5/JmHxRWQ7ev6u1fjqwRFui5N9iXRDccqRsig
 amm5K6djbprdQSalfxLLkSSz9H+4kcmSqnshOlzyEWWYBCUBDcH8i5xvddbxXBYG5bjjxdENEGi
 rmAOKK6bEAx9gyJRrajlWwF0bbGpns6UUuU3lflOFwQ6KCwjFs7w7mA29sJZVID6YOcQbQrCIc/
 ETLwyu0jZ8a5PSnsjo80evNlZR1Bpw2XileEsnBG75vmUAxb/NrU6qoEyJX3yvGoVZFx2KMQZgP
 nNyuuHHTyZ+whjRXNHLRzmC7oFmY5F/0vbKu4eXZG+qR3b07svjgSasqPpL5ILYo7lL1+S7Xa0w
 335YXP5xVNET5Fg9xpPa5WNSMjVPrE7WilCJ29RH6/hEBENbtOTUp/0qj8z/3XPD5FyxhXXF
X-Proofpoint-GUID: YYEfsK1eXPwLoYgYcIPCMNyzw_XFjVqv
X-Authority-Analysis: v=2.4 cv=JJk7s9Kb c=1 sm=1 tr=0 ts=6878f40c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=A4mJK6/VAfRUM2WLv3bxlg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=ZvBNaTAgAf9eIsPa14YA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxlogscore=785 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170114


On Thu, 10 Jul 2025 13:08:05 -0500, Rob Herring (Arm) wrote:
> Convert the Marvell Armada 3700 PCIe binding to DT schema format.
> 
> The 'clocks' property was missing and has been added.
> 
> 

Applied, thanks!

[1/1] dt-bindings: PCI: Convert marvell,armada-3700-pcie to DT schema
      commit: 7d372e2a37af6e02a643f0be80020b05d29b45cc

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


