Return-Path: <linux-pci+bounces-39988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 118B8C276FF
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 04:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6E344E06C0
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 03:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F114E25E824;
	Sat,  1 Nov 2025 03:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I5FEZNFc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CsrJv4UY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D9F1B4138
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2025 03:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761969586; cv=none; b=U8QykBkR+YXqMnJI6FS0eL22Yfud8X0N0hNH3sBVCeAMAsU+GiL8Aw4sioGgaiuoDeqmYzFDR8EBE3PfUSGKsUNzQpW8wA4ip65zfXwBsXSFcs4xieJjWx0jYEDnSD9q0hq1jh3YNEBDMMQGCEy1J1qtaNpEZKAo1DHggbg1LzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761969586; c=relaxed/simple;
	bh=AVFJeWhwjPeMfv4vZC+1z3aySCaKehRl8D67ckwLWlY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aloKhqOPHqU6hRqTLrpGnahHtCXDMr9XMr8X4u+h+CjvHXrtIDw9xXaOGvjyBgt6ZeMmm7C55YJSSCDupnEOoxMhwrnQbmx1eUvCHQhhqn8SpxrI+4yjTGHqdWbKIiRcRHf9WuGUZDhltOejx1iKhBY7Oiz1jWldmm7IjJxOg1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I5FEZNFc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CsrJv4UY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A13Ym6t428420
	for <linux-pci@vger.kernel.org>; Sat, 1 Nov 2025 03:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nS4VA2S6QxRvYf5zmxs18z
	z4+QdRrBTL2vqWGCC+Tho=; b=I5FEZNFcNxkhcwu7xuV/E6DqtyodcJ5L3nURDO
	cUHJduNuJwC9S11lQzzfPTXBfw2f/0oaWkOSQHAB6F28iSVcRvZlux7qcz/urJDa
	8gHhdXdV/Rky97zPIUP68bs7A90Bk/M5QCWySagN3bjvB5Wj79edEed3dLoa4wO9
	g6+ZOrJq6p0DI0EO2X0W1RBypCSMiSulOLdLQnTSlWm5//ujAsbLDtcvta+u9MGE
	WcV5Kj5FScV6325z7QH0U85xicsWly4NefSzEk4YwhloNZd7vWAOW8h5CH78xqvS
	H0s9K3FWV51dkhffqxoMChtJmlN0i21s8sCHdCNWl1BTS4pQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5ae300us-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 01 Nov 2025 03:59:44 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2930e6e2c03so32771655ad.3
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 20:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761969584; x=1762574384; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nS4VA2S6QxRvYf5zmxs18zz4+QdRrBTL2vqWGCC+Tho=;
        b=CsrJv4UYkvsgGVBCgGhu7Buqe0Gblc6jbv1QAbw08bhYCVxDTYr6K4NShW+F+5xXTK
         p9QFgSUBFEgCd/XyPaYIZ9ETcEdrrnhsZDV8hNRhKHFvvzFaokt7MJrH8kREYrHkYrFr
         l/pC7UUxTXKjNGfZawbXL35IFAfE9CV5BOt6J6s89pwGlP6imbLwgezEcEHe1T8U+3ZA
         zJJ59IHuYw1J/Ha6uCfo7o5mMv7+gnNG9NBVhEV5Jso6pvDwRMxzjVOJ0/2VWFsig4dK
         KpLxKWIqqO++HnxFoATipICM6PdFXC9pMC/fb0YuMeSArcJn6csanduuwAuTuTiGEYTT
         pndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761969584; x=1762574384;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nS4VA2S6QxRvYf5zmxs18zz4+QdRrBTL2vqWGCC+Tho=;
        b=oNnkpeELD6Fz0S52vU3zGZTySyyB4SLGpqaZMbBvrBK8a8G9U6M9SueNpql0DOPI+h
         Sv27sg4g7L2y2kH1c16fGJjFMp2q/NGW5Zb6y6jiFx1eDsm9N/AzWciA31Xa/mOJ+qOW
         bpTgtRQ4GlWxuBhoER1P/4ynfgazvX+eAAyWhEz49GMY7YI1juSmhv8TVcS/YBfNGp1M
         9iaC3b60XFHvPH3kcWGiZqfiTLvFivKplgT7mEKfzvhD1xjwztZYadnqybzVeUqFx3He
         6AlZ0VWbqcwpVbAwtfpdKsMKU0bvWHgfSdnKwvw67iND+teA4gLJWpmmKmgX05m12VCx
         4dug==
