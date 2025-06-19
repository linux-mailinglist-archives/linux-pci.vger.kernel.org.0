Return-Path: <linux-pci+bounces-30172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5A8AE019C
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 11:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA97E189D6F8
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 09:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DC3265CAA;
	Thu, 19 Jun 2025 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b6dhF26/"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010065.outbound.protection.outlook.com [52.101.84.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851452690D1;
	Thu, 19 Jun 2025 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750324475; cv=fail; b=fAo1wCe1hMikRh5v8SZIr07rL8Ljaw+7z0nn9LVrrdkIsgjRkdv7Ni7ajmJXmRPBRITRQaYccgUvX5JW9Tiks9KTytNkColRxUYuIUjwFSN5VDw1oZe89wNsvxV8YobnhSA3VBo74xNNBhkY5+8UlGdNgV3ijSjRvAXTcsd/7OE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750324475; c=relaxed/simple;
	bh=WpANRqaayzGeLOJ/NSdoQ4ZyBpPZyjKKVsiGYZ4nJBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oswwOXUsdXhj9ACBKmGDb17OWLzzW92dPwoz7yNgP5OmLPuaHkTevnX3I2DJ9D4Fo7OZ92E3ekw+QQPJQKBb8Rm88+B7IyOR3zutncCnTGd/O/Q4XlEtX0rOF+sKW1u9KwEWLk/nPbYyuYDmNYnTrInSbzi9QTyHBvNzTJ4+hAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b6dhF26/; arc=fail smtp.client-ip=52.101.84.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTtgmU+YDLdWwgsbWaCA+uSLgDEGETGtfdzcV8fptJtcy0GkvyLIJR8zC7ec7oxpzJhJJhDhO3lF/U7fOS0eBAhyuxxelYuaJhWazsBZ+5e6BPd4Op2CWGziPPYxc7WYMJAOzLQNh64iJkN4q+ZOV0T3WX1W2MXQwpIactG/QkQwgA4H9N9ZX25vaxfpAPT2rcuJape7WhU3AyeeYcKFRnh918uYPWHAnu7PuqGcat5+Ndw+I0W8M4bUchApDAj2Tz5uZEzRKFhLLLArMs91YktCelzH5VTutM8ZW3zyXjAPuebRIaIApQ9ERkMygHZ1zNrnM37evrT61lVM1bY1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8fkwdc3PYtQjwhq6Po/T/8gTI2hUBfx8vMIEQvYQok=;
 b=E8oZg9MZsrcf6HjwAtrqYcSQe4l4fEUY53bnCVaZqkC/06KA/F8y1CWROUjCOWRJVEcNgzFjOnUfxmUyfDkDnkjuvlDQvWWsSmj4AwuKj+fV60Gu7GgmHxqKa8nJcoO7v8fRwKSuagGp4NIwCUIivbBg/zKEcR3mxNfERwhRk/k4wjwiTuR9HL2gEUAbAjlzUlaYkW1Kwefvp9cHIMHi6Ah3v4pNF6P3Gq1EPmU3VnEpJbAyuEQpAhWtVrY/lhG1iGnwBmcDSZgAXNVTku8U3lj7Bi5guNkqDuoYM7iSpOnJaePPqTuSkLtHN5/KMTKcySH0PXkUhZOziMLPbEh2Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8fkwdc3PYtQjwhq6Po/T/8gTI2hUBfx8vMIEQvYQok=;
 b=b6dhF26/txKUJY/vBv7vO3uVlkzJo23F+1dQjj1WXzmAN5wbKGoD4aXTiaIr21P58JCL6VpkeaU7dnhio8FS/E0OqMv1lYKqd+wrwfXPp1Z5oAE3XPPCA0BWpUZk8+hHqcm1/KU9gG7ezzTyZFSI9ozgyFPlbdrQ/Jago52kBOZ39pNVS27RVIjSWtvHmucNLntUsr+2sw/fjR2ZXruhwEx1doeUhPMJwf6mGcYjZ6ySK+G5jSJ9MTg1MJ3HVWJMJo7xzl5lEP9S7BUZwS58bdM8rmqktaElDJp4E2vrX7aToF19AVCO8kTPXaDuWwpZT2RE+tw7j8dV4yH0CRPe+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB7021.eurprd04.prod.outlook.com (2603:10a6:800:127::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Thu, 19 Jun
 2025 09:14:31 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8857.020; Thu, 19 Jun 2025
 09:14:31 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	jingoohan1@gmail.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 3/5] PCI: imx6: Don't poll LTSSM state of i.MX7D PCIe in PM operations
