Return-Path: <linux-pci+bounces-8641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B66904DFB
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 10:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A472873D7
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 08:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BFA16D4C5;
	Wed, 12 Jun 2024 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="TQxk5MYK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0594E16C857
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180437; cv=none; b=RdyabnnH0TpKjGhzJosmYYbvCBo7j2r42i4swxz3n+uCbIshEsAarWvhludDPWquZCq38DPcA4byIuhrVZfsrDdvQSUJAWTxE/yaPZiSgKmNszFWTmvwu7s/MZ6MvA9cZ+iW12Ebw1fWcEyx0OzU1gwetSMVcl7cGcUg/PQfoF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180437; c=relaxed/simple;
	bh=7ODnCMLyMATh86YrN1ZPmjwWRMHpwQW+fCV8rLwj58E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSLpPFGlHYv3v6ZUEmxjJnmkFYrNEobhn8Pl4yzYm1fbJ8rTA7cVwsXnJndJ/rBD1qnIV5dpVnN9Es64TvHHKf8+Vnrv6Fh2WN3B4etGS9yveUnsR0/HZzW+UxzMsG66NFIMVbuIf+X4qn54nGOUP3iNCgTkBqxACPQLg73ZU5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=TQxk5MYK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42281d8cd2dso4242325e9.3
        for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 01:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718180434; x=1718785234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+tryJWSLGei4yj4mnd/Wwwy83ERVx62Yqnj8MX2+CY=;
        b=TQxk5MYKztGI6IXzOvLNSX1Njy4G7Hep1ykBwj6IhXYoOEw9pKxLtEzPd2wxtFb+cc
         YAUAbUsz81k3PQwwtmjrzngEVjQP4rLRn5UMo326cRTX8vPoPRci43fPmLaByxOTfn0s
         n/+BQV91CFCQfd7B9ahbGfKBH2G/7GNjglh78dz6WDDucsESrZa2P7YjtAmSGe2Otl4p
         mHrThXSC9sEbti4UNFlq3kAWDNBu0OM8OnN7vKzYrh2PdIGXrNLYaA54VLL23wbtVBDi
         6AVHg/yCYS9XrSRZcSTyhPVEWqy7IoZ7N3QAegDDfM4e1rLHyOEZU1pu20naTZo6ShTL
         pYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718180434; x=1718785234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+tryJWSLGei4yj4mnd/Wwwy83ERVx62Yqnj8MX2+CY=;
        b=MlDMUleXapvzgJ70MPSlXLZw9sdI3iAz/L5dgNmpBmyHrN+myhxeW4M8tJcpXn16qt
         LNhzew31B1FxA4hQy8lk9Yy7hj+OdPPLlfNUK6TUfsnPspnzHCtaKE4fKxK4BvZjK3PV
         I3CBJaIiCS/TNiYzePrLCeRXiCavFv1yHmIMGHGnxtyYV0GjnA6ed5dS5gj+J1jVySyl
         MqBFu7iXjppR1AblHTFDBHww1/VcTsYL+S2FmV+dxkBLd3kwrNfhO2q9PORDWzOCcVUR
         NHG+aG2d15pnhPZ6yVJHProgu+djX98z4hXZaeB97LnswVIxcNRtGJLtz9qcRGOyiQYK
         Hr5A==
X-Forwarded-Encrypted: i=1; AJvYcCWmCp3Lz4mojDdnPiqdT12Usddvu8PduepgCdjGHd0yLyKQkNV8SiJzI0K5A9p8KUCbMRT92nXgsiyrf1C4R59nvIRf+06ideOL
X-Gm-Message-State: AOJu0YyWvs+BNsrcWmzsIXHSGd1tNFj8K7vtwpcmyHp7BmEo5VYbefKd
	aUW4h72RaASmoBZ14xunRU6PJQR2hKkSiE4eWjoyCBChGx2rhW3wF+UrYPfTFVU=
X-Google-Smtp-Source: AGHT+IFDFkTt9Hyalt1EORmsWnUvoaT3No0XLhTfumJCHtinnWuBc/50Y76gRwgEs1k/81gMqxtorg==
X-Received: by 2002:a05:600c:1913:b0:422:727c:70b1 with SMTP id 5b1f17b1804b1-422861aed43mr12346085e9.8.1718180434362;
        Wed, 12 Jun 2024 01:20:34 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:8d3:3800:a172:4e8b:453e:2f03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4229207d1a7sm6011775e9.1.2024.06.12.01.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:20:33 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v9 1/5] PCI: Hold the rescan mutex when scanning for the first time
Date: Wed, 12 Jun 2024 10:20:14 +0200
Message-ID: <20240612082019.19161-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612082019.19161-1-brgl@bgdev.pl>
References: <20240612082019.19161-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With the introduction of PCI device power control drivers that will be
able to trigger the port rescan when probing, we need to hold the rescan
mutex during the initial pci_host_probe() too or the two could get in
each other's way.

Tested-by: Amit Pundir <amit.pundir@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD, SM8650-QRD & SM8650-HDK
Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # OnePlus 8T
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/probe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bfeeaf2d1fa9..b14b9876c030 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3083,7 +3083,9 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 	struct pci_bus *bus, *child;
 	int ret;
 
+	pci_lock_rescan_remove();
 	ret = pci_scan_root_bus_bridge(bridge);
+	pci_unlock_rescan_remove();
 	if (ret < 0) {
 		dev_err(bridge->dev.parent, "Scanning root bridge failed");
 		return ret;
-- 
2.40.1


