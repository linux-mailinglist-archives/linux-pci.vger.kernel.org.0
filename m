Return-Path: <linux-pci+bounces-11804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A5B95664A
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 11:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A24F1F2061B
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 09:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FCB15E5BE;
	Mon, 19 Aug 2024 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf1iJ9yz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C15215D5CA;
	Mon, 19 Aug 2024 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058278; cv=none; b=X6/A3vvO2IkOPseqbUqLlLxEZLzN6Ga6BAoS6ei2MVBfjtsvzcNBT4stGcN+/pL/C4HOo0WV8n5dVNDLMNQWFnsFy7lJLmRXeT0xNdGKM/RNzbahxNgC/BVKoFPdYZkbuO7fnKDkwGORBCBtyQzEEbcJq+h53u1pHU6fR9aSZkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058278; c=relaxed/simple;
	bh=EGcprhy5mZbPF9sfa+PupUNrxqcOBkimo2HGnH8hWpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l40PsDvKgrL3PWoTaOUlTZVGtKsDActwIzfEw3ZUpJjFxSnZdnUX1gbRqeKeVb+54a+LuJ7HD/YVzeptlxWsUXJBAxlwyppc/r5awIf+/XJlOXS+i8WMJ42Q9Aic8VZloGPZAKGGaX74f1tqjuYo6LcHlYN06X8pH0ZlqDanJp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uf1iJ9yz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so32334115e9.2;
        Mon, 19 Aug 2024 02:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724058275; x=1724663075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73KaV9INZpxIDOJ2Xw69bHLb9GRPh7H+PU9DOGB19/g=;
        b=Uf1iJ9yz1KMza50hmbufWnrUDiXiVhztN/uff7dUVONejvtkjWgqNm7WG/ED+mS4zH
         BRdX7muNnyaTEJ2uzhEKVVEUNPGJPVXiBaaOzBwCJ4VezAycPgysoFzkHfiEHpnr461o
         5lBHoGDdtWk+co6boiMEP4qCJ/4zLAEyhRUze4u+C/XIbcM/Olh8m+mxzpABoTxLAIOp
         tX92XrCuaKP4v5RWlucg5uvJB9LIxik6YsyPdyCQZECa2DMGnshmF6PW7px6b4bi+deP
         UoUotRBdrQjS5yth7H/IET/Ljb4hMVd5iUif4NYEU7y3+RbpuDXIZ304yEmvIhjncM+y
         id4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724058275; x=1724663075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73KaV9INZpxIDOJ2Xw69bHLb9GRPh7H+PU9DOGB19/g=;
        b=gho3mBlah5JVyV0tXmlq49gHSzCCIvmVcgOC+BmhO5mXvMCyGgXb/Gik1XQWpYhj8I
         VmaAPM4VY10VstjyFH0Tgqq0Rx2N+jV9w1RJfukleRpZMh3eAj9jOngeVkxIS5VPAYxq
         +ha7iHKFKiMFqkOI4IzxjNVPAepbIc8nBTNMyom4C3tmQo0s9kre5OYPUVqrtDGqcCn6
         4t0qWCo1UGiS5hrnHhz8lBusrSvhbAZOoMPguj5A7aR1vIEvM8YSKEmyHdl22fIQNR5E
         rYwQYRncUqVetOSmAapJTai8BVWJQGOJRT0AWE3QOwMcJAKZT50Gdfr22wBKJkJfiV/J
         RP1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmr6/v1jQm7GD3pqRHv721aBKlpY+ApgZPIjwXEhvkBg0nuFTNetfpF/NBKD4BCE1SHgcfv3gjORVhb7z3n+If1dCx4e66N4zzPckr
X-Gm-Message-State: AOJu0Yz4JzYkLvC/SDTkTyq+nP/1j+KEbVwOwV2rtWTrRMfkaQ64WoD9
	ERHUc5u1TmuZhNgvaWlyqnwF5EyRt8Bjl6GicXfacofbeu9V4rPp
X-Google-Smtp-Source: AGHT+IFj0i36M1XtioC1FP1u9W1VBkISL7S6BIM5YHh9arQA28kGUfNyxyAdUgfl+WXFeQvQpsZc6A==
X-Received: by 2002:adf:e78b:0:b0:371:885f:73a with SMTP id ffacd0b85a97d-37194695bf8mr6200443f8f.58.1724058275150;
        Mon, 19 Aug 2024 02:04:35 -0700 (PDT)
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:a64c:8731:e4fb:38f1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded19627sm154672095e9.5.2024.08.19.02.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 02:04:34 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	francesco.dolcini@toradex.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v1 2/3] PCI: imx6: move the wait for clock stabilization to enable ref clk
Date: Mon, 19 Aug 2024 11:03:18 +0200
Message-ID: <20240819090428.17349-3-eichest@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819090428.17349-1-eichest@gmail.com>
References: <20240819090428.17349-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

After enabling the ref clock, we should wait for the clock to stabilize.
To eliminate the need for code duplication in the future, move the
usleep to the enable_ref_clk function.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index fda704d82431f..f17561791e35a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -632,6 +632,9 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 		break;
 	}
 
+	/* allow the clocks to stabilize */
+	usleep_range(200, 500);
+
 	return ret;
 }
 
@@ -672,8 +675,6 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
 		goto err_ref_clk;
 	}
 
-	/* allow the clocks to stabilize */
-	usleep_range(200, 500);
 	return 0;
 
 err_ref_clk:
-- 
2.43.0


