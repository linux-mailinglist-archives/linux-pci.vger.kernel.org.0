Return-Path: <linux-pci+bounces-43242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C37ACCA4EF
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 06:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 612A5301FBE5
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 05:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FF9308F36;
	Thu, 18 Dec 2025 05:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B+yJczoV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YwJNrxDa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92321307ACC
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 05:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766035389; cv=none; b=WNCY1D6GGzLTBIKDNf113hFnff5DBby4cZU3+Uxwk3ju33PGDW+axTPIPk9XO1gV5r34TmtwmVIez+8RQh2sf5lUwEZ8J02WipbADaxmzpKUi+jR/kZllbvIROpU3j/xn3Yi8AHPOINWTUYephQvJQMhgqj0xwpAf8eajMuk+F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766035389; c=relaxed/simple;
	bh=RQx9EjbZzA4ei3NX9t2BJHxX/pI0/xNzFou4zzkIS7c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZTqrtOvSfaap/iHOs0W5/7RqWs4uXpPOw3Fr/cxCrdzaVDAgPNUC1tEVwZMau5WZ9jsIjJN4mASueUt9fF/6YW6hq7tFRRMfEl9ade17LJ4o71/+yPnwyd+MSlXjYH2jNAnH4eKUlI1GjblXOSfQqWhH2eAtY0w4DOojdo0/Bcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B+yJczoV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YwJNrxDa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1YUwe174259
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 05:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	enmCRQ5x3mh4iFRLG50m7N49AT+rZ2yyvL504EZOAY0=; b=B+yJczoVTa48n6Dq
	aTtBhDqYq+jTEvR1g0nAO5TlwI9mnxMUXbfOc2pgM2pZ0ox8qH77D4Ny/hL9jLHA
	bcxreMjfM65879tY334/iUfZFalhUbegZp0KFDqHktADR3wU3B+q0dS4fRZWPBXl
	Y1iy6xfGm450ZSWNeylJZp1anHSxrYsb6HmB8pE7BQrLIpncDG9JFv8/LjIvN5Zw
	nVB93d5+3XosyN3bW7PMN93pHx0hD1OPKkodecbCxw5W+e4E5Fkn9Fc6jLLCOkDj
	tJT00dKdpDludDHuXyyg1jPMUVRgNVIugCgzy0xPEvPpmSC+/FLAVMGIePYXTnjk
	9iWoYQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b43nms7r7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 05:23:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34e5a9f0d6aso293173a91.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 21:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766035386; x=1766640186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enmCRQ5x3mh4iFRLG50m7N49AT+rZ2yyvL504EZOAY0=;
        b=YwJNrxDah5tmAXi1xA1H+8WDV+tjoqvOAMrzwEchYVSwelGvDNRND40NTdE7smtwT5
         xO+ixCMyqRCxuMLhOrtNvrIvFIRDJf5MyoiwJKnOA7d55bzjffFqZ/xbHICKKGT1PyX9
         zwgP4pKI+1s0yHd94TWlKO9587RL5ZyY9MXxH9I1hOKRTzPc05XCj6ulyUuONavSiZjl
         P9AMvuR9YfXX0sZQoKq0MQbAxgbffrGIgbk/+aXU/hUqZqG0BO2oUjtotKCT/UVrjQ+d
         L16VIEpYbo/InYb8hYIFbhyAUW2H0dsufO1s+ji+K2RHV7nRMXmt27grDOOVPfI49a7y
         O1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766035386; x=1766640186;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=enmCRQ5x3mh4iFRLG50m7N49AT+rZ2yyvL504EZOAY0=;
        b=ljbkowr40pZ0YsOiKnxi45C7Q92ohTOe/ZvVQLaaANP/6osGww2TN3AjXeXzolj56e
         dyLZ7naT/llTQvEcj45qID2J/E8d4rzTlcmy0IGHCtOQ0fYOESvouPTqnYaouWhXtW3K
         vIKomGoQ3WwrE2TAknhF2ekBAHnYw1fBykP9fULiBfu67LLlooUYpk+HihwrBF/rfI/x
         xi0DXXH7dGg+gxVYPeclnX/uua5BV9LxYB/zxiMIC/jQabf4iy2WYZ0kDH0CWvI4lUlj
         EHWxtNH6Hlk7SNhlVT9u2l8soXy1+dryJMu5sWMPIPUIXCewybFWqywCicvIPY2qVtGn
         qSQA==
X-Forwarded-Encrypted: i=1; AJvYcCWAwFMi2a3jcJuJPPjxRhsLzFlUukr72lW+HJEsuYV0PDNQsK0eKMCtB5GyQUwiuuBvXq0OgCwf7fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwWtcEC4FYHhiafvoXjDZ6ANrgtJBNamGhflWuNCMb1KjrgAJJ
	KnricfaGaQgGCV0iCYUO+k3PH1PCj6shSRvQCgyhGy7+cdyORcMibaLaIDY2ZYGV3rE/drB8IoT
	ZEvneqqRQUk2FfoQ9TcDReQv7eDeU/ib2vguMmN3IUGp6jq10dEHlKRYKhJZJLYI=
