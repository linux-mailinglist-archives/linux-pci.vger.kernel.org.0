Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA366974CE
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 04:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjBODWL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 22:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBODWE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 22:22:04 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C972B60B
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676431321; x=1707967321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9t4V26W1BTuWwWINggkU+hrMt8+NDJ3nkX3Khu54WcU=;
  b=O9AbTTfpAGEna2xPe6q+wZEpuIyI8z7DJhbda3Cjlv97CLPeWfWZljLg
   JriHU7Q7nkSiRHFk9w4RMr6e2Xc9DcHUi/7cr9X6WwJpFll2tjZIYCYCQ
   CpnyarsbZnmRmOMTh1hXnLboqL0oXXvk0K2qJYE88zAKiC5Gr0TtBFQOo
   RNub4tXGc5LwX2FFkpJLqyfRdQRy9TRm3XrDjQJoRftZJT4d9mq5cQuNk
   AqvhkCq2XYYLMTyuEMzt7KEoM2Yn0ns/DFXfF1OsHpq9noiFTTQY3a2CR
   YyMwACwqplMLjGRD7sj5z7VbSErtiOldcrlhjEDILAWL/MrdvlsvZFdOY
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="223351448"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 11:22:01 +0800
IronPort-SDR: xwQV5QSHseobRiQzcbIVZgQYyHzMa00XsQw14+xQf3UM5UAF8IkRVmZF0bhyVUknNaa5eR48Jk
 XaVc/T2dtlV9l03DuAnt96KlCy4BWaoBfhHmyxYAjNvOViR+/neHpB3u+S29dDa6F/Qp0oHoyi
 4K0ySS7p3w0fn2yuHwqOrRs5lomzGOFCdHVIQpg7aEQ9FlCQspuyXS8vFBLr79xuXSir9NEean
 nF3yYhUc9wYeyeU+CPApNEWPxE5weIiaXhlNngUppxhEsalmb1ADHnYJIkaaRQzj9aNIdMtdyz
 3Cg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 18:33:24 -0800
IronPort-SDR: ItWtpvgz6mt/P5xiBswSwHY/mr9UF5kGWOBzMKVhJt+iw3NjFYd+ZMw2KyjB/5Zd6/d980P/jI
 eEiWCl74en72a7jPuEpcuWKV1Tc0Bc4my3HsX+efBmndsYu9Oqqmrktw0zZwsq4UkLIYiOUqfV
 4A0fF6yUVmCZKCz3puDoh9LdIte3scOkV7YAIFZMwdf7HifbsThTSsT3gbTdsDSAgymCjwT7lP
 DbeA183B3AArsswqttxtQdP7KSqz87cQPRCt8lYHu4dG1gL3RWh1jEFBz2i7D2X93y01FokbGM
 Jr4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 19:22:00 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGjzs1n7qz1Rwtm
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:01 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1676431320; x=1679023321; bh=9t4V26W1BTuWwWINgg
        kU+hrMt8+NDJ3nkX3Khu54WcU=; b=NYgdShkICzz5D9YR4S7NXxHIJuHWJIhxNJ
        TOwhBJZqIFik3aRjNh7B/mLNpJLH3eUw71nR3MLXxEPPkaB9MtYgyq9HWIF9Huj7
        VqWTgopoKT0o76AW/CIOoON2/lhSrX/4wavpPK3NYoNTbrGpuSIQzCUI+f1RYgFM
        5/x0+sNaiyCyJxjb4dlXnbojh0xfrpdmr+zI7LetzMTynp1mIJQgTLiaZgkeqqcd
        CYsoSIHN0CqK4GY9kXET8H13MPmWlp1IJJRUmbTGeeoxQ+AgCJU6b8ADEBSfCaaw
        3DWbaZSpoxuZ2WvC6DGqmhdTAqKVE0iXJouzEVoguuoJ58H+zwGA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FQA1tqDGmdf2 for <linux-pci@vger.kernel.org>;
        Tue, 14 Feb 2023 19:22:00 -0800 (PST)
Received: from fedora.flets-east.jp (unknown [10.225.163.119])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGjzp5km3z1RvTp;
        Tue, 14 Feb 2023 19:21:58 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 01/12] pci: endpoint: Automatically create a function type attributes group
Date:   Wed, 15 Feb 2023 12:21:44 +0900
Message-Id: <20230215032155.74993-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
References: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A PCI endpoint function driver can define function specific attributes
using the add_cfs() endpoint driver operation. However, this attributes
group is not created automatically when the function is created and
rather relies on the user creating a directory within the endpoint
function configfs directory to initialize the attributes.

While working, this approach is dangerous as nothing prevents the user
from creating multiple directories with differenti (wrong) names that
all will contain the same attributes.

Fix this by modifying pci_epf_cfs_work() to execute the new function
pci_ep_cfs_add_type_group() which itself calls pci_epf_type_add_cfs() to
obtain the function specific attribute group from the function driver.
If the function driver defines an attribute group,
pci_ep_cfs_add_type_group() then proceeds to register this group using
configfs_register_group(), thus automatically exposing the configfs
attributes to the user.

With this change, there is no need for the user to create/delete
directories in the endpoint function configfs directory. The
pci_epf_type_group_ops group operations are thus removed.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 41 ++++++++++++++-----------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci=
-ep-cfs.c
index d4850bdd837f..1fb31f07199f 100644
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
2.39.1

