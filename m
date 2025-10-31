Return-Path: <linux-pci+bounces-39913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 697C2C24B75
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 12:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99B6A4F2CA8
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 11:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20B33446AD;
	Fri, 31 Oct 2025 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OzUQ0PSj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XAYaSmbf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98BA3446A6
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909131; cv=none; b=U4FKCisbSZdS7zzugpqfgLqoKPeBqYrvmM6tcg+0bT7fcbTHVdl/3s6aaSUb/pWMt7+PvEdMnEz/8yLVqb3xhW4jlxboxQhgdOGU3oBeS4OgcdOcp0XppBrInr40FOogyfxIMNVGCbrrHMTjDxKuiJwqVmGRKNG9k90bzFenKUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909131; c=relaxed/simple;
	bh=rlbFRwarOM6xnyfugRGzoE/t6N2ODTzyxswtvuADIs8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MgJ6YhbNYbltgDvaZE1fltL+T1bmn5FNKeVcSOuZAGrOa1otGUyGlfMxDmpvzbjxoY6HwJLzbp6mHaWX1MCUJSRV8IZ0tAIbXfMnXBrfv+28T10VWTd2CxLOPDqy60pHC5oJIpHz6EJBG3CzuAbOQD6RxWIvNzE2Yhs2oMnVSv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OzUQ0PSj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XAYaSmbf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V9dVwt1418130
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 11:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RMnCXOzSniEt+BA8eQK9kS
	MP6BGd4fZ2+dvmH19PIiw=; b=OzUQ0PSj8FZ/a/rnW3C7Z9OH6WWbAjkM5JLpJc
	eVVQeay5K0AoJSEbIfrQmeA55k0VoJc5a7LVXmiTgDJX2XitjovH6m75u1hs9zWf
	clV00WlGLvn3SGdN84v4WWvqIHqnsJ4QNSAQF3XLqgLeSX3BId+VWr9yM7t/FZDQ
	/6FWOwCVNT58zKc+Di0bEHO87nSYXw6E52FRqxVyV58wScCrVU+wHXO4bjr5/hnC
	z+S/JY155N+BitloWINNRDsEN6SEj1HqSs+/OtikPmO327LriS7T2X9NpL9YXXtV
	mgHLmc/NgZ083xjw15g8+oe3oIcE8jJQUEh/EiYXg9XmymaA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4k69hhaj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 11:12:07 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-340562297b9so1520478a91.1
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 04:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761909127; x=1762513927; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RMnCXOzSniEt+BA8eQK9kSMP6BGd4fZ2+dvmH19PIiw=;
        b=XAYaSmbfzo9CPaHuG7cnWMYfFJVah+YBV1utOYzP5Ciagej7L1sp5g/cJWoxVj9B9s
         BdSDS+8+JLRsjx8gG26ZgkaXABzvY/w61ar48L/HSYzbNH4AhosDajhCGQK1urTJ+xIl
         ePg5zWRY+ZZs0t6UmgN2KT17Gl9T57kvZm+LaJZD8QktGAvjIBvU0QZqwGZfOdfPh0x5
         I0wFTB9YJxlpv6x1JKq0sm+FPfvh/l+Z76FkPSLyLe0u0HNiq5Za435vnNDuC33D4tOe
         d0rTLAb3lApwikj9RZPMChHwD7hpx/QGK1MCuA72/U+Ym/uLk90L7i+pc4lFMFqqW8L4
         jK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761909127; x=1762513927;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMnCXOzSniEt+BA8eQK9kSMP6BGd4fZ2+dvmH19PIiw=;
        b=sj3CxDatlQ1AzXzxKSEJqXEzTwfATIPJjgaaG1wo0rXe+NIIXp/xUtXHfwcm2gpGCD
         VfLjNxnlUfsBClOy1sGKMow1FjtL4n8QGfWfNhTYiOZYVhGrm9Xvz++1EfDrp55QAqr0
         2yl+rVo0LbFmSXeQ+c4mXMGY1Q9Y4bw9sR+dOtLxG6IgI0oFR1sFlJKWBf35+jJJKjpL
         O+5piBMeyhDlsauwZjNyoJtf+01u0QniLXRBzjKvRakHM8DP2wukg/Wc3Rlv/jB1SRDO
         YrZjZo7K6smCWtyDXLvVc2JRO8V1/NImIQmuRXIwKq+H/9VE+3w0RdZLXr12fYirNpcq
         oMQQ==
X-Gm-Message-State: AOJu0Yzz/3bgHj8ARwQDc4RSwvZn/beTmNq8R1DanCIuQDMXXXScyLVz
	JMr1iORTls7IltgRNRHKLYz7BqncoXjAmDlCh1Cd+J0vVlfiwYhQooM9HGqrBhZAccoQ5F18BZk
	3AIhF3u7fCY9Whb0TtLcljYpcIE5aYwDXGLcn7CwokE2LjOujkYpNX+yhz4w56S0=
