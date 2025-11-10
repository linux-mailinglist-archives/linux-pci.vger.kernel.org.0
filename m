Return-Path: <linux-pci+bounces-40672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6E8C4522E
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 07:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AAA73346AA7
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 06:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B772E92B0;
	Mon, 10 Nov 2025 06:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gnYYw6cp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Byjgce0l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202CB2E8B95
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 06:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757777; cv=none; b=bpF2OdUuZ+agrUqbHLZ2YRrvsNftC8eGR+MMdicYkuPel6VEg9vkTueCF5zEOktmsaPgG7PTusUh9S8Q9lbUPpUs98pyGff1K1gTjVL81E3ZhMVJflsm3Drt+iW3g4HFgDnbN4UAsf0c8s6JJomTa95zV42uXfdczJ8ptz3bHpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757777; c=relaxed/simple;
	bh=V+DIvAVczDzOt/Tkg6whkzz5HQVAibDy8MvhqHSfRCA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gkw+xAOTcsH5PQmLLgCa11ifXthUU2Ni5OqBfhtZab4mOJh6CgcBWkBmnqDy0UB6pfgkZ6OaEZNbcnMyqNgVqX0RzDuYLK23un6mlxsd99h3HWoTb4k6BCKVwLEpjGkNqCvPKgJ9yPrrCwQtuCckVtEYTvZYLNyppb5mR5FtHHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gnYYw6cp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Byjgce0l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9MTx4P1621055
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 06:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bPP/EyjT2wII9bMHLU4QX3es3K/LqGTkzbqM6Papzbs=; b=gnYYw6cpx0Fjen+H
	5qy7EDBTI5wzHU79FunFy8v2oOvdbsBpNa+xlqa4ZQ3vRMfqCy/4PmHkS4oQ7xf7
	lNlZl4MIrrQNECJ91RW5IJO/EINtjC9NMot89W9MtfyC26BvVzFauBh5XzIOYTWb
	7snJMy0+nVwcETJ95QvtfYDiWqjyxXnufN6B+6vf6B4kspbvPUbSTVXcQH0CJGmW
	8UElZWBfup89uCQp+lQpx5kgls3xDWjN0LgXa+ZNq6i21HcVxq5Tgoa0wtKsu/yX
	KJwtHAYxU6pi9l+0+ANMArqP/odd1rOG1B5WvVcBkkCRbkYg6l+WXuz/zESO5FAk
	nN15SA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xu9undy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 06:56:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34378c914b4so1639111a91.1
        for <linux-pci@vger.kernel.org>; Sun, 09 Nov 2025 22:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762757775; x=1763362575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPP/EyjT2wII9bMHLU4QX3es3K/LqGTkzbqM6Papzbs=;
        b=Byjgce0lWBZv112berjZMKlCBZ8K5AiTTEdS8ZCmxlt+pEWHs/xQ5rAoxzvvfrhxOp
         00K+Idtfeg898CWXcKD9XxI8c1rN99EUqdLZtit+qiTduvHIGGINatDD1jXtQmct12cX
         UOv70MQCZ6/1T2uH2+qYWAGSnoFhg3kRfloK+qnVcOzdbKfdH8M71uhinW4G3MhZpfaQ
         VAGN37BTKIKB8ji4E3jDIxLHDfZNrlsrAzqqZmVvjXDCMxxCnFFxW5oeh1BGHnECH69t
         RwG96WFMFgudzh9r6HznvLaFpgpWWUfxGR6UGSYw24qgYJWds6gy6E31zqiTiRlG4iDO
         nnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762757775; x=1763362575;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bPP/EyjT2wII9bMHLU4QX3es3K/LqGTkzbqM6Papzbs=;
        b=uq5IHC5D+IbQLJ5dj2YOjcRwysuEX3QcNA27h6nac1G6710QttlE6Y+xmWo760bhkN
         3NOtYM+qD8aMoAxxkExb+2CZooRnRMuO2qmIFYRK4CNZSRwSlmdHlyF80RoCfbpIglce
         ofe6xA4T8DXLlf0iVQnybE3bhLIp2Kil1KG/vECynsS4EGodeA5sZkssciADbKOBiIpP
         l3DqRQ/fx8rciJ9ev/QWcFWF/XavdWn3kb2d/LQXAwN11MrT203q0fMUp+ZYnzQK9Gv+
         BPpJFL3DwDav9xTqlZlxFfSyDUykf7vmr9u9kDjFXHPnTzJdcmWvqG4xOC+dWH5Ogo0d
         zZMQ==
