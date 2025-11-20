Return-Path: <linux-pci+bounces-41732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82178C7271B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 07:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 7A3D02A29C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 06:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA37530594F;
	Thu, 20 Nov 2025 06:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j3iXlwm9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fpsiXIoe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CB33054CC
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 06:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763621498; cv=none; b=TNevbFZCW5s5507gRc3iP5EdMbuL7pbAhFlZjbVg0J4q5Z4aBHKhu+Aokl8O84l0keXcw55jMgzGOii7qg6tbJ8POa/LlPruIxUDRhB1esAzbNxvbnL4j5Yq3vcN/q1pJhmTd2me9HW+srnXe/MAj16zDVKPkj67mY6RZ0cD7Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763621498; c=relaxed/simple;
	bh=t0DM0ZEsY9cfquGHzkVaBXOxvIaB5yQEXWWEL9Js4mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+2uwpF7arpSgVu4OFDRa44Vn7etqdchwjV2JthosRifKayeQSORoCaAcIWtHhfc94XxToaB/xNNai/uabvR4CbcPe0N1izaN32OMzndMvlaHmo0tXCx2/zpgtBe/SWlHzbUipZDppZYg9BWMQ5DEbhtfufM77vzFxFSqLrBk+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j3iXlwm9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fpsiXIoe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AK4pXve047714
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 06:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=0Xut0bMq7t/
	itRF84iEQ6e6NbnsU9ncOu2shMkWFW2s=; b=j3iXlwm9ipuUX4aAS+NigZYLirT
	c1jNpnEXPHEvwLrKysMqkcw0GUx2iKoCVzD81ueDAVbcii8hJ49G38DUYOrmvFfT
	I7RgQ8K1FHGIRRAEhXQtivEw421OokEzvwTvNpz3AVTE2VJ17Y4Y+4wD6mG3/eyO
	oL70sXurXvkP/7cnjCCA2potP1+j1IAqEgKvYRGQmz4C9LjymXw3hhuLpsVTere4
	8PBHYb4pbXUZA2Iey/ImB3QWDLwmUbzSdb5SU5u8wAwovY7PxdVSMW7ZXStP4sgP
	el/RdVsmzsIWCMt2FHaz7TEkTc83odkO5/auK9pP64F27luN6Rjo0UNnBhQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ahcqnk41f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 06:51:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-343806688cbso1354579a91.3
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 22:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763621494; x=1764226294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Xut0bMq7t/itRF84iEQ6e6NbnsU9ncOu2shMkWFW2s=;
        b=fpsiXIoehjGSwaBuwGoz/Ezcpf62v2bGOAVd2F7MPLlpKTJcaL+i4i8Ig1F/DoscYO
         kkEA/TqzCTii2C+VwdI/xC1Z002hJFqqg99DpsntBDHQPWRpBH8Ek/LALxBUv2DVDpib
         Q1/FKuoR63cdOfbmMNcx90qHICzCUYVU7MqRqZOCyD/GiNuob/iRQ4e75t81cboazpdb
         O8o3XUx6ErhG52q71HQbGoMNy81XK+E39y7QCY0EoYkQfcJxm4XfGHdgdzM8U/iDBjqf
         4cyL0S2lHecu02wKiAKiHt+qq341awen4JJWp1/0I6J12ztj1nmfS4VXyHkw0+9eTkf1
         z7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763621494; x=1764226294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Xut0bMq7t/itRF84iEQ6e6NbnsU9ncOu2shMkWFW2s=;
        b=OqHPM56B6/PSW84ZtjT3NGWbLWwQ59r2CFLXPfROYCnmbQDflgpXR/9Tnjpw44Tbwr
         67ao1ZTL+UlyzNSqempxUccPc2/xwY3BSvzS8BB5T3kdrjEwETBxW/t5fWLFVv5+067b
         tuMp/Ypm2txyqltUR7L3vzIhh6oTnEEuXC/WaX4YAOWtdxrJ4woz3B4bint18nYW9Tci
         GY36/tydYSgAcoh7ittvnLUoLDR1OIDngciP/hLrSyuoplPiGEWwMtZDARl+k2uypdsU
         I38enquWgHnuQg5wReplI2kvUSYE/TN3MW0Sr9pOO2NnyETPaHK53lBLq1Ohvwyk/dc/
         xiBw==
X-Gm-Message-State: AOJu0YyQ3K7UNn5Vq56Cwa03PmWfbtUacqNitoBmmLsVsPdMkJDCSPsw
	wpUtJQ6cpT1nXpvPoStpzPfnzvPsMCQDY8WL48/hVD6Zg7kQwNSumMm1qPNMFL8YIEHc8pGuQQH
	3Y5Lh2mZrh09pQCglSV8ofH7//NOngCILxdoCvrtug78Lqkj0NHqGAwQvBc8//bY=
