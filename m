Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D37358D3C
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 21:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhDHTFs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 15:05:48 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:5792 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232885AbhDHTFq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 15:05:46 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138IvAi2025080;
        Thu, 8 Apr 2021 12:05:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=wCnXi61wHuPeyuDAnn8oxwcq4+aq7oglKjm+LC30Cvs=;
 b=A2j3/99wnMWo4IQay73fUmJgqXG/QpEr8VocT40Kz0KEkYihwWWUyTwA5hXfh8EiiIk1
 NlhAsEAIt5Y4ad4fz3oMzguK6oEOIfXkSrpzkFXYdqsCRKQ5z2OKETw2iNvdt4Lh+RXK
 YwwCQDa65zA4zI13r3SXTvBBuSIUXOUKSSIaE71EFzRmESs8VM7WxNeqVyqUWh/cmkdq
 +FAKryXXkAEUAwDyQ9UGqJgDBy0DFaofFhbC6NtTo22GdRoPZMncud4fNesDlhY45TZD
 esyWezffaFT2qrEpM2y4wOH6Ho5YeE7vZRQ+w1nNdko6tw96acfs06bHuUMEcM6M/yw1 jA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by mx0b-002c1b01.pphosted.com with ESMTP id 37t17hh1w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 12:05:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+4uYqzG3RXhm38SJn6K4EGM3EmbS/Kw8wdWD2nNFpa7LmRGsEK2+varcPFptJmGmJjRRzRsBP16YbhWctzuqG/4bX4b/yAYVJtYP+EGL/5QefpOXZZispScrQvWDL/NWzC8Z7KJZOF0SQ2NeZKnDl5Iur2JVvOll9SLoj5BqaG8hyU2z3zDzG9VLJ/5ViwOA9JatevYvwu1Y6cx+lxoiMFUEimdWrqpFdPtK0stkXBL3jHBo/vhPlRXlf/7kGNr0Utf0cczSSCLd+2P+CCdDnmNr9qnjb0AVoKSHr6A/Aon6wgdugVNijIg3md7wxcFNAjEsqlfZHBpPk3eDYx6dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCnXi61wHuPeyuDAnn8oxwcq4+aq7oglKjm+LC30Cvs=;
 b=dsMRpBJFzVOHMo3YkZNqXK14PM5ZVqZcJkik+gyhwQAT6yObwsj0IOgDgnhprlBHYknQethEdwd+QrFhE5szq+nJ0pHL/tNJB5w6aa4wiwDwNBAk1pVvN5dIZQdzsxyfsbcumjGYoTVUoZJV1oTRHYSXxOonaJ9l4WbBUBWzoXy87FXLnPcRtNj975fBKYiheft+u15fvxz6/e79GSPbunaeihideGPplR0z2K50OCS6ywyZvZ8mfJx7NmUmHdz5xBMAlndTqawqxyuBlcqxhXuX5C3xrUz2tNBu3ZzVVHIEeFI4LDCR6E6IAg5lBirw06M2WVAYTqTW4PsB0a0ydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from SN6PR02MB4543.namprd02.prod.outlook.com (2603:10b6:805:b1::24)
 by SN6PR02MB5567.namprd02.prod.outlook.com (2603:10b6:805:e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Thu, 8 Apr
 2021 19:05:28 +0000
Received: from SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::7139:d6a4:cf94:c4b1]) by SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::7139:d6a4:cf94:c4b1%4]) with mapi id 15.20.3999.034; Thu, 8 Apr 2021
 19:05:28 +0000
From:   Raphael Norwitz <raphael.norwitz@nutanix.com>
To:     "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "ameynarkhede03@gmail.com" <ameynarkhede03@gmail.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        Alay Shah <alay.shah@nutanix.com>,
        Suresh Gumpula <suresh.gumpula@nutanix.com>
