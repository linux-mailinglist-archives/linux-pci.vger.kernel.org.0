Return-Path: <linux-pci+bounces-4002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1F0867363
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 12:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0491028A5C8
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 11:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4B41DA3A;
	Mon, 26 Feb 2024 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="liVJl3i9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7942B1DA4E
	for <linux-pci@vger.kernel.org>; Mon, 26 Feb 2024 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947471; cv=none; b=tVmxT0g8Joh07y/ncPXysgoybxYPtKCjSSPzMQi9V1NNxL8Wm4aaYNt8D4R5FZVViPX0CdeDcjuf7i0NKd+GHzvcooSlrblmnN9UP/FF/KvJdBEcqUvTzZN3kI7VPlMp2HFM8GIJgogQUgPKa6HKIAgNiojjtmdvjWdc/9eAsg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947471; c=relaxed/simple;
	bh=zN4H7AL9yEWwBMPFUse2kPeWuj9c3TyK31dCtLQBVwU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VyY/WhcrwCU1Z6wcKeswB1KTKxl9c+nmWfVbuHpQkeSPAV/3lWAQTJoKmMhVO1Nb029wN8H6QPjx+9IBymZrySOEZsUQx2Bcbh30FjyDv1LjCkhxt2aqKK8zYwT6ERy5G0/o7jHNPOU2GGqo+BtWdMvl7qdiTu5VJN1TJcH9F5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=liVJl3i9; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7879e69af35so204540485a.1
        for <linux-pci@vger.kernel.org>; Mon, 26 Feb 2024 03:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708947468; x=1709552268; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yOtDU75r2JA5nMqmgqSfs6LZtJBpRoh0ipLmkGMw850=;
        b=liVJl3i9xCmrH9zhq8o1WhqU3jVj4q6wdYxEpJeW9obDIk2gNHciJWvVAcahATIzkh
         lSSPipVAh/+joi7aK0go8IeuKgqaiy2rrxkLhUPiBXlWz02DBdG973xL+aDTtUQMlTM5
         7m2pbIbvmPK2+YNYm8z/3eme2/0V1L2RhQ0yWSq38JAkQWJLsFRl3jn8x0qSfLPnhnnm
         xV5qQnCEE+LbSm9zwwqZo8lG1Jb2Bte+Mt4Q0CX7rj9Lbk6caPZnDQbt+VTbkP+1N+8z
         DwstsUQkMOhLrl5LYE7VN+83ZonmAwF1/weltCnW4GlfyUSBR1NlulaTNMhVCC3Uf9SB
         tYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708947468; x=1709552268;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yOtDU75r2JA5nMqmgqSfs6LZtJBpRoh0ipLmkGMw850=;
        b=Uu2XzIBMsu84Z9MzpVcJY7ixpuu6EgdCmIlLzjjbSq2tEoYYMN6rKBKX1StQ113WRs
         nXMyTAnqj5VHIcJUI70oqZO5ayKV/iO4FJVVU8hXd2fkaZ/5CKSv5T8I3BUUWIfji1o7
         vgw2JeLzfGoQoUIQxTs2LI4FPkB52AdAluaxo/Nj8C6vVTBRtJiKvrDHKhdKhHafaTZF
         F++p7auqqdmDW42QvRhegTsUDCtPkP170TPXbfdE8WFVR7G0ORSu7ch/ki0bhbG5m/jM
         1A+hQpK5l9248VAbOOeRcxBrnRrLDQJV1TJHkzUzpzssn1eWNl6NgdlKOhBFobEeqCMY
         B/Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUhEv6cLzonKsN8ShqzNyBfEln1hfp/r5n9Eyu+mdQxURv2mPtEBMx3JNseFYVKSWWUTQzbPCQpyUiweQPpXd53utcVRmyCOF7/
X-Gm-Message-State: AOJu0Ywy8IpqCv8Kpt1lDRi6BjTQmoVqwWkUdTs7Qq0dHId7E5uFshp6
	e9+z45OhEwQlOG49boCKGNt0r1vBpGPbHoryxNBXMRtnP3EXsu2QGUE1nIZ5Xg==
X-Google-Smtp-Source: AGHT+IHRlLAac3t/t+Ib99/W27Guf/dv3EWDLEDqeS4bxH0DZ+XkVc/0i/w22EDz3k2nxlw6LuR/Kw==
X-Received: by 2002:a05:620a:7f9:b0:787:1a78:fbe9 with SMTP id k25-20020a05620a07f900b007871a78fbe9mr6385524qkk.56.1708947468464;
        Mon, 26 Feb 2024 03:37:48 -0800 (PST)
Received: from [127.0.1.1] ([117.202.184.81])
        by smtp.gmail.com with ESMTPSA id q15-20020a05620a0c8f00b007878babb96asm2341842qki.94.2024.02.26.03.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 03:37:47 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/5] PCI: dwc: Add support for integrating HDMA with DWC
 EP driver
Date: Mon, 26 Feb 2024 17:07:25 +0530
Message-Id: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPV33GUC/2XMQQ7CIBCF4as0sxYzDqRJXXkP0wUUKJMoGDCoa
 bi72K3L/+Xl26C4zK7Aedggu8qFU+whDwMsQcfVCba9gZAU0mkU9iWCvWsxKmsXnLyRaKC/H9l
 5fu/Sde4duDxT/uxwpd/6b1QSKIwiSROi9Epebhx1TseUV5hba1/oduAdnwAAAA==
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
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Mrinmay Sarkar <quic_msarkar@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2608;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=zN4H7AL9yEWwBMPFUse2kPeWuj9c3TyK31dCtLQBVwU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl3Hf+ugscH906dxKa1q956AiK7dO/M8tdcr6fT
 aiph35AMmeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZdx3/gAKCRBVnxHm/pHO
 9VIPB/90Qib9s9ybHOJjZTFAzC+LuAX4iTj/eAvrr+mXEaxKJgMyz/Zaxr3LoPGnq9TeHvyOSh+
 rk8EqkZ8yGo+jFjQru/9eO3BCZEAaZQgbP4dgHuLgkKBkUOl91uC1af3moCy9egzAqAnXVcZJ2k
 lgcJf7eOuH+Db/euhh8+4bvApFvNG2KBCWI+e3lP8A4MARip6kPe7hc924+LzcG1RAg2CLJXK6w
 qGIQeCoU/d5wx0OiCOz8HGQpUWTXeTSDOes8m4P9WVTwWHQih8n5oYyZ8DV4yoURYsgxiaE43QX
 O+qByCZy8Q9LEQTmuuv+cv8fJuWCq5nxdUXlYbYny/O34vIw
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
      PCI: dwc: Skip finding eDMA channels count if glue drivers have passed them
      PCI: dwc: Pass the eDMA mapping format flag directly from glue drivers

Mrinmay Sarkar (2):
      PCI: qcom-ep: Add HDMA support for SA8775P SoC
      PCI: epf-mhi: Enable HDMA for SA8775P SoC

 drivers/pci/controller/dwc/pcie-designware.c | 74 +++++++++++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.h |  5 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c    | 23 ++++++++-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c  |  2 +-
 drivers/pci/endpoint/functions/pci-epf-mhi.c |  1 +
 5 files changed, 78 insertions(+), 27 deletions(-)
---
base-commit: fdd10aee7740a53c370a867b8743a8c8945d1db1
change-id: 20240216-dw-hdma-64ddc09fb30b

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


