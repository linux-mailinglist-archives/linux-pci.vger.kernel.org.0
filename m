Return-Path: <linux-pci+bounces-41421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 68230C64D47
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 16:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD7B3341E80
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 15:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B006E32BF31;
	Mon, 17 Nov 2025 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OREd6A0F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MOsqOz5v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436FE30ACEB
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763392254; cv=none; b=tTAdqEDFDgnmNhNKES4/J2PLeYZVbj8sH9WONyRX9F2nwW8GP2of9pMc26Z0BRUGxbg7zoHigzh5rmbnYD/ZaNWxFSuP0rCadX842/3AAQfj+WjHjvqMyKcwyL7g5ObC+pFefbtLcR66II1TThIL/GPAM6tNFUMEsKyn1BT66ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763392254; c=relaxed/simple;
	bh=8GP87rndjeRAAZwpZQECmyCGSbGgW7OJY+MuhnDnBp4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lz+lfqPxq4vII0HSg8g2rkhrx8+RQL7cCWJT8AI8RFxvWyYcpbUU2zBIUgzWJLN744I2pr927mJQ0JuMrP+HPeMAWgSJuaqI3CyvRKIRUtVyvTUb1HVOwJktIppzJd6vnOLYnB5v5G5QPFDIjsju1hHoLUF1Z7PeggvtqzwKcQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OREd6A0F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MOsqOz5v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AHB2qs23671289
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 15:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gP7SZuFmqRobLejfGyt7GbvmhEcle0ex0smMYzsYzKk=; b=OREd6A0F037sF1VT
	OEdbZ4GyZWZJwpHnFFS8IU7If1hIVFXrmL3BgZ9ZyNWTwpe6cD7mu6uIAUNHFw6t
	cqveLssSVTYiCUKSwwHRgXdB8tYDvyLTYMh6wLlBygB648Vcqlqb7i3xQW/cRZse
	JQ7MrA4/kxGCY4nEYqVTyI+H/ed0QmGWVU8UP3f6qSKtuCSZ8e8ptIZqSsMx+H0P
	EmYawz9/IjU81nyrPSHzXrImTthBUtFC4oSM8Yk15TqgQ5sOMwJY1EVDAfkVsymC
	cHFp62K0U+0IPUrqETMBgDVL9DHjzKVuC1qHPpTPnTs7PbS6NU/4ukfC0b72pV2R
	clsrHw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag2g58ny4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 15:10:52 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3418ad76023so10503138a91.0
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 07:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763392252; x=1763997052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gP7SZuFmqRobLejfGyt7GbvmhEcle0ex0smMYzsYzKk=;
        b=MOsqOz5vfsXXDJuvkP6tp9pcg/B/LimhouMN9j1rSnYMT8RM/p+B6jM5aGSChUG7Xh
         zQR8zsFAuCyeIpVLuOa+emM3ZRcB+VrsqkdhIQ90O0NGwtMSdMAym1+HmsRfKnZdfprf
         pChkcZvryPvyudLINqwgVh+B2zyOGC647JeijNv7dZ2Qqvh8eBEr0Hq2JscGB3+3ZpU7
         AeHWp8SXljT8J6mIqHO+Wax2P2kZbEEFyxlEybK++ZOtw+ubjE4vSJKmYsTrh0dq1QIv
         yJShlle5XUuJfC+DS9B+wW/awJhsaq19rMcLLSnEbEWm25tW+1dpxcdfnVetCRA2e5V5
         9a3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763392252; x=1763997052;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gP7SZuFmqRobLejfGyt7GbvmhEcle0ex0smMYzsYzKk=;
        b=Zt8irNDqH1TxX9bWiI6JwmBPbz54fCE/uqqEMa/AmXrftYh3ADva6gcVPQKD/sT3lk
         r7s7rF8Fy0P2lXYD21CIZTEe55f7VCey6zaZUxn2svjvto1bHwech5djfoFIZFrA/cQG
         H/Cxmbg2DRmyrg5Ft9vZ4mUYNhPqnSxr1iMSkS6eaJHFm6zp3mAiNZuMtYMhTtGAy8RF
         joJiEy/XlcMSpmXiK+IIMM+Fx2+cjVbfHdqv3so/8Jw5MxMc0opq7eFj0Tz2fKsdiieq
         MWSnvG/tMSLd7yy+QPlZozwaiYyLFRX7gqGyTrefwlE4R3y0EYGkNUBWJd5jnMWE8E+2
         0flw==
