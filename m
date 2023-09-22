Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99B07AB1DB
	for <lists+linux-pci@lfdr.de>; Fri, 22 Sep 2023 14:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjIVMIw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Sep 2023 08:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjIVMIw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Sep 2023 08:08:52 -0400
X-Greylist: delayed 98 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Sep 2023 05:08:46 PDT
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:df01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1526099
        for <linux-pci@vger.kernel.org>; Fri, 22 Sep 2023 05:08:46 -0700 (PDT)
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:d11:0:640:6943:0])
        by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id E161D6070A;
        Fri, 22 Sep 2023 15:07:02 +0300 (MSK)
Received: from valesini-ubuntu.yandex-team.ru (unknown [2a02:6b8:b081:b66f::1:2])
        by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id j6K8x60OmmI0-b5Arb8C2;
        Fri, 22 Sep 2023 15:07:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
        s=default; t=1695384422;
        bh=3l3NStcQb4fAtiJh/6zDM4CwhjhPpOkhc+jebpeMr80=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=oCcdbDt0EDepOVo5vdoa1OGRI8f3yWyrRtRqH0eO5IDWQDXP6nlOII/yezTOwuGeS
         e4xhRyKskg5DpXBYMwhj+OEcbWA1TnGvxJjQv6N+cmwH/anRX63AJQ2bYdwFkC+eAN
         4ocpRkzJpKzyLnFFIM1VhvLPc2uu5ftMyARXEIqs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From:   Valentine Sinitsyn <valesini@yandex-team.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v8 1/2] kernfs: sysfs: support custom llseek method for sysfs entries
Date:   Fri, 22 Sep 2023 17:06:44 +0500
Message-Id: <20230922120645.65190-1-valesini@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As of now, seeking in sysfs files is handled by generic_file_llseek().
There are situations where one may want to customize seeking logic:

- Many sysfs entries are fixed files while generic_file_llseek() accepts
  past-the-end positions. Not only being useless by itself, this
  also means a bug in userspace code will trigger not at lseek(), but at
  some later point making debugging harder.
- generic_file_llseek() relies on f_mapping->host to get the file size
  which might not be correct for all sysfs entries.
  See commit 636b21b50152 ("PCI: Revoke mappings like devmem") as an example.

Implement llseek method to override this behavior at sysfs attribute
level. The method is optional, and if it is absent,
generic_file_llseek() is called to preserve backwards compatibility.

Cc: stable@vger.kernel.org
Signed-off-by: Valentine Sinitsyn <valesini@yandex-team.ru>
----
Perhaps this got burried to deep in the original thread [a],
resubmitting afresh.

a.
https://lore.kernel.org/all/20230814190850.948032-1-valesini@yandex-team.ru/

Changelog:
v8:
        - This is real v7; previous v7 is a buggy earlier patch sent by
          mistake
v7:
        - Use proper locking in kernfs_fop_llseek()
v6:
        - Mark pci_llseek_resource() as __maybe_unused
        - Fix a typo in pci_create_legacy_files()
v5:
        - Fix builds without PCI mmap support (e.g. Alpha)
v4:
        - Fix builds which #define HAVE_PCI_LEGACY (e.g. PowerPC)
v3:
        - Grammar fixes
        - Add base-patch: and prerequisite-patch-id: to make kernel test
          robot happy
v2:
        - Add infrastructure to customize llseek per sysfs entry type
        - Override llseek for PCI sysfs entries with fixed_file_llseek()--

 fs/kernfs/file.c       | 29 ++++++++++++++++++++++++++++-
 fs/sysfs/file.c        | 13 +++++++++++++
 include/linux/kernfs.h |  1 +
 include/linux/sysfs.h  |  2 ++
 4 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 180906c36f51..855e3f9d8dcc 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -903,6 +903,33 @@ static __poll_t kernfs_fop_poll(struct file *filp, poll_table *wait)
 	return ret;
 }
 
+static loff_t kernfs_fop_llseek(struct file *file, loff_t offset, int whence)
+{
+	struct kernfs_open_file *of = kernfs_of(file);
+	const struct kernfs_ops *ops;
+	loff_t ret;
+
+	/*
+	 * @of->mutex nests outside active ref and is primarily to ensure that
+	 * the ops aren't called concurrently for the same open file.
+	 */
+	mutex_lock(&of->mutex);
+	if (!kernfs_get_active(of->kn)) {
+		mutex_unlock(&of->mutex);
+		return -ENODEV;
+	}
+
+	ops = kernfs_ops(of->kn);
+	if (ops->llseek)
+		ret = ops->llseek(of, offset, whence);
+	else
+		ret = generic_file_llseek(file, offset, whence);
+
+	kernfs_put_active(of->kn);
+	mutex_unlock(&of->mutex);
+	return ret;
+}
+
 static void kernfs_notify_workfn(struct work_struct *work)
 {
 	struct kernfs_node *kn;
@@ -1005,7 +1032,7 @@ EXPORT_SYMBOL_GPL(kernfs_notify);
 const struct file_operations kernfs_file_fops = {
 	.read_iter	= kernfs_fop_read_iter,
 	.write_iter	= kernfs_fop_write_iter,
-	.llseek		= generic_file_llseek,
+	.llseek		= kernfs_fop_llseek,
 	.mmap		= kernfs_fop_mmap,
 	.open		= kernfs_fop_open,
 	.release	= kernfs_fop_release,
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index a12ac0356c69..6b7652fb8050 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -167,6 +167,18 @@ static int sysfs_kf_bin_mmap(struct kernfs_open_file *of,
 	return battr->mmap(of->file, kobj, battr, vma);
 }
 
+static loff_t sysfs_kf_bin_llseek(struct kernfs_open_file *of, loff_t offset,
+				  int whence)
+{
+	struct bin_attribute *battr = of->kn->priv;
+	struct kobject *kobj = of->kn->parent->priv;
+
+	if (battr->llseek)
+		return battr->llseek(of->file, kobj, battr, offset, whence);
+	else
+		return generic_file_llseek(of->file, offset, whence);
+}
+
 static int sysfs_kf_bin_open(struct kernfs_open_file *of)
 {
 	struct bin_attribute *battr = of->kn->priv;
@@ -249,6 +261,7 @@ static const struct kernfs_ops sysfs_bin_kfops_mmap = {
 	.write		= sysfs_kf_bin_write,
 	.mmap		= sysfs_kf_bin_mmap,
 	.open		= sysfs_kf_bin_open,
+	.llseek		= sysfs_kf_bin_llseek,
 };
 
 int sysfs_add_file_mode_ns(struct kernfs_node *parent,
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 2a36f3218b51..99aaa050ccb7 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -316,6 +316,7 @@ struct kernfs_ops {
 			 struct poll_table_struct *pt);
 
 	int (*mmap)(struct kernfs_open_file *of, struct vm_area_struct *vma);
+	loff_t (*llseek)(struct kernfs_open_file *of, loff_t offset, int whence);
 };
 
 /*
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index fd3fe5c8c17f..b717a70219f6 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -181,6 +181,8 @@ struct bin_attribute {
 			char *, loff_t, size_t);
 	ssize_t (*write)(struct file *, struct kobject *, struct bin_attribute *,
 			 char *, loff_t, size_t);
+	loff_t (*llseek)(struct file *, struct kobject *, struct bin_attribute *,
+			 loff_t, int);
 	int (*mmap)(struct file *, struct kobject *, struct bin_attribute *attr,
 		    struct vm_area_struct *vma);
 };

base-commit: a48fa7efaf1161c1c898931fe4c7f0070964233a
-- 
2.34.1

