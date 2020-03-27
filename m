Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8DB19542B
	for <lists+linux-pci@lfdr.de>; Fri, 27 Mar 2020 10:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgC0JhY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Mar 2020 05:37:24 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:55402 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbgC0JhX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Mar 2020 05:37:23 -0400
Received: by mail-wm1-f49.google.com with SMTP id z5so10689394wml.5
        for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2020 02:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hlrOdL1KnO3xQYV3oaqWV4hvkH1Bg456h/MxyKV3WFw=;
        b=AXAQWqDQYNqaDWIB7CeKYUxw7hETFRXiqsTm5GB6QuYNBPcelQSsGJHp5Mo0Yzih1c
         lrlAc3KiLzp3YkpOC6c3Mz/9hoEhRlL5pdmKXHqAwue6fV/58S6mEPvZud5Hpbj+OVrL
         PXAq1h2zG9WxnOaZBbuLpJxycu836WvG3jPT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hlrOdL1KnO3xQYV3oaqWV4hvkH1Bg456h/MxyKV3WFw=;
        b=IprsUrWocvG6T3HoreENWa1zL/ourujQVcpuRvDFQqbZhYvpkgrCArKzxaPWsEUJUI
         Ua7hC3DeCPcZWp83NQND8zR8C9XESkAru4aUAHnplI6aJcDiDlOJdmAxYFowwKvkuuUx
         tMXMR/Aw2qdIcwWAXPUejHg8yyf33bMc8EZNBL90euwS5/nguNTJbsnMGus4Cu06LMgO
         gKYChngLSnJL7/OFoKz8ZHJ8ZqxiRdMoS+4wfTzfG1aaHGoQZKc06+ZhnCO4Uq5Z2Uiz
         b+wL+joQWqIr0uLCnUdRnDFPeVwmFPg9zJT5gUHof1imblTrgJjhuJq64UKJihlwbrhE
         7oxQ==
X-Gm-Message-State: ANhLgQ2BJ9cg1E/w3AOzexKpNx3tqp2yCim4BpNo3/pRxhm35t401nVo
        RFO86TUqw2xySvnp4XjFcenSPbZAiSX8hUV/vnmvf7iHspqDu13zWvEXOR2EaLjKsSNr5a2RThU
        /WFaydAuXs1ltyReZwVOOyUZpRETtMKIcOT7BAE7FhNkcLrXpb/pKO5kxE5nOyIOu73+YFaLarj
        xZRXV3i0Zm
X-Google-Smtp-Source: ADFU+vv4F5R+JWGZ1eIAV+JFzPo2e5u1Lqpct/x33oPVKbpnLmrECscGOG3PCYUbJ81mLewUU0adqQ==
X-Received: by 2002:a1c:4684:: with SMTP id t126mr4328407wma.128.1585301841143;
        Fri, 27 Mar 2020 02:37:21 -0700 (PDT)
Received: from lxpurley1.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id b82sm7246600wmb.46.2020.03.27.02.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2020 02:37:20 -0700 (PDT)
From:   Vasundhara Volam <vasundhara-v.volam@broadcom.com>
To:     linux-pci@vger.kernel.org, davem@davemloft.net
Cc:     netdev@vger.kernel.org,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>
Subject: [PATCH v4 net-next 3/6] PCI: Add new PCI_VPD_RO_KEYWORD_SERIALNO macro
Date:   Fri, 27 Mar 2020 15:05:32 +0530
Message-Id: <1585301732-26004-1-git-send-email-vasundhara-v.volam@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds a new macro for serial number keyword.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 include/linux/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index fc54b89..a048fba 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2184,6 +2184,7 @@ bool pci_acs_path_enabled(struct pci_dev *start,
 #define PCI_VPD_INFO_FLD_HDR_SIZE	3
 
 #define PCI_VPD_RO_KEYWORD_PARTNO	"PN"
+#define PCI_VPD_RO_KEYWORD_SERIALNO	"SN"
 #define PCI_VPD_RO_KEYWORD_MFR_ID	"MN"
 #define PCI_VPD_RO_KEYWORD_VENDOR0	"V0"
 #define PCI_VPD_RO_KEYWORD_CHKSUM	"RV"
-- 
1.8.3.1

