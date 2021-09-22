Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482ED4140FD
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 07:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhIVFCR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 01:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbhIVFCM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Sep 2021 01:02:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E881EC061574;
        Tue, 21 Sep 2021 22:00:42 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t18so3201070wrb.0;
        Tue, 21 Sep 2021 22:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uLV1H8lOUqllhWhMWtTAgHCu5bS8aT/YHsgKcThPqTo=;
        b=hc7YsC+KdwME/FdU9dBYKerpWNTd36HebU7kzGoHCb+v9NITrk4VBHlGJvNybmu2NV
         HgE8Mf/5sNZF40dlkEq1WNn/bQXmZaQ8GE+1DwvvCVLJN6Vh4+EwzVF+uVaAAsUXh78F
         +pek75WzITpMDasRDOWC9VZaEw1ofuCHUhYEVjWY4njIvlhTUnaqp0U2KDfhyiZMigEv
         rMY4ocfnD3d5grfgbOERKJpYe/SqoefgRwTF20fZm8JLp9nRpXXylHeJ3C+9xf4GOj1D
         6ABRyEjeu4AMiIT4p+dO4FzrU1DmYLHV33Ja4mYGzE93h2w4nLKFlkx9+l4NX/i6TFl1
         FWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uLV1H8lOUqllhWhMWtTAgHCu5bS8aT/YHsgKcThPqTo=;
        b=hQnGceXScVSpM1M7fcljWBrK++TNvsCC9z7VRip+7XazOFk/IPZ4zI5YASa4mB3Qmw
         YC1Ibo818Zt5MzYCeas2kzll5xF0PQyjuqcP+TyzfZegxqMZ+/t44DVPl9MmDQLfZkys
         AYKxjZb8IXE4ux+FnGI0U8xO2K4R3rlFAeggKyix0dycnSPyzWb7yIo3sLESY08hp0hl
         IsCFKVWLChPom/SbEbA+zjlGUuxLBZ26F35iafL61VT2aZxPAYlJgpruaIoykxOaXZ1Q
         ZMitWCnvSqz4bM8KrsDVXgmtXccnRu1PZZI2+11etBUfIAjmS8leASoAAknk6ljagVSC
         EYXg==
X-Gm-Message-State: AOAM5330AXt0WrQ4B0WC5HhVQL+SOKSKH84xh+0Y2Tn86gh0RPXq29rT
        NrD5BeQRmZELXeVTsmQZgJUuvqk3CDw=
X-Google-Smtp-Source: ABdhPJydVjWKiS4HM+M6BTpD6DBcjrGFUBfUfGlobfx9VO3CWDAwnpe828DpeeusVa6m6HrEob5EuA==
X-Received: by 2002:a5d:64e2:: with SMTP id g2mr36130452wri.20.1632286841330;
        Tue, 21 Sep 2021 22:00:41 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id b187sm4811625wmd.33.2021.09.21.22.00.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Sep 2021 22:00:40 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, john@phrozen.org,
        devicetree@vger.kernel.org, tsbogend@alpha.franken.de,
        bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-staging@lists.linux.dev, neil@brown.name,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] MAINTAINERS: add myself as maintainer of the MT7621 PCI controller driver
Date:   Wed, 22 Sep 2021 07:00:35 +0200
Message-Id: <20210922050035.18162-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210922050035.18162-1-sergio.paracuellos@gmail.com>
References: <20210922050035.18162-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add myself as maintainer of the PCie Controlller driver for
MT7621 SoCs.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eeb4c70b3d5b..a7f0cbad7ac5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11842,6 +11842,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/i2c-mt7621.txt
 F:	drivers/i2c/busses/i2c-mt7621.c
 
+MEDIATEK MT7621 PCI CONTROLLER DRIVER
+M:	Sergio Paracuellos <sergio.paracuellos@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
+F:	drivers/pci/controller/pci-mt7621.c
+
 MEDIATEK MT7621 PHY PCI DRIVER
 M:	Sergio Paracuellos <sergio.paracuellos@gmail.com>
 S:	Maintained
-- 
2.25.1