X-Gm-Message-State: AOJu0YzMYd9obbZKCHttpTIvXj9EipltjdVNPO7qdnu4BdEit2SXGg0U
	q6G7S0/ZnuROvmTRLuEdQDy+1Op5VvqDwarF+nm3eDqKZh6QSrQpY9Vfb61tYpekzj4dQcWpnQL
	tGiK/07B5kaxUUt92/XtqDRA69uTZz8+daJimKGKmCXin+4GqNkmmqI7s8c6eI9Y=
X-Gm-Gg: ASbGncsZnezSK3sPQLcp0xBY0rj2LCNazChQZsXUgDIBYKTgCNy7nmo9K3K63Arwhnv
	954qLftOk5nQyrXw64Nun4ZctLIYV19++j4Xul0jRDUR3vrp9E30ABAjcT8V9N+bWM4s5wxliaZ
	qLLN8zPzhJMFxhW3xiYK3EHiVEqA802NWbilurahvhGvl5Uwa6p6uQVANG9BZ/tqbw6nXGN/iWG
	eMmOSHRl2kXqFQz8c3/sC7lJo5S8di5+Ct1cDj1TaBDn4gmpRwaBoqvuytV73kh9v1gRYk+1gCQ
	IafaZm8corYo00qZroN++iC+YYExRZjcO1orPgrRB0TUWKFGgEbvJtVgpxp9q991PJmBSCDFV26
	Y
X-Received: by 2002:a17:90b:5710:b0:32e:5d87:8abc with SMTP id 98e67ed59e1d1-3436cd0f1f0mr10125486a91.36.1762757774579;
        Sun, 09 Nov 2025 22:56:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYMFCEW+VsM+etUbmQ/zHKtVvlMdywCxJgC9tLLnLF4IVTMN7CmfPAWy4Wy9Uex9snC5RxDQ==
X-Received: by 2002:a17:90b:5710:b0:32e:5d87:8abc with SMTP id 98e67ed59e1d1-3436cd0f1f0mr10125465a91.36.1762757774113;
        Sun, 09 Nov 2025 22:56:14 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:884c:92ad:3fef:1d6a:49a7:308b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a696dfe9sm16705022a91.10.2025.11.09.22.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 22:56:13 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Hanjie Lin <hanjie.lin@amlogic.com>, Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, stable+noautosel@kernel.org,
        stable@vger.kernel.org, Linnaea Lavia <linnaea-von-lavia@live.com>
In-Reply-To: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
References: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
Subject: Re: (subset) [PATCH RESEND 0/3] PCI: meson: Fix the parsing of DBI
 region
Message-Id: <176275776139.8821.9724702125495761876.b4-ty@kernel.org>
Date: Mon, 10 Nov 2025 12:26:01 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: j7uWuJxdJsemv1R8V5uNJF_6XTRRSBc1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA1OSBTYWx0ZWRfX+73zGtzpiK5v
 BbupL+sNXlbPBFKtqlfi5lzUxV/EJWDX/8GPT8hbWDHHLRuWTtUntGxjSqgQ/R4oeQEMEiNDVpt
 Q3wGo6iPFJxGq6H3HBDzqr6xM/7Fgfo2b8fejaFT/6PY+tCmc6+WWd47piU1pHVnE9VW/gtvuXt
 RpLwnp50D0/jwHd2dRhdOXub9u1bmGbr8s0jW2kUgQfROeGjj0BT6W3srK051IxruJv2cbdw6mM
 N8uxRs+nYZ/4d+lT1g5fQP9TUkcZihHHANvMpNshvG+Z8DX2rQtO2jrZ1HADmgDs1OB4ABl9LXf
 LkwaZzszTEu7cK+Uvu/+v/3EyaJdsemgs/0oWrj9l1SOmcKFt6jjzfkzjNIkfbV6L+Ydwm0VKmQ
 rlWkWWYyDoUIO5equlGJ3pQ0vZv3Lw==
X-Authority-Analysis: v=2.4 cv=ZPXaWH7b c=1 sm=1 tr=0 ts=69118c8f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=F-EKWGjZHOx0vckpNnAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: j7uWuJxdJsemv1R8V5uNJF_6XTRRSBc1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100059


On Sat, 01 Nov 2025 09:59:39 +0530, Manivannan Sadhasivam wrote:
> This compile tested only series aims to fix the DBI parsing issue repored in
> [1]. The issue stems from the fact that the DT and binding described 'dbi'
> region as 'elbi' from the start.
> 
> Now, both binding and DTs are fixed and the driver is reworked to work with both
> old and new DTs.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: PCI: amlogic: Fix the register name of the DBI region
      commit: 4813dea9e272ba0a57c50b8d51d440dd8e3ccdd7
[3/3] PCI: meson: Fix parsing the DBI register region
      commit: eff0306b109f2d611e44f0155b0324f6cfec3ef4

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


