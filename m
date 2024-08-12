Return-Path: <linux-pci+bounces-11585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A13F994E651
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 07:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B7D1F223E3
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 05:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E4A14E2EF;
	Mon, 12 Aug 2024 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jnImDly1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB518035
	for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2024 05:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723442249; cv=none; b=XRV6Ry0A3vEeJYTEK2MWHyqs2tAy7vRy1iTL8i9ROAVDy51t0a/GenPGDuD++cVxDnk5qqUbNRlyzkDuUC+d5Mo2aNcxxFYlQgOE77q0m2aAHeI5tMVszLTdOpKkbFit13hRT/ME/O+ZCUI5GADfJ15zXm3fFCau5JV4xfEtiCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723442249; c=relaxed/simple;
	bh=JRTKe/+GPn5F97910E2NrqoeM2xkgWSA6uZKjEF14qw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dzLFeO1GAJ5lZF/t9LLY042LEUANFnJcBnQmt3R1tFCa3nir7rDk0Z20KU2HcSZqBTI8AHT31BOQuyyGijqZLRHrFOLKsbfJIBT1hzVQOeQZNktVpJtP2fgQT6d7mpw8Em0cC//Q9ELoVTVjfbb8Svy1oRm3SNTU2UkhNAc1zVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jnImDly1; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-704466b19c4so2352400a34.0
        for <linux-pci@vger.kernel.org>; Sun, 11 Aug 2024 22:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723442246; x=1724047046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0MWXWXuSpacZv3o44AtzQtJipy2mqJJWT9Z6XrKdPg0=;
        b=jnImDly17Q+OBB4web6518yUwabbxcwh2tq1kL8nnI7jZqGpv3H/iagHWRlQRx4pFj
         hypNhtCLiNczja2FKps3STVB+CFz8KzHWV5kTaSlOPsN24YFY1RyrbfCKgUsbcCJ6lwG
         m8LAFRIJX9g9UecNNltpH1iJgEhS+firsAIbtnVfffI+f+aZru3bTlpvOPBpSAM2rn24
         VcUJvamG6IldXtOtTyX+Lt3og5PlqDnhGcpN1yXPuflXoY0UTGdN+h1jfPk+QStt3zJe
         X2LhPi/wZ/f2qRnAG5XER4q418PhCowyI/1wOb0pi5EMp+TSwoa86yh/FiZr+MQHkXYz
         VyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723442246; x=1724047046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0MWXWXuSpacZv3o44AtzQtJipy2mqJJWT9Z6XrKdPg0=;
        b=ogHHvC9RklfOGUMQi86b6QOiBdy9Pe4uVeDZ8px4InScbcLQuYyRcAxF17M5A+RqXd
         a+xb6oI1CGXlVJmhRlPbKuBafG5P037aBop8SAD/YiDaqrcRrphj/pNMTRC1AVb72pdv
         52adEF9MkUVcrmSvdGx0pHDefbp4KBzEXaNfxJaIEjrDZwIyF+yPZa3OzW0XlOEAqZZ2
         9DSDpWZB1kkFuhCLwbDIEMhZkn1AgtJ2z4+K8Ql4danazw8bLt/llhbONE+4Ahbt9GuA
         nCR22JTdf2hYDagorobod4bp53pZITNqNavBtdRW3Gv4rM4kJuguGIvLRGfyQd+jKpsc
         QC9w==
X-Forwarded-Encrypted: i=1; AJvYcCWY3YH8i4CKFt+6tvkqkVQXIQCnCw0k0JnkrfCdh3ja1+7KIOldjAnBPr+R9TWwqrgQxGfeAPlcfIE97uidqu1GQyQjXb9Q+gpH
X-Gm-Message-State: AOJu0YwhWyAyAI9EibDIZmYh9K7JSbY6IgPGJ2kryhA36YXCbi2WWGNw
	3kRJN54aEM5H0IJ5x8UfS0OtGuLh8sfsE4+bERiJJBX7GO7V2txZ0GIYMojljQ==
X-Google-Smtp-Source: AGHT+IHf/t8INFWtWT3kvCRMB5XYPGEi03o2KU92mgIQHoqs0qXKGXuZFLtVFW5IrvsyhiP2/g0lwA==
X-Received: by 2002:a05:6830:6417:b0:703:6ca6:27 with SMTP id 46e09a7af769-70b74731bfbmr11376167a34.16.1723442245724;
        Sun, 11 Aug 2024 22:57:25 -0700 (PDT)
Received: from localhost.localdomain ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe3cd6bsm3507702a12.56.2024.08.11.22.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 22:57:25 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] MAINTAINERS: Add Manivannan Sadhasivam as Reviewer for PCI native host bridge and endpoint drivers
Date: Mon, 12 Aug 2024 11:27:07 +0530
Message-Id: <20240812055707.6778-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=a
Content-Transfer-Encoding: 8bit

I've been reviewing the native host bridge drivers for some time and would
like to be listed as a Reviewer formally.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde38320..3fb27f41515d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17616,6 +17616,7 @@ F:	drivers/pci/controller/pci-xgene-msi.c
 PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
 M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
 M:	Krzysztof Wilczyński <kw@linux.com>
+R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 R:	Rob Herring <robh@kernel.org>
 L:	linux-pci@vger.kernel.org
 S:	Supported
-- 
2.25.1


