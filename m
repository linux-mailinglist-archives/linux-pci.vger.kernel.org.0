Return-Path: <linux-pci+bounces-30022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B929CADE650
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 11:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6339217695E
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 09:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B581C28033C;
	Wed, 18 Jun 2025 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XeyVHp5b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10E7280038
	for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750237895; cv=none; b=KoQD89NkIfHkqBOjy35Enp7JqoaoRAU9V7mhVgmDXWeB7BxhfHp4upslXpa86oA5wJ+LjHEb7pSST31FtB8BpkDgbwtrMRYgy/j2QScFcJlaChlZsivKHE9giFw5haHLvBxaEKIBxVIdy207ru9UKJ252RmWRg82pkLl5wRJNK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750237895; c=relaxed/simple;
	bh=Xc2NBHsznUkZ7Zud/eNZV3ii9JTknqsdx3ydQFQ8NQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ce97JSQWK9MRvS9IZD3uhJjbH8ICvY6oHeDOC4eXmMH1mHbyl8/1WYifB73CmKHbiuFS6PAOf594E94MzED9PT8ykBClGjq1ZQ5eFL3R55jlslusHP1UOw4rVbuFLn9Aau19DzACQsaklIFCVYaVyXJ0rtTfsbGhsqa5Nt/fmAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XeyVHp5b; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a5257748e1so4799382f8f.2
        for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 02:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750237892; x=1750842692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CcBLm7tGhY8Rw7Vk5grZPteIq/0vRFGfD7tWVZQdGW4=;
        b=XeyVHp5byGJzYx8Gnt3U32njQRK2LJR+YwQ2NHlpp3kDCqMh5Unn5WRwr7yyJ/nEFW
         SzVTNsAMB8HnN90VMJk4WzeqfYaiFftaxzRSoL4Y4MRJDNbx5nt2sLQmRY+vVzizphUu
         YXCDcZLjGfnEpah7xz7ON8/33XQc/CyBULoLcLfIL3S4hxHIO5LGLHmusR7eXc5Ms9lY
         YkMFzrFNftaVA2Truldr62Ry+6mx+F0DS74YBCnKudl9RuUxiYPSHYx7wCHHQpAcpad/
         dbtK0ewMOP9Mhdux+fo5S8AZvbr6gTKQLwcEk7v/ngd+UfKqzv4EDRJgk9Uu982wh64r
         WwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750237892; x=1750842692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CcBLm7tGhY8Rw7Vk5grZPteIq/0vRFGfD7tWVZQdGW4=;
        b=ud+9oxB0c/r5ffugLI3OevekaLWgHCOvLQI0LjeFvUexl0jMkFfi59eODEq1afzAo1
         HbQywz0eHg7KaveFGUojNhT41NE/MkBnwk6s11mQvoPoA04Kup5wd/XExTtpONlzvrpq
         VN3SnJjWHUsiN+SyxAL8Ek+uk2eiWyibF17FsYBHBRqfoZkMC7RvttJ9eQuN46Li/aJJ
         TKHhsMVx+5DWcf+CTx2NQMHwPumJQEz2dEPUHBc5yAHhSZ3wgAcfY5te3Y3+44/t754G
         zfyYWSs46csf6Fu7MR9XKqo6ElAANO/65fJYHyoxbGP0Vy82FQccT5VJC3fGw4jbwq1R
         oWcg==
X-Gm-Message-State: AOJu0Yz3eeml2SLhQ2o6RqSzIHVSF2KCCJDG5eJ+kwma2KyV/mqY2cFZ
	F/0CQsi7GsFNHrq8od1pTFFqVxFpiVtCdTKgmT9cfoePriRLWjrvFTjmCPV4AJbNFlw=
X-Gm-Gg: ASbGncvduDrw+efBfY9BdAEAb+EkW8BjFxHB1T2lSIeNdsk+90L5+Urwvbb3StRP2+W
	YnVslbRnyOCeiqpUOUhNUYCyfwygbG3jSCdpdGNfDc1m5p9Xl461g5A37nPMIveKt+ZIuwAheQb
	Rjb1kb2oaWBqLnwC6XPty6d67JXpStxreVHL1ITXPTVd4OilRw9yzKbJMFONrPSu7/xt0oc9Hm9
	HlkbbvWBCJh/iCAof8tGfAmHTAmkYo3XuczoyIefLub6FAuvnhc94TiP+b55a28YET03hbs92Ff
	1Ep61ti69Yt9IWUw/JHCQmY18XZzHAcdL4WeGSvvIsXz1BZpIgQIaqZ9fikP3k85fQISF1Qs
X-Google-Smtp-Source: AGHT+IGdGxAgTjeq442KrF43tQh5NdouFuIUbtzATFWqvgo6etguIElMXWR18XsY0rulcJPK3B0wJA==
X-Received: by 2002:a05:6000:1887:b0:3a5:2e9c:edc with SMTP id ffacd0b85a97d-3a5723a2de2mr14254428f8f.34.1750237891947;
        Wed, 18 Jun 2025 02:11:31 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:ad8:9ec2:efc8:7797])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b089c2sm16550526f8f.59.2025.06.18.02.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 02:11:31 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH] pci: pwrctl: fix the kerneldoc tag for private fields
Date: Wed, 18 Jun 2025 11:11:29 +0200
Message-ID: <20250618091129.44810-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The correct tag for marking private fields in kerneldoc is "private:",
not capitalized "Private:". Fix the pwrctl struct to silence the
following warnings:

  Warning: include/linux/pci-pwrctrl.h:45 struct member 'nb' not described in 'pci_pwrctrl'
  Warning: include/linux/pci-pwrctrl.h:45 struct member 'link' not described in 'pci_pwrctrl'
  Warning: include/linux/pci-pwrctrl.h:45 struct member 'work' not described in 'pci_pwrctrl'

Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Closes: https://lore.kernel.org/all/20250617233539.GA1177120@bhelgaas/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/pci-pwrctrl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pci-pwrctrl.h b/include/linux/pci-pwrctrl.h
index 7d439b0675e9..4aefc7901cd1 100644
--- a/include/linux/pci-pwrctrl.h
+++ b/include/linux/pci-pwrctrl.h
@@ -39,7 +39,7 @@ struct device_link;
 struct pci_pwrctrl {
 	struct device *dev;
 
-	/* Private: don't use. */
+	/* private: internal use only */
 	struct notifier_block nb;
 	struct device_link *link;
 	struct work_struct work;
-- 
2.48.1


