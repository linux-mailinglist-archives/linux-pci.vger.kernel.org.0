Return-Path: <linux-pci+bounces-2979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF74846893
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 07:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D888B22B09
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 06:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2955C8839;
	Fri,  2 Feb 2024 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ytfTPLfL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9699217BDC
	for <linux-pci@vger.kernel.org>; Fri,  2 Feb 2024 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856878; cv=none; b=QFctPhzpS0/y/vD7kr/Fc9j5oMSvvjkA1J3tjl00TWVSN8SaWNIrAPnVl/diArxCCLtlbjNOrKd1Mz8Cq2puxH1Lz4tC79CxsDaieFv/TZL4KBDvpJ6+Hllv0QBFPDu/9vXhPDQlYsLNWe+CQE0YfkRKnRzKmEF6kg1ndfpCap4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856878; c=relaxed/simple;
	bh=8a+0oyI0cSJoqWk2V6P5ZLmO6u2tJ1UClYhfKKZ2QWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k2le2oG5CTblA8h3J39aY6zVcuvC7HO0W/6VirMpoExlUEojU/BVomruP7BQ4HWLwDe6YUUrmsy2UFJJVaZWnpdM75u7vEzgUigrnnIvYI044q4hB/As7BRw98R2FJsC9UoAIzQfv1YYBmBEnqlDaFh0+8D+QXId0iM6oZq117o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ytfTPLfL; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2906773c7e9so1294300a91.1
        for <linux-pci@vger.kernel.org>; Thu, 01 Feb 2024 22:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706856876; x=1707461676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/x9xuKD51JJrFalnZZ10uYlZwdWv4nb3yUwtxcC2fc=;
        b=ytfTPLfL6b5yFwmrwF2tJ1Giu9g/HOMPwRIC51omxKZtBi7gpWl+HWY2IHSfx0A5Dc
         QBYHpuSbRvO3f6PX37qDW8tvGjc3/AAqH0DjuJ0I1do3Tphq639bot4OVg4/igJtmh5+
         JpNd7haYCM18x91TP9EPkJj6Mk0zMpmNjZ+qyQIN1h344+ltvFzLa596c5sFyZBNrG0F
         M6Y231WGp8J5BuvRM18rugq7gNvoVF9kbXjcDsaLgM9iteMDCKN/rQGRkO7dRDatBm57
         1e67a8sIi+eLA4J2+pGa6dfWnagSGdVHgm26UWRXFFDCo07w0ZdpmvIefk9cmP8KBZIG
         T1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706856876; x=1707461676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/x9xuKD51JJrFalnZZ10uYlZwdWv4nb3yUwtxcC2fc=;
        b=v2c/PQzhSaakhFqwhEIeRdSTZ9IOXx9Qbg3k5SwZMiel+ZRE2QXM33RC3dROxlnQmO
         DhEREh29gVQjLXSyGHdlCtLnGIejQbYXp+ueTLzW35e+I5rct8BasoxGQ4Yt+1uPp8FB
         1+SvuKngP2eap1FrH7LaW/fz66ZFX0PnkA2ALwaLZtRpudG/Y+8oSATXDnOr7EZhJDzg
         eMlqwH84gSSIXuN4jpSH7urTpDkBxr1uCgwEob6psz4U5kfVQ9oYSvMj9mFRhKrI+MkD
         srxUfQt1SLaVtAd6IeZImnxz8vPgTejEP3GuS6LW0LLHzwSAI9Yf9wUr3GDkMJBPt8Cz
         B7Lg==
X-Gm-Message-State: AOJu0YzJfVtDV6MvHwaMTIRIFsIhVpyWBsRgN2cZjMAcGqEGSCAMauF1
	4COHDQVa+hhyjSPezhPJhuLRBV4cAGEZFLhVuF3iguM4NKcLqUYMyio+D8aNTQ==
