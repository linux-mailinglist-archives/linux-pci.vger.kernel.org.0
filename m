Return-Path: <linux-pci+bounces-23091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE150A5625A
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 09:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C61F189722C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 08:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71171DC9BA;
	Fri,  7 Mar 2025 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yH7S8w4l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B5A1B86EF
	for <linux-pci@vger.kernel.org>; Fri,  7 Mar 2025 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741335216; cv=none; b=rMBMjDI3Alz7nc4kY3pz/Ju0eX5a/GSqiXQu+w0PlPk5TizymTbuJbgIm2pBIeF0/bs9nJBzF4T+v92aN2Np2vVBmSCTWSSJSTNhCrITxCGChXyyNuDvwQ4PIx1/AFJEf0XxM+BazqZF9Dkp8c97uE217i1iR74jB4KaaFXGDKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741335216; c=relaxed/simple;
	bh=mNNtsgjvr/yg2dDU2qGg1ag4pOBiq+f/ajn9YgzG3AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8NSKeyum0Y/K6Kk6wxldFmc6+JQ0AILBTI7+CqYUkIQ3OmHO8qoKhyLDbtRQQZOwLlOKj5CYp+GxvApMlgu6z2z0f/ap+TP9ZG9N8Jkf0MqXsrVGJoatjo4n9V1g/SmXY2dd7FR5q/9qIZX1yrVcsLDByqeA5Uz4k7FQpupkfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yH7S8w4l; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43bc526c7c8so2041165e9.3
        for <linux-pci@vger.kernel.org>; Fri, 07 Mar 2025 00:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741335213; x=1741940013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12a3NnEfGMI2vuVvciD88yslLap86n9MfZE9qRsezz4=;
        b=yH7S8w4lVDYb0b579FuP93g8k8kinxWIbiqkN1cGT5OKt3+UA6VIJ7uj5Epbch/ygr
         wZhMUWu/PUAU4Rv3xaODXKze1uDqkZ6fpaL/+GtF6xljTw1kgoTiUua4CApSA76qtJC+
         y8UgX6xlFtKdttpjysXvpakyhheOD0r9lwkFz4dWthvXlt4+l8vkmH58sUtWwGOGjLNm
         MoH2xjC3GSKtfYmF8QYeALPE4KCy3WdGtvQhQOBdNEJ+jw6uJjhjtfd2EaUQoPO95Xrf
         NQBDTW6ONl/bPUEsaIxyAKj65Gila15quMGmmCmqZeRcBCbcuiHP4rtW1MunUjv4Pl2/
         sWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741335213; x=1741940013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12a3NnEfGMI2vuVvciD88yslLap86n9MfZE9qRsezz4=;
        b=NT8y79vWSjM0lo7cEwKD0PEo2Q2B1D76cAWGix3MhTDjUK7quilic4HOYgUc2JJd/1
         k68skvyUbpQysmf83Bq1Vh5oreb/kOwGV38DfqQrOPMvlE6GUs5kifKoz9+is7aNZdfC
         QoyeD5yeWnE1aZB4VUcGs+g9PMLhHeXBcw1ihX0r+jpT0r4vmEpOrRFfj1NBJurtk2JV
         KzoO3wS4xZp0MRonGh0hJPCOwFd3i0chdT2JoinxPWvQHUfk2Rhg6Auza1zzGUZ9Sfqj
         zMB9Xf8bBFU1/1/OfYkAYTRAi5JkqKjgys6J5fUh1RuvYpeojN3kZCNECgt9zOnMjpWj
         lgtg==
X-Forwarded-Encrypted: i=1; AJvYcCU3EsRIkjFKHKcxp+0E+cZ8S6q3fG5IlKuXzT4xJ4SGF5CGaazOwsmDKchV8ExAsPXAcbIB/DZWd0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5jXmgMzkrB/dKsCxAVHClO6S3L53Xs+MtHlg1FHq4GF0GgLGI
	9zbcpGECg2OP42k0d8lH8LE1DIpqNg5wodNMJAplcgQgsKDYGXh9VmrDI7sAvsU=
X-Gm-Gg: ASbGncthJdZTW7F0tGgSI6S2zKR1Stc4DriAbjpeub/D4+aceK89HBzHwd1jvJXWgUs
	2IrNwYJYK2WcAXyv0MbKPwfgm/LnXAxge0l9uz/4f2WRLZ2AYUnRR8DsRD0TwR3Fk7ZORyQQTGp
	8eawICtk5sP45PdBoMvkpHXmTa050YGkenSm9TwFoqj2fApnUB94uaxC3h3xwbLQ3/sujC/TdLC
	qOsH7+MpeJ1cln4df82K4THmrF/b7ksDpNvDOxqjx+4Lnfxyg3HnIcguOQqKjzQIjqSDoKD4ez1
	O78/iA0rFmS+smjKCkQjZGWwr+XfXXIzlGG92zkg+rgoQ1Z1K3DL0j5hNaU=
X-Google-Smtp-Source: AGHT+IFQ+WMMvLL1/aaHUI7n7dcR9ePxgtPjRJRbPaHSVEqjJg//u898K3D1y4ZCAvDVaQslPXHcGA==
X-Received: by 2002:a05:600c:35c9:b0:43b:c844:a4ba with SMTP id 5b1f17b1804b1-43cccdd9b0dmr2917685e9.3.1741335213314;
        Fri, 07 Mar 2025 00:13:33 -0800 (PST)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e222dsm4575458f8f.72.2025.03.07.00.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 00:13:32 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: PCI: fsl,layerscape-pcie-ep: Drop unnecessary status from example
Date: Fri,  7 Mar 2025 09:13:27 +0100
Message-ID: <20250307081327.35153-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307081327.35153-1-krzysztof.kozlowski@linaro.org>
References: <20250307081327.35153-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device nodes in the examples are supposed to be enabled, so the schema
will be validated against them.  Keeping them disabled hides potential
errors.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml          | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
index 1fdc899e7292..d78a6d1f7198 100644
--- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
@@ -94,7 +94,6 @@ examples:
         reg-names = "regs", "addr_space";
         interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
         interrupt-names = "pme";
-        status = "disabled";
       };
     };
 ...
-- 
2.43.0


