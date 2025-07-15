Return-Path: <linux-pci+bounces-32127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE7DB053F6
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 10:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888E15631BD
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 08:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9510623AE9B;
	Tue, 15 Jul 2025 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lidSIJqu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1722750F1
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752566427; cv=none; b=DnDL3U2pQM1NBFNBe5R0kQSw8htsa91s/qSdmLzAP+qlXouDaGGhQK58x2EqgnOkCp56/W2A2r8HG85+f3Tju9r9TY6sV7nlbsLVfSj18yybtwDhAup4zsDFeW7OF3XCMQ7/aP0Dakx0y839rdzRFyz7+byamSxTNJjfglX8X3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752566427; c=relaxed/simple;
	bh=8xT/TVIi8Lf5TLxzo4hzS0yvnnm7uBaiufG5Ui34iHA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=De/z8ZoEUbb47cVjnvI9T5eKrq+4lM71q2qie84fZxbIePOGc10n7g8aDg2KmKBLp7iNlCuYn+ZDV+TusqoLwxd3tssTUsbpxNbQx6tAC/grDgpQtQl6au0TvNzz4mKZ9odzhwdsNneoUe8kDo9UWO2gGGDRLxEV0SkeorRp+Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lidSIJqu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F3k2iv004270
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 08:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6GJz2i62juPlOyegqHrF3O
	vjXVoMZ+oRnuJpYKATWxs=; b=lidSIJquc1KSKJZMCNQdU9rsDZ+ozrxfqT6zlT
	AVs4GKmm3UWz+RhjDreJgGWdyQ/ia6ucP1mXJ/pTm+f3MKuuheD2e/IH4x7LeJrT
	kF33ucan0rMDJYONdb4SaHISi8BPIr7EU5f31B9XD80uhTYcaak0t3exfMbL94Hp
	P5vA7YMnvEbDA967+WmwPRjqpvuiaekygsOU8qgxDyxjsvq9NPCh5+5wJsSo1iSm
	XSTsZkuKKMwvDd4Bbo8B4gaAtXRyk+HcnzMasRNUtD2BuN4iaLkALvMwusyGucmK
	PPe6jyBC5rb1no204Hl2COEh1NNV4X4qpruYWs3tSbXWO32Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wfca0m6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 08:00:24 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a9e1de6f5cso106116541cf.1
        for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 01:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752566410; x=1753171210;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6GJz2i62juPlOyegqHrF3OvjXVoMZ+oRnuJpYKATWxs=;
        b=EUzdL4Mq8T/oiIp3mAW2Wc1E7/Vs12ibKZeVJfkqR7x+w4divPK8z5OzpBJQmpOmTa
         EZmg7ImxEb8xZgVAYy/u9bnT9xN4D8juvt3T7/p3TSL5Jf3jiOa+JU8lV+kvvJvNzRH2
         OenxAzRH7UicxOm52uVUWIcorK/JjPZ30c6BmYToXbwDNyDyw96zykf1dEdVq9GT/fFP
         TfTVw83CY4xTf4HkFitzjX32C+Xx2IRjCKk6Vj9FLccoU+OVGwa9NTo94vaLVNBSjDax
         EAHCXKCd7G8nIb1z12XB8VWBuhXi5UH/sd7DJgwPnakzYVr/W+oSugnEBWO+RhUIT5bg
         WsEA==
X-Gm-Message-State: AOJu0Yx+e1JglCf06p2tmvrwOk/+trzHv34sr15M6Jy+xa0xnrcMcbyO
	HBWGl9CnMbDr+AGlNCy8Eqfu9lNErluaPF5VVej56555gnK3q6S8CBvZCRcm64xrt+r0Kq2f6gG
	eTfDPZos+rbekIQjN1ruWOyGexutWbfHXtdh/AfpDo5zxzVpBr5ZAUVuOFpoYCKk=
X-Gm-Gg: ASbGncuGXlpj3v0wqbiVl6JVtQ3aFTfgCB1FGaHsXN1GMlG8+8SsSIj+82lA+csBiax
	DduSAJlT3PzIjr2wo/I1OUYvMPF4SCB5eg3vzs8+MfWQyKWpGK5HhY7etlmGAMWeKLuHYWhg3gW
	PO+fssAiWnWbpWB/tVw5rn4m0xrI0Bm5yFi5oAHzHSFH4SEoQDVPEZOrHGezD5kIs9giJ2je0BB
	9rgCMCTZih2Cqefi+3j+wrBQZUoT5gxMWBl6UCwOhrRtT0Q04e/NAZHGKp1+SUeFukHXMH+IBzB
	gT4pKX50OE6xyIteL3k/Y7UqpIc3i6vbwufs/ALswlqBc8xOTNir0toOig6uvRC4LahNUg==
