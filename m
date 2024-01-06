Return-Path: <linux-pci+bounces-1731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C65A825EF1
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 09:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310C41F22D05
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 08:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E988B46A6;
	Sat,  6 Jan 2024 08:42:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809225233;
	Sat,  6 Jan 2024 08:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3ed1ca402so2541745ad.2;
        Sat, 06 Jan 2024 00:42:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704530577; x=1705135377;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzSpcIavoyReTEOiYnKgTmz4B3FykorYQgoSNgSH6UA=;
        b=BreqQe8kNQ6SQBzeYIA4ad0SwVSXOAhtAh6+jC/drGzSJx04lTw6XhWSxbrP2vAoQn
         14TA2H5YxhjBoquu1yTuNr+oi1dRJWJ7gmmXZbBz++wn3HYdR6+oDe/By2+nftYKLmhS
         6xh9aQ1Jld5oIH2/3+pjoipVsEMFMlCZWH/2AVBXnZBdUxQbdlbnGOIWySFsPsud9/sN
         A8zJebKVUuUODgdFvmMlIKeWWLOHrnCPptnCWcujluiVuts5dJ92vT4DjDUy6sRF7EWH
         qKm+ml1Bz8KNoeiF9ceXfIFdRKuiWz7C6EOnTxUf9ZeHsaaTtN9sH7O+917dPNXsWDaJ
         N2Tw==
X-Gm-Message-State: AOJu0YwBTgswHtRXp4cYlXUxLJIXa6c3DpMDJCGEM0qIv3tpX3UfPdSf
	WFViNMvW0rgbdVXWic0G/gVSYS9IGX9BfQ==
X-Google-Smtp-Source: AGHT+IHzyCA6YhDhaj0FSeozHPpYI1Em6n+NGIGifHHAldeTpzU/LLimNtK9cabCu1Qa3doOkarELQ==
X-Received: by 2002:a17:902:d4c2:b0:1d5:307:7b74 with SMTP id o2-20020a170902d4c200b001d503077b74mr914039plg.43.1704530576795;
        Sat, 06 Jan 2024 00:42:56 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db0200b001cca8a01e68sm2578078plx.278.2024.01.06.00.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 00:42:56 -0800 (PST)
Date: Sat, 6 Jan 2024 17:42:54 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	mani@kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 0/6] PCI: controllers: tidy code up
Message-ID: <20240106084254.GE1227754@rocinante>
References: <20231220053829.1921187-1-yoshihiro.shimoda.uh@renesas.com>
 <20240106083340.GD1227754@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240106083340.GD1227754@rocinante>

Hello,

> > This patch series tidies the code of PCIe dwc controllers and some
> > controllers up.
> 
> Applied to controller/dwc, thank you!
> 
> [01/06] PCI: dwc: Drop host prefix from struct dw_pcie_host_ops members
>         https://git.kernel.org/pci/pci/c/aea370b2aec9
> [02/06] PCI: dwc: Rename .ep_init to .init in struct dw_pcie_ep_ops
>         https://git.kernel.org/pci/pci/c/756dcb5a820a
> [03/06] PCI: dwc: Rename .func_conf_select to .get_dbi_offset in struct dw_pcie_ep_ops
>         https://git.kernel.org/pci/pci/c/641f79beeebc
> [04/06] PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2] helpers
>         https://git.kernel.org/pci/pci/c/70fa02ca1446
> [05/06] PCI: iproc: Fix -Wvoid-pointer-to-enum-cast warning
>         https://git.kernel.org/pci/pci/c/f72896721621
> [06/06] PCI: rcar-gen4: Fix -Wvoid-pointer-to-enum-cast error
>         https://git.kernel.org/pci/pci/c/7682f19c3c8c

Bjorn, there will be a minor conflict with the controller/layerscape branch
when you pull these changes to apply against our "next"—a side effect of
this particular series, which was rebased against our "next" rather than
being kept aligned with our HEAD branch, no longer including changes
against Frank Li's updates to the driver.

The following simple patch would be needed:

diff --git i/drivers/pci/controller/dwc/pci-layerscape.c w/drivers/pci/controller/dwc/pci-layerscape.c
index 7cdada200de7..9db079bbd947 100644
--- i/drivers/pci/controller/dwc/pci-layerscape.c
+++ w/drivers/pci/controller/dwc/pci-layerscape.c
@@ -278,7 +278,7 @@ static const struct dw_pcie_host_ops ls_pcie_host_ops = {
 };
 
 static const struct dw_pcie_host_ops ls1021a_pcie_host_ops = {
-	.host_init = ls_pcie_host_init,
+	.init = ls_pcie_host_init,
 	.pme_turn_off = ls1021a_pcie_send_turnoff_msg,
 };
 
@@ -290,7 +290,7 @@ static const struct ls_pcie_drvdata ls1021a_drvdata = {
 };
 
 static const struct dw_pcie_host_ops ls1043a_pcie_host_ops = {
-	.host_init = ls_pcie_host_init,
+	.init = ls_pcie_host_init,
 	.pme_turn_off = ls1043a_pcie_send_turnoff_msg,
 };
 
	Krzysztof

