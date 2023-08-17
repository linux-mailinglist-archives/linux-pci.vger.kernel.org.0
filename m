Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D9878020C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 01:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356262AbjHQX7D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 19:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356333AbjHQX6n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 19:58:43 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D71526B6;
        Thu, 17 Aug 2023 16:58:41 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-4881f8a6caeso115133e0c.0;
        Thu, 17 Aug 2023 16:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692316720; x=1692921520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhYFDJTt8t7W7/+Nj3izgy85+P+pn9Ak5WijxGq2p+Q=;
        b=hVRuVq4seOD0e1K0arobBgHBIAfpKu+qtKERCI7g+N3DYJyoGKBSC2Ph8sipI730vF
         5VZ5WmFjmpXJLaqj/mFrKYMI4YDD4iycpT/MtlN9X0drTuJVIzYT1XSeDsC4jjV5PtJ3
         qeCLIpTFyzAf0HizEeRSL3DLkmIMGRRsp3torg+2MYyQkdjnA7Fwpaq/5KAqdryxP/BC
         TeGc6bxzksuTx/B+EyRMkcCLX5z6LFxFzVv7GRFpgjudisP40FCSeP2xgTZ5zqT+eTJh
         FxIm7w5eTprCr3F6IcNQg8wLdlTT+XvozKKEJZMcPUL7HJDyeToC+c6n1dogU0LOCv5f
         gNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692316720; x=1692921520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhYFDJTt8t7W7/+Nj3izgy85+P+pn9Ak5WijxGq2p+Q=;
        b=UVlOg0WcABjX6kWHmBX6Vv3oxuGAnD2whZ0eyS7F7HKmOa+1FWoG38QOTdzHVOaEsq
         rvRKhVtr0LtxWoB/TgRw1K5KHAd9okXXxxp+5dMI7ilmvIQv8RLpw20XllG6C34sm/re
         UQFDN3oN+WLTa+xcg5Y7LVsx4Zw7NZHHgMKEIpx+We6moJDWKy7MDHFgwZK+sThbIEoW
         HfMqEtF+UWohJUbFENrC6wTvOASBc9SoX4bn1E90d2hG6qsozS5iT3dqCQybU6uZBPWS
         937iYyQaHeOc5yc51U7fetkMctkti9Gjm4AaphoxGTk6caGpGXqOLlgFJq8UBBUoci6q
         L9lA==
X-Gm-Message-State: AOJu0YyCtyb6TlCMEfO4rAMOvc2JeqPio46noKoysDPZzo5hmcZfVCZr
        IRtmBJ9gJ4k8YJq/akaf5Nk=
X-Google-Smtp-Source: AGHT+IFrrh7c2bJwTE+iNjf4C7BVmlGDz4CVfCvz9VQBas8wkdE9LzLBsN5ZlTbhSeyE5Yxj9smUpQ==
X-Received: by 2002:a67:ffd5:0:b0:43d:6660:581b with SMTP id w21-20020a67ffd5000000b0043d6660581bmr1726767vsq.5.1692316720529;
        Thu, 17 Aug 2023 16:58:40 -0700 (PDT)
Received: from localhost.localdomain ([146.70.187.10])
        by smtp.gmail.com with ESMTPSA id k19-20020a67c293000000b0044bf2750d30sm135182vsj.10.2023.08.17.16.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:58:40 -0700 (PDT)
From:   Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de
Cc:     alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        chaitanyak@nvidia.com, rdunlap@infradead.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 2/3] sysfs: Add a attr_is_visible function to attribute_group
Date:   Thu, 17 Aug 2023 19:58:09 -0400
Message-ID: <20230817235810.596458-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817235810.596458-1-alistair.francis@wdc.com>
References: <20230817235810.596458-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When creating an attribute group, if it is named a subdirectory it is
created and the sysfs files are placed into that subdirectory.  If no
files are created, normally the directory would still be present, but it
would be empty.

This can be confusing for users, as it appears the feature is avaliable
as there is a directory, but it isn't supported by the hardware or the
kernel.

One way to fix this is to remove directories that don't contain any
files, such as [1]. The problem with this is that there are currently
lots of users in the kernel who expect the group to remain even if
empty, as they dynamically add/merge properties later.

The documentation for sysfs_merge_group() specifically says

    This function returns an error if the group doesn't exist or any of the
    files already exist in that group, in which case none of the new files
    are created.

So just not adding the group if it's empty doesn't work, at least not
with the code we currently have. The code can be changed to support
this, but it is difficult to determine how this will affect existing use
cases.

This approach instead adds a new function pointer, attr_is_visible(), to
`struct attribute_group` which can be set if the user wants to filter
the avaliablility of the function.

This matches the .is_visible() function pointer that already exists and
is commonly used. This approach provides greater control over if the
directory should be visible or not.

This will be used by the PCIe DOE sysfs attributes to kind the directory
on devices that don't support DOE.

1: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=debugfs_cleanup&id=f670945dfbaf353fe068544c31e3fa45575da5b5

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v6:
 - Add patch

 fs/sysfs/group.c      | 12 +++++++++++-
 include/linux/sysfs.h |  6 ++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 138676463336..34afd5becdbe 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -111,6 +111,7 @@ static int internal_create_group(struct kobject *kobj, int update,
 	kuid_t uid;
 	kgid_t gid;
 	int error;
+	umode_t mode;
 
 	if (WARN_ON(!kobj || (!update && !kobj->sd)))
 		return -EINVAL;
@@ -125,6 +126,15 @@ static int internal_create_group(struct kobject *kobj, int update,
 		return 0;
 	}
 
+	if (grp->attr_is_visible) {
+		mode = grp->attr_is_visible(kobj);
+
+		if (mode == 0)
+			return 0;
+	} else {
+		mode = S_IRWXU | S_IRUGO | S_IXUGO;
+	}
+
 	kobject_get_ownership(kobj, &uid, &gid);
 	if (grp->name) {
 		if (update) {
@@ -136,7 +146,7 @@ static int internal_create_group(struct kobject *kobj, int update,
 			}
 		} else {
 			kn = kernfs_create_dir_ns(kobj->sd, grp->name,
-						  S_IRWXU | S_IRUGO | S_IXUGO,
+						  mode,
 						  uid, gid, kobj, NULL);
 			if (IS_ERR(kn)) {
 				if (PTR_ERR(kn) == -EEXIST)
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index fd3fe5c8c17f..808e7fc0ca57 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -63,6 +63,11 @@ do {							\
  * @name:	Optional: Attribute group name
  *		If specified, the attribute group will be created in
  *		a new subdirectory with this name.
+ * @attr_is_visible:	Optional: Function to return permissions
+ *		associated with the attribute group. Only read/write
+ *		permissions as well as SYSFS_PREALLOC are accepted. Must
+ *		return 0 if an attribute is not visible. The returned value
+ *		will replace static permissions defined in struct attribute.
  * @is_visible:	Optional: Function to return permissions associated with an
  *		attribute of the group. Will be called repeatedly for each
  *		non-binary attribute in the group. Only read/write
@@ -83,6 +88,7 @@ do {							\
  */
 struct attribute_group {
 	const char		*name;
+	umode_t			(*attr_is_visible)(struct kobject *);
 	umode_t			(*is_visible)(struct kobject *,
 					      struct attribute *, int);
 	umode_t			(*is_bin_visible)(struct kobject *,
-- 
2.41.0

