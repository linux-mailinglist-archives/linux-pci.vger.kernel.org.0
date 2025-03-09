Return-Path: <linux-pci+bounces-23200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 729A8A580BA
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 06:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9BD9189064B
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 05:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBDC1311AC;
	Sun,  9 Mar 2025 05:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CWxto7e8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EB53010C
	for <linux-pci@vger.kernel.org>; Sun,  9 Mar 2025 05:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741499171; cv=none; b=Z8O0Ar2ZqM8J+oX5det7f50TczaP0+z44+kCOdiPYLn/2QpipDoYQjxKqnPc+YRbu94AlbPnYvK5/Ui0gVY/1SYaOikuopMpuUxjtEuOAuhfOp8IFySA80+A6kY3D/JJC23sd2KELk6QZfJpjXrAMa/w8x6jV/jRoZp9IdNCH9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741499171; c=relaxed/simple;
	bh=qy3a3LhatXmhBiVGfseaHNNeFmAru0icw6KGdow2L6U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mRP57c68XcK0O2ZU4BRcflXhdTAt43UxRb8CI8vgy0Blh4F7lWYzdgiGXYUl0xQBP51Ek6/9OJC7qYlbNTK+UpcKB7jilcLhSr38gFSCmpk8yt7TwxugVJKzU4ZGPFj3/dHrqFeINVT89u85wT40u5Y3mBN2PbZ3EZaxXwSdTxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CWxto7e8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5294wKoE000434
	for <linux-pci@vger.kernel.org>; Sun, 9 Mar 2025 05:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7rDxeiLzUOR4yzkct3q3Hx
	wISzKuzG++MdmkzWiLy2Y=; b=CWxto7e81Agw7mn27Y2/iNbyFUBQ2vliwXLKJ0
	0S4AMwDt/eTVb+QfwwzDxAGZXgvsA0Pe/1caB3ozEs5QaPmpOAGN3y4wSKo1XfHg
	CNAcUC8Xq3sD3aU0mE6BfcUt2hsoijMwU8rqoWZPyBXsHe8oKulP7lXn/9mAtZUf
	h/Cw6dE4cCcdH8JqA1J3HqPmC/bXcpeT1VDFFEoUiOzHACH0eSGaa7g6hWZXDAfu
	g4ggq8V3TxZvw/CVwCfb/gHaMWik4DrtJue3EUp8iY8ldUzbspgZFHwvtyA5t42j
	sLY1HiWupdlomavOxDdCmuaoKK14hr+d3J/CT342iO+EthuA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458eyt1nxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 09 Mar 2025 05:46:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-225429696a9so27411115ad.1
        for <linux-pci@vger.kernel.org>; Sat, 08 Mar 2025 21:46:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741499166; x=1742103966;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rDxeiLzUOR4yzkct3q3HxwISzKuzG++MdmkzWiLy2Y=;
        b=YdYY1AIFWp0OIvSEO7AXhB06DXlTSIkczLuJEk2YE/fkESgC7g4D3g6ZvPfXz9YL9h
         NZgg6U1J/TVm5eKzMvMP7o0r6VNeuXDsU2LGnfC3939KTgnbW+6jDFNcFQpvUq4t65Zp
         coPwiKdIMbJmrwmt5McJHzOhh1TNAn99qS0HCQY+RLbcMjL2LajZQHcf7cY/exg7yBp9
         nAFOxTFfntR9gLcIzMrQ9r7HBXVQkYliXTO1mJHTKblrwjoe9GskXmPtg0maatuTLydn
         Lchfgg3mW2jtWVoRpXYX3AFbO9nk/S8+O0qJfwTspvzKiV6bb5bgT69p7KLrjA0GieUr
         88zw==
