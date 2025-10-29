Return-Path: <linux-pci+bounces-39630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7D4C1A0C3
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 12:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181351A2182A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32010214A64;
	Wed, 29 Oct 2025 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h/ZmG+RG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EfBNZa4h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6208432ED4B
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737413; cv=none; b=ftqFN2nfEwQgt3aQiVtBA8zkPzLEUpBzfkueelXXr28+BGNXGPLOQD+A4pIdQ4T5ga3C7H9jBnzMZs2DKpGmtcHPLrX6v568Rr4TKC8zW+8d+2djvULq0KUEzg+7E1UIQwzKmuER4hPobjDwzcE8qvaMC7fQX4jRXXfyYhvlqCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737413; c=relaxed/simple;
	bh=R1ym5za/YxWveqf8yqW0XLv+wHPbUS9FbYThihnVuwo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YbRGCBzTrrsrGT+U5LiQonYUFFugPOXsBNxKlKHNYFtOKotNa7G0Fb/eLCV3VaTmx8vG6TTtJ2My99F2ox/M2iRszkeuiVbl7Ntr2nmApPeLIOVaWGxp16Bb4yldM/3C23EJBwf3B1U55lgBjZU8Us0BcGA5jUmhVoXu4oPrCCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h/ZmG+RG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EfBNZa4h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4usMX3757545
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 11:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=y2jm9dDHlt5T0Ww3rdQuy+
	Lar+Wls5nknPdT9+n/cKI=; b=h/ZmG+RGoH9pG0BiiGDv4tYKhgoaATxZgX8AAR
	MaxDEkM5y3lkB7H9czQQCS2rDx2tAJ3q8Yr1vA9EnxuiOIQTsbDUc17abckMYNbM
	k7v42vZ397tHxg889o4zpcovxeyxfDFZCr9XW2i/Fi8rcgwvNfSqLSxStL9WX7ee
	a9x5bvRgKiJjWq1vya5XVL3vYawvGV0Km7OVbdnH0IoPnioxOJ3Ykhbhx9Z9hviE
	KZZtOopzIGeffTzgEeGIzfplv7c+Qa74FqCIC3yO8flXZ4eU+bcFZpG+cZI7krqG
	7m8NW+fnS7KCvJlVobEeuE6NrczUkUBMMTWeKmA22deRXSVA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a349y2bhe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 11:30:07 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-290bd7c835dso68017225ad.3
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 04:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761737406; x=1762342206; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y2jm9dDHlt5T0Ww3rdQuy+Lar+Wls5nknPdT9+n/cKI=;
        b=EfBNZa4hzEVkmCMtHZEDCAFpEYxDsJTGtt7qMfs4pbWSTzDINub07r/u0mqywpD4Nj
         6suLmhQmpmlmlgZWgvDGYl8ZYUQlKPTQCF9spv4/eiF92K7GUmykVZVVPm57W4mA9qKL
         BvPbQ153c39+FPgczVxoFhGVG/2ZIj+mw2YrteqZ6pvKa42ppad664t8WJLrwIdImrP7
         noVvr52+GSGArd5wc4c4FG7uf7bxDhxPwPAacMqv9yKpONTDUXQ95CrUMrTfDDIIdK6N
         /0IDzsU2qG6oBokGO1+5isGYS2JuskLk+0Hx48uIfTCBtSV68L9Lr0eBNmtR4Q4w6LRI
         Oq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737406; x=1762342206;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2jm9dDHlt5T0Ww3rdQuy+Lar+Wls5nknPdT9+n/cKI=;
        b=rC+1BAovZbHGsQ8UrQZevSPeK92lpvdtHLS9qBwI+ryn+DmUdrR0MQYHJee2AyWyc/
         GDdcmEvukLKUlrF3nrbxFw+G/jGKnHVsWMN1rl5BYV77VTS8HzkQzoRtKjtpW5fSUKYJ
         IEPzHl6WPBRvtXe3Y5PDEE9ma9rhNJmwbWzeEtaI/TLUk+o1VFOUgVOkuW4iPvat0FdB
         Co8qmwkw2l9hQZjn9wEN57M9G6ACpYYj2x7YuHhvU/tzcKBpEJemGvshKwyhxHh1pVoD
         pa2yv0qa5wMDNfFwg6m+CMOG6p8Lqhg2pZFoRmD8Ldrx9hVJPWH6MbIAZoLF50MVmocH
         qr9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtjq8HsJMS1smdIuIRNUwXJooRFziH6UyS60K8DjJHvJ8+GOTLvpBZQxaiQQMpvOFtbeAUv9nY7I8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUIpPpE2NQWk/nudY0xVIzB41ima3GBE5L71xt9016yt7g1ylx
	BEOpYhdQjNgICKc3ANzMFFgQfwQJhQMFS+IPpiKYehAziYzk8WT60rrcyg/OEC1VOAuYAzP60/v
	y02LXqbNqHXC0mwU0ZCZ/7qQmD0GgzQdqj6PEPv71WwoEK0huedHeyDUzzdYCXG4=
