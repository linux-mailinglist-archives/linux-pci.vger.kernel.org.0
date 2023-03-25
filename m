Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDA36C8BF8
	for <lists+linux-pci@lfdr.de>; Sat, 25 Mar 2023 08:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjCYHCh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Mar 2023 03:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjCYHCg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Mar 2023 03:02:36 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E69914200
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679727753; x=1711263753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1e2OamP7r55F0zsilJj9y5bwk7gTaGYciJ+mu0rhE98=;
  b=kRvbWJjgax8FPuGQVQMF/NeL5bPrGyfj87LZ2EHXOufZkxZ/km0HzQaS
   UbQOajBinIdPISrdSTUm3RDrIw/qfFSo+sHYVbXLsUQl7SICSdpQY9a+W
   GKEQXTOIfLybuLD5jFstVsZBAMGGFdtlho8T12ARFT9SQZkuCRtMQhLUe
   zV/pNDpWKzqmSFvDvuchn4m+04XHpGyGVde+Y5Z0mqmHg66WneyuyuKOv
   7hmEoo40pfXui2LTy9+B1U5VeEH6laeMkAx/p3xSbLSNmf+KCCPxoorxO
   HcYCL0iixNjZ5A/AyHZpzf2YY8g86OVRzruBBCl0LlP2gLnaOm5Dmo0AR
   g==;
X-IronPort-AV: E=Sophos;i="5.98,289,1673884800"; 
   d="scan'208";a="224756679"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2023 15:02:33 +0800
IronPort-SDR: /NO65C1rKtMomlKX6ejNEOD49Rzo22lMOkmRX3EvWXqUUvW4b0vIX+Yr9uAgeKUFJo7BxTznY4
 iGGU1eR2mFcGXzBC32GPbg/cvLf1BguuRv5uStAKzxn271PmdbseIulCd6yAlxP/I4X3OTm0az
 bzkeLnA7kD8UlqbhI72ZXUA6D7HwmdqFdYFMcrPTLIsl1tR/ZC4fRiK6YKmoFI2uosKIgAYOSh
 dFhLgD+H7M3PtUUDkNe7YTA/NT95bH4FOgpUSdPrU/cDEOSxRM7PvekZIK+QOgPDPRjeErCH0y
 drY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 23:18:48 -0700
IronPort-SDR: PosaadPInUzQFFvCvqevdXjn49ruPX55Dm2hnNRLXl/Xu2h86L065uhjmJlkDZTNYSZDYvlzfZ
 yxEXMqL/sDwwsm3RbgML3arlC04puwzDA/6SG+8ANdMttVt+G2olbGOusfMIRa2FcgSyliPCo/
 fpv6fT7Hh43qgfm0IxTsq1VJuDrFwv+oR/t5hMlRGasFq8I7JJ/MDMl2+BM2Ou3V1aEstC8c8o
 Sa38NaEhyqK3gH1f8waffCtBsmEScP/+LS23WLegoL2kz1LE+7c5QCHuCRhcngopXAbB/j/675
 82Y=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2023 00:02:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pk94n2rQ8z1RtVt
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1679727751; x=1682319752; bh=1e2OamP7r55F0zsilJ
        j9y5bwk7gTaGYciJ+mu0rhE98=; b=A8pdAbjuaKZ82IdiH2QaLy1bmqtA0DY3VK
        pOf7W8sj7yUJXR+kRQtpFJd9w0KFwPJkoZta0jGCGf0p8enPa94tSCeMTPdTYubs
        Methl+2R7xCAkVlvHKb2yQth3wLF+sq3xdoqYJFD0CHnjSpgPSckgHkGodZv9CCW
        qsujkEqOVj1kASrYfx1mJt/5utlOsFudi6D+J5jjB1fGSoj6JBKJp58qlWIewB/4
        +2GLJbYGulllgaV/rhn+x4eJnnABcoY52QOu+iXuGH47BkaLkEi1WbxCepY9Cz8C
        AtAAzwOnJx3JjRfASffRYh7CKhCJ2tGxCTBM6kVf/VWz7YYSQIoQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DK7yuC5Lqy1n for <linux-pci@vger.kernel.org>;
        Sat, 25 Mar 2023 00:02:31 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pk94j5w4bz1RtVn;
        Sat, 25 Mar 2023 00:02:29 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 01/16] PCI: endpoint: Automatically create a function specific attributes group
