Return-Path: <linux-pci+bounces-43264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA300CCAE2A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 09:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA8BE30B7FB0
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 08:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789B4330339;
	Thu, 18 Dec 2025 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rm9JkxK0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K0iT5bta"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BC332F757
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046306; cv=none; b=h5dKsXfXauJkmHYEDFH/IE6vkX0V2n30ZFmpbwx7BF4pU+YhRQsi4took7k21pvoS5flqMFsmQbCw0wkdGAyrZkkuJtJ9OiCNkEdozldqBn8VSvQF+HLAQDeURxYNAz5kleZyhu7FNz91LJcbSZ0pCBdiaYXC+Kz2RpUwuVNfEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046306; c=relaxed/simple;
	bh=JaFkZsdNFK+cow+o/VHZIpY4BvAVKpP4dhKbLWxlt2o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Os6zlZjjF6nleDFqsuk7HJAApLe0Sn8TQx/F2pM/ZUX+vBRhJy7ngNdByiziWK5Az7eCAvlf4X27b/okOfq9jwocdAnHoTB2P7Ss6NgtEtCqbW+W9sspKscgSBpB61vQBIV4pHa4GvzZwqpZgyb4qEHjd28YIxljGpcTSKLA+NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rm9JkxK0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K0iT5bta; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1YVIn4147875
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 08:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h9eXcbVLE8BoXKOP6CjUjrYHB49qzqi2WjOZ27sOho8=; b=Rm9JkxK0OhC9Znjd
	/ASbKDmSFFlHys9C1IoRkaaBuxH8AV7NaAFyd/yEK81cE0GAftas8eZKX6MN+IM0
	jRnfG85A0mvV7J9LSzDo6+P69knKWRae61RJQDhSXhY59AHYWBTojFQookF25dcR
	4KqcEb5OOozLUfGQ8irc2pgcgWoQ5pb+Ku53cQHOGkSy0gFVB4EAQ91/McjzdUD8
	31Eeomx+0PLIHuzREjSuMuOKOWAF/KsB6dYPlM4o5yLXSbbjozNYnXOCGQdDCG+p
	oFqvFT7ErmnsrdlwKv+hUjrR5HY+/EB8Tmiyrh43LnoG6EkQNNA2k0AHtXDCNh79
	bj0Nug==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40u7a9n9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 08:25:02 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29f25e494c2so4502355ad.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 00:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766046302; x=1766651102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9eXcbVLE8BoXKOP6CjUjrYHB49qzqi2WjOZ27sOho8=;
        b=K0iT5btaHzOuuS+j8xYgnb7+D0BNyboXEC/JOczPxmAiO21xwcJDnZKfV1IYbai7dR
         4Q0J+fCX/0JEOYpuWeF2ZgO/f/K06lH92oP29n+ywkcrFEntNPmRapi6XsaR6jMSIFig
         4tzAWgq3SlFtK9QhUn2gB00e2PETLUVTXkyBWayKRA8S5D8qdx0yO/4LTmIHTP7yEAU1
         zvrlSO6tVmFJoodjEFdnRT7Ep4Yg9auAybC8HdNu4COgcHAIcrtMjisN5JCwud821zvo
         Pmd+IjzTYiIDha+K2xjqVilCUzfWnyutNnEZLpFJLQbLn+INUOz3v7RSVFH3xA5jI7CB
         JeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766046302; x=1766651102;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h9eXcbVLE8BoXKOP6CjUjrYHB49qzqi2WjOZ27sOho8=;
        b=HPW12e3tnFrj9w1DJ2WrsR0wO374HaHGv8ACSklaxXUxQVfSzilVDgZxXE42gZsPlA
         RE5Gxn1Dp73vktkXsy+3Emc/JF4qYo45Pzg365yaOadK+EyTFYlR2Z+jqq3KOG9ZBmIk
         EK28ptIEjtwurMETw4PziaBNTymEbg62gxUtcJWSw8kMrVdxR9s83TE6wIAHLQWVGc90
         o9dm/BjQZy1iM8/qXQy1MRUIc76uaX619lIABMPNGaZQRgHcejVmqbkSu2dsepiH4y6v
         qoWRX4lFlTjvnYeoFBw29M+jeOH2eH2uGksCHBeDEFBdq8DIaoTxp2CsyNK5uEY+RXzG
         /JSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxckB5Pk6IXt04Y9HM1Nik48c+/8ps8Ht3++nNdPmxwgZy16gTD6WcOH6lBcV33nwCXyDMlR4Efjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs93UvyJ4uWNpkJFXlIXXCM/Ca/vvvFJ801D87jiRBUGZ96L/4
	v1p/Jyk6xsjRfXVE+8MnS6KX5fUI4xnPBVdRIZcvBEFIDc+gm/dUAcQ4LHu2SH3ipaXWf4/bYIs
	R0ehCya7xGtRVE+bmmbN8YekhL1mJZIqMrgIhL9CiWQWnbf/qWN1XOg9pFq9KRwk=