X-Gm-Gg: ASbGnctL0PjA6/7JLnEnnqGa+jgftsb7nQQoClli9GomyFeFi708Gu1ER5Wa/YbELWC
	mmT4M8ALmqi5NQgYizFxoFsThfA215upyZZVBb0xmZynvp9C9jkr+jMFxyZ9hcLLm7n2bddn7Gf
	rcM9pLl+w0+yf/a9JBYKO+e3NkjY4lfbaL483ilt+eTcsfljvWmjh0ZjQdoiZW2oceo5iN+1JVf
	clCJ8rPsivd1WyPbhdYMrFoduxLAMCGPrulZRj3Md00MWM+hM8JhqSZaN0RxTvtn8PJmcRg3fiX
	XPCuAUvESRLEeVVOjhysN/I15XMZ+0qmlQ07hsIW54NiSz1qvlb8mpQUfYx0mH1FUKt9QHRGPIk
	=
X-Received: by 2002:a17:90b:2d0c:b0:341:8c8e:38b5 with SMTP id 98e67ed59e1d1-34728514dfdmr2186654a91.25.1763621493915;
        Wed, 19 Nov 2025 22:51:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUIM0JhCPx/Pf2BAh6B5XedE9FIGzxDTnIZWCaaYmfncZJ/GTMhDKXnt1ZHfiiBzYKbYDXBQ==
X-Received: by 2002:a17:90b:2d0c:b0:341:8c8e:38b5 with SMTP id 98e67ed59e1d1-34728514dfdmr2186626a91.25.1763621493456;
        Wed, 19 Nov 2025 22:51:33 -0800 (PST)
Received: from work.. ([117.193.198.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34727be33dbsm1292681a91.8.2025.11.19.22.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 22:51:33 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, brgl@bgdev.pl
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        krishna.chundru@oss.qualcomm.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] PCI/pwrctrl: tc9563: Enforce I2C dependency
Date: Thu, 20 Nov 2025 12:21:15 +0530
Message-ID: <20251120065116.13647-2-mani@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251120065116.13647-1-mani@kernel.org>
References: <20251120065116.13647-1-mani@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDAzOSBTYWx0ZWRfX0mZj0uq+m/jq
 67o0imAzOlYdoXlRmr8Sfl/fDg1RJdUkMjltYJj5ehMy956KDlni7d1Ob8jK89akCcBhMZ/qX11
 7Nn4qhowhye9B1w2Nh/SwmvuDiZwjw4FaVj/m3eCjp5U0ma5+LDFrI/KDMUwh35g7ufLxPtEEt7
 hPDRKcsFDF7W469UWpQTsA3o8cL3Mtkx+HdFf4YQHtDyKhgugmJDHmyUZ5r76wjVNWJO5U3c/KW
 Cbj7hYjYnf2yrw1hsv9Sr8LO2hFOEZjO/n/NcgPfV91hwuQ5aO/FpGRaOyqLtxfRYrMYprqIzvc
 iuVJ+YxfPDl9QIqYOlKhEfX/CX72cJmlR+9PQgfeUDL7ZN0RrMecXbF8uA4fLgV97Uon4zyJzor
 Pw/vFnHIp3/IdI5L4faYTRnRpPBeCA==
X-Authority-Analysis: v=2.4 cv=ApfjHe9P c=1 sm=1 tr=0 ts=691eba77 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=UMbGOA4G/0oMlBJKcU414A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=UMpyiCEZGz9FoZQ1JnEA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: G8Z_3Ntquo0s4q-RYVV0bdFWm2B5A7Tp
X-Proofpoint-ORIG-GUID: G8Z_3Ntquo0s4q-RYVV0bdFWm2B5A7Tp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511200039

This driver depends on the I2C interface to configure the switch. So
enforce the dependency in Kconfig so that the I2C interface is selected
appropriately. This also avoids the build issues like the one reported by
the LKP bot:

   alpha-linux-ld: alpha-linux-ld: DWARF error: could not find abbrev number 14070
   drivers/pci/pwrctrl/pci-pwrctrl-tc9563.o: in function `tc9563_pwrctrl_remove':
>> (.text+0x4c): undefined reference to `i2c_unregister_device'
>> alpha-linux-ld: (.text+0x50): undefined reference to `i2c_unregister_device'
>> alpha-linux-ld: (.text+0x60): undefined reference to `i2c_put_adapter'
   alpha-linux-ld: (.text+0x64): undefined reference to `i2c_put_adapter'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511200555.M4TX84jK-lkp@intel.com
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/pwrctrl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
index b43fdf052d37..e0f999f299bb 100644
--- a/drivers/pci/pwrctrl/Kconfig
+++ b/drivers/pci/pwrctrl/Kconfig
@@ -26,6 +26,7 @@ config PCI_PWRCTRL_TC9563
 	tristate "PCI Power Control driver for TC9563 PCIe switch"
 	select PCI_PWRCTRL
 	default m if ARCH_QCOM
+	depends on I2C
 	help
 	  Say Y here to enable the PCI Power Control driver of TC9563 PCIe
 	  switch.
-- 
2.48.1


