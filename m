Return-Path: <linux-pci+bounces-43574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB76ACD9131
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 12:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D765A30140CB
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 11:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55332DBF76;
	Tue, 23 Dec 2025 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U9a/8NMl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vfcc+R8T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7F5329392
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488767; cv=none; b=QSafHkkCbhswdUo+uDJbH3d/ODoTsYN5qCX5o9CgjXlPI6gS3KKuHUWhhh7sYT6w9BlF4NbsIjKiyypOuS7zMXdEEZnRSZQqL6SJ568PF/olP4z1+NrJY6YPFqvLKjUr2hTHE0p4g1M93oWmpW4qbk3Bv3Axn7Yoltssk2RFg/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488767; c=relaxed/simple;
	bh=Cg6ODCDgtUdL/MiiAS4qGym3xOvuIRactcu5RiR8AL0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tIH/gxdG6crBJR22i5OulM2/8VarddrHC7vLrTxm2yGI60dLaXMz9WrvJnDBS2mQTeKY3T/j+KTemowdoG7E6Csl/CwpmQajgvGYG1lEv1PpUGi44q2Ow3Bb8fY0NHr26CL7K47J2LunXWhYYZfIZXe+ZsNZ0s5VXwZZESBml/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U9a/8NMl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vfcc+R8T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BN9prsr1889146
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 11:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+8HL+DZBIZSUxGYcDrpRwDAEJRaqZ0Y5zZTVJgDZ4hs=; b=U9a/8NMly2sal5IK
	O1d6EnKhQ84qB5TStwciMrsMzqvSvxN1hSCQS2DjtEL9hLQwD7uxwDixT4QY81N1
	xmSg7MAhiCKnacac/VkFwjw+mclFhoPnHqfD+RLYn78TT5U6STQgPVPpYEchMdJ0
	IMhOhHbBV+aWqf4AMASlE6bKbZ+SVyyISOlYexVIN6U5TfYev90VDf6rrx+xBKcJ
	qMaK1ETu9mwRkMuBaazbuNiM7mWMuwQhWQv4Dx/Ncv/KlKRmlrjSvBi0mf57ZGo8
	ChosPH6z4fI08LjTotHlURA0hyxr4TybtXWpsH09bFaBx776JDAN0CdnIl+/LMkB
	KaFQtw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b770akbwp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 11:19:25 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34ab8693a2cso13583349a91.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 03:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766488764; x=1767093564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8HL+DZBIZSUxGYcDrpRwDAEJRaqZ0Y5zZTVJgDZ4hs=;
        b=Vfcc+R8T8IlARNmKRQiu1g1CCnccjGEdVtzDayMta8MY5KtkY8kzmBVvOpeuTXO4tq
         8YsgizKwslh8R895lSWbZL7Ng7AldouWv/+MBP6DD2Dru0Xp3SVYHvFhLfNBFwrbrwa2
         u0rITdkutB/Ht89qjkqNi3HpEm8+y+bEmsIij2yHquDyXVsxDuL3Nk04SlLfkQlwmGFE
         hkd0SY0O+IfAMrWN/bz8eEYLxDSmQlGwel6rNuKlViNGiBoFl8p4AMoj5pw/8uHuAKkr
         /K8RwAQo2wvtCzFS4VeWOciNC05/lWM5/FLpRuF6lwsYhRurOT3LY7bpi/0n3jjPyn+m
         HBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766488764; x=1767093564;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+8HL+DZBIZSUxGYcDrpRwDAEJRaqZ0Y5zZTVJgDZ4hs=;
        b=ok5eRM+mnfZH3ZhvVtybzANcfL82LFOpqyliuYfvhM/xD3aCynMedse086e6IzX+iS
         +9VNWzstjgDoRzLy8szAt3o7Z+2ktg3eSK5gZp3zKQKhZW9iCec55Rm3O+UTTQp+TCTW
         arjSFFLKVEmzAF2PAth2EdjZ2r3mTKoPLEVBy4JR4VaPmCzN5mBrtBLjgWnY9QJ8sxVJ
         vAxRRQFl90VLMyUyMPWaPjYmi6g1dnO7QRTJchob9N4b5ed3CWlTBJpy1h+Vp79vqfmO
         mbZBQh1pEkXvUHCH47FcOvaWmAaV2ucCDxJ3P6yug5+5a29t7NktTMlNGswUs5EHK7L6
         eBwg==
X-Forwarded-Encrypted: i=1; AJvYcCWfyVVFzliOXxTGhlIg2HhKLVK9evGn0z42R5c4IbE46kbgGDzV74AUcm81MpoOvwFbljQWp0r1UUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqmWW3PL4R3y8W9i+q+utPfftVCFfjkMknxlgibFiXU9DEtc5W
	Wr4JJG5gaDfAx0nYUaKBsY2PdICAwX062c6pe7qV5D6vNV6BMX2/satTWKk1UGTYbvi8A3l5yZb
	Jt4Amm8iKCUlMD3SjuUnwx2qbDfLxIHnWqFTZBJm1Kt1D6lNs1OT+mPCsW04ZJbw=
