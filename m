Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B2D1888F5
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 16:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgCQPS3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 11:18:29 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:54592 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbgCQPS1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2020 11:18:27 -0400
Received: by mail-wm1-f48.google.com with SMTP id n8so21883808wmc.4
        for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2020 08:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fWJS1K8DaSEgRDiDV9AcCT/035zEMfTydDERyKEuy2U=;
        b=ASL07buAWMPriX0XDeDS46CINBuUir50WGSStWMfXAQbWjzSEkdTQYlibx4Hmv9V+g
         xUnWSwcfolqkkSxPyx6fauKuCeI6I+JpJkSboWqUTFhDfTQdg9FvUzteAkNn5qjolq+z
         iJTUK79OYlHQ7rsQCR5x/74CjCM/r7ghLpH1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fWJS1K8DaSEgRDiDV9AcCT/035zEMfTydDERyKEuy2U=;
        b=LlIHYxvW1mS4ASE07AsfsK9WrO1X76hh9a6LchJagz43WGYkBXT7RNPNFm12Mz5Q+e
         Cd9qAdyFtc68iON0kFFYyGqUEZH7KDaGXXmYUmg+SqmKfwtoBH/CexUHDp+5/kMh7bPR
         /Fhh24bU/mhaCVwq9NKAYiD0K53VLNsKMT8ucZRhTKFf3IpxNyadZUzDUtKiuVH/VucO
         JOX0fOHaQQgnEobILz1WxAiLpmb81wD6dWLCgllbFdxCQJHBZfc/2w5DkL+15oFzXD3Q
         WfcOpBp7sdGFHR5RV+Txbup64ybopWqNE3F4Tu02l609JOek0YzLUBblb86KQcAzMBye
         tMZw==
X-Gm-Message-State: ANhLgQ3PKuLjwsdkvamzQAJb8o+vQf/BfnWxjPHcvUmP6ilIVvHHI07w
        bxbjyOFkllz891e3pZKZ6j444mvHL3JC4jyvp0X3BWOT1oAOUw/yj9AhnkHZs3Yqk46RV/BEVNp
        ljC5MP5FysrIHhsyBlWoh3KSefAaaO+3MVBstUSh1Sngl8fpDvNvDRBGW7Pf2/uAcy501z4TUme
        p2eM2q3zZ/
X-Google-Smtp-Source: ADFU+vvmrI8fEHU+l+2nvOmXwSM4p8w+RFzlgP05vuVTNvaIpVkBWRgdcbhA3bpwnV1C3JucUe8muw==
X-Received: by 2002:a05:600c:4145:: with SMTP id h5mr5787880wmm.3.1584458304813;
        Tue, 17 Mar 2020 08:18:24 -0700 (PDT)
Received: from lxpurley1.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id i6sm4878489wru.40.2020.03.17.08.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2020 08:18:24 -0700 (PDT)
From:   Vasundhara Volam <vasundhara-v.volam@broadcom.com>
To:     linux-pci@vger.kernel.org, davem@davemloft.net
Cc:     netdev@vger.kernel.org,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Chan <michael.chan@broadcom.com>
Subject: [PATCH net-next 06/11] PCI: Add new PCI_VPD_RO_KEYWORD_SERIALNO macro
Date:   Tue, 17 Mar 2020 20:46:44 +0530
Message-Id: <1584458204-29285-1-git-send-email-vasundhara-v.volam@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds a new macro for serial number keyword.

Cc: Bjorn Helgaas <bhelgaas@google.com>
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

