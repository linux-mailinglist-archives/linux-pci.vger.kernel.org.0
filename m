Return-Path: <linux-pci+bounces-14587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D101C99F8F2
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 23:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60CC4B224CA
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 21:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F871FBF47;
	Tue, 15 Oct 2024 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Es04bfnH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA231FE102
	for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2024 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729027055; cv=none; b=UoM6INItXZpCXsqs05iOtLwaUcuLSlwPTHmIuVJeZ7eMtH+KhoTp+EDxq6deFZo7N9ZS07xmHNBG59YrcE0hddyN5dH9sK/NIlQoLkSvd3XHI7w8MnuRKs5z+tw+lRKcnSkXPg3IsV2XN01hrjLuGLZJQXv6yDYhv3NKFdxhz94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729027055; c=relaxed/simple;
	bh=sq1soXl6abewwlFa2cbC8njUDVPYJn8dPV3vVeC5jfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b9rJH3nVeQWL78X1gF9yhP6T6UeB8oEDI605ceDND1ZH1gfz3AbmCSMSWayOIWK53o6GGxQACdLRHYZuJ3TcELvcQY60zsLHra9PgfLvakbS2oT2m2CNWPLnxr9MA6iRBuJGRxmQGt+sAsQkUVjw8CNgTzW/R77XDUGT4vy+gFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Es04bfnH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ca96a155cso36707005ad.2
        for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2024 14:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729027051; x=1729631851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=45JHgiZllHV9bG+rAdE9g36380sJR4Ghem5bkWEe8y4=;
        b=Es04bfnHbqQMIpb3BGY2wj/E7r7GNf93YN5M9k4bgRM/cQtCisjTgdtiZO4M8Raka4
         YWaxTIakiN0meX6YmnAnooEX7ws36BKLEXo+FNzNgbq4qSXI9Oqlou24+DHBjtIy9gse
         wwlcFBe2uCaiVFOwYF+VQ/O2UC2NW+1gwooBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729027051; x=1729631851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45JHgiZllHV9bG+rAdE9g36380sJR4Ghem5bkWEe8y4=;
        b=brxIjOR3jjC1nD/kSTvDKeFwjwBx4emNhI1imA2sLqQE4DOxdoJoMzBG96xDBi8SwB
         9K8R5I4IaNUkniU8R9VcZbQoJfj6dck9V0oLLzpoysuc4ByLuLehETR5CSVxDhg/FDx1
         YIwyb1LG8fOdU18R20qtTuT4RQ8R0q8Tq2FJd4GyjCkDBLbWXmMV2GiHD4J6Q7o06IUj
         xL5eMYQ53kepHBBix0GhuQMlRn+OSI9hXhsD8nHFtDGkOybldHhfyYAM7g4Zvf48n1gD
         w/Dma/sL5PFqxGJKZJn7nqBLjbqots1Mpr1D498Eyahr2hFqQSUhMmeY7fe3S9JbxJOY
         OAxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKPGMgckGHbfp9s8Ltx52WathStw0V+tIf7GrcSLylIyE7CDHShg7opztUyBDtTko9GG+ahLfD6AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBybaHqeacenTx9laCUKuRp2w3sQKjyUaLjySEHMEAZBP99NCX
	yU5okSRqMP8HdaYlY3tb2wiqQ+Wzvr/ZOZqrG1uR0HoDJa9mEEEe5R5eEjuk6VHqkh0zFnyl7Lg
	=
X-Google-Smtp-Source: AGHT+IEBiwMyi3fjfu1hF5JodP8eCHbFlmnTBRYbtyOyrIuYZzVq5QuUA3QT0frTpd8QsWbReK0dag==
X-Received: by 2002:a17:903:22c4:b0:20c:a055:9f07 with SMTP id d9443c01a7336-20ca145f3d6mr197854775ad.26.1729027051559;
        Tue, 15 Oct 2024 14:17:31 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:eef3:dbf8:fbe3:ab12])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20d17f828c8sm16720525ad.37.2024.10.15.14.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 14:17:31 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Brian Norris <briannorris@google.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] PCI: dwc: Use level-triggered handler for MSI IRQs
Date: Tue, 15 Oct 2024 14:12:16 -0700
Message-ID: <20241015141215.1.Id60295bee6aacf44aa3664e702012cb4710529c3@changeid>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Brian Norris <briannorris@google.com>

Per Synopsis's documentation, the msi_ctrl_int signal is
level-triggered, not edge-triggered.

The use of handle_edge_trigger() was chosen in commit 7c5925afbc58
("PCI: dwc: Move MSI IRQs allocation to IRQ domains hierarchical API"),
which actually dropped preexisting use of handle_level_trigger().
Looking at the patch history, this change was only made by request:

  Subject: Re: [PATCH v6 1/9] PCI: dwc: Add IRQ chained API support
  https://lore.kernel.org/all/04d3d5b6-9199-218d-476f-c77d04b8d2e7@arm.com/

  "Are you sure about this "handle_level_irq"? MSIs are definitely edge
   triggered, not level."

However, while the underlying MSI protocol is edge-triggered in a sense,
the DesignWare IP is actually level-triggered.

So, let's switch back to level-triggered.

In many cases, the distinction doesn't really matter here, because this
signal is hidden behind another (chained) top-level IRQ which can be
masked on its own. But it's still wise to manipulate this interrupt line
according to its actual specification -- specifically, to mask it while
we handle it.

Signed-off-by: Brian Norris <briannorris@google.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3e41865c7290..0fb79a26d05e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -198,7 +198,7 @@ static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
 	for (i = 0; i < nr_irqs; i++)
 		irq_domain_set_info(domain, virq + i, bit + i,
 				    pp->msi_irq_chip,
-				    pp, handle_edge_irq,
+				    pp, handle_level_irq,
 				    NULL, NULL);
 
 	return 0;
-- 
2.47.0.rc1.288.g06298d1525-goog