Date: Thu, 19 Jun 2025 17:12:12 +0800
Message-Id: <20250619091214.400222-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250619091214.400222-1-hongxing.zhu@nxp.com>
References: <20250619091214.400222-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22)
 To AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|VI1PR04MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: a76b4f70-58e6-46d0-393d-08ddaf11b2eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?04Lds95jAjOyt+dOzm8dROpIazyqp24cSRf6aymi6aVlSNetluMhXfDQVrvL?=
 =?us-ascii?Q?dxZ74Feg83JtXhQLnSQECy0rurAIXCzXY7V2DEujiwHrPP3Dr5J/OfrlDsqg?=
 =?us-ascii?Q?zkOM/a5QwAM3LfQdmvBJmGWtETKU7BcvO03kvIQZkHk9zQtd1765BTP+iHdd?=
 =?us-ascii?Q?64Bgl0iocdsk3iDmH7w7nRj3qSfGzAg7sGFMncBo1JHNw43qvosU90AVzyzY?=
 =?us-ascii?Q?R3G8zr8db7CNzrnom7hIDHJAx0Obdse3xwQOZKasFppVnGYcFPrL2ab3rS1q?=
 =?us-ascii?Q?ONxw/nCCyO/saFzXnY/JOpli7geXwB/2SE1f6zlv8qOEcO2kRM1TtzGZJHhQ?=
 =?us-ascii?Q?bLvaMN9TRyY0bswrXIVO2GiW+zho1prHoiaCXOmurwm5dGHutxAS63j7PXiB?=
 =?us-ascii?Q?zPHmFuE7/YKio7V1u2Cs9FkVxKP7K8ygGjc6RerXKDE/04chph919ApxDrW8?=
 =?us-ascii?Q?H/ZW31A4ZAIvQOLvdxk9VR+/MCh/IZ6p36cUiMCWn8oWpuDRnJrsCITOUmqb?=
 =?us-ascii?Q?YSukQai6QO5EADGJ+E2J/RFBItWDBrzeRZQ6bvyYQVCDzJwkSbZCUGjvH7U1?=
 =?us-ascii?Q?/bvnx6RdMnka0I8SZwJMl1c9BDqBv2DeqP8qTpTi1g3eZ5o7ezwxqm8SM4v9?=
 =?us-ascii?Q?fyPAQ+wgnTdF/MSUlGQ8LSLM+mJzuHQxYJmR5x0D0Lj/I5SiYLMtxHp4ds9+?=
 =?us-ascii?Q?unty4pR8BNYhbG5UlyqxMG6olwoLlwBWR5s0hBpy/gDDW7lLPD80CJ8mXZyq?=
 =?us-ascii?Q?EO0sA3mqQHX0dz1+UWc9UJF+arIHvfnn4gL1arjxCdTvwPp+Fs5VacDMXNNm?=
 =?us-ascii?Q?XERie+1Fe64Z3OPzRO73C89cXx6BFKkypFIyOmrPrLHQR68Acp0UNhm9tXlk?=
 =?us-ascii?Q?+oYC+POuc5mwjL/ZRbgXUb9TEDalgQ8FpuFc82TIOgRpiD/YURTZSKMwUriY?=
 =?us-ascii?Q?WBPPwzBD1suhwJOaSjy+e86qHioKmSaORyTdoHfhSNlckqDtQljRGZbABW0K?=
 =?us-ascii?Q?nb7htSYWDpr6lBrzXi3yAlwxQYClMeH6FbXn1F34ePeB6/c1J2htbk/EVgjL?=
 =?us-ascii?Q?kzgsgLuYVN2HYp4r++jbgYrAOIr0tJcbDC0r3+OyYGurfp6y12zpHj49DtlJ?=
 =?us-ascii?Q?mjh88afqaAKoJt6wzkp4BZwKJMcJl5bhARP67MDJZ122WEBuvkH6J8yOzMbU?=
 =?us-ascii?Q?AUx4rbsNpk5gqtENj9R0M8ta9G7LmmD25x3F291u3sma1/MikW+UpLM/1Ctr?=
 =?us-ascii?Q?LidH/XxkmbIefXgLBdKwza2VxBkz6NSEdyvqPoFfHcUdd9HY5PLzmoK3EqZ5?=
 =?us-ascii?Q?kb6ii5ORlev2a+FtAx2d5Ee22BUSzGe+lQrhlr327R9dbxr4teJoLpYMPKgF?=
 =?us-ascii?Q?gewpYObXYOt10rkGlTwWEPIqQUQ8lwuwqm7qVoc4L+1honO+0KDfb4MbnzeO?=
 =?us-ascii?Q?INJhzHyKH686nw2Usbpvtu7OaajWye7tYM/1dpVACK4hFLp3bilFdqJNBIev?=
 =?us-ascii?Q?ibXDjyEYUtTMw1o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ce8sOwR7vWl8xDe814Hk1GqeOFgjSHZ4UyLEVIydGyW/0M9TTyeEjci9n+tS?=
 =?us-ascii?Q?5ucTJwGp6erXZMZqgHNtrgVS/9nmKAzMNU4u2hPVq2+7rZSaaavCF0oJkcL0?=
 =?us-ascii?Q?Qa0KkTAqwVRe8uK3CI5U8YIunAej/J5geeNnH/S/vbc3lHh9RHqtjiCf/qYi?=
 =?us-ascii?Q?x4A9GcFP0h2lBr2Ma+CutcOUMCitSX+ObUkdqey5wYiMzrrVNPVNd+MJHhs2?=
 =?us-ascii?Q?qHvhcyyyK8fq5hBe3s/95k+Wtnueu5MvtLa/lScNwOemVLua/E4HTE1QKeqc?=
 =?us-ascii?Q?io41eKsoGgkrWzogtrjWRTyjFddUVsXX4ME9695tHwO8KeejsMmQqUxyzPWc?=
 =?us-ascii?Q?mLcKaDx6LqVsjLq3gV0We3HgCFEDWTZI2MdR34BERAGXBxdMMw5+CgA0tfYT?=
 =?us-ascii?Q?bsDq4DYgSBC5ww/a+OgkoJJv7IyrR9CKstGN2OOIE0U+l7HpG6VAHfc4C6HP?=
 =?us-ascii?Q?bCeDvRsIeHaiwynKAwgLAhQg4lfU+z2BNo2kSZHConkcZggmsPzSwA6OTJvN?=
 =?us-ascii?Q?PQI5X3q2RoxVOZ5jsdpDiz4ZNIgUbppC5CG+Bs7z5Wr/4duPoFAzpz2MF4ZO?=
 =?us-ascii?Q?KCAHz/scJP9cRk2/kcRjKvKzkPS4ssZkXGNR4zJghX9Y2TtmKVnvCzC4DI02?=
 =?us-ascii?Q?in4TdWHwsjTrexAlJhafnnme1PNNT4ZCoNdrXU5iwDBYHd2E8KG84XWr+bS6?=
 =?us-ascii?Q?ikdoIe8uaFp2yJYwDIb0328tXZiKYpR/KhTwqTS2lgyWFJAbhzpXnfdV4yhz?=
 =?us-ascii?Q?wP5fSJbzt6+vnwsKbKgEBBYJMmOGTfwX9dOSR1R3ltW2sadPJcuYJ+pxUYJj?=
 =?us-ascii?Q?v7aLtPJroyY21DFHv+zf8Flv7mTs6UfFoWBtU16ohNKyrXFviBnyOFViunb3?=
 =?us-ascii?Q?JKFninQFjajHnyWVNXbG0bf9INXfHg2KSqI6sWVd8aYCWK2iJ1dqHHq/zk4q?=
 =?us-ascii?Q?NhaiggsSrrKCgqxQN1QW1xXjHA2KhBzArY9c9KYs8s4z9/aDRJbrl5j96BBX?=
 =?us-ascii?Q?uiWMwqVSWOJls9erj+9gkR6vcjK9adjquomHZrgU4qI8RJRcLI2oNYIw27pZ?=
 =?us-ascii?Q?ApgVsxxi2uD7Mj5c5dTXe9SN/YYCkwsJQjBXAI/zLW72Q+5uAdkxoP6+OFke?=
 =?us-ascii?Q?qeCbT/kniFVeDK9VqsIMJa3InJZswMxncWk7QAXWpUgbh9DIAK7vAxoaAc6w?=
 =?us-ascii?Q?BR5QXxwcdfqG0EkjnX4Y2LaQMediqycPVSKvM/MCEpgrX8LjpZz9YSDFDYgC?=
 =?us-ascii?Q?LnnrlGbNbnvT3Cxz6WfLaPqU9K9BxkiN+Dig8oIflTIT9o13ljB21TGogEPG?=
 =?us-ascii?Q?ywi7VctfTUWKoJE0g0Aktu5KguNUjZ0nrF7CIzVu5mvmHx5rlJjW+pE+jHZ3?=
 =?us-ascii?Q?9L6FLCfqK6uvyojP8xwujphz8mmrr2OBCo0QJ8LU7eRLpu65M/vlo7ocr5lW?=
 =?us-ascii?Q?X+YvWS4Gi1t4Ab6aWWZrMQj87bn80fFkqzAizDckWXd/UW3jbq3YVBMoBhqV?=
 =?us-ascii?Q?fwbP9muOkwkumIjQJLwRrUKy9cde5IWRG1TvknjZw6IiW/945ZFRYpgG+8vj?=
 =?us-ascii?Q?XeSpm5rbhkfucnHUkPLcxiIKfsPgQEvkEiOy42KX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a76b4f70-58e6-46d0-393d-08ddaf11b2eb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 09:14:31.0947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yi5v4Piyz3dru0Z022KrFE1esXAjkWKPEhL23xGU7IAI6ZXauVUhy8SpK9f50x3kN1F2q91x+ZEVq6lsSi1++A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7021

Add a quirk flag(QUIRK_NOL2POLL_IN_PM) for i.MX7D PCIe. Don't poll the
LTSSM states after issue the PME_Turn_Off message.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 8b7daaf36fef..f084a9ad1001 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1851,6 +1851,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
 		.core_reset = imx7d_pcie_core_reset,
+		.quirk = QUIRK_NOL2POLL_IN_PM,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
-- 
2.37.1