X-Forwarded-Encrypted: i=1; AJvYcCW45lJCEFSReRlHmDLl9wfMlP2L52FTP+Ba2Z0TKgCRyqoL+QwP5r+IKjVXzucTrsFrdKVerNWwjb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa3ZKxgkJOJ+to2blqgFCmNESFilZyIZstc/D54K7yYJqC5dkm
	P7RUXnLzfqZ/XMPz07ciWqgvPodY+xJZ034BqQ2sS1Nhzw0kICB9AnPwGQrI6z8A/M2rsC5Ed6v
	yPJhP3D4zcl5ppui0zpy6T7ODEwyPJTL1XMhRvMmC9ssKfWkjS5IEmbcGMzCh8KgGHvU=
X-Gm-Gg: ASbGncv/UTP7fPRqzS5ZzKM56NDbonfS/jI3FBjWqcjlY2WX98mmT70VjkMkuzIYBFh
	/627zedB1DetZQ2rW6W3j/5JFhWTLdm7Wa+Y8xGFeDxkTr1AUM3FSJQT44yFu9p/JBMojBv9rkv
	pvLHUTSxTJQOTRC5TLOP41x1665PUSQ6hH/IijyVmzMXaKRlEy7rAmQ38Qg8PsIO10sQPqFOQT8
	3+C3uEizgajvkjRQIH7lla0dbU1zkRcJve68qkPgljHavaI6Gm+mq+ruLbe+RLd/bKQ7EzT9fXA
	5IEnOA0cc8mypxaY5qXijyutFj4dcTKGO6XpaktcNUKmF6OU4Zo=
X-Received: by 2002:a17:903:22c8:b0:220:cb6c:2e30 with SMTP id d9443c01a7336-22428ad565bmr149146805ad.49.1741499165972;
        Sat, 08 Mar 2025 21:46:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDZximE4vMb6xW2gdzO5/opmMvmOC9BaBFAwRe/SdmWmKoB3irb2IryAb3yHX/w3gKQ4AXkA==
X-Received: by 2002:a17:903:22c8:b0:220:cb6c:2e30 with SMTP id d9443c01a7336-22428ad565bmr149146425ad.49.1741499165519;
        Sat, 08 Mar 2025 21:46:05 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddbe7sm54887145ad.32.2025.03.08.21.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 21:46:04 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v5 0/7] PCI: dwc: Add ECAM support with iATU configuration
Date: Sun, 09 Mar 2025 11:15:22 +0530
Message-Id: <20250309-ecam_v4-v5-0-8eff4b59790d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPIqzWcC/2WM0QrCIBiFX2X81znMlGVXvUeMUPev/ZBzaUkxf
 Pdst8HhwHc4fCskjIQJTs0KETMlCnMFtWvATWa+IaOhMgguFBe8Y+iMv2bJRolW26M+IFqo7yX
 iSO/NdOkrT5SeIX42cZa/9d9Rw5mWVg0KneL77hxSah8vc3fB+7YW9KWUL/bhhHKlAAAA
To: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741499159; l=4752;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=qy3a3LhatXmhBiVGfseaHNNeFmAru0icw6KGdow2L6U=;
 b=iRvbxORLMVOnGBDgjBm5+tfGCMfr1FOcAA/1PUf3cXc4AiiAZZ0V7476WKFR0syX5KCtnkMGc
 VgMIfrmuQo/C/k8c694pqvgtsmTRDhEIW+nx+rF8o38Afk9R8ObL7WM
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: OEqr325qRdK9VLHFT1YiAU5absg6-rKg
X-Authority-Analysis: v=2.4 cv=CupFcm4D c=1 sm=1 tr=0 ts=67cd2b1f cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=7ZRfWG0Ds4o22ekFdNEA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: OEqr325qRdK9VLHFT1YiAU5absg6-rKg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-09_02,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503090043

The current implementation requires iATU for every configuration
space access which increases latency & cpu utilization.

Designware databook 5.20a, section 3.10.10.3 says about CFG Shift Feature,
which shifts/maps the BDF (bits [31:16] of the third header DWORD, which
would be matched against the Base and Limit addresses) of the incoming
CfgRd0/CfgWr0 down to bits[27:12]of the translated address.

Configuring iATU in config shift mode enables ECAM feature to access the
config space, which avoids iATU configuration for every config access.

