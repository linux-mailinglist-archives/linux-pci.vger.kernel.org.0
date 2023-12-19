Return-Path: <linux-pci+bounces-1170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9107A8189B4
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 15:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391FD286396
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 14:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8C01B274;
	Tue, 19 Dec 2023 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UyCmdk66"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D7F1C294;
	Tue, 19 Dec 2023 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlRpAJqp2eICa7eOFjtcCprpmqVVZ1Qzw/703Sn2v5X9r5r62oryC6G7GvVKS2LVIwT1acDnR7EL6tRU6p5TiVGMM9SpO7luCN4nGclN0YbgBy1a09iUYt4WEDN+gwABeRclQ/+Q7AXunsd+wH6q0b0mUovnXTlAJUbJj74+ecL0KrPJ/tqzSClvn/SAIAFzO8XTuu6zp74UiTqpC0xI3Zpa5bcMO5x/PDk/sLVUn1l8FFI6weBqpIgOYMR+G9ZuJi8OirhIZYXFKkzQ+8Gv5thvznGCu+QKgEqbi8EM0prE807OUB7sDWhzLRd0LNoYn7N1AbAqwq2mCI0+tnd0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ideQh1mNmjKsTtjHkQT11tgBgcVVL8qr4niA58QMSy4=;
 b=i9gIUM5Ps1VqPhJUwiNztlNdacYZzuCxH1YW02/5if9AmfWX+F22uWaXlHr2x3yZc9IdQR1hDcADOYhx8CoTLe1bGWo8NLs9u7qtZLbUNwyuSPYfnBudKXh+BLKuLrM6cvB4Q26EosLbikCvaviKCf0G02DIzJs907oUcOETQ6XzLwMWW3mPWt7W+efXQWqoz/pzgx0XXBMrzUExXeAu3+oKQoFxX1JNSwwBIntJ3HrcmP/Sic+WOiXULvOkqNhPCLfCTgb+uCOeKqd0FIftQEeLks4uP4G7TF347gpEmzod/p9YerY6U0n+x19kWD56/Ke0UlRgAb98tLppsuyLCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ideQh1mNmjKsTtjHkQT11tgBgcVVL8qr4niA58QMSy4=;
 b=UyCmdk66SXT/7P5Mv2dWOmywjDOWoFkbNL1KHwZbZG5HA5WlhjY6TEZJkeUQE61QDb/4nqL+GbxcsAPbpqBGgXsQZ4xKf6p4SnR8zgT5hMLfL7DgHMYRW3Ff50oHaOfP3gE0+DGuYXEYRCS9Hb0khu3JK9x3vOOiOZDkFwHHnY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8576.eurprd04.prod.outlook.com (2603:10a6:102:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Tue, 19 Dec
 2023 14:24:16 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 14:24:16 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: allenbh@gmail.com,
	bhelgaas@google.com,
	dave.jiang@intel.com,
	imx@lists.linux.dev,
	jdmason@kudzu.us,
	kishon@kernel.org,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v2 1/1] PCI: endpoint: pci-epf-vntb: Fix transfer fail when BAR1 is fixed size
