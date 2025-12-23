Return-Path: <linux-pci+bounces-43578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4752CD9426
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 13:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF171304809E
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 12:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B652329391;
	Tue, 23 Dec 2025 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VG2eCwzS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H2eFGwuJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF05A330644
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766493001; cv=none; b=jSKnD9xLmmLU3pjHWBeYxRA83t6am3GWAf4GAv7gWwY/UK0KP2FHbEDzAySoNtL9oPDptjmxBaPOotKfH84AKwvzrCW9Id30rKySPaaMFoZJv6C35LQaHx51fsYEI74xV8QV1mf5XI31AW95HYy5KwZ+ylyGtNVMlEdxt9DGTBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766493001; c=relaxed/simple;
	bh=DM2K62Tg0CBm/wIOPy2pMRcFMqVhU6v5NSJNGLDojaw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D6gXz6s9FzlnYAL0putPezjJLPc2rMofmDDlPEN7drsIuq/+3exOVGM1gUryWiVyHvpSE4yE76y7IcL/n//TvhM6e12pIEC7WOrnQvP6DuwOPt72L4Oygt0Py+59RltVLNMRLvmLpyfyZC4HIthJlYMVyvBnlBIeClegirG/Myg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VG2eCwzS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H2eFGwuJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNA2aBO1568773
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 12:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2ffbG6iJcP+z5d4xqhzCeKpZMxj2hNcge9Gry8DMjRg=; b=VG2eCwzSAuLTBzBS
	cyN+WFz045WXQcDei+Hdlfd11Hw7mqZxT1oWwtVcCuHA8vsbEcLTYv+q7ppf2K/h
	6YEC9QcBH0ZYNrmI6wSS/FEXD+5409iwJliT4Dvb7VBoEJEDFbl0amMUW/lgPPvX
	vvT6eVy3JXF/vTp92Ef7iElVmcjfNb0gM/6fCeytX8KpKQemA3QRcND5bdvuGoic
	ObK5am1BqKhMwqgEOhkQXR3CxtCnNbYa8K90a9ZmEKWAa07nff6BuXpEmVWHzRZ3
	xWA/B+LWbBcNiwvCQTF2HChDHdDkdvU7kstDDWcClB5EOy+CM1FRInmfKUWrOYvT
	8z39yQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b76yy3mh2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 12:29:58 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-804c73088daso1527010b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 04:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766492998; x=1767097798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ffbG6iJcP+z5d4xqhzCeKpZMxj2hNcge9Gry8DMjRg=;
        b=H2eFGwuJ1NpZemS4lFewkphRTQMfLZagai2Ll4mkHKgS4bak4D69gzUObBn9a4xQvb
         TdPShWLu1Kzklu8F+jGn6gtH6+eePQiLsqBeX515II9T0LC8Ik5Q45FTOJk27z4uEvdM
         P6HjUs6vomJpjX51WzJMxAevC51ViIog7i0Z56xXBOf5o+APLAXaYEV2Xs2ZPzFKUu9/
         WutgHZ1gu1rRRufyFAVjMPWArIVD7HXW8NsjOGCcYt02oQbHzZf6H5Gsh1UUL1y8ylxY
         D/0jyaV3LCI9oZT9YMZk+Q+uXX5T7OZ0ojWwMvxAh6bsGzmAanXrbtL8vHjW1JSNfw/G
         fc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766492998; x=1767097798;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ffbG6iJcP+z5d4xqhzCeKpZMxj2hNcge9Gry8DMjRg=;
        b=BfuBCffmW7KomrYnyQcT+W3vWQ9qXz4GSLr9VrIe4nTNP+zBSyF984WqXRZDq8WJtm
         5lJY/uKvp+v8z13AWraeUA75o5QnmsjV4KT7oYP9B4ddqRAoD9B+uegJk66trRUhBL6u
         PRk7xakNLbFrPJ3PbyKgUEFtkW02h+95C5CApkgp+agPOoWOWhmsbx7thoXJUH1gONM1
         cUHfY3p5+hRg22Aw3bizshqtQS4sjFTmXv0KpfzkWBqhqJhimlqMs140SpOPvfTIY9Ss
         AKciRlUvucRmZJ4kafXErVWlDvgu3XKvAUguMT47W+DD2JIz+F/qj6Dp7WisIQkMg75I
         Z0Zg==
X-Forwarded-Encrypted: i=1; AJvYcCW5YD+Gd75dVCYjHrrCfr75oOW/zNZDhUrqgU9JOo5syqa54LIKkNpsqSgSmq8J/TFbrv+XgyeAw9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrsbTxUQuFX6M00louCPoF/hzE+7REP0QHWgbnclyOGbDTuELP
	lwy2p+dAApMlQeIOaLEufLX8pROdl0IE14qyu5e3IdV9Olnx3ahfqTutPCK5AiEkBHQNwztgnEi
	5fgAlzoWRoV8euQpZr+ch2ep7jMHdLyWaNOE0T6qBIKWhg54v3sJCFWrg2vtcIn2d4dB/LY8=
