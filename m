Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA91275DF49
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jul 2023 01:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjGVXZM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Jul 2023 19:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGVXZL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Jul 2023 19:25:11 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FD919AA
        for <linux-pci@vger.kernel.org>; Sat, 22 Jul 2023 16:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=nXTpEnvYxIqxyUt02yJGB4DzINGd6irEOWEcHV+28tU=; b=QAybGx3pV056eRBmpH9+6gI4Qp
        Pq2Z4DqbpP7g441/K+wyASFP/qAVZf2i+fX8bYgGAFa03hxW4HfqPeRmULR2Ez0Hk71Kqwk8I8wsa
        642JIu4FxGrLLoXgBHKgB5gSauzJlQYZGVq+N5WnBBGruakkxKPHqpRfaDpJ5orO5/oYAzwjfAWk3
        BWpWri8mWOw+AFV7atnJliO4taTUWeHR28vVBH4zXdDvbBE1fcmkjVdw3fqbW5/AymuKTcouVWXro
        TAIGMZvk0I4H7T2dM6t88mYCoZZofiuFYSCeEOCCut9nqelPVNw6WgpTfpuvV46aVOgKzDY4SvaZj
        6N5RLt2Q==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1qNLj2-0001HQ-6u; Sun, 23 Jul 2023 01:09:24 +0200
Received: from [136.25.87.181] (helo=lars-desktop.lan)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1qNLj1-000OAF-Hk; Sun, 23 Jul 2023 01:09:23 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org,
        mhi@lists.linux.dev, ntb@lists.linux.dev,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/5] PCI: endpoint: pci-epf-mhi: Constify pci_epf_ops and pci_epf_event_ops
Date:   Sat, 22 Jul 2023 16:08:45 -0700
Message-Id: <20230722230848.589428-2-lars@metafoo.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230722230848.589428-1-lars@metafoo.de>
References: <20230722230848.589428-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26977/Sat Jul 22 09:27:56 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Both the pci_epf_ops and pci_epf_evnt_ops structs for the PCI endpoint mhi
driver are never modified. Mark them as const so they can be placed in the
read-only section.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 9c1f5a154fbd..bb1c8e502a09 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -389,7 +389,7 @@ static void pci_epf_mhi_unbind(struct pci_epf *epf)
 	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, epf_bar);
 }
 
-static struct pci_epc_event_ops pci_epf_mhi_event_ops = {
+static const struct pci_epc_event_ops pci_epf_mhi_event_ops = {
 	.core_init = pci_epf_mhi_core_init,
 	.link_up = pci_epf_mhi_link_up,
 	.link_down = pci_epf_mhi_link_down,
@@ -428,7 +428,7 @@ static const struct pci_epf_device_id pci_epf_mhi_ids[] = {
 	{},
 };
 
-static struct pci_epf_ops pci_epf_mhi_ops = {
+static const struct pci_epf_ops pci_epf_mhi_ops = {
 	.unbind	= pci_epf_mhi_unbind,
 	.bind	= pci_epf_mhi_bind,
 };
-- 
2.39.2