Date: Tue, 19 Dec 2023 09:24:03 -0500
Message-Id: <20231219142403.1223873-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:a03:331::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 20fbfbf9-4c47-42ba-8c09-08dc009e2e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZxQqgjMsk/F6fWyxhJNUkmIv6jhtePuDOwqaD9pygM+C+nPyiOefETWpbBrOlW6mvRb+TB2DJuUJ/aFn1uQpAwwLyRv0iQt+8ZmB2EOOTQ61D9HfZywmyJV6odmtbtstAiw6EwgfLCcdk4rLBmM4sxF20Sylubw0lE7bChV6uKXGRzqHzic4LhLOUSjTieKwbqMmNm87M2N2SHiFL4wd8VRetgvs8gtVdz5yIRvbK2DYJCHzL7/eInqdjVVoWZ5Cf8AcZiufoqroecdaUX6NfJsammC19jpVPSUg6WqxcfZkGyCTxkE3XqeGGXtAeQ7Us9+B7TIeS9nef0yzaqMJ7u2sWvT9THN9t7Lo0sqqVkORlly5FaVrj0hOVqOGxAzcoGOzRtp+ZNHlJIjUenr1l6d7pD0NrXHy+TnatSzi+TJG0003DVdPHz9YKJajLMrzyOYxF7X834vlH6TvSY7JxEfzxoMw9aPkM2qFfEaex1MmjCW6rCla/ehofUusOiq8WEvDLT780FdZ+ShxcfD/qdBORTSNM7hHR1rDVKHyeLtSUeL1NYH4n4Voze0PTv+iRDnBuAt9+0s+SzQK+hBLsR/NRVnHX0+Mu+l2BUqvyW8XHWCJ20HBMd1wqQeQ/5Wi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(36756003)(38350700005)(37006003)(316002)(66946007)(34206002)(66556008)(66476007)(7416002)(38100700002)(5660300002)(8936002)(4326008)(8676002)(2906002)(52116002)(6512007)(6506007)(6666004)(6486002)(26005)(1076003)(478600001)(2616005)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZXAZpNLdkfIHtkGTly9o0FRb25rPzDNU9tbQ8V7uX9ux+DYO/PZU5T2vNhWE?=
 =?us-ascii?Q?BqlwQ86oRpkupfpT85U6ubXV1NOM4knGBn/9VLnHDQsMXlNoJatnCu1x8aPT?=
 =?us-ascii?Q?GDAOqIkZxoOvCoxiuB9OyGSB4BuLA2olEeZVz6jv6VXYV7E+dvWCLHTfDXKE?=
 =?us-ascii?Q?X4rQjeeSTWvC1JIwcv8GUjpCJja2quZFEQQELLKz7F2ypTjojzsInwGWuCIn?=
 =?us-ascii?Q?AGZDBawdsL1lZ16Uef/UgVbAcP/X9i8VWC0Do4I0srNpyOXT5d22hiaQ87TR?=
 =?us-ascii?Q?tLdD7oQZ/bNEW4EqbmLl58mnl4/H2ZCGxp9J9/J+HkToUYhNGsdy5ZOfhZRm?=
 =?us-ascii?Q?DbU29c9n78xHuh8CHft1RotjHSVDUH0xYuhA/gdZo/IB+4ud/bzZQEySiy2y?=
 =?us-ascii?Q?NpIvn5OkETkH5FqJZGVroSjds95ZpNkvP7n3BJM/Qvjk7S8mOQ7697l9Jsdu?=
 =?us-ascii?Q?dgHPTYsWKXaROxVLg+g5/acEqXIe8d7ahK4usTLs1Cf52g39Y2ymRCl9WWD5?=
 =?us-ascii?Q?Mlno6f+c6cxU1nN2AdavwPwSi3Kh1OYQFf0nsTiXca89GwyFS7HtQpaxJxAZ?=
 =?us-ascii?Q?+eNyYqoTTadquIOYMEtj8eukUQ06svuoENxM6WRd6Cn1VFQrv7ZKVcUhYjnP?=
 =?us-ascii?Q?7R+UGdvsh2WlSiATzREQeMW1IXLYCevS7fXomqBdaDTqxOfEVRunYQmUwvlC?=
 =?us-ascii?Q?+2Un4MLWGhR4HbtKa4FN04WICR6M7s8JQ7vmszyYzHhatpmSbCcOtekhqvvZ?=
 =?us-ascii?Q?M3/19DXPJqWB3Azb18RAsrZKC9oYbJZFvObTk1SYc2VcPUAh5VFPDpXHPN1Q?=
 =?us-ascii?Q?WwcIxSqvxAfVZ+Abtb/uckjzpaHjr9V9ZTLrIKfSUGMw7yJS/hVNMTlaIQml?=
 =?us-ascii?Q?2vxescMRkePaF48ucOkrzCOOqLOniCzd/RjyuMufVwH+TWfL4ZQRXqoBHsbr?=
 =?us-ascii?Q?ilX6NFwTdm/a6kkI1Tzz3D40tPj2JXmA5Q4cTP3kwxGAe/RmpBKkqgkfP1iU?=
 =?us-ascii?Q?aDObsm3n8e+i8M8qBykU7lBjgE5LsJMrjHg3TUji2aoubS9zQgcpL32ttGRA?=
 =?us-ascii?Q?mWJBVTiDBlmC4EYiFRLwzpxCmMGK7qLinv071dbS7KIQZVYn1tkFMizIfovr?=
 =?us-ascii?Q?ZNnExunWl3f+KMHzA1tldXuhKR1JqGBQYUb+bRkCzkOV5tnEye8VN5IE7l8n?=
 =?us-ascii?Q?Y1RiWZulrTSFNZ+N3sj3beZEUATgYx29eZp46xKVZ2k9CuY3/vgdED9pKw/o?=
 =?us-ascii?Q?HCgthqm4cf3j8F5ybUafDnXNfnCHZjvUo6BCQeGABNuCm5CFpE9xxnem9Q5D?=
 =?us-ascii?Q?gwWjSuQBItRwHPZwHvOYRJd2Y2q7XiBIsvKUfcUFozh3gJ4BMwgzof/BStL4?=
 =?us-ascii?Q?Zn06blPlbxWid8zDQddzexbAhbHmgdhU1niyNlY2zma1Q82wLdqje5PdnCIX?=
 =?us-ascii?Q?slKN528KiYZhZrp5J54LdQK0vjWqJZ256EvAyASU3Lyq+7tnh0kQCbUwKpdU?=
 =?us-ascii?Q?NCTQi5ORajwSmC5LHnEMYlX6UXSg4nE9I6e5pSokzILM0a5YvSvEZGxDszQU?=
 =?us-ascii?Q?/jFCgA0Npv5pFsUzOAm6JWY2FZOm85aYSO8uPy8k?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fbfbf9-4c47-42ba-8c09-08dc009e2e55
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 14:24:16.3642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtZDKy73R7UGd/mIJlgz78R18Veb0bVaSKkOwxtT5HfSfPER4AzY6d5URWFX0Nwj6ku2C/gs95OoGkR+QgZxZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8576

ntb_netdev transfer is failing when epc controller's BAR1 is fix size, such
as 64K. Certain controller(like dwc) require memory address must be align
with the fixed bar size.

For example:
	If BAR1's fix size is 64K, and other size programmable BAR's
alignment is 4K.
	vntb call pci_epf_alloc_space() get 4K aligned address, like
0x104E31000. But root complex actually write to address 0x104E30000 when
write BAR1.

Adds bar_fixed_size check and sets correct alignment for fixed-size BAR.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - Remove unnessary set align when fix_bar_size.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 3f60128560ed0..ec3922f404efe 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -550,6 +550,14 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 
 	barno = ntb->epf_ntb_bar[BAR_DB];
 
+	if (epc_features->bar_fixed_size[barno]) {
+		if (size > epc_features->bar_fixed_size[barno]) {
+			dev_err(dev, "Fixed BAR%d is too small for doorbell\n", barno);
+			return -EINVAL;
+		}
+		size = epc_features->bar_fixed_size[barno];
+	}
+
 	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
 	if (!mw_addr) {
 		dev_err(dev, "Failed to allocate OB address\n");
-- 
2.34.1