X-Gm-Gg: AY/fxX7CKVgdcS9tg4EMSznHu3+boOUznwi/PkKseGpb4gSzA+o4IF/y5qlUOQnQsyD
	QJBn5w4svHAc49QEr3gIilxGMoinxWTCVC6BV6tJLO+6KXRPHPigfJV+se9rKkzRf3FwsbD0nEU
	qSU8CtvaWmBoSy9gxcUbTIyMmqq5HCBmBOM+jutKczeROBYr5oNrLHQBTN7EprKDKsU3mqCxc11
	paAiyTiKNbq9IkDphnV9RpmyKJkD0WD0M706ToEZsu50ikRjcOLIJpqS2a5Frbt6ENWBi2112L5
	ToW0Fxb8TTJEGgs5F3RioZA9HbHuAAAPtvytHRdfrfoaTXnhP54o/8SG7D936Q6AEo66gBUG1dz
	Py77mQ9P0
X-Received: by 2002:a05:6a00:1d23:b0:7b0:1d84:8634 with SMTP id d2e1a72fcca58-7ff53501207mr12347220b3a.15.1766492998092;
        Tue, 23 Dec 2025 04:29:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKW+H73D9ksZ7fL/FG16dl2s55ZD5r9HDlncH90Y1SXkZ6xZ0B5TcR1RTF1oMqSDXvIjV3Tw==
X-Received: by 2002:a05:6a00:1d23:b0:7b0:1d84:8634 with SMTP id d2e1a72fcca58-7ff53501207mr12347198b3a.15.1766492997644;
        Tue, 23 Dec 2025 04:29:57 -0800 (PST)
Received: from [192.168.1.102] ([120.60.139.28])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e892926sm13647781b3a.66.2025.12.23.04.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 04:29:57 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, kwilczynski@kernel.org,
        Haotian Zhang <vulab@iscas.ac.cn>
Cc: robh@kernel.org, bhelgaas@google.com, michal.simek@amd.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20251219021615.965-1-vulab@iscas.ac.cn>
References: <20251119033301.518-1-vulab@iscas.ac.cn>
 <20251219021615.965-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH v3] PCI: xilinx: Fix INTx IRQ domain leak in error
 paths
Message-Id: <176649299472.522673.6050154108234112363.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 17:59:54 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDEwMSBTYWx0ZWRfXwl9OjI8KiQvW
 4MLvswzDWpfrinUhQeSOJCB8rJLSfU1kD4r8VndQHsy8qWfA4+uujsL3LunU+mBiA5jB8GHmPrH
 Wy7ryAV/GFp9H+uxrhNsKYaWZFqYLbrhjg5E+6mG+rHao9tZGKkcyP+G7olq+yQykakInFBze7l
 s85FZRTWjxFeZX1oQY6YinANbvDgm1AeqGr2UlpwcOozMwHGGY6zK7YNKRfjkYM2Ll2jtxFFR2M
 Rz8yLLqSBP+ozc+7D4gApcNcqb6M6Tt1pWrh0yV9oHzktJZTcLt0udGjcOXm6J1oB6W0oXsveVI
 /pBNvG6qKhx3SYKP2BxKZbZ93KiShRPuJYBc4NpBhw4r5TXAlphWU5rktTimxSd9iERpm0F/qwF
 sUjzY66ZzadvQWSu6GUbA/cbk3jJZFbktinF/LPgzbAO8UTo9EqTsQzEvg0KVNhNV8BUAAWzbeT
 Mc3Cm8Gv31XvFJbL2RA==
X-Authority-Analysis: v=2.4 cv=Zb0Q98VA c=1 sm=1 tr=0 ts=694a8b46 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=wbxd9xFQoh2bOL7BUxlcyw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=A4LZ0qbstxbIEDcu2eAA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: XSgLZ_pKOXKBXVNlBAj6QfaTPUItf6kC
X-Proofpoint-GUID: XSgLZ_pKOXKBXVNlBAj6QfaTPUItf6kC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512230101


On Fri, 19 Dec 2025 10:16:15 +0800, Haotian Zhang wrote:
> In xilinx_pcie_init_irq_domain(), if xilinx_allocate_msi_domains()
> fails after pcie->leg_domain has been successfully created via
> irq_domain_create_linear(), the function returns directly without
> cleaning up the allocated IRQ domain, resulting in a resource leak.
> In xilinx_free_msi_domains(), pcie->leg_domain is also neglected.
> 
> Add irq_domain_remove() call in the error path to properly release the
> IRQ domain before returning the error. Rename xilinx_free_msi_domains()
> to xilinx_free_irq_domains() and add the release of pcie->leg_domain
> in the function.
> 
> [...]

Applied, thanks!

[1/1] PCI: xilinx: Fix INTx IRQ domain leak in error paths
      commit: f42b3c053b1554d66af6fe45bb1ef357464c0456

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


