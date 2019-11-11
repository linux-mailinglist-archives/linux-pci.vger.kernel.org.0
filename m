Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 112AFF6CF3
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 03:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfKKCnR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Nov 2019 21:43:17 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:32236 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726789AbfKKCnR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Nov 2019 21:43:17 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAB2fIEM015045;
        Sun, 10 Nov 2019 18:43:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Gw8mcriqSIw5SP/ujmM9RLf+fAFVt9cJ2Pv74kWfEWs=;
 b=trbMBe7wX0ZQFNZqbEzCfXtzbw9GEWrppS6wrTsg3w8pNwfGSGbyQDIQs+VjGbh6rS9D
 jpMAiRPkYQbi/E/79DyBpNxbFGikGP/SAxqmtmFk8of2B7AoQ+H+mgHrdGlrNltN/1JC
 Pc9UVp7dGZ6IgSkc8qDOKkI03CgkqOuQjgxI7DVo+rzzMO5AVmoN3Cdgq20Pk7lfLmtR
 t7q6KmLaViyE+6aQFUFxGW9n8vsObChrb6uQsxW6cSg/axk7V80WX5Ju59zI9yNfJxBn
 YYNngYrGfT+LgQhXsfcVYzn1hu2MoT5Z8Q4OUWpkH2bXaojlyGh/3nTctSfLaF5iQL/L Aw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2w5upuw3c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 10 Nov 2019 18:43:06 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 10 Nov
 2019 18:43:05 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.55) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 10 Nov 2019 18:43:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0fbwnKt2SJd9bv8mLQp8Yjrj06Z7/Nltrl2DkvSwidMlJdyFdQM46R1Bcb7xyGZyYqOJyhTzqzhEQ1tsZG238J5YTb86mlobBktWE7OPMB9cArIbuoAfmExGtZcF3FNiEipNfb3pqTxQmuLM/n86mZWjFxVQv+sFPyqJArcSyjm0PCwxdSvBms1v12KR5Df2CuHdHEv5hHEKQFkC+nO7X/MwVaT/QBPYr4Q+hx6bmr89ImdJxZudv8b8NcBwE8HnKvZW2r6UTcVugNpd9XMD517wt1ozbyfR+tkQIraM4aDJkF6x06MmsKw0LH5CZemuKoo1rs8C1qHE1BAAAHkFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw8mcriqSIw5SP/ujmM9RLf+fAFVt9cJ2Pv74kWfEWs=;
 b=GFY9R1ojSUDG8zvdL94ASz/cvZ3vCDN4HbDPX0AR2PxKJyAOVgw+yDDnuiiHYPWrZ9Bb3eBkUn4uhykJBbspWoI+0CfD76NIoW/cLs80fncBEJN2b069yAiJ0TWFOaPOYy++3qB+EDAhXy4nk0qo0GKd80M8EIM5MbZdZdgJuLhCL0DLEUmGl3sPnsu0P0RHg1MUqOrbzhOgCkULUKQSchw0PnbUmK35/OV5yaP0QpTUpSY/Zvfd9ATG6IK4kFsmluGqYHvLYNKRls/tKLm834dPB/hGJN8H2LHlm0uigdNGg4GeohnSQKmLuC1t9CY/89ASDE7rO+imGm8lM2DtoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw8mcriqSIw5SP/ujmM9RLf+fAFVt9cJ2Pv74kWfEWs=;
 b=CfSW/LsC3HUsdcou/dy7NEXl8ycj/IXduHGtXsmpY9rnXeg6QGVsrHHWdlBtO/8Fnu1jsPZqYfl0pysIekpT9zynfF0l6heDja5o9fZYG5oDBHd6MHfOyBTF8w1U0vpOVq7sqDkRSQh8Vu7K7YVtWpf+V/UQWIOnz0BmmsX2TSY=
Received: from DM6PR18MB2940.namprd18.prod.outlook.com (20.179.52.160) by
 DM6PR18MB3372.namprd18.prod.outlook.com (10.255.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Mon, 11 Nov 2019 02:43:04 +0000
Received: from DM6PR18MB2940.namprd18.prod.outlook.com
 ([fe80::8899:66e2:5744:ca28]) by DM6PR18MB2940.namprd18.prod.outlook.com
 ([fe80::8899:66e2:5744:ca28%6]) with mapi id 15.20.2430.023; Mon, 11 Nov 2019
 02:43:04 +0000
From:   George Cherian <george.cherian@marvell.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "shannon.zhao@linux.alibaba.com" <shannon.zhao@linux.alibaba.com>,
        "Robert Richter" <rrichter@marvell.com>,
        George Cherian <gcherian@marvell.com>
Subject: [PATCH v2] PCI: Enhance the ACS quirk for Cavium devices
Thread-Topic: [PATCH v2] PCI: Enhance the ACS quirk for Cavium devices
Thread-Index: AQHVmDm9y6YD3yvz7kuOKWt2CLfuww==
Date:   Mon, 11 Nov 2019 02:43:03 +0000
Message-ID: <20191111024243.GA11408@dc5-eodlnx05.marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::40) To DM6PR18MB2940.namprd18.prod.outlook.com
 (2603:10b6:5:172::32)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab0009eb-db5a-4fda-3fe5-08d76650e000
