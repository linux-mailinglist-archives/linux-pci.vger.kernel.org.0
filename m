Return-Path: <linux-pci+bounces-22978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A28ACA50310
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 16:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5044B3A78B5
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 15:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B693424EF99;
	Wed,  5 Mar 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4XQwnFr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D4A24EF66
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186815; cv=none; b=nCKIW/rWI3+yacGjLsQiLp3qX74c/m+qps8LJMzBBI1FJXBvn3bsud+W0Ogb7yQU2bWeGdt95OvIAr0bmg74pLFajgnPJSht3ugKLOCuEiFl0Ft1mq59BdRBmnd9hc8kWshx6rY1lBGe3Nz0aAkRq5bb5thllryOPGeJBzW0wAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186815; c=relaxed/simple;
	bh=Q8DJ8fiTmNjeP/+2ks1wRurrJfcRDgtOToR7IsclVLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NhSgjzEWQg8TPFijoYFTeXiENHGtmoE7xyYOpIhApYrIY6jsyoLeVfjyjUzLFNcJcwZJrDF8NRgrhbN9a1WIQyO8s5B+AQS2IpGsVzQ+zo/wCc+AsjVcjX2y6mvIhZvvpQTsl1X3NF7s7/oHAIbBh97iK9owsKlaEKcEitG+jUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z4XQwnFr; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-390e6ac844fso6159434f8f.3
        for <linux-pci@vger.kernel.org>; Wed, 05 Mar 2025 07:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741186811; x=1741791611; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bXn+R30pfqAeO+ripC6gzbXJrYwc26V6TE4Knds++Rc=;
        b=Z4XQwnFrXlxKwgfpMtsWoubHNjl00O57875c1XTaww2fGik1DcTZoywAX7je1NLgAC
         WOPcwwKvMA6AVMesw7kZqb7SGR2mzfkQqaWRaVEVCpsWwrkJgUvcWqydEqOIDP4HsRKK
         0wDVjHjlqxtADqXOWjLWRAcfiPnPQ3q6be/iGqNvN2tbM3TzFAwGYNWkKZi0qnV0UYVl
         sixFDr6cYoh8c4D9XvyMALvvml/Z5Uy5t1PvsFqxbRDUbQbUmeaXbXODTOFDmhzeedgh
         kxSgBvzMWDQ5BAv3zFOI1GLUQkaiVE8kilaP6nIr7CcZwtjZ08Ayi0HfaJYumXmcrRmU
         2Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186811; x=1741791611;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bXn+R30pfqAeO+ripC6gzbXJrYwc26V6TE4Knds++Rc=;
        b=Ol8QgCuWoEiUPuo8mb8m5J65TWWWinhDorV8edopZOxtdgpb2xaoM5KAfe9DZAz4KF
         mbrqLug2Yow3EVt2h55EaURxke+OnbD9EgnJfjUPwUCrxZ8rVqnQvciemUxbNwEuNdUd
         yiIpWPzyVLueHWNGCzZSn2V4i6F97ZyQpjUuaXnXgkpvbfM8kQTQAhLFypuSM5CbY6EO
         3M7Bt+N2acn4zBdZKeKPFoIab40aiOkVEbGegTrkickfEaNbjc0bnaBnLi2f1GSbTCND
         yy7WYQhBL2Qa5ZtR6DXaStDoFxTlKDKy6BxQh1D/DGaz/nB1CJf0VTlWxvUaqLi6VJEG
         k2hg==
X-Forwarded-Encrypted: i=1; AJvYcCXCVtsAmjM1wi+QmRIcpHevejkkoLewXAUBuQWwgoAIXmQHv4c9GrcS/aDCbatJBbCIOwZ7qZwrrHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG5j8HzQERNMq5+JBwha2MYH8x8cY9DQFSisQ+SRpJetZIcQZp
	Cwl+hC2hqoLn0N3ltAlwhpoFIdO7pzd74yxDNxC2TuFVghm54BhmPad2IVXhgPw=
X-Gm-Gg: ASbGncvRUpu2WiXd1ZK8DgtlPKjHWX4o17ttpSNs8S0jV1eXByyxTe2CDNCf4WFOdBA
	0FdJTC90jLm23CAwdMPBY/mAvpSKmF4blQrzEUZvS9BejWNSmu9lOfCQuYCgA5fgTJiyVvEabX7
	1B/zyf8rtVT1Sy2ij1Z06bWa+xY5s6+S4DRoG9VVrSsvamGetbvNVzAuwxCqEnjWXHwhued8mYw
	L6YLD1B7sKlQBqMeqI47pmHezZEsBzCLV6KnfSJUYDpEnihjWVaqm0mdQypvj8JQIYxclU3gxGd
	DD4Lff27b3hwKhGpUqajzWevqChb6QFMS0lGYcAk1slpD4kxYA==
X-Google-Smtp-Source: AGHT+IHwAOMpL/YkvcIgyvX6we6SxWByrXnH2O7kDqMIwc9Mimc1XxnvaS/gUDf6T/jHttMfPf7cPQ==
X-Received: by 2002:a5d:59a5:0:b0:390:ea4b:ea9 with SMTP id ffacd0b85a97d-3911f7b7459mr3110045f8f.39.1741186810870;
        Wed, 05 Mar 2025 07:00:10 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e47b6cd8sm20988561f8f.44.2025.03.05.07.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:00:10 -0800 (PST)
Date: Wed, 5 Mar 2025 18:00:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Vidya Sagar <vidyas@nvidia.com>, Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] PCI: dwc: ep: Return -ENOMEM for allocation failures
Message-ID: <36dcb6fc-f292-4dd5-bd45-a8c6f9dc3df7@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If the bitmap allocations fail then dw_pcie_ep_init_registers() currently
returns success.  Return -ENOMEM instead.

Fixes: 869bc5253406 ("PCI: dwc: ep: Fix DBI access failure for drivers requiring refclk from host")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 20f2436c7091..1b873d486b2d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -908,6 +908,7 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 	if (ret)
 		return ret;
 
+	ret = -ENOMEM;
 	if (!ep->ib_window_map) {
 		ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
 						       GFP_KERNEL);
-- 
2.47.2