X-Google-Smtp-Source: AGHT+IG35APMmIsAPS0j6Mhg1cAmS1c/03TtriEZi2sP8CTKNnEvcqdTcj64smTRHsNcjMtbMv2EQg==
X-Received: by 2002:a17:90a:6b46:b0:296:2fe3:cd28 with SMTP id x6-20020a17090a6b4600b002962fe3cd28mr2273163pjl.0.1706856875975;
        Thu, 01 Feb 2024 22:54:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU5Jb1FDbEvfLgI5xEQaw+rAxd3rh1NLDc++Z9GSqA8boFyE/4tJGNkVMmL+J3MHUPd00O9sWjbw/T7FmnwE17PzhgMW9Egiqz1VqLkq2sVcaaEXCXgYS3cRNL4GAFTdQIdfsap6ppvCHeeGP83EyYsaMd6xdQMmJjNSzkSFpQ+aAysiNhA+k4AlUf4iPkJjU1hEhDRW9f0glweYChXypIbS18lHIGvQClqXGrW7jIchleOTaGXLTWRrXvMn48PnQeCl3mIG4th5+2SXrYDfsKwVW6snheHd1RauWcFHtZC+no01zkIpbx36tvgU3Hp36mDnU/xnXzpQv6cmBDNo5Q2DKajMkMfjXbOvdZfJCyTBRrN7d0EDwfRV2HYA/lTr2ApwXNbTzWUhBbf2138ZKh8GP/m+nF4s7Wxn9EqYwO8uYQNnWWtJ001sg==
Received: from [127.0.1.1] ([120.56.198.122])
        by smtp.gmail.com with ESMTPSA id r16-20020a17090ad41000b00295f900f38fsm984763pju.11.2024.02.01.22.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 22:54:35 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Fri, 02 Feb 2024 12:24:18 +0530
Subject: [PATCH 2/2] PCI: qcom: Enable D3 support for the recent PCI
 bridges
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-pcie-qcom-bridge-v1-2-46d7789836c0@linaro.org>
References: <20240202-pcie-qcom-bridge-v1-0-46d7789836c0@linaro.org>
In-Reply-To: <20240202-pcie-qcom-bridge-v1-0-46d7789836c0@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, quic_krichai@quicinc.com, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1737;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=8a+0oyI0cSJoqWk2V6P5ZLmO6u2tJ1UClYhfKKZ2QWw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlvJGciN/Y0zChE5M99t5u9KSV9M2KE/HUNCrvm
 er3fnw8mOGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZbyRnAAKCRBVnxHm/pHO
 9S1nB/4jumZoFbgNps6BZOB3a0lMhegz7WtIlzbRJv+6L1+sIUWkv2tHHcWN5uABhRb9v4ObLcp
 H328Xl2mbuZZDJFZmaNqd22ihNpYSZ1yj5+fIsAwXXw6PGjKuunjkZs/dv7tQRD61dDr9I/jyec
 W0mh4Iu1xSe/g6Qo0c5ODfo6SWOcl8y17Mo947xnafjV8URXtcZf+tUrKgDHKgDbc92UK88zBSK
 a5xvY0Mu1G1/Cj5NYsq2JJ3M0pJgPw0k7RxzgD7dR97Li86IjCxVfO8inkLlo5KZjXpY+ROWIGv
 oFDw78TWDPlJ0PCuqMTdcG6iCHi9rkpSyifMG3nDQMhOnYFc
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Make use of the "bridge_d3_capable" flag to specify the D3 capability to
the PCI core so that the D3 support (in turn runtime PM) will be enabled
for the PCI bridges.

Currently, only for the recent bridges with PID "0x0110", this flag is set
as a fixup. Because, there is no guarantee that the older bridges will
support D3.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 10f2d0bb86be..a6ae78d2ce92 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1649,6 +1649,11 @@ static void qcom_fixup_class(struct pci_dev *dev)
 {
 	dev->class = PCI_CLASS_BRIDGE_PCI_NORMAL;
 }
+
+static void qcom_fixup_bridge_d3_capability(struct pci_dev *dev)
+{
+	dev->bridge_d3_capable = true;
+}
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0101, qcom_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0104, qcom_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0106, qcom_fixup_class);
@@ -1656,6 +1661,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0107, qcom_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0302, qcom_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1000, qcom_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0110, qcom_fixup_bridge_d3_capability);
 
 static const struct dev_pm_ops qcom_pcie_pm_ops = {
 	NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_suspend_noirq, qcom_pcie_resume_noirq)

-- 
2.25.1


