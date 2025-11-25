Return-Path: <linux-pci+bounces-42007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F4AC83692
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 06:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CB694E2088
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 05:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66111E505;
	Tue, 25 Nov 2025 05:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GybhLeGN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EYRDbI/2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5363E2737FC
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 05:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764049969; cv=none; b=YZ/Vv7pD/a1oHu8rrwFy56jKedhv7PBdD5gXaUKW3BFNus6PaaWjVwjbClxcNZJ/GkliygRqiKv+lHh/TQMtRFcGtN8Y4N8I4Wlg/GtZ+rOT8GXl3PkwLOAMUIFkWVez0/9k97jclCXZY8aN2ZsSypDd4o8SkArs0Ofn7JEsCOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764049969; c=relaxed/simple;
	bh=ZIIzYnv4Q5BekNkR9egX4PMB0Q4mnckLxIhWYuoDy7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dYoXQTIjXM8dsx/e5hDZWEdOmCTm/Ciy0G/bsHk1JtEC9c3vhvx1M9o3yyKFUxEW9Yp9qMY7Pf+5zLtUwUPSn+He4eiyHGNCmrqc2bUhE7fyMqv6vwASThxGAtesVol0vxLkruMhTNY3hQVdyHODn+UHEEevqhJn2Ln2MESo0nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GybhLeGN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EYRDbI/2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP2gkYS1688365
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 05:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	404nClmNRmrTW1zYFRsUIzncgU8WOWDCjaNO2hfY0lo=; b=GybhLeGNown36iC1
	S4bsjg/ZywuYGDrpHnYtsWpKMZUfHhWDOl1fzMjH+yZ2LFHIznQyY3p2oc9msxRP
	irYebswsgp+w9+SyN0bR5x1avvIjCifs/IVnmUQPwPVI8cqtL9pgs1GY2djwnyQZ
	4C1nZJr6jUsTV/+DgcjOnQfOmGYdqh4IAkHj61XYFsYQlSlm5ltuVos01VDo6sjR
	oNnpoWRdvIfhFpQc6KsQAWVcqmB8gZIBR9ZiGJ2ffBbemLkQgwmMtYs6H7DMXtIP
	c21GGsLdxpwWCtyzoZY0hgh6mNd9pCPufjpNBR1AWSX/yu/qLUgbmX/VceJe6Tur
	PWf3Mg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amrv6acj7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 05:52:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2982b47ce35so54879125ad.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 21:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764049967; x=1764654767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=404nClmNRmrTW1zYFRsUIzncgU8WOWDCjaNO2hfY0lo=;
        b=EYRDbI/2JetXAUVWnalEiQd1AeOEc3gmn9G+vtiH5z04S0AyRJgYIAnfPmbfUa7zu1
         A8UcLt1abUqaRnrJo3tCXfrJwIK9VmOL1/N1MxhTgeGjhFH0mBgTucL5a2t3wGsR1C8q
         F603VNj5zpTgtr0ZJ59HmIeH+PYDW8Meyxok8Os4ZWEAG5biwB4u8XbTPYXlaPyEiz1P
         loe2GwiJa4CFmdt2mdR8b5APw4q0LrXFy/y9bwvIrle7V42k9VS4SS59Xu3wGJwGi7gu
         /yRi21VMNtLNg2RweiVlm52nED0y2HT0J3MukXPlFP3cW8nUoxlJOSUW1yNbPzs60PZf
         EPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764049967; x=1764654767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=404nClmNRmrTW1zYFRsUIzncgU8WOWDCjaNO2hfY0lo=;
        b=jhv6Fv9bsmwp8ZFN9lAk3sVyQpxWbUzn0Qvr8S85rN6RbeSNzOos0tQGviFMlCFHOO
         SMpPHg1Y79O3xSlNM4mchenb+eXWmUdpb6akhe3KIj2vtg+zk+cIeSIx9Mcgl+q1ASSH
         IQXOz8xrQG/DDJxYxwN9S6XuCrOlalANOB6gj/kaMU9yVD+8sn3gC065B3e50CY+i9o5
         2dYYOLFxq2zpBkVuVL5Oy0bl5r1FHG4/GnckEiLa8TiEgyDRsfvWDUwe7Hu7BuHJxgYa
         eqeL8kLciCcFOHhT663pfAzlcMtoE3b0mouku5glA53ME133+EY65td59/lfVmW0skxn
         qYkA==
