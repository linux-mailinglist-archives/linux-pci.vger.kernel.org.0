Return-Path: <linux-pci+bounces-21054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DC7A2E5E7
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 08:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169193A5EC0
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 07:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5241BD9F2;
	Mon, 10 Feb 2025 07:58:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2313C1BBBF7;
	Mon, 10 Feb 2025 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739174305; cv=none; b=CalzTYIyQf3ZTGvuejKkWs7BpDBlD1XhZale2KsC9D+0xNXuX7LoOcdXjqQh73huneCAM6mHV1XV4+0N8GY+W0vpQ1qcdGCv2H9Er/4EyduEQYsBktqfzt9KCbEP7DLSK83Cpu6CQ3YJUcMw1lAw/jB4S++kSqE2Iaw0VNxEtHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739174305; c=relaxed/simple;
	bh=nHzQIpdsP4IcdpW1dt9ei1+itu2EKrYjxh/aM8W5BSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H+Serw1uDluvEz+AilGy2rca1f+pblzOwcTPj5oEt28QIp3xDFA91AIBfzDdh4H+VyhkJXeNOetiWTjOQqAr9xPT9fm4KqUREkEa072tsGRmdGnGFlI+zYJfSnNlTU/xGQqdnLTVH14BnKKKHukHNHK2huaI9xQXMbWsSBVt3kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 10 Feb 2025 16:58:21 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 9F64320090C1;
	Mon, 10 Feb 2025 16:58:21 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Mon, 10 Feb 2025 16:58:21 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 4BADC1CDD;
	Mon, 10 Feb 2025 16:58:21 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Wilczynski  <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/5] misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
Date: Mon, 10 Feb 2025 16:58:08 +0900
Message-Id: <20250210075812.3900646-2-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210075812.3900646-1-hayashi.kunihiko@socionext.com>
References: <20250210075812.3900646-1-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After devm_request_irq() fails with error in
pci_endpoint_test_request_irq(), pci_endpoint_test_free_irq_vectors() is
called assuming that all IRQs have been released.

However some requested IRQs remain unreleased, so there are still
/proc/irq/* entries remaining and we encounters WARN() with the following
message:

    remove_proc_entry: removing non-empty directory 'irq/30', leaking at
    least 'pci-endpoint-test.0'
    WARNING: CPU: 0 PID: 202 at fs/proc/generic.c:719 remove_proc_entry
    +0x190/0x19c

And show the call trace that led to this issue:

    [   12.050005] Call trace:
    [   12.051226]  remove_proc_entry+0x190/0x19c (P)
    [   12.053448]  unregister_irq_proc+0xd0/0x104
    [   12.055541]  free_desc+0x4c/0xd0
    [   12.057155]  irq_free_descs+0x68/0x90
    [   12.058984]  irq_domain_free_irqs+0x15c/0x1bc
    [   12.061161]  msi_domain_free_locked.part.0+0x184/0x1d4
    [   12.063728]  msi_domain_free_irqs_all_locked+0x64/0x8c
    [   12.066296]  pci_msi_teardown_msi_irqs+0x48/0x54
    [   12.068604]  pci_free_msi_irqs+0x18/0x38
    [   12.070564]  pci_free_irq_vectors+0x64/0x8c
    [   12.072654]  pci_endpoint_test_ioctl+0x870/0x1068
    [   12.075006]  __arm64_sys_ioctl+0xb0/0xe8
    [   12.076967]  invoke_syscall+0x48/0x110
    [   12.078841]  el0_svc_common.constprop.0+0x40/0xe8
    [   12.081192]  do_el0_svc+0x20/0x2c
    [   12.082848]  el0_svc+0x30/0xd0
    [   12.084376]  el0t_64_sync_handler+0x144/0x168
    [   12.086553]  el0t_64_sync+0x198/0x19c
    [   12.088383] ---[ end trace 0000000000000000 ]---

To solve this issue, set the number of remaining IRQs to test->num_irqs
and release IRQs in advance by calling pci_endpoint_test_release_irq().

Cc: stable@vger.kernel.org
Fixes: e03327122e2c ("pci_endpoint_test: Add 2 ioctl commands")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/misc/pci_endpoint_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index d5ac71a49386..bbcccd425700 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -259,6 +259,9 @@ static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 		break;
 	}
 
+	test->num_irqs = i;
+	pci_endpoint_test_release_irq(test);
+
 	return ret;
 }
 
-- 
2.25.1


