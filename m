Return-Path: <linux-pci+bounces-17508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DECFB9DFCC8
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 10:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3BAD281D4B
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 09:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2821FA14F;
	Mon,  2 Dec 2024 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GjXKHDQK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824491F9F7C
	for <linux-pci@vger.kernel.org>; Mon,  2 Dec 2024 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733130450; cv=none; b=oPlNmY20h1caGB8+/CXNONO7kR6fxlHRREK6QshB81ek76NKkKRkSHbo5ASV/g4NkVgamgqKc55q5BGoMz7h7aFbDC5CY0t2YeOHTV3XtDQFajkD91uFvwZ90SLJy1xUrEyjLLaA2MRHi4gIiW8/LlF0DuT8wq59v6HO7fUD0gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733130450; c=relaxed/simple;
	bh=eDatTayJdQZOiMDh398vW8A73/RB5IYaI7qGAmHkcV4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U/wWUvqTO8JIrO2oRGaqiAUnw/WS1DMsJSuq30yCzJqGRnivEhJmsdAvvh7RbSg70Q3MbcZm+yK25HQPjgZWXseg+1n63S4rgHhwr+Gto4ozEbPsD1ie+EbhojcCaB9o0uyppRCtyC/Yj3Zn9mCkZL8Uq3eEeDNu/3zAW1ptvTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GjXKHDQK; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e2880606so2274402f8f.3
        for <linux-pci@vger.kernel.org>; Mon, 02 Dec 2024 01:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733130447; x=1733735247; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BR7917va66KYfi/dxTW86XB5ZaenGMbVA2IyXvz+JIw=;
        b=GjXKHDQKQd5ZXfD05lLstT6GVkN4nM2KruJwqhgp6+QdzuLMAOJt4xcM9pkdoaB0Uh
         yelJU1omDuWAMXjn4+4RloQ5PAJkDnqB2WZivKcCcdCpGunmeeKdlRpk9N9FVSvk/LLj
         LYERcITvoR+pdxfSTAbSQhp5LLNh7F814tePm4iANAt+62NE7Kh0HXqzA8WV3WnEOEnE
         zIgXVM5iTH1j9JE+Ic0ovTuGMnTxRIM5S9Fr65fIaI/lIZQ7dtB2Q2NbhlcuqSQ1WWyR
         s8CwgJXzYUN+S3ZxggeHE5xGNrokVeou4RGRMVB+7LNebWSblGkCYFURQpM/oKE5MpiW
         ndKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733130447; x=1733735247;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BR7917va66KYfi/dxTW86XB5ZaenGMbVA2IyXvz+JIw=;
        b=SPYL6A9CYKvJhZ61vfHHm6NZel/Tw6cw8PRYKhHiK4GeFNfezC0v96DD5h+PVpxHJq
         RTDVBc2qvLAPjU0LaZb47Uf01nlvUCqe+E4Ud4bacCeEsCE6enxP28VPYfjd2Lk3VaA9
         2al1GYI/Xp0y0YY4rGT7EtDvbf0MxdfvOTMEVJDklRN/mlhn3LtXEjtlw05cm71QoZF/
         ojKEgMqYVGSF7TDLH/kpCJua7xXmq5C0egi1gzKHHqDXXmsKehrl0yDpP7nJ8HNHNuF6
         Qfbnks/1nj5fUkktVBBaU18jzyV7rm29oWo95XLhCYzVzPNE1RKxH9SphzKBQfzyYKRx
         97Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ8ZBKyal6NPOj6rAqK6ClJ4nlsIdtncWJPoRS13xELoap3bKYTlfkRwE2bTGkLq0Tr6BeVPqRoKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGEUbEoJz1Kr48Nw1R9voKgOw/p4CbDnerss436RrJp8xgrR/k
	4p9hc1ies4f2rPA41Bzdwj45Znlkb9oDTCiZ6RalIh5oGAlNrYON95ADEOeYn84=
X-Gm-Gg: ASbGncuJ5ZTdbA4HIar1uNKGpagv5aiSz65CaLWSp3XlRKcA8g1hHVdoQJ93oy+gjw9
	flWjkXwrlgrGiPzwv+nRqZE36ESjf8qrQcAhPUmL+A+LSu+d/gscJKQBU/xaf1VEpQgrIGwQa+4
	PlfEpNbEGWea75SuqjTaQfcbJKHFmRLb1HMitzovHDKdF6kzD7qDeYsufMhnFYtCYD8vdzUi0Ib
	aB4Se67Kj+zQQ+6ey7Gk0nYabUZTcozVA8B42qnLIBKsx1X58KLArA=
X-Google-Smtp-Source: AGHT+IErHtjKyBNSf/XUWvWl1AoW/h4AU63KtH1xNYUNQzmKxpbD3bUa+ZybCCBWlQeaV0PJJSm5wQ==
X-Received: by 2002:a05:6000:156e:b0:385:f062:c2d4 with SMTP id ffacd0b85a97d-385f062c49emr4402219f8f.37.1733130446807;
        Mon, 02 Dec 2024 01:07:26 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa78120dsm175382645e9.24.2024.12.02.01.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:07:26 -0800 (PST)
Date: Mon, 2 Dec 2024 12:07:22 +0300
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
Subject: [PATCH v2] PCI: rockchip-ep: Fix error code in
 rockchip_pcie_ep_init_ob_mem()
Message-ID: <Z014ylYz_xrrgI4W@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Return -ENOMEM if pci_epc_mem_alloc_addr() fails.  Don't return success.

Fixes: 945648019466 ("PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() memory allocations")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
v2: Update the git hash for the Fixes tag because the tree was rebased I guess.

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


