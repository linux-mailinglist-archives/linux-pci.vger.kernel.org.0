Return-Path: <linux-pci+bounces-31027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB70AECCAA
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 14:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF41B3B3AC4
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 12:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FCE21D3E3;
	Sun, 29 Jun 2025 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJwvcV4q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D0A21FF59;
	Sun, 29 Jun 2025 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751201313; cv=none; b=kempmrL6uy8oITbjebJMuWusE8Zo/+YCJcpOEwb2wIoQOhji8Fb/0Bj6y0byQu51zOGbMu9KlaqaFJ2o/b9h9JP7Msy+uPMhiU/qtIEicvt5hqAIaO3BvuvWY0Z+OMAJ/kiris7IJA90uBL1XB8CY+RyGcSO5R7Mjnl3W+8ZYQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751201313; c=relaxed/simple;
	bh=ZHiuNjkysUslUmsJxg+pQGZzasofUlWvOElEMSh7s+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxdrpqgK8HtLwa4IkRm/n9NnwWpZHNcWzAI4z26wdLD+ieDTUKWR5qHNqreCU7ZJNEypNxj2HyzPkA83TA1jdKMDHRGwHkP3uyPf9hWYVmdNx8+7Khcke+SdoqqpJtMk1pOUP7LouC5cAqO1+dpHqY99HjchA/MsdTSDqttw4jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJwvcV4q; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d3f5796755so346997685a.1;
        Sun, 29 Jun 2025 05:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751201311; x=1751806111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OvjviZOYrIKurfYh7ExfJUlmx0DJYashywHEqMq8QKk=;
        b=OJwvcV4q1yol3NJWPxTgIuLNLBBVTDHbt/u+tSMG03eG6jFIqXpwgpAI4ZciLEd38X
         A2VaBCrkr5DgnRqYOyKEows36CMqNdk3zvvaZo7+Tjsz4aVKrZvl0oX/K3iTjDNLGvSA
         iyo1x3qSD+N4WkkcMbAWmik3HF5dLQtJOta1cxHQwBtV0J1LmJcoKUKzKBUafTRxYOK2
         Pk6Q3OPmuipb3qj/hjYv6gKe+UCSGqh5MA7xd33h4UKEKhziftvAeoPJawnNzOKKybP4
         0fc7USeb8aCcQCaeoPPKfyU10dgZBhE8ut3txWCC5aH4NNzY3jYwsMG55wbhn6xRI52A
         hW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751201311; x=1751806111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvjviZOYrIKurfYh7ExfJUlmx0DJYashywHEqMq8QKk=;
        b=M5saFTzLdWEF1JPaPlDKDrGzY63O7qUK63OAtk0+bSq/e+TO0IuCS2MnhySh1Gl+iP
         9IuobaAPMJDIzPq6HH7weyeRfzZcwUdzjKemo3ZgN3+vlKbMdc+sdqqXAasgo6acPrQD
         OkPGOVuHGF3pq7m7XCpvw/0d7n+zsCs5IiSTaZrMyNRJ85JmUI0YpeCNv/btW+sO2nOx
         wRKzHPxBKcRbiYqDlDCPgpc7McxSbT6ZbazkimLaGq4zbKumdlxeHc6N5lgNtOP3zmFJ
         gb+R+jBLQvTVBJsEBri8hVl/hwa7Eqz37NqULZrCkAXGdrMaGF+23AjWZ/XWAD05AfVG
         787Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/WLpvnAAqvZRL78Ty8U6bteCyk9yDwPCLUD4QPwOpfxFLEC5inxXEdAQY0y8VjYveYf73/4ekob1pi0I=@vger.kernel.org, AJvYcCU0wUENljNv54/URpQ2U+n2+maz0O6fka6uceKwljeFfR+X0IkdJnt929HEC3QRN1X5lXJGS6XcvVmS@vger.kernel.org
X-Gm-Message-State: AOJu0YxsNdfgQQKLJ99+B7/xT65reO3M8prIxJatB/F3e+c6iMJShcCp
	eIOZ8nQOQuGgoFc+cdAIrT9oomtH50bUaAQBVrPWjsh/JFO8ZICZhNXu
X-Gm-Gg: ASbGncutGePa+hZUYd4evTRKqvDSVNPojDILbx8rlLzJ/Svek3w3uZdXlH5Tqngu5Wq
	2FEizjJ663u0nA5LwGwk5FiGWO7mSYwuR1sO3CqSTFAQ5z68+VlkPi96hCGUH6vX076aFMWtKER
	RLos0asTi5zjfKAlSaIOKUoUM16g2gZjIqdaQjD0q858MEOxH6G7rLHZ0pb6dlHn5LqINcFuETx
	XPEBeSiRViSwbHPuT9xkjXzEPwPnsJ7RPbAxslsH/AiB5fcdgcw7CYL77awxB3lhBwph5OMYwAK
	TAaA9aCDtNb2r/fVK39jp8+tyb5jYIyvyOAlsdv17srylPlv9A==
X-Google-Smtp-Source: AGHT+IEL/USEP/o68qM8kpTv7RVt+yvEVYuaMW1bky10qQjPlYApX6JjeupaO/caQhzoh8VdKrp98w==
X-Received: by 2002:a05:620a:2556:b0:7d4:567e:3df3 with SMTP id af79cd13be357-7d4567e4429mr264478785a.46.1751201311114;
        Sun, 29 Jun 2025 05:48:31 -0700 (PDT)
Received: from geday ([2804:7f2:800b:24f4::dead:c001])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d443203134sm435231085a.67.2025.06.29.05.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 05:48:30 -0700 (PDT)
Date: Sun, 29 Jun 2025 09:48:24 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rick wertenbroek <rick.wertenbroek@gmail.com>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/4] phy: rockchip-pcie: Properly disable TEST_WRITE
 strobe signal
Message-ID: <60ad1985a0de0a6b47044ea9c0acefe6ff865aad.1751200382.git.geraldogabriel@gmail.com>
References: <cover.1751200382.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751200382.git.geraldogabriel@gmail.com>

pcie_conf is used to touch TEST_WRITE strobe signal. This signal should
be enabled, a little time waited, and then disabled. Current code clearly
was copy-pasted and never disables the strobe signal. Adjust the define.
While at it, remove PHY_CFG_RD_MASK which has been unused since
64cdc0360811 ("phy: rockchip-pcie: remove unused phy_rd_cfg function").

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-pcie.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index f22ffb41cdc2..4e2dfd01adf2 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -30,9 +30,8 @@
 #define PHY_CFG_ADDR_SHIFT    1
 #define PHY_CFG_DATA_MASK     0xf
 #define PHY_CFG_ADDR_MASK     0x3f
-#define PHY_CFG_RD_MASK       0x3ff
 #define PHY_CFG_WR_ENABLE     1
-#define PHY_CFG_WR_DISABLE    1
+#define PHY_CFG_WR_DISABLE    0
 #define PHY_CFG_WR_SHIFT      0
 #define PHY_CFG_WR_MASK       1
 #define PHY_CFG_PLL_LOCK      0x10
-- 
2.49.0


