Return-Path: <linux-pci+bounces-14355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C12199B104
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 07:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D353A1F22F4A
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 05:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8F331A60;
	Sat, 12 Oct 2024 05:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx2ZrkbJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B641F5FA;
	Sat, 12 Oct 2024 05:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728709589; cv=none; b=gJhIFLrZ6Z3UFBflMvrf4lR5UJlV0tIRNkHEk3nmPhOdqgK0PnJd0qHALT86WLYjFIEChCjqx1GUvjKvdbEqTlEfn1D7JSdsvRNWadbBOTeoBkb+Dyt36qutlbqEdcdAUGnArxSQce4b3uc/yFUDE8CW6Ch8Kdj+iEehlvIyHZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728709589; c=relaxed/simple;
	bh=s70t+eSEc0ePHXCRkOzgi/KsljvHLiLNgDdPbL/ufP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HbzfIZkBf1F/EWG35tEJnQ8PMTJRHSNVypU53RCKyyrrhUDkNzE88FAY3+DvSWIiMxDfLemFJGyxP0DmMh2J+eo6Pqw+3ANCrQ7HRKnEOCwJPCTb4tnGiVATYELusW3IK9OkX8md3HzjNQndNCIdk+0GBXctJ7gGXHlWYRa6g98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rx2ZrkbJ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71df2b0a2f7so2363322b3a.3;
        Fri, 11 Oct 2024 22:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728709586; x=1729314386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yrMwgAq1e1++de4Zz3jYukz8cz/GmaA5v1778Sh7EeI=;
        b=Rx2ZrkbJTxA9oICBCGfQpdDS2dXrQ1dX8utW6grBYLyS4wL8I+8UQpD74Wyxnsoxfd
         pNGW6pnZov4iyAImS3W2VyAgu9tn33SZ/N/E2QV7qCx2RNPJDtINz2NACyLtIdEgxohf
         8S2gBx3gwdZ1+NjHJpgLA5XxMudK4Y55s8rsoxjU8ny+s4lgTuIye9zCGH78Q2DKvfZy
         NJzYjcH4SWGxjPezyczg876qU8wjNmsiSMOF512VstMmU/DhOiD+Yz7ge+3Din6R197Z
         6TrVLyUohVvM9yvFAebVf1pOsbbHUaTC8LbvrsncqF/zCaFVKT6XBNo2XEQjc7sI66+8
         /Pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728709586; x=1729314386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yrMwgAq1e1++de4Zz3jYukz8cz/GmaA5v1778Sh7EeI=;
        b=S2wEvqxwqiG5HGYp3z6AdSsQp85zxFvhDX+n6r4oMK6sjFSS4elQBlEmwIn8cS/2em
         zqGG915mfsHXit84R3xVOzPy+U3MqRXzA0f4e2IKky1KCyTglpRvSNz0qbNrb/yLwadH
         EAUc/Y4dZfHxD7jnu/f2I1u/vpkvdzREoH98LAWMA+abc6JZRi8ijdCzoRe5Ll67OAT8
         MAqPJ4Egp6ncm1AlQ3+iAWo6qywn8QULjutuFtpvgSOrtcyzKBw4dChytaNZ3QM4x7as
         kLVmaPe3e+i7oGatzk9ZoNzAv6wpp4Z/FnmlPB4x/GB3fH6w0GNi9DCqjObk8BVxkQoz
         T8Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUDGktBT+SH35ui/TV2knEHzs2ejnMI0XURzdqQ5VHor6VK2wVThUT4b+TCmKL0h6f3HrwKgRQK6CsadCk=@vger.kernel.org, AJvYcCXqr3CMiDEFGsQ+H1JjaG52s6iarhdSt/MWcDxEC8lugwXese620Nscipe8SOQSyKE8cwzdHRnLH1GN@vger.kernel.org
X-Gm-Message-State: AOJu0YwEpp0cOG1w62wde8KUZ30Kofhv4awLOUc+CZ5UUA4PznGGsylZ
	NTE8F5B71AGBarnurp7NCAxUlAY72FCpIWWbyfoRiV8dBrbbsagy
X-Google-Smtp-Source: AGHT+IF45l0QU4CAqS/7Bll3KH41T+leZDJyL2cSSYzvPDtV6bK37nxDLXTgJxAecdk2smkhcmrKSw==
X-Received: by 2002:a05:6a20:2450:b0:1d6:d330:2417 with SMTP id adf61e73a8af0-1d8bcfb27b6mr7532680637.40.1728709586432;
        Fri, 11 Oct 2024 22:06:26 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e4ad1b9f7sm859809b3a.190.2024.10.11.22.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 22:06:26 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pci@vger.kernel.org (open list:PCIE DRIVER FOR ROCKCHIP),
	linux-rockchip@lists.infradead.org (open list:PCIE DRIVER FOR ROCKCHIP),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v7 0/3] PCIe RK3399 clock and reset using new helper functions
Date: Sat, 12 Oct 2024 10:36:02 +0530
Message-ID: <20241012050611.1908-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following changes are used to reduce the code and used new
clk_bulk and reset_control_bulk helper functions.

Additional to the PCie core controller changes
added some new PHY changes to help improve and clean up
the code.

Made lots of silly mistakes.

Previous changes.
v6:
https://lore.kernel.org/r/20241006182445.3713-2-linux.amoon@gmail.com/
v5:
https://lore.kernel.org/all/20240901183221.240361-2-linux.amoon@gmail.com/
V4:
 https://lore.kernel.org/all/20240625104039.48311-1-linux.amoon@gmail.com/
V3:
 https://lore.kernel.org/all/20240622061845.3678-1-linux.amoon@gmail.com/
V2:
 https://lore.kernel.org/all/20240621064426.282048-1-linux.amoon@gmail.com/
V1:
 https://lore.kernel.org/all/20240618164133.223194-2-linux.amoon@gmail.com/

Thanks
-Anand

Anand Moon (3):
  PCI: rockchip: Simplify clock handling by using clk_bulk*() function
  PCI: rockchip: Simplify reset control handling by using
    reset_control_bulk*() function
  PCI: rockchip: Refactor rockchip_pcie_disable_clocks() function
    signature

 drivers/pci/controller/pcie-rockchip.c | 219 +++++--------------------
 drivers/pci/controller/pcie-rockchip.h |  35 ++--
 2 files changed, 61 insertions(+), 193 deletions(-)


base-commit: 09f6b0c8904bfaa1e0601bc102e1b6aa6de8c98f
-- 
2.44.0