X-Gm-Message-State: AOJu0YwQ902arzZZRpCvCw8txzo0soSvcWDxUWIp6/3xGMUjrtpACphP
	jAtGds38pBFikVyoIPB0ZUnaUkrM3YHCFSlOPFIV1cOSWBI8EfodSYSXwUbU3HBtMUPTyEUbnkq
	Gw28Y1kAvrT1/AOtkxG0KK+kgYYd+hn8OQrsNoi5tTiCJJ9Hu9o6wXFxpUNKeMzU=
X-Gm-Gg: ASbGnctQtQJ2+LcaiAJ2qyEdUkpt7TI2rDX26LMyVp5U3kTTPdp8wgHL4gDPkNc9YG5
	ruSyVfxf8xJnhZwAEwQ4YIUPjQBnkIQW7Gu2oji5h3X0GODSBbcRy+UgWkqRd6qVuG0GAiInBkP
	/Qa5TIpoxHNRTk9f5L5jGCITBPzYpshRavqqn9F5Xk0CKZog+FnYtina3l34HZZj12kmHETer+e
	sQMOH1T5wmOGRxmKFLYmXzE5kxsGZN2HqFpDji9OBBSNHB3Z0vJnirVYjottUj22h9ScnSQKUIE
	OfVhy8dLBkxMmg7Yk0OFWQfEhzvZK4cf6pR0kJmD8rZZTKBpQQ5XFNeC8DF3QxqrS6e2zrsJyVQ
	CZ2UqXfcFbzGI4GdXOdtWcew04KRZW0x4tQ==
X-Received: by 2002:a17:902:cec7:b0:295:5668:2f27 with SMTP id d9443c01a7336-295566831dbmr12504025ad.9.1761969583326;
        Fri, 31 Oct 2025 20:59:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE5xXMxDCRfEogt8u0lCduW2jhsKu29eTg1BS9RJ1hxfwUl1jmGC7Ip7Vz358MzGpb31qELA==
X-Received: by 2002:a17:902:cec7:b0:295:5668:2f27 with SMTP id d9443c01a7336-295566831dbmr12503695ad.9.1761969582738;
        Fri, 31 Oct 2025 20:59:42 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268717ffsm41490725ad.2.2025.10.31.20.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 20:59:42 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v9 0/7] PCI: Enable Power and configure the TC9563 PCIe
 switch
Date: Sat, 01 Nov 2025 09:29:31 +0530
Message-Id: <20251101-tc9563-v9-0-de3429f7787a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKOFBWkC/2WMwQ6CMBBEf4Xs2ZIttYR68j8Mh1pWaSIUW2w0p
 P/uytXLZN5k8jZIFD0lOFUbRMo++TAzmEMFbrTznYQfmKHBRktUUqzO6FYJY4ajlVxJKeDzEun
 m37vo0jOPPq0hfnZv7n7rnyJ3AoWiq9VaIWIrzyGl+vmyDxemqeaAvpTyBc/3V3SjAAAA
X-Change-ID: 20251031-tc9563-99d4a1956e33
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761969577; l=8336;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=AVFJeWhwjPeMfv4vZC+1z3aySCaKehRl8D67ckwLWlY=;
 b=O6Gb7HXzuG4MiH5g8A4O+zWxImjei5v0cRTRVAyvrLcH3t285hfrXzvo/Lbrc6jm7OTFQu64s
 qhmXGrKeA1lBUKWueIuBjIuVaQk9m9bfifNjB0JdeHznmzZdMsIPwE8
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: 98XO1rRNFJ_EfeZa3xDtY7F6kf2Gmejq
X-Proofpoint-GUID: 98XO1rRNFJ_EfeZa3xDtY7F6kf2Gmejq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAzMCBTYWx0ZWRfX48TKecOj2W45
 +kyV8H1LXJudSPJWDYxlaPVimWwOaeic6Hk9e8u1PhhvRLk49xvQe240MstrLMhx4yBIJyPACn8
 NmGZxRCoxutTaCnCFOBDoWKLYTxkNh9024ZbQcgFCIklto3kTSUIoceIw7qInx1zFGgKYCvjrX3
 OOp/9BUCm7gte3Yp22hkdgYJhK5OvBfLiUyii52GnARgP2UslpnpO5muotPNGZr/Ot0AnMk9OtH
 jq/gD10V8Eby9DwpIuaZ/VYNWkhN6uGlcmkXf6aPtHr5l3lzp2FuhqYqC4PZF90B21izdMeecIN
 ku+hswF0r7C70IhND7aqdZPxjW7v02YAnA0f9wkc5F/rTywzlQzCV2O1rXbPpULqCWXQdpdZU2b
 BN+D8vONU+eXhNTg3G06GBYqPdQ1BA==
