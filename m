Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396716E2E9C
	for <lists+linux-pci@lfdr.de>; Sat, 15 Apr 2023 04:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjDOCfu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 22:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjDOCft (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 22:35:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBED2F1
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 19:35:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8859E64079
        for <linux-pci@vger.kernel.org>; Sat, 15 Apr 2023 02:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9BFC4339C;
        Sat, 15 Apr 2023 02:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681526147;
        bh=QKCTmwgEhdmPDd8Sw+UBV1l5V9URQT9GREzq8OGv0Xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hOZ5U5pzE4IYJiJYNzeBlT0hya3PdmEarY+OLopYjLodUck0jUkvZ0QDd0xdTdgSj
         /7pkqdz5SR6nI9SllGPFAsdfinGDXjQVpFTUW1JLqdYhEEleAz/PVvMyy8a+7/0Gek
         oe0r764DYj8Ic8I/mIxQf8Uk6J4LlYqkEOv57qE279x8HX3M1lOePqQ7tR7GqVShud
         X7EAP7nZ23gUJ0MBeS0GdkpwI8SyzDbUUY7qGkuSa3VIrjtCYyRk28XiUBpXTrYfbp
         UkTVlTMyFGZNpibQ0ozaZgeC3CGJm1nm8n4D1L5FqlMiHuD8JJw1FRHjlElbkNkWyD
         t6+gJOjnaNh+Q==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 01/17] PCI: endpoint: Automatically create a function specific attributes group
Date:   Sat, 15 Apr 2023 11:35:26 +0900
Message-Id: <20230415023542.77601-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230415023542.77601-1-dlemoal@kernel.org>
References: <20230415023542.77601-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A PCI endpoint function driver can define function specific attributes
under its function configfs directory using the add_cfs() endpoint
driver operation. This is done by tying up the mkdir operation for
the function configfs directory to a call to the add_cfs() operation.
However, there are no checks preventing the user from repeatedly
creating function specific attribute directories with different names,
resulting in the same endpoint specific attributes group being added
multiple times, which also result in an invalid reference counting for
the attribute groups. E.g., using the pci-epf-ntb function driver as an
example, the user creates the function as follows:

$ modprobe pci-epf-ntb
$ cd /sys/kernel/config/pci_ep/functions/pci_epf_ntb
$ mkdir func0
$ tree func0
func0/
|-- baseclass_code
|-- cache_line_size
|-- ...
`-- vendorid

$ mkdir func0/attrs
$ tree func0
func0/
|-- attrs
|   |-- db_count
|   |-- mw1
|   |-- mw2
|   |-- mw3
|   |-- mw4
|   |-- num_mws
|   `-- spad_count
|-- baseclass_code
|-- cache_line_size
|-- ...
`-- vendorid

At this point, the function can be started by linking the EP controller.
However, if the user mistakenly creates again a directory:

$ mkdir func0/attrs2
$ tree func0
func0/
|-- attrs
|   |-- db_count
|   |-- mw1
|   |-- mw2
|   |-- mw3
|   |-- mw4
|   |-- num_mws
|   `-- spad_count
|-- attrs2
|   |-- db_count
|   |-- mw1
|   |-- mw2
|   |-- mw3
|   |-- mw4
|   |-- num_mws
|   `-- spad_count
|-- baseclass_code
|-- cache_line_size
|-- ...
`-- vendorid

The endpoint function specific attributes are duplicated and cause a
crash when the endpoint function device is torn down:

refcount_t: addition on 0; use-after-free.
WARNING: CPU: 2 PID: 834 at lib/refcount.c:25 refcount_warn_saturate+0xc8/0x144
CPU: 2 PID: 834 Comm: rmdir Not tainted 6.3.0-rc1 #1
Hardware name: Pine64 RockPro64 v2.1 (DT)
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
...
Call trace:
refcount_warn_saturate+0xc8/0x144
config_item_get+0x7c/0x80
configfs_rmdir+0x17c/0x30c
vfs_rmdir+0x8c/0x204
do_rmdir+0x158/0x184
__arm64_sys_unlinkat+0x64/0x80
invoke_syscall+0x48/0x114
...

Fix this by modifying pci_epf_cfs_work() to execute the new function
pci_ep_cfs_add_type_group() which itself calls pci_epf_type_add_cfs()
to obtain the function specific attribute group and the group name
(directory name) from the endpoint function driver. If the function
driver defines an attribute group, pci_ep_cfs_add_type_group() then
proceeds to register this group using configfs_register_group(), thus
automatically exposing the function type specific configfs attributes
to the user. E.g.:

$ modprobe pci-epf-ntb
$ cd /sys/kernel/config/pci_ep/functions/pci_epf_ntb
$ mkdir func0
$ tree func0
func0/
|-- baseclass_code
|-- cache_line_size
|-- ...
|-- pci_epf_ntb.0
|   |-- db_count
|   |-- mw1
|   |-- mw2
|   |-- mw3
|   |-- mw4
|   |-- num_mws
|   `-- spad_count
|-- primary
|-- ...
`-- vendorid

With this change, there is no need for the user to create or delete
directories in the endpoint function attributes directory. The
pci_epf_type_group_ops group operations are thus removed.

