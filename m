Return-Path: <linux-pci+bounces-13894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930D7992065
	for <lists+linux-pci@lfdr.de>; Sun,  6 Oct 2024 20:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B748281FCE
	for <lists+linux-pci@lfdr.de>; Sun,  6 Oct 2024 18:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2878282890;
	Sun,  6 Oct 2024 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1TvGD6y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6866320B;
	Sun,  6 Oct 2024 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728239103; cv=none; b=arcUQ6NblUCxmJlPKRacF2dOIuG53qlh/0HsAl9Jy2xdoGNf9fe3bYRvZVvaqCbl9vld+DVWc0lKb6N9qk/wEX2dkTlpml9OVgz/xpPcM/00UwC0K2CzG7QMpgp/wl6BPEZjFF2M7+fGSuAkifC/czjAghKDbzbqYC62njFrlzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728239103; c=relaxed/simple;
	bh=wV1HIDG93UPtf+8R6xlE7lEt87u6njfR98MjARMw0Es=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c4G14Dru0kU645Z86eDqJOWaye6X6Gb0yHPam2Hlar4PPW1PMrb1DFYly6xNxNruGrnjZ3OZ6b95tavkh1ifUHV0OCKd8ydfDHBkT9otMJGnwNazeH6zeeqtA1hL4+2LSidczRbCdODyJPxv1en3u5u1zlEJrHDrfEeM/DKAw+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1TvGD6y; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so2452309a12.0;
        Sun, 06 Oct 2024 11:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728239101; x=1728843901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6LK0amb/aMznsCxMIWGk8usigwtRwvEg2RbDRthic78=;
        b=C1TvGD6y7pqcfizaI+V+Puc3AGarlwhKYOt5UruMCSkovVSDxiihZLIbPq1NpEefuY
         y4S3iUCb/U9QydG+fRdWNRBHdstw4hep6NeMmc6cP0GQxrc5uzy8yw3JQhhMZZpuN6pB
         xdaY5tD5dBGRCD+uj8z82ydxT4oURf337IYCxrwPM3+o2jnvebpZyFTFVAbXUrpq246Q
         aa9kX9ELwL48311B/O756MXEpaCymzeZfWFdrKYgBGTsQB8bT3VNrcVGWmJZd0CLOwM3
         5IW5bAft12yElzGUlrOb1mnqrbJ5comf6CQYUW/iaMYTb3AzvRMe6QiVy/49o+kXIRzP
         C9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728239101; x=1728843901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6LK0amb/aMznsCxMIWGk8usigwtRwvEg2RbDRthic78=;
        b=oSbfXbunn8Jmv5zLSLQFqHw4x416BLm+vME2LTpuOIheUS46kkc+1Syq2y0QRTAUuO
         j4trK9AX3F1xztbpFTdD6XW6eMsKwgqlkeG9bWN1diTv4W2A+Gv6HuqkukU9iQtmBSv1
         o80astFdknytlqJPLTBTZs9qPeaoTUCw4xZRMAkL2irSk6v4reVP02PFyIWK06Sb++v6
         ME/PL7NWwQM1OPHil8fc2DGUdAdK8LPEYY6GoI5peCq4jEEnpcFmomJkS175xv1aBC4E
         ps4ewb3lHYrEj6zocjmhq2k0128uZRdDNMY8QLlpy4hxz79k8HuMfxQ4tkIbedqCAadu
         XFnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO7af6K3WYp485r5i2iwkkzewuQAFlf7ORuJyab10tCAMsBjY6I8lyXFURrM9I153ArGQCHAgG4ZxxxN0=@vger.kernel.org, AJvYcCXizMOQZvCrWUClE1kR66xSjzGWjj4R4Ivbh91FaHXDcipX2lHjBR12YfGCBYE1EyuqpIslKmmx1jiO@vger.kernel.org
X-Gm-Message-State: AOJu0YxXhGgEe7vGjJqOGz3pf7pSvgYifLSzi4NjyV7qVrRz31rEho3H
	6v3gUjGehyy+BqNss4gsLoks6d0meeVZbGUA6qDyCDCO2BHOOQnB
X-Google-Smtp-Source: AGHT+IFC20s6cHCkGy6tRI0kTt7uHTaPUGYkqJz8dnYIqBo392XPXz6Qcbbzuayu74n+/YJHWq3QEw==
X-Received: by 2002:a17:90b:4c05:b0:2d8:f7e2:f03 with SMTP id 98e67ed59e1d1-2e1e631e1d7mr11153854a91.32.1728239101052;
        Sun, 06 Oct 2024 11:25:01 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85c905esm5458471a91.17.2024.10.06.11.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 11:25:00 -0700 (PDT)
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
Subject: [PATCH v6 RESET 0/3] PCIe RK3399 clock and reset using new helper functions
Date: Sun,  6 Oct 2024 23:54:35 +0530
Message-ID: <20241006182445.3713-1-linux.amoon@gmail.com>
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

Resend since last patch got missed.

Previous changes.
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

Thanks
-Anand

 drivers/pci/controller/pcie-rockchip.c | 219 +++++--------------------
 drivers/pci/controller/pcie-rockchip.h |  35 ++--
 2 files changed, 61 insertions(+), 193 deletions(-)


base-commit: 8f602276d3902642fdc3429b548d73c745446601
-- 
2.44.0


