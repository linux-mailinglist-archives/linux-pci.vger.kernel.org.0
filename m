Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 083F819389D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Mar 2020 07:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgCZGag (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Mar 2020 02:30:36 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:53467 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgCZGaf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Mar 2020 02:30:35 -0400
Received: by mail-wm1-f46.google.com with SMTP id b12so5247836wmj.3
        for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2020 23:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hlrOdL1KnO3xQYV3oaqWV4hvkH1Bg456h/MxyKV3WFw=;
        b=HIuuNOyHtZ8vE5PXUoCi3aenLXK4DeNW4eiiBfzzfo+MV39IWqeaU7iN9BXDWITohy
         hlCNW4duOj9Kp2v9EEfEUxtrd8ZWu5/bj4jcMJXLxXXrsXFUa+BpE0OItx0C+O+LZzN6
         ShDpzB9vzolBq4RofaFIUgVuzy6/HjeCci95c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hlrOdL1KnO3xQYV3oaqWV4hvkH1Bg456h/MxyKV3WFw=;
        b=r+xlGfA/ZvziCLkJOiC8n84upq5/Tmel/L7rhfml0MEosi81MrEojCAT45v+/6xPSl
         FgfdTcGTTSw4gbBTvVoq8AM6T+NGUtfGOigJ1ng4DYhPYZw6rbDJ/S64VnWArMMUtxdA
         VxeBPY1TNwOU2HMADvAV8+0/8IQU0dBoy83bDh1iQC5vaFeNTrSPLIiAkACHYvld79/8
         jO2s2oeT9b/Oil511k17UrLhlnm/St2bpXB4NPKpsW1040S+M6Gvxlagw9ZOiAvqndZa
         dtBLg08oU41XpjVP32oFtEbqIA9qclR/djZm/EpoxgKWsOSWT6XFx4qN6Cn69aphXBGo
         5nTQ==
X-Gm-Message-State: ANhLgQ3Njd8rdBiCLXLhnTYyQS9pg/F9OAaIL0ZDripYe/gixRpsnlqE
        Xpb4hH3QJJJwyryk2ok8wUf9U7Gy/+7r1IwXQ0kSAsrZFVCxm74l3exnzd4xmsfO2X8ef2msKBx
        Rpb0o284kG2m0qWvhPrVEKEqj2iXteeUbjTHU5h4elBwInDb8j7drCkxlpxSf5t/219e9/lyhV2
        EzRhZ+ggy4
X-Google-Smtp-Source: ADFU+vvOcwwRoJQy9AG39pNs4o3qyDriNCdEwAcfsgMPLvxYqbzuKTHbgcb95QVV2MxWH+4JfavfuA==
X-Received: by 2002:a05:600c:cc:: with SMTP id u12mr1443982wmm.60.1585204233385;
        Wed, 25 Mar 2020 23:30:33 -0700 (PDT)
Received: from lxpurley1.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 9sm2041731wmm.6.2020.03.25.23.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 23:30:32 -0700 (PDT)
From:   Vasundhara Volam <vasundhara-v.volam@broadcom.com>
To:     linux-pci@vger.kernel.org, davem@davemloft.net
Cc:     netdev@vger.kernel.org,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>
Subject: [PATCH v2 net-next 5/7] PCI: Add new PCI_VPD_RO_KEYWORD_SERIALNO macro
Date:   Thu, 26 Mar 2020 11:58:39 +0530
Message-Id: <1585204119-10371-1-git-send-email-vasundhara-v.volam@broadcom.com>
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

