Return-Path: <linux-pci+bounces-34578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294BDB31D66
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 17:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657D6AA7193
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 14:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBB23126B6;
	Fri, 22 Aug 2025 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buEQ7sMt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85882ED16D;
	Fri, 22 Aug 2025 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874662; cv=none; b=Q9qd9tkNoUd3NK9q6pd0XxlQFkbotnX8gzN4a6k7xg+Lt3d/mdbpkNVYoUtTZF3yIF8tm3gfUc3ii1ySB4L4wrWBxhqn96vNzhE5M1Iu+8yx6DoOPmyce4DvwwwXP3pa12e4R/yyQj4Fh0T/tjpzM5pP9RNjj12vNERn846toG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874662; c=relaxed/simple;
	bh=F2R5lm6B0zlfTPYSGNsRRvyNW/8MTuBWGQgTQj1Brew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYaH2isDi79af8Of+dUUOgXQqXy3SuMz61oY7ajM48rpiq0NPpjXeIhWq4UeiEFPssr2WZq4Vv/dg0skDA11lmtaNgdJSCQRX9FVPiEejNDnOv+AuogfP6tELgnH5Ds29RcuGT1I9DpRmpT5e/IFbGnbmEQuw4WtmQvQix0Z86o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=buEQ7sMt; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755874660; x=1787410660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F2R5lm6B0zlfTPYSGNsRRvyNW/8MTuBWGQgTQj1Brew=;
  b=buEQ7sMtIV/r84bq81VEFcsJ7J2TTlMpMBQmGF4R+zvhiPVY/dCOYTJ0
   Tm72AlPmo0d4wjokc439/4DHA5jxuaH2EbTRhDoMxZgc3wPdU3iJo8ABf
   e1AnYWKp3dhOSnjONTh7q19PBmKqW0z1RQf2Mel2jNtN0vGIHIvMVYkSF
   wH26eUZvl6gZ6EjTN28zweDlg+d8jqSZF2+PJ7C8m0lXk6hWa+6fSk5r2
   EAtMY6wufAuwoUuHBrBOc+uenf1KZ3JI51FJFgCDYLbr9MRd3f+3jsSLP
   +j3sX5lEhD//AfuaagKMH/lodnj1ZrRXUcBrjJ51tPmpda1XBOjdmuQO9
   w==;
X-CSE-ConnectionGUID: PSCsNVHoShiTP/NO8DTxng==
X-CSE-MsgGUID: GXbMmo6PTV2vt9XNrZCuxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57201364"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="57201364"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:57:40 -0700
X-CSE-ConnectionGUID: dUvSFF9VS1qy+pJdy3UIkw==
X-CSE-MsgGUID: wzKVwqaETQWyVrIJW+JaKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168920509"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:57:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Andreas Larsson <andreas@gaisler.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-pci@vger.kernel.org,
	sparclinux@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Igor Mammedov <imammedo@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 09/24] PCI: Enable bridge even if bridge window fails to assign
Date: Fri, 22 Aug 2025 17:55:50 +0300
Message-Id: <20250822145605.18172-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
References: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A normal PCI bridge has multiple bridge windows and not all of them are
always required by devices underneath the bridge. If Root Port or
bridge does not have a device underneath, no bridge windows get
assigned. Yet, pci_enable_resources() is set to fail indiscriminantly
on any resource assignment failure if the resource is not known to be
optional.

In practice, the code in pci_enable_resources() is currently largely
dormant. The kernel sets resource flags to zero for any unused bridge
window and resets flags to zero in case of an resource assignment
failure, which short-circuits pci_enable_resources() because of this
check:

	if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
		continue;

However, an upcoming change to resource flags will alter how bridge
window flags resource flags behave activating these long dormants
checks in pci_enable_resources().

While complex logic could be built to selectively enable a bridge only
under some conditions, a few versions of such logic were tried during
development of this change and none of them worked satisfactorily.
Thus, I just gave up and decided to enable any bridge regardless of the
bridge windows as there seems to be no clear benefit from not enabling
it but a major downside as pcieport will not be probed for the bridge
if it's not enabled.

Therefore, change pci_enable_resources() to not check if bridge window
resources remain unassigned. Resource assignment failures are pretty
noisy already so there is no need to log that for bridge windows in
pci_enable_resources().

Ignoring bridge window failures hopefully prevents an obvious sources
of regressions when the upcoming change that no longer clears resource
flags for bridge windows is enacted. I've hit this problem even during
my own testing on multiple occassions so I expect it to be a quite
common problem.

This can always be revisited later if somebody thinks the enable check
for bridges is not strict enough, but expect a mind-boggling number of
regressions from such a change.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-res.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 0468c058b598..4e0e60256f04 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -527,22 +527,26 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
 		if (pci_resource_is_optional(dev, i))
 			continue;
 
-		if (r->flags & IORESOURCE_UNSET) {
-			pci_err(dev, "%s %pR: not assigned; can't enable device\n",
-				r_name, r);
-			return -EINVAL;
+		if (i < PCI_BRIDGE_RESOURCES) {
+			if (r->flags & IORESOURCE_UNSET) {
+				pci_err(dev, "%s %pR: not assigned; can't enable device\n",
+					r_name, r);
+				return -EINVAL;
+			}
+
+			if (!r->parent) {
+				pci_err(dev, "%s %pR: not claimed; can't enable device\n",
+					r_name, r);
+				return -EINVAL;
+			}
 		}
 
-		if (!r->parent) {
-			pci_err(dev, "%s %pR: not claimed; can't enable device\n",
-				r_name, r);
-			return -EINVAL;
+		if (r->parent) {
+			if (r->flags & IORESOURCE_IO)
+				cmd |= PCI_COMMAND_IO;
+			if (r->flags & IORESOURCE_MEM)
+				cmd |= PCI_COMMAND_MEMORY;
 		}
-
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
 	}
 
 	if (cmd != old_cmd) {
-- 
2.39.5


