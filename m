Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4C4297E8F
	for <lists+linux-pci@lfdr.de>; Sat, 24 Oct 2020 22:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764539AbgJXU4T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Oct 2020 16:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764536AbgJXU4T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Oct 2020 16:56:19 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6391BC0613CE
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2020 13:56:03 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i2so5472947ljg.4
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2020 13:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZT+5FZe1JJratYtVvddwvaIyTNrCamHP4CwNxkpWBg=;
        b=kksQsO+YLUDQhdI6/GTYGjAMlsX+XhJmP9nmjr55rRr8wFUGaT8J6R29s3rLdnoX0Y
         Leijw7ntpumAcSwf+O+jEqqIa9ESP9ZhUgEHUtMsJS1H58uuhhtvEyLULSeLAB9wCNCL
         zgsEwiqk+vzNcRtB5SRvpl4IXUbRFYTzXXoyQMBy6dj9qGsJjR6D4ngiuo77wWtFHZar
         O73LHWPOReO070ZqnEBjiiXt4e2rj8+u8T0pgK8fuN1iTx3E3VwoaPbzYPuonX8xGxtL
         pNVCfe4NRb0Y9JTHG144WaFdMHauoDVaKuT0+vvTk9U2DWKOhkZ6/qdGOztPJ0L/TOU1
         6voQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZT+5FZe1JJratYtVvddwvaIyTNrCamHP4CwNxkpWBg=;
        b=ebJvZqcnxnGr/B2WLY5ZDYoLJjS4pqa7gsCOjkLt+j3C4PoM03HsFJaVVEr1N7QEsY
         WRqWfAzB/z/AOouusMWiFd75uUCFrxe2zlcJMolhtNmUMPU6TY4W/8+2Tr8FjmicntPi
         sq/yV6vDkYX9J+fKl6MsDz8qNf643AFvWWXZkVTibsQNJtigPuR8M8QPbGaoo/Z1EDpX
         UZYkprN2thPlgCt0wSxChC1IWkuQ++yUkW8ZSNLSPdCRmbfhSC6tHtjW0yHN2s1vKrkl
         AcMScxnd4lxKwFHAVZsIqc2EfGLVyhZ7rZmj5DypXsJ3Zd/4UeKni2DT6mVDB7vdiq/y
         CtmQ==
X-Gm-Message-State: AOAM531Vzj6+REpsmvkPpsPsjqTK1hzQg4pFHlXsLO6ns2HsN7hFAkRe
        bK0UsIp5sw2RIieWCWKjuZ4=
X-Google-Smtp-Source: ABdhPJzViab6/TRRJFUoCbURv6LeDvTlYJVhQGMCpzlZ+mt7l/aOfLSN/JWNCSlg0iJ/CIWO7AzAcQ==
X-Received: by 2002:a2e:9905:: with SMTP id v5mr2965374lji.222.1603572961852;
        Sat, 24 Oct 2020 13:56:01 -0700 (PDT)
Received: from octa.pomac.com (c-f9c8225c.013-195-6c756e10.bbcust.telenor.se. [92.34.200.249])
        by smtp.gmail.com with ESMTPSA id f26sm246815lfc.302.2020.10.24.13.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 13:56:01 -0700 (PDT)
From:   Ian Kumlien <ian.kumlien@gmail.com>
To:     kai.heng.feng@canonical.com, linux-pci@vger.kernel.org,
        alexander.duyck@gmail.com, refactormyself@gmail.com,
        puranjay12@gmail.com
Cc:     Ian Kumlien <ian.kumlien@gmail.com>
Subject: [PATCH 3/3] [RFC] PCI/ASPM: Print L1/L0s latency messages per endpoint
Date:   Sat, 24 Oct 2020 22:55:48 +0200
Message-Id: <20201024205548.1837770-3-ian.kumlien@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201024205548.1837770-1-ian.kumlien@gmail.com>
References: <20201022183030.GA513862@bjorn-Precision-5520>
 <20201024205548.1837770-1-ian.kumlien@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Print information on where along the path we disable L1 or L0s per
endpoint. I think the infromation could be useful in the normal dmesg.

Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
---
 drivers/pci/pcie/aspm.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index dbe3ce60c1ff..8bec24119f3e 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -436,6 +436,7 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
 	u32 latency, l1_max_latency = 0, l1_switch_latency = 0,
 		l0s_latency_up = 0, l0s_latency_dw = 0;
+	bool aspm_disable = 0;
 	struct aspm_latency *acceptable;
 	struct pcie_link_state *link;
 
@@ -447,19 +448,35 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 	link = endpoint->bus->self->link_state;
 	acceptable = &link->acceptable[PCI_FUNC(endpoint->devfn)];
 
+#define aspm_info(device, type, down, up) \
+	if (!aspm_disable) \
+	{ \
+		pr_cont("pci %s: ASPM latency exceeded, disabling: %s:%s-%s", \
+			pci_name(device), type, pci_name(down), pci_name(up)); \
+		aspm_disable = 1; \
+	} \
+	else \
+		pr_cont(", %s:%s-%s", type, pci_name(down), pci_name(up));
+
 	while (link) {
 		/* Check upstream direction L0s latency */
 		if (link->aspm_capable & ASPM_STATE_L0S_UP) {
 			l0s_latency_up += link->latency_up.l0s;
 			if (l0s_latency_up > acceptable->l0s)
+			{
 				link->aspm_capable &= ~ASPM_STATE_L0S_UP;
+				aspm_info(endpoint, "L0s-up", link->downstream, link->pdev);
+			}
 		}
 
 		/* Check downstream direction L0s latency */
 		if (link->aspm_capable & ASPM_STATE_L0S_DW) {
 			l0s_latency_dw += link->latency_dw.l0s;
 			if (l0s_latency_dw > acceptable->l0s)
+			{
 				link->aspm_capable &= ~ASPM_STATE_L0S_DW;
+				aspm_info(endpoint, "L0s-dw", link->downstream, link->pdev);
+			}
 		}
 
 		/*
@@ -482,12 +499,18 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 			latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
 			l1_max_latency = max_t(u32, latency, l1_max_latency);
 			if (l1_max_latency + l1_switch_latency > acceptable->l1)
+			{
 				link->aspm_capable &= ~ASPM_STATE_L1;
+				aspm_info(endpoint, "L1", link->downstream, link->pdev);
+			}
 			l1_switch_latency += 1000;
 		}
 
 		link = link->parent;
 	}
+	if (aspm_disable)
+		pr_cont("\n");
+#undef aspm_info
 }
 
 /*
-- 
2.29.1

