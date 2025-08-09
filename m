Return-Path: <linux-pci+bounces-33666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B2AB1F4FE
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 16:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D95562AB4
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 14:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B1B29CB32;
	Sat,  9 Aug 2025 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GVsHEoD0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A454E29E10D
	for <linux-pci@vger.kernel.org>; Sat,  9 Aug 2025 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754750694; cv=none; b=gh60pp1X1PaKoFh6ZKZ6LLVwFHfsF1XiimrrP9MnYMbTJCDHnSDwTDnfVXomwcVA1TBoOL3UvHluM7nkQ4v2ILF5tKJHQAhaZv9AW4H07mbSW8NxuJs9TE6GLqPCv1eBBt4inlWw/inrx8DJvICziip6K3Pr2J1RWN2gZCg2q1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754750694; c=relaxed/simple;
	bh=//K7yi03aIfeehIyo3o5++11x5/89R6GKKbqCb302vE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eajjkVwMf4fwXw8i4PCiYShYhbluHtdIPKjTb2XaRlI2lVrCxoGBYgkUyxjvuFZI7T9ZYQ0Ht6536w3x4PglkqFnJOw/fF3hatN3jG4toglCKxQQHrJTvD2KBt56wLJr+nikIgvOgsRlpDQdXJ0YXRV2+Nul8yJir+B7ZFNeomI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GVsHEoD0; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b783d851e6so2669480f8f.0
        for <linux-pci@vger.kernel.org>; Sat, 09 Aug 2025 07:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754750691; x=1755355491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=62tWEcOig/dfSmII8+B6nS0fppI/7HUrUbyrKzGRZQQ=;
        b=GVsHEoD0eJ7Av15RYbiCF/4IaKH8vxee1OPlxxBLx4aMpfPi6673S928/Yb4MQJaev
         a/0xiqrJCqlXcJASYbVic8u2bvLJk7Hv7abJ/txFfK19I6Yre/KIZbIRd2vzRxZY6UsU
         l9cArTYjlq4Rz4FqM1T//27ThUf/hTVZA+1l+GbMOFyhVMiQ4FQYDZt4KVPgMaUX626H
         j5rRYFVh0BmEulqw07qpugzDeSVh2mhwoIZt7CSTwEb6hFEiH7jlNc6kVXSzqzq31tei
         8uT8WsNPKyPBiFNe1B1LAaLQQRXab67tHORPiczCqV2rXlp4VERj2YIADHq4pgDNWepd
         SFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754750691; x=1755355491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62tWEcOig/dfSmII8+B6nS0fppI/7HUrUbyrKzGRZQQ=;
        b=Q/69so5h2x3NFHHYTH0vJXwqpWP2/c+BAFooQl2V+bdwl91dgsVy3y5EPIyMdsw0wy
         gksnmxGNbZxmywmmRoThY6Sp9uVOdZjKBSL6MYkzqin5VDxbNYWr299cX6zUeaCxZEGW
         yrJLiVniyKnHmdGUOvE5bi7vYy9R2zB3uKMBmSuMHZTxT5V+PgL38U8L9eG6FSxEzj6s
         aaHf12smN5vZZh5Ji8Dy8IrBCnvHPSpYAx+fIaSNRceXzdH+xDR33asMznynb/x5VMaL
         /SiKpeBGBQHVqBlHIdd6owcejDAlCm7C8Ng8ERH7zd1KUH2kXTDyRo5uVRpTXgzOuSA0
         jCew==
X-Forwarded-Encrypted: i=1; AJvYcCXwnxEG5QhI5ITpVS85k1wNMWuFy3w1nL7086ruCSRYSV1LWy0bcXRt1rF6rcKeqPxbqOi9sPmo4Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZe2NT7PdLK3MI7k5et/mtI3x5o/u9LUE45LtdOUVhRl+WFs9p
	6EpMMb0PzRdv9+gUKzm1l7siUZx6ORdf1RQuHvSVlIc05P9KUtQWJJ2yDbPSzBATxJY=
X-Gm-Gg: ASbGncv/CPyOkvSwxHDKZlM2+n97WgRINhfRgfuZscNL995PxrGKVxeAk5u/ggklofj
	KoEBMNgIbAPG2+xRjEpt1N8Z9SgcCPHPt4QWm+BVD8jkhJmTMYGjbZgEfPzvpQ7QXOwIPhHLh4q
	RNCT6jfZWkSD1TsK6dQCaJwHfnoJxzH6mPnNjx7f18pcrpftDyH14Zn11j+DEruue+nJGhk8KNN
	SWNavPZboT1uWE3k5KRmJ0nkcVfEb3H0aoI7ayLKsb+dupVy+VN33apBhqVciMVW4e9gcnPLQOd
	lmo3zcnuss/nzdzQwk7td2xrDDveYT5gq8GcLza+0MO0qP5qq2IklkUIyKK1LZwFYJDgpOey++K
	xBPmlNnPKB4fzb43r4OdEJgeT/OdII5woYVl9NiwDJpaT1ZwAxT3h
X-Google-Smtp-Source: AGHT+IF+KfnqXJwt6SMkli7edNPF5N9xOPj99QcqBfM5xO8yk0mX48AaSZy6q2XkBgGjZ3eq5eqZsQ==
X-Received: by 2002:a05:6000:2302:b0:3b7:9c35:bb7 with SMTP id ffacd0b85a97d-3b900b7bd51mr5308863f8f.46.1754750690938;
        Sat, 09 Aug 2025 07:44:50 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453333sm35314164f8f.45.2025.08.09.07.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 07:44:50 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: marek.vasut+renesas@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	namcao@linutronix.de,
	tglx@linutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] PCI: rcar-host: Use proper IRQ domain
Date: Sat,  9 Aug 2025 17:44:47 +0300
Message-ID: <20250809144447.3939284-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Starting with commit dd26c1a23fd5 ("PCI: rcar-host: Switch to
msi_create_parent_irq_domain()"), the MSI parent IRQ domain is NULL because
the object of type struct irq_domain_info passed to:

msi_create_parent_irq_domain() ->
  irq_domain_instantiate()() ->
    __irq_domain_instantiate()

has no reference to the parent IRQ domain. Using msi->domain->parent as an
argument for generic_handle_domain_irq() leads to a "Unable to handle
kernel NULL pointer dereference at virtual address" error.

This error was identified while switching the upcoming RZ/G3S PCIe host
controller driver to msi_create_parent_irq_domain() (which was using a
similar pattern to handle MSIs (see link section)), but it was not tested
on hardware using the pcie-rcar-host controller driver due to lack of
hardware.

Link: https://lore.kernel.org/all/20250704161410.3931884-6-claudiu.beznea.uj@bp.renesas.com/
Fixes: dd26c1a23fd5 ("PCI: rcar-host: Switch to msi_create_parent_irq_domain()")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rcar-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index fe288fd770c4..4780e0109e58 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -584,7 +584,7 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 		unsigned int index = find_first_bit(&reg, 32);
 		int ret;
 
-		ret = generic_handle_domain_irq(msi->domain->parent, index);
+		ret = generic_handle_domain_irq(msi->domain, index);
 		if (ret) {
 			/* Unknown MSI, just clear it */
 			dev_dbg(dev, "unexpected MSI\n");
-- 
2.43.0


