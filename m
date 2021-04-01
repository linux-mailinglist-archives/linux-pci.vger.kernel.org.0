Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F71350E7B
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 07:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhDAFhn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 01:37:43 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:41602 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229539AbhDAFhW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 01:37:22 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1315VsLt032363;
        Wed, 31 Mar 2021 22:37:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=+lEEwQkCwc2B7mV9NLEEZnOByR21MjCyntO2vF/WIwY=;
 b=iNOChZAluwjt4SDKHqZV1CkmpHxp95QGnCiw4P0+JbUICr+pElthhGhj8vNt3iwQ5x7Y
 M/sPe5M+Qu6VbJ8UjgTwyN4rmxwjLsqsHScZKp2u+jz6xndzdgAX+f10PWHWdj5phb8H
 S33qQW6DBYmk7d67s/gDeB2858VjibG9kLImgC7Xt+Y1iS6SGLvMWipOiLvxwrsw5o8P
 e6xEqFS3yQWB+XQnIJohP3qLKEYbkVdUgiBB6Yc52ndTOxu90c8ORtsYV/14dbH5Dks9
 7+AgVMIO9idqnQ63hv8HlLlCam9h1+52tRoufZgomAiRC+bt9CEURnWqyQCQ4k8rZ9Ta TA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0b-002c1b01.pphosted.com with ESMTP id 37n28urp37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Mar 2021 22:37:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNTl4H1NhdbJ31k3AzjtZzK/SPfg98YCEyFNkLIX2nOApRbrGvt6The4cOR+z0qX79MdZq8c81N+GnG7kcu3XGvCS1QOb+5i6khdkluRyXUj/VV41n3rhRRzjS1ZCAOjWUsRCE5fHkMOR92HKGGOIS1ke2eHSMetW3tUPLSqWR6ibW2Dan/0/IZkqLT4BZITuoBe5iKD80FtuOTulVGi31jjKxvL3m2jhPQGe0ErB+tul4e4PbO3VqTu7AXmxxY1DhzA4gCKKcAUZkQFk954RHXxwu5AmTlpqpw5yMjr4HHciUwHYdmEwSVvrQgChwXQPBl2tdJkLGIhT2lFBX/yPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lEEwQkCwc2B7mV9NLEEZnOByR21MjCyntO2vF/WIwY=;
 b=GKQYbJUWLuicwmRShs9tdzLyeOq8gk7Ex70o/ogUP9egr1PdlBVab1TgZwfgLtkkLeqw9ycXpfiisKAtqlkkkKNrdHTrWuxtz9QloGVRarGEiKmFUm28xPg/BaIeV0HBgejsD7zN8wZh/FJikh0UBafTPe8QOrdzyrwJB79LQ07eeKvRnk9rjHE/hAfRxpXjs+aGa/t96jcZli0FnqfFOmnM+H/6XAhi0/p4H7FtXzkd7PIIQs6rb8DVCGPsetA4nZPBUqX+R5xaPt+NcXaLQoAOQNDUfRppt7CO0jZPUlS831ZT9SyBydKDpY1Fdcl3xua5psH6Q5WydN5d7m9K3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from SN6PR02MB4543.namprd02.prod.outlook.com (2603:10b6:805:b1::24)
 by SN1PR02MB3679.namprd02.prod.outlook.com (2603:10b6:802:31::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 05:37:16 +0000
Received: from SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::7139:d6a4:cf94:c4b1]) by SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::7139:d6a4:cf94:c4b1%4]) with mapi id 15.20.3999.027; Thu, 1 Apr 2021
 05:37:16 +0000
