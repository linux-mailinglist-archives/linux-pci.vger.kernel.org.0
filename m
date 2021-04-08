Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F69358C1E
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 20:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhDHSYD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 14:24:03 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:19060 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231676AbhDHSYC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 14:24:02 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138ICRHY030405;
        Thu, 8 Apr 2021 11:23:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=sMm/8wCQ5emWBlBd0qwh3UKAPvKxQVHyyLFdn/v7HLg=;
 b=S8KeCMwLMbMNOUPWVAzGCTXKR3FyQX+NxJHvZwBBM58Dm06hP2rQPvtnzfBJujeuZJA4
 4taFw5TmNUIgjAdrsJ5hjnlMmS5Hm2E5IvgfgmXMEDklObSheVkp07DN5QBU8ectd9Gh
 c+VjVySuzz+gPaYWF/ipQB8zdAKbtgaIz3Kle8PscFFh2SOMc8QoF6dq5n8Wcg7/nM9C
 N4eyZ2MK9Bsin/FYXuv255L2bz6b9x4gSfvoXVe0CR1yH6UwDonOvLspIi+v1ygHl1Js
 vPgZpYrnGT0SuO+OtxqzQxggRwk1FvFwUhwqSrROe1y0nHz8XjkRLOIxV8QDWb6Urnqt jQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-002c1b01.pphosted.com with ESMTP id 37sw981ggk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 11:23:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsmzuDvjy1jpTJhMQW2ZbGDcZpe74LThBvsGS69T8tU2XK6cyMu5sz5M5QlngovKBiArRzqK/oMdncc5Mm8qTZo2WtQ9SXw4eNMoMNWhhq7JpKjDHQ5xIWncFF8ifMjFYcKL0LgoADr6ntDspFcVDC8KnQE/hO0kF9nEh2ctuhcUY01GXooUPOklpcMspQZ//X44HvT5AtT3yam7sn+/6z2GfwScuQH5oSa49+f+Ju7waoS3GFZamf4fBX0JP5z02/ffZNK6w7UO0guEimEh/PR1cCQPx9McDIMq6LTIvzjWIZi4InYCJQ2Be7RQYh1UQVK+yNLON5ma+Wdew5wajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMm/8wCQ5emWBlBd0qwh3UKAPvKxQVHyyLFdn/v7HLg=;
 b=NqsMxZVQ9q0/bdL57yuKXhtXZXYots/QvVjS8DqvgUuelte1+JGWspcrIOQLS5A8tSfiXTVIvpdjHmRidVm6zD3G/FsN/IJHq+BvpYGdfWj2iHxTsMhs3IoDz+jAy+CqnzI7R2G1fTGk3Q/3+Vm8nX0jRN+0e4pFE/G3uzvSLm+27hGH1GRqcd91NsTDBFFwp8/9OiIjpLmtte3t4HvITjG+hgb2S5V0nAMRK6t/rXPHaENJhFkyrIvvbzh1moR+4YPyJPrMKzQSyIFE1Ca/ogR5cyoF9CQpbTkNsRkP/D42JmGxA4C6sKVoQc+2FxL0bmHjBYydshlFhwu6HlkauA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from SN6PR02MB4543.namprd02.prod.outlook.com (2603:10b6:805:b1::24)
 by SN6PR02MB4942.namprd02.prod.outlook.com (2603:10b6:805:96::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Thu, 8 Apr
 2021 18:23:40 +0000
Received: from SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::7139:d6a4:cf94:c4b1]) by SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::7139:d6a4:cf94:c4b1%4]) with mapi id 15.20.3999.034; Thu, 8 Apr 2021
 18:23:40 +0000