X-Gm-Gg: ASbGncu8Vp5En9iR+QvA3e8IGY9upQMgjuD4xs3BMCaaYuAjaA1rP9l7Hz9CZzEQvQS
	qSdIkLCs76lD2jbQtVFkDrb929tAlpueLLcefS2zSRq1SiC+zgIiRrrNG1CBr5BQUml9drM+95j
	aKDlJZ/u+GgU4BsmHixdjrGOY98iIPjikjEPtj5b4eySdLPc6hftsJxkw+yY1sxTMQy34vOgNbB
	g1+MZ2qobmFctkM6x9GLa79wbqiwuuQil9GfcI9QUlHdBibUMPUdKPu5GArmjkqzdvCW00vaxGt
	NEXH3UuPwzsX7TyLm0SvxQXScUs4IyCqnn2a1Sxwi28nGEZMudGZTunCFRe8/Y3citpSmCJJ9oQ
	1n4JsUfokGC5ph8QnjyaE5IYyVMEkCaV3Ag==
X-Received: by 2002:a17:902:cec1:b0:275:2328:5d3e with SMTP id d9443c01a7336-294dedf4a48mr38764575ad.18.1761737406160;
        Wed, 29 Oct 2025 04:30:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4QuNCki4+zixZpMZK9vnl/SsRQHgfutzx405yAsnm6xucYwg8APiRkZJ1SC61gScEpYJOwg==
X-Received: by 2002:a17:902:cec1:b0:275:2328:5d3e with SMTP id d9443c01a7336-294dedf4a48mr38763585ad.18.1761737405134;
        Wed, 29 Oct 2025 04:30:05 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d429c6sm152154935ad.85.2025.10.29.04.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:30:04 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v7 0/8] PCI: Enable Power and configure the TC9563 PCIe
 switch
Date: Wed, 29 Oct 2025 16:59:53 +0530
Message-Id: <20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALH6AWkC/3XP3QoCIRAF4FcJrzN0dh3drnqPiHDXsYRqay0pY
 t89t4jo70Y4wvlm5soidYEim46urKMUYmh3OejxiDVru1sRDy5nBgKUAAn8sI8o1TKVS8m9IQR
 vpdQGWW7sO/LhfNfmi5zXIR7b7nLHUzn8Ph18c1LJBZeawDlVQQ121sY4OZzspmm320l+Bv1RB
 fVdJWGwKKyunTff1WGTpF7Ty48rksqEqtEKlAV4av4Q+CIMmHcCM1EZ5SthtXOi+EH0fX8DH7u
 eKW4BAAA=
