Return-Path: <linux-pci+bounces-33292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A91B18290
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 15:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77676625CE5
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 13:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283BE264A65;
	Fri,  1 Aug 2025 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jGIq5nlO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D84263F5F
	for <linux-pci@vger.kernel.org>; Fri,  1 Aug 2025 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754055293; cv=none; b=tpS7CJ2vLNqXrPOlHUIQK8HGR9OsIsz4sG3FnY+zWHqCpnkeBla/8h/6ms818YqLVU5kdZnJMMsoBce5nu3RzUx6jYhmdCad/pZx/q6PlT1X8neVlY7UMVXbjGafLRbtoVVGXhHH8xaqwJNO8qgfTrYRS+CsBsm1b7g7HurL2b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754055293; c=relaxed/simple;
	bh=B6dkp/BBDmEeyjf+/PEcpn9dFT32NaecIIHFog8H+Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bFQenLWfXZXXd0VJ5B/FzuiVqpbf/AROUE3nVQrhS5Yg0NekEm0asWGilmxjgCNf58BrnPykHQfJZC/4D2Dcmv9bOoVT+bsSxK+ei3VecGLGDzljil46LVQQyM5YQ8R55ariaJL2wzBc4bX7lV6dwAjXfHVpqsGEfJ6MJlbjXT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jGIq5nlO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-458a84e2917so11024095e9.1
        for <linux-pci@vger.kernel.org>; Fri, 01 Aug 2025 06:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754055289; x=1754660089; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=91nE9pIukFXGqv89yf8nL8EO399drb1w4wsJvfUDGbI=;
        b=jGIq5nlOTqTHOeTMmdnAdUm4MVBgOjeeSwxDrSwiJuuEnQw0SFXoWxSXZgLZ8YwVOh
         Vtga69wUhbQly/+rJNXs+En0o40ERdPqLOdtIigc96ifZfsbh1Xc/GHquQJyCUGLhMYd
         A/1PQzcw+T4axYTWoFfMyH349K6HcM92jFxqims74R2XzFo31NQ2R3PS/92VT0xgb4om
         TNJMMddMSpVplI+ShJRS2B0c8WDz7ckA6fnppjZWCZX46Dv3a4YIKhN4a8x7H2e2WNfn
         oIU1GE1aRxcHfxbc7xqB1vTM8ndW1lDWkXzjY1aMvj35NWPDeZVI/L1JIKEvVhAtYPh6
         gwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754055289; x=1754660089;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91nE9pIukFXGqv89yf8nL8EO399drb1w4wsJvfUDGbI=;
        b=KDExJ5IX3LB6Q8iZNjwtPZd9vptzubZqF30r++1du7HgQuvCYjucljU+2eEnfV/cCk
         ExAEx2a3L88zdakRYanlc5ZaEwnix/luOQQwP/4CLsMg9XoAk5Bov6z7LUb4zA6BpYA9
         cOIFopSnMxsQEDZi7D1INcsnMy7LuPHhQsJ375EEaDDsjqbepih5/L5S05PVhFgDrTbu
         O5zRee8Pe5QvHYSZ/LC/NSBI4dq9HUYbPXvntSL8tqlftQDt0zmJRtNWTOceEekQr62y
         kP/6RWCPSB7WxapfH0DZPiXYGyLxIyIjw/gahDksujOKYG94eBrPl41Kxysi6bo/UUkv
         AL3w==
X-Forwarded-Encrypted: i=1; AJvYcCXeZntBf4/Cn9U6u3qOSXLYEdSUGqMys5DLh+GWKliNP629iEQ1ib2nGilhAICb0LkBBIEiNJa44fs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8kzsFmyY8dH7UtvZLNxKsL03ceoQYZt29y7Q6djtOCQ2ccHoq
	qjz/rlU2wt1D4BOH9+TuZp6qoyCznFemDvNg10rX8VPstioRTJFqZU4z36/YtnzFq4M=
X-Gm-Gg: ASbGncsD0IlbJGPMMNVbQPXpT8scv9hf16qNbCcUagF6avmoODd3g+91+gtpc7wLiky
	XiR/TLwOiHnrXmS5n3iwiF04j1g5frHFwKE37d3CGF2jChp/xeQ6wlEGDzX19cNqzAkeCapk6zD
	FR/D2x5vIy1yP1p+cy2QluLrEZlBdcrwEAv8u1Syxp7p49gzV8uhisf9kxDBimjFtifne8P8xUp
	5Vj76Jd4letB8fUGNN8wkg+BLWBwlRGQMdmKB8WTRdY+AmGiBdryWvVOdnpynsQvq5sirgsKbMg
	B7XW4n3T5n2tawF/5jZi0KF367Edsb5raVjbf2YdedknPR3QCDuanOPUQzx9OM0aQAH6j5upUqz
	DrRx7UIZwRxmyIcWFWOACKVUnHX7XrXBlItU1wQ==
X-Google-Smtp-Source: AGHT+IGINVe5hDq+30CQhj/n/29dWvuH5Attb1DwC+ibJDto9n7Mzc5Zl/21ZMrbaLLxn/fjg1KzyA==
X-Received: by 2002:a05:600c:1388:b0:456:25e7:bed with SMTP id 5b1f17b1804b1-4589af5ba2fmr100886665e9.14.1754055289518;
        Fri, 01 Aug 2025 06:34:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458b4a6635asm1093675e9.29.2025.08.01.06.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:34:49 -0700 (PDT)
Date: Fri, 1 Aug 2025 16:34:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] PCI: endpoint: pci-ep-msi: Fix NULL vs IS_ERR() check
 in pci_epf_write_msi_msg()
Message-ID: <aIzCdV8jyBeql-Oa@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The pci_epc_get() function returns error pointers.  It never returns NULL.
Update the check to match.

Fixes: 1c3b002c6bf6 ("PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pci/endpoint/pci-ep-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index 9ca89cbfec15..1b58357b905f 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -24,7 +24,7 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	struct pci_epf *epf;
 
 	epc = pci_epc_get(dev_name(msi_desc_to_dev(desc)));
-	if (!epc)
+	if (IS_ERR(epc))
 		return;
 
 	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
-- 
2.47.2


