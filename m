Return-Path: <linux-pci+bounces-28273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C423BAC0D82
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 16:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019003AACF1
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 14:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A797228BAA2;
	Thu, 22 May 2025 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nr53kkY8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB9228B7F4
	for <linux-pci@vger.kernel.org>; Thu, 22 May 2025 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747922640; cv=none; b=Fbydhl7CiiV8AkbkK6asJ5lgJR5sbamOn9A/Ykwqm+mZ9NByFTHuUVYbTVHJjwNT4p80J27rPsRuyrQapZglND2RnPAlygMcktI+THB19tvK9KpQ4baTJkEOuBoTGtXizDRcy0GLZfbzxCRt8n8zUW/6lo0PNX2T173Xhh99dDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747922640; c=relaxed/simple;
	bh=1KVjcik5so/WTA64+96vM5LC1e61yVX6g4s+JpKmV2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m5F99UlTSIQme6pd5IHkUFaqUSDJ+PI/+wnklaNwgHxQJUuamOqxXX5RakVgBWvCHP2sejdxg+XFvKlu2gwuicINGJHB7jWPZR5OnXZF+0XPz99XGHtg6DJRR4prAxaDakQvHI67SHQJGkT7xKt0VGf82tO/21xT15LbhrZRtyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nr53kkY8; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-742c46611b6so6540861b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 22 May 2025 07:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747922638; x=1748527438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WFeocyTJuLKPQZ0pWs7dDXWGd3yi1SWCmy79lHa62kE=;
        b=Nr53kkY86zoALfGxA53ksW5QSy+ajHUZXaZRfjooPddKw/li9wgH5eq+V1oLLO+rRm
         iRLgpmhc6vmk5x4k0SFWgqK9PGj4gvlCOxge0kyD298v4pqaBMA+TeafVfslFIWCxKmU
         LDVsRqaTMzqdLqv9oxDZabsx5Zu85/7cZdQJ+TlecLoiogvY5bH7jiK8CVHOmCeSeDGh
         I+WhuYf6ME+H95BgllFxtIpdZJTbCK6tNntVPiRC44+3Cb1BPKzlQbKv41/tm8UbO2Pr
         KlS42pSL3+LRp89uEqX2YaIhUwHGW3vOruWOTr96Y+TRJA27L92aFJr2b8T6sCRESYyK
         cozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747922638; x=1748527438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFeocyTJuLKPQZ0pWs7dDXWGd3yi1SWCmy79lHa62kE=;
        b=bdOstz05E5xC4d57i3QcBmK0h7lqmGUOVIy8k+3BwfHpVUFH8JpvfU1AloyzS/eT2I
         +tpdv5+b+FpdU6pACMg+HOMYUFWLmdBgnBbtdAXg6ueHsFI44XCt0lMcc6dZW/f+tVAe
         v0k2m/qjlQHlAIcFM4hxjpUGAMz9ztcoe9jHE8grOZX7mJf8GZuW2AU0Yg1k+5bfr1Ej
         A1aNkQ9Wj8cmgwhVZB/3icgdet6DDySdPtbdSmaknZgc6omxN+27IchcB9mxLK97jREr
         YuopTX3LE9UVNpyRtaf6q31LcXN+puqe5bFZL2W4gK0dORM6nOCYGFGF35Ax1Xwuc7KJ
         pfWg==
X-Gm-Message-State: AOJu0YwvzAhGA0lme67dO/FGa7NKk4ejifL6/kUKhtsZXHOiZpL13WQv
	gk0qJOx/SF5uKy1Lfq26DW3W70nUpgRdF75zg7haKKzedPPzBvCBKC4ix3G95kEPaprn1nhBn52
	O7Z0=
X-Gm-Gg: ASbGncv44NQtHvh5nduM6MpxdoIC/qPXv43yz6GUCmhOmEwSDUoIl3D+IDTUmXxaFd1
	llh1pUJki32t4233KGSQbTi7sbfacPwccRn2/sAmF0717n7QLDgp72E7AB+lWTYvncnNIAUYoCK
	BYJru2Wytw7rTCuc2rtHEa701x0PpSsGP3YlVUrvIe9+UgJqICzh1HYzQ70255LrDMyUQ3kpEWS
	XN38npgmvmVux5XGCEiUT2Yb2Xja7n1/r9macb+ZZhgpovrFL/J5F6y3ACLWJ8hfoBQurShFWL7
	CEV7oKtVUR41/2xyMR6GwlC6dYFFgMVvUrMjRzYefhNQiuw/DIwxwLfMmTaoRu6o
X-Google-Smtp-Source: AGHT+IG1vC5VzRGtucIyP67/HVoXG1ghss4YShEgmt/nznCRuiVBZrRT3C7b2kCpEHLM7q1bfdFeXg==
X-Received: by 2002:a05:6a21:3405:b0:1f5:9330:29fe with SMTP id adf61e73a8af0-2170cb40802mr32117847637.17.1747922627085;
        Thu, 22 May 2025 07:03:47 -0700 (PDT)
Received: from thinkpad.. ([120.60.130.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98a2146sm11247499b3a.160.2025.05.22.07.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 07:03:44 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bartosz.golaszewski@linaro.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jim Quinlan <james.quinlan@broadcom.com>
Subject: [PATCH] PCI/pwrctrl: Skip creating platform device if CONFIG_PCI_PWRCTL is not enabled
Date: Thu, 22 May 2025 19:33:26 +0530
Message-ID: <20250522140326.93869-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For platforms that do not use pwrctrl framework, the existence of the
pwrctrl platform device will prevent the enumeration of the PCI devices due
to the devlink dependency. This issue is reported on the systems using the
pci-brcmstb.c driver, which doesn't use pwrctrl framework and handles the
endpoint supplies on its own.

So, skip creating the pwrctrl platform device if the framework is not
enabled. It is only a temporary solution to the issue. The actual fix would
be to make pwrctrl framework feature complete (by supporting system PM with
WOL) and convert the drivers that already support system PM like
pci-brcmstb.c to use it.

Fixes: 957f40d039a9 ("PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()")
Reported-by: Jim Quinlan <james.quinlan@broadcom.com>
Closes: https://lore.kernel.org/linux-pci/CA+-6iNwgaByXEYD3j=-+H_PKAxXRU78svPMRHDKKci8AGXAUPg@mail.gmail.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Jim Quinlan <james.quinlan@broadcom.com>
---

Bjorn: Since we have merged patches that rename the Kconfig symbol from
CONFIG_PCI_PWRCTL to CONFIG_PCI_PWRCTRL for v6.16, we need to make sure that
those patches also rename the symbol in this patch once it gets merged in
mainline. Maybe merging this patch to pci/pwrctrl branch and rebasing the
renaming patches on top would also help.

 drivers/pci/probe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 364fa2a514f8..7f5e91eafe56 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2514,6 +2514,9 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
 	struct platform_device *pdev;
 	struct device_node *np;
 
+	if (!IS_ENABLED(CONFIG_PCI_PWRCTL))
+		return NULL;
+
 	np = of_pci_find_child_device(dev_of_node(&bus->dev), devfn);
 	if (!np || of_find_device_by_node(np))
 		return NULL;
-- 
2.43.0


