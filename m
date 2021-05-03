Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F01371FF2
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 20:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhECSxh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 14:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhECSxg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 May 2021 14:53:36 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B55C06138B
        for <linux-pci@vger.kernel.org>; Mon,  3 May 2021 11:52:43 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so4093984wmi.5
        for <linux-pci@vger.kernel.org>; Mon, 03 May 2021 11:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=82HDXXG46Pyy1GhCwdYUJ5WCmL9ABh3Q4FDg8vtMbgU=;
        b=P2kULaZjG8+ReQlLuLNzUohHBVbqvoYQUTHmhAZ2ZJbUdaoheXKqMpy+plTvx0edQL
         Wum4dgUq/ymQNvXoCdZ9T3GuDDpr0DQRrz7NTVC+nXxqHvLqz7RQF08rn8FiQyEXH0kb
         edmn9JKZFVyKSqDts/cTWf5iq/2HDnsRIqhDtchEsYnnEH6Hex6H5e443OWd5/4c6Dlu
         dzlD/z7y4OfZQ+X3DIUCZ+GPQcQey2I07PejXmf8fNFPiIyk1sL3xAxiysU+bq662LO6
         xJ2g3SOXJDdV6OmEhYxgvgBOHLFXt1tcokVYW3qI2lK6BTOk0sMbLBxIrasJfDuDu+1J
         /qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=82HDXXG46Pyy1GhCwdYUJ5WCmL9ABh3Q4FDg8vtMbgU=;
        b=XgDvM3Gapyb7El42N7DXxceKOOfxPWrRjdvdHCc3IAVTEZb0bVsVcD3Bm4wjafZnx4
         mGIeCi2qvSoodVlzcwRFTJGpNzP87QRaDfLp5eK1xuzR4BD/sAmBABCgSVIFzgLHpTMD
         ghy4JSaCGC0ee+mpi5UP2WCXrzGm+/7JUu/Qh7KNc44RgGO63cglUJpg2WS3Q/dJR1N9
         k/shqOuFvdY4hAjV3lZoHhwQK6PBf0tSC0hZEOsifxRBEu9QSOZ6ehCrbkfQuo4MChLb
         UGvzrqVUn2U4/k6K1F3x5y4HuEdaE/pt9YEPhrjp9gqkOPsoMTMXHtj2TX1tlu4+FCqi
         NVGA==
X-Gm-Message-State: AOAM531gBY0rJe6YF/yrj131J51757esBlVbR9/4K+oqFk5BwwT6PfX/
        HmJX8zfSK9mZFt0UiRtiriQp6A==
X-Google-Smtp-Source: ABdhPJx+/FD+vQb71g+hkJ2DiRJnMCIxM5J6rNPMIeuaRRwtKuOzARhkNPbNrzczU+8vkNPFkAR5SQ==
X-Received: by 2002:a1c:3:: with SMTP id 3mr9895wma.32.1620067961929;
        Mon, 03 May 2021 11:52:41 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i14sm711228wmq.1.2021.05.03.11.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 11:52:41 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     bhelgaas@google.com, linus.walleij@linaro.org, robh+dt@kernel.org,
        ulli.kroll@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 2/2] ARM: dts: gemini: add device_type on pci
Date:   Mon,  3 May 2021 18:52:28 +0000
Message-Id: <20210503185228.1518131-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503185228.1518131-1-clabbe@baylibre.com>
References: <20210503185228.1518131-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixes DT warning on pci node by adding the missing device_type.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/gemini.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index 1833b6590d76..31db0be7ec67 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -287,6 +287,7 @@ pci@50000000 {
 			clock-names = "PCLK", "PCICLK";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pci_default_pins>;
+			device_type = "pci";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
-- 
2.26.3

