Return-Path: <linux-pci+bounces-33584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2F7B1DF48
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 00:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D843D584256
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 22:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB2822A4D6;
	Thu,  7 Aug 2025 22:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c46aMqEM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF204246771
	for <linux-pci@vger.kernel.org>; Thu,  7 Aug 2025 22:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754604920; cv=none; b=nqOdJ/6tUqWtDYi867Al/RU2H88u/E/zjRxnqrCY9R/4EHan6hPmLR7XEGgVHuPZy/WQGwCRSzY9LTE3QIPEZxRFWDMiBTt/ovLq0FrecbSOc4Xmjo/8fZllsrtdQeb2Fvv3zK7C70ztZ2pYew982p7BAdgOI2LJAhYM992VdFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754604920; c=relaxed/simple;
	bh=cpYosszGE7z9FBSZYrQgJg6t3ei7dtNkmJCh0m8xF7c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=tT8p3Mo1HDGYXUcFBGmA74ZvYDpPkmlb74j2XqXQ7gwd8hi0mds2O9NCDDqzwcMsANGkQykOa9AdXOwejX1S8NJt0nSvFrnfPsYHFAVgUnHMYrKGABKVVaiFQdtaGUB6OCyvBJDB/q9R2wWFvIuuTSyOx9CPZVm9x3HfPhezfRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c46aMqEM; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b09db20abbso11632771cf.0
        for <linux-pci@vger.kernel.org>; Thu, 07 Aug 2025 15:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754604917; x=1755209717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SqUvdOC946rFD7lpr+DjUdX+bn31qNKPQpPGSWv0WLQ=;
        b=c46aMqEM50+vGcYhbfbRwfx8e8eONu0qbiKQc9njk2wuY11QA5Dqp6MTijIijNctpE
         6+ApxBGVPlaaHCwPmCSgsXCm76anhiHMHTggL5U++wlZIeKDLihDK4q7/Dk+ZDPDscYV
         OL6DpEKA7SIDN+wtVv92LeoGLir7cUUp9jE9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754604917; x=1755209717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SqUvdOC946rFD7lpr+DjUdX+bn31qNKPQpPGSWv0WLQ=;
        b=C/9Gi9HEQd/WDgP0cktcKDM9Jt68G8kGzEadhhKwkDy+N4FYkackBR3tVb9QDbKwiJ
         vc94QHJvi9TMrRje6Ex4ZeYYT1Cph0kXAto5YnjSc73qYbpLO+jQHTsdt+bpwgyYdG9e
         RbKkB3paMIekiehKSGwe4Ax00yiStIcjSMgr9bygwOaBYKMFWBHJdAIXleN5bHmJYXma
         WlugOI47modFiPJpkG5cW13hA4yP7wxcc/MaY3q7bzCtxC8iQKdF8jgZEa1ST17qlSeC
         FhYlyvHgO0+52OJpZXnvY8kGF4w8jlvWPOgSbgsl15+TdZ9VsFP0/b6NzIwhPk/d2WAP
         uiMQ==
X-Gm-Message-State: AOJu0Yy3YGFd+19ADrBtIiaKua3k4wEAUXPe1V0ebBrmaFMZ36crlPYp
	v1oCf4F+tcBzoGd3vkkT9jXdXWBmkRYOxrsV3kp3IWUs1xcH+eooLh1QMPCCveX57/Y2KXt03IC
	sPq1qYxU2hnw29I7eC2S0XmlJ8VpgQtCuZi/6+PMwKORJBQERVyl9KR/9Sw8xuCt7kT5FnnQXP6
	vxKK7gv+c7DxAXgz/BZWdgN5vP+9CwAzKsCTna0p5hv69b+uxVtg==
X-Gm-Gg: ASbGncvbNKrIf//1Z6CCsDznc64tHqzZ8/K7mtHv3oT1G8acU7e3r/wdBMf+kz9nq2f
	1leatJuZ/HnKG0qq18dUD4MbF6R4Oto50AvOzXKy8TQ+AM2MzTxu5Kz4zOuPUjerhOvyLTH2I16
	IwWM2S+10Ikg6gcg0BOFmfiI4y+Mq+bxpFerG/FcYUOGL4wmNoWkupKF85j71kq6sHS55POXTH+
	xTNboGBTGVti+Vp4SUG/1fQlr87lHkpL+nNPf7NwmLUcCj1kR5TXcWnw4s38MqCAEY09AlTTJnS
	8a7lO6FP+j/WTWDHU03rqWrQGkHdXm+6Av28/lZFTiVXaLINvz9XG2dCQrANG95T8J/9ohD/gHC
	tZm3gJjiiApO2yJLj0QLCnDF9g3zygPSMstBmrr2C0gJMEkDQ1f6pIQDbsfgRKiWt2OCVP7gxr/
	VmjA==
X-Google-Smtp-Source: AGHT+IGrHY0W6jxNkbrQ3m600mFCkOGQ/IxVhQDWJBcdeWQRPKOv4UerjzHk2+vz9NrXyRZL7wcH2A==
X-Received: by 2002:ac8:598e:0:b0:4b0:7c42:8dfe with SMTP id d75a77b69052e-4b0aed0c810mr19173841cf.7.1754604916715;
        Thu, 07 Aug 2025 15:15:16 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0aa1efe78sm9527421cf.8.2025.08.07.15.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 15:15:16 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Subject: [PATCH v2 0/2] PCI: brcmstb: Add panic/die handler to driver
Date: Thu,  7 Aug 2025 18:15:11 -0400
Message-Id: <20250807221513.1439407-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2 Changes:
  -- Commit "Add a way to indicate if PCIe bridge is active"
    o Set "bridge_on" correctly when bridge is reset (Bjorn)
    o Return 0 instead "return ret" and skip ret init (Bjorn)
    o Use u32p_replace_bits(...) instead of shifts and AND/OR (Bjorn)
    o Reword error statement regarding bridge reset (Bjorn)

The first commit sets up a field variable and spinlock to indicate whether
the PCIe bridge is active.  The second commit builds upon the first and
adds a "die" handler to the driver, which, when invoked, prints out a
summary of any pending PCIe errors.  The "die" handler is careful not to
access any registers unless the bridge is active.

Jim Quinlan (2):
  PCI: brcmstb: Add a way to indicate if PCIe bridge is active
  PCI: brcmstb: Add panic/die handler to driver

 drivers/pci/controller/pcie-brcmstb.c | 204 ++++++++++++++++++++++++--
 1 file changed, 193 insertions(+), 11 deletions(-)


base-commit: 6bcdbd62bd56e6d7383f9e06d9d148935b3c9b73
-- 
2.34.1


