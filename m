Return-Path: <linux-pci+bounces-5290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F4288EF7D
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 20:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3026C1F310E0
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 19:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A44152DEE;
	Wed, 27 Mar 2024 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iw89/Rzp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBE7152164
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 19:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711568962; cv=none; b=ZYPLcXXHwDQjaL4sacRj9B8biFfBCFhilWEGW4js+YWZ3azuW9J1fY/YOVPSulIxwlts+dCXsHoZNdGrKBn5QmwCBfKccs1ce4VsigRKoHN68R/B1WZ21qsX/GAOw6pzcH3PJyqV/OvczWFgzhtqObR+QTGiSwUugY8Gu5WOgMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711568962; c=relaxed/simple;
	bh=bAoVUdOEl5oXBjR4tVelpCyD6CLDNyMZESd4YDrAuM8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mbMyoJlSFvqZsqBu99s9VfZwIfA4IpSO5NBoxIls7t7X+rMBms8UDszkl1xz9J5R64d+RcN/4sz0hVaI3g3kKS4SkFKcM0noMVoCisIhInXi/Kg4Jx+zk3CCpnYoFHJ4EtpIEDOHzqiz1CH6fHCqzFmaBEDYoqm6uZCjpCG136k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iw89/Rzp; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-515a97846b5so140849e87.2
        for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 12:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711568957; x=1712173757; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NrM6H3f/CVd7EVIzLnLM60MDR7BLmyLxovfihEFCOqQ=;
        b=Iw89/RzpO8hhweIpjfpc1ZtMetOrHCUa3bxOUXQroCfUMUZL+WLvXFM1p05D7stQCc
         UcHlv4Q9tVeQDmzsNA3/OIj/DAPtryYRY8dN//gwCS96FFhbKxQ5T5hVyPloJw3/QN1q
         JCjUYtJPg0SFRdXzeJP5NdCTcFwFeVuCEQ4cMgs9ql+zQf/G37tCAjxyta8xz/oWn7gE
         yq5fmXNlTATX0IOoWQAXW2/AHV6DKNjFfL5tGUnsSsqJOiIZL8oCMcAjLMExlf+9KO1g
         dUYrt1hO9vZCkz6lDG9RfiKXo2e2i7XJAyWtXjlOM0AO+pyBREbSjL+kuZQLGM9SjjEu
         VlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711568957; x=1712173757;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NrM6H3f/CVd7EVIzLnLM60MDR7BLmyLxovfihEFCOqQ=;
        b=TLqba9SSN88tk8EnKfuNPgYCn2takvMp1wnWXMBc2Pj7k4TPZpBDz28d9AxUYQeMPL
         lKjnamEJ0kxC7Bf+7grG7kA0syaCwikIRRZ+q9DyikK8m2X020yrnBPKrx+UTyppSUvy
         1ObmlQLRJjXzRxi3RKdpUcN1UEpPtzpBg8ddZn+Kok+MRZJvrV1ZnhPEU6nb7SJwkoYW
         2a0c+xOEl9WqBclBesLjdUaLsOpj4O+8dbxVNYF5EioGYdp5HRyBoQW5WFw7lN5qG+p4
         ox/Su/w4eOP/K88Swnq4xITTfvW48i/PShLkn/HqLj9ryV3UxKt3wBSF9UUv0MTHdcIU
         iGjA==
X-Forwarded-Encrypted: i=1; AJvYcCVrcOPR2OvJlwSMlzvu7qi9OYE+lMQK1AAtnydW0tPqx/VSfhyMK9JnSEU7kreGNaIqojqxFXWDuULIdTsU6mzdaPp+HuXpdPet
X-Gm-Message-State: AOJu0YzpG2RpqMcvrqDCMC56oHGyD/bRE9YTWLDtNUz1N6gjgO50T3o3
	vjA5TU+M4qScNiOcH7+QaeTOMO0MgVwL4054k0l5QJ6WIA4jqz8eQphqj5fLhE4=
X-Google-Smtp-Source: AGHT+IHCtMJ1TEGgYZ2P1PWlQMN4NWgMM7GEMX9FHTpjySwq9ILK2/Fx0WRham7uXLy8Cz1FLR1PZA==
X-Received: by 2002:a05:6512:311a:b0:512:d877:df6f with SMTP id n26-20020a056512311a00b00512d877df6fmr275280lfb.2.1711568956742;
        Wed, 27 Mar 2024 12:49:16 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id jw22-20020a170906e95600b00a4e0ce293cfsm582147ejb.41.2024.03.27.12.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 12:49:16 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 0/2] Qualcomm PCIe RC shutdown & reinit
Date: Wed, 27 Mar 2024 20:49:07 +0100
Message-Id: <20240210-topic-8280_pcie-v3-0-ee7af6f892a0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADN4BGYC/3WNywqDMBBFf0Vm3ZRxfBC76n8UKTYddaCYMBFpk
 fx7U/ddngP33B0iq3CES7GD8iZR/JKhOhXg5mGZ2MgzMxBSjVSiWX0QZyxZvAcnbFxXj40tG4v
 UQV4F5VHeR/HWZ54lrl4/x8FGP/u/tZFBUzoe60eLrbXV9SXLoP7sdYI+pfQFNGf5eq8AAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711568954; l=1416;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=bAoVUdOEl5oXBjR4tVelpCyD6CLDNyMZESd4YDrAuM8=;
 b=0Wa0d33D2z4AXCaHfFMONDdw/s4pXtOxIYRBCKa+l2mDNrEe1dXZ2x4VpPs+QKubuqUO4zDw4
 J+aFHTa71ZWC0yeleA69D3GRvDP+xm7MBIpGVj1ore3l/zyBouzjUIO
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Changes in v3:
- Drop "Read back PARF_LTSSM register"
- Drop unnecessary inclusion of qcom,rpm-icc.h
- Fix a couple of commit msg typos
- Rebase, resolve some conflicts
- Link to v2: https://lore.kernel.org/r/20240210-topic-8280_pcie-v2-0-1cef4b606883@linaro.org

Qualcomm PCIe RC shutdown & reinit

This series implements shutdown & reinitialization of the PCIe RC on
system suspend. Tested on 8280-crd.

Changes in v2:
* Rebase
* Get rid of "Cache last icc bandwidth", use icc_enable instead
* Don't permanently assert reset on clk enable fail in "Reshuffle reset.."
* Drop fixes tag in "Reshuffle reset.."
* Improve commit messages of "Reshuffle reset.." and "Implement RC shutdown.."
* Only set icc tag on RPMh SoCs
* Pick up rb
Link to v1: https://lore.kernel.org/linux-arm-msm/20231227-topic-8280_pcie-v1-0-095491baf9e4@linaro.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      PCI: qcom: reshuffle reset logic in 2_7_0 .init
      PCI: qcom: properly implement RC shutdown/power up

 drivers/pci/controller/dwc/Kconfig     |   1 +
 drivers/pci/controller/dwc/pcie-qcom.c | 176 ++++++++++++++++++++++++---------
 2 files changed, 133 insertions(+), 44 deletions(-)
---
base-commit: 26074e1be23143b2388cacb36166766c235feb7c
change-id: 20240210-topic-8280_pcie-c94f58158029

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


