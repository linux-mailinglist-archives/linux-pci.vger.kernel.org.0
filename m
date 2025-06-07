Return-Path: <linux-pci+bounces-29128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDACAD0CEC
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 13:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69CD016F9B7
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 11:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C4D1E5B88;
	Sat,  7 Jun 2025 11:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdbNx8ik"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B431EF09D;
	Sat,  7 Jun 2025 11:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749294087; cv=none; b=PRkrGZbdn7OWDSwm/7AE35+NY6lZFgPklDBpylu2YSsp9Ljjkkzke14n62M6ETLIj0Px3kjSnKFPkfwSJ7dZHnFFmUYEZ8oe99TcmOm4c6yjfAA09cTsAC4ViR6FMQdEpatbDfwuR6OMVEz0oUpAWzlLN47ZPCNEXN6Iyk3aCMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749294087; c=relaxed/simple;
	bh=R0Diu8FdNpsonij9FRi296bJDC7EXdWN7iyi2qRRg20=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mBZgEqEtljbDPCFBs1sCSYlmzoQTCELGllSmH8R4RvKXxAHabSBfcIGYJhW1jbT3+9v7Dq5bVaaACXaPZ0LmWrooHID0oK6Kw70T+bsdneVtfpuBseP517E2MiK3Hvz9WAsBHWLv9PBl+TQXHuOi2cLGK4jrtJxObkFJ6snF378=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdbNx8ik; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-745fe311741so3376276b3a.0;
        Sat, 07 Jun 2025 04:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749294085; x=1749898885; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JsBR+3ZaCX2OHnpXjm2aWoB1xEksOSX5f66Opu4aP6U=;
        b=hdbNx8ikm0H/6KMV8n3cLB3ILopWwVEoMzOcZlB/XkkzJj9LUdt095zBjAhdIYj74f
         9CQaVYuKNczAQnbMlfRe5wGjlrRpySaz16dCa1bqOs00fGnJXBU0XclBUMZR4x1w1PO8
         Qx+XJlXAu+tI81Fervyfk+S000I98ABXvvHzsEjdQ7aAzqTngAUr7LHUYXOkwJRrhErK
         ydex+9L5CEnuJBtO4Prp5uH4gYsodRwEUwXlQIg3LQpTwA4PXUqk1Yw+D/NOd5L2dZ9z
         C7gbAFlnDaSS8qcfT/WZ0ZO5SxgXfiPsi5/k73u/BpU2wGdG95gzsei+BJSXJxbgU4Vp
         cU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749294085; x=1749898885;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JsBR+3ZaCX2OHnpXjm2aWoB1xEksOSX5f66Opu4aP6U=;
        b=Ov4i1oQ2n1P9cPullTEFIcHFioK8DklYKn/Qdwj6LYOZTo9oF44f4ycAFcQFHjgpKo
         TYaQW+XwOSQsTspGy5YgAqSeJYJ+kh10GxC7DUjXeOP/1Yh624mexVNtCQ2VQP7fywMf
         NLSPZTv1aSqHYlBX0qe8DBuvkvsoFXy5GyQf5RfI1mgu4La8Bc1FSoLqc6aoN2ps4Zg6
         7rt2F0bL769sDANyRxxLJ05SZDpdFj3oNIYPUs7O8f4M4x4vsQQYRjogj3PsmSeODttB
         vb8peqFHrxzjdjVjZrSSZalOpUXtYNNQDKWej4RuYW5ea7eFy+j+QIxuw6g1ShRIpg/J
         g7qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFDGpVO99OjFjwqAtNCTU/OXN9DKx4jDwX987mNJoVS5LdiyWEzCgbS99Y+cUda0wlZbvzIEnQCwptrDE=@vger.kernel.org, AJvYcCVYE5Bpdl6swRLG7N33iwF6ExghI5F8UfU6F3OFHaRg/KYMy5Pa9LSoV7WL3iAD1xWIxoXeNzhZgdt5@vger.kernel.org
X-Gm-Message-State: AOJu0YzJuw75DM4fWxcpJDbj39ESvuBSQsT7ynLOHRkSkoBEC5J4mxOU
	yjDoJRyPslKolxlONnBq5cOhlW5bzJbT8IgCYOI6abJCz9oF/iib80emiMwE7ivk
X-Gm-Gg: ASbGnct/kOfOa8ZhaLn5CNKX3VDLE48Y9dbLZVk/53QqkJ0z4fv5UIZzfRGJSdXVnzO
	ykmCSkbGS1m2mDSJGv2CkNL1+SoKeiAoMTdmUCXwX/vsj4cf4LuwlDOdIkMQLbTz+Fqi/whl+I0
	fs8nW+gR9j6bew6RyrOg/UHDzNY1RJs7TghLRIKeozXf/ZCkhWCxyHEbOmAIAU+vcXEzUi5O6Ok
	nxLuXehtUw6T9sSeyAc6oJBqlYisK/VdMbHYxrg6DTe+fFbQ3NiyZLuxjm7rtYr+hNEytZ/K8cv
	V8ZhQBzYaNmQEbysOKIAsXyl8sohpDDPXSlF3/OOk6O+430wkw==
X-Google-Smtp-Source: AGHT+IHNpZUdZlSIJX40FGVrU5jxa9k7R1/SXc2BmovlQlqrVQqzsarwJuqHOBXzdPDbIs0BFD5RsA==
X-Received: by 2002:a05:6a21:68a:b0:21a:ede2:2ea3 with SMTP id adf61e73a8af0-21ee250ce0dmr8734059637.17.1749294085231;
        Sat, 07 Jun 2025 04:01:25 -0700 (PDT)
Received: from geday ([2804:7f2:800b:2bc9::dead:c001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748391f7391sm959612b3a.45.2025.06.07.04.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 04:01:24 -0700 (PDT)
Date: Sat, 7 Jun 2025 08:01:19 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/4] PCI: rockchip-host: Set Target Link Speed before
 retraining
Message-ID: <aEQb_xUwC0gk97y1@geday>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Current code may fail Gen2 retraining if Target Link Speed
is set to 2.5 GT/s in Link Control and Status Register 2.
Set it accordingly.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 6a46be17aa91..55b3289fb70f 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -341,6 +341,10 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		 * Enable retrain for gen2. This should be configured only after
 		 * gen1 finished.
 		 */
+		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS_2);
+		status &= ~PCIE_RC_CONFIG_LCS_2_TLS_25;
+		status |= PCIE_RC_CONFIG_LCS_2_TLS_50;
+		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS_2);
 		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
 		status |= PCI_EXP_LNKCTL_RL;
 		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
-- 
2.49.0


