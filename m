Return-Path: <linux-pci+bounces-2430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F065D836B92
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 17:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221011C2531D
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 16:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06DA59B44;
	Mon, 22 Jan 2024 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/yBbLD2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A63A405D5
	for <linux-pci@vger.kernel.org>; Mon, 22 Jan 2024 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936877; cv=none; b=C5een2qV/jN4v2yDtos1I3fKiXL/GFwZP8EHhSZMM2hG5+xfrS6/VxMUbD1zEi/Bex+En/WCEZNObK2samoo6LKTdlkFR4uVisFJNqrxl7SEBmtNzdroiHShigpPOmXTYN8IzWfdU+Zp423HFDDmTGlckj1KAyKTUjSBkEWHc1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936877; c=relaxed/simple;
	bh=fUfuTS1ONtt1Sc+QMJaOn6OAPkhCtiu6J0M8A7SoJa8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=E7DAb5IIwtZStBw6pwqLAjmeUONHHv6eSmHrZ/8mdnnSpMmVKimADOc2dJnvFVA5G0teJ6pG+AuM5d2HBU2kHe/PjR2PM8gWJI00P7QoQ42LmtEkY4TfQFAnyFxnq3ku7i4pWw8U2F88WFPplLlHOBM8pRGFpMVmlkF6NkbQGXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D/yBbLD2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40eb2f392f0so6115e9.1
        for <linux-pci@vger.kernel.org>; Mon, 22 Jan 2024 07:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705936873; x=1706541673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3NSmP683nHsYZ+QYwFDjWG0Am9VIQRDzOaWrn4+k4gg=;
        b=D/yBbLD2Z9NmmMarOc0g3Zy4wqpJ7mmfYz+3x6zxlNkNMqU4w/Qf3lfBsQh0cbDSpD
         jFCtpNcZFf4yke329Grdm36+MJ9R7xTJ54V8fjPInO4xmgCln5+DRvyw2h/SnpqGOl1H
         PH5HeLlB5Ofl/8dTQSgbzIbko5kiF0B/Pd1m7tN+PMX2U9eVLrsbB+6dvZ6yqQZWxuCu
         MF+QTu/jcKUojmGVsCTMh2vBRwQQexgg8obr8Ys4kni+ggRa1dG4/CzAaMewQf/DME29
         6+zodjrYx5izdXrGgwbA66xkStFN3cmzisE/dSCcu/QPflXYaC57PH7Xx7L/c6UoEJm4
         B5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705936873; x=1706541673;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NSmP683nHsYZ+QYwFDjWG0Am9VIQRDzOaWrn4+k4gg=;
        b=UCEyIdP/jeOmiUFJ2ylqFBgo3/QXKVcoDOZmd9aS7J9h2wZY2LAFnYioYHZDU68vD3
         JR5oPXHN2A9IVgtfK/fy/SGkAZvI3SwHewWa8JqvjwSp8BTO2tCU9OrvuRwprMPSWeOv
         P9baJP7vFZGfjj4WFMzb6o8XzGk3gQMfHB0yIfOD2si9jS97bRqgpvVbxfGP3SIdoiuP
         kUErCkmr0b+2MCfj37cwvWPvwoZG95n9G9SaTsgQ3hogqkmv6pckWeoVkLyvuGCLknal
         NHWn0oxZV2X89t2Q+yiZKelMQ68gtkYohYK6keogmQRsKqF0JNvnJmCebL4fr7h0qrD9
         fJ9Q==
X-Gm-Message-State: AOJu0Yx4A4wYv/KtFwAfGDyQwFLYFL7aBu8v59eLRjRVmFeJh/fxyk1a
	4ON6prOpHpFkQQGArVzBLGLBJaIQZXV99+6pf5N7CAW7QPRl5WZBIPN6ghF50dI=
X-Google-Smtp-Source: AGHT+IEW7U1TIKg1LwteChy4/AJ3H9LLFV7lw3z54lPa8/SxA8IUIP/Cz3kDcBRnGzAbhGpHLENTEQ==
X-Received: by 2002:a05:600c:3847:b0:40e:553c:dace with SMTP id s7-20020a05600c384700b0040e553cdacemr2272796wmr.92.1705936873221;
        Mon, 22 Jan 2024 07:21:13 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id jb13-20020a05600c54ed00b0040e418494absm38542327wmb.46.2024.01.22.07.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 07:21:13 -0800 (PST)
Date: Mon, 22 Jan 2024 18:21:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v3 2/2] PCI: dwc: Cleanup in dw_pcie_ep_raise_msi_irq()
Message-ID: <c5499db2-2c25-4765-b9e0-1fa26da1cc45@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0d5b689-9437-43cd-8c1f-daa72aeafb2e@moroto.mountain>
X-Mailer: git-send-email haha only kidding

I recently changed the code in dw_pcie_ep_raise_msix_irq() to use
ALIGN_DOWN(). The code in dw_pcie_ep_raise_msi_irq() is similar so
update it to match as well.  (No effect on runtime, just a cleanup).

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: Add this patch
v3: Use ALIGN_DOWN() as a style improvement

 drivers/pci/controller/dwc/pcie-designware-ep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 51679c6702cf..1c8d2e938851 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -483,8 +483,8 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 		msg_data = dw_pcie_ep_readw_dbi(ep, func_no, reg);
 	}
 	aligned_offset = msg_addr_lower & (epc->mem->window.page_size - 1);
-	msg_addr = ((u64)msg_addr_upper) << 32 |
-			(msg_addr_lower & ~aligned_offset);
+	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
+	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
 	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
 				  epc->mem->window.page_size);
 	if (ret)
-- 
2.43.0


