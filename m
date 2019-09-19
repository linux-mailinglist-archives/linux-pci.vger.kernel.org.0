Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C10BB71A4
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2019 04:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388393AbfISCnp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Sep 2019 22:43:45 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:36482 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388339AbfISCno (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Sep 2019 22:43:44 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8J2eFiU015874;
        Wed, 18 Sep 2019 19:43:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=69XqeKh3yHrvvFDF+vzyc0roWNBqwWWDYkDZ/m9EyNA=;
 b=VlaCkSpu0w0AW4ltcETJN/Crw0pv+er5mfDg7Z31s0Eys/fqm+Lz/Jn/KozHRJAap3Sa
 Z+l9hX4k3papqaE4Lhn2iZZFUTa7bSxM+iaeDVIp60exv9yeAFoYjdNsZjyOw1XWY3Be
 RTq4QQ3OIbfTD93bcFipvEIaTGRhD98MJ2rRcu7k3XESQpCtOKPDXnvTZgP7ieN2d8wu
 uAnWBZM1NVQWMcCVpAamse+50wWlSh+4xNlOFnAE4HJ2ecAlz3O2WGzMmH+DwD3Bv2hJ
 XdYzJf8Vjbmt6nEXbqMn3C3n/YP6eVFrmR/6W+O0uUMVSsawgXQQOc0/pNHuYj1q93Q2 HQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2v3vcdry66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 18 Sep 2019 19:43:36 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 18 Sep
 2019 19:43:35 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.58) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 18 Sep 2019 19:43:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FN9oW6XEt6iUSycX6sb8q1YSegC24bp+l+V9XwIGccyDgfPPGy3MRKOZ9wLBhi5bUz3V6mMyUn9GY0A3nZ+OQ++HMRiGe8aveTzEsAIkEAu4Jl96ht66Cid4aINZZ2MwF0bqd/1rbKks53Y1ag0g8wOYvK66s8DDbrujsK317I1A8T97xQDvrE2HgZN/2lw2rmi98hynoqpMgvRrz1jZMw+mw882RDC0wO0U4UrNQ9oSLL9E3XuG47NXqQMu73SOcN88xxmfYKk12qslPZKRg6R0nBpq4hcz4BxS8bKli+8lPNcTyKQrdHChH7yvjU9WuYgdFgzqwscSKtvLszZKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69XqeKh3yHrvvFDF+vzyc0roWNBqwWWDYkDZ/m9EyNA=;
 b=ASNr9B9qxFMh+JlVKHph4I3p+zXsXfhTz9dkgy3TYwQmDpj7mKgU3CkS3rF0QDe+DRvAmK71qOAs8OCA+u0FuS2N4NAuABOxRGyz6X7ZBDuvea10fgLi4Tp36DmJI8UMzo0q/VPEggZwu6p1wr7TawLoorWl43bGsmPK8RM/wxfLl8VSYGCmUmmFdNvqNFWzANrW6OBFiRbhpb2MgQpf2KXEpV6x4iRb+eWkrAQBIFy9HjkS+f0byqfOaIR8fhD0aKoVui+hF0yHmM5MIKq7eIZmLOxxQZ1m1N0XBkXDbYkLhe+LAt9/coop4OSa0YlJDmcLyNx7cbMjTpCJ/huDfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69XqeKh3yHrvvFDF+vzyc0roWNBqwWWDYkDZ/m9EyNA=;
 b=vi9CL84lEOvQokjAtlnVr7uC1jYA80Th4Kl37XllF7X1Ua77UzryslxpmGrXOdidax7AE6Fi2eZimMksyTsXt5dgmQFhmMNU1KSXEgu+k434gckUJeia7RppTfEGEy/NX1UByYErIgG+egAHY40YuvY200ugUrTWYeJh8bqpOFo=
