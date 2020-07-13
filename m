Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52FC21D6C5
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgGMNXi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730033AbgGMNXW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:23:22 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296C4C08C5DE;
        Mon, 13 Jul 2020 06:23:22 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n26so17186390ejx.0;
        Mon, 13 Jul 2020 06:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q0DdfK+UqqJL8YcIl12EqmY6PSz1+/PN6RVfEMMF3Q4=;
        b=NJ0hp1NNApuQU8bw6tjVSWHitDg1vIDtFUaeiDmwx+ow60WBbHEGBeAnEHj2j8qP02
         osWR34BF9/0x8PP9hyxdf/f30PfvtWe+O+aml4jtazke07Tlc8rIfTA/0UyD53kV/T0S
         rWlpmKn5qM3eaFqMksBujvyYkHysClu8JPEN4xHZOp3xZ5xRgzdKkinh7WhCxvY5JY3Y
         fi7mzT8DuGLOGVZz2ptsFk4NskphYU8XMgi3rCJu7VPwP/nDmOJP6fv3IlmWScA3Jgip
         NZMp29fPPm1OhZBhqAwiUhNo+exFWu5DYVBfDT19KBqUrNYPzkbNZqWnzLY0/B5iuezX
         3aBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q0DdfK+UqqJL8YcIl12EqmY6PSz1+/PN6RVfEMMF3Q4=;
        b=mTFbGknyNZ9ExnaULfz7Ix6NSGub33vS45L3Pnmw/b2uNeEdjAyWD/UfAI+LYBHxEv
         LwRVoHx/3U7lBkLcyL1AlIgj5ZkNao0lIZqn3bsBOErxcpDXZllqwCCrGAeXguCvOz/G
         5kD7oz5AGOutffnrRkYC8yDvfknRC9TH1umc6vYulAZlx8FlBTu8L7h+2eHklZ6yF9Wm
         5F73dagXNKjDuQt7ZCGRvStFcD0YlrFx1nBPRK5iOaeX4iDEBn78K+eGv3qwAwTGS1lp
         kSb4KwbfR+nHh5IIxN8jXs0jWW6WqX34G+ExC1E4YqwrNwu67b9RKvJWM4hjVzv9RRUT
         ZuDQ==
X-Gm-Message-State: AOAM532YPIyu38NF5RYEyJN3K9/IF4RAQD9BE2cLY6AkTFb8GvtnhRFM
        hNBOBZfxq6GC09BK5UaaO1gtB825jeqzCA==
X-Google-Smtp-Source: ABdhPJwnEBexXFGQz22NWjdykgIfoLXjIHNBfzIIKQCDH2Im79N2tI7W18NL0nmBRmj7cAZNYPAT3w==
X-Received: by 2002:a17:906:9387:: with SMTP id l7mr70963250ejx.274.1594646600908;
        Mon, 13 Jul 2020 06:23:20 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:23:20 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Russell King <linux@armlinux.org.uk>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 33/35] arm/PCI: Tidy Success/Failure checks
Date:   Mon, 13 Jul 2020 14:22:45 +0200
Message-Id: <20200713122247.10985-34-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unnecessary check for 0.

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
This patch depends on PATCH 32/35

 arch/arm/mach-cns3xxx/pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
index 7020071a2dc5..c249d4cbf4f0 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -92,7 +92,7 @@ static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 
 	ret = pci_generic_config_read(bus, devfn, where, size, val);
 
-	if (ret == 0 && !bus->number && !devfn &&
+	if (!ret && !bus->number && !devfn &&
 	    (where & 0xffc) == PCI_CLASS_REVISION)
 		/*
 		 * RC's class is 0xb, but Linux PCI driver needs 0x604
-- 
2.18.2

