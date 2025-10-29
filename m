Return-Path: <linux-pci+bounces-39649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7E2C1B61D
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 15:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A2E58415C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 13:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6E134888D;
	Wed, 29 Oct 2025 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="a0JFJJ9n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED72234679C
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745050; cv=none; b=PMYvQ6YCuUp9aBHRa7XjriQPo2DlFd8VBNfTvBUc5cuAiSGoQvfWehZ1UwEluWOe4EDfXXi6zjy7dfkWj2XlJCpPJW/y74VkvmvMSMlaqXm6nUUX3h6Oy2uAwz3OmhYOMViteqFcgB8DEAzKQ2CFhrZs2KNYPuNrX+7obd30oKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745050; c=relaxed/simple;
	bh=GZ10kK+pYLUSiMaANpNaBmHbt+19wn5/MQvWC5jgaQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qyi7c7EIuz4CEr57ckmd4zS3+laBVPLlZ9wQa3fC3AzyK+UnGyjN8bFqY0PwHFBxKdkbVtlolQ7UBRzn+t6fB8T+Znav+ck6e2C5k36PHCqcl0TdTFMAiRYcs9+jamX8sJlpZFPos3gQ4gciAh+SyS89531bfCmkayb6VIuxe8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=a0JFJJ9n; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-475dae5d473so45223245e9.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 06:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761745046; x=1762349846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=US6TL4WKOMJYPiF+qfjdrtMs7INfn6qweemcxJelWcY=;
        b=a0JFJJ9nJIw5ExDu00WgC5AVmKvQoezQe5B5Tj/XTdMsCpN2bkIpayke9NZCMmLoWJ
         LM0E0BY/nyUcoiN6nniVYJjPtiFypCYZtnkmKbpJ7rPOEZPxI2ASOsMCsU8nycyQZNpO
         g5GQC5/Vw+eRI78sYt2pQ1Hpry7yeBljNcsIi1UcJD6fTFV7eFH53XDlFm0PgQIxUW/j
         U8Bg8dLBEcZVgFLqHlyt+qeLjFJr4FjljmSS2hw4dRY2H9cxd8lRXJIhPkAObqMYefuv
         gVNG2ptY7QxmuS3u0Lv12/vNMs4W60jE5qjkF9NF2wwJra6QltjtfWh+jRlF4a/RMnKU
         JZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761745046; x=1762349846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=US6TL4WKOMJYPiF+qfjdrtMs7INfn6qweemcxJelWcY=;
        b=YACFcQY71n2KTHHwyK/fdoIeUOpXj9Q4mSavr0yQXdmcM+ry8RI62wDLqp5y604uUO
         1+Z/mV0+th6wxGWzitVKwL59o7xGSlL3EGp2GQhQESOfvMc7iuN0qTzZg5H36ln5UM5K
         yejalT8HYfV0vo0rOyCLIVEqAfa5nPuXO13H1pRiZ5rKH7bTFQYalqF/x+p2YauZ5ls2
         30raupLZHqgorlxPOGOeHGHkhbyNroLfKR6JDJDLSKDziBFOXyBjNDk7yjZN9Z0jGdQz
         uqY6IXkrKG4TVrQlqAGqZlSkrvjeXU/7l7cpo7OSdK6+fLYg/tvELejF/NOP547lo3BT
         hK5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVomezAmHB9m5y6zdc9cKsPVYaU+hO51b3XzYD+qJJhMdP/4wO7EyijJPlCzXDrdUaDioMFPL9/XpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDp+HzI0T/45BtxBkmIBAuhMXBCgtN0v6JJzgpoFi9dhPkUHpm
	vpwLMUUUkzSt/pR3dhOWnKk2ImmhDyTWd0lu7aQJMOM8OXx1/Dg6Sxv7b5i1HAuAbMk=
X-Gm-Gg: ASbGncu+vDZ2KnUgcyodMDsiYY8umFnC3Y/otexRjGf0deoX2sbqOr2f7FyRFC9Wczx
	tJ6c2KS+cwKqRXA/in/z/mccPoFIYVyjgv54fcBsg051MQWEIoeG78I1cycZtmRiJQD+7qti8iH
	wm36Cte0FGjYncp+mEv0Y2/PD4bHR45HBVY5EXqmYu/MzxXYJqGu3LRW17iAuczkIjMaq0Wdz4S
	1xnFHT92APXm77lX1lz+kOrUJLk6u/r/pnjiB5NsYLAn4BU03SzQ5p2lkzopMNax8bDZJgc/V4F
	Y8T6v5Jhi2MChHCUuQi1tmhrSgNB6uObVZM0ZgCCJ8IO7kJ9KZtdbmgAz9CdvhPdoD2QheTSQQ9
	zEj4opyP5U3QM/qALMUpqdXUydklbpr7IjXdWsLR2+piTPLREUoqb3EYd4qWadaG9L9AP503wCd
	H52kylRBFeWjIwkhPmjhCSzYpLpX11DYpaDYR066eYQxCSKc1815eSmsjiWjbH
X-Google-Smtp-Source: AGHT+IEtPz0Owa/uEAi7Mu4+EoNUOeaQ///6DG4yCtEM4dUCCiUVnDE6W6H21Mp9cuh5kJvNRIk1EQ==
X-Received: by 2002:a05:600c:4e56:b0:475:dd59:d8da with SMTP id 5b1f17b1804b1-4771e3ccf23mr25357735e9.40.1761745046169;
        Wed, 29 Oct 2025 06:37:26 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6302:7900:aafe:5712:6974:4a42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e22280fsm49774795e9.14.2025.10.29.06.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:37:25 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v6 4/6] arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock
Date: Wed, 29 Oct 2025 15:36:51 +0200
Message-ID: <20251029133653.2437024-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029133653.2437024-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251029133653.2437024-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Versa3 clock generator available on RZ/G3S SMARC Module provides the
reference clock for SoC PCIe interface. Update the device tree to reflect
this connection.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- collected tags

Changes in v5:
- this patch is the result of dropping the updates to dma-ranges for
  secure area and keeping only the remaining bits

 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 6f25ab617982..982f17aafbc5 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -168,6 +168,11 @@ a0 80 30 30 9c
 	};
 };
 
+&pcie_port0 {
+	clocks = <&versa3 5>;
+	clock-names = "ref";
+};
+
 #if SW_CONFIG2 == SW_ON
 /* SD0 slot */
 &sdhi0 {
-- 
2.43.0


