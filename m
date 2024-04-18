Return-Path: <linux-pci+bounces-6415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B898A9937
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 13:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9519F1C208C4
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 11:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2689715F3E1;
	Thu, 18 Apr 2024 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rRAHjDd2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1CF15F326
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441531; cv=none; b=YGX9iDT1vSUtcoUKOCH7npWM3LSC76mVtMOsncEJETITLMDsGb/XGc9SQ7vRpxIGmSG0RH1GUKeFc+hbC1IKf/d3ASd3oidaKFGH8M4jCR7xvXS82gjzoWtTOA2Fx14VdBOyJIAzydQBtqzczjZw9klPcgOC5DJNgfYtjnZgc/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441531; c=relaxed/simple;
	bh=0T8bNbgbYJmSiH1c9/RWSLart5xq9j5qFnGxJ69MW2M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MP8QUzH9mCMfJD+F3WJJH28nLIDqwLcLZH7gPYcgxviLV6YEH0HSwHvHKjhAD2TbPLCDGjeWTxg1HK4P0pSt5GjJReMQaPimG+lT3zZpdT6oSeXxeDM1ogJkaUAnC1s5r4SokfNNjsCbfVdPt6PhmFtksHNBvpRGh/tnnSw9XLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rRAHjDd2; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so743130b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 04:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713441529; x=1714046329; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/m9mYsEVOVi3Gw/TMsG70ggRl65xkCqo+gadqykEay8=;
        b=rRAHjDd22uKppwhulZHBEfAoa371xTHVYXzbCNVHatEioaOKcqMgIuCPdFqhqwPy2w
         A2ibJhyK7V1CwOurMhZGoU8I/yKRjjVk6HTswdgjmLE5wieDY5BKqtOe0ACSy0BPYxhg
         DHtVpvfmVHTGP4rmky59zdUAH3IPTLoO3VtCA6PjWRqnuig+JVOcHLYmogLrc2jpaeM2
         i0t11Y1v3YnWpxfE+aOitg0l3p9FyxMJBN9dkoMP61eexTBdKMCsfHEcFEBQoqisyeG6
         +gRfh+pA8ZunyQXkQGWdfpoNS3JUCuYXBSRSKlny7husImWI+QhEeOE6QgfafYyF/XlM
         HxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441529; x=1714046329;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/m9mYsEVOVi3Gw/TMsG70ggRl65xkCqo+gadqykEay8=;
        b=CW0wM9kgSU7aM9JDlcTMSGnpaMi9sM3RvkoJ5N72nEUaCD3VqEGdipMPd7ytc1w+/y
         OZUcaqpHXiR6kCTakLXUJzneH0h1HvWWYAYtaBRDP2La3owXKyvHCc24MtFCtDZRn4al
         krgrisD14gsve/MrrvBwgxsTB/GD76c3DvSh6BE7QKUPZ7fG9TJGBENv39id1oD4XBNe
         Mk0JY62Kubt+fAFQlWomIW/8acyg/VrtE9H8gemNabjUmqKTo7f6/Dj6CBJAk8jZgcd9
         hvlyBlZAD6YB2QWRhu4RpJJjg5+eS/0ngCxI8iS0C1MZ1AfN0elAit5fLWnGGDk1Sw8U
         stcA==
X-Gm-Message-State: AOJu0YwQoHo/N8JxNaAKHpYQm1KcwcAq6GztH9fmB05pSaaeVJNBHhkI
	Zzhk8eOXXKcjLDNfU+2p2ULB1HvaiM6GVirCoibXFlaUNENki1IIlBKqMGRXrA==
X-Google-Smtp-Source: AGHT+IGVB1LvunC2qEVzKKZKTV4+bcGe7kvNx74AXifHmOk3+Bo8xo9Am99F+YEUY89ktZX6VTqsNw==
X-Received: by 2002:a05:6a00:c81:b0:6ea:bd59:9389 with SMTP id a1-20020a056a000c8100b006eabd599389mr2662351pfv.8.1713441528605;
        Thu, 18 Apr 2024 04:58:48 -0700 (PDT)
Received: from [127.0.1.1] ([120.56.197.253])
        by smtp.gmail.com with ESMTPSA id ei16-20020a056a0080d000b006ed06c4074bsm1305512pfb.85.2024.04.18.04.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:58:48 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/9] PCI: endpoint: Make host reboot handling more
 robust