X-Gm-Gg: ASbGncvxedyNGtW1U2cXzsSQX3OS/U0/R1C47AwdNUxRiN8jt8Oxk+QeM3OuvWUyS7U
	Pr61uV2SAvh8XFEzp2Bnjb14tTQOLtV5bBOTtYQABsmTBZ5ZAlZQip//p3ZUNaw3w4jlTpXrUO6
	nanZ3HrzilosL76k62vAhOcjllYlSQiWbDw+WHyP78pR3xg4i4BSj+zL0XPn6OdwdcQVs3z+Ltw
	Y+ihZjd4oRDdvN2BFpNpV92xP6a87A6tSdJLjs3DlUtbvv+9msZEYDipQ2UumdJMQviPjLBwjxl
	9WzF5MeO21S/5zkDtKVXSnHUgdt3O+ev/j+ORj4ZuBHb5W2tNyh5MN9WxpUoCrTpBvWdoivXIqz
	Xekw/LTbg5B97Af7vX+73WtiSHuqOUhdTMA==
X-Received: by 2002:a17:90b:2584:b0:32e:23c9:6f41 with SMTP id 98e67ed59e1d1-3407f9d235fmr4253745a91.5.1761909126540;
        Fri, 31 Oct 2025 04:12:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTApuYOuTWC3uZh+zi2uxMxBgaUFFtOoqClH39YHqSv9IQ1nVNxgzyI8wdgltuzOyfitm/lA==
X-Received: by 2002:a17:90b:2584:b0:32e:23c9:6f41 with SMTP id 98e67ed59e1d1-3407f9d235fmr4253675a91.5.1761909125764;
        Fri, 31 Oct 2025 04:12:05 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8d7793fsm1887363b3a.25.2025.10.31.04.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:12:05 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v8 0/7] PCI: Enable Power and configure the TC9563 PCIe
 switch
Date: Fri, 31 Oct 2025 16:41:57 +0530
Message-Id: <20251031-tc9563-v8-0-3eba55300061@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH2ZBGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyLHQUlJIzE
 vPSU3UzU4B8JSMDI1NDA2ND3ZJkS1MzY11LyxSTREMgM9XYWAmouKAoNS2zAmxQdGxtLQDc+xg
 /WAAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761909120; l=8172;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=rlbFRwarOM6xnyfugRGzoE/t6N2ODTzyxswtvuADIs8=;
 b=jZyA1mUBYjFVrWc1mInjQktwUHcx6+cQjn1UadRt0STn880ZZ8ezQVzu5oIeyDN0El+XhmXS/
 pjLhB46lOQjAVVWle/YIQFkQrYKvpIV9l5qcrvawurqf3hgs4EBkafQ
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwMSBTYWx0ZWRfX4ULgr/YHhmVd
 no4qbh7PYJ9udrdsbtuKjyFOdAyXkKVZYre9iZZpLexI3NJ7LhHs0wru3m2Ff+3KHPq7hDYh2Re
 /jVvp+2gqruY8i9LQTbnb7fp5usUICou5J+z4FqpiVVWSywC4/oBN7RaXJz3I+vi7X7KtZ4f6WR
 JZBMHH7FiBAMu137PcTaUXrzx2jUzmv1+y0fHN4DwDzwotPFd85YFi9lxIxZ2h7tCK9cMnRgdrq
 15oKQaqJfdsGoAUxZd/QBmPZLaV65GdznbNbCPyHDMj7DqK2+BoHeNrUwSSZq/7rSO/c0JUXOHy
 jTh0uDlzHI+ibUHcumOaEx3ilxH4juQ/8bT97CnC9rU95yfv8Ad6GzFbKEPKVA4OQ4W1BVMEBHh
 YOJUMJ+wm7MxaDX+QRgVjcsVjWVEkw==
X-Authority-Analysis: v=2.4 cv=Bv2QAIX5 c=1 sm=1 tr=0 ts=69049988 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=yKAn6K1XAAAA:8
 a=COk6AnOGAAAA:8 a=LYJiWw1m0VcFHw0g8QYA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=6M1ixcW_PCWoKiWyFx5v:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: RjOnEXX-c_olD9pRof6tODylzc9-R6SM
X-Proofpoint-ORIG-GUID: RjOnEXX-c_olD9pRof6tODylzc9-R6SM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310101

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
      PCI: pwrctrl: Add power control driver for tc9563
      arm64: dts: qcom: qcs6490-rb3gen2: Add TC9563 PCIe switch node

 .../devicetree/bindings/pci/toshiba,tc9563.yaml    | 178 ++++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       | 128 ++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   2 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |   9 +
 drivers/pci/controller/dwc/pcie-designware.h       |   9 +
 drivers/pci/controller/dwc/pcie-qcom.c             |  13 +
 drivers/pci/pwrctrl/Kconfig                        |  14 +
 drivers/pci/pwrctrl/Makefile                       |   2 +
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c           | 649 +++++++++++++++++++++
 include/linux/pci.h                                |   1 +
 10 files changed, 1004 insertions(+), 1 deletion(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251031-tc9563-99d4a1956e33

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


