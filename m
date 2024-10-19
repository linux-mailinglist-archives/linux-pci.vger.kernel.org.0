Return-Path: <linux-pci+bounces-14892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 196D09A4B71
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 08:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31151F22DF7
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 06:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15971D5AAD;
	Sat, 19 Oct 2024 06:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1Kkh/Lw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF9A28EF;
	Sat, 19 Oct 2024 06:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729317719; cv=none; b=uRSmWsczV0C80XmotKoi+R23WpdaYzYyRb7gABR60ed3j1FrVbw4B5FqsJzrz9LvN5oGYVRl4tOxWksP0uHrtTa9kt7cBty16N8T7afO9ThOLjqHP5W02Ma4GMNi/4SSL4TfDbcGQ/B9qrj0maXOYVVqKgQT+wLnkgfO+T2VNWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729317719; c=relaxed/simple;
	bh=E5ipzky63Qfsph9XD5HsPx3/qkDVWzP1L+99MG5jrdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MMfNkui5Wg2OnRrCED6wKkQqgAk5kNxSVPZJaOOtVbvP22MA8ALFlOvyIyQTwxbdUhCqzrIxyMhK2qVGRRPTIGP95lL+F8FARvx2brYZ/RCVpKzk2SScWCN7zcEmjwlZHmj42aeyP+djrmlqXM26optU3PELsJqybq1E8VuK7xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1Kkh/Lw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e580256c2so2117838b3a.3;
        Fri, 18 Oct 2024 23:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729317717; x=1729922517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gZ987UAA7uNYocGM5WXzbU2Nb0CraFouN1LG0xFXxL8=;
        b=E1Kkh/LwXl2JxBxGtcixZC4SVgansKZyljhPEO9alp1NBYs0JY0tAikR643GRBknRS
         Wm1Re0Gwmr6C/l5FVzDxf0vjBqfUtVXMe5QTnVibX0IjQMLLkYotCjMpbuLNPyzumAWX
         w3wm8+lPCjm7kRfO7m4Y5zcNuOralGF9RxKRNZCriSCOX1pTDikzQXbq0I+GhgPdSqEn
         O8hN0RiEOauX1Xj3QuaUa0PuoqQV1m8ZAFCv5J9gfxedaQWKnvcTErr441tgvq/WzV/Z
         ClRYyD+QBFhMnpXa19OQKcdtJLI4FpQ3H8fFfQruZlkTUuiFRuIFdl710m3/28BC1x1n
         1IyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729317717; x=1729922517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZ987UAA7uNYocGM5WXzbU2Nb0CraFouN1LG0xFXxL8=;
        b=fjQ9KUrp/xUDNji64gC1847xJ7np2rqD7LQj6HPAWAbxMTU8ChYvxXF+BQRdFMaiCv
         XWdMFBknW+Q8YF/7WkcHb/PKPL/PNCrAfeAj0Sv0IWGE1TcTlIUpWch2PcgfQ2tjvE14
         bTbnv2/wIl1oGEnigOa8ryvOMD8wRQ/6kfaKHFvv5xhBS3E5WeV+oojC+QpFxES/V/j7
         dp2j/7Uc5S4xJea/MjGm7J+hppZcU8aVQXgvPvk3sqZTKviVWbl11zOpuLDZkvx1dtMR
         oIzBSO1P2hy/aWqR5+Bc3p4GwDGGYQK7bakelicZpJWW1FuVROzCF2WyYXJvy7H9dXFl
         j7XA==
X-Forwarded-Encrypted: i=1; AJvYcCV9VYKLrEtbf/KOPsHkgxUWXAtSPS5u7aLb468vIfQbwf5m+YPZwMTP860RTVrExMF3gfXxon/UZi31P6I=@vger.kernel.org, AJvYcCX9PYbOL3KQ3EdJyY6rzCTnr9S0wozuiv3NV+RQtHkLsPq1PZL4bP9nqXsmUFugWO00kJ8zikhh+Tq2@vger.kernel.org
X-Gm-Message-State: AOJu0YzoOSszXaDvELj+cs5+6pZyizRvhpbx7/0wqGvpjiLA2HYjVrvC
	OT6ylg0h63q4IlUbrGaNl57JFeXCYLZXQnmhyWYVeix3K6XQkv68
X-Google-Smtp-Source: AGHT+IGBr1wUlGKENgW2T4qdlEsv0NXF+yy19a1hMzR1S5d2615oD133Gws0Qigxu6ZZ1tEpCgGzlg==
X-Received: by 2002:a05:6a00:2394:b0:71e:6bf1:158f with SMTP id d2e1a72fcca58-71ea330c5cbmr7219719b3a.21.1729317717099;
        Fri, 18 Oct 2024 23:01:57 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea333e94fsm2424237b3a.69.2024.10.18.23.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 23:01:56 -0700 (PDT)
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
Subject: [PATCH v10 0/3] PCIe RK3399 clock and reset using new helper functions
Date: Sat, 19 Oct 2024 11:31:32 +0530
Message-ID: <20241019060141.2489-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following changes are used to reduce the code and used new
clk_bulk()* API d reset_control_bulk()* API helper functions.

Additional to the PCie core controller changes
added some new PHY changes to help improve and clean up
the code.

Made lots of silly mistakes, will try to improve in the future.

Thanks
-Anand

Previous changes.
v9:
https://lore.kernel.org/all/20241016114915.2823-2-linux.amoon@gmail.com/
v8:
https://lore.kernel.org/r/20241014135210.224913-2-linux.amoon@gmail.com/
v7:
https://lore.kernel.org/all/20241012050611.1908-2-linux.amoon@gmail.com/
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

Anand Moon (3):
  PCI: rockchip: Simplify clock handling by using clk_bulk*() function
  PCI: rockchip: Simplify reset control handling by using
    reset_control_bulk*() function
  PCI: rockchip: Refactor rockchip_pcie_disable_clocks() function
    signature

 drivers/pci/controller/pcie-rockchip.c | 222 +++++--------------------
 drivers/pci/controller/pcie-rockchip.h |  35 ++--
 2 files changed, 60 insertions(+), 197 deletions(-)


base-commit: 3d5ad2d4eca337e80f38df77de89614aa5aaceb9
-- 
2.44.0


