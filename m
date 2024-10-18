Return-Path: <linux-pci+bounces-14852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F85A9A3D51
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 13:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD76A1F213D1
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 11:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEABF2F46;
	Fri, 18 Oct 2024 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="NszY1Dst"
X-Original-To: linux-pci@vger.kernel.org
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E541878;
	Fri, 18 Oct 2024 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729251123; cv=none; b=gD/XS7yf7qeWUwV2CQDjewUntljwhlmPFr0riaPG72EwoYNXkvVfsNIiwTrTabOaPh72bQMTFPhAw37WM252OMgX1AtkgayfN1rOBqyIJa+dh4SpIpG53mNkBwQ3ozdCUe29dcBwhXZetZivM/glo69TYtQ49D7ilx/ixufUEGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729251123; c=relaxed/simple;
	bh=8ems0K1QyHygi1SqtXgmSrGquVuuN6HMjhVTmKZFanY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nN3kpJZEN33AqIZaoXmPOS9L2EkA1WIqOZ3qoJEsVi58POeKdpJA7bZ/wW/R0lz7oMvH2Aotj0SekqhybFj0DE7DjtL1CJzpjAqEdIbSlqkJF5qipWDFcLDaFGmOJbYoUWncUk1yz+dZjLP5YrCA5Euxa164FJLEnZRvANugDRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=NszY1Dst; arc=none smtp.client-ip=173.37.142.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=926; q=dns/txt; s=iport;
  t=1729251121; x=1730460721;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3DA0NWcgl24vVYnTdhXW/PVgT6zdj6KdLX9kyr/pEYA=;
  b=NszY1DstJecfkuB5U49ltA9HR+58ifXCYMUVe98hg5PQ57O5G2uTJfWp
   ZnwUfL2flUCmp7bxW61sIQkdV4yGfoyvBTxTVnOo22IGzIa7UaL8FphjG
   MLpXDC8vaBp09zANANv4SwE7+ahuxclF/McBdzE9tINNl87lcuAV9yPV/
   I=;
X-CSE-ConnectionGUID: rgs88DQdSViD62vmV7vgqg==
X-CSE-MsgGUID: v9Bi5zXRQ1yrQEL6Ecj8aQ==
X-IPAS-Result: =?us-ascii?q?A0AZAACDRhJngY0QJK1aHAEBAQEBAQcBARIBAQQEAQGBe?=
 =?us-ascii?q?wcBAQsBhBlDSIxylUaSIoElA1YPAQEBD0QEAQGFB4olAiY0CQ4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBDQEBBQEBAQIBBwUUAQE9BQ47hgiGXSsLAUYpYzEBEoMBg?=
 =?us-ascii?q?mUDr0CBeTOBAd4zgWwYgTABjUWFZycbgUlEglCBPm+ECoZ9BIdojC2CE1cPg?=
 =?us-ascii?q?laEC4likT9IgSEDWSECEQFVEw0KCwkFiTWDAAUhBCWBa4EIFoJygkwCgleBZ?=
 =?us-ascii?q?wlhhDqCO3BigQctgRGBHzpHgTyBNi8bIQtegUOBMAYVBIEbgQaCT2pONwINA?=
 =?us-ascii?q?jeCJCRcglGGBUADCxgNSBEsNQYOGwY+bgesUUaCXHsTyRWEJKE/GjOqSwGYd?=
 =?us-ascii?q?yKkGIRmgWc6gVtwFYMiUhkPjlmTAAG3fUYyOwIHCwEBAwmMHoF9AQE?=
