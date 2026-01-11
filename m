Return-Path: <linux-pci+bounces-44439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7E8D0F79E
	for <lists+linux-pci@lfdr.de>; Sun, 11 Jan 2026 18:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58E06300ED84
	for <lists+linux-pci@lfdr.de>; Sun, 11 Jan 2026 17:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43685D8F0;
	Sun, 11 Jan 2026 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUq8J65M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DD61758B
	for <linux-pci@vger.kernel.org>; Sun, 11 Jan 2026 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768150846; cv=none; b=NF02BCtUhZPkPKOBF78yqUOvVOiMZtpoEjfjUoJe/UYwQ1F8Loc4jAmb3PUT1KMQqOpmPd7DlnY2XLrjJHmFYeLDHHLuO9XJzMHYKIz3zS5o8lzer7A6JgpWUp67LQ3/kWBJRO78onjTX88bByi8hrYTTzhYGq3LQBFJag7E0ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768150846; c=relaxed/simple;
	bh=hRpSrENs+exAzLmmyDR9z10zgMQx/BnRWTtqM7vZG+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=REv5y7piGY9RbHYoKLrio5f64a4VsWLf8LriOK+AB2I3UfrP7sg5S0Ghoz1yejF/hPuKO8FjLYRiB580IrY9SojA41nB+1lEGEP6WhSujnyS70uBxzwUIAQtLQq7NlLYeEyJdkKEGoZZKlEtVzgMJG9y6xnAIqH/LdKn2Qx99Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUq8J65M; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-34e730f5fefso4125050a91.0
        for <linux-pci@vger.kernel.org>; Sun, 11 Jan 2026 09:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768150845; x=1768755645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6kjR6vJVSaNEP/K31+so/7gi81I0rHPjTD6YqT7uJyY=;
        b=TUq8J65MimOKt5h/a2F+ggaiFTL0YBloJ6YFScfTLef+x1Rk+QZs2u4n8aIWkxLFXz
         2Cfa5tGcR7HGXUkEZzl8ahC9zI+NrbuDZNbO/5jV2illBLNZsFazvYyvBHA7H6mjiT6O
         9NTM/gRhB2B+Qf+I+eEtpmSugFhHUUyouVKLDxBpx81qCVwqLCzr/V5Op5hHMpyZ2zWS
         fALrJe8jKaq/0eCkrmO1PoiUvn/sqd3vFXDkJVqWab1J69wEe1E/jQXjGujLKWFi4tk5
         WMuxmKOaSGX7zgawm2NgnTadXs1eJCmueYtBY/KdpKHmhpJNtn4F/oq0CZtqY3nKuJd4
         JX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768150845; x=1768755645;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6kjR6vJVSaNEP/K31+so/7gi81I0rHPjTD6YqT7uJyY=;
        b=f2ux/Qzo9yZfNbX4cPC7wk2bOQaQchiKGPEeGdpW5PWYtwblZHW1KdS6tTEWKiAzEO
         TVIFx+zsnPzWOMP2wdhfCQgt6FCJpW5oKxRbc2532/x161+gYC1DrooMITOS7ifxETXW
         Wcp8X37CP3xrofkS899h8fUQXyope2Pk2CvOkry+Wylvjm3vpQPGQQ0/zwd652B5MYEB
         gHl0X4Q9WFVFuPhppa143kZTRlsEjKRDFmo5pLoCsbSUkVMDKFEDntG56sucGmyrfIJI
         1/k/swL8THEBwotfTazKakiDFaun4aSyufKZLMh4v4haxHg/0FVh07+chCm9y8cLrpbl
         LITA==
X-Gm-Message-State: AOJu0YxiATYcBBJMNk9RFuCp9/RyPSrN7eHa+b4GUhCnwLmvx69gO32v
	26YaqEOu8tFCs3QK1XdcH0rkyc9EmGHOhNYLkLNb3UMUMDq7BsJQtON7
X-Gm-Gg: AY/fxX515oJUPV7oqLaHkNw6/icdkE9rwC4Xz7vTBmJHqEsROEXgg9L0PD0kV4BdcrS
	uAHjvk8K04sWqajz6cWmOX2zJqQSgMpDIvCEgAwf18vndH5BHNrAOLs9th4pCw1HSqlOqp6LQLC
	GZ6YcW9Car6ln8AqYTwPHnTHYnul9mZLtup59A7lZF9SciIyyy5nXQO1yo6wRdXo8HSp/3lJomX
	XDitokMVrI5T/lzwT4zdGybPre2Jl9IhpOzEgBduIZ/N7Td00jhsVQoBLmGIGOdpBz8mKBuRY8N
	N9SuXFpwBy9su1nSaBT5SjtCHGI4YlRytYwiTLZA8hz9CvdwWlnrn0Bp9e8zIzWRf/JSUgkE3Np
	wFbTy629MCBQNHq+d0fiFHyzrgpMk68vW7FtHR0PmdhpC9hBx4HtrR4bEuzVVdkwgiqbJD9fAs8
	SONkA4OWdGg5NylCZcJYzSqGc3EqiUFPAX/LqAYq9MIc/ssAM+Wn+GdsxLKKzRHE6a+g==
X-Google-Smtp-Source: AGHT+IFt0ORucE5sJv3IM0mkDwpWDLSo+rRqQTXeM/xgroPRzc2ArLXkenT9yyjgZva8oiZUDVKi9A==
X-Received: by 2002:a17:903:298b:b0:2a0:d5bf:b271 with SMTP id d9443c01a7336-2a3ee486f81mr144561425ad.32.1768150844710;
        Sun, 11 Jan 2026 09:00:44 -0800 (PST)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a507sm150677795ad.3.2026.01.11.09.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 09:00:44 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH 1/1] PCI: hv: Remove unused field pci_bus in struct hv_pcibus_device
Date: Sun, 11 Jan 2026 09:00:34 -0800
Message-Id: <20260111170034.67558-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Field pci_bus in struct hv_pcibus_device is unused since
commit 418cb6c8e051 ("PCI: hv: Generify PCI probing"). Remove it.

No functional change.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/pci/controller/pci-hyperv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 1e237d3538f9..7fcba05cec30 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -501,7 +501,6 @@ struct hv_pcibus_device {
 	struct resource *low_mmio_res;
 	struct resource *high_mmio_res;
 	struct completion *survey_event;
-	struct pci_bus *pci_bus;
 	spinlock_t config_lock;	/* Avoid two threads writing index page */
 	spinlock_t device_list_lock;	/* Protect lists below */
 	void __iomem *cfg_addr;
-- 
2.25.1