alos update the documentation for the pci-epf-ntb and pci-epf-vntb
function drivers to reflect this change, removing the explanations
showing the need to manually create the sub-directory for the function
specific attributes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 Documentation/PCI/endpoint/pci-ntb-howto.rst  | 11 ++---
 Documentation/PCI/endpoint/pci-vntb-howto.rst | 13 +++---
 drivers/pci/endpoint/pci-ep-cfs.c             | 42 +++++++++----------
 3 files changed, 29 insertions(+), 37 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-ntb-howto.rst b/Documentation/PCI/endpoint/pci-ntb-howto.rst
index 1884bf29caba..4261e7157ef1 100644
--- a/Documentation/PCI/endpoint/pci-ntb-howto.rst
+++ b/Documentation/PCI/endpoint/pci-ntb-howto.rst
@@ -88,13 +88,10 @@ commands can be used::
 	# echo 0x104c > functions/pci_epf_ntb/func1/vendorid
 	# echo 0xb00d > functions/pci_epf_ntb/func1/deviceid
 
-In order to configure NTB specific attributes, a new sub-directory to func1
-should be created::
-
-	# mkdir functions/pci_epf_ntb/func1/pci_epf_ntb.0/
-
-The NTB function driver will populate this directory with various attributes
-that can be configured by the user::
+The PCI endpoint framework also automatically creates a sub-directory in the
+function attribute directory. This sub-directory has the same name as the name
+of the function device and is populated with the following NTB specific
+attributes that can be configured by the user::
 
 	# ls functions/pci_epf_ntb/func1/pci_epf_ntb.0/
 	db_count    mw1         mw2         mw3         mw4         num_mws
diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
index 4ab8e4a26d4b..70d3bc90893f 100644
--- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
+++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
@@ -84,13 +84,10 @@ commands can be used::
 	# echo 0x1957 > functions/pci_epf_vntb/func1/vendorid
 	# echo 0x0809 > functions/pci_epf_vntb/func1/deviceid
 
-In order to configure NTB specific attributes, a new sub-directory to func1
-should be created::
-
-	# mkdir functions/pci_epf_vntb/func1/pci_epf_vntb.0/
-
-The NTB function driver will populate this directory with various attributes
-that can be configured by the user::
+The PCI endpoint framework also automatically creates a sub-directory in the
+function attribute directory. This sub-directory has the same name as the name
+of the function device and is populated with the following NTB specific
+attributes that can be configured by the user::
 
 	# ls functions/pci_epf_vntb/func1/pci_epf_vntb.0/
 	db_count    mw1         mw2         mw3         mw4         num_mws
@@ -103,7 +100,7 @@ A sample configuration for NTB function is given below::
 	# echo 1 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
 	# echo 0x100000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
 
-A sample configuration for virtual NTB driver for virutal PCI bus::
+A sample configuration for virtual NTB driver for virtual PCI bus::
 
 	# echo 0x1957 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
 	# echo 0x080A > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_pid
diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 4b8ac0ac84d5..e255a8415bd5 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -23,6 +23,7 @@ struct pci_epf_group {
 	struct config_group group;
 	struct config_group primary_epc_group;
 	struct config_group secondary_epc_group;
+	struct config_group *type_group;
 	struct delayed_work cfs_work;
 	struct pci_epf *epf;
 	int index;
@@ -502,34 +503,29 @@ static struct configfs_item_operations pci_epf_ops = {
 	.release		= pci_epf_release,
 };
 
-static struct config_group *pci_epf_type_make(struct config_group *group,
-					      const char *name)
-{
-	struct pci_epf_group *epf_group = to_pci_epf_group(&group->cg_item);
-	struct config_group *epf_type_group;
-
-	epf_type_group = pci_epf_type_add_cfs(epf_group->epf, group);
-	return epf_type_group;
-}
-
-static void pci_epf_type_drop(struct config_group *group,
-			      struct config_item *item)
-{
-	config_item_put(item);
-}
-
-static struct configfs_group_operations pci_epf_type_group_ops = {
-	.make_group     = &pci_epf_type_make,
-	.drop_item      = &pci_epf_type_drop,
-};
-
 static const struct config_item_type pci_epf_type = {
-	.ct_group_ops	= &pci_epf_type_group_ops,
 	.ct_item_ops	= &pci_epf_ops,
 	.ct_attrs	= pci_epf_attrs,
 	.ct_owner	= THIS_MODULE,
 };
 
+static void pci_ep_cfs_add_type_group(struct pci_epf_group *epf_group)
+{
+	struct config_group *group;
+
+	group = pci_epf_type_add_cfs(epf_group->epf, &epf_group->group);
+	if (!group)
+		return;
+
+	if (IS_ERR(group)) {
+		dev_err(&epf_group->epf->dev,
+			"failed to create epf type specific attributes\n");
+		return;
+	}
+
+	configfs_register_group(&epf_group->group, group);
+}
+
 static void pci_epf_cfs_work(struct work_struct *work)
 {
 	struct pci_epf_group *epf_group;
@@ -547,6 +543,8 @@ static void pci_epf_cfs_work(struct work_struct *work)
 		pr_err("failed to create 'secondary' EPC interface\n");
 		return;
 	}
+
+	pci_ep_cfs_add_type_group(epf_group);
 }
 
 static struct config_group *pci_epf_make(struct config_group *group,
-- 
2.39.2

