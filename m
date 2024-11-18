Return-Path: <linux-pci+bounces-17037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CB09D0AC4
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 09:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A4C1F21F43
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 08:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F5014D29D;
	Mon, 18 Nov 2024 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZU5o1jXk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BA613D245
	for <linux-pci@vger.kernel.org>; Mon, 18 Nov 2024 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731918237; cv=none; b=I3gSoy4DFYUVfXS/2Z4BpSSWMEq8wT0qIqSx+t53nVJQENU+1fl9SHFP3tx7LaBWsDeGGvGhtaKi5BCEn86U4Y2IYIIy6XRw2vvB6Y1O/AwO0eKqvATWxSLMMdJZyU+vX1es0XwDGAys0AftDYnWVF6oFB1wnQy4zuQloGaRkLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731918237; c=relaxed/simple;
	bh=UCqjZDeI9FpJ7I3dSZ3gFuZ2wbdMuuE/PwssuNWZGzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lKEw3pDKP+XueaZlzQkwBHq2/BI7m9UDfiX0QXM1IumCfpmtZsqHB4fFNFJt7WMGIcqvvVFLaTnkLWFpk4XcAP3rCBM29deT7AGZmcP/qgKp9KnrZ9Ar5PvHtL+iwAh2V2oNOsAi6dNLJtJEKFPO36dG5Qkwxf76uK6u/iwS3Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZU5o1jXk; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ee55fa4b31so837772eaf.0
        for <linux-pci@vger.kernel.org>; Mon, 18 Nov 2024 00:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731918235; x=1732523035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SCbk4TlfvzPjOdLFFqTGjXfKYNxdwV9cR55qDByjVYA=;
        b=ZU5o1jXk5NLjXIi2XWPtmo0oVyxuUMRnwyu6b8eAeqSbq7hMeJ+mYT0mHFLtqz00i9
         osUkpzXa8PwpMY3aV9Ie2SfksNLFJ3eRGjBGE/KgI4u3qHz3iMFoZAeqoCkJY8u1W+W2
         i2F9tnErGk9sMcBaTEcbjcFa2JSbVyK8gkqA16Q0v+vmTctRYsHLqCcM6YHDRNq3CMDH
         YVfbiUp9vXikxA274BoBLhW40+7umrY+c3HRM0n0B1mMrhIAAfapdba1/E/snIYn390y
         L11NEALRMgOA1kwuxh3T/fakqDe6V/+BVlcGZjiPNQ+Ir5xBnlXUh8PtxMfjR2SwN5ka
         92uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731918235; x=1732523035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCbk4TlfvzPjOdLFFqTGjXfKYNxdwV9cR55qDByjVYA=;
        b=X8FJbOvk7XhbM9F0NZQMpqDkCS+FAfds0seB8ubwD3/j/fucSjRksG1Msfq84/5TZk
         DfQTTs1tqFr554NDZHuA0dYyYPPwlva8PBzqjq4nptqWZbIH+t8MpQmrAu6QI+kOHtE7
         i9OSElnZ1Bh+ZiqqlW4yXw5Ju+m+af7JrfLwAuHjO0IrAKVFWpPQV10uRavUoNW0p8KR
         63eaZunp+Mth0+ronECdKhHSfL/fx9p48cqlu9IbKEr2qpNcsubF7V46/C4Ge+lVRaoH
         UgyxAFVATyW1t90Vg2X630jFHHdoYlRNUi4VF1mmzOFYe5Xi+Gi+06fPVTnOPeyWArXh
         whkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWkfLZP0r+8MeOwxXqrjktU6y5nDXm3ZTd5N1GMOJ480KZf287qiFG5gW9DxDcB8zhNQAgO94HYNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUh2YcsyuAs32efeKS9yhvEHdu4fCU4hzRz7LANooogkhOfdFL
	pDcGrsfXozsP4vdzszuLgs5vimZ6fXd58tcmsfPGFqdWrlsFVQy7+0NrhKFh4A==
X-Google-Smtp-Source: AGHT+IHPwdoIIv20ZBrWH7DKZTnWpFwfY9K/rbsdLP8Ornpdb2oaHhsxCXEpXC4AlEb+sqMy9L4wzg==
X-Received: by 2002:a05:6830:4708:b0:717:d5c6:d593 with SMTP id 46e09a7af769-71a779ce2e0mr9736978a34.21.1731918235394;
        Mon, 18 Nov 2024 00:23:55 -0800 (PST)
Received: from localhost.localdomain ([117.193.212.36])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1dac1f1sm5350101a12.68.2024.11.18.00.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 00:23:54 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
Date: Mon, 18 Nov 2024 13:53:44 +0530
Message-Id: <20241118082344.8146-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI core allows users to configure the D3Cold state for each PCI device
through the sysfs attribute '/sys/bus/pci/devices/.../d3cold_allowed'. This
attribute sets the 'pci_dev:d3cold_allowed' flag and could be used by users
to allow/disallow the PCI devices to enter D3Cold during system suspend.

So make use of this flag in the NVMe driver to shutdown the NVMe device
during system suspend if the user has allowed D3Cold for the device.
Existing checks in the NVMe driver decide whether to shut down the device
(based on platform/device limitations), so use this flag as the last resort
to keep the existing behavior.

The default behavior of the 'pci_dev:d3cold_allowed' flag is to allow
D3Cold and the users can disallow it through sysfs if they want.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4b9fda0b1d9a..a4d4687854bf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3287,7 +3287,8 @@ static int nvme_suspend(struct device *dev)
 	 */
 	if (pm_suspend_via_firmware() || !ctrl->npss ||
 	    !pcie_aspm_enabled(pdev) ||
-	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
+	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND) ||
+	    pdev->d3cold_allowed)
 		return nvme_disable_prepare_reset(ndev, true);
 
 	nvme_start_freeze(ctrl);
-- 
2.25.1


