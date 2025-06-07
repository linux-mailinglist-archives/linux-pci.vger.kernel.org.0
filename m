Return-Path: <linux-pci+bounces-29127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 636A1AD0CEA
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 13:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41091892640
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 11:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3212A20B81D;
	Sat,  7 Jun 2025 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFfIAIOO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAC41EF09D;
	Sat,  7 Jun 2025 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749294063; cv=none; b=efyv7LMEyxs0fZnee+LO8EItdFDQo3n7JX8zqSUh4o3yy9MseYu89Gua1KPa+E8S50aHCOBRFajMVsHa1vSea6iKr1nJfPsaFXmEFQaCLR9xi5jzRQVkaAKByuUGynPI3ZNv/ngqXWMrcKickfLyZhu/LEhYhYsZ6hPqRbu96yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749294063; c=relaxed/simple;
	bh=UUqxr+6/779hZneJeKWvtKEmgP4iuqaZesdhUSXdbFs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C2JZuDm0VbBJepkR1Kze7MYdYw13jNk17bYGQh+vezd30ciYPPnf5HuZIYX43J0+GVNLzZCwefWtFkzAKbZVm5uayxSsRoqhMGSrwmbY1g629rwzjc+dPbyU1hyWz4wGVsQm8td3KnPKlAmK7foyrm/u6k/5UHH1P68t3FLeHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFfIAIOO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7426c44e014so2516676b3a.3;
        Sat, 07 Jun 2025 04:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749294061; x=1749898861; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z4rJwaiGUcVMasYaoYfW1m6j68aKnL343YiExodW7Dg=;
        b=JFfIAIOOMLSnjLNiprgYS5yrHmeeEkl1tIE3ycGJhBRzjIFiLAlFjsoGl8f9RgUWoU
         MZA7Kt8aS0rU7WXd/v+3uilJnMJ1ulvvtf/wj5YcFZOOz6vFgWPGBR43tLlzKNL4Bnje
         YcFVqQTXNYXY2VEEkZWkK/WLX9sh6NkGdM00TIXSfAUigGH3F9X6Z2k5xKqDVhot8WH2
         is5KXS1vAR2PcOMM+Ggbq+dPy4KHLTp6AeVdoHkgGpcF1X1PqYJZFj+pZJWbuTJwQPmZ
         17boauuoMVAvPq380Yd2/7U2LUvEBiYKM4Day9Iwk6I6RwB0Erylrb/y9Qc35/1CoXqK
         lwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749294061; x=1749898861;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4rJwaiGUcVMasYaoYfW1m6j68aKnL343YiExodW7Dg=;
        b=gZf4CFIMgdbZ9UnIfwYDLZUo8x8dDVl2vlcpy+6pL2MbgdaNwU2Ckg1tWn7cfspXNf
         MTvEU8zMzQbgXw/J1wOJG+ut1FIzWIb2dYpF8IZra/4gbvv8tL/RbYo17YNIpOZXkQwz
         9Xm+CdlN+9yLu3n3fMndWhBJRcKKK3AyzDBHDItgW+wQEZyWAw5ATRgWO8ReuPzC7Exv
         LoTNtOMtwlt/TGM77gJBCEaYozSXWd8TWc/Ezu5/qhhhplbZxrxHa1pHONLSuvp7UM6v
         xs5wyEMPMTdO+m2nBNoJTUWSbZ8QHKjseyVkn71n/f9+P5WqaOzsY63d0N4gwJuqC/lo
         6+/w==
X-Forwarded-Encrypted: i=1; AJvYcCUPz0fN4Lw7cQRlGiuxcUyKmy8EWRFoveY7pZyRBA7MlwJjgUHJmNH8NkK6U08qEAhEiEkL9Bu+9xyXM6Q=@vger.kernel.org, AJvYcCVPhkSJFE4BBYla7JLJH1bG0Lh+g7zU+6RS56rIKS7l0g3+cs8jnHWpdAkkka/YCS5aBo8pBVhYkOsP@vger.kernel.org
X-Gm-Message-State: AOJu0YyFkFLpX3TNedlkFkdKM6GgUCNKCTyiY1KxA9aLtwtnYFSQKpqk
	39NYGIQy8jxQdHSFGnMtz7iyKKZNls9sBkTde4CmXtIVKa5IBQp69wKu
X-Gm-Gg: ASbGncvYyRfVD1Vwe4xatgMfmyI1CMS9VhwaMXqDOLRhQtp1gfZf1jQqIPwFMAmPaez
	E9s6KJfsv0Ic1EQnCuiaS+89xpxCSryt3LIZ3xowYVXOYKFDXyp/mWGG4LZN9fF/ehtMVgKA7C9
	vKxYtLxoD2ufcSc1eihLFqBEVXLboKNYnrmOIPCbekHIGKzxsrauHiuGN4EALnD2WSEb+IYIsVm
	CNGOyK/2bCNnyr88mtpNcGBbg1Sm9VUBqVMWbtvOzPcGpFSeb07VLUiuw9WNLMwJFlPPX+3Aarp
	fnotdvvubU1pzorzDoWrWTf0XyWdBH1kZM3rKak=
X-Google-Smtp-Source: AGHT+IGt/YtuqJHdC6xAWVKyDpr0OqW7Qptp05bE0lEWtmw3T24yD4J1hIcvX2JIFS7jqrEZ4rgBXw==
X-Received: by 2002:a05:6a00:4b51:b0:740:41e4:e761 with SMTP id d2e1a72fcca58-74827f3ba85mr8768000b3a.22.1749294061062;
        Sat, 07 Jun 2025 04:01:01 -0700 (PDT)
Received: from geday ([2804:7f2:800b:2bc9::dead:c001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af382c5sm2534219b3a.1.2025.06.07.04.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 04:01:00 -0700 (PDT)
Date: Sat, 7 Jun 2025 08:00:54 -0300
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
Subject: [RFC PATCH 1/4] PCI: pcie-rockchip: add bits for Target Link Speed
 in LCS_2
Message-ID: <aEQb5kEOCJNQJMin@geday>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Link Control and Status Register 2 is not present in current
pcie-rockchip.h definitions. Add it in preparation for
setting it before Gen2 retraining.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 14954f43e5e9..7a84899d3812 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -166,6 +166,9 @@
 #define   PCIE_RC_CONFIG_LINK_CAP_L0S		BIT(10)
 #define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
 #define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
+#define PCIE_RC_CONFIG_LCS_2		(PCIE_RC_CONFIG_BASE + 0xf0)
+#define   PCIE_RC_CONFIG_LCS_2_TLS_25	BIT(0)
+#define   PCIE_RC_CONFIG_LCS_2_TLS_50	BIT(1)
 #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
 #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
 #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
-- 
2.49.0


