Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A26396996
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 00:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhEaWNu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 18:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbhEaWNt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 May 2021 18:13:49 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786F5C061574;
        Mon, 31 May 2021 15:12:09 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id z26so5882989pfj.5;
        Mon, 31 May 2021 15:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GljEIu7jIiK5mN+vwX9RD16rs+gsfiwk0Od3Nc7rcMA=;
        b=vNvhfeWt5cFD8gkB4sUI7nF6V2E/QEdfYsExlwI595NuvXT3oIvH3xZNLviBnX4zDN
         nuR04B1NXsc3Jhe6NFFmU1xquEyA26aLCG2DqHFvRiLvTHBY4DS7rS9QMlqGLcwWL56j
         qf34Kc2OvKjY6sJRKe5LN79I2oNo8sihnnkTlb/NYeMaI4sA0na2qNzGmlCUmYblWHPk
         06RNlK5AeluOY4dQYH7lsutCEehI4Guj2sGqbJ23hStHORh9mO3r30ipUYFVqhlSLTwK
         dMxSvewN9Y0aGJOOc99hYFlq7vhfNeEXNDi0RFK/ay2235wQntfmfFcOdqg2vkpcngyI
         D0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GljEIu7jIiK5mN+vwX9RD16rs+gsfiwk0Od3Nc7rcMA=;
        b=Nw+AnZFjFtx0AVuuSiLTQo9MlBU26sIRaE1xhx5ZutaszMQCFlhlJxK52bPKqDtA7g
         Go8+dHz+o7v+TJFmK2j4Hz5gOQOjOXE7/wpRzfypLhnnnOHZ9tpVj6TXgUy2R15HVi1i
         ntx14igjg7w5IaWMV36FsVRpycKDikDEqc45aEgOAvwTgxXGJi4pmjNq72IEUf6cFMd2
         tQlY9C3MUS9amG5GiswBuobjOLFkuBqgK4yYndj6nufPE4FPV7Lll9Tv0JThGhSBsDJM
         2yMY8DwO55S6NqoP0qPycDfphYoi9e0H/kHtdbcNt/E4qqgoQjiwy1JW6q4MZ5szH2Jb
         Na5w==
X-Gm-Message-State: AOAM5338PRAEYg4yjYyLAD5rzUH+f1vetucBgqBflWPPtGQ6B8N1VvVL
        yH7GwfKp5y6Ow/YcdGvAfxo=
X-Google-Smtp-Source: ABdhPJy1PBZt9zgv9B4tloqR1PSuGex00FScff7o1LZFYY4Dcj9PLvG31McWKUKnJHay1fqAP8grxw==
X-Received: by 2002:a62:7fc5:0:b029:2de:5813:8890 with SMTP id a188-20020a627fc50000b02902de58138890mr18721295pfd.60.1622499129035;
        Mon, 31 May 2021 15:12:09 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id n23sm11879008pff.93.2021.05.31.15.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 15:12:08 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandru.elisei@arm.com, wqu@suse.com, robin.murphy@arm.com,
        pgwipeout@gmail.com, ardb@kernel.org, briannorris@chromium.org,
        shawn.lin@rock-chips.com, helgaas@kernel.org, robh+dt@kernel.org,
        Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH v2 3/4] PCI: of: Refactor the check for non-prefetchable 32-bit window
Date:   Tue,  1 Jun 2021 07:10:56 +0900
Message-Id: <20210531221057.3406958-4-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210531221057.3406958-1-punitagrawal@gmail.com>
References: <20210531221057.3406958-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Recently, an override was added for non-prefetchable host bridge
windows below 4GB that have the 64-bit address attribute set. As many
of the conditions for the check overlap with the check for
non-prefetchable window size, refactor the code to unify the ranges
validation into devm_of_pci_get_host_bridge_resources().

As an added benefit, the warning message is now printed right after
the range mapping giving the user a better indication of where the
issue is.

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Cc: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/of.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index c2a57c61f1d1..836d2787510f 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -348,11 +348,15 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
 			*io_base = range.cpu_addr;
 		} else if (resource_type(res) == IORESOURCE_MEM) {
 			if (!(res->flags & IORESOURCE_PREFETCH)) {
-				if (res->flags & IORESOURCE_MEM_64)
+				if (res->flags & IORESOURCE_MEM_64) {
 					if (!upper_32_bits(range.pci_addr + range.size - 1)) {
 						dev_warn(dev, "Clearing 64-bit flag for non-prefetchable memory below 4GB\n");
 						res->flags &= ~IORESOURCE_MEM_64;
 					}
+				} else {
+					if (upper_32_bits(resource_size(res)))
+						dev_warn(dev, "Memory resource size exceeds max for 32 bits\n");
+				}
 			}
 		}
 
@@ -572,12 +576,6 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
 			break;
 		case IORESOURCE_MEM:
 			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
-
-			if (!(res->flags & IORESOURCE_PREFETCH))
-				if (!(res->flags & IORESOURCE_MEM_64) &&
-				    upper_32_bits(resource_size(res)))
-					dev_warn(dev, "Memory resource size exceeds max for 32 bits\n");
-
 			break;
 		}
 	}
-- 
2.30.2