X-Gm-Gg: AY/fxX7f97Sf27zcs4qHZud/vla94IDwf97MtKqAp7DXfxou7ShHnaiHWty32F5HOr+
	ECINtOtXk3rBuQS9OyI5EhDXXDi+5KI1bhkXYJEvCXqEBcI01g/vhjofDZSXdukBhugTHA2f4Mz
	joHlXkutGyOKtXogsYLNQQ4qVhCQNhm//rJPGJGNNjHd86mqGGGGY4MuHg+o2HknJ78773bToDa
	J0Jc7XE3dsdQWlkcF2Mg5oOzO82/XxVGIOM2l6Tqx5EHjd7H+DRCMccKKhqar2hHL4A5TnWExUu
	a14sxUDsGtOPPAhzGaGHw6f8a+a7g7is1/oXSIGOvyNFuhNRzTqbfcdRN5gzojvy2kKpm2JMzZN
	iMzF2I7AO
X-Received: by 2002:a05:6a21:e098:b0:371:7fee:7497 with SMTP id adf61e73a8af0-376ab1e9ec2mr13226026637.68.1766488764162;
        Tue, 23 Dec 2025 03:19:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVlIDpCG+Igs3PunLF0Y4zN/5kxjjqIXBJAUE+GFsBN3c6voBjflBAR8EyyQ/AJJdqAwAVrg==
X-Received: by 2002:a05:6a21:e098:b0:371:7fee:7497 with SMTP id adf61e73a8af0-376ab1e9ec2mr13225996637.68.1766488763688;
        Tue, 23 Dec 2025 03:19:23 -0800 (PST)
Received: from [192.168.1.102] ([120.60.139.28])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7a018eb5sm12380441a12.16.2025.12.23.03.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 03:19:23 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <cassel@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Frank Li <Frank.Li@nxp.com>, Damien Le Moal <dlemoal@kernel.org>,
        Koichiro Den <den@valinux.co.jp>, linux-pci@vger.kernel.org
In-Reply-To: <20251222110144.3299523-2-cassel@kernel.org>
References: <20251222110144.3299523-2-cassel@kernel.org>
Subject: Re: [PATCH v2] PCI: dwc: ep: Cache MSI outbound iATU mapping
Message-Id: <176648876048.446431.7990743502761229019.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 16:49:20 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDA5MSBTYWx0ZWRfX0ro2COpeUKp8
 9ok9KEwBTt4duvjrikWuSAf37Buc6Er8XTOu7O8yzLRB3+Bkw/8B7fUbRHYLbNWNUYF9v0+wkg+
 NdANTvjUCOAzs+BD1NFcLom09po43ahkCbLKGF+bNOkyFBRgEgh9FyieLn5cxq6M0067l39nkX+
 2SbKuD5GAB8Uc8esgdwjXMTyI+b0nW4yr9C4WVr4PGR/3HO/CcZy5zlpLw8BU34sDJvfuQmCqDf
 hA5JKzu6guBRUkwO4Ck1JcerZtRUrHWZUMcOap9hRaAVVFO3bcRaFgUpdVzdKLF92uBs4vqGT9+
 1XirRYo62sl4xHtOHj1QimQjQavQvFy+rEUW2KG0MyW13MI9m9qUfvKT5JKl8Nf0FdqVVcjE+AN
 EJbI099YoxMnjtaa0GLmbur9ka8FmNhKkqEsefqt1buX3BUijQBxQG7GmN21uVb5a8YxiseyeOy
 ZF+SYYAqzBvMmR4jhhw==
X-Authority-Analysis: v=2.4 cv=VqAuwu2n c=1 sm=1 tr=0 ts=694a7abd cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=wbxd9xFQoh2bOL7BUxlcyw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=a5Ne7kLCzoYn1g0T3z0A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: UBQDNlXxyvoEEl5hlyJv4jgahyDLcw21
X-Proofpoint-ORIG-GUID: UBQDNlXxyvoEEl5hlyJv4jgahyDLcw21
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230091


On Mon, 22 Dec 2025 12:01:44 +0100, Niklas Cassel wrote:
> dw_pcie_ep_raise_msi_irq() currently programs an outbound iATU window
> for the MSI target address on every interrupt and tears it down again
> via dw_pcie_ep_unmap_addr().
> 
> On systems that heavily use the AXI bridge interface (for example when
> the integrated eDMA engine is active), this means the outbound iATU
> registers are updated while traffic is in flight. The DesignWare
> endpoint databook 5.40a - "3.10.6.1 iATU Outbound Programming Overview"
> warns that updating iATU registers in this situation is not supported,
> and the behavior is undefined.
> 
> [...]

Applied, thanks!

[1/1] PCI: dwc: ep: Cache MSI outbound iATU mapping
      commit: 8719c64e76bf258cc8f44109740c854f2e2ead2e

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


