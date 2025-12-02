Return-Path: <linux-pci+bounces-42491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AEBC9BE85
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 16:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C6384E2D30
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 15:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DAC54774;
	Tue,  2 Dec 2025 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V6FU1JXf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867AC23C4F3
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764688460; cv=none; b=uXtrvPjws1fGdgvqILbVA7i35l9XHeBfDmUjZ6qD3ILiYOfUKZCO/qHX/KmgFivaAne36RnxM65Iq4xJgD+pSC6VFuGbJXl7W7P1GhVec1O4wGGigznXYajLRpimgj5stJRSAkXJa/p9BfWXnO/7QagQ0URvgOXig6U4JlKoF+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764688460; c=relaxed/simple;
	bh=GM0JrmfiNdfo48tsNKE/oyZWmsSgnTdU7rBVJeWsd5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O80lD9QXPSovbkySrL7TCnLqkRH+r7I9OoYJypdaZi4sTzvAa8ojoR/NuIlGw/3txyFG4DtiDJIb9CWLpRWrKarpMi1CKAdybq3YFxYG6iLT5rRHyb5VuOd/HRNDrFJaks/XCyo7eijD0BzfM4vBCErMFaYIxeinuRt3dllGCnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=V6FU1JXf; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so9187667a12.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 07:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764688457; x=1765293257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJleW3X0oHBBWB0t0WSDMI9zF1AEbP8yxVeFgIwRq7Y=;
        b=V6FU1JXfZco8EyyKZ/6Gv96DOwtqtBXrlNtx1Z7uJoFF5tUZZypirZuHHPr3iGWxyy
         HnSoeYxgiQK+xNSbesKGXIbY6sUndzrM27fpbqPuj0HqztIM2ISjn0daQzt277Q5q+4k
         ulEjisxlpfmGbzBZTjc5CfPYSODsYNgbR6e/Xovtzr2yaoln0xP4XJxRiPmn87z5dfta
         aVe+0YWTRoOVPzd/4WoTsJUEq/yqtn+7BzzRD2LEOqLIcr5SOVntwAx9FDmp+CfYXFcV
         hpBzyaxfrPI+X4AyGhG5WnYlbPt9Pz1xZXWMDLN1GjXYjrSX9aGaNuPue0pf16trbgKP
         bhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764688457; x=1765293257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RJleW3X0oHBBWB0t0WSDMI9zF1AEbP8yxVeFgIwRq7Y=;
        b=kZ48NOXYorNY7hRRJ9t1pzeoq0E5UfCpQAKUBODXuzMXGYg90sjd5uakOooAAYvShf
         u3rXSCXcTXA6DYKHLlv9+0yusOgiy4uLLNd9mEcT+1Y2dELIQhe1WYfLp5CKxyHtiudF
         7L2a4LWTEJZd07AXeGGbPNjmOrEZlcXEHhOpkf7yIXULV+RXo14LVAchsD9Moj62Ap6v
         GJ2pNnjf7AF/O38P1A1k3oP/JnVTvTxaYLGnCYWBwfdfUYB+pKPRBaEdYyk1vdlUW2DI
         EmUYkUM4T+HIpb/Jga7qAqGspYz5Q7/l+EOg4EJoaTh0YmhmLvM7AubXvS/yqRWJ8sre
         gM+w==
X-Forwarded-Encrypted: i=1; AJvYcCXwz/vVqshftIENuaM/MqFh79AQM0vtrLlNrKTAyXrt+gqYpExV/z2GmDqDXO/Fenk4mDZiz2kgDp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPf/OZ637yQC06CYHaWi9bOzUyGV1z2eR4wqIWN4n5cp/ATHJ4
	/v+6zOEZFe3wpKxzhWFOmy4Pl+BDe2OkwkzqCemZiWe2JTUW1DZCjW8tGBVMLBl35E8=