Date:   Sat, 25 Mar 2023 16:02:11 +0900
Message-Id: <20230325070226.511323-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230325070226.511323-1-damien.lemoal@opensource.wdc.com>
References: <20230325070226.511323-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

The documentation for the pci-epf-ntb and pci-epf-vntb function drivers
are updated to reflect this change, removing the explanations showing
the need to manually create the sub-directory for the function specific
attributes.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 Documentation/PCI/endpoint/pci-ntb-howto.rst  | 11 ++---
 Documentation/PCI/endpoint/pci-vntb-howto.rst | 13 +++---
 drivers/pci/endpoint/pci-ep-cfs.c             | 41 +++++++++----------
 3 files changed, 28 insertions(+), 37 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-ntb-howto.rst b/Documentation=
/PCI/endpoint/pci-ntb-howto.rst
index 1884bf29caba..4261e7157ef1 100644
--- a/Documentation/PCI/endpoint/pci-ntb-howto.rst
+++ b/Documentation/PCI/endpoint/pci-ntb-howto.rst
@@ -88,13 +88,10 @@ commands can be used::
 	# echo 0x104c > functions/pci_epf_ntb/func1/vendorid
 	# echo 0xb00d > functions/pci_epf_ntb/func1/deviceid
=20
-In order to configure NTB specific attributes, a new sub-directory to fu=
nc1
-should be created::
-
-	# mkdir functions/pci_epf_ntb/func1/pci_epf_ntb.0/
-
-The NTB function driver will populate this directory with various attrib=
utes
-that can be configured by the user::
+The PCI endpoint framework also automatically creates a sub-directory in=
 the
+function attribute directory. This sub-directory has the same name as th=
e name
+of the function device and is populated with the following NTB specific
+attributes that can be configured by the user::
=20
 	# ls functions/pci_epf_ntb/func1/pci_epf_ntb.0/
 	db_count    mw1         mw2         mw3         mw4         num_mws
diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentatio=
n/PCI/endpoint/pci-vntb-howto.rst
index 4ab8e4a26d4b..70d3bc90893f 100644
--- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
+++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
@@ -84,13 +84,10 @@ commands can be used::
 	# echo 0x1957 > functions/pci_epf_vntb/func1/vendorid
 	# echo 0x0809 > functions/pci_epf_vntb/func1/deviceid
=20
-In order to configure NTB specific attributes, a new sub-directory to fu=
nc1
-should be created::
-
-	# mkdir functions/pci_epf_vntb/func1/pci_epf_vntb.0/
-
-The NTB function driver will populate this directory with various attrib=
utes
-that can be configured by the user::
+The PCI endpoint framework also automatically creates a sub-directory in=
 the
+function attribute directory. This sub-directory has the same name as th=
e name
+of the function device and is populated with the following NTB specific
+attributes that can be configured by the user::
=20
 	# ls functions/pci_epf_vntb/func1/pci_epf_vntb.0/
 	db_count    mw1         mw2         mw3         mw4         num_mws
@@ -103,7 +100,7 @@ A sample configuration for NTB function is given belo=
w::
 	# echo 1 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
 	# echo 0x100000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
=20
-A sample configuration for virtual NTB driver for virutal PCI bus::
+A sample configuration for virtual NTB driver for virtual PCI bus::
=20
 	# echo 0x1957 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
 	# echo 0x080A > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_pid
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

