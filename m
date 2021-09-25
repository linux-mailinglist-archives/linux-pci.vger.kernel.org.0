Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F0341807A
	for <lists+linux-pci@lfdr.de>; Sat, 25 Sep 2021 10:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbhIYIsl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Sep 2021 04:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbhIYIsg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Sep 2021 04:48:36 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF198C061604;
        Sat, 25 Sep 2021 01:46:51 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w29so34480134wra.8;
        Sat, 25 Sep 2021 01:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iEHoU21DH841tx0qtRTz5FbDxLZko2mQ4Z33po9e6hg=;
        b=PIJxllT69paC9PSPnGweRS7+dl4W6XwBhxX3NJEfjhKXs2OgetHWGsVMM+/xlYnpkJ
         yE067R/ulXFWu0+Nb22zbtRi8id5cEPSI4UwX4hUP/vr8+fIKm0RSc1dshmlkRiEEO4e
         a8Ev6kbxZ7iEMMiCbQvYroehkiSsHhWWckVb729l7AVvPOvm2uRGq7JtMYujgGJyM8xw
         0JeGRmnCEqhmtxTCWUhlCgG3Qp4q4kP9jJT2zWwu/jNuV22dva3L3R04ETxhI8U4+Tzr
         jurnDvW9kIcg4JM/zHGJQKU+WHZQcULwW9HWmexNR7JaaNFn+8vixbUKHUTkeYPeLUL1
         7gVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iEHoU21DH841tx0qtRTz5FbDxLZko2mQ4Z33po9e6hg=;
        b=u+83xcNnXrp8acai9DlI4z4py/ZFyDTC+b35STZYir4QapJJ9QLcbA0vPHRA3StBea
         yYJv4/y+E9GtJm0L7be3VHMEQVHdzgfRaEg2L3laHCm6bHeP4ArBh9BXrm2BqmmOa3aA
         hVuPHF/PI+CcTCYfHMP1RdeUinfUv8SqHeHbO9N+s46OPVTnsDNNmS+FJuFEnKUMq5HS
         adsJk21DrV7ZqZkUygBmVe96dXTEoAkA61R1L49ISTEeA0Yt+LF5+0CuHPAvhWeznXyP
         kDIC2p1q1dqfOQ94KM8slVVLC/aydcnAAgKqcynFHolGILU/+EhE5EYuBLzNfehwv6ov
         T9Pw==
X-Gm-Message-State: AOAM533g+ry+INIzLhtZXtKXQq6TchWmQ23GMK0LpOc3ltT1QH5o7uqC
        U+Ve6eedn3/gd13QunONw68=
X-Google-Smtp-Source: ABdhPJwbFGgQ4QqaYZwkc1R+U45nYpniQk1gbE3hEL7mfMPfDk8HqaaEUp/5WE47sL6izCrEYT8uVg==
X-Received: by 2002:adf:eec3:: with SMTP id a3mr16448514wrp.276.1632559610460;
        Sat, 25 Sep 2021 01:46:50 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id y9sm17222997wmj.36.2021.09.25.01.46.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Sep 2021 01:46:50 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     robh@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        Liviu.Dudau@arm.com, bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] staging: mt7621-pci: properly adjust base address for the IO window
Date:   Sat, 25 Sep 2021 10:46:41 +0200
Message-Id: <20210925084642.5642-7-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210925084642.5642-1-sergio.paracuellos@gmail.com>
References: <20210925084642.5642-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The value to adjust in the bridge register RALINK_PCI_IOBASE must take into
account the raw value from DT, not only the translated linux port number.
As long as io_offset is zero, the two are the same, but if you were to use
multiple host bridge in the system, or pick a different bus address in DT,
you can have a nonzero io_offset. At this means to take into account the
bus address which is used to calculate this offset, substracting it from
the IO resource start address.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index 6acfc94a16e7..503cb1fca2e0 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -482,7 +482,7 @@ static int mt7621_pcie_enable_ports(struct pci_host_bridge *host)
 
 	/* Setup MEMWIN and IOWIN */
 	pcie_write(pcie, 0xffffffff, RALINK_PCI_MEMBASE);
-	pcie_write(pcie, entry->res->start, RALINK_PCI_IOBASE);
+	pcie_write(pcie, entry->res->start - entry->offset, RALINK_PCI_IOBASE);
 
 	list_for_each_entry(port, &pcie->ports, list) {
 		if (port->enabled) {
-- 
2.25.1

