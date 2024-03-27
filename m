Return-Path: <linux-pci+bounces-5249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7281388DCED
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 12:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE241F276C5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 11:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE80B12C800;
	Wed, 27 Mar 2024 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zij1bBeg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276C112C7F5;
	Wed, 27 Mar 2024 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711540485; cv=none; b=YFosjTzJFdQSEbfVC2A7ymX8s0bApuJ8Scyb9LCtme9idTd/HoOTTA/Dub5l7C6HmRznuNn8Kkm+ny2K/mze7SZ88uOGoYPQM1RFaxPL9oAuEzO7VTUlaYyC5cuTvxGlv8eclTS/D6oNBc5SJmcGGE9SodsAgUursgnDYs1Lnlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711540485; c=relaxed/simple;
	bh=ZZSMpoOev78J1M2meXpmvfouZ4ljCxtiNTYvkxowyFc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FiGvDwSqUDofKy1kzkERUK+SA2BPtAb3sjEkKKOrTV1ZUT22XgEPuywTsVnnwuCFRm/gHz0oXf7oD/iIshVBSP99mKaUdNanc4M79tyfwR9sL5MEzIxXMlQl6DNAsy9b2YyZrkHNaIbgcsJkNdrVJSfh7ta9twt6n9iGHrTOm44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zij1bBeg; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so151623466b.1;
        Wed, 27 Mar 2024 04:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711540482; x=1712145282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pZaLHIacfr6HStTphCo5lzi6sIvV88Wx/Y1k9aMmSGU=;
        b=Zij1bBega5RoLvkArNhzMpHxPNEGnkLIebfRqp0DsB7UPjmQ4PoPO+bg99bIGzt85E
         3OEBHn+AmdrhdH6ZTFiJvlHC3CQ3Va33VRaw3d/7RW92Hk6VggfcYBeO6qTpbGOSvAcM
         ZhdiEQ61s4YyFceeAJIDWgFlrvFHwX0VXiKjz0gcr8olvr3ZSQ+U/uD1EjG3WtPhZouk
         gBgSV40HOlLpL75UpJiVm1CnYqDcC8wWX07plmgzX9XYkdYXg6BdZlCY1PbBbbKTaL0N
         xgagQ0O7uU5cu5xzwejWKuVKX/Zhx0bzecrQ0AjsShsiFH9AIbEpS22Fyu9zrBxbEoeq
         P8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711540482; x=1712145282;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZaLHIacfr6HStTphCo5lzi6sIvV88Wx/Y1k9aMmSGU=;
        b=jSAz8kq5bZx3QVOP6JHBXh29L+ITebgqn6eSzq+SGbndO2DL4X4vt2ZcNvB69kj+WT
         KEyOaDd9Opya+2q2iiqh8T+e0hPGM1T8z92hWBcv1iGSjyXR8lh4bVjvOubCFBtGufEN
         w+PVqUiVXMlirt/JfqsdzAWYuXsxqkz1Z7sHSaAlA+uS4iCxYESd2eC+oJ0EMmT1VpbV
         Hzd6nwV6inj0Ia/GeGq9KiTxM654icAhY9ARhBNmFYe+XQzea6WLeoNmHI19yBjuQYLk
         hfOnwBpEhZQfZRJ2EJEn+RzD5j9YmTOzOvIklxoyKjXUxlGQGZ1gGHPn4GpkTKF+EIfV
         gkIw==
X-Forwarded-Encrypted: i=1; AJvYcCUwqab6jDn9IL69bdNKEE4X6Az1HRBsDY9lnJTdgGh93vLP8kkhbJlZ9A4SIhu+dOScs9WjgSN2tYgwC6RWROBcWaeRBBd3
X-Gm-Message-State: AOJu0YwOhwjnNdpcS6Z34p6YX8WzYUCEeB++g7WY8GWlqDfZpwpCy2HM
	RUBv6UEs56/GDCWejydh+3VTrtpfvNvbmqe/yRV39kp7vqlVtiHq
X-Google-Smtp-Source: AGHT+IH8pf42nXHh+517fdP00T1mgakqFRoyz55pNC/O1igyyqQuULRTdKdBAmUHaPtuei1Ao91geg==
X-Received: by 2002:a17:906:b305:b0:a47:61ca:575 with SMTP id n5-20020a170906b30500b00a4761ca0575mr3457005ejz.25.1711540482199;
        Wed, 27 Mar 2024 04:54:42 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7b87:a500:dd0e:a4dd:4c2a:b10a? (dynamic-2a01-0c22-7b87-a500-dd0e-a4dd-4c2a-b10a.c22.pool.telefonica.de. [2a01:c22:7b87:a500:dd0e:a4dd:4c2a:b10a])
        by smtp.googlemail.com with ESMTPSA id kh11-20020a170906f80b00b00a4df6442e69sm1641076ejb.152.2024.03.27.04.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 04:54:41 -0700 (PDT)
Message-ID: <e1016eec-c059-47e5-8e01-539b1b48012a@gmail.com>
Date: Wed, 27 Mar 2024 12:54:44 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] r8169: use new function pcim_iomap_region()
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <982b02cb-a095-4131-84a7-24817ac68857@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <982b02cb-a095-4131-84a7-24817ac68857@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use new function pcim_iomap_region() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 5c879a5c8..7411cf1a1 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5333,11 +5333,9 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (region < 0)
 		return dev_err_probe(&pdev->dev, -ENODEV, "no MMIO resource found\n");
 
-	rc = pcim_iomap_regions(pdev, BIT(region), KBUILD_MODNAME);
-	if (rc < 0)
-		return dev_err_probe(&pdev->dev, rc, "cannot remap MMIO, aborting\n");
-
-	tp->mmio_addr = pcim_iomap_table(pdev)[region];
+	tp->mmio_addr = pcim_iomap_region(pdev, region, KBUILD_MODNAME);
+	if (!tp->mmio_addr)
+		return dev_err_probe(&pdev->dev, -ENOMEM, "cannot remap MMIO, aborting\n");
 
 	txconfig = RTL_R32(tp, TxConfig);
 	if (txconfig == ~0U)
-- 
2.44.0



