Return-Path: <linux-pci+bounces-29743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D24AD90C0
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 17:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83BF21E39E8
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 15:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC351C84BB;
	Fri, 13 Jun 2025 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dd1KsZOA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A7A1AA1DA;
	Fri, 13 Jun 2025 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827169; cv=none; b=Ok26uZfRwNDbevg5pH2BpQpjvA+ZNNzOs4o2Lp2UUlR4+r2xacxd89HRHCwPviCdLqvyfwV52uKHegV7JNu2G4TbfqpkJRAL7QC/CdOXyvbZDqNN4AKCUfFrfQnr9a6llwpmvqZKRn4ZR8Anxgv4vaAzKGnPGi/ACeQplRrhXnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827169; c=relaxed/simple;
	bh=I6GWAxCHn9ykIre5Iu/5nDrUj5xXpxLWH8Z1EPm68Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiKzFGrfnMvFGZ9Dv18bhSZmqyb3W4EZvXwkoSw8lZ71B+odeNwlDFnBV3jcC7FEPp727hf92d+eJOnZuGMkAe9AnHpGSnQf9x6EjLC0tcxvqll2hcywSVQyOzVtRQ4gulLucZNWyhFSDvCIbNfHm5KMG0vzUVsH0X1v+m0tQsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dd1KsZOA; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so1930834b3a.0;
        Fri, 13 Jun 2025 08:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749827167; x=1750431967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5jwmmYn5mR6/LEUkoHGVPsLNEcwThgX3SiiTAZydAvs=;
        b=dd1KsZOAt4QawWSsAHW9c8sFGQUs3GlKOA2fwyXjZUa9NSzLwR5BE9BEhwT+qQ2L3q
         2/lJcruHF22uk/QyBQZZNjpPMMSixS6OLXtsDzgD5Vfrfo6EzPb8Yhooqy7w3IgVVUiz
         Qdgq661/sSr/cIRGylC3y+GCNa5AU90DYBekzEajgrTG/LvrxW3JQKTr1MfwIj0nwPn5
         tQNuNXsLGrZtFOyu9hAwYJ7JDT61dleUf21sgylyx3S5dX2hS0fOPo1fY/9s+8dRMs1+
         y0TGEgMotcNjhG8txqISp+/BJrZSbMsaqqYCKT6F2ohPcCTUTbXrcJN1sLu/OnMLe1WP
         E0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749827167; x=1750431967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jwmmYn5mR6/LEUkoHGVPsLNEcwThgX3SiiTAZydAvs=;
        b=t/k0WawU1JXao/wJb+GjA/68+9Yz2LxElA0Vdb9Xl9vklCUtsQM28zHqDU82JnXjDs
         WrnVu4JA0UEn/kTPaLP42Q5oBCpdHX9bfPnIzc1jPoDpqYf+EOCDdh2AnN+EAS27NRu0
         YnyyK/UoFRhKypwMsIixGRLI9I5iKNZKiDCmi6ym3TyWU96dsueJ+Do3YvzogDr8ez2Z
         F29lqHlvF6XrORUqFzOUdLoSzYOOhMtjBXTvSbccXF3NfxHQd0HT8+E6HNayTLZdBnBx
         reKExU+rXL+tuiILnB7wvDn1TZf4S93k3StwhSBGx5YiEZWfJMfL+e+QtEWWJOVkVqEh
         sMWw==
X-Forwarded-Encrypted: i=1; AJvYcCWiNvX/PhcPKLPkU5KTUnuya+k5ikTNfsDEACzzC4DLQh7Yw3ELmK6X769g4qeLolGawNdLxKwnchNE@vger.kernel.org, AJvYcCWqrlrQAZh68fMhindpEJSN7Xdm0GcHwDqgJEScsrec2gZPrmo5FSrKGN3ETMVGyYhVc9k24kxSyxHCPjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpkG9x9XI1Cearvz8fripVCMX1qfs8uqokJya1f4P8z9z+2UyV
	df1FRxGNeKMdZlL12RknWSSqy0GvgTzWS1p/gFmVycIcukOWNDH4ZNYg
X-Gm-Gg: ASbGncvV4Wz16gJFaiiWP3p+tN+7dmfpgg+MScxF1/MXgPjnvAzInMIy70BIwWgSTH5
	4sS4iDDotQsGY7nZtPmRnSMlhJDMn9DjsEUnxODaWUx6pU68+3PZwRPdFps5Fx8MPK9lfFhu2t5
	zTUxyNJleXOuiUgYGK9XuU24BFogcPhgaJQGsU60ADxSg/61qe1pGcSJ4ctvLUVUfuAt+r0D2hE
	4l/MrvbrlK/qZ8SANVU+WrTbBkQrVI17VVbS+AwLaxlvfdp/8ehp35Y8U9VglG30oRou+CZn412
	DQooszE9RY1Yt4Xrh5+Tb3UQ79WvBERisDnp/Pu4Nh+vuUJ6pQ==
X-Google-Smtp-Source: AGHT+IGYw5AjQ+/QZORRx3QoafJhKHVvIiAqNZXzixKJWW+8p/p+htMuLlVMp3U5LPssM6b4Oi+Eew==
X-Received: by 2002:a05:6a20:7fa4:b0:1f5:6b36:f574 with SMTP id adf61e73a8af0-21fad0d39ebmr4649001637.38.1749827167066;
        Fri, 13 Jun 2025 08:06:07 -0700 (PDT)
Received: from geday ([2804:7f2:800b:838f::dead:c001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7489000531esm1691240b3a.41.2025.06.13.08.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:06:06 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:06:00 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v4 3/5] PCI: rockchip: Set Target Link Speed
 before retraining
Message-ID: <affaa12fedbb6e34696242d1f2f2dc5634b72005.1749827015.git.geraldogabriel@gmail.com>
References: <cover.1749827015.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749827015.git.geraldogabriel@gmail.com>

Current code may fail Gen2 retraining if Target Link Speed
is set to 2.5 GT/s in Link Control and Status Register 2.
Set it to 5.0 GT/s accordingly.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 65653218b9ab..7a0b6ebb7c27 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -341,6 +341,10 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		 * Enable retrain for gen2. This should be configured only after
 		 * gen1 finished.
 		 */
+		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
+		status &= ~PCI_EXP_LNKCTL2_TLS;
+		status |= PCI_EXP_LNKCTL2_TLS_5_0GT;
+		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
 		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 		status |= PCI_EXP_LNKCTL_RL;
 		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
-- 
2.49.0