X-Received: by 2002:a05:622a:5a05:b0:4ab:5d87:91e8 with SMTP id d75a77b69052e-4ab825ac736mr25858591cf.31.1752566410165;
        Tue, 15 Jul 2025 01:00:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGodpYpCiKK+ig7+dAeyUiedid2AqDR6o8ee2iwMToEcOyeNts5u5xULe5KHTQAZiadcwUvmA==
X-Received: by 2002:a05:622a:5a05:b0:4ab:5d87:91e8 with SMTP id d75a77b69052e-4ab825ac736mr25858021cf.31.1752566409650;
        Tue, 15 Jul 2025 01:00:09 -0700 (PDT)
Received: from [192.168.1.17] ([120.60.140.219])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab3f1c9a2csm37792461cf.67.2025.07.15.01.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 01:00:08 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v5 0/4] PCI: Add support for resetting the Root Ports in a
 platform specific way
Date: Tue, 15 Jul 2025 13:29:17 +0530
Message-Id: <20250715-pci-port-reset-v5-0-26a5d278db40@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFUKdmgC/x3MMQqAMAxA0atIZgNtNRS9ijiIRs3SllREkN7d4
 viG/1/IrMIZxuYF5VuyxFBBbQPruYSDUbZqcMaR8ZYwrYIp6oXKmS/st4HsQN5Y10GNkvIuzz+
 c5lI+rsDLXGAAAAA=
X-Change-ID: 20250715-pci-port-reset-4d9519570123
To: Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Niklas Cassel <cassel@kernel.org>,
        Wilfred Mallawa <wilfred.mallawa@wdc.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4400;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=8xT/TVIi8Lf5TLxzo4hzS0yvnnm7uBaiufG5Ui34iHA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBodgqBRV9d193TvHdNlr2jxjHR5Q3V0is3e91iw
 OJ1a7jKZjiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaHYKgQAKCRBVnxHm/pHO
 9Yu+B/4tQUVXiGfLVVZt4fAu/lYZmbtEfihDCXylY8XG/vbIBFfj6dhfaYWumgXGPGzRmnadOBW
 AjSCgaX9ZUU5+zhZI4QJTKeYjpQd0wUjXP420GLdSfoQ5o3u5/HprNyr+mG1R5XqhXJql2TKYoG
 otgfNjPLgJZRYCdQnmCHatx9vnKIi5IgdclRY2D++0J2UQxUgfjsJaNemfKB/qUvavyrtUdpyoM
 VB31LN9WMW7lIYy7SIu5saoxRxxh9B7vtTdB51HMlw1NvMA1P1N5UqSPwLxrlhKqaoow/D+2VcN
 pFbvCFrRU+PAoun5tqY3HLgLY9U/DQx6VFKlJxS+VxHElnKC
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA3MiBTYWx0ZWRfXzw0HSZL1K4ok
 TbmnHGv2O71+9RohtDBwRblTnp3swgQt66MkniVBliHlAwlBllM9TC18RtkRvcqZsMqfViN90f1
 OLBjpddgnuhj6O84alR/971oOuxg95g6E7hy0RUjwgSH74aykxftBYO3DqsDknITZza54224ucV
 +AOrN6DhhjeoP0BmdU2tvxUQnBb/Bk3jtXVYfgezmM8OYoH2JkpgzShqAewMybO8lRKuN8SFtnF
 12aTiPrwS8ANbqQgNhtsGAEsqmcqll8Y3lEkK5xmKe7UbrCT3RHEpeowfazAKngWoU0CWS6G3zH
 BFvu7S1AGtbAzUcyHxcgiq9yPGsyLGpcvSznKkLbx1h1dXv0we6F4Wn5qrlvfnDxkF+Epqvhk0t
 1Ys870tDkvsQDAN7vnqpwAjs6kefZcbDdhBUfNvrs/AwtdJ4KkJsmqO0Uo2XQxLzglzK/yiB