X-Forwarded-Encrypted: i=1; AJvYcCXAUR4Q9o+JnWHhundrzpZqb5b5fX7DMaTG8OO7tvsC3brt++RSWHdmf0+pTTcmcUoMNVnP1fll6PE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8OrfRW0HCeH6VF8K0gHvPPvc+R7h7aj+x+nhvZrvZxixVfbiP
	lTIhTz8M/wRFpUJ7VTyHKwUeV5Fg8vUNqZz/iGM4DORlSoNu2xH5H09QtzxFffrZidnM0bV7p6O
	By+GylTYx1rpn5F79oV/KK3IawPLha3SeQXad9UnD+I5G4vDXTI6mdQhseKd3ezw=
X-Gm-Gg: ASbGncvGqzxpzEPfNZ9054dLxMioGOsPpjhH65LVlS+aPQTjP/w+7ThUq9ojebLPSv8
	Xv+nJSQIZo/QKiXsmuUIB/K8pJvMD4PUFKuof1AN83tduZBbHAKbkxecckfHB1hkrKZ2jU7DWsj
	jck6N72uWqh8bUa13JMbXZVHA8j926wwsr6/5XmzJym+RqSuYnh5bCWJl1h6W9/0k58AH/JAABL
	jsIaG7te5pLT8Xx+RjrVHvhXU9Fxp8AF/E/8PV48iH2TGKVtt3s//Xagy4CsWRMM2Ts/Msg1JiF
	ZsGujRlVkeWrDTnqVflFxCg5IUCqKV2T7ZY36iUEsj7iEajpPctJ1I1Iy4FMsrWSM77gsqAiRMN
	i
X-Received: by 2002:a17:903:2ec4:b0:290:b53b:7455 with SMTP id d9443c01a7336-29b6c3c2ac4mr143359845ad.10.1764049966259;
        Mon, 24 Nov 2025 21:52:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXMUITLBiR/ZLCoM1NGFajbfCNfqX0jMinzo5hzg/AXj8F8hDegLqk1If4egR7OthdW3Rb5Q==
X-Received: by 2002:a17:903:2ec4:b0:290:b53b:7455 with SMTP id d9443c01a7336-29b6c3c2ac4mr143359645ad.10.1764049965803;
        Mon, 24 Nov 2025 21:52:45 -0800 (PST)
Received: from work.. ([2401:4900:88e8:55c:808f:7bd5:9774:52e7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25d787sm155753885ad.66.2025.11.24.21.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 21:52:45 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com, p.zabel@pengutronix.de,
        Claudiu <claudiu.beznea@tuxon.dev>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: (subset) [PATCH v8 0/6] PCI: rzg3s-host: Add PCIe driver for Renesas RZ/G3S SoC
Date: Tue, 25 Nov 2025 11:22:32 +0530
Message-ID: <176404979544.19308.1377321354838950467.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251119143523.977085-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251119143523.977085-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA0NiBTYWx0ZWRfX43B12U0Hv/DX
 Pe0DuIStZjxHSfJ56WKezTYINVEmztvxbVFT/eK7CfZRVuXtZFcnbrP3mH1jtJV+bnOe8imDNG3
 EBSUmJ2qNFDKXipNMJgnnalEZLOCe4hcaVKbx4FeE+VETGTvjKnMNxuEdu6ZiT+rQ3iI1lLaslP
 U2fah3aA1vFC8Nj7tLz7K/vZ4XHeYlsUP8R7CbyjPpUuheu83oMF6ZW/+b8bFZwh7f5RzTJKIl7
 HrcT4Tt4gqMzeRry9dea8TnhVjpbLntqZbAcUa6lO5v1KV0fjaqEE95fiW4kzWqzO9yqApq0cII
 tCX5HnSdD7Ski6hpNazr4TLsB1roK5PE88tySYYRvFPr9HUrbvBi2zPFNJphVJ95btdool194MI
 fwWgLr0TKrGaAKKU7R2IJgbsecM2Vg==
X-Proofpoint-GUID: LEBa2g-jl0H6iq75g6-BnG9RRAR0cY_3
X-Authority-Analysis: v=2.4 cv=f7BFxeyM c=1 sm=1 tr=0 ts=6925442f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yC-0_ovQAAAA:8 a=VwQbUJbxAAAA:8 a=L_-H442qEDLWYYIWuCAA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: LEBa2g-jl0H6iq75g6-BnG9RRAR0cY_3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_01,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250046


On Wed, 19 Nov 2025 16:35:17 +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> Series adds a PCIe driver for the Renesas RZ/G3S SoC.
> It is split as follows:
> - patches 1-2/6:	add PCIe support for the RZ/G3S SoC
> - patches 3-6/6:	add device tree support and defconfig flag
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add Renesas RZ/G3S
      commit: e7534e790557e9ee18a2c497dc89a6b31e435e48
[2/6] PCI: rzg3s-host: Add Renesas RZ/G3S SoC host driver
      commit: b4a5c0c9dd430be2c1b980c2b08078071f465ea8

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