X-Gm-Gg: AY/fxX5pqdjpdMub+6LOelOXFmSgyGR0mA1v+RmyXI0BW4wofWsvlQwy7w2oyX0SsFg
	GR6C0uuQa8Gc7dOQoIMflrTTEFvXPxq3847wCFuyFNPkt68UVitBELsn72DOOef2NS5Yi6pl8L6
	Rwf3JMrNeT+uc24GdAUrbA6Dl68olZ8iSlR7yT23bpEyIguX/K3ezwYrLlQjVy8FzE+tFIMTyZk
	8+BzX9OvpxY05klFzmpm/GOdKWXXDHqh3yiTPtQ5V5f2r9Kg3kiyX2haASlgtHA3jTztY5KpY7H
	XBZdIgInaJgVpWBYOo/7MYLcEwXHwBI4+W8xIqUEY4V+5MA1Vq8UXYz1s3r4jMS+o7hulz3T6Ci
	zx2QTZUEp6pg=
X-Received: by 2002:a17:90b:5188:b0:34c:2e8a:ea42 with SMTP id 98e67ed59e1d1-34e71dbcfc4mr1900814a91.7.1766035386079;
        Wed, 17 Dec 2025 21:23:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1uif5/k+kGaUzokc/1cPGTxk/yEbsq8GumAvceKN56qoZljhicE+tTvI4yGX72oVtqPiFZA==
X-Received: by 2002:a17:90b:5188:b0:34c:2e8a:ea42 with SMTP id 98e67ed59e1d1-34e71dbcfc4mr1900791a91.7.1766035385621;
        Wed, 17 Dec 2025 21:23:05 -0800 (PST)
Received: from [192.168.1.102] ([117.193.213.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dccd14sm1175108a91.16.2025.12.17.21.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 21:23:04 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, Kees Cook <kees@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel test robot <lkp@intel.com>
In-Reply-To: <20251014-rcar_pcie_probe-avoid-nocfi-objtool-warning-v2-1-6e0204b002c6@kernel.org>
References: <20251014-rcar_pcie_probe-avoid-nocfi-objtool-warning-v2-1-6e0204b002c6@kernel.org>
Subject: Re: [PATCH v2] PCI: rcar-host: Add OF Kconfig dependency to avoid
 objtool no-cfi warning
Message-Id: <176603538085.6580.3625113457403612097.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 10:53:00 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: TcLzJgiABvmOYe47uGM5RbB87MPwF9nt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA0MSBTYWx0ZWRfX+m7TbHgswH4K
 g45dgbzi5Xl+zwFz01evvuANP29lQob8AF77owdVE/6dPXuvUplqaaURUmnXaiTbOfSrLolQH3v
 d7NcTj20aLLxnhOoiYm2TanKe+GGEYSRRs+UQN1HqKSYvl3WPaOBZ4cryj9zHipSJH7Qo9qSEwb
 02UpRA7UuGDCAZW0/L1ctf7Hgriea8nZN4Qxc5+Q57B/K62BU+X93mvhilmE263dmOQr+QOuhRo
 FfM3c2vBQBYWJNY7apUrAWlrcv5fUjiy3Hi28+MsbO/Dc2YiUDRrcYuizxRJa5MCxJECUlGzCrQ
 hXVFYcFtTywi8RRH73bpOX6A+TyzWMyYsXfQsUHpjtxISJr8czyuyOoQfXdZURS253m+nRZ33ou
 KQLSue5vxdIg22bbWQX05hbOnWYcfA==
X-Proofpoint-ORIG-GUID: TcLzJgiABvmOYe47uGM5RbB87MPwF9nt
X-Authority-Analysis: v=2.4 cv=A6Zh/qWG c=1 sm=1 tr=0 ts=69438fba cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=PLOdWElDzbaVVj/XHNhp9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=ehsjDiE4JrN5eREjfRcA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180041


On Tue, 14 Oct 2025 11:20:27 -0700, Nathan Chancellor wrote:
> After commit 894af4a1cde6 ("objtool: Validate kCFI calls"), compile
> testing pcie-rcar-host.c with CONFIG_FINEIBT=y and CONFIG_OF=n results
> in a no-cfi objtool warning in rcar_pcie_probe():
> 
>   $ cat allno.config
>   CONFIG_CFI=y
>   CONFIG_COMPILE_TEST=y
>   CONFIG_CPU_MITIGATIONS=y
>   CONFIG_GENERIC_PHY=y
>   CONFIG_MITIGATION_RETPOLINE=y
>   CONFIG_MODULES=y
>   CONFIG_PCI=y
>   CONFIG_PCI_MSI=y
>   CONFIG_PCIE_RCAR_HOST=y
>   CONFIG_X86_KERNEL_IBT=y
> 
> [...]

Applied, thanks!

[1/1] PCI: rcar-host: Add OF Kconfig dependency to avoid objtool no-cfi warning
      commit: 57833f84f6f5967134c9c1119289f7acdd1c93e9

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