X-Authority-Analysis: v=2.4 cv=CfUFJbrl c=1 sm=1 tr=0 ts=690585b0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=yKAn6K1XAAAA:8
 a=COk6AnOGAAAA:8 a=LYJiWw1m0VcFHw0g8QYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=6M1ixcW_PCWoKiWyFx5v:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511010030

TC9563 is the PCIe switch which has one upstream and three downstream
ports. To one of the downstream ports ethernet MAC is connected as endpoint
device. Other two downstream ports are supposed to connect to external
device. One Host can connect to TC956x by upstream port.

TC9563 switch power is controlled by the GPIO's. After powering on
the switch will immediately participate in the link training. if the
host is also ready by that time PCIe link will established. 

The TC9563 needs to configured certain parameters like de-emphasis,
disable unused port etc before link is established.

As the controller starts link training before the probe of pwrctl driver,
the PCIe link may come up as soon as we power on the switch. Due to this
configuring the switch itself through i2c will not have any effect as
this configuration needs to done before link training. To avoid this
introduce assert_perst() which asserts & de-asserts the PERST# which helps
to stop switch from participating from the link training.

Note: The QPS615 PCIe switch is rebranded version of Toshiba switch TC9563 series.
There is no difference between both the switches, both has two open downstream ports
and one embedded downstream port to which Ethernet MAC is connected. As QPS615 is the
rebranded version of Toshiba switch rename qps615 with tc9563 so that this driver
can be leveraged by all who are using Toshiba switch.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v9:
- Change driver to align with dt properties (Bjorn).
- Link to v8: https://lore.kernel.org/r/20251031-tc9563-v8-0-3eba55300061@oss.qualcomm.com

Changes in v8:
- Rebase on the pci branch (Bjorn)
- Change order of the patch (Dmitry)
- Couple of nits pointed by (Ilpo)
- Change reset-gpios to resx-gpios (Mani)
- Link to v7: https://lore.kernel.org/r/20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com

Changes in v7:
- Rename stop_link() & start_link() to asser_perst() and change all
  occurances  (Bjorn).
- Remove PCIe link is active check & relevent patch,  assume this driver will
  be for the swicth connected directly to the root port, if it is
  connected in the DSP of another switch we can't control the link so driver will not have any impact
  we need make them as fixed regulators for now.
- Link to v6: https://lore.kernel.org/r/20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com

Changes in v6:
- Took v10 patch  https://lore.kernel.org/all/1822371399.1670864.1756212520886.JavaMail.zimbra@raptorengineeringinc.com/
  to my series as my change is dependent on it.
- Add Reviewed-by tag by Rob on dt-binding patch.
- Add Reviewed-by tag by Dmitry on devicetree.
- Fixed compilation errors.
- Fixed n-fts issue point by (Bjorn Helgaas).
- Fixed couple of nits by (Bjorn Helgas).
- Link to v5: https://lore.kernel.org/r/20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com
Changes from v4:
- Rename tc956x to tc9563, instead of using x which represents overlay board one
  use actual name (Konrad & Krzysztof).
- Remove the patches 9 & 10 from the series and this will be added by mani
- Couple of nits by Konrad
- Have defconfig change for TC956X by Dmitry
- Change the function name pcie_is_link_active to pcie_link_is_active
  replace all call sites of pciehp_check_link_active() with a call
  to the new function. return bool instead of int (Lukas)
- Add pincntrl property for reset gpio (Dmitry)
- Follow the example-schema order, remove ref for the
  tx-amplitude-microvolt, change the vendor prefix (Krzysztof)
- for USP node refer pci-bus-common.yaml and for remaining refer
  pci-pci-bridge.yaml(Mani)
- rebase to latest code and change pci dev retrieval logic due code
  changes in the latest tip.
