Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411236B0242
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 10:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCHJEX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 04:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjCHJER (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 04:04:17 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFF2198B
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678266215; x=1709802215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IKpKIi+RDytzszzbrjWeKwDxiVX4G2UiJ0s8BP61ZHk=;
  b=FKdR2Ur7IPoHgromvSPpyN2xQKOc0jKI+Iik/PCJt3RgWgE+2CBfyVNy
   cV+pG7q1evXpSmd3Cp04l4IH+cceMaO6MeWk3PpZxMwatE28d4DlYQZck
   EPPlwGFrySnmgajKW2kla7bLwMe5G7w2gGqvcHdW0eSvrNqG8gQFIhubg
   G0g6AYwW8+7mhb3SFcvwhaUgleROimW6mqli1rXJs1DhoOnx7j92kXS24
   fFP1LzHov2GtsTxMb3ObJJyczugCQ6oRjHN7R+escEnLLY4qm1wqk1wbD
   bM8OX+TttbUM3TAdj/xRsZ0WZM33KKCjYiGTEhXVhVvwArR+ff2EVvw1W
   g==;
X-IronPort-AV: E=Sophos;i="5.98,243,1673884800"; 
   d="scan'208";a="224880535"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 17:03:19 +0800
IronPort-SDR: a39kCNWP3vTbo2V80wiIWJKIgZi5a+JSmvs5J41RMiXr/adNayOjqU1TZwMTO09tTY7rZDVQ2R
 hozPuFV8HHBU0kCVsoYibAOcOaGq7cgotYNrAz+cseCCu8sxcMGU1xG62k7NwwIHqIvAwCdajG
 amaAs0q50Bn6L8IYre7sX7IrJie6Nti3BKCjk7ctM+3SFsdCeInJrw3RWhbFranuPVFbtAd7kI
 8Mu7dPWAru5yZrTl+rnQzZ9jphmRGhc+NPhD2Scyqd5G4KrKM39QMqYIXfE7ClpXgm6YWXJ/o0
 Gsc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 00:14:16 -0800
IronPort-SDR: qWXW+YVt7VhcyCD/10iXzOx613pkXgiXs+5RtXeW+gC+W5KNIdHiTAaz/JPOxssh9WNrOku2r/
 2rnKYFoxaTNkxjv4HfppejbqEdVCLZvJ1cCIYymhXd6UumEyL7HvdrmvrembN3fJM6xvA6WkeL
 zGBC50K5/XyusxxgXW6GE0IqF5qPX9bMe2MSlCvN9+7LctfrJRhypA3hWjL/Ddetf7mvtZP/t3
 UEgktU3SGw9Ks2tzkrZZWWlx/c0mhCJD+BOnRea62yP4v0CvUB4FltDi4aueNU/S7uIOQqNg7Q
 gV0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 01:03:20 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PWmYz3TnMz1Rwt8
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:03:19 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1678266198; x=1680858199; bh=IKpKIi+RDytzszzbrj
        WeKwDxiVX4G2UiJ0s8BP61ZHk=; b=Y57hFjK/rVcDReqYVMlqXnG4xbTOblJvRL
        RC3sGQzlvokmS7QalF6+C8BPxuR9qO+NyOkL7nD8sPgE0uKAitWZN2fQK2FlVMcj
        7KP1/QhMDv5Bm7UDNj71yrCHaIMdiCk4wIZAnoHuMZuposgzkXlUhMSxCY7CFXaT
        Xwy3LOmEGU6s7Wt0RJ0UocFx2GxJztZB8HHhmhd+uB0xWWcgE5f77q/w1yN3s31M
        petZgyy1yf4PN2p/1L4ro68W6gaNWRY8CfcO/oeNiYKBPj1S5QVDE2MY0SLfRV3r
        1Di1oVLw5buhUjUWiT+np0H94vLOiBKv18Inq9pY1hpk0QRdXJOA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZHG-z1sjiOnh for <linux-pci@vger.kernel.org>;
        Wed,  8 Mar 2023 01:03:18 -0800 (PST)
Received: from ephost.wdc.com (unknown [10.225.163.68])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PWmYw6XjTz1RvTp;
        Wed,  8 Mar 2023 01:03:16 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 01/16] PCI: endpoint: Automatically create a function specific attributes group
Date:   Wed,  8 Mar 2023 18:02:58 +0900
Message-Id: <20230308090313.1653-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
References: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A PCI endpoint function driver can define function specific attributes
under its function configfs directory using the add_cfs() endpoint
driver operation. This is done by tighing up the mkdir operation for
the function configfs directory to a call to the add_cfs() operation.
However, there are no checks preventing the user from repeatedly
creating function specific attribute directories with different names,
resulting in the same endpoing specific attributes group being added
multiple times, which also result in an invalid refernce counting for
the attribute groups. E.g., using the pci-epf-ntb function driver as an
example, the user creates the function as follows:

 modprobe pci-epf-ntb