Date: Thu, 18 Apr 2024 17:28:28 +0530
Message-Id: <20240418-pci-epf-rework-v3-0-222a5d1ed2e5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOQKIWYC/3XMSwrCMBSF4a2UjI3kZUocuQ9xkDa37UVpyo1Ep
 XTvpp2IiMNz4PtnloAQEjtWMyPImDCOZehdxdrBjz1wDGUzJZQRWho+tchh6jjBI9KVewv20Ei
 hfe1YQRNBh88teL6UPWC6R3pt/SzX928qSy64ldqAbWUwTp5uOHqK+0g9W1tZfbwR8ser4l0tQ
 gNONM6FL78syxshzEZB7QAAAA==
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
 linux-tegra@vger.kernel.org, Niklas Cassel <cassel@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Damien Le Moal <dlemoal@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3248;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=0T8bNbgbYJmSiH1c9/RWSLart5xq9j5qFnGxJ69MW2M=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmIQrxcz5ybFnUiJwKxoAXrBZC2YgZAbMO75Ehc
 lMFY1sne+iJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZiEK8QAKCRBVnxHm/pHO
 9WXzCACGEr3EQYv7NBNDTtjHkKmE5HiuF3NmZv3x6qki54w9TlLp5Fppi9xFJOPekHndUI82iyq
 WbVhVhWXIB5806UNqGlQ7/DJBh5at2yVqi1D5HeOjbN+tdVw0OEv2dOnk194r+k+aiWgWy+RTA7
 aXa0xNAolc5Q88Q0uPwODQzxPPVxbhi9ATuhBvU39kNk4Ir3ar0w5cgg7Mw+0pUpLCdHpc0U3Zc
 KV2shiP06yELv065SWHGPJ1SuQC6jb6DaQYmlL3Xl/KoOHmGiO0F7wvxSdX6gA+MYPxr/bSHXav
 jG+y/arJU/TkAyF/UgmJS9EfPwFmn6ETxMokyDz95uY/2ZdZ
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Hello,

This is the follow up series of [1], to improve the handling of host reboot in
the endpoint subsystem. This involves refining the PERST# and Link Down event
handling in both the controller and function drivers.

Testing
=======

This series is tested on Qcom SM8450 based development board with both MHI_EPF
and EPF_TEST function drivers.

Dependency
==========

This series depends on [1] and [2] which are currently in pci/next.

@Niklas: I've dropped your Tested-by tags as there were some changes in between
and I want to make sure this version gets tested again. So please give it a go!

- Mani

[1] https://lore.kernel.org/linux-pci/20240314-pci-dbi-rework-v10-0-14a45c5a938e@linaro.org/
[2] https://lore.kernel.org/linux-pci/20240320113157.322695-1-cassel@kernel.org/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v3:
- Dropped the patch that split epc_events into two
- Added a patch to rename BME to Bus Master Enable
- Added back the comment for REBAR
- Switched to cancel_delayed_work_sync() for Link Down event
- Rebased on top of pci/next
- Dropped the tested-by tag from Niklas as I'd like to get this series tested
  one more time due to changes
- Link to v2: https://lore.kernel.org/r/20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org

Changes in v2:
- Dropped the {start/stop}_link rework patches
- Incorporated comments from Niklas
- Collected review tags
- Rebased on top of v6.9-rc1 and https://lore.kernel.org/linux-pci/20240320113157.322695-1-cassel@kernel.org/
- Link to v1: https://lore.kernel.org/r/20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org

---
Manivannan Sadhasivam (9):
      PCI: qcom-ep: Disable resources unconditionally during PERST# assert
      PCI: endpoint: Rename core_init() callback in 'struct pci_epc_event_ops' to epc_init()
      PCI: endpoint: Rename BME to Bus Master Enable
      PCI: endpoint: pci-epf-test: Refactor pci_epf_test_unbind() function
      PCI: endpoint: pci-epf-{mhi/test}: Move DMA initialization to EPC init callback
      PCI: endpoint: Introduce 'epc_deinit' event and notify the EPF drivers
      PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown() API to handle Link Down event
      PCI: qcom-ep: Use the generic dw_pcie_ep_linkdown() API to handle Link Down event
      PCI: endpoint: pci-epf-test: Handle Link Down event

 drivers/pci/controller/dwc/pcie-designware-ep.c | 104 ++++++++++++++++--------
 drivers/pci/controller/dwc/pcie-designware.h    |   5 ++
 drivers/pci/controller/dwc/pcie-qcom-ep.c       |  13 +--
 drivers/pci/controller/dwc/pcie-tegra194.c      |   1 +
 drivers/pci/endpoint/functions/pci-epf-mhi.c    |  47 +++++++----
 drivers/pci/endpoint/functions/pci-epf-test.c   |  95 ++++++++++++++++------
 drivers/pci/endpoint/pci-epc-core.c             |  58 +++++++++----
 include/linux/pci-epc.h                         |   3 +-
 include/linux/pci-epf.h                         |  10 ++-
 9 files changed, 230 insertions(+), 106 deletions(-)
---
base-commit: 13ccfe1d824dd392c9200b91655929b6f49a3e69
change-id: 20240314-pci-epf-rework-a6e65b103a79

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