X-Gm-Gg: AY/fxX5CtvKN64YALptFoEj7Zyk4BRzxqZnQk3v6Wsfyq0gnXKVbTJfg0eCZDJill7d
	24OHOKP00+aqvCv20mwjl6+bZ7+C0LDRx9HJfIGziZEd0IksWEyk/9c4DVIwqLZZ6IIyj13Uc0T
	CI/X+mjV26cyKrLFHRezUIkBmgLX0Ec8VFhdizi/0K3RTIz0ZPMqoPgYgR7ls+EdDaWfDsOAfxb
	2y9pAi+XJF9tAPAnF/zHyiceLOj1ISnuWwlRR3F/byI6npivFZRTpcN1Rg9Qb+k5bSfaTEXPtaz
	A2Tu+JoXNhp4iIeVRmZ51z30L3qcJyvt4+iYET7l697rsQZlu/MzX0ltE67V457ji8oHIhUxRsU
	uZq15YhRhxNo=
X-Received: by 2002:a17:903:2307:b0:29f:2734:837d with SMTP id d9443c01a7336-2a2cab74c17mr24950275ad.28.1766046302305;
        Thu, 18 Dec 2025 00:25:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3dH7tcxdtCqdARxzZ55t+fLL1sGXobURAo2/LxpuPlbdPHdNZsH0SrJ8Ajmd1pgR62QsrNA==
X-Received: by 2002:a17:903:2307:b0:29f:2734:837d with SMTP id d9443c01a7336-2a2cab74c17mr24949965ad.28.1766046301770;
        Thu, 18 Dec 2025 00:25:01 -0800 (PST)
Received: from [192.168.1.102] ([117.193.213.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c812sm17421705ad.15.2025.12.18.00.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 00:25:01 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
In-Reply-To: <1765503205-22184-1-git-send-email-shawn.lin@rock-chips.com>
References: <1765503205-22184-1-git-send-email-shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 1/2] PCI: dwc: Add L1 Substates context to
 ltssm_status of debugfs
Message-Id: <176604630001.843297.17429554282202051282.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 13:55:00 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: hmJuAg9yuiO5SErPAes4_Y6-0de2GW4R
X-Authority-Analysis: v=2.4 cv=Z8Th3XRA c=1 sm=1 tr=0 ts=6943ba5f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=PLOdWElDzbaVVj/XHNhp9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=hNyLsvljiUqWJzcpEN8A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: hmJuAg9yuiO5SErPAes4_Y6-0de2GW4R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA2NyBTYWx0ZWRfX52Y0Ih2eF+cX
 OSJ28SroZ7bFdAU4x2g8MZtbhjudkui8wPxcnVjE7YqruKD2liLfSCjJCqq5+w67SBbLeBwkZbT
 5t0JJvanZ4Mkzs4Ia3hllipnfmmNbPYm0NXhl9OdPkCCCmi0n18bgDYf1T0ZD6CLsmscursVczh
 9lUyEvdn2lKCt/gRdrub5B0HbvznWIJwqb6zDyfWhTf+HkbuzVVuURe87Yal0uwsgYcwvCa2dUX
 fRIVcof4JGdApXHd3w3riK3CNcVsV3WxRTnW9cjAtaQ07cGS4iRsjesHkGtX1LdC3wwSyoDWdRS
 Tt61cIzrAcYUyPl5NUafZW1ogGkA/h4p+PfShIAaUh7Dg4DD0+fdCqKDjM8XqtJMhitGe+RJNHP
 b+MTkt73JnHCwmCe6jtsiifWPspA6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180067


On Fri, 12 Dec 2025 09:33:24 +0800, Shawn Lin wrote:
> dwc core couldn't distinguish LTSSM status among L1.0, L1.1 and L1.2.
> But the variant driver may implement additional register to tell them
> apart. Add two pseudo definitions for variant drivers to translate their
> internal L1 Substates for debugfs to show.
> 
> 

Applied, thanks!

[1/2] PCI: dwc: Add L1 Substates context to ltssm_status of debugfs
      commit: 679ec639f29cbdaf36bd79bf3e98240fffa335ee
[2/2] PCI: dw-rockchip: Change get_ltssm() to provide L1 Substates info
      commit: f994bb8f1c94726e0124356ccd31c3c23a8a69f4

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


