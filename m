Return-Path: <linux-pci+bounces-12053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E43995C005
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 22:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A6A1F23DF9
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 20:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC061D04B4;
	Thu, 22 Aug 2024 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBH7vxja"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4F943165;
	Thu, 22 Aug 2024 20:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724360386; cv=none; b=hjtpJH7gRI4UJpRhOi7L4tmznNja47uMOo/ZzfnVBKH7EotGOYTv5wttPjwnAFCvxF4cBZo1U1+fxomxVDfY8waZtgChk1jwVzvB6h6yRper1hCj7x4WXGOAmS2bis+5ywgL2HnufCtTQyoXOJmStW+rZcKvGZrEQkHt0TiKou4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724360386; c=relaxed/simple;
	bh=28pojKUQ6qO+r6on3wWUKKYnVzEqLG1o3UOM58rJigc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=b4oRac3rgMz1Ox/JjdXcLUUyt6Uf3N4ijBTnM52xNG+bB3x82D/5YxiOEsgTKmN4RHauSx1oa7YlSxZre3gVEf+cAgiKj42VOme7NTWESjp2eqQbQWESo1+ENA93GAk6WcrqDN6x5ApL0k9DXW8yMACx8wSyx5gQXSXPO+W/Dbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBH7vxja; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a80eab3945eso149738366b.1;
        Thu, 22 Aug 2024 13:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724360383; x=1724965183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vDvy51ASABEq3gzqvmhGI/KCGTT6YChJJ7sq8DX2KeQ=;
        b=nBH7vxjaWgKUgXiEws8MqIfX13oujLM2z1ycaLGRUCAn0iTq1yRBMNXnXc3f2XhWpn
         WCYgMH0FhroVp8ISb5NpfR138cJumcca/4RroGE2OdNdp9x1jqxcmvH4QKTzfXHXsVd+
         PpFbIncfW7lIjGPLwTuDuD19NeleWYYrjVvyWaDpRtTpIcfGMs2rIWCo/l1+nJxhATs5
         efDTOQHlPhn4NZjGyNl1uxk7Rd2EcnlsEDBh0inhJFsyoK9GIYcwr6N7tI3/eOLGRXIq
         qxZxh+2ShvwnXkkskVP9pj5kE/iojqTB2MfY50m3Jxk4NUfD49UILXanY+7lEpXv1jWu
         QPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724360383; x=1724965183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDvy51ASABEq3gzqvmhGI/KCGTT6YChJJ7sq8DX2KeQ=;
        b=wE36ZZ7CcfGHhC/LWzAq7bxovKJvqG2F3K9XiBYxaMtqnsNkSilYXD3TeTNQcYby2u
         1Md6ApqXJNJ3ZGdqA9NOZHEr6v/pd4XETpWcM+xOLwT2N8IbQMb7nyMNFU6BgWcwNee6
         lmBSqVp478py2We8ZI6/NICzKZz/RpuSw9bqUNKwkffM1ksDlH84Z5UXI6CydUdcDbyX
         ZJmEL2OC3Vqy6LdtZ7NB4oP5S5v6RvfI4s/sgh/ERO2u4JgkoJ2hbz3DD+X3XDrd+rzA
         PeeYAF8ELH7VNdR6rtYD+XZDdR63G3iYh3hkRliPDQ0PAMD+C3XtCHknaDJW33ddhO8g
         EXGw==
X-Forwarded-Encrypted: i=1; AJvYcCU2WOvHgf8vmu7RCvMWpLUnTAPiwdFf2ZDIJ1hx3vuB1eypSPBAwWi6pXEzqRBcRhj7qVKzD9BjkTvDyQ34J6dOE0E=@vger.kernel.org, AJvYcCWMDWFWjQ/Jnf36BDBfWEprC4NFufldeJDICzBAZtIIQLovxjv16zCdax9d1HF3U2WsGf+lrmVCsRA8nAU=@vger.kernel.org, AJvYcCWxPhdUQqdDFqU0qS4dhwKHSBGBS32afqHnj2sD/j5oQFdmfx59yffPn/qRWRVXIF0xFpoBYuLyD6M9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5wuDGbeu/YA+FQPqYeXQlKcI+UTkgLrK/qKAIokZYODk75GK3
	FAnaO0hOuEgj4FTxZ73Wy7V0GFTtP4L8LX51fj98sqjWPSFID/w5BGy6dxic
X-Google-Smtp-Source: AGHT+IHSGB3plWvvS/3gYKDMTDl/UhR91uk+0+sizAOhYQZCutOMiUIE9gG/rOlUPMc9eZKyuwoC3A==
X-Received: by 2002:a17:907:d5a7:b0:a7a:ae85:f24d with SMTP id a640c23a62f3a-a866f8c3451mr529079366b.51.1724360382619;
        Thu, 22 Aug 2024 13:59:42 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f43367fsm164044366b.115.2024.08.22.13.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 13:59:42 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] PCI: rcar-gen4: make read-only const array check_addr static
Date: Thu, 22 Aug 2024 21:59:41 +0100
Message-Id: <20240822205941.643187-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the const read-only array check_addr on the stack at
run time, instead make it static.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index f0f3ebd1a033..c0ea6b02f1cd 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -606,7 +606,9 @@ static int rcar_gen4_pcie_reg_test_bit(struct rcar_gen4_pcie *rcar,
 static int rcar_gen4_pcie_download_phy_firmware(struct rcar_gen4_pcie *rcar)
 {
 	/* The check_addr values are magical numbers in the datasheet */
-	const u32 check_addr[] = { 0x00101018, 0x00101118, 0x00101021, 0x00101121};
+	static const u32 check_addr[] = {
+		0x00101018, 0x00101118, 0x00101021, 0x00101121
+	};
 	struct dw_pcie *dw = &rcar->dw;
 	const struct firmware *fw;
 	unsigned int i, timeout;
-- 
2.39.2


