Return-Path: <linux-pci+bounces-32397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5B7B08DCC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 15:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6638C582579
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 13:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFB52DA756;
	Thu, 17 Jul 2025 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LIIXC3wC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155882D9EF9
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752757270; cv=none; b=VCAwdE2qDRgBWp9T/MB5sWDmeBBTIJ8CCzFdM+VwediHF6/xpKZQI9GVPRIrlEWt4jJ8/7qQ3w883Zi9Xfvq0PqWiq1j1F54kEg00ZZUtv15pd9FBV+aXFmx9ec/ko8rDBO4wklboAwNdi5AAj5/7/yLbI7VYBKpyRMsZxy6whk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752757270; c=relaxed/simple;
	bh=vCd4NQszFCL+6SR8GnfbGLcZko3d35aaKRkLZLDDY3I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f5UO64J/6BvC3BgKhAn2Do2uJYv+O+NlA49hTD+K3bk4CSLDZreqD1xH6P91XkWklZIvPLSTYGn/dG2HoDR+/8t9A0Gp7dRz+/OfA5u8z7jpAEA4TuH5Cm1YbnGD9pjk/CkfC3dmgXz/4OAuY6yIoSf6RCVQxTQV7E4EvW+KSLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LIIXC3wC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCRLVn015727
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 13:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PFJBplyOVOVqVS5tVt6ls995i5hPEOXns8yrQXCIRDU=; b=LIIXC3wC7QRrPWcx
	IUNe9MczC3qCVXxrJXlHKb9xjnh5S8tkjxitUKgiJz6PpVuZATdtC6exphyLK54x
	3cE/Q0bbjV/aa3C5hru+eLKgg75j15vByV0S/mGZxDwiPZPKs5GvFzoswxyJ59pG
	ZWpMGk8OPdaR3TVWK1BhiOEzQWTG2zjThw0m/Q9pbNv7BPqXJqgWsOup7HdJRrka
	X+HWg6th4LNmYujUqNT5/1/biFmsCan6XMwdER0wsu+B1Rb6x3J91glMJ5nf3XRt
	C+ad4+4TFjhuYtyU2bai+jt/bK6jJ52ImixlwWKq9At+/1XuGvEgWAWUImu9dahu
	kVqGKQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dytnys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 13:01:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-234f1acc707so10163685ad.3
        for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 06:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752757267; x=1753362067;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFJBplyOVOVqVS5tVt6ls995i5hPEOXns8yrQXCIRDU=;
        b=M7pB2DrzHbiHDCTFupe3L5xc7DYmtSqksQz4P7qI8AsOz5fWS/gnjqg4MJ9mdl+qkq
         BCZKFNWHKakHMcNbC3UWEDcQbMS8yehzUT/JNi4EnCmrCYuqOGys5jNaq9w3D3JEOXwm
         5jM7NmwjrZJzz9fdW4WzJ7GyjcghYMntTp+CV1jSr/d4uU/ZW+hTCvbP5dpqe5WS5Fp0
         JVL2Ovhs0yAm56p4tSrmy5Ps4ApVZdFUwnPavLe5AF3b4gtJNElXva7SywogOq6hkeI2
         ZEJJv154yLiJhd544vEsnnBTaxOQvFCdKo4KvR+lrJfgh9khbR5YijIVjr7ALMN/gIhg
         Dakg==
X-Gm-Message-State: AOJu0YyL0EPL/IuAK8xuILK/uo6A2kfnhfnx8caOc4QGMdk2E9YbPEgm
	FgGFbut3O1UpiTWcIVOnCz5JYZST+cZeTbYD5MjKwapXnyI2GGH/BEGJUYISe6gLrITtfbuMoHG
	y/X8DucvBh00zWSQ9y557OGpEwGOxgCKULxN5zqouLZNrRB4HnmxyHfTkxrbQOlY=
