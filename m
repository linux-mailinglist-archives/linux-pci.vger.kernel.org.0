Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D868C39DB51
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 13:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhFGLbU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 07:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhFGLbT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 07:31:19 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05828C061787;
        Mon,  7 Jun 2021 04:29:15 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x19so1340722pln.2;
        Mon, 07 Jun 2021 04:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gYiHNfH1kBmlkfBbotBqPsqiGVKKUt560+1kJ7V9BBI=;
        b=HSjMpYqbSO55esGzCWNfGkoYFj4gMqtwfUfHXE29SoUjYg37Hb+SuucnnMj9G8fzbL
         mYA1d0dno5FmYgmBIwveBEpO4fVaS/RCuo/vWRQ1knSJvNVTEPA0Yf6k3jYgHJXcRSOE
         25RXPij1VsOc6kkoWt5UV3Lw9uo7IprR5sS69pv6xAawn2N8U48H6guaaFI50W1uK2z8
         PqSPeN91DfEhs5yuomAa+W8bPkj1s7gpU0EA9euZPaydazhVJt5fE5a3bOzvAAyHfKnX
         H86UYjnw9lPB+vgq4+CJrIsc8/p8AM18wlQY50UZ9os7FZk60dV2h9sgOEUkxi4a8Tsl
         ePjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gYiHNfH1kBmlkfBbotBqPsqiGVKKUt560+1kJ7V9BBI=;
        b=JIkd670qNHVayBBH7oIlB8Aa93Tfo0tN7tR746umUV+C9VPp+ukLeYARvZLYUZn0S0
         SInL2WIapk9v5BIGwtX7tiVDDazPN3K6X9z4tL/4QC3WI6DeTOCO0oPnaieGUHDnx2oR
         RadtFnAiPzZAcMch90AQVa1yhyBG0Yf8PyJ5TmHiolC4GRiCLXM0NmPb4iuQrflEVJVj
         vYDa+m27GRRIknCwfsYUUXcoUUsbSvlFZ3VCaE5dPtyjsS13JET3m+9LrAa1GYgeIzWu
         gocDLnqSQEo2KUn6jo5d6tKKUb27JTb0oFXp+f7DxTFV8LsvOLxRWxAl1heE2qYbRyG0
         4rFg==
X-Gm-Message-State: AOAM5303dvVvlCD2h/lTEAnC+n6vk/4vR3Vtj/ukJjy1/fos45CZZgrk
        ZqQj2iGuUtPwFnuC4YHk8C0=
X-Google-Smtp-Source: ABdhPJyJGEghd9xFqSDRVaCu/4EepRG3WEkYdxRhmQn4Msi5hfJY0FokTjDtG1ac+2yeZYi+sEBMQQ==
X-Received: by 2002:a17:90a:f304:: with SMTP id ca4mr20846856pjb.177.1623065354552;
        Mon, 07 Jun 2021 04:29:14 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id i21sm8029078pfd.219.2021.06.07.04.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:29:14 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     helgaas@kernel.org, robh+dt@kernel.org
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alexandru.elisei@arm.com, wqu@suse.com,
        robin.murphy@arm.com, pgwipeout@gmail.com, ardb@kernel.org,
        briannorris@chromium.org, shawn.lin@rock-chips.com,
        Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH v3 2/4] PCI: of: Relax the condition for warning about non-prefetchable memory aperture size
Date:   Mon,  7 Jun 2021 20:28:54 +0900
Message-Id: <20210607112856.3499682-3-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607112856.3499682-1-punitagrawal@gmail.com>
References: <20210607112856.3499682-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit fede8526cc48 ("PCI: of: Warn if non-prefetchable memory
aperture size is > 32-bit") introduced a warning for non-prefetchable
resources that need more than 32bits to resolve. It turns out that the
check is too restrictive and should be applicable to only resources
that are limited to host bridge windows that don't have the ability to
map 64-bit address space.

Relax the condition to only warn when the resource size requires >
32-bits and doesn't allow mapping to 64-bit addresses.

Link: https://lore.kernel.org/r/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com
Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/of.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 1e45186a5715..38fe2589beb0 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -581,7 +581,8 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
 			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
 
 			if (!(res->flags & IORESOURCE_PREFETCH))
-				if (upper_32_bits(resource_size(res)))
+				if (!(res->flags & IORESOURCE_MEM_64) &&
+				    upper_32_bits(resource_size(res)))
 					dev_warn(dev, "Memory resource size exceeds max for 32 bits\n");
 
 			break;
-- 
2.30.2