From:   Raphael Norwitz <raphael.norwitz@nutanix.com>
To:     "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "ameynarkhede03@gmail.com" <ameynarkhede03@gmail.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v2] PCI: merge slot and bus reset implementations
Thread-Topic: [PATCH v2] PCI: merge slot and bus reset implementations
Thread-Index: AQHXLKRMegmdSIbwh0yUAOjSYPt99g==
Date:   Thu, 8 Apr 2021 18:23:40 +0000
Message-ID: <20210408182328.12323-1-raphael.norwitz@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [24.94.68.249]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8df34df-1938-410d-688d-08d8fabb6f76
x-ms-traffictypediagnostic: SN6PR02MB4942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR02MB4942D66308BB2FBE9B23DF24EA749@SN6PR02MB4942.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lT2hWjVURWP7HqKvQLlc8w7wSx1qJ2WbYzspBvfHuU78phsbnb526FQytAGNMjxEN28ZYosF+67Kzg2RJs5Q0R70ICsMBmLv8jekOHECQYZLo4iG165aCHP+AXcbGoSSwvjX5zCQE7H8ylKSiPgz8by+QMtt4RJUaCNRVCgl0F1I35xePW/7xXrkMhV1RuYOfuMS6znGz8P2Mi+W85uORLUQWfhfaKgZ0xrtT0tvoxuhXy+oSMX+cg7h+V5jlM+Dv3f5tGBVp9x46Q0IgZrXVko5dnY1abSlyn5Cd36JAmzpBopPWcthkgy9LgNwnnwnQH/RRx1XeV6AQdZv2uGKgArs2j0fm397068t3nUno46gQM+6wHA3173kz80NyPAkxNj2mQVvqVoRG+BTVCXmj+2Fnuv92N2FV/IvPEXELwCORzOgL0NHaRyxdtJ7XZpNqXuVCzSXdvc6w7wtG1JA1S+53+CFZQF2iCp5r3YO1pu+2X689X1RAHjyBWR70/WPIdGEDoMe3ObOeDAHDxilGav+p9S18mlMYirpt6p3Hf4gtdkKRMhwqaUPEUJLirqqJpMfRTSaAZJ1YmCXJYuBmo48cfU8HnR47wHim1ZTxGz+vaWjFVXifj8ARBUC6TMv4nKrkCG2sPvb6d2rM2k6E6YU0XGv9266mZx2UkbdYX6O9cfMjOUokpntZdp9BcHXeOQUpjvTDQMErTLNBAa/ITVj168NrFBifVqpU/cHmTs7DzAw0QtBmoa6vQ+XUMKC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4543.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(346002)(39860400002)(366004)(966005)(66946007)(38100700001)(2616005)(4326008)(76116006)(8676002)(66556008)(66476007)(44832011)(6506007)(86362001)(91956017)(36756003)(478600001)(64756008)(54906003)(8936002)(2906002)(6916009)(66446008)(6486002)(316002)(107886003)(1076003)(6512007)(71200400001)(26005)(5660300002)(83380400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?VdipimDS1/MqS3dzMDCJ6IU8Hyd+sYyPuEzuRLZDu8T+ZN1m5vQB5BAvQr?=
 =?iso-8859-1?Q?smT7+5mVl8VTi0GHj3y7V0UFI76MaG1iJ4Y52layM/vINjfQOcTWg/tjvn?=
 =?iso-8859-1?Q?9dW12GKRH+hGdUiSk40gxnI+dXfCKHqISTQ1LRfkqdrTHg6BFfFC5ly9qt?=
 =?iso-8859-1?Q?T1XMn/Qao7z3inQXNGDO/0bnUWEoFZWSIU7DgNQHOtcK2iWN3TgPbNfwEs?=
 =?iso-8859-1?Q?uHs4bHnixJCfYc2e52V9KCoNJelOh5RoUhOh2f33nN3nOm2OxcTPk8Qyei?=
 =?iso-8859-1?Q?s18wb4DfTrXQe7uj0Ey902PHJAd7Z3Xn3yKxt4tYplHFfSgpjlZiFoTShN?=
 =?iso-8859-1?Q?pNkD+wGXREMqoDjhgWRvg7JgHG594SKPZXFs7k4HLGPCynm8EJ0/nva3oQ?=
 =?iso-8859-1?Q?zZH6X27PZwghFHGqw8dcytVP1UYsH/YaYKKFgSkGdnn8B/SFI7yxxl8QGy?=
 =?iso-8859-1?Q?sQjSft6NIL00f3d78gEmoAnrDWszm/fDK9Gg/BrXO6p4OmeL4kUuKEi25f?=
 =?iso-8859-1?Q?DvqKbnlH1Pe63FiBajQ3h9MUyQdL16MszaTkLNiHbvEN+M3gBdUC+en5Hx?=
 =?iso-8859-1?Q?Bn6Foz/pjB0R3NczYqkyqlz8KpX13utqNyr+Nawo5WdGAz00V8ZrTJWRVd?=
 =?iso-8859-1?Q?cTtK1QBVJejiySfenaRscw6M+h6GD3HTVIY5rGfqRgUokDVAx/YY0cbGaL?=
 =?iso-8859-1?Q?+++56q8vP1Nhj+qGbfaNSGESU5V90lKrU9NdudPpK2VWIGVsRy2PwDvyH7?=
 =?iso-8859-1?Q?lyHkZjJZqwRsT+GnEL075KErErRuCubYJFFn3JosUFKTuOQAqzCTs+9EkD?=
 =?iso-8859-1?Q?I8Kcn9qGAR80B/H+HZ6ndDzn4nFNDFd7QpzVGjvWe2ElQqewt53iHRhF6m?=
 =?iso-8859-1?Q?j6RS/Gai1clZOd1g0GL2EJdJaMY7B7HOUUeOgXfFiPaGNrD0le5RiZCMvx?=
 =?iso-8859-1?Q?nnkM2jC13mqv/ORmai3zeihDcq6vCw2fpMrGrJ9mOwtDgKcP7FFWznSEvx?=
 =?iso-8859-1?Q?bcOJbvYbxzDr4SMKsboo7EjZrUr8m2LHSMO5yykXU/KrlZh40mEe6KNQJA?=
 =?iso-8859-1?Q?BXya1uaDkOtHibi2bGwWpcdZveFaam1sPJabmWx/FmShllGuyWuxz52SmA?=
 =?iso-8859-1?Q?6WbqtG624IEQSBvwoBzAOtsVfVzf9go/Qc/WxzvPbeCL+3/BGz2TWiFqCn?=
 =?iso-8859-1?Q?FuoA9f4j0hY98ckSdUPKazPZAnTOdMkZG/k689uCks87rdZrfUk3Vn4S/1?=
 =?iso-8859-1?Q?/HvLF4Dn9BcscQBP6jDNp7mDYvfoyMiA+QbqKRa+IBScZ1ICcJLAdstRln?=
 =?iso-8859-1?Q?bkfU0TyTNsAr5Y9MN2C1txMHdblHIOUkNC8HyM/ANGDN611kgjtVY8LRqw?=
 =?iso-8859-1?Q?8J2nmpIpXi?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4543.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8df34df-1938-410d-688d-08d8fabb6f76
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 18:23:40.7585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VTNdPa3nCk+Tsr1UDLzBmf/fvRC8I3ayfcV90DSLP4wL3FguT6W8wpchePH2EnATVAoc/G9SWJjCLysgRbFv3vFxWaKddgDLzwcJX5MCViA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4942
X-Proofpoint-ORIG-GUID: 2gUrDDLyTDSiwx3MIudJEvKeefsyvdzK
X-Proofpoint-GUID: 2gUrDDLyTDSiwx3MIudJEvKeefsyvdzK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_04:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Slot resets are bus resets with additional logic to prevent a device
from being removed during the reset. Currently slot and bus resets have
separate implementations in pci.c, complicating higher level logic. As
discussed on the mailing list, they should be combined into a generic
function which performs an SBR. This change adds a function,
pci_reset_bus_function(), which first attempts a slot reset and then
attempts a bus reset if -ENOTTY is returned, such that there is now a
single device agnostic function to perform an SBR.

This new function is also needed to add SBR reset quirks and therefore
is exposed in pci.h.

Link: https://lkml.org/lkml/2021/3/23/911

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 drivers/pci/pci.c   | 19 +++++++++++--------
 include/linux/pci.h |  1 +
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 16a17215f633..a8f8dd588d15 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4982,6 +4982,15 @@ static int pci_dev_reset_slot_function(struct pci_de=
v *dev, int probe)
 	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
 }
