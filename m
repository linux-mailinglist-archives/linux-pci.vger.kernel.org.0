Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74712DDA47
	for <lists+linux-pci@lfdr.de>; Thu, 17 Dec 2020 21:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbgLQUoZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Dec 2020 15:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgLQUoZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Dec 2020 15:44:25 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F10C0617A7
        for <linux-pci@vger.kernel.org>; Thu, 17 Dec 2020 12:43:45 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id dk8so107684edb.1
        for <linux-pci@vger.kernel.org>; Thu, 17 Dec 2020 12:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=ulgwG3L5KQfPeeXWLviGF2w5wVPlt5pQdp4CiLaMlFk=;
        b=B2WevceXgTdwdrvzuM2MsecUn5pbxwuJQVGTjQXjtrO+nZnbvYIWf5romcco5PW6qg
         OPUGzocra041LlLKrvvRsE7uvaxJrUu8V5dVC28xL9mee27CyJ+Jpel+/NlVa7hsp+Qw
         aRHEXcrNBNR6j3P0W74BnD8S9zpAmQf9KmjfDcmKGmMeviP40+QlY5BXdbQn7huCGgWZ
         28amGQmiQEojoSfNvkY78sNc/OWlfeAL/u2p25fkaikP1BGFj2mVds8sEu55IguxMm25
         vpuLnHrAhbepuxy0D/ofaBoYurWyrnnzDJSzIk8DnWfgK+gfDcU+Sl/wJTuRh/VVEqde
         S0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=ulgwG3L5KQfPeeXWLviGF2w5wVPlt5pQdp4CiLaMlFk=;
        b=DA59vPrPIKqMn5gxl7XVPf/Fg/xh+wZLva8a2CuctvkGNVyQfwr9R4ZgqSNufZS8fH
         UvTWDc4d3MhTkOTrDEte+Iy0pkaKv8erC1mfaTAAjUfNN8zE+vJ0Z7OYuokr3nFWw0ks
         kf+CUWK7ndk+CMLD1hwv0NWxNdBpGXVc99fZkhlxAYFVSBJuAnrHY+yLRRblAlwr4wQb
         X0V2CTR7r7DYAu6mTRRDG0OP5FI0Ers3KZxTOtF856nRvGSE8O6qBeQ9pX8ZWi5avqbY
         rl0g6J730s6LKzD/uT6Iztc1GNHCJ9PwiFMPJnU9wTdHVMPB9q4ElC4guZ5aRqwxns/b
         SQSA==
X-Gm-Message-State: AOAM532N/KojQhsUdwpmNgiZZdelW+sdFl3Yjn7E6yXr3wkmHo8DyNdh
        8IluL9Qnzvudp0wVgR7BwD/zFNekyPI=
X-Google-Smtp-Source: ABdhPJwkYku2/nKxjtDKyvxKpZIPp2MpZuKFRY7FCIR+OeeiGTltQDIavbVmkAr0xv6XtlG3US8Xrg==
X-Received: by 2002:a05:6402:a5b:: with SMTP id bt27mr1245145edb.222.1608237823756;
        Thu, 17 Dec 2020 12:43:43 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:c095:d389:734d:8e2a? (p200300ea8f065500c095d389734d8e2a.dip0.t-ipconnect.de. [2003:ea:8f06:5500:c095:d389:734d:8e2a])
        by smtp.googlemail.com with ESMTPSA id l5sm24990150edl.48.2020.12.17.12.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 12:43:43 -0800 (PST)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI/VPD: Silence warning if optional VPD PROM is missing
Message-ID: <b04a0e46-0b97-da3d-aa77-b05c9b37d21f@gmail.com>
Date:   Thu, 17 Dec 2020 21:43:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Realtek RTL8169/8168/8125 NIC families indicate VPD capability and an
optional VPD EEPROM can be connected via I2C/SPI. However I haven't
seen any card or system with such a VPD EEPROM yet. The missing EEPROM
causes the following warning whenever e.g. lscpi -vv is executed.

invalid short VPD tag 00 at offset 01

The warning confuses users, I think we should handle the situation more
gentle. Therefore, if first VPD byte is read as 0x00, assume a missing
optional VPD PROM as and silently set the VPD length to 0.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index ef5165eb3..bd174705f 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -89,6 +89,10 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 	       pci_read_vpd(dev, off, 1, header) == 1) {
 		unsigned char tag;
 
+		/* assume missing optional VPD PROM */
+		if (!header[0] && !off)
+			return 0;
+
 		if (header[0] & PCI_VPD_LRDT) {
 			/* Large Resource Data Type Tag */
 			tag = pci_vpd_lrdt_tag(header);
-- 
2.29.2