X-Change-ID: 20250212-qps615_v4_1-f8e62fa11786
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761737398; l=8142;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=R1ym5za/YxWveqf8yqW0XLv+wHPbUS9FbYThihnVuwo=;
 b=bjXMRd2WO29QEf6QHKNYgV7NOKh0WLgIi02TP4pxrqdsKJFGFfIjo3fQCVGJcZiYaQi2nf1Vp
 UHhcG2ULBeiDfn0h7soAhL7KTlWxDbcQF7DkKtL5xH0YpkfQ+mKoojl
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=D8RK6/Rj c=1 sm=1 tr=0 ts=6901fac0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=yKAn6K1XAAAA:8
 a=COk6AnOGAAAA:8 a=jdgvuftHn8Q9ZZcfGlkA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=6M1ixcW_PCWoKiWyFx5v:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: PluBD2Gb_vsUOsIUgqvoNPm2F0eGG1Rt
X-Proofpoint-ORIG-GUID: PluBD2Gb_vsUOsIUgqvoNPm2F0eGG1Rt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA4NSBTYWx0ZWRfX3MBiRh5/u7C4
 mmd3X92Sbee91VJQydZJyOtoWOsER35idYIzdBeMjA6KV7yMkGXU23TXx0OVnXYk9AE8xh8YLAV
 vPf8SuEdUdRsfPeD4hZoJfalBaThpLE6BNPFZfo/gGix2SzJpydkSeGPafd0yXTVNTsHeZDwRJc
 KHNdWMHpAaHjneGcZ3Pnl+0aYBIHop3Q94aAv1wyglYrRrvgYACzHjLtWo2WBPBRIH9Atn11ee2
 voKmc9efjj7+ApC116yQMobTQeJ27/ecQA+DvJA5pbuWRsdx38H++lL/bLA5+RrhDC3xg22c7NR
 htaSPJtwRVHV4lAFC0lFFo86KGEEmz2jKR/rRPnbMrXE6rRcdcBuzacRk86JFShDtk0HoT+zxC3
 cFXab+4WPzFCVjD9csaxrC/oFzddYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_04,2025-10-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510290085

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
introduce two functions in pci_ops to start_link() & stop_link() which
will disable the link training if the PCIe link is not up yet.

This series depends on the https://lore.kernel.org/all/20250124101038.3871768-3-krishna.chundru@oss.qualcomm.com/

Note: The QPS615 PCIe switch is rebranded version of Toshiba switch TC9563 series.
There is no difference between both the switches, both has two open downstream ports
and one embedded downstream port to which Ethernet MAC is connected. As QPS615 is the
rebranded version of Toshiba switch rename qps615 with tc956x so that this driver
can be leveraged by all who are using Toshiba switch.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
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
Krishna Chaitanya Chundru (8):
      dt-bindings: PCI: Add binding for Toshiba TC9563 PCIe switch
      arm64: dts: qcom: qcs6490-rb3gen2: Add TC9563 PCIe switch node
      PCI: Add assert_perst() operation to control PCIe PERST#
      PCI: dwc: Add assert_perst() hook for dwc glue drivers
      PCI: dwc: Implement .assert_perst() hook
      PCI: qcom: Add support for assert_perst()
      arm64: defconfig: Enable TC9563 PWRCTL driver
      PCI: pwrctrl: Add power control driver for tc9563

 .../devicetree/bindings/pci/toshiba,tc9563.yaml    | 178 ++++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       | 128 +++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   2 +-
 arch/arm64/configs/defconfig                       |   1 +
 drivers/pci/controller/dwc/pcie-designware-host.c  |  19 +
 drivers/pci/controller/dwc/pcie-designware.h       |   9 +
 drivers/pci/controller/dwc/pcie-qcom.c             |  13 +
 drivers/pci/pwrctrl/Kconfig                        |  13 +
 drivers/pci/pwrctrl/Makefile                       |   2 +
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c           | 639 +++++++++++++++++++++
 include/linux/pci.h                                |   1 +
 11 files changed, 1004 insertions(+), 1 deletion(-)
---
base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
change-id: 20250212-qps615_v4_1-f8e62fa11786

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


