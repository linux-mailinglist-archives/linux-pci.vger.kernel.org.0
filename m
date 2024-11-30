Return-Path: <linux-pci+bounces-17491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B899DEFC7
	for <lists+linux-pci@lfdr.de>; Sat, 30 Nov 2024 11:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59C3281765
	for <lists+linux-pci@lfdr.de>; Sat, 30 Nov 2024 10:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F6915532A;
	Sat, 30 Nov 2024 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xJDwtJWJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F4015530F
	for <linux-pci@vger.kernel.org>; Sat, 30 Nov 2024 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732960880; cv=none; b=LWxrmnfaruk6RmtyIk3W5CaoVtGBOsZJkvzsJhSwErJwHheUpfqRBLeumEqnQ+Z3yWu/TvrQMHA1ZpG2NBxDDmLHrTkpeJ2mcRfThmPcQ7R12V2vp+/fMQD9RpUSv84MfWXSES03WCSTLQT81B3v4YK4kNusjm+btHnoY+qMF+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732960880; c=relaxed/simple;
	bh=pwCVrSo2d63QozkbYlTrgoal5OaXwx+yCaGWKkdfnss=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TGR4pDt6lyNukl1prsVwgZf/0C58yvRXabtrlx9xpnR+5GWEFCdwn7D12W7shSQeeihL2uxLt/YqddTWafHuXQZNxK0YkQ12A4r9kSPSzgNvTO7IqEb9D4JSV6ARjcp4m+V0q2AbQ1Tmr/hFGuixkIUxWm9f0NdnHXvYHq8B7fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xJDwtJWJ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aaddeso3154420a12.2
        for <linux-pci@vger.kernel.org>; Sat, 30 Nov 2024 02:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732960877; x=1733565677; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aK0dV1gfejvgX5AVRAv0AO9jA2ssYUcI54wSBwP2RLM=;
        b=xJDwtJWJ5nVVYoF8BeAwKwPx19hTzgGsYMyVveS/HUx/+9EhIYH5A/O1785udRsVQe
         AMUgPTTC8wFIg11nGNEPm29CLucQOHlZWF6CaserezMgX9bMvWBoUoNCcldIi2m3Sxva
         s0Vlif+LVIFuiamCOKtOPO9u37LmTIiu8HPte1A86ZgQPtVPjyuHvBoTZck3cOYfh5As
         PowTScUTXytEOhD9GNC5CXfPs9AyhTbFsvMk1jbHGg/deDV0MhhNEYpziiF09MSb6B7s
         Mx823j+dqBIkBVwLJfwWlAAC210nBtQWZy1IewM3Z4sXY2vg9CsvPZ/spqHsV+rx+CXl
         WkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732960877; x=1733565677;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aK0dV1gfejvgX5AVRAv0AO9jA2ssYUcI54wSBwP2RLM=;
        b=KQ1fv1yjVyPsloELygACa0pFuSjtt3GMWbOBGUR0qWnGHk+41y/3KUwv7ye5ft1Lat
         WOwfsO0OfqAwju1PHFksE/Xig6pqLF1rylqHFr1VAKGHdDwzSzsx4nCaw8c5NLO3m/WG
         ztx/Jc58h6aXLGVQfBytKFlg2EPxl8K04CKj1+5rGMi145cG4pQRD6Fu+J4wdCy83bc1
         Q9nNrOlsg7nvhhdf31TEO9Vh6H3/OEmkcI5XHbtlyTed9kFBVzsg0KStOEOMU9vjUPqS
         TG3dEM8carI3AEae77cGN4JoMK5CANL9WlU01xGNyVZ9ZsPgkHXBhwq78NncyvaCE9PT
         MIVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsoLDSGOvYUPCq1FMhglw3F/UiHLqo5F75+yvdltlWnsKp8xI09zdVx8J6QyG03p08CVqaFdaABGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8sL9UBv0LtqGNVM38tQRZ2xTxJtLdmC8DXiHkK9W/Zdz/NMqD
	LvtW6FI/7HUO9aeBLjfaUM99g/DzPoXmhrvJpl1Sy0CG2Q5tOyfFZ8jc//ldY/gi2hCdYLZyLjU
	ByvUy7A==
X-Gm-Gg: ASbGnctfd02FwcQSyhUDuVl7MpjmjXRi/eXkuuugHslsk+E5b6W9VrcnuUCUZjd2leF
	RBwYPuxB/cQzE9gyavSxuRsWBwQsgAGX1D0ScSi5iKWUBzMUL5CrZ499hvjq191cV0cJzoJLmq8
	/kYwgafpvINbwYQvgjSokkd6xzkawZZWxY86K9jw6U5lm+yMH1lvZHNcyzmUtjLAJElnnlT10S1
	ajjWCwDwwxCix4nW8cvGHcWdUdYl41bzMBoQDI7VPW0FEl5GDi5IaBluupYYK1C9f8Jwomk
X-Google-Smtp-Source: AGHT+IEtv6gd869K+dRtqKZE6OGZWNVbaOzagbrsUDx5xx6VOeUmeXvzJOk8eFEsMgnWDlwVcluldw==
X-Received: by 2002:a05:6402:2116:b0:5cf:e3cf:38af with SMTP id 4fb4d7f45d1cf-5d080b8d46fmr14459310a12.2.1732960876730;
        Sat, 30 Nov 2024 02:01:16 -0800 (PST)
Received: from localhost (h1109.n1.ips.mtn.co.ug. [41.210.145.9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097d9f5fdsm2670060a12.15.2024.11.30.02.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 02:01:16 -0800 (PST)
Date: Sat, 30 Nov 2024 13:01:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] PCI: rockchip-ep: Fix error code in
 rockchip_pcie_ep_init_ob_mem()
Message-ID: <8b0fefdf-0e5b-42bb-b1ee-ccdddd13856d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return -ENOMEM if pci_epc_mem_alloc_addr() fails.  Don't return success.

Fixes: c35a85126116 ("PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() memory allocations")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 1064b7b06cef..34162ca14093 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -784,6 +784,7 @@ static int rockchip_pcie_ep_init_ob_mem(struct rockchip_pcie_ep *ep)
 						  SZ_1M);
 	if (!ep->irq_cpu_addr) {
 		dev_err(dev, "failed to reserve memory space for MSI\n");
+		err = -ENOMEM;
 		goto err_epc_mem_exit;
 	}
 
-- 
2.45.2


