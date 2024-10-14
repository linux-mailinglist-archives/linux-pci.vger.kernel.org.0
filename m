Return-Path: <linux-pci+bounces-14474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561AB99CBE1
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 15:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B9C283B6A
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 13:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FCA18638;
	Mon, 14 Oct 2024 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6lvXUQI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9914A24;
	Mon, 14 Oct 2024 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728913947; cv=none; b=hqbOm9p/JkO1Cr4tOFaGH8OgXtGfT/sxP9ZD4FzFrIy6eJrBwl9YwCxwRCS3U4pbOqJLCvIeII93nhafirmahXXn3MEwj205agER3uK9awRsiO8WuhioGGqTqIbEY33XJlpbWZglyclZ5oXKq4HLR4zwMfMCm5AgkDeW0gNU2zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728913947; c=relaxed/simple;
	bh=3CJtddor8kAQcEyzr0jmju5ajzdiZarXzV5DPnZaSiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g3fK3mDCPk5ERriPikZ42iE3aYbvChjNVOI5GHmiOeEXtRlXhW4+hzeE0bFNwP32ZRiEo7+4ibAEdgOSjyELGsgCJnwc2JgM28PAI8Eh5mME6E3J21lGQWW1NCJhb/iWGT6o25D6TpU+sS0Z5JLsVniiNkevTdiJjTwaCYI1Jz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6lvXUQI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cbca51687so17731865ad.1;
        Mon, 14 Oct 2024 06:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728913945; x=1729518745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4mEet+VxNwfbUuCPrGHnyzyOobmPKfSoDJ8KD89KQIo=;
        b=E6lvXUQI+wfJMJOPRqfg0HL/FTrwYj0NdgI62ZggtduWWc0SCszckntx9d62/93j0i
         erUHQmNRnykoXbRTmk5sA6BDbRGK9ZeXQfIb5eabZmWa0dhqJjyogtm8+ToG3T2nPPXI
         N2sdFL0Z3jQmnLenttMWg+N4tUgURC75w8MumJvQUY3G7kSTpY7DVMMt3Qe+7UP8AIAD
         ba6P9tZsfw2nfoxvGI17E/rEMaExbZOn0bDoJ+J+K7T5HBz0AoPDJRu2u1NS0Tezs5sK
         YgbeJNN2Iw8gD5BmYKZIZAe6mUOYLKOlrTkjfLjCqINEap0Jr/Y2YcNC23sUlQsgzhGv
         rCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728913945; x=1729518745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mEet+VxNwfbUuCPrGHnyzyOobmPKfSoDJ8KD89KQIo=;
        b=RH5WcfGxJYLBmN1PhzIl2vH9a/IJqqbvLh4W0qftjlFEb6wiybFz+lKEchBwz5HSPt
         gRhVM0SZR7rdDBhRJ1jevBJ7k89Frow8V0n1JLydhx80Jaahdwjs/Hpf7tCj4uGvhaYL
         TzLw3AefiBMNCmeP8dMEz+hTYZOwheWtHGZZa84jo7uFyAWCFijzSIg4Q8usmbeY7Wfd
         z+/CGTJ0uaIidGEuysp/NV4wmgF146F2Jv5oFtPIwC4JZYc4LrjQeKHcziWxJBpULs3R
         5T3NESbBUIelzLOoF+Va4ECk63jPiLbL/oj6dtjXx1BvfdN+YblY3qXY7xnRAfa2UZWw
         flBg==
X-Forwarded-Encrypted: i=1; AJvYcCUwghuofTXT54bpJrYi7Jd8+7NS8tbbs2LNuyikCY2SG60MZFaObSS5SyCTtSZCv8d6gcbF+Am89pShIyA=@vger.kernel.org, AJvYcCV5yaJe7n60jAJdFSkPw7ezFCZ7a3MC9eVPGcXykl8m9kZ51f8JsbmrHHuD4qLmZ8fjDZJlXZLIriat@vger.kernel.org
X-Gm-Message-State: AOJu0YyUGFj6f1jZollql4UwKz30sTSuuhGl4csXAK1J3kaGrELVoSFb
	dBcjB8+FG5n4pK6GXAYpUOLq7SektM9WfSlMwel7nP2IochFl+Qbj43Ibw==
X-Google-Smtp-Source: AGHT+IFSkC4chkVqozNqzmopyEX8/RuItKUwhS/QRqadp/zTqqldezvzhK0XtlNQSDIdQ+EpPjg3zQ==
X-Received: by 2002:a17:902:f68b:b0:20c:85db:fb6e with SMTP id d9443c01a7336-20cbb1a9689mr105050535ad.8.1728913945161;
        Mon, 14 Oct 2024 06:52:25 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0e74d6sm66469135ad.166.2024.10.14.06.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:52:24 -0700 (PDT)
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
Subject: [PATCH v8 0/3] PCIe RK3399 clock and reset using new helper functions
Date: Mon, 14 Oct 2024 19:22:01 +0530
Message-ID: <20241014135210.224913-1-linux.amoon@gmail.com>
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

Made lots of silly mistakes, will try to improve in the futuree.

Thanks
-Anand

Previous changes.
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

 drivers/pci/controller/pcie-rockchip.c | 223 +++++--------------------
 drivers/pci/controller/pcie-rockchip.h |  35 ++--
 2 files changed, 61 insertions(+), 197 deletions(-)


base-commit: 6485cf5ea253d40d507cd71253c9568c5470cd27
-- 
2.44.0


