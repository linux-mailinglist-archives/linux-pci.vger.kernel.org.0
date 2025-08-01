Return-Path: <linux-pci+bounces-33291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A87B1828D
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 15:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B090624E03
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 13:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346EA25FA0E;
	Fri,  1 Aug 2025 13:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="COSBTcni"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DD526657B
	for <linux-pci@vger.kernel.org>; Fri,  1 Aug 2025 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754055284; cv=none; b=Ea7tqevOjv4t3Wf1i/cEeU3ato0F3YnlSB+EKkKl7F3ALYO9KRwDw/Dh1cHilvDtgpziZfxh9QQKl4PVY8FlQYMX/lsoI1lmJZSj+FXGyUlhWx8etpklFkFAmfAuHkszG8gFVvCGm8gt/I+/JcECxyX1LV3R8oDOkIipFzYvU4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754055284; c=relaxed/simple;
	bh=MPOvYXHyt1VUDDVRVybn8iaD9dzrXwNCpMsrhQkJ1g4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IlJp7EMhaW4JvN4tDvivtt601dWNOxeAFZE0x593gl51/5CMjz9IltxpPzDw5s8pudawVyLZl6ugLC7CNyzMRJJUjNTg2YABnztaB3uS7o+CJ2QFSX/lB/CFoGIVYCWKLjOYUBmWodKX4Vs+vufabdWOtxexRfdrO/ea1/hO8oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=COSBTcni; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-458aee6e86aso4329605e9.3
        for <linux-pci@vger.kernel.org>; Fri, 01 Aug 2025 06:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754055281; x=1754660081; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JXrCxZaMMaRtHFaNQGeH/9TtujLuny+WCwC4B5wtCMc=;
        b=COSBTcniNu9VVI60cqSqkKlfElyVj0jBO0n9flH0K6iBDw3f0uS9vQzXNAMHMUJSd8
         7YjZTXGg9fRoBsaPSQCSzFATGbH82yMuyfAA8LM1QTZTYTMds3AG1nmUGAjfT9BsBDp1
         KENDwvqsQP5r2FTJeO5VQZgxjYny+5fnZJXutLdncgf9hlo86TosOsPYMx7TqGBC1EP+
         jx9wNp3+2hcq+UnEvX942lVjMUXEY+vfvq/IPF74Axjuo3GH59sqbDmTi8iWd/EfY/YR
         WP2KNQS6zpOK+jXLxRJKXsY8xxM8OuaR3Sl20xfiVnzFfm/5wsnVFbQrXbRpXi2qCcms
         qhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754055281; x=1754660081;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXrCxZaMMaRtHFaNQGeH/9TtujLuny+WCwC4B5wtCMc=;
        b=nhI1dDvgkE1EnWPBJcsxEbu0FBjgw8ZHgDaDpl8H4xwkXR40eilSJKKVeCTzpnNDiU
         iqPIPJgC51SzUzL44OTzwhlq+1PgTDw47YXDIsqriGvivwOjPd2r4fQpPNWgBanNXvSM
         N/bhME08EnQooP+Ydcltj3vTFOMU0UPNALV5iu/qZQBi3ZRpl7AxpqorXGAXpg0inPzq
         v8vBrBbcF5DbhorqrLtr1NS4XxZPdFRFMI2h7ap6R1CUqiHlrk1RjWXtC6o0vNfr5vX6
         6gWaKax1ys+aSu+VcrLbZnu5tUiHZrvl5A7TswY6BMukDf4JaldoxAAO8z7E2DjC9Jnd
         hkaA==
X-Forwarded-Encrypted: i=1; AJvYcCWeMDTQOAhkRCzzxdY/FzZVqfOD0b8fkLnPsLg/KPaswqI9pEezADUJei8wpIPIE1cQZxpIxPNYij8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZGtQneMkLZyoPED2wPjN1yYyMNt6hz/Nqdfmva3jgWDMJ+REQ
	YbR66cLaoS/NZPUxeDaOBJwm6kjTn+NiNp/yQ94F3vtMa3gcei7lr7MxjStnhYX3/Kg=
X-Gm-Gg: ASbGncuVoV7oOAPQyq5BDN14f39qiPJK9/GCit86Ne45AAzW8F4R+W+z8w4d9Nm3lJG
	nn6gYoiN3VjOK39+5B2zdRsMu5kfBCOEYA85GQsRPkvM+Enbwmc0VsiUMBotBVKRUtNGE3pMFzV
	1aYv1Ukj59Is1k3kGVyN+mBUq0Yxr4cmu1KZoRauXuUs2yBnClpm+JcNF1jov4P5DH7JHfTG46B
	bN06q06GbiLsQ/KPshi64kH/BYQ+/qaDcns4ysw7u6KChSVLZi08960JSKWSivHMevWGq9blu+Q
	v8ELHzA2wJ5u6QJ3HJFt0nH0NghU1nbatotyv0f1jf2Xqb2gxeWvl9MQGqnfJMUMMfDAGf4aITt
	3/A0p3KICTMQGYkdeezsPOPATf5iQq5S8a/764xSVmWE=
X-Google-Smtp-Source: AGHT+IEY4PzKF931Cl4hXP2ucH16DnQzD1sduXwZybAumiUjCHWrT+naQgUR/VvPTU7PmaLeiSG4OA==
X-Received: by 2002:a05:600c:4445:b0:456:22f0:d9ca with SMTP id 5b1f17b1804b1-45892bd09b5mr98694275e9.26.1754055280691;
        Fri, 01 Aug 2025 06:34:40 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4589edf5683sm66413925e9.7.2025.08.01.06.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:34:40 -0700 (PDT)
Date: Fri, 1 Aug 2025 16:34:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Toan Le <toan@os.amperecomputing.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] PCI: xgene-msi: Return negative -EINVAL in
 xgene_msi_handler_setup()
Message-ID: <aIzCbVd93ivPinne@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There is a typo so we accidentally return positive EINVAL instead of
negative -EINVAL.  Add the missing '-' character.

Fixes: 6aceb36f17ab ("PCI: xgene-msi: Restructure handler setup/teardown")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pci/controller/pci-xgene-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index 0a37a3f1809c..654639bccd10 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -311,7 +311,7 @@ static int xgene_msi_handler_setup(struct platform_device *pdev)
 		msi_val = xgene_msi_int_read(xgene_msi, i);
 		if (msi_val) {
 			dev_err(&pdev->dev, "Failed to clear spurious IRQ\n");
-			return EINVAL;
+			return -EINVAL;
 		}
 
 		irq = platform_get_irq(pdev, i);
-- 
2.47.2