- Link to v4: https://lore.kernel.org/r/20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com
changes from v3:
- move common properties like l0s-delay, l1-delay and nfts to pci-host-common.yaml (bjorn H)
- remove axi-clk-frequency property (Krzysztof)
- Update the pattern properties (Rob)
- use pci-pci-bridge as the reference (Rob)
- change tx-amplitude-millivolt to tx-amplitude-microvolt  (Krzysztof)
- rename qps615_pwrctl_power_on to qps615_pwrctl_bring_up (Bart)
- move the checks for l0s_delay, l1_delay etc to helper functon to
  reduce a level of indentation (Bjorn H)
- move platform_set_drvdata to end after there is no error return (bjorn H)
- Replace GPIOD_ASIS to GPIOD_OUT_HIGH (Mani)
- Create a common api to check if link is up or not and use that to call
  stop_link() and start_link().
- couple of nits in comments, names etc from everyone
Link to v3: https://lore.kernel.org/all/20241112-qps615_pwr-v3-3-29a1e98aa2b0@quicinc.com/T/
Changes from v2:
- As per offline discussions with rob i2c-parent is best suitable to
  use i2c client device. So use i2c-parent as suggested and remove i2c
  client node reference from the dt-bindings & devicetree.
- Remove "PCI: Change the parent to correctly represent pcie hierarchy"
  as this requires seperate discussions.
- Remove bdf logic to identify the dsp's and usp's to make it generic
  by using the logic that downstream devices will always child of
  upstream node and dsp1, dsp2 will always in same order (Dmitry)
- Remove recursive function for parsing devicetree instead parse
  only for required devicetree nodes (Dmitry)
- Fix the issue in be & le conversion (Dmitry).
- Call put_device for i2c device once done with the usage (Dmitry)
- Use $defs to describe common properties between upstream port and
  downstream properties. and remove unneccessary if then. (Krzysztof)
- Place the qcom,qps615 compatibility in dt-binding document in alphabatic order (Krzysztof)
- Rename qcom,no-dfe to describe it as hardware capability and change
  qcom,nfts description to reflect hardware details (Krzysztof)
- Fix the indentation in the example in dt binding (Dmitry)
- Add more description to qcom,nfts (Dmitry)
- Remove nanosec from the property description (Dmitry)
- Link to v2: https://lore.kernel.org/r/linux-arm-msm/20240803-qps615-v2-0-9560b7c71369@quicinc.com/T/
Changes from v1:
- Instead of referencing whole i2c-bus add i2c-client node and reference it (Dmitry)
- Change the regulator's as per the schematics as per offline review
(Bjorn Andresson)
- Remove additional host check in bus.c (Bart)
- For stop_link op change return type from int to void (Bart)
- Remove firmware based approach for configuring sequence as suggested
by multiple reviewers.
- Introduce new dt-properties for the switch to configure the switch
as we are replacing the firmware based approach.
- The downstream ports add properties in the child nodes which will
represented in PCIe hierarchy format.
- Removed D3cold D0 sequence in suspend resume for now as it needs
separate discussion.
- Link to v1: https://lore.kernel.org/linux-pci/20240626-qps615-v1-4-2ade7bd91e02@quicinc.com/T/

---
Krishna Chaitanya Chundru (7):
      dt-bindings: PCI: Add binding for Toshiba TC9563 PCIe switch
      PCI: Add assert_perst() operation to control PCIe PERST#
      PCI: dwc: Add assert_perst() hook for dwc glue drivers
      PCI: dwc: Implement .assert_perst() hook
      PCI: qcom: Add support for assert_perst()
      PCI: pwrctrl: Add power control driver for TC9563
      arm64: dts: qcom: qcs6490-rb3gen2: Add TC9563 PCIe switch node

 .../devicetree/bindings/pci/toshiba,tc9563.yaml    | 179 ++++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       | 128 ++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   2 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |   9 +
 drivers/pci/controller/dwc/pcie-designware.h       |   9 +
 drivers/pci/controller/dwc/pcie-qcom.c             |  13 +
 drivers/pci/pwrctrl/Kconfig                        |  14 +
 drivers/pci/pwrctrl/Makefile                       |   2 +
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c           | 648 +++++++++++++++++++++
 include/linux/pci.h                                |   1 +
 10 files changed, 1004 insertions(+), 1 deletion(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251031-tc9563-99d4a1956e33

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


