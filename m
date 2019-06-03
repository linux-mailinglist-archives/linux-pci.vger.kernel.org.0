Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2174133AE7
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 00:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfFCWNo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jun 2019 18:13:44 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40782 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfFCWNn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jun 2019 18:13:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id r18so27978478edo.7;
        Mon, 03 Jun 2019 15:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QO9b5Do5ysQrr7s3GzcTFKoPLVja1hwLd/j7EFbklsk=;
        b=F39ZYDelGutNNCw6Bm7MOuBQURzN8FAvhTNI9xGoMNHwOACNWjg9BFnW+WeFnsIQq7
         Q0VASU62D/QuJQjOsiMtpEez8Etq7laX3OFIvnaD++/DW8DLB8ztNIkDoAITNGzs61ho
         5MogTKA1mgmgCZsXjFQePNV6uXanaRvbqXK+zvg1ipmxn6fgfuINLrh2epN64OPP7Hga
         jR9dl+Ejsp0swrOCM12w4x2LOgpskEk1EuaM9DdE0zsyT9PgQU3dNV60i5pv/47x9g21
         s/o5Uy8CbEpI/Fba6v4MqWyx6TiJcKHSNLRn/NS1ok0Q2ltXR3aDtEfgHNdtp/fIPZ2L
         uTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QO9b5Do5ysQrr7s3GzcTFKoPLVja1hwLd/j7EFbklsk=;
        b=U7mMhtEm7nh7BY/l1HOM/fDSv1GB9ctsldzI3JOei/ATfo+efc1rQbTNy/F8iKA6P/
         Ms+hH+r9XWwID4zkzNm5RzfqnQqlOjDFxnRKDAkpGZPEJ7DZeU7Ov4EYK9tEOPFBO5k9
         vqEscRq2fMvm8YTB0/jMyRF7/7og6Trk/dknsPoeDfRsP7vAVSB/fCZ670d02Pmt6yhz
         0sKlGwHkMVj+TrgM7t08M036+pgEWes/9ubyjDgsLWOIu5xo7ju1KDdZBP85J85mZJ6t
         iqhefTteHMhoeMJHgM7WshWQRShmFoiJ0IwkdtG90E1i6gwWQOuE7vNVNowpB0DmExoe
         JbiQ==
X-Gm-Message-State: APjAAAV4SvOHlfHyv7/08/ZF00Jq9+84xZAxo9/rEQQniz+8y8vkp9Sw
        PlzFAhLQshOX9rTUlodj/nw=
X-Google-Smtp-Source: APXvYqzwJdJC5UuqbhofMI8Wzs9XZsjOp6JuZrA/isKGIP5Cjz3CHyXpt3g0enOrim2YrrRwlSlnkA==
X-Received: by 2002:a17:906:1c1b:: with SMTP id k27mr1364028ejg.13.1559600021948;
        Mon, 03 Jun 2019 15:13:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id r9sm3869840eds.61.2019.06.03.15.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 15:13:41 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2] PCI: rpaphp: Avoid a sometimes-uninitialized warning
Date:   Mon,  3 Jun 2019 15:11:58 -0700
Message-Id: <20190603221157.58502-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0.rc3
In-Reply-To: <20190603174323.48251-1-natechancellor@gmail.com>
References: <20190603174323.48251-1-natechancellor@gmail.com>
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

fndit is only used to gate a sprintf call, which can be moved into the
loop to simplify the code and eliminate the local variable, which will
fix this warning.

Link: https://github.com/ClangBuiltLinux/linux/issues/504
Fixes: 2fcf3ae508c2 ("hotplug/drc-info: Add code to search ibm,drc-info property")
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Eliminate fndit altogether by shuffling the sprintf call into the for
  loop and changing the if conditional, as suggested by Nick.

 drivers/pci/hotplug/rpaphp_core.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index bcd5d357ca23..c3899ee1db99 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -230,7 +230,7 @@ static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
 	struct of_drc_info drc;
 	const __be32 *value;
 	char cell_drc_name[MAX_DRC_NAME_LEN];
-	int j, fndit;
+	int j;
 
 	info = of_find_property(dn->parent, "ibm,drc-info", NULL);
 	if (info == NULL)
@@ -245,17 +245,13 @@ static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
 
 		/* Should now know end of current entry */
 
-		if (my_index > drc.last_drc_index)
-			continue;
-
-		fndit = 1;
-		break;
+		/* Found it */
+		if (my_index <= drc.last_drc_index) {
+			sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix,
+				my_index);
+			break;
+		}
 	}
-	/* Found it */
-
-	if (fndit)
-		sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix, 
-			my_index);
 
 	if (((drc_name == NULL) ||
 	     (drc_name && !strcmp(drc_name, cell_drc_name))) &&
-- 
2.22.0.rc3

