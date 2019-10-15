Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D873AD7975
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 17:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732897AbfJOPL5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 11:11:57 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:1607 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJOPL5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 11:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1571152316; x=1602688316;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u+I3dMwQI/KSkSqrBp+39zdAeGJeYw2xPhZwcNW/iQ0=;
  b=F9isxWb6BoFggK6g9Y3Sq9OwaTgFOKl5A1rBYgYgOLqZ+h04/5Nl/v5I
   kycdlhSdGDWaYnEHQvUkJlOw56w6VVchBYFeBXUKx/cQisifysQZTzxXJ
   tzifOvlPTZ1S7VYbBkeghVVL/5m6vu4q73UMNgaC8V+dplj5VTiF+Z84q
   U=;
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="793097327"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 15 Oct 2019 15:11:55 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id 86ABDA182D;
        Tue, 15 Oct 2019 15:11:54 +0000 (UTC)
Received: from EX13D13EUA004.ant.amazon.com (10.43.165.22) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 15 Oct 2019 15:11:53 +0000
Received: from localhost (10.43.160.180) by EX13D13EUA004.ant.amazon.com
 (10.43.165.22) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 15 Oct
 2019 15:11:51 +0000
From:   Yuri Volchkov <volchkov@amazon.de>
To:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     <joro@8bytes.org>, <bhelgaas@google.com>, <dwmw2@infradead.org>,
        <neugebar@amazon.co.uk>, Yuri Volchkov <volchkov@amazon.de>
Subject: [PATCH 0/2] iommu/dmar: expose fault counters via sysfs
Date:   Tue, 15 Oct 2019 17:11:10 +0200
Message-ID: <20191015151112.17225-1-volchkov@amazon.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Originating-IP: [10.43.160.180]
X-ClientProxiedBy: EX13D13UWA004.ant.amazon.com (10.43.160.251) To
 EX13D13EUA004.ant.amazon.com (10.43.165.22)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For health monitoring, it can be useful to know if iommu is behaving as
expected. DMAR faults can be an indicator that a device:
 - has been misconfigured, or
 - has experienced a hardware hiccup and replacement should
   be considered, or
 - has been issuing faults due to malicious activity

Currently the only way to check if there were any DMAR faults on the
host is to scan the dmesg output. However this approach is not very
elegant. The information we are looking for can be wrapped out of the
buffer, or masked (since it is a rate-limited print) by another
device.

The series adds counters for DMAR faults and exposes them via sysfs.

Yuri Volchkov (2):
  iommu/dmar: collect fault statistics
  iommu/dmar: catch early fault occurrences

 drivers/iommu/dmar.c        | 182 ++++++++++++++++++++++++++++++++----
 drivers/iommu/intel-iommu.c |   1 +
 drivers/pci/pci-sysfs.c     |  20 ++++
 include/linux/intel-iommu.h |   4 +
 include/linux/pci.h         |  11 +++
 5 files changed, 201 insertions(+), 17 deletions(-)

-- 
2.23.0




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Ralf Herbrich
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



