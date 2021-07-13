Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D603C6771
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 02:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhGMA2T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 20:28:19 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:37398 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhGMA2T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jul 2021 20:28:19 -0400
Received: by mail-wr1-f48.google.com with SMTP id i94so27996197wri.4
        for <linux-pci@vger.kernel.org>; Mon, 12 Jul 2021 17:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bui7AgdPIiwwrYwMh79xgVS7mq+OX7ceu5SE/Hq8sVc=;
        b=AS/xFtiwMklaClLD0y/3Srd0m+Y2j+0AQkt5v5ovQwQ8QoKc9ozIaVdocfE38MAa+N
         EYZ67xev17puVGBM8AXUaaT8mfAcLRC1Rz91jP67aPKcap3zncV2jSlN625/oLdj8nsc
         PC6dO1eQKh+qCGuZOeEeM+2UhNRfKnxHcSNgpuxy5ohQXvEom+eVAd9J1K6slN5zAvdf
         I/PXpXPBwQ5x4xoKVB9j0R/RTCNvhz6l3a/c+XDtxwHDRpAM2QkUZOiKest9ZpIqQxK6
         5wMwik8DS365mvj1vjJQ4X+Sm+DFUN3JAueTERBeWZA4jcfT7gs7iH8PBGBZEEoZLj85
         MJxw==
X-Gm-Message-State: AOAM53187+YuopUxJbN7qWdKFngwbw8HyHhGcKo/GRnSD3b7AowcwQRQ
        VXQA91s4Ej+ut/E0P2f9jpw=
X-Google-Smtp-Source: ABdhPJwBMvQ6lKonrvm8WyUjCvo327ju2Dz8Wj7wvkaN1fP7TiUWp6kySHD0TLvAM1NwWrQHjogLyA==
X-Received: by 2002:a5d:6ac4:: with SMTP id u4mr1997170wrw.166.1626135928773;
        Mon, 12 Jul 2021 17:25:28 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id p5sm38895wme.2.2021.07.12.17.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 17:25:28 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Russell Currey <ruscur@russell.cc>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: [PATCH 2/2] powerpc/eeh: Use pcie_reset_state_t type in function arguments
Date:   Tue, 13 Jul 2021 00:25:25 +0000
Message-Id: <20210713002525.203840-2-kw@linux.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713002525.203840-1-kw@linux.com>
References: <20210713002525.203840-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pcie_reset_state_t type has been introduced in the commit
f7bdd12d234d ("pci: New PCI-E reset API") along with the enum
pcie_reset_state, but it has never been used for anything else
other than to define the members of the enumeration set in the
enum pcie_reset_state.

Thus, replace the direct use of enum pcie_reset_state in function
arguments and replace it with pcie_reset_state_t type so that the
argument type matches the type used in enum pcie_reset_state.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 arch/powerpc/kernel/eeh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 3bbdcc86d01b..15485abb89ff 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -714,7 +714,7 @@ static void eeh_restore_dev_state(struct eeh_dev *edev, void *userdata)
  * Return value:
  * 	0 if success
  */
-int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
+int pcibios_set_pcie_reset_state(struct pci_dev *dev, pcie_reset_state_t state)
 {
 	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
 	struct eeh_pe *pe = eeh_dev_to_pe(edev);
-- 
2.32.0

