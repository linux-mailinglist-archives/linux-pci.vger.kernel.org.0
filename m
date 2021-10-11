Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E55429656
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 20:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhJKSFw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 14:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJKSFv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 14:05:51 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BD3C061570;
        Mon, 11 Oct 2021 11:03:51 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r2so11522752pgl.10;
        Mon, 11 Oct 2021 11:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uTfOlYjXNBEAayJpHetBNlZe2ZqNE3iJj+P39moFg1o=;
        b=CSXN0d+RX5gVlA5Q6T781+097P6ScH10C+hQduS/VAIjDhz85Wkn5oq4rZtV4nfhI/
         nA7yRKHyjET+4LZoq5kDrIEZ14S24AaOC39nfFj3G85zXmqKjmUJ6aAnSvDgQjdjcdvr
         TW8t0fDtHViTExg8YHlvXF11jbrY/+JdLD5lc9Ohb/4RTZRB7fP9d7sANa0PcJH7gIDj
         k6iXlH7fyyhtKawMwvJoCpo4EvBqo6VJLX3bs8kjrC3GXmUW17j3xgcT4miUwKa5AED5
         39GsmDT6IeglFJIKalOSnZqiu6V5/ZV+dYoVHjRwmgtFIRAKg0D9AAh0S3V5MF37cCmb
         HcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uTfOlYjXNBEAayJpHetBNlZe2ZqNE3iJj+P39moFg1o=;
        b=WGK2orXrEAL3iwtQWrIEh5R9iuDE7K3BV9AxMujQsU5CDP9YfH3+eAU37w3+2+LjnI
         RC7G4vrsUahOq5iU0KvFg8SRNmzUjnAAs5naeDsqiiYVDcB/pKRvMomkP2yD+M0/mm9d
         43zXGrCi5ogtz+r7l07n8RR7Xx3Ola9d6nvL6ZKdG04vWrVIrBLaZo4XStkRkDLsgnWH
         P6XqwC+DhygX656Qks6009CcugJINLOS44vkpc1duxI2/bkt2VOF5K7/N4NtcImyqMiR
         8hyvp43vZKrz5v2bMlRabLKdceDGE2zqXA/1ca+fby7g6IltxMwQRbFdfVGqI6EIP5BK
         d5WQ==
X-Gm-Message-State: AOAM531p4uwShAh5xGvu4AvWKTjGIrMo7J6wXFV5QsIdroolmSBtHxFY
        kYtTZO6V6JP4H1M8hvztez1PZxa9Nxx2uyGo
X-Google-Smtp-Source: ABdhPJzrxXUDNFUyE8esyCGa95IxW6Gzh2r6gzWoHQySw7x7LypeFURbzQqutuscxuzTnY38/3GUSw==
X-Received: by 2002:a62:6206:0:b0:44c:bc1f:aa5a with SMTP id w6-20020a626206000000b0044cbc1faa5amr26730462pfb.5.1633975430947;
        Mon, 11 Oct 2021 11:03:50 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id d12sm8711637pgf.19.2021.10.11.11.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 11:03:50 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org (open list:PCIE DRIVER FOR ROCKCHIP),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support)
Subject: [PATCH 13/22] PCI: rockchip: Use SET_PCI_ERROR_RESPONSE() when device not found
Date:   Mon, 11 Oct 2021 23:32:57 +0530
Message-Id: <11cbd327beeed70c6db69aad4eeafe28ade4ecb3.1633972263.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633972263.git.naveennaidu479@gmail.com>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use SET_PCI_ERROR_RESPONSE() to set the error response, when a faulty
read occurs.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Compile tested only.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index c52316d0bfd2..f5d718700d59 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -222,7 +222,7 @@ static int rockchip_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 	struct rockchip_pcie *rockchip = bus->sysdata;
 
 	if (!rockchip_pcie_valid_device(rockchip, bus, PCI_SLOT(devfn))) {
-		*val = 0xffffffff;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-- 
2.25.1

