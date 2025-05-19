Return-Path: <linux-pci+bounces-28030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D948ABCA38
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 23:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EACCA3B3ACC
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 21:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31419225A3C;
	Mon, 19 May 2025 21:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0WtaEvg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DFE226D1F;
	Mon, 19 May 2025 21:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690635; cv=none; b=TgMW+6qVQ60SDWMBSiRKuw2etu6hrcWAYTGB/fn33FFL56wIk5Gv5dHK1o2CgoWGYMxJHae2cKOxGjmwn6/XAfRmmEPJOGAtflbnymi4dpDRdl54HwvRrHVAfMBDj67u7f1Wp6Q4ndPOkCr5FfaFSpqUprj3zi7lAM00BwmyV5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690635; c=relaxed/simple;
	bh=909bKlpGXpejs6alzRrtkNNoVbidxfjnR8RhC93JgX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLIh31DcR9TGqUQrZX+9r1zTFkM2zcJuJv7dAs6qkn+CfnVTbewC9drtI0IGPMs10uV/B0eI5XdkYc4v6PBKXUskRmA0n34vZlWQciyXPZGlIiBGaGbPW+8620EPY6BjYCry+z6FSk2gx/4CATddKqMqnJHMfaOS68wOg30yfbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0WtaEvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447FAC4CEE9;
	Mon, 19 May 2025 21:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747690634;
	bh=909bKlpGXpejs6alzRrtkNNoVbidxfjnR8RhC93JgX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N0WtaEvgXAzOSk9iDG8i/BZrjzO6AGUdr9aPPpLa2T8Ze5lwku1J0lo6iD8vdJcIy
	 beoRBdYA6S0glwT3cdvYmet34cpc5K0od22JQ0ScSeDnVipX1eYOoy4F/gv8RKi9Ui
	 3wAUHYsd6CGCc36udQz7WFL8Me+OvicF9x+5I7CQLfrE8ukBB7oqEN1EjH4uY5asSG
	 vQbCO8kxhiUNJZ7OwSpryzBcebvWZTu6O7sOWwxgWillMZwAjNURM+0TpG4HUIWiMo
	 Hueh7xZWZ0WBB47iYJWQnPKbmpdpOjoTLwDeKvg08CCfsHqhCSaeHIb/OckfveUeNQ
	 SXDn+SHgtYp0w==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v6 15/16] PCI/AER: Add ratelimits to PCI AER Documentation
Date: Mon, 19 May 2025 16:35:57 -0500
Message-ID: <20250519213603.1257897-16-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519213603.1257897-1-helgaas@kernel.org>
References: <20250519213603.1257897-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jon Pan-Doh <pandoh@google.com>

Add ratelimits section for rationale and defaults.

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/PCI/pcieaer-howto.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index f013f3b27c82..896d2a232a90 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -85,6 +85,17 @@ In the example, 'Requester ID' means the ID of the device that sent
 the error message to the Root Port. Please refer to PCIe specs for other
 fields.
 
+AER Ratelimits
+--------------
+
+Since error messages can be generated for each transaction, we may see
+large volumes of errors reported. To prevent spammy devices from flooding
+the console/stalling execution, messages are throttled by device and error
+type (correctable vs. uncorrectable).
+
+AER uses the default ratelimit of DEFAULT_RATELIMIT_BURST (10 events) over
+DEFAULT_RATELIMIT_INTERVAL (5 seconds).
+
 AER Statistics / Counters
 -------------------------
 
-- 
2.43.0


