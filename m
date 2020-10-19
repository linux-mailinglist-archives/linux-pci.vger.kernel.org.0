Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B962292E0B
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 21:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbgJSTC7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 15:02:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53576 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731041AbgJSTC6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 15:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603134177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=uegBest9qGU95FbQlMt6mOSEsrBzbQhzO1uq0ihtkrw=;
        b=OgAQo+fp/LkuzxkumnroxcKuw4mUQU41yef30nJV5xn3JVdb5cZKY8vNJrQIetb5cFdVQn
        8y4ykytBPs7wq7yvEwpb3FM6SbhorG+qtiK4VYO5+0cT3CTaVEyJ1tUBm0FplGehHBgfXx
        ETB+N5o3p/gVwONFMAXTou6mmOe2La4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-xqUj3tXJPYaC8ArqWx3QMQ-1; Mon, 19 Oct 2020 15:02:55 -0400
X-MC-Unique: xqUj3tXJPYaC8ArqWx3QMQ-1
Received: by mail-qk1-f197.google.com with SMTP id k12so377172qkj.18
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2020 12:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uegBest9qGU95FbQlMt6mOSEsrBzbQhzO1uq0ihtkrw=;
        b=XGI3cDKLsRS8azkw/KI1XrAr9q4ie9nobttUgXxg82lJvMKAY6sXPSfz2teXLsBo0r
         eoCRKYyE1VNzkWNCwYMWL2n9b0r9B4vkLVKTSfLfcsh89VyQkr3roSDY2LFq5gUkUi9T
         3huSegsufkQ14yAhHdmsrxkeQg1ZU8xc+ymsAsOl5N+YFz3lCPE8093+sYYTiJOtV5V4
         EpP9HGa16B7KCkSGWoYgbZ/17Eq0QMvA5WVVo+Xz4RX29COqHG0bKESoixEW4JIrUeB0
         4pXr1ubHu0H9vnfybJycKGfOa9SUMBlYc0awK1ef48utZCUvcP2R9jTHpkPLsmz2Zd/t
         sUEQ==
X-Gm-Message-State: AOAM532KusYJVfat98QbMjZhUqxcI/l/UYSPaeVoFQ5hZnFY1kic8/lt
        tMNdqKvSgHkwZglshcxRZfvUz7VghU0c44LRMwvzfIcBv5QYHJeA5Xzd292hSAAd1UW0WUC6Fk+
        PGZ3LJ2womoyll9GBp8X7
X-Received: by 2002:a0c:a945:: with SMTP id z5mr1182784qva.55.1603134174808;
        Mon, 19 Oct 2020 12:02:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTkR2FbOzB18YDbh5OssfhPNpOXoSRI1q3NjkKotOp6l0c/da+MJYdy6UjlSd62aH7UPyrxQ==
X-Received: by 2002:a0c:a945:: with SMTP id z5mr1182768qva.55.1603134174632;
        Mon, 19 Oct 2020 12:02:54 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x91sm309284qte.69.2020.10.19.12.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:02:54 -0700 (PDT)
From:   trix@redhat.com
To:     linus.walleij@linaro.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] pci: remove unneeded break
Date:   Mon, 19 Oct 2020 12:02:49 -0700
Message-Id: <20201019190249.7825-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/pci/controller/pci-v3-semi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index 1f54334f09f7..154a5398633c 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -658,7 +658,6 @@ static int v3_get_dma_range_config(struct v3_pci *v3,
 	default:
 		dev_err(v3->dev, "illegal dma memory chunk size\n");
 		return -EINVAL;
-		break;
 	}
 	val |= V3_PCI_MAP_M_REG_EN | V3_PCI_MAP_M_ENABLE;
 	*pci_map = val;
-- 
2.18.1