Add cfg_shft_mode into struct dw_pcie_ob_atu_cfg to enable config shift mode.

As DBI comes under config space, this avoids remapping of DBI space
separately. Instead, it uses the mapped config space address returned from
ECAM initialization. Change the order of dw_pcie_get_resources() execution
to acheive this.

Enable the ECAM feature if the config space size is equal to size required
to represent number of buses in the bus range property.

ELBI registers are optional registers which are part of dwc. So move
ELBI resource mapping to dwc. Also change the dtbinding and devicetree
to make the elbi registers as optional one. Having ELBI as the required
one is making the ecam feature complicated.

The ELBI registers falls after the DBI space, PARF_SLV_DBI_ELBI register
gives us the offset from which ELBI starts. so use this offset and cfg
win to map these regions instead of doing the ioremap again.

On root bus, we have only the root port. Any access other than that
should not go out of the link and should return all F's. Since the iATU
is configured for the buses which starts after root bus, block the
transactions starting from function 1 of the root bus to the end of
the root bus (i.e from dbi_base + 4kb to dbi_base + 1MB) from going
outside the link through ECAM blocker through PARF registers.

Increase the configuration size to 256MB as required by the ECAM feature
and also move config space, DBI, iATU to upper space and use lower space
entirely for BAR region.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v5:
- Make elbi as optional and move resource mapping to the dwc (Mani)
- Make the changes in the code as we made elbi as optional.
- Link to v4: https://lore.kernel.org/r/20250207-ecam_v4-v4-0-94b5d5ec5017@oss.qualcomm.com

Changes in v4:
- Update the commit messgaes and do minor code changes like adding
  export for the api, adding error message( mani)
- Link to v3: https://lore.kernel.org/all/20250121-enable_ecam-v3-0-cd84d3b2a7ba@oss.qualcomm.com/
Changes in v3:
- if bus range is less than 2 return with out configuring iATU for next
  bus & update the logic of ecam_supported() as suggested ( Konrad)
- updated commit text and update S-o-b (Bjorn Andresson)
- Link to v2: https://lore.kernel.org/r/20241224-enable_ecam-v2-0-43daef68a901@oss.qualcomm.com

changes in v2:
- rename enable_ecam to ecam_mode as suggested by mani.
- refactor changes as suggested by bjorn
- remove ecam_init() function op as we have removed ELBI virtual address
update from the ecam_init and moved to host init as we need the clocks
to be enabled to read the ELBI offset from the PARF registers.
- Update comments and commit message as suggested by bjorn.
- Allocate host bridge in the DWC glue drivers as suggested by bjorn
- move qcom_pcie_ecam_supported to dwc as suggested by mani.
Link to v1: https://lore.kernel.org/r/linux-devicetree/20241117-ecam-v1-1-6059faf38d07@quicinc.com/T/

---
Krishna Chaitanya Chundru (7):
      arm64: dts: qcom: sc7280: Increase config size to 256MB for ECAM feature
      dt-bindings: PCI: qcom,pcie-sc7280: Make elbi register as an optional
      arch: arm64: qcom: sc7280: Remove optional elbi register
      PCI: dwc: Add support for ELBI resource mapping
      PCI: dwc: qcom: Switch to dwc ELBI resource mapping
      PCI: dwc: Add ECAM support with iATU configuration
      PCI: qcom: Add support for ECAM feature

 .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  |   9 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  13 +-
 drivers/pci/controller/dwc/Kconfig                 |   1 +
 drivers/pci/controller/dwc/pcie-designware-host.c  | 134 ++++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.c       |  11 +-
 drivers/pci/controller/dwc/pcie-designware.h       |   6 +
 drivers/pci/controller/dwc/pcie-qcom.c             |  76 ++++++++++--
 7 files changed, 211 insertions(+), 39 deletions(-)
---
base-commit: 0f52fd4f67c67f7f2ea3063c627e466255f027fd
change-id: 20250207-ecam_v4-f4eb9b893eeb

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


