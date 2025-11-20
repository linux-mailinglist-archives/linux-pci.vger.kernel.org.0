Return-Path: <linux-pci+bounces-41747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73801C72EA4
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 09:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B65A64EF106
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 08:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B1D2E9EA0;
	Thu, 20 Nov 2025 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NEmVBWay"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F2830CD87
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763627285; cv=none; b=gvfdaI1L4jjfbF67t7bJaY0JapRW+9gKt0vksc+jaibW/4Y7xzY7DCPE+xG7wIQvpNVrZmUPw52AK2FTruwq3CiX5pT2N2YVhYwaPAxETs/lWxmWifQehT5fxOxRTfmhEJ7jCEEmxx8DQFO/bTkc5zcY4AbstyfyOOVSH5/5X8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763627285; c=relaxed/simple;
	bh=yhkpPxnqJDDLNcpmyWruX9obDzPE+LZGVXZ2KcFXexM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GcI3Hm3p33Qx8BRuIwWK6Y8Nnlfmn4mhDaOOQ6dqiSSqxH6s6ReRkHifV52pmByGXRUg+Sz9ehkb8+XcATpeq3XZZb7SPZk6KxlPbcURlIs6Ppnt9Zqiohx+97u0gJidmDr3fxmAvolt3XW0ethoMc+zk561nc5BSmBquXimUcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NEmVBWay; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b31507ed8so507379f8f.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 00:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763627282; x=1764232082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mlo7c2AgCPZO22byEKaD7zpgLlt4/Jhg8EPgXCe2PfE=;
        b=NEmVBWayT10zNhWvI9x+3ERoFbXxYWyxeRyxB1knm2i+giftBrKl/g8IhdXuxCdSaz
         s7H5HfUgn/qqtnO4mRiZjTJITVnPGiH7TO0FYMIgRwJFI8vst9vmlgOyYWqqYRt4iUJ4
         fSBt+9zKiiD7X9qg4ZQTuaClWu+ZTnSNoWghtopXMmcVN/ltF4s2HYPi2eapHDH0C1fF
         ERuVGSJKOFOjIZMXIKAFS2D2i4rrrBf6ztKAJ9U5fiNAPCK3pOHtYX3eCSURG1tWOR4o
         cZH6lHnWFZWCP3vQHQLRz7VCKwVHcqoWkNycKhXWD8I2l7aEeIRbj8vz0V6Q5JcCN7QE
         ecuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763627282; x=1764232082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mlo7c2AgCPZO22byEKaD7zpgLlt4/Jhg8EPgXCe2PfE=;
        b=l//xkga/Daww2grui3RdIgcVAeiyXdb9oA5NI3MYN6oWc6ZePVqYRajyXtCT+U1gfR
         TFCIwU56ets7qN/cmYxkiD421nI7FucXHN5hr+ptGuDB2achBoWtxd+km/tR7rONwqKi
         TkLfGI3LbkAGrbyiozXXwwnhP/XLOalr56OOS6S5b2kJ4K/y00p6c3keG4RUYVKFfO+S
         vztOgBy91AV1jKMoe0ZJjFstVONqGA2bC+1tKOV0tqUKdrJGEK6digeegwq7JI62dDXA
         IIT0zJ2IRd6eSWnWYQiWMNFrzArj07KE7qiiU9LsdhRoE6GCkpcyh43Aiv/4aSgepIUq
         EU8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwP3UgTPeCFoyAOa0heIuoBU5Tk2vqBQ6GIVs7Xu4fwJhug+wnmrZC2DjRcf6TFwfGvzGuOettOnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQZu7tloRtVvYAXFFutGq6nvtDGL75/zDJrR9wX9o678aRQX6X
	wyETG7ZXaepdQO/yKLSsOOZeZZLA2te6kugcEPQZLnr0FdAyY2E2ydb0FU/KLmOsF4E=
X-Gm-Gg: ASbGncs+nlYyXvO5iB/y7kLZVaKDZeKrwzMjAAvDvHl9CZzrt+Fn4he+QtVWupFwZ7F
	oF/3yb7wD0TeULLA9GfbB82ySRiY5H+j/9RUoye0+SRpG4xPM1WSSJ2QY5CGTJnnpXefTk//1ea
	v685NmtCU1VyAuWsXEPO5Xtfm31ICYB81GFzIa5K9Q4e/jHcP0PqCHUugKL0qUi4V9R9RFryaXy
	s2lDKr5FJzT1I0Fl8HDBimbNomIsoXv8ufht3vqUfKXyGXRTlmaDAWJOfSbX2ZH8gWC3E3PUbau
	vl8j7ydE9ocu4D7puRrbXRWEX4Tv+Yi1hfFQNOUVLfEBLm4OrzYj0T2ijB7Nh/Lb5hxe9n0W33C
	eT5GcvE8LdaqS7z5WHeG/LKTCVUE8rxNwYCpaSc07wq69Lw0ac/SYgqXWolaZpTWhWJD1z0yHNq
	Q/zMiev8soTXkd4A==
X-Google-Smtp-Source: AGHT+IGv1wI9Mex5MR6LhGondGBzHUMhvEHUwLQQRyoNfYLNUrW5taMy2GRtPkKsOOLc8k2rYMZtww==
X-Received: by 2002:a05:6000:40de:b0:429:c851:69b3 with SMTP id ffacd0b85a97d-42cb9a5c52cmr1470208f8f.30.1763627282223;
        Thu, 20 Nov 2025 00:28:02 -0800 (PST)
Received: from brgl-uxlite ([2a01:cb1d:dc:7e00:37af:6c1f:28a:47d2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8c47sm4159539f8f.38.2025.11.20.00.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 00:28:00 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] MAINTAINERS: add Manivannan Sadhasivam as maintainer of PCI/pwrctl
Date: Thu, 20 Nov 2025 09:27:47 +0100
Message-ID: <20251120082747.10541-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Manivannan is doing a lot of work on the PCI power control. Add him as
maintainer.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 59b145dde215f..549e51e57c4cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20100,6 +20100,7 @@ F:	include/linux/pci-p2pdma.h
 
 PCI POWER CONTROL
 M:	Bartosz Golaszewski <brgl@bgdev.pl>
+M:	Manivannan Sadhasivam <mani@kernel.org>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
-- 
2.51.0