func0/
|-- baseclass_code
|-- cache_line_size
|-- ...
`-- vendorid

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

The function specific attributes are duplicated and cause a crash when
the function is tore down:

[ 9740.729598] ------------[ cut here ]------------
[ 9740.730071] refcount_t: addition on 0; use-after-free.
[ 9740.730564] WARNING: CPU: 2 PID: 834 at lib/refcount.c:25 refcount_war=
n_saturate+0xc8/0x144
[ 9740.735593] CPU: 2 PID: 834 Comm: rmdir Not tainted 6.3.0-rc1 #1
[ 9740.736133] Hardware name: Pine64 RockPro64 v2.1 (DT)
[ 9740.736586] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
[ 9740.737210] pc : refcount_warn_saturate+0xc8/0x144
[ 9740.737648] lr : refcount_warn_saturate+0xc8/0x144
[ 9740.738085] sp : ffff800009cebc90
[ 9740.738385] x29: ffff800009cebc90 x28: ffff0000019ed700 x27: ffff00000=
40c3900
[ 9740.739032] x26: 0000000000000000 x25: ffff800009325320 x24: ffff00000=
12da000
[ 9740.739678] x23: ffff000003bd9a80 x22: ffff000005ee9580 x21: ffff00000=
3bd9ad8
[ 9740.740324] x20: ffff0000f36cd2c8 x19: ffff0000012da2b8 x18: 000000000=
0000006
[ 9740.740969] x17: 0000000000000000 x16: 0000000000000000 x15: 076507650=
7720766
[ 9740.741615] x14: 072d077207650774 x13: ffff800009281000 x12: 000000000=
000056d
[ 9740.742261] x11: 00000000000001cf x10: ffff8000092d9000 x9 : ffff80000=
9281000
[ 9740.742906] x8 : 00000000ffffefff x7 : ffff8000092d9000 x6 : 80000000f=
ffff000
[ 9740.743552] x5 : ffff0000f7771b88 x4 : 0000000000000000 x3 : 000000000=
0000027
[ 9740.744197] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00000=
19ed700
[ 9740.744842] Call trace:
[ 9740.745068]  refcount_warn_saturate+0xc8/0x144
[ 9740.745475]  config_item_get+0x7c/0x80
[ 9740.745822]  configfs_rmdir+0x17c/0x30c
[ 9740.746174]  vfs_rmdir+0x8c/0x204
[ 9740.746482]  do_rmdir+0x158/0x184
[ 9740.746787]  __arm64_sys_unlinkat+0x64/0x80
[ 9740.747171]  invoke_syscall+0x48/0x114
[ 9740.747519]  el0_svc_common.constprop.0+0x44/0xec
[ 9740.747948]  do_el0_svc+0x38/0x98
[ 9740.748255]  el0_svc+0x2c/0x84
[ 9740.748541]  el0t_64_sync_handler+0xf4/0x120
[ 9740.748932]  el0t_64_sync+0x190/0x194
[ 9740.749269] ---[ end trace 0000000000000000 ]---
[ 9740.749754] ------------[ cut here ]------------

Fix this by modifying pci_epf_cfs_work() to execute the new function
pci_ep_cfs_add_type_group() which itself calls pci_epf_type_add_cfs()
to obtain the function specific attribute group and the group name
(directory name) from the endpoint function driver. If the function
driver defines an attribute group, pci_ep_cfs_add_type_group() then
proceeds to register this group using configfs_register_group(), thus
automatically exposing the function type pecific onfigfs attributes to
the user. E.g.:

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

With this change, there is no need for the user to create/delete
directories in the endpoint function configfs directory. The
pci_epf_type_group_ops group operations are thus removed.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 41 ++++++++++++++-----------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci=
-ep-cfs.c
index 4b8ac0ac84d5..b16fc6093c20 100644
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
@@ -502,34 +503,28 @@ static struct configfs_item_operations pci_epf_ops =
=3D {
 	.release		=3D pci_epf_release,
 };
=20
-static struct config_group *pci_epf_type_make(struct config_group *group=
,
-					      const char *name)
-{
-	struct pci_epf_group *epf_group =3D to_pci_epf_group(&group->cg_item);
-	struct config_group *epf_type_group;
-
-	epf_type_group =3D pci_epf_type_add_cfs(epf_group->epf, group);
-	return epf_type_group;
-}
-
-static void pci_epf_type_drop(struct config_group *group,
-			      struct config_item *item)
-{
-	config_item_put(item);
-}
-
-static struct configfs_group_operations pci_epf_type_group_ops =3D {
-	.make_group     =3D &pci_epf_type_make,
-	.drop_item      =3D &pci_epf_type_drop,
-};
-
 static const struct config_item_type pci_epf_type =3D {
-	.ct_group_ops	=3D &pci_epf_type_group_ops,
 	.ct_item_ops	=3D &pci_epf_ops,
 	.ct_attrs	=3D pci_epf_attrs,
 	.ct_owner	=3D THIS_MODULE,
 };
=20
+static void pci_ep_cfs_add_type_group(struct pci_epf_group *epf_group)
+{
+	struct config_group *group;
+
+	group =3D pci_epf_type_add_cfs(epf_group->epf, &epf_group->group);
+	if (!group)
+		return;
+
+	if (IS_ERR(group)) {
+		pr_err("failed to create epf type specific attributes\n");
+		return;
+	}
+
+	configfs_register_group(&epf_group->group, group);
+}
+
 static void pci_epf_cfs_work(struct work_struct *work)
 {
 	struct pci_epf_group *epf_group;
@@ -547,6 +542,8 @@ static void pci_epf_cfs_work(struct work_struct *work=
)
 		pr_err("failed to create 'secondary' EPC interface\n");
 		return;
 	}
+
+	pci_ep_cfs_add_type_group(epf_group);
 }
=20
 static struct config_group *pci_epf_make(struct config_group *group,
--=20
2.39.2

