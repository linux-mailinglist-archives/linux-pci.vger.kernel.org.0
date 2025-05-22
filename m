Return-Path: <linux-pci+bounces-28306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ECFAC17E1
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 01:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6A0A45815
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 23:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DF82E62A1;
	Thu, 22 May 2025 23:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRTxT7w5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C023B2E62A3;
	Thu, 22 May 2025 23:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956255; cv=none; b=YZcpKCy/RQA6NQZXLgSgQNVgy1ogeBtQ1mK2PGCOQNt/844kI7M7Pik1jlQRdhaJbd5fGFHtx5PRFCuWZVALwHZC1SlM6YZumpwB0fYRu5zAfip1mz28mLnDoK+VUXDkEYMf6pX8yFTQvy9tW39MZ1PLa8JszTL3U7ZmlXOfZCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956255; c=relaxed/simple;
	bh=y7e9P3hEYVjb2rwfefX+/4+/9fyA9woYlogIdjnrYWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjUraQ0M/xlMSMUaK3Cpg60L/IXPf/F5JrSP9mZ8aUEWwLWOCcNCTz31fex4RCaWiEErO8QgzruULUeAsG5/fEBtfFmeMImIMnyB0S2RmR9WnCw6nCUUaDAW8ItE/8Wz7LmKUoYEQtw3v67KJr7HXdWYbXbbL+HB17ypOVQQ/3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRTxT7w5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CAF9C4CEEF;
	Thu, 22 May 2025 23:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747956254;
	bh=y7e9P3hEYVjb2rwfefX+/4+/9fyA9woYlogIdjnrYWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vRTxT7w5ShuM+U2ecxDsu8/xXhl5mZOvdjWYRV2H8si8LbPzsJoUftWYXxdNS27wp
	 +Ic3RyhnRXODUlHfylAMidD569hQ+GGYGjIyeeEtMlxpst51OgSBDvIEtgEeF2V82J
	 ontzSuYHEeAKvBaJqfA8A2I3hP2MBVp9qeVIbKPC26a/hkqL9X4zfYrrqQwKNmfdct
	 skZolLoqVSbZieVayTQj5Zb/kqzatohTnb99SNjle3UVkcWo7A1KUxHATiKeARQLlB
	 WjF224kN2hX/0ztPcQOpbj1Is1T1y0RjG457NlEjZEjvLUGVNx+61bFDYV1ljMPfYV
	 zA69skxAww3/A==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Weinan Liu <wnliu@google.com>,
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
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v8 19/20] PCI/AER: Add ratelimits to PCI AER Documentation
Date: Thu, 22 May 2025 18:21:25 -0500
Message-ID: <20250522232339.1525671-20-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522232339.1525671-1-helgaas@kernel.org>
References: <20250522232339.1525671-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jon Pan-Doh <pandoh@google.com>

Add ratelimits section for rationale and defaults.

[bhelgaas: note fatal errors are not ratelimited]

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20250520215047.1350603-17-helgaas@kernel.org
---
 Documentation/PCI/pcieaer-howto.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index f013f3b27c82..6fb31516fff1 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -85,6 +85,18 @@ In the example, 'Requester ID' means the ID of the device that sent
 the error message to the Root Port. Please refer to PCIe specs for other
 fields.
 
+AER Ratelimits
+--------------
+
+Since error messages can be generated for each transaction, we may see
+large volumes of errors reported. To prevent spammy devices from flooding
+the console/stalling execution, messages are throttled by device and error
+type (correctable vs. non-fatal uncorrectable).  Fatal errors, including
+DPC errors, are not ratelimited.
+
+AER uses the default ratelimit of DEFAULT_RATELIMIT_BURST (10 events) over
+DEFAULT_RATELIMIT_INTERVAL (5 seconds).
+
 AER Statistics / Counters
 -------------------------
 
-- 
2.43.0