X-Gm-Message-State: AOJu0YywypUs0yuPJTLzpq2iIOa1e/rIdwyouwAnZ1/DmloD7N4j5dZS
	Y/C3ZGGNzXEQ6gXsUAAcX0c7/fzTwS5TC5MVCYhoA9xIcBTzvNXAeFIX7CEWXN+r7nJs27iWQ7y
	lojjDc5VJyMDjzeN84leiCJA65PTY+OOCGFXeZ7tulVFzym19xL8iz6eVDnvTzSHXJMzaLh8=
X-Gm-Gg: ASbGnctwjLWvPSAhVnBw3KTAKR40SXx2HrL5Nygxc63DyrABEH9TyBdN8TPncaI7ENs
	dYl4h6z1z/jDWPLh5JOq6BLvjVjhRDgmJ1Wh8h2PtzUkz2cZwiTZ+GusFvELq7WYydG/WCtccbn
	D9hMrPOctWt2ckseim7tPp1mDBmx+kwFpsXUQEBv28gvVYh66TQU8YmzuLmzXqpYwhGFJf7glMK
	4TrNR5naDV0kPlnFbAUCmvoJX67FCbsxlQEaI7ma9ICLM18qEvo/ylvmb0a+eyTHBFzlchuLZFC
	6uVhdXuOqUFj8NxAV82yWyTlj+Yf6n5WrRFMooU1JQRxMN8tT9emfMN0UuiJb0ySbdtJoNC/
X-Received: by 2002:a17:90b:514e:b0:341:b5a2:3e7b with SMTP id 98e67ed59e1d1-343f9ea68aamr15342282a91.4.1763392251665;
        Mon, 17 Nov 2025 07:10:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbsQ08i3RpDgpHclLMhdgzdyoJ+w6CtMbBeyMNLvGdDTzxKR1J3yh37uQpCSBsZD5+fmLg4w==
X-Received: by 2002:a17:90b:514e:b0:341:b5a2:3e7b with SMTP id 98e67ed59e1d1-343f9ea68aamr15342231a91.4.1763392251198;
        Mon, 17 Nov 2025 07:10:51 -0800 (PST)
Received: from [192.168.1.102] ([120.60.57.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e07d2e5esm18476478a91.17.2025.11.17.07.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 07:10:50 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christian Bruel <christian.bruel@foss.st.com>
Cc: linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251114-perst_ep-v1-1-e7976317a890@foss.st.com>
References: <20251114-perst_ep-v1-1-e7976317a890@foss.st.com>
Subject: Re: [PATCH] PCI: stm32: Fix LTSSM EP race with start link.
Message-Id: <176339224773.8361.12189431111845230002.b4-ty@kernel.org>
Date: Mon, 17 Nov 2025 20:40:47 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=F7Vat6hN c=1 sm=1 tr=0 ts=691b3afc cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=SvArCPxluHhT4bP621h3eQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=dc-18obONeaZi32LRPcA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: lBD1X4f6FYQ2itKjI4Cd1ryJw2caD9SB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDEyOSBTYWx0ZWRfX0dKlw85OhXfk
 o5+XWU/8mMoPw6toGPpQ44Zsqe54V5EDYrEXiV3fbfPm3GBwSf5S6t5pveQDbPn+d4tdna6x2OF
 Ao7fGnJxWPdtnbhCoRv9/c3WY0wB881f7RAoLD5UMelrSqKRIJRh+dQ6/XnZ7GX96uKvigTWVMt
 pOV13/uwfSBTiGXWyB3fEcCj3hdp0rJijDyiqGwBCIPbVK8NE7X9fScqDvU4zEcXbFeYBqbj7bW
 ms3rH8bd3O/KTtrfM1VezV0W6Rv0GjngCS2BbE7Z9MiMZ7dfDge/cs26TTYcZDu1/+cU9Wf4ht2
 JASfZVg3nfwqb4jltGxqUrSsQBjNhujvFZmZuuTOw+5vXRjUWFfUTgq0lxkT1Cxt7psuCKDwrAw
 947QA+sacZ/2GuvYQbzBKIGhG1KSmw==
X-Proofpoint-ORIG-GUID: lBD1X4f6FYQ2itKjI4Cd1ryJw2caD9SB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511170129


On Fri, 14 Nov 2025 08:45:52 +0100, Christian Bruel wrote:
> If the host has deasserted PERST# and started link training before the link
> is started on EP side, enabling LTSSM before the endpoint registers are
> initialized in the perst_irq handler results in probing incorrect values.
> 
> Thus, wait for the PERST# level-triggered interrupt to start link training
> at the end of initialization and cleanup the stm32_pcie_[start stop]_link
> functions.
> 
> [...]

Applied, thanks!

[1/1] PCI: stm32: Fix LTSSM EP race with start link.
      commit: acca17da9c9f53c0aa05bbdef255213d36dc09db

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