IronPort-Data: A9a23:wOoGAaw90NN0lwCqKK96t+fMxirEfRIJ4+MujC+fZmUNrF6WrkVVm
 2YcXmvUM/bcZDT2fNt/aYm08xwHvpfUz9ZhTwI+/FhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlpCCKa/FH1a+iJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 IqaT/H3Ygf/h2csazJMt8pvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJFs5Jt1I1t97Ol9P2
 aJCNjUzMQ6Mnu3jldpXSsE07igiBMDvOIVavjRryivUSK56B5vCWK7No9Rf2V/chOgXQq2YP
 JRfMGQpNUiZC/FMEg9/5JYWlvihmWPtYjtwo1OOrq1x6G/WpOB0+OOzYIWOJ4DVG625mG6G9
 0jHonbJOChDJcam5B7b33mu1ub2yHaTtIU6T+DgqaUw3zV/3Fc7Ah0bUVSyqOKRhUm5VNZSb
 UcT/0IGqbAz+VaiStjmXjW7rWSCsxpaXMBfe8Ug7wuN4qnZ+QCUAi4DVDEpQNkvss4oTDos3
 1nPhNrlBTV0saOcTFqZ97GdtzT0PjIaRUcBegcATA0Y85/op4RbphbOSMtzVa24lNv4HRnuz
 D2Q6isznbMeiYgMzarT1VTGhS+844DCTyYr6QjNGGGo9AV0YMiifYPA1LTAxf9EKIDcShyKu
 2IJ3pDCqusPFpqK0ieKRY3hAY1F+d6fPyaM0XJWE6If9hjzoWCmQ99O7yhxcRIB3tk/RRflZ
 0rauAV07ZBVPWe3YaIfX25XI5p3pUQHPYq5Ps04fuZzjo5NmBhrFRyChHJ8PUi2wCDAcolmZ
 f93lPpA615BVMyLKxLsF48gPUcDnHxW+I8qbcmTI+6b+bSffmWJbrwOLUGDaOs0hIvd/1+Eq
 ocHb5PUlUQEOAEbXsUx2dNDRbztBSVqba0aV+QNL4Zv3yI/Qjh4UK6LqV/fU9M9xf8L/gs3w
 p1NchQFkAWk3yKvxfSiYXF4Y7SnRodksX8+JmQtO13us0XPkq7xhJrzg6AfJOF9nMQ6lKYcZ
 6BcJ6297gFnEGWvF8I1N8il9NQKmdXCrV7mAhdJlxBvIc8xHlOYqo6Mk8mG3HBmMxdbfPAW+
 9WIvj43i7JaL+i+JK46sM6S8m4=
IronPort-HdrOrdr: A9a23:aCspAKH/qu+NZ1GppLqE6ceALOsnbusQ8zAXPo5KJiC9Ffbo8v
 xG88576faZslsssRIb6LK90de7IU80nKQdieJ6AV7IZmfbUQWTQL2KxLGSpwEIYxeOldK0Ec
 xbAs5D4BqaNykcsfrH
X-Talos-CUID: =?us-ascii?q?9a23=3AL3nCgGpZlgi4fe5Lv0is/YDmUdoqaS2N4E7cGHG?=
 =?us-ascii?q?5JTgzVrirFkGf4awxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AY2w6gA8qFmdmBrH3cm1CtdSQf9k5yaXzGnA3qMw?=
 =?us-ascii?q?XofCpEXJdMDXNhQ3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,213,1725321600"; 
   d="scan'208";a="368735476"
Received: from alln-l-core-04.cisco.com ([173.36.16.141])
  by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Oct 2024 11:30:53 +0000
Received: from sjc-ads-7158.cisco.com (sjc-ads-7158.cisco.com [10.30.217.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-04.cisco.com (Postfix) with ESMTPS id 60B26180001B2;
	Fri, 18 Oct 2024 11:30:50 +0000 (GMT)
Received: by sjc-ads-7158.cisco.com (Postfix, from userid 1776881)
	id D3019CC1280; Fri, 18 Oct 2024 04:30:49 -0700 (PDT)
From: Bartosz Wawrzyniak <bwawrzyn@cisco.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: xe-linux-external@cisco.com,
	Daniel Walker <danielwa@cisco.com>,
	Bartosz Stania <sbartosz@cisco.com>,
	Bartosz Wawrzyniak <bwawrzyn@cisco.com>
Subject: [PATCH] PCI: cadence: Lower severity of message when phy-names property is absent in DTS
Date: Fri, 18 Oct 2024 11:30:43 +0000
Message-Id: <20241018113045.2050295-1-bwawrzyn@cisco.com>
X-Mailer: git-send-email 2.28.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.30.217.233, sjc-ads-7158.cisco.com
X-Outbound-Node: alln-l-core-04.cisco.com

The phy-names property is optional, so the message indicating its absence
during the probe should be of 'info' severity rather than 'error' severity.

Signed-off-by: Bartosz Wawrzyniak <bwawrzyn@cisco.com>
---
 drivers/pci/controller/cadence/pcie-cadence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 4251fac5e310..88122d480432 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -197,7 +197,7 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 
 	phy_count = of_property_count_strings(np, "phy-names");
 	if (phy_count < 1) {
-		dev_err(dev, "no phy-names.  PHY will not be initialized\n");
+		dev_info(dev, "no phy-names.  PHY will not be initialized\n");
 		pcie->phy_count = 0;
 		return 0;
 	}
-- 
2.28.0