X-Gm-Gg: ASbGncuGAqxUbqNOP9nYRwqOcE8iAHrsM1MBYmouFzozuKWpMKW4HbJ8Fp1Wl2ucOgl
	CGWMicLfprLzvyWJerK23ES1mZDHOeTUWozjn4FvYXf9Lws4xnhsDxChk/SSjrn4uC6agWs9EEo
	Z6xHxLlvZpDb8wWohcJJBqK0ZALKoImIuF1V27Q8FvmYZiX5Eddp7SYEcjjzrthwOVIr9o/sNQi
	m+/SIprzmfoSfR9tPcl9ugDJY2BB7D6MjyNolPFsS1rn9Kxq+qb3iM/wp1KtWhtg/wLZFhNnCRW
	TTTEMxuoG8BT8ntlRPROXrjGS4ZEIK0Opfo+
X-Received: by 2002:a17:902:f68d:b0:235:1962:1bf4 with SMTP id d9443c01a7336-23e256b7428mr85155105ad.14.1752757266885;
        Thu, 17 Jul 2025 06:01:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbS0LDQKlOsPFw7HKcHFgsvu6B+PBbBhY5qMGfKyMEG7qzr7920aAD1g7Ty4QSDMZORwk6Mg==
X-Received: by 2002:a17:902:f68d:b0:235:1962:1bf4 with SMTP id d9443c01a7336-23e256b7428mr85154665ad.14.1752757266418;
        Thu, 17 Jul 2025 06:01:06 -0700 (PDT)
Received: from [192.168.1.17] ([120.60.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42847casm147179855ad.14.2025.07.17.06.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:01:06 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250710180843.2971667-1-robh@kernel.org>
References: <20250710180843.2971667-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: Remove 83xx-512x-pci.txt
Message-Id: <175275726329.8776.14270280128728418652.b4-ty@kernel.org>
Date: Thu, 17 Jul 2025 18:31:03 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: rHYUDpjpXoOfyJPdvtJhptVc8xOWUcwL
X-Authority-Analysis: v=2.4 cv=RtXFLDmK c=1 sm=1 tr=0 ts=6878f414 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=A4mJK6/VAfRUM2WLv3bxlg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=uwvIQ4CO5uxB_bX_CJYA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExNCBTYWx0ZWRfXwGWos5X/GjST
 hd6bKBbYYED6PL8oJsG+M0GTLT9JEZRAQtkiilgx5Jaoq/J8sgAKPKZ6bKhbkghvgBtragDL7rk
 Z9ZW5/Kbq+/2KzrgBiT//7jph9PuXudPxMWgbWlJIuc4g4+9yQuhK/kumd2Yd+tyUigDBG9AhWK
 k6VXGYoIcVntXh0avygIrxRGw/JUNGNTxAh+xMKMhmAqTYLrx6tLBk70TokwKeV4qsL7LVPzKhe
 9r7j8VuBf8Cxqr7mApGbDaUxYPRRwzZYLqfJ+BfzI/29tFwvHnZP2Kop3lGGITcDQQsRYqwPS8H
 jKqmqWdyNfBxkTxixoXZaLNiEKw/9ayCgrfh8pLsNzwB6MToSJmM1a79s9Xw8X48cZzkdrxFY/u
 0Z5X5wxfWtThJv7nP3cci6L8xJWobNBuqHYFAIVyA8rMuoPI4pvFYdQRb5qMYFV1AFIKtLpg
X-Proofpoint-GUID: rHYUDpjpXoOfyJPdvtJhptVc8xOWUcwL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=823
 priorityscore=1501 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170114


On Thu, 10 Jul 2025 13:08:42 -0500, Rob Herring (Arm) wrote:
> This binding is already covered by fsl,mpc8xxx-pci.yaml schema. While
> the MPC512x is mentioned here, its compatible strings aren't actually
> documented and remain that way.
> 
> 

Applied, thanks!

[1/1] dt-bindings: PCI: Remove 83xx-512x-pci.txt
      commit: 873eb218b39302654fca8251634da8f25d30c29d

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