Subject: [PATCH] PCI: Delay after FLR of Intel DC P4510 NVMe
Thread-Topic: [PATCH] PCI: Delay after FLR of Intel DC P4510 NVMe
Thread-Index: AQHXLKojWkVUrTJNYkajdTXZJRXXcQ==
Date:   Thu, 8 Apr 2021 19:05:27 +0000
Message-ID: <20210408190521.16897-1-raphael.norwitz@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [24.94.68.249]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b3897b7-189d-4657-9dc7-08d8fac145db
x-ms-traffictypediagnostic: SN6PR02MB5567:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR02MB5567A7641DEFBA2BCE6C27F6EA749@SN6PR02MB5567.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 52gfK3mOVWxEwidrvirRg8y/7x+KodMvTFK8WCXMVwTXUBxwHgcKGB9+YzmG82jaFJiVHcZZ7FqXk8ziXnM1bdkafuNJdDjl+QXLuJIV6MS6bUUUBGoejVeOYZ1ng1ktzL0uKeBDBDXWh7AlyTB+DBy/8F6sxUhsv2BAdMhEJRCgop/wLqGgHIcMBugN2ep1AP1vkkociNtLnQkl86d9rUyApQvIsBKO8RxjM7AYvgcxYHHDqloB9HIvAPJttK8yhkYmyWCfpuU2rAp6qU2yPs6diHlJLgZvZxGwVdM618E1M7bDyiEoqCdpiiE1MDJQtLv7iFA3QhFl0JaAnRQnxRRhsl4jl6mRD0GmuzDMwC8LyO3fpqXRvNUo7QAlbtLtiQwq3e7Gjdq86pWbhvAd4zPE7VO2QnhcI/P+mR4DaHTB4mlNzdO6VAE171c1m4SlVf69+07VkBFjxzG+DR8JNKtxwGPELVKVfAsrW/Tme+jxJ3C8MN1SqwkUoTmGKifSoG4YqL96rBkHO1GNpEX0k0KKw/Sz88AvJhUXvxkz5tG7P1oWpL7/vWexxVXHbqot8hCFRfj3Bah2saZ/DXBoh7f3jG7mNiQ6P5gdAORJM7FOWZJEsp0YRDHXukGrtD5x7lSgXZ7OHMl2fWY+xJ9QyIOitfyula9ltoTUGhcqfVU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4543.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(366004)(346002)(396003)(2616005)(91956017)(66446008)(64756008)(6916009)(36756003)(186003)(4326008)(316002)(2906002)(66476007)(6512007)(6486002)(38100700001)(83380400001)(4744005)(8676002)(107886003)(5660300002)(76116006)(66946007)(1076003)(66556008)(478600001)(86362001)(8936002)(71200400001)(6506007)(26005)(54906003)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?aTNy/vpeJkxLCyczEnh1beynZ7+vu5aO0Hn9tBOTJXoLMNgpv6Z/YSXRPw?=
 =?iso-8859-1?Q?9FWGHqvHUtJY7gxuuEos6+ao0cpomU64Kqy165iZtmGJq/PGdEjgyDQSuu?=
 =?iso-8859-1?Q?fPqFhmn9T3XvQ8j5rAQLe5HNlUq6vQoqiuOg9K79XSthjZLsPGPc+JgFVW?=
 =?iso-8859-1?Q?cXKrOGOVCL6ITZ1DagHJFux4d9bbX7aq7Hal62mdLkI1OIU9bbTL6lvnWp?=
 =?iso-8859-1?Q?wZoOocm8STrPr7CrU35irJbRDXFs2NHgDKtfr6KymkgIvVdKAx0LzxVQWp?=
 =?iso-8859-1?Q?vinL8IK17BDv2bLX+Car2Fr+B6lNBlR3YUFog7S5UXn6utx5xt+iWK360n?=
 =?iso-8859-1?Q?OodbjxyzJr5/5yIa1HG3wzM8MkqfF2i99QU455r/UtPLoaslxMPEcsXiXw?=
 =?iso-8859-1?Q?Os9HexmNF4YifFGfJXiEYlYnnsCuj//bsq1j13cllkVg1ZooUAkninaXN9?=
 =?iso-8859-1?Q?pvHZO7XF2rzzhIbArYyJUN9QruX7yDThFKy0b5VNAxS+Mr3eztf4cz/yvP?=
 =?iso-8859-1?Q?BmxMrEEiyBwpRC++eqwix1CnJGSD0hC10RnQpz+3WrEbdMVOjivB5dq2K3?=
 =?iso-8859-1?Q?p8AAFFqsF+42EG8LO+txVAog0RuNvP/VlT6L/7uRfvWE8ZRpTHefawH3Kt?=
 =?iso-8859-1?Q?7PX549OnteUn+EsOQMVlH8VO0Q9/3lFt+l3EqZtDsjOZ8VOTXledOeEt/3?=
 =?iso-8859-1?Q?NTVDBqTxGT2LR/GjLNZl1IbYPKWKPLhvJmw/ZEi3brOguWIDQj4jjTSg83?=
 =?iso-8859-1?Q?QlFlHOEfEYSHPw0O8g1RqV8MTTxZ6ioeiSmyEFv4yddHrJ/LjTTamUI/Jg?=
 =?iso-8859-1?Q?lDcRZYRtAEAK0eeQ5BIfM5CqaKbhfOvCzj/nQN5xDb3qICp8vrthTZqEgE?=
 =?iso-8859-1?Q?Lv2GrcK+6IvhzmlFxvryDJthdE8y87TwzgvWDrcXVX2zco0FvBafd0v/Nn?=
 =?iso-8859-1?Q?ygOkD58AQUHYltUWG83ZIiBGMedyC5T3r3EGqL82GYf+2h+22FNn26aRQT?=
 =?iso-8859-1?Q?T+giYmLuO0OhsA2iX2ZWHWd/ekFyPRvA41kYp90vWR1ygiEp0e44G3EzrV?=
 =?iso-8859-1?Q?Bz2VrA3Hw69+a/a6yTo1z3zP2XjbAp7W9Mh2qnqWRTPUGzP09W7qJEgas6?=
 =?iso-8859-1?Q?svlVpgtob07agNCFvEIJV76RXKEw4gKP/sbFvv1pevZXKGFbVLnEyrgCVB?=
 =?iso-8859-1?Q?judrr9sJghzxfaBvL6VwgYmUz7klgQHfY+GxUOVCgmL0MRgon0b1LSVmJc?=
 =?iso-8859-1?Q?u6O95P1aa6iVTjjFE0KVZbxocGAGjjo9mmqB1MIhQJnlHQYrrdYy0x7kI9?=
 =?iso-8859-1?Q?NINYzQMD+k9qTnTnqhXsTbcYEkTUV8sy+6Xuat5Em1MEgh4Y64k5pQHsCR?=
 =?iso-8859-1?Q?3/+HPhFCgb?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4543.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3897b7-189d-4657-9dc7-08d8fac145db
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 19:05:27.6710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZR+oc2YGgVCN1Ia5X5/omNXpOf4Y3bYhhTdLoIU0e9Sl7XmNbtvQFTBfOSIWZmHQ33Ia3Qv/bO1m2Ep6kSyXleAKzuZB+DSd/pSKRjkxHes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5567
X-Proofpoint-GUID: sBWyXq9eqW-dfFmHWD2qxSItfmyDF9sB
X-Proofpoint-ORIG-GUID: sBWyXq9eqW-dfFmHWD2qxSItfmyDF9sB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_04:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Like the Intel DC P3700 NVMe, the Intel P4510 NVMe exhibits a timeout
failure when the driver tries to interact with the device to soon after
an FLR. The same reset quirk the P3700 uses also resolves the failure
for the P4510, so this change introduces the same reset quirk for the
P4510.

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Alay Shah <alay.shah@nutanix.com>
Signed-off-by: Suresh Gumpula <suresh.gumpula@nutanix.com>
Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3ba9e..5a8c059b848d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3922,6 +3922,7 @@ static const struct pci_dev_reset_methods pci_dev_res=
et_methods[] =3D {
 		reset_ivb_igd },
 	{ PCI_VENDOR_ID_SAMSUNG, 0xa804, nvme_disable_and_flr },
 	{ PCI_VENDOR_ID_INTEL, 0x0953, delay_250ms_after_flr },
+	{ PCI_VENDOR_ID_INTEL, 0x0a54, delay_250ms_after_flr },
 	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
 		reset_chelsio_generic_dev },
 	{ 0 }
--=20
2.20.1
