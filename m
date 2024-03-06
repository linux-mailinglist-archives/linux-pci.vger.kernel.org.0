Return-Path: <linux-pci+bounces-4564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB74873457
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 11:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 683D3B22E7C
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 10:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9A55FB8F;
	Wed,  6 Mar 2024 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VR96yLa3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCA75FB85
	for <linux-pci@vger.kernel.org>; Wed,  6 Mar 2024 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720538; cv=none; b=B5pNDscN2DK0fhjiXf6XNshNjMq3pW/taSjW0k/FFDdi6V/f8+DQeqdN4p/ppziOa8MT6i+KdlGPCcgOxmJjaRp21csjUskBKpXcqDrp5fpGSAjKbrZp3BTHsm0KZWr7bwg3UePdcHvIWRuc9vSMYp0t983d/I8a/0BMuvcCSvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720538; c=relaxed/simple;
	bh=AjeoBE4fyLRvjmasEXjDIaFHtdHHOgnz8vtvmnu/slA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G0nyvNHlGQfnxVqFpcf8WIWm4plkUKQ0RbvkBndxGSSQSoJkcdR9XDJdcreewfdx/e3YOYrBIcVIfYptspD/VBBCxbps/IQrqIPFTO7tjl37Ru1Ymai0lxAN/OUB7tCdne6VFDG8uYAet8AvkkJaMFzJRq8y3Xu6b6agOjT3r6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VR96yLa3; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so5190475a12.0
        for <linux-pci@vger.kernel.org>; Wed, 06 Mar 2024 02:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709720535; x=1710325335; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HfQtUh9Hb1S2F0NpU287F2kJlqd4GKGxqgD/P+ZTQlU=;
        b=VR96yLa3mt4rRaGDOStlmBVxmbxTtYZ2S7KQbpkChVkuH/CaY9LbASZMrYa8eT8Yv1
         +0GMrVnY5DHwlcjLq9RNtZcQsM7bLQcQxIAbtY8izFGKob1OF/f3PUZdV3BbKziM5Ie2
         nVLL3vKwCg3P4LLR0LjBSYp8djUGs6JQLhAwsyZCC+5V4dHkq50gk7mT8Tfz6I3qtdyR
         CxRRrvfHvsXu9SSjNI93bmSEzHNcP26j/jud7OnHaL1ex4OQg68DERfb4W8UgxsYbwOC
         sKlRYnxAResCFk5XI02SJdIGMvGoj2cAgMXqKmWppglESY5B2wMA3Ol1vqeV1vweBzPL
         n52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709720535; x=1710325335;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HfQtUh9Hb1S2F0NpU287F2kJlqd4GKGxqgD/P+ZTQlU=;
        b=V3yfORHrQOClDYMmVThSmxYGxus/8CaqXll/iD306Vp77XBRXvyFiWAwnxHbvzsb52
         TnsPh+rvtdJ0F7HV2A5tui/FLZLqnezvxUbp4W4bZcvSrRvVjOcVz0Jj2QWhIJ1CngNB
         vyO94awlRrd3y5KSK8C25+emuOPtBp/Du9vWC7xWJPtZUgFFVnZldugTCtbgFiS2uZhp
         pUBnyzlTCEnyb5TxORE7N6SThjI//rqJQmrcwNgcdgJf1Tkpc5H5+q4ytrg+AmrXWfQb
         aQL22dT6F7uXb2ExQ2o5sAHQt5nUOcmd9Iab4zEJGXcgQf8IyKqtzl0cXuHUPalR2bR6
         ZOrw==
X-Forwarded-Encrypted: i=1; AJvYcCVeAenSDU9lufBTAsAf6Xz62i6lFKxnml06N4DdopGh6B7kdM+w86q9KSwLG2y42jLDXoYyiY2croJqEizf7F2jhHDbu06QI8Tf
X-Gm-Message-State: AOJu0Yx7dum4IPmmpFTdikSw1PWd709oBSW0tv1zyYBDiXDkQYAEsAwb
	GtplQNQSDMm7jobvoNF4xd8H9jq+TzzAM/nH9RR7XYBw8b1jXPr4FX7lezg6DQ==
X-Google-Smtp-Source: AGHT+IHQcJlvqnne2sVsf5+p2hF2vPMg9zCWvt2vfRbFLp9pIOd9R88WdlpVRJVCezYfzeofnInWaw==
X-Received: by 2002:a17:90a:b88:b0:29a:76f5:6557 with SMTP id 8-20020a17090a0b8800b0029a76f56557mr10507176pjr.19.1709720534924;
        Wed, 06 Mar 2024 02:22:14 -0800 (PST)
Received: from [127.0.1.1] ([117.248.1.194])
        by smtp.gmail.com with ESMTPSA id li17-20020a17090b48d100b0029ab96b13ebsm13339320pjb.40.2024.03.06.02.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:22:14 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 0/5] PCI: dwc: Add support for integrating HDMA with DWC
 EP driver