X-Gm-Gg: ASbGncuqFiaPueRsKS6iYaWSDNyLfydO0D5BjtT166Y+7/CaSi6o81GA4g4pQ4BfmXh
	5ngoVj4O2O/9mUgw/8wQWiceoGD4g9D1d7nKuDoq4lKwnu9WILuQp2ySRN/1x0Ebuv5GH15XWuD
	Uy3M6bqyD02hdTGMiKDXng7a8vd9UIepVhi/0mQ4h9bRNDlqNm55JPtT0dmZNT/bX3wD0vY7azM
	UZs1D/rGrZ7BDs7kx0qC8+qildc514W/jWaJEHD0elDu1jaQfKtgAjNM6xfGwQ4llK8b5lUH3AT
	ZWn+bjYt0XQbiz2fI3SDOLdnwQ9oyOgxEtz35T0tTfY8Xn1bhbAi5VEFH/PRFArIOsfxtzat7O0
	wk0m0fkaq4VtncJ0rrV+oRkZsy9G3Jj4QPNtFDs43IB1iZFqhcXtybdrLuHJEk4SYflR2N0noct
	rRvyXyXpq0wTxs88+L4MrLowzyJkDC4WoGNRbSxjNwAkebHBYxGMVf3YlTkvOTncwBa0Lm5bDp8
	l0=
X-Google-Smtp-Source: AGHT+IHGIc/mViQmt+hc5AeyXZ08MjhMwHck3U3h2A3wORRzNakxWeSZTNqxtHkvmPPqWvRE4AjbfQ==
X-Received: by 2002:a05:6402:34d1:b0:63b:efa7:b0a9 with SMTP id 4fb4d7f45d1cf-64555b97f06mr35378525a12.9.1764688456595;
        Tue, 02 Dec 2025 07:14:16 -0800 (PST)
Received: from localhost (p200300f65f006608c90d1d7fe637464b.dip0.t-ipconnect.de. [2003:f6:5f00:6608:c90d:1d7f:e637:464b])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-647510508d4sm15573273a12.26.2025.12.02.07.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 07:14:16 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/6] PCI/portdrv: Fix potential resource leak
Date: Tue,  2 Dec 2025 16:13:49 +0100
Message-ID:  <e1c68c3b3f1af8427e98ca5e2c79f8bf0ebe2ce4.1764688034.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1764688034.git.u.kleine-koenig@baylibre.com>
References: <cover.1764688034.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1004; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=GM0JrmfiNdfo48tsNKE/oyZWmsSgnTdU7rBVJeWsd5w=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpLwIwu6AXdpku7tfju4z7Snk49VfCNNKfd4KCl tvUhXJSyi2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaS8CMAAKCRCPgPtYfRL+ Tg40B/0ZvNLVsfPSBkUOH0zx4ZwRnfa/Qml1Ruz6unuOx/YD0uTDAWFK+CBdE/Ru+PJX95D/lK5 JlM76F8rBANc7FIx0SGPeDJIkGFwwitTW8ozFx0cZKX2nERfnMr0qmrSbBH00Hs0eHiEu3cwQxE cL1rbZABZuTPecMUl0eIn88qj4N6yk+VzO/+NmFMJUO+S4dRpOBUzhqyoa0GQXY3RiMb8lmS5C1 2LepcTD3Kw6WeVoH4x9Z/kN3vNFLvQ5OUvsBmvGa0yuLoT7aFrwegQNmxJaqTrFBpXqKwsDTVOH xx5V3hw8LgoB2aTR8VruoFqrH9Ezc41dk0HOLsDnXMN5flug
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

pcie_port_probe_service() unconditionally calls get_device() (unless it
fails). So drop that reference also unconditionally as it's fine for a
pcie driver to not have a remove callback.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
This isn't very urgent as I think there is no pcie driver without a
remove callback
---
 drivers/pci/pcie/portdrv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index d1b68c18444f..f13039378908 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -557,10 +557,10 @@ static int pcie_port_remove_service(struct device *dev)
 
 	pciedev = to_pcie_device(dev);
 	driver = to_service_driver(dev->driver);
-	if (driver && driver->remove) {
+	if (driver && driver->remove)
 		driver->remove(pciedev);
-		put_device(dev);
-	}
+
+	put_device(dev);
 	return 0;
 }
 
-- 
2.47.3


