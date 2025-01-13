Return-Path: <linux-pci+bounces-19695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B830A0C571
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 00:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 155987A3ACE
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 23:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E881FA82B;
	Mon, 13 Jan 2025 23:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJMk1SlK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5AE1FA26C;
	Mon, 13 Jan 2025 23:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736810167; cv=none; b=oLE4/ZWoCMQXCu6RszjRDoB7/yp45xXwn9/GdxUWA2HY8R7zu+ZiymTSanIEelJLn10exVN6d8pwPc5zONVsUR8LZI3cndzqD8IX30fRh01irw7JjoPMsnZs1PHj0SYl7qtYFjQoF/OX8t2xxHZ55Kc8QkhpSrc3tsw2az2cmSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736810167; c=relaxed/simple;
	bh=KOXOGe97ehqKsZKwVKNcpQJHClrkPCwZgqXe+REa9p0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fbgr69Pbq2iHA4tArx+ov67pelI75gEK09TlS9BuclFD9yfH3bQxDukAW0hbT0soynUMRZY5pSnAI2/+I2lQsLh0dlOVPS7Jv+cVKCshFQIEiizkUDZq6dxamMdvW+E9qneT1WmFnsT14XRQq1xZg2A29l7WSf9YU5vr39xr68I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJMk1SlK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8D1C4CED6;
	Mon, 13 Jan 2025 23:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736810166;
	bh=KOXOGe97ehqKsZKwVKNcpQJHClrkPCwZgqXe+REa9p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uJMk1SlK0p74odfX9wVVMd7Rlgj/T/RT5wX1KdH3wcz3w0BglMh49fiVCxXMPqlb2
	 ZcDJfy0iXjAhGJZAy3xGWYFOLr/rQkiiF1SPy1tyHn44fFSORfYjmMe1ca8NPRc9dk
	 GNpCMnbDbxBob+SOmMd1jn6RR3IwV50lo3VKtKxgXhSZlZ5ly0XlCejucsZF3lTA7y
	 uz8iZvQ7UWE45xx/45GJ/uWo2cnSgqZlOzXuH5PxggJwo/3Cc17LXcRGkNDfqbYMiN
	 YDMT1eOBJyqooOjpMglM21YUZ7rlKogyC1kZOXx2SHfE/8o2mR+TAMsme6JrNUG8fi
	 hDEjxvxovn3Fg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 2/4] PCI: of: Drop 'No bus range found' message
Date: Mon, 13 Jan 2025 17:15:55 -0600
Message-Id: <20250113231557.441289-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113231557.441289-1-helgaas@kernel.org>
References: <20250113231557.441289-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

The typical bus range for a host bridge is [bus 00-ff], and
devm_of_pci_get_host_bridge_resources() defaults to that unless DT contains
a "bus-range" property.

devm_of_pci_get_host_bridge_resources() previously emitted a message when
there was no "bus-range" property, but that seems unnecessary for this
common situation.  Remove the message.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/of.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 2f579b691f8e..48b9274b846e 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -346,8 +346,6 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
 		bus_range->start = busno;
 		bus_range->end = bus_max;
 		bus_range->flags = IORESOURCE_BUS;
-		dev_info(dev, "  No bus range found for %pOF, using %pR\n",
-			 dev_node, bus_range);
 	} else {
 		if (bus_range->end > bus_range->start + bus_max)
 			bus_range->end = bus_range->start + bus_max;
-- 
2.34.1