Date: Wed, 06 Mar 2024 15:51:56 +0530
Message-Id: <20240306-dw-hdma-v4-0-9fed506e95be@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMRD6GUC/2WMyw6CMBBFf4XM2pph2qC48j+MC/qCSZSa1lQN4
 d8trDAuz809Z4LkIrsEp2qC6DInDmMBtavADN3YO8G2MBCSQqobYV9isPdONMpag63XEjWU9yM
 6z++1dLkWHjg9Q/ys4UzL+t/IJFBoRZJaROmVPN947GLYh9jDEslyI9JGlEU03uhjfai9IfUjz
 vP8BRYJbyDYAAAA
To: Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Frank Li <Frank.Li@nxp.com>, 
 Mrinmay Sarkar <quic_msarkar@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2845;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=AjeoBE4fyLRvjmasEXjDIaFHtdHHOgnz8vtvmnu/slA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl6EPImM0GbzZyuB5WgL6EtRQUAg3oupiHa+fKf
 wu7D/s5gjyJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZehDyAAKCRBVnxHm/pHO
 9aYgB/wNxq6NI0ouxsTilx9ADlzvNeyYWc4pGJ2ZVeFBh1zleZQVAcyjWI6UP2wKo5Vj16FqX3h
 tzhHpqsoEqZqflwdN7Vdrtq11jXJDQdjLy6fQBsieSzdsl7mVRA/QRWOZT8FHHlvavaHxwvAZxh
 vErkJXtAzVowSSAOr5caWmMyCSNxAEI3g0cB+hyN1OQnDGSvYxQkI500d6YxBXvWbf4AqFFB9mM
 +n62UwYgXNDfJ7hOVX/Kzy79+LW736tj7+xVoNfNvchg+fXoqWLwc4H/TkTxbH13uPEPAl5DldB
 TIlt4/lEehH41azE6tfhgKezGOgp39btbkz1VuH09KmJJa+e
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Hello,

This series adds support for integrating HDMA with the DWC EP driver.

Hyper DMA (HDMA) is already supported by the dw-edma dmaengine driver.
Unlike it's predecessor Embedded DMA (eDMA), HDMA supports only unroll
mapping format and doesn't support auto detecting the read/write channels.

Hence, this series modifies the existing eDMA code to work with HDMA by
honoring the platform supplied mapping format and read/write channels
count.

The platform drivers making use of HDMA should pass the EDMA_MF_HDMA_NATIVE
flag and provide channels count. In this series, HDMA support is added for
the Qcom SA8775P SoC and the DMA support in enabled in MHI EPF driver as
well.

Testing
-------

Tested on Qualcomm SA8775P Ride board.

Dependency
----------

Depends on:
https://lore.kernel.org/dmaengine/20240129-b4-feature_hdma_mainline-v7-0-8e8c1acb7a46@bootlin.com/
https://lore.kernel.org/all/1701432377-16899-1-git-send-email-quic_msarkar@quicinc.com/

NOTE: I've taken over this series from Mrinmay who posted v1:
https://lore.kernel.org/linux-pci/1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com/

- Mani

Changes in v4:

- Rolled back the code refactoring done in v2 for patch 1 (Sergey)
- Reworked the channels count auto detection (Sergey)
- Collected tags 
- Link to v3: https://lore.kernel.org/r/20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org

Changes in v3:

- Collected review tags
- Minor code refactoring (Siddharth)
- Link to v2: https://lore.kernel.org/r/20240216-dw-hdma-v2-0-b42329003f43@linaro.org

Changes in v2:

- Dropped dmaengine patches (Sergey)
- Reworked dw_pcie_edma_find_chip() to support both eDMA and HDMA (Sergey)
- Skipped MF and channel detection if glue drivers have provided them (Sergey)
- Addressed review comments in pcie-qcom-ep and pci-epf-mhi drivers (Mani)

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Manivannan Sadhasivam (3):
      PCI: dwc: Refactor dw_pcie_edma_find_chip() API
      PCI: dwc: Skip finding eDMA channels count for HDMA platforms
      PCI: dwc: Pass the eDMA mapping format flag directly from glue drivers

Mrinmay Sarkar (2):
      PCI: qcom-ep: Add HDMA support for SA8775P SoC
      PCI: epf-mhi: Enable HDMA for SA8775P SoC

 drivers/pci/controller/dwc/pcie-designware.c | 65 +++++++++++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h |  5 +--
 drivers/pci/controller/dwc/pcie-qcom-ep.c    | 23 +++++++++-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c  |  2 +-
 drivers/pci/endpoint/functions/pci-epf-mhi.c |  1 +
 5 files changed, 75 insertions(+), 21 deletions(-)
---
base-commit: fdd10aee7740a53c370a867b8743a8c8945d1db1
change-id: 20240216-dw-hdma-64ddc09fb30b

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