x-ms-traffictypediagnostic: DM6PR18MB3372:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR18MB337247BFC418089EDA38A94DC5740@DM6PR18MB3372.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(39850400004)(366004)(136003)(199004)(189003)(5660300002)(6116002)(14454004)(6486002)(2501003)(478600001)(6436002)(25786009)(107886003)(4326008)(66476007)(6512007)(3846002)(66946007)(66556008)(64756008)(66446008)(1076003)(486006)(256004)(71190400001)(71200400001)(66066001)(44832011)(81166006)(110136005)(99286004)(8936002)(476003)(81156014)(8676002)(186003)(386003)(6506007)(33656002)(102836004)(2906002)(7736002)(305945005)(316002)(54906003)(52116002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR18MB3372;H:DM6PR18MB2940.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PCaQ8UpkOPhI15QRv8a6IMyl/JaTt7D7+hH9rcluR1/SCK1T/CFmEX6BQhhCgeGa1M07VneySluAB10W/3bkE7zYuSsk4VLCYJ/pwiBZS5z74lmgVusLAVO6PxVdQzejHXc3VFkJpFOmWdTR5Lb2Q03H35ykB8I2BOjNQfFloCfIE+/WYbTCnjK9bcDNagPlTh+ATYUc4Rsyyx8cTeJvMJN4dd07jHSgfHkLU9jXYr5aFAbQgcsANUS77z67B/fxFy5LT7O2yvhDnJO0fjioox6tuhF2rYdbOpjwN+R+UhVypZguQefOwkjAkK6f/lGjA2MKHAKh/qjgiOKTQcr/hzxiAHEXiY4BftycrQHmxH0MaGeroatRXqQZluOjePrNIDHzwE7LCAyg9zihWsbAJxtm7te5AZfp21PcAjLRQeP/H5i3Cr7Ky7KRhUmfTvGQ
Content-Type: text/plain; charset="us-ascii"
Content-ID: <08B0A7A5A3079A40906B8F8A5D0B9EBA@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0009eb-db5a-4fda-3fe5-08d76650e000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 02:43:03.9343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QYRC7APJUEalLLYscUHUq6LGyxqbfH6+B3yla700Ckrgu98Aa4RosxiFEX+DQ/FnYO5Ut5emCzpmgnJb5ZruCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3372
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-10_08:2019-11-08,2019-11-10 signatures=0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enhance the ACS quirk for Cavium Processors. Add the root port
vendor ID's for ThunderX2 and ThunderX3 series  of processors.

Signed-off-by: George Cherian <george.cherian@marvell.com>
Reviewed-by: Robert Richter <rrichter@marvell.com>

---
 drivers/pci/quirks.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 44c4ae1abd00..19821d5d0ef3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4243,15 +4243,21 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev=
, u16 acs_flags)
=20
 static bool pci_quirk_cavium_acs_match(struct pci_dev *dev)
 {
+	if (!pci_is_pcie(dev) || pci_pcie_type(dev) !=3D PCI_EXP_TYPE_ROOT_PORT)
+		return false;
+
+	switch (dev->device) {
 	/*
-	 * Effectively selects all downstream ports for whole ThunderX 1
-	 * family by 0xf800 mask (which represents 8 SoCs), while the lower
-	 * bits of device ID are used to indicate which subdevice is used
-	 * within the SoC.
+	 * Effectively selects all downstream ports for whole ThunderX1
+	 * (which represents 8 SoCs).
 	 */
-	return (pci_is_pcie(dev) &&
-		(pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT) &&
-		((dev->device & 0xf800) =3D=3D 0xa000));
+	case 0xa000 ... 0xa7ff: /* ThunderX1 */
+	case 0xaf84:  /* ThunderX2 */
+	case 0xb884:  /* ThunderX3 */
+		return true;
+	default:
+		return false;
+	}
 }
=20
 static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
--=20
2.17.1

