Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F99C107809
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 20:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKVTbv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 14:31:51 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42871 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfKVTbv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 14:31:51 -0500
Received: by mail-io1-f66.google.com with SMTP id k13so9294129ioa.9;
        Fri, 22 Nov 2019 11:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MHDX6AdLLIWuuwMa7ws4so1QjqLZd2fQo8w152Jy6bY=;
        b=nPoSoT4aW3Ehi2l0eD9o60SzrhXZxiG2uZ1RF7HNBVWBjxNcB6GE1fI9W1I7GhJtCT
         6fM+HttOGDrIXEIVYDXtCQMOPC2HzeAmeevj7vBwWgRgCPjO/roikQPeko51EeFQvcYC
         sBg1W+HvZhA7tRWrxaPNABHStJs3MBqZYipcDVJptxFHoeH2ek3FIMSvQGLxy6oFzheP
         Fj6pvstzbt/xXK+CLPDxo8uG95kKMTbTHQ3rVBB7zBhszLy34X6cTc75wk8U9WVrEVA9
         9CHrOwXHl/EqcVXcUG4BX/xn90/1k6MvMrWTAoGbeQYahZ7UCFqtUYiajE4nXLk1Obs0
         l2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MHDX6AdLLIWuuwMa7ws4so1QjqLZd2fQo8w152Jy6bY=;
        b=EV6L8mwSNCGRDx2qhxOVKPYsyQLBgSaKrGGxU7iNPgkUjZNCeqhnGGCeQLOSDDGSb2
         VFR6LpovD79Y6hOKuT0stnsHtm/Hjkf9L3JGLU4G8DGRiCpF3V2MiCq9Hs6jph2/pdnX
         nfpXIfizunviR9RAnXRYM/TsBKEM6D/YxkgNbaW4DQNmUxxNc9HZryUUEidlWqvhbnWP
         R+CjcrlpDmxzDwORa+xa+ENnuTKppT1XAzmQ4lNOEbO7fraBA4+897bXxRY4+Mc6sIYR
         q3/PxtUK35b4k3pm9HuepvyDELXEy8LFjoYuA8TP84tz7hubEmUdNMJWGLuOU8fobHYl
         BJHw==
X-Gm-Message-State: APjAAAWJhfuwpZ1XbQ4dDQ7ctz7+g44a0mYqT12DzQChtO52frqbLEq/
        PP6H3q7tcFHlG2fttjUKYQE=
X-Google-Smtp-Source: APXvYqwN+XnetajcE0ljGs8FPDjx51cwZ0qbcoPonZgSGqshBCh9pr7NCVj71fotEwxfD1WtNgajZw==
X-Received: by 2002:a5e:c010:: with SMTP id u16mr14269465iol.275.1574451110240;
        Fri, 22 Nov 2019 11:31:50 -0800 (PST)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id y8sm3095338ilg.47.2019.11.22.11.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 11:31:49 -0800 (PST)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] PCI/IOV: Fix memory leak in pci_iov_add_virtfn()
Date:   Fri, 22 Nov 2019 13:31:36 -0600
Message-Id: <20191122193138.19278-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the implementation of pci_iov_add_virtfn() the allocated virtfn is
leaked if pci_setup_device() fails. The error handling is not calling
pci_stop_and_remove_bus_device(). Change the goto label to failed2.

Fixes: 156c55325d30 ("PCI: Check for pci_setup_device() failure in pci_iov_add_virtfn()")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/pci/iov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index b3f972e8cfed..713660482feb 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -164,7 +164,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 
 	rc = pci_setup_device(virtfn);
 	if (rc)
-		goto failed1;
+		goto failed2;
 
 	virtfn->dev.parent = dev->dev.parent;
 	virtfn->multifunction = 0;
-- 
2.17.1

