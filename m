Return-Path: <linux-pci+bounces-6280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304DF8A59B2
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 20:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D968F282D7F
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 18:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E1A13AD0A;
	Mon, 15 Apr 2024 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQUZgONU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19F013AA48;
	Mon, 15 Apr 2024 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205278; cv=none; b=S+gytQZ+kGSjylVIOv+y2YHAI21A2sykNQFPNx31AkmovAisOfS5VWSQ4JvjdHvJGuGgSq4IULvkaHQl/Bjeaa+7/N+/AXCKBTj+ikH42w+xvFaf2IHr4iOEs3caY/XMdbgvMGNtZvhfQEOaX2TqfMb5KvZ8Pt6HyCWyFwj8z4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205278; c=relaxed/simple;
	bh=/LW5UP24d3M9gnDJHKsZY3AjzrEnrgPIA21IZxGWV+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MZGswg788GVVeb7juw3QqCoZEU0BnFTx8CRxaifYu3Cg1o5/UsOvrcS0X9u5UtZUVlGawz1JdcyymU0Lz4fSGjONnJjdEctarrkTsyVaPpXmB+O9VDT3tbmF4UC6z6m/IsFcBtIQXOpEVKj0zgSMKxS2/n7sihYM6dggJN9pby0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQUZgONU; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ac61cf3fffso2284092eaf.3;
        Mon, 15 Apr 2024 11:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713205276; x=1713810076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQII4bd5vU3iEBUOJRNxIf3Y2tkmIxs3qzEGZCMfEv8=;
        b=cQUZgONUIZKNDikttc5xQmO0+Gk0A1pWL+tq/nwS3EcTJa2boUAWi6yuOXCnwH0jBY
         B4pO/CiqVnrCPX0cdhFb9AibXPewSvZ4uQJu2XvO9SyXqjWUnBPqNPv/nZbUUgAz98YF
         XIYWgbTAWxRCI6+pr6cXlDNuT2ehukyQfsKMJpKJC8EDKWb3P3cCe9WCmie79dovs0qY
         ejB9REEI/43hdMG7B8pujqUQZPjpUFgKCW3HrYL+GH+SzfC7biRrcGtSgrjfx2R2jRTr
         juru5mDfvUqyUzqqKTwC3hpAnpBeem9JPprKUEiHco8uGKc7ftyJpB78/twqN+lqrxR7
         PJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713205276; x=1713810076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQII4bd5vU3iEBUOJRNxIf3Y2tkmIxs3qzEGZCMfEv8=;
        b=mYeiL8nLVBdp7aza8zKR8W1IOQ05mviQC5H1in8JgOfy5yVsqt3BzxukGBzYixZ4TN
         WWoaw7pYklPW9kDUIBFakCuaSIXlPWrk5uNj5M8dNNfaVAdaNTfWJsTQu+j7QhuBjM8b
         HUqqWfn4vzgcBXjmDFxdr7E+qx4P29oj4ud9ULY2EXg5gah2aReM7L2Ndlvf/35fvZLB
         /75VCQKzSxU8WDCrtlAYiyDfakSD9f9ItH4fQ6Win+ICQtAgO/5shWwwMr8InTAvuoxv
         1X5QmQ46cpP5p/IQvsuQFRLJcaFktMoVB/f2vpg9d+dnAtQSbOmg2DHZr6ZrMp+FmnkH
         py0w==
X-Forwarded-Encrypted: i=1; AJvYcCV0AAQYGXF/IapV2E37Xu5Nqdda/+CUtHorqMZV/j6fjN10pAwHS3bzL5QENxJphwwT0ue2M12AR4ZRf+gKgsOqa/GkdWLr8ewatmbalaTx7Ah5eRTpS8SsZGTz4LS9BN+YhhvhNvKdA9Yej2Ahid7EMm0lYOb9yrRJUgVAmQWtDT8GhAX6iUdVZOr7PIrstzeHSFuu0jsZGyHvrg1FM20BM0RblxCaSo0eqprYdwnVTOvxbSSzpadSumUSags=
X-Gm-Message-State: AOJu0Ywfi6kwHmfsMSOqrWi1eHjHZ2LIetGn810tfF3Pu36IL1eX2OHt
	RUoFiSNinbFcbNGTa8EZDuraSkyW92a+a2SU3tiGxPCcvNNmDZVk
X-Google-Smtp-Source: AGHT+IEeVcvxHNezT/W5g+Igrx1FREJxZQPkhRmeduAzr31PwaRKeMNBmncsMYxNomC3jAJlTvCPaw==
X-Received: by 2002:a05:6820:2715:b0:5aa:3b8a:b491 with SMTP id db21-20020a056820271500b005aa3b8ab491mr9969886oob.4.1713205275860;
        Mon, 15 Apr 2024 11:21:15 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id x4-20020a056820104400b005a4dc7abc01sm2177494oot.11.2024.04.15.11.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 11:21:15 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-clk@vger.kernel.org
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/7] dt-bindings: clock: Add PCIe pipe related clocks for IPQ9574
Date: Mon, 15 Apr 2024 13:20:46 -0500
Message-Id: <20240415182052.374494-2-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240415182052.374494-1-mr.nuke.me@gmail.com>
References: <20240415182052.374494-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add defines for the missing PCIe PIPE clocks.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/dt-bindings/clock/qcom,ipq9574-gcc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
index 08fd3a37acaa..52123c5a09fa 100644
--- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
+++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
@@ -216,4 +216,8 @@
 #define GCC_CRYPTO_AHB_CLK				207
 #define GCC_USB0_PIPE_CLK				208
 #define GCC_USB0_SLEEP_CLK				209
+#define GCC_PCIE0_PIPE_CLK				210
+#define GCC_PCIE1_PIPE_CLK				211
+#define GCC_PCIE2_PIPE_CLK				212
+#define GCC_PCIE3_PIPE_CLK				213
 #endif
-- 
2.40.1


