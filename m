Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BD821295F
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jul 2020 18:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgGBQ2A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jul 2020 12:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgGBQ17 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jul 2020 12:27:59 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284DDC08C5C1;
        Thu,  2 Jul 2020 09:27:59 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n26so16546343ejx.0;
        Thu, 02 Jul 2020 09:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BKGyNwdE3y4ef1pbkDUWx2wEahUUqC/tey8vsP66t3k=;
        b=oXmeu34tul/Eh7uALk3qd8uoJLsyESkwDkrlTEhQDnvTGG809iGcWCvYZ2j+ILjUqn
         JqZrk62Ibi+SpIVMkR6J1oI4k1WXEwAxiJ6+9Yb0+GlECA4h5/ZKb4EaSMfLyTQZ4uuC
         8WBb4havLLiRJbCifA811Zvi3+Mf4uOkrRpcyJbA0vfcDxOS7DhRT7QWbmNoIHPatlY5
         3VgNFME8sgYVSRnaAyloi6snVT/coZIQ7ijlbZ+dL3HN2g9q4BfQiIJREVknD3Dh35/d
         8YclbBRtRktjzIW3H1Cs690UjsUJ8VrgEeNmFu6PZOfq5M1tAuiVbiHsKhd9qd//6B+u
         eIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BKGyNwdE3y4ef1pbkDUWx2wEahUUqC/tey8vsP66t3k=;
        b=F9Z7tmYpQ+orsW2hDDh6DgPKYlDl8fP5baXcZbhDmn3ssXp3V/TOhRjHONogh7WI1z
         G/vNu355G3BDGk79bhUPqm+sENsu/R+/I++2DWQHWAhpKBrWn9h4fpyfhU9iIQWBT+/2
         HcBBxpI7z8FN92/5UeNlE6xiOc/Whvtvbmm8llryRtdiif/vpun5f3+U0F5tO7WFIvg/
         IVV2JrtsSgjFejvQy9bTa4H3crsf7Gg5kql7PwAlDIzxx08EQbALH8zVUyIKrYl4YEAi
         Msq6RyrDHna5kl4VtT66qbjbDAySuKbNGj3TOiMZNlkWqRhakH8jntkP65Dwia2IKmYb
         d8dw==
X-Gm-Message-State: AOAM533q+sfweLehP3M52n57Vh4NXY9sIFH8sE6H+v/ii1T9J90D1Exi
        PgE+e2VVxlv4O7p+XPRmjG4=
X-Google-Smtp-Source: ABdhPJwIDcSGwPz0FbI0llipZVkAtHj5PxwwFRXYEVZYr1hCckr2gQQXUIJ5Pq19jE6TG7TU84vHXA==
X-Received: by 2002:a17:906:57da:: with SMTP id u26mr29223325ejr.157.1593707277882;
        Thu, 02 Jul 2020 09:27:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:4932:71ef:3c73:a14f])
        by smtp.gmail.com with ESMTPSA id gu15sm7375188ejb.111.2020.07.02.09.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 09:27:57 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 3/3] pci: update to doc to use 'pci_channel_state_t'
Date:   Thu,  2 Jul 2020 18:26:51 +0200
Message-Id: <20200702162651.49526-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702162651.49526-1-luc.vanoostenryck@gmail.com>
References: <20200702162651.49526-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The type used to describe the PCI channel state is a combination
of a bitwise typedef 'pci_channel_state_t' and an enumeration
of constant __force casted to this typedef: enum pci_channel_state.

It's a bit complex and quite ugly because:
* in C enums are weakly typed (they're essentially the same as 'int')
* sparse only allow to define bitwise ints, not bitwise enums.
But the idea is clearly to enforce typechecking and thus to
use 'pci_channel_state_t' everywhere.

So, update the documentation to use 'pci_chanell_state_t' and hide
'enum pci_channel_state' by showing a simplified but somehow equivalent
definition:
	typedef enum { ... } pci_channel_state_t;
which makes abstraction of the '__bitwise' which would otherwise
just bring unneeded complications here.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/PCI/pci-error-recovery.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
index c055deec8c56..ccd713423133 100644
--- a/Documentation/PCI/pci-error-recovery.rst
+++ b/Documentation/PCI/pci-error-recovery.rst
@@ -87,11 +87,11 @@ This structure has the form::
 
 The possible channel states are::
 
-	enum pci_channel_state {
+	typedef enum {
 		pci_channel_io_normal,  /* I/O channel is in normal state */
 		pci_channel_io_frozen,  /* I/O to channel is blocked */
 		pci_channel_io_perm_failure, /* PCI card is dead */
-	};
+	} pci_channel_state_t;
 
 Possible return values are::
 
-- 
2.27.0