From:   Raphael Norwitz <raphael.norwitz@nutanix.com>
To:     "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "ameynarkhede03@gmail.com" <ameynarkhede03@gmail.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH] PCI: merge slot and bus reset implementations
Thread-Topic: [PATCH] PCI: merge slot and bus reset implementations
Thread-Index: AQHXJrkTV5QyceIJbEKfiTx8AA1Kaw==
Date:   Thu, 1 Apr 2021 05:37:16 +0000
Message-ID: <20210401053656.16065-1-raphael.norwitz@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [98.151.208.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f350b4a8-e734-4a1f-d1cd-08d8f4d0359f
x-ms-traffictypediagnostic: SN1PR02MB3679:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR02MB3679F62567CCFE88DB386364EA7B9@SN1PR02MB3679.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1jaXpiPnbnAfX/UrHlnagj1F4UcsIRdH6+gYSsy9x5p+QcoGLnSEey2sHJ6J3QkXoEAy92YeFmr4TyYqkCKARJEg+5oI0hDH0WaPHL5UiW7U10F2Ad7lCPX4nYQQWZwRL6VS9pkODc5z56oXbNlPEioulTgfEVEtRTdecWsgkxKleemHqGqtKSFA5xHuGxEmgIKFFS2W28GTDQcQn+5MUby6VFxjWhU986pM2KTpGmxSWR2eEx9/KQvvkNee3/pEr/L0F5Tt1OOQdMkyjupEtfU4fSqNMa/dUN7TX87im9A5+vNCGAw0pIzr6XBJyjB2gV49FcTpOcMXHZQM/UewuL25JWJEpj6Z1ONfSsxR8ossIQwFAehdrTYTKzhFrVAbwO99X10nM2KjU3eCwAu6vxJvsDkTMKo3YpHX2x3aUZPM5UrXUDsjNnCfzj5PkEPFgBfyuXTJpu/KbS/gO6wjH7Y1B4FQrRWPW+didU3XludyLHw2Nz0TZPAh1blNQy8A4HMOU//2ox3Q2g4FXKsbBuCldhx1mgXZNecexRyNx5N6qXWa6wKfqwaB0VHwgW69rmLgCQQ7GjNKs+X2H9RmjVLdHOOcndgekwdL6bBt75O26wxCnnogmdKvt5HT2MNqHw7U+CsBJ+hoHUr0Y6pKVPQ9ADn7Y1dyicMg4IhtLXVZGIf9BHsLfBLq7ob7hqXjZJ1ZcQ5ESMgBy4/rPAXW5tMBa79/T6ozRHyrVE73cfI2bsIwdLZHB3S2WhCine9V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4543.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(39840400004)(346002)(376002)(64756008)(66446008)(91956017)(76116006)(316002)(66556008)(66946007)(66476007)(54906003)(966005)(478600001)(5660300002)(1076003)(71200400001)(6506007)(6512007)(6486002)(186003)(4326008)(2616005)(107886003)(44832011)(83380400001)(86362001)(8676002)(6916009)(8936002)(36756003)(38100700001)(2906002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?qjfXNoESKQuGrytPAB9dBXO/WY8x23+xO7UwvmTTSjGj9ogy+TXUWHx1Jq?=
 =?iso-8859-1?Q?AJIIhTFoDgLe7j3OtGhZ9xJggni9LIOkLjhX//dhoB9ofrpIArqYwLSr13?=
 =?iso-8859-1?Q?DzrKrsip9sIi16x8er5O+7lXAsFpwtP9IWBjUQxQedija1kGDBm3hPpyLH?=
 =?iso-8859-1?Q?6G2/vdX5WM8ASaebwib31/XOoD7Vsy911fxFd3Y3x4l7aXj4fbC8lBDGnw?=
 =?iso-8859-1?Q?8QCkmzPuJrb9cYFO3zZQNJ0KWBgxpit1Y31qDAvvKq058P4rE/XwQ06fj1?=
 =?iso-8859-1?Q?YiWTJtrFY0O5vFpf9XVVUBibikhocWKeirqtP/eZ8m8jqzybKktyBezBCx?=
 =?iso-8859-1?Q?2whgdTKURvNw9kl4jvZOGR3WLbHBmcNIgO7iiwZKo29bIpYRbOZoQKwDvI?=
 =?iso-8859-1?Q?qGjs8ir/Tfky8saHkLonvKQ+3LRl0SjhM0fAY8utNa3Rq64n5Onb8Xw2D0?=
 =?iso-8859-1?Q?qSCmLa/uHa2YguBlQYVDbpbjw6BY1s5gBs7dphjM8Re5ackXwibBcDKoXt?=
 =?iso-8859-1?Q?SYwrLMDCTzRyATtdORBK73umfRAy0663iRHNlTuIQKthT/5nSy33WtnZcD?=
 =?iso-8859-1?Q?IvMNaYDqvf02uIoM++LFcpRXP6Qj1VuwE2B1W4jXmvK56Agg7TYj1Q3NB2?=
 =?iso-8859-1?Q?6EEzzBuS5y+nZeupoGO5yAEaM1ASAjZ6SsvmaNuOrZp6KebqnKg+zFaWGz?=
 =?iso-8859-1?Q?T7C4HHzxK6fXuIakXe+pvpUNYScQyIEb/d2ys1havP6PuamnoS0hEgBfKI?=
 =?iso-8859-1?Q?daYlHTXM9VPI0kxa4fpoICQSyy8s+mJGw+oA8bSinNAi9LUJHKL6ONBheT?=
 =?iso-8859-1?Q?W9Mk/p92oKJwbGbMUKIgLIuHSvjFbKWR856xmeEwdMsyfqGofGH/l4ymPq?=
 =?iso-8859-1?Q?VpQLjRvvb/hBAEVNqQF05kF/qyXZ1sOu2aGXLQn+FeIrhhmMe3a2dhDPUP?=
 =?iso-8859-1?Q?5FMFqakwWNTR00kwSkRPSwEHzFmmJkNREx76Tvfq5Gp5vPlT8OoE7nmItx?=
 =?iso-8859-1?Q?YJb36vDMpGaDhowGeH6oUMdAbQwxw6ZG9sr+SGixgEmm9rNOWUjVQvhun8?=
 =?iso-8859-1?Q?GiAiq4t73sBnvUxI6wY9iKIKQ3aR0JizyY9y8yvqEjrqtXZwimyg8RVxKO?=
 =?iso-8859-1?Q?NpDqJ7Bjpr20GKTyFsM8XryGlLFzvmRfaA0iKN45oiUbX0cpIXoZVZjSyN?=
 =?iso-8859-1?Q?oajljvgkEEa9iBHvPWFRCNWlfoMfM5bvaqgzB6wL8ELkJs5FuAIU/TUAQk?=
 =?iso-8859-1?Q?4r+m8Bu8EUitHS1OiCvrF4+ee5J3cM/CuBYGvp0UFWhis1GWQe65znJ/c0?=
 =?iso-8859-1?Q?FGGMuAdKPsEheVhpO+9Qtd/xpyu2D2Gl7/P93P+B/RCLrcmJleLRM0JTfv?=
 =?iso-8859-1?Q?S8/anCaCUJXBo/ZHcMWcZvwmMtR25poQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4543.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f350b4a8-e734-4a1f-d1cd-08d8f4d0359f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 05:37:16.1477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jzrBe77KmG2o+zI+MSYdlnT55M9HHrAfvcoYXK2TChfVrWjqumzITXqJl4Lj0vKiVv2TIA9qXvKmRChGc/UmsmF1FXbdgsQIURj14RYzCVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3679
X-Proofpoint-ORIG-GUID: sr4d-kW1AwXZrUkrEfCtEF6iBHbzRR8O
X-Proofpoint-GUID: sr4d-kW1AwXZrUkrEfCtEF6iBHbzRR8O
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_02:2021-03-31,2021-04-01 signatures=0
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
 drivers/pci/pci.c   | 17 +++++++++--------
 include/linux/pci.h |  1 +
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 16a17215f633..12a91af2ade4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4982,6 +4982,13 @@ static int pci_dev_reset_slot_function(struct pci_de=
v *dev, int probe)
 	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
 }
=20
+int pci_reset_bus_function(struct pci_dev *dev, int probe)
+{
+	int rc =3D pci_dev_reset_slot_function(dev, probe);
+
+	return (rc =3D=3D -ENOTTY) ? pci_parent_bus_reset(dev, probe) : rc;
+}
+
 static void pci_dev_lock(struct pci_dev *dev)
 {
 	pci_cfg_access_lock(dev);
@@ -5102,10 +5109,7 @@ int __pci_reset_function_locked(struct pci_dev *dev)
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
@@ -5135,13 +5139,10 @@ int pci_probe_reset_function(struct pci_dev *dev)
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
