Return-Path: <linux-pci+bounces-11651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FE7950CF3
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 21:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48627B27DE2
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 19:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A321A7045;
	Tue, 13 Aug 2024 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Lq7OPLBY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2DC1A4F2F
	for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576331; cv=none; b=tC0bZy3gPVfpPuY/ndyHrwR7riqIO1r9on2P6+2mCeZtmwhN4gSCg5n52nbXPbwhlzut22zD1WiSVP1sIv5IggPUstKzpx+DtkiRyZQRfDYXnf5eu2o/e6ePuxoR8b3wTHRYcK0j2OkHq9/yfVtqka/5Aq3vA38esqehws+X30E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576331; c=relaxed/simple;
	bh=PPwW78qgunnYtZvqCU/S509OHopFesLiZnEPd2aWgyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ll9zhcXXqBfJehmKsTRsQaGes8zqoFeApJt+ysRPM7/jZNqfSbLY5VlLSgR0AqlzJh0AyXao1Yxigb2pWSnIhJIS4VZ6NeXzBDlcDa3rmP/bUhB620bWx4EZ+VQgNgszVqEvfxFbBfxlKv3DGa/tD7YU9SYyf5LyGsb3OwVVKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Lq7OPLBY; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-530e062217eso7150594e87.1
        for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 12:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723576326; x=1724181126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UIp7b12fAVv8rkm6/TKT5fjSShHkGlLIT78jfOCi3C8=;
        b=Lq7OPLBY+5yUQD/vMeyVH1SMtw0uJDKWc/qR0J6nnjQQrx+obM0Zx41Og1SaF4DewP
         iWueO0tRZSn3bWfOV27Wre7KIz+ndYGFAvAx+hKGx7jfxWvL9b+5EXKcbEvheCpirLQs
         QMwFsiHj2DP1lQmN1O6m9pAUUsvr++DDXjmzO4TRuhhOYrvIndHv650KmdE+iovNM8t7
         RR7CtG9u/z3zsElW84ms5jQIVEzpXSUZWoyy/JM3M1CkhnKr3d7qNNjV9i0SITzR+V4z
         IvutAFW20e447/B/Wl91FR+hjuFHfyIMli7FTCqGwZoas3yd35JlVau6dqXw00UZ0HFE
         oQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723576326; x=1724181126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIp7b12fAVv8rkm6/TKT5fjSShHkGlLIT78jfOCi3C8=;
        b=L/domaOG0i4MATIEpqIul/FBuvJHdlWp/UILk7idps8R3D93782TAItgG2VewnYfIV
         OkdTkJ6qfZCS1ZiLSpJij8sk63EYyF7fCFf5mCtiSloKPFURWQ3+1TLlcWuprQCoCk4e
         +Ri1kS+5NjQVY+kLpXLB3KWGIE/GfvSY3H5fr1fWjQ903uwRBCT0rr/eh5kD9itkVBV6
         6jrA6pnP10qzLZ7fwDth+JTh+0mY38pQ3Q5wOxIxtSXfHl7mL0WN3obfdbchAcq+3xTw
         AZGVXaTTFmB5lLgrkFBC56JcnRKKpB4gaiVYQU/0fzn5/DDVw3dswm1UNKJTeJl7pS3h
         JERQ==
X-Gm-Message-State: AOJu0Yyk71Xi1pBQSpp7Fqjy3mYwLglM9Mfh5u4fcKZy8exjrdg2h9Sn
	u8C/8HLGxiad1c2rLIazmeO1uHdFGo38Bnjg9dBt1Wol30/1s0BHKvVDgPFegDU=
X-Google-Smtp-Source: AGHT+IFIBVxZaulsbwEixDBwx/xvqg42Eqvsg5pKm87hj4sJVV0voSlvx3fWUfrZpH18h8eGif2S1g==
X-Received: by 2002:a05:6512:1396:b0:52c:e03d:dfd7 with SMTP id 2adb3069b0e04-532edbe9ab4mr264805e87.39.1723576326356;
        Tue, 13 Aug 2024 12:12:06 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3979:ff54:1b42:968a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51e966sm11091807f8f.75.2024.08.13.12.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:12:05 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] PCI/pwrctl: pwrseq: add support for WCN6855
Date: Tue, 13 Aug 2024 21:12:00 +0200
Message-ID: <20240813191201.155123-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konrad Dybcio <konradybcio@kernel.org>

Add support for ATH11K inside the WCN6855 package to the power
sequencing PCI power control driver.

Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
[Bartosz: split Konrad's bigger patch, write the commit message]
Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
index f07758c9edad..a23a4312574b 100644
--- a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
+++ b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
@@ -66,6 +66,11 @@ static const struct of_device_id pci_pwrctl_pwrseq_of_match[] = {
 		.compatible = "pci17cb,1101",
 		.data = "wlan",
 	},
+	{
+		/* ATH11K in WCN6855 package. */
+		.compatible = "pci17cb,1103",
+		.data = "wlan",
+	},
 	{
 		/* ATH12K in WCN7850 package. */
 		.compatible = "pci17cb,1107",
-- 
2.43.0


