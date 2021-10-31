Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CB8440EB9
	for <lists+linux-pci@lfdr.de>; Sun, 31 Oct 2021 14:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhJaN62 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 31 Oct 2021 09:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhJaN62 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 31 Oct 2021 09:58:28 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34C2C061570;
        Sun, 31 Oct 2021 06:55:56 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g184so14754197pgc.6;
        Sun, 31 Oct 2021 06:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eApvuA9AcCPcJdYCjnNeqJuvkYqT5k5b2Xfmt74TBmE=;
        b=A4CapSWi1uQJCLeeBz/QHofmrAcWqPIiKmDvOANu2jrgWEsLrX1qd4tu9EkGWVEXZj
         L+FYUsuATs5xFYikuc+EkzDPOZioY/BMizOJ593Vhd31dXYfigmWyEY52Anut75vEkn0
         /g/hHEMrWd7AFj1U+EWm1DDosRQxqRyKw8N8dzzfLCbZaHh9o88RQlF6dJ/V7CM4d9L0
         31N3/C9nzhCQNkndrmpB8LvAdKDGa7SwKykT0F+fkCM8HD1R8beH9MRGAgckyPbwMQhh
         dWvVSZCrnRX5DIy0BKrcVdEPcDwDYGvlA9L8mj7sDBBodfV/6qJ7SjTsdAr45I9iKICl
         5qWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eApvuA9AcCPcJdYCjnNeqJuvkYqT5k5b2Xfmt74TBmE=;
        b=078KjjEmn2lGqCOteK2Eh1/APA+coSfHI8B4lgLle7s296RBOsTU1gJhEWmcnYEICM
         6kFFqlAVIS0zfrWOEgz3EhAAfQ0b/7TPWOCAbtSRBloofCO68nL0blahEIsdOSlIxn6R
         o1aDDhBkmK9O9YKr7Fv99+f+itmytfwH37PfdWgcRYtggxDmvwj5JU7l79qCrdCQI5nq
         b46n7qKuoEC6Q5fQ5n0jJhzrCxiBBLLB7CG0RVdwSaeaW+OF82ox9hRG0mWvQbKhsWr0
         sBKfRFKqkNHh7AMmnBF2p6LgC64iBHUoPhqhdq9vFnVczNgQWwSRRL9L5WCGSP36LWD1
         +jYQ==
X-Gm-Message-State: AOAM531EviUjWBAAjw/ziQhBgKg5Ndck4TQh+cWYUHxTqtV3Twyt6xD9
        baQyi+156RG8uPmjqDB3n00=
X-Google-Smtp-Source: ABdhPJzCi1LYcBPCxJstfmIBP6NwkGAu/tBs7+vsua6U15aTdfNxeW63gqeWxeq6K9u7BbPUyQYrnw==
X-Received: by 2002:a63:788d:: with SMTP id t135mr17149832pgc.2.1635688556394;
        Sun, 31 Oct 2021 06:55:56 -0700 (PDT)
Received: from pc ([223.197.3.99])
        by smtp.gmail.com with ESMTPSA id s30sm14284963pfg.17.2021.10.31.06.55.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Oct 2021 06:55:56 -0700 (PDT)
Date:   Sun, 31 Oct 2021 21:55:48 +0800
From:   Zhaoyu Liu <zackary.liu.pro@gmail.com>
To:     alyssa@rosenzweig.io, maz@kernel.org
Cc:     lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pci/controller/pcie-apple: remove the indentation beside
 arguments of DECLARE_BITMAP
Message-ID: <20211031135544.GA1616@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When "make tags", it prompts a warning:

    ctags: Warning: drivers/pci/controller/pcie-apple.c:150:
    null expansion of name pattern "\1"

Ctags regular can not be matched due to indentation, so remove it.
Same fix as in commit 5fdf876d30ce ("KVM: arm: Do not indent
the arguments of DECLARE_BITMAP")

Signed-off-by: Zhaoyu Liu <zackary.liu.pro@gmail.com>
---
 drivers/pci/controller/pcie-apple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index b665d29af77a..955134464d84 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -147,7 +147,7 @@ struct apple_pcie_port {
 	void __iomem		*base;
 	struct irq_domain	*domain;
 	struct list_head	entry;
-	DECLARE_BITMAP(		sid_map, MAX_RID2SID);
+	DECLARE_BITMAP(sid_map, MAX_RID2SID);
 	int			sid_map_sz;
 	int			idx;
 };
-- 
2.17.1