=20
+int pci_reset_bus_function(struct pci_dev *dev, int probe)
+{
+	int rc =3D pci_dev_reset_slot_function(dev, probe);
+
+	if (rc !=3D -ENOTTY)
+		return rc;
+	return pci_parent_bus_reset(dev, probe);
+}
+
 static void pci_dev_lock(struct pci_dev *dev)
 {
 	pci_cfg_access_lock(dev);
@@ -5102,10 +5111,7 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 	rc =3D pci_pm_reset(dev, 0);
 	if (rc !=3D -ENOTTY)
 		return rc;
-	rc =3D pci_dev_reset_slot_function(dev, 0);
-	if (rc !=3D -ENOTTY)
-		return rc;
-	return pci_parent_bus_reset(dev, 0);
+	return pci_reset_bus_function(dev, 0);
 }
 EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
=20
@@ -5135,13 +5141,10 @@ int pci_probe_reset_function(struct pci_dev *dev)
 	if (rc !=3D -ENOTTY)
 		return rc;
 	rc =3D pci_pm_reset(dev, 1);
-	if (rc !=3D -ENOTTY)
-		return rc;
-	rc =3D pci_dev_reset_slot_function(dev, 1);
 	if (rc !=3D -ENOTTY)
 		return rc;
=20
-	return pci_parent_bus_reset(dev, 1);
+	return pci_reset_bus_function(dev, 1);
 }
=20
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 86c799c97b77..979d54335ac1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1228,6 +1228,7 @@ int pci_probe_reset_bus(struct pci_bus *bus);
 int pci_reset_bus(struct pci_dev *dev);
 void pci_reset_secondary_bus(struct pci_dev *dev);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
+int pci_reset_bus_function(struct pci_dev *dev, int probe);
 void pci_update_resource(struct pci_dev *dev, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
 int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resourc=
e_size_t add_size, resource_size_t align);
--=20
2.20.1
