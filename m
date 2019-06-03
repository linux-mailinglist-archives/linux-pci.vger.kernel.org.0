Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9043933706
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2019 19:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfFCRo4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jun 2019 13:44:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35688 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfFCRo4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jun 2019 13:44:56 -0400
Received: by mail-ed1-f66.google.com with SMTP id p26so28067198edr.2;
        Mon, 03 Jun 2019 10:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UvPJ0pMiZoixpn1vorRDAMa+r0PwCmpA/CAl7+RUBFU=;
        b=mDpQCM0tAqeODReAP8OTV9DQoxN3yLTrbJtlUsVjnmtI/1iuLx7p9FbWDiC0DYh6UQ
         Y0jCK+ksupdzG1tNrJR5ovgGWsKJ78pddBKDrQ33b4nE4T0Iw58uPk+joii9Zs8Fj7tA
         UFLSIUl8IF4g9SukjZM3OHserAnn95viimi3WLCbD1Q2sx2tghWyqFQFfOWOgCLR8sk+
         J5e7xvriKldbYic86yWsDLSX8O+We57jRa9t30ZRAN79w2hxdd3Ts2NDWXdaC3si33zD
         +fd75c1OaYBe1maShaI11cbdIvM7wrX0TRoEYAXqBQW2Aw1PvXbI2y4M5QySroTMvWmp
         33ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UvPJ0pMiZoixpn1vorRDAMa+r0PwCmpA/CAl7+RUBFU=;
        b=PlKiAmyiO6SsAOsF5rBhpNK4Vs8z0G17c9q8bXuHJd40+bZ3wIaYYo/zPNOlR9W8FU
         XYtHulO6wuLWaGCwkwSzf9qhnqi9AEIyEN7+Q3tzTV3h5h6DL+2LV38+trBIKHsa6ftq
         giuu2vagx4GJ/D1RkTY2afiH7Pe6tU2peLszlLOKl9eLd06y3ZNVo40JHWsUiiNVEUsi
         LGGyxmRvJJSKpClBPqXNMAyG1+iet9xjbCVGmltcrfpF/GYQzI/nqYEmNppHgp9Qh8Ej
         E6+0epcthni28ZptPQWF65kPm3yE5CldIQ4un3XTmWAGk5x5g1ttiGmeEr79NZziqoLG
         Vmdg==
X-Gm-Message-State: APjAAAWvYj7csnULFpNEM/eSFo8gSWgGgIjoie4aZYb4Sl8DK4k7gOJz
        mQ9PxNW8/Iw2ndQQxB0Gk2s=
X-Google-Smtp-Source: APXvYqwYAH8FNbjJRPVG0DUMG7ZcBF+6mEqLYoc4xqQXZ9P5ym/vMa4fHhFVqcDLNjjZ9ibMHPZOTA==
X-Received: by 2002:a17:906:951:: with SMTP id j17mr23314130ejd.174.1559583894230;
        Mon, 03 Jun 2019 10:44:54 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id i31sm266996edd.90.2019.06.03.10.44.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 10:44:53 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] PCI: rpaphp: Avoid a sometimes-uninitialized warning
Date:   Mon,  3 Jun 2019 10:43:23 -0700
Message-Id: <20190603174323.48251-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0.rc2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When building with -Wsometimes-uninitialized, clang warns:

drivers/pci/hotplug/rpaphp_core.c:243:14: warning: variable 'fndit' is
used uninitialized whenever 'for' loop exits because its condition is
false [-Wsometimes-uninitialized]
        for (j = 0; j < entries; j++) {
                    ^~~~~~~~~~~
drivers/pci/hotplug/rpaphp_core.c:256:6: note: uninitialized use occurs
here
        if (fndit)
            ^~~~~
drivers/pci/hotplug/rpaphp_core.c:243:14: note: remove the condition if
it is always true
        for (j = 0; j < entries; j++) {
                    ^~~~~~~~~~~
drivers/pci/hotplug/rpaphp_core.c:233:14: note: initialize the variable
'fndit' to silence this warning
        int j, fndit;
                    ^
                     = 0

Looking at the loop in a vacuum as clang would, fndit could be
uninitialized if entries was ever zero or the if statement was
always true within the loop. Regardless of whether or not this
warning is a problem in practice, "found" variables should always
be initialized to false so that there is no possibility of
undefined behavior.

Link: https://github.com/ClangBuiltLinux/linux/issues/504
Fixes: 2fcf3ae508c2 ("hotplug/drc-info: Add code to search ibm,drc-info property")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/pci/hotplug/rpaphp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index bcd5d357ca23..07b56bf2886f 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -230,7 +230,7 @@ static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
 	struct of_drc_info drc;
 	const __be32 *value;
 	char cell_drc_name[MAX_DRC_NAME_LEN];
-	int j, fndit;
+	int j, fndit = 0;
 
 	info = of_find_property(dn->parent, "ibm,drc-info", NULL);
 	if (info == NULL)
-- 
2.22.0.rc2