Received: from DM6PR18MB2940.namprd18.prod.outlook.com (20.179.52.160) by
 DM6PR18MB2890.namprd18.prod.outlook.com (20.179.52.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Thu, 19 Sep 2019 02:43:35 +0000
Received: from DM6PR18MB2940.namprd18.prod.outlook.com
 ([fe80::9856:8914:1ec4:713d]) by DM6PR18MB2940.namprd18.prod.outlook.com
 ([fe80::9856:8914:1ec4:713d%5]) with mapi id 15.20.2263.023; Thu, 19 Sep 2019
 02:43:35 +0000
From:   George Cherian <george.cherian@marvell.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "shannon.zhao@linux.alibaba.com" <shannon.zhao@linux.alibaba.com>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        George Cherian <gcherian@marvell.com>
Subject: [PATCH] PCI: Enhance the ACS quirk for Cavium devices
Thread-Topic: [PATCH] PCI: Enhance the ACS quirk for Cavium devices
Thread-Index: AQHVbpQIV9ptp6oiNE2QU/yR1h+fzw==
Date:   Thu, 19 Sep 2019 02:43:34 +0000
Message-ID: <20190919024319.GA8792@dc5-eodlnx05.marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:a03:100::33) To DM6PR18MB2940.namprd18.prod.outlook.com
 (2603:10b6:5:172::32)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c57e55e1-72ca-46c8-9781-08d73cab2a87
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR18MB2890;
x-ms-traffictypediagnostic: DM6PR18MB2890:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR18MB28901D32A9E4343499394615C5890@DM6PR18MB2890.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(189003)(199004)(26005)(6506007)(1076003)(99286004)(8936002)(52116002)(8676002)(81166006)(102836004)(2906002)(386003)(81156014)(54906003)(110136005)(71200400001)(5660300002)(71190400001)(6116002)(316002)(3846002)(186003)(66446008)(64756008)(66556008)(486006)(2501003)(7736002)(66476007)(256004)(33656002)(66946007)(476003)(478600001)(6512007)(44832011)(25786009)(6436002)(14454004)(66066001)(6486002)(4326008)(305945005)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR18MB2890;H:DM6PR18MB2940.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xy/AChKoKtrFxkAVDYYabuLZCz0xM47RPw6Gc1M1N62Y5snG1kDp5zDJ8BZ/uO9l3IIrNRzUVASmkkC0vxhNTm9QuLMl88gsVHID00z1/qG6AhC+Aq5bF4WP/jqECHWsApxG0tOQS1Zfu589SI6w7eyc49Y20IfxqD2dpC12rRZTtv54dU3IJySybrX3wwTfWbKkvl3YE3aqUuyOd3IgsDbLJH8fUYUKNRcRczOH/5ofkGJ5Zl40wNMnqrPBchdHsPBpKHh/2Kj0bxrIIOaXO8kq1f5cxpiiKb64z5t1E7j7l3jIKwA9HZGpma4WG8qJp6XRiv7GHw8LYmtGJ3uOO6qW3PK5Q3iGoArRS6VpnjzgLpjCpmd3GcN/6pxLDspvC2ZnCk8ZHEtuXlrPVcz40gT/iHLbsos6ba3GlxsTObY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4D7A9B424EE1ED4E95B13A7EB9897182@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c57e55e1-72ca-46c8-9781-08d73cab2a87
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 02:43:34.8466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZCTmRc5hDgeJzCiRp5Y/+M7rnyJcRoddtg8wHluzTDTnDzEl6m6IenmwXZUucE5jYBdJ4wWDgYDGsO7SjwhlXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2890
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-19_01:2019-09-18,2019-09-19 signatures=0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enhance the ACS quirk for Cavium Processors. Add the root port
vendor ID's in an array and use the same in match function.
For newer devices add the vendor ID's in the array so that the
match function is simpler.

Signed-off-by: George Cherian <george.cherian@marvell.com>
---
 drivers/pci/quirks.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 44c4ae1abd00..64deeaddd51c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4241,17 +4241,27 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev=
, u16 acs_flags)
 #endif
 }
=20
+static const u16 pci_quirk_cavium_acs_ids[] =3D {
+	/* CN88xx family of devices */
+	0xa180, 0xa170,
+	/* CN99xx family of devices */
+	0xaf84,
+	/* CN11xxx family of devices */
+	0xb884,
+};
+
 static bool pci_quirk_cavium_acs_match(struct pci_dev *dev)
 {
-	/*
-	 * Effectively selects all downstream ports for whole ThunderX 1
-	 * family by 0xf800 mask (which represents 8 SoCs), while the lower
-	 * bits of device ID are used to indicate which subdevice is used
-	 * within the SoC.
-	 */
-	return (pci_is_pcie(dev) &&
-		(pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT) &&
-		((dev->device & 0xf800) =3D=3D 0xa000));
+	int i;
+
+	if (!pci_is_pcie(dev) || pci_pcie_type(dev) !=3D PCI_EXP_TYPE_ROOT_PORT)
+		return false;
+
+	for (i =3D 0; i < ARRAY_SIZE(pci_quirk_cavium_acs_ids); i++)
+		if (pci_quirk_cavium_acs_ids[i] =3D=3D dev->device)
+			return true;
+
+	return false;
 }
=20
 static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
--=20
2.17.1