X-Proofpoint-GUID: 5Eof7qVeSxTT1irLtaglusmYbtNvn8ao
X-Authority-Analysis: v=2.4 cv=SeX3duRu c=1 sm=1 tr=0 ts=68760a98 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=HOswsyiB/7FCIMMjk980kA==:17
 a=lJ8DZ0MjVbnDIa4D:21 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=pah7fRnKCyhbKptB6fkA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 5Eof7qVeSxTT1irLtaglusmYbtNvn8ao
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150072

Hi,

Currently, in the event of AER/DPC, PCI core will try to reset the slot (Root
Port) and its subordinate devices by invoking bridge control reset and FLR. But
in some cases like AER Fatal error, it might be necessary to reset the Root
Ports using the PCI host bridge drivers in a platform specific way (as indicated
by the TODO in the pcie_do_recovery() function in drivers/pci/pcie/err.c).
Otherwise, the PCI link won't be recovered successfully.

So this series adds a new callback 'pci_host_bridge::reset_root_port' for the
host bridge drivers to reset the Root Port when a fatal error happens.

Also, this series allows the host bridge drivers to handle PCI link down event
by resetting the Root Ports and recovering the bus. This is accomplished by the
help of the new 'pci_host_handle_link_down()' API. Host bridge drivers are
expected to call this API (preferrably from a threaded IRQ handler) with
relevant Root Port 'pci_dev' when a link down event is detected for the port.
The API will reuse the pcie_do_recovery() function to recover the link if AER
support is enabled, otherwise it will directly call the reset_root_port()
callback of the host bridge driver (if exists).

For reference, I've modified the pcie-qcom driver to call
pci_host_handle_link_down() API with Root Port 'pci_dev' after receiving the
LINK_DOWN global_irq event and populated 'pci_host_bridge::reset_root_port()'
callback to reset the Root Port. Since the Qcom PCIe controllers support only
a single Root Port (slot) per controller instance, the API is going to be
invoked only once. For multi Root Port controllers, the controller driver is
expected to detect the Root Port that received the link down event and call
the pci_host_handle_link_down() API with 'pci_dev' of that Root Port.

Testing
-------

I've lost access to my test setup now. So Krishna (Cced) will help with testing
on the Qcom platform and Wilfred or Niklas should be able to test it on Rockchip
platform. For the moment, this series is compile tested only.

Changes in v5:
* Reworked the pci_host_handle_link_down() to accept Root Port instead of
  resetting all Root Ports in the event of link down.
* Renamed 'reset_slot' to 'reset_root_port' to avoid confusion as both terms
  were used interchangibly and the series is intended to reset Root Port only.
* Added the Rockchip driver change to this series.
* Dropped the applied patches and review/tested tags due to rework.
* Rebased on top of v6.16-rc1.

Changes in v4:
- Handled link down first in the irq handler
- Updated ICC & OPP bandwidth after link up in reset_slot() callback
- Link to v3: https://lore.kernel.org/r/20250417-pcie-reset-slot-v3-0-59a10811c962@linaro.org

Changes in v3:
- Made the pci-host-common driver as a common library for host controller
  drivers
- Moved the reset slot code to pci-host-common library
- Link to v2: https://lore.kernel.org/r/20250416-pcie-reset-slot-v2-0-efe76b278c10@linaro.org

Changes in v2:
- Moved calling reset_slot() callback from pcie_do_recovery() to pcibios_reset_secondary_bus()
- Link to v1: https://lore.kernel.org/r/20250404-pcie-reset-slot-v1-0-98952918bf90@linaro.org

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Manivannan Sadhasivam (3):
      PCI/ERR: Add support for resetting the Root Ports in a platform specific way
      PCI: host-common: Add link down handling for Root Ports
      PCI: qcom: Add support for resetting the Root Port due to link down event

Wilfred Mallawa (1):
      PCI: dw-rockchip: Add support to reset Root Port upon link down event

 drivers/pci/controller/dwc/Kconfig            |   2 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |  91 ++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c        | 120 ++++++++++++++++++++++++--
 drivers/pci/controller/pci-host-common.c      |  33 +++++++
 drivers/pci/controller/pci-host-common.h      |   1 +
 drivers/pci/pci.c                             |  13 +++
 drivers/pci/pcie/err.c                        |   6 +-
 include/linux/pci.h                           |   1 +
 8 files changed, 252 insertions(+), 15 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250715-pci-port-reset-4d9519570123

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


