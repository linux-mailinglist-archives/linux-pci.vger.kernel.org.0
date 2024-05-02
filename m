Return-Path: <linux-pci+bounces-7024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 006B98BA12D
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 21:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BE31F21D4B
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 19:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F90142AB6;
	Thu,  2 May 2024 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VA7YyPZ7"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C12869D2F
	for <linux-pci@vger.kernel.org>; Thu,  2 May 2024 19:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714679964; cv=fail; b=ByWRQVUdMTyKt8Va0udo+iLYJPny8KXDl4q7suzvdjphQekmxK+LWtvu8HASKD8T0U/EpNuVGFtGTtfGqwO2Y2ohJB8lvsdUS5wR386rqHXKMBMXYkKiE+mDs75emalteoMbKhpOb0dwWo+1whM1cq21mBHnXxeBMklc1fFAYGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714679964; c=relaxed/simple;
	bh=pstVBb8F2USD/8HQ+8WjlsxJrRD9iIWp5s1LU9mLsXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PMmycsB7U7i0xDM3TGyZMk9bkv57bUJg4cFy2k95W/i5g/vMiaYoD4KbtjF6pD2DionOoZDMfDZqOotrpE7IBi6gEWWzkXYZRZC+8GH2wJ6+W5p2GTiSAC58CnBuZAsorD8ak2+vdjio5j594/xAJNlFsESFwzcZeY89ErVcHR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VA7YyPZ7; arc=fail smtp.client-ip=40.107.8.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lol7/0kdGUhtQhKhejOHFGtil1Bf1SzBPQ/r3Xdh3Y3uaw3x6H3bZqb39u8Mqf5hzEMVeWsBkl7WUQ1LncJzwC5CiH6Oj+KUdgRnlSdYTvKIw3v8BbIggwsb7S5gxD2O9jswxX7cS0KfZiU+oswUF7G7x79n4Qj36s+2mxI3HGQ5/kEgLiEC0m2RzU4CvrCluJPZVKUN4axf9aBkaCJvNy/MHdDZGslzcWlTsB/fvM11INiuVB6A1XspE6gdPPpqY5rXAivotl0lcsMABmavvGqG+Uw9HkuERfbdolkjpmdbRadBPSa5SZMPRq12sgVLXIZ5BQvCKiVYxHkrGz4JmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUt+HNg5YMjh/l+YI4YkaeMjiQkTXyCoVeWrHkvt5JI=;
 b=QO5luZz3HYMH99mIAPvQ//obI5EdKkX66jCtgJjd2UAhFNItPXGsyzn4TMYq+1F1GMj6wea8uWNhY4HnAb/zfulyKF8TGtdbRAxX5XwcnYFvsy3+LNrWh83xs+qxIZzXb22uN5dXDTB7ucwzb2uAU64Aa9pWHRFVZTBgAr3s0KA8dKdAiUE+TMZDYqPn6vl/GsmtLXFeYn7DI8PrAd34YCrY5P7n2nKbGyY6cdKBSVZAm3kV02j/TIhhH7EyFN5+RbPDynYey4gYdoug8D9vHzCtwuU7jxEkoUSN2MTaZ/mn8q3IwfIrblSdiXsiyhF19w9Uov6S9/FUbbvbclMLaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUt+HNg5YMjh/l+YI4YkaeMjiQkTXyCoVeWrHkvt5JI=;
 b=VA7YyPZ7z/HxONJqvBveIvYHC4YDde46pTeo65PwTTwQAnEwBSao1Sb5MYzN4ssHu2yuaipRyE9Xc5bPieCZ52abUmYX5A/JBgFu7G3ItYLkuvT8f2ozW9tTObVun7aGpve6qRv1exPlOS5KPHtAY9FpOGu3suJLdiCFte5RDz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9130.eurprd04.prod.outlook.com (2603:10a6:10:2f5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.24; Thu, 2 May
 2024 19:59:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 19:59:18 +0000
From: Frank Li <Frank.Li@nxp.com>
To: manivannan.sadhasivam@linaro.org,
	imx@lists.linux.dev
Cc: Frank.Li@nxp.com,
	arnd@arndb.de,
	cassel@kernel.org,
	gregkh@linuxfoundation.org,
	kishon@kernel.org,
	kw@linux.com,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 1/1] misc: pci_endpoint_test: Refactor dma_set_mask_and_coherent() logic
Date: Thu,  2 May 2024 15:59:03 -0400
Message-Id: <20240502195903.3191049-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::28) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: a40110a7-de19-4d1b-00df-08dc6ae25970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NcO7CY5y2Xz40NQGlPZsvc9kJm2pBlGiN3cr9Hni/0+LJPkepY7sJqjS3KeI?=
 =?us-ascii?Q?lKAF2W5i7TIV2hqS2Oy2KVrs34f5VQtN0AOAUTB+hBxmoGMF2S/NNtGZ34Dr?=
 =?us-ascii?Q?l+WDds6/6ltMS/OUTOzUj8Xidlq1R/D0RRvrV80z+L2RHWfg4XHkb/nn3Wy3?=
 =?us-ascii?Q?d78Mf5I8BPFDBub5HbY5H4H9aAOdCzhz7ErvTJ500Yssz/ILuyBpVctMnJE5?=
 =?us-ascii?Q?umyNVg1yCs7W7FEohVrGEU+svV79ZLdEO+PTGUxxv+FxeVTALYdcUkfWh/gX?=
 =?us-ascii?Q?AibWjUw2N4ylXL096U+aiFj/1Y08oBfTFil0bGxdv650Q6T24SIaIq90fC/h?=
 =?us-ascii?Q?eqWEwG7pwMAK7KELodwSz88hS7oknnH8e1eR6SUYHEYFSg9IbX6FICKWTHvO?=
 =?us-ascii?Q?SyW4qLWzkl+M266VB2IdvGRvYVWjJELMRSKRNg7cnQwyVxtoljWlzxLZPAvq?=
 =?us-ascii?Q?k7SvhqTkYZDT46J4npNtFXa3cZ9J5OkDucGxWuDzvTrARb53lp6QzQ/oU0Lc?=
 =?us-ascii?Q?eQAjJOnr2uFCijrSu+aJ4Upbq1M6xOv5lWxWof3FZebqJ+bA7g+vrM4yNuiO?=
 =?us-ascii?Q?0mNZBHV2hWjf4a6HUXbURHevFmWKOnEFn+YLaj4Xi6a1ZN4ynf5N8TwM0IOW?=
 =?us-ascii?Q?ERvDIBrchvDQtgp8UCkEdBfo/8TETrozHQjm/AJZbXa1vUHqCV7jRgkILEmd?=
 =?us-ascii?Q?6TbgVgvddLQSeVaxE0I3sSdAzi03GswJdv0fKq2BMzWs6olypL5Mx30q0xnZ?=
 =?us-ascii?Q?LzNOyDjLh618EOvHoTtdvwjzJvX9/HwL8OEPZetKB7w2cT2cnqX5CLlbzv40?=
 =?us-ascii?Q?tC1h6J1JE7qQUIhxB337c7wsk8POQhFsbFrdQPzeP3tr/s9LxftYBk06JqEr?=
 =?us-ascii?Q?AafmdZXUaJA4YGX6MfvboH+CXFK6OFOVmAJ4RpXUT5yk/a3NEsQOTaBOSTCr?=
 =?us-ascii?Q?Vn2SVOxgwe7a8i40AXZFVyGR96wLO3mfRLzDMHQQH+r9ypbRS/nluIKvgrxC?=
 =?us-ascii?Q?ujgciP8wUYNFVswOq/YnGnWjBb4mHimBOWbxm7iwtg3L3XKsBYKKZK5c+eA+?=
 =?us-ascii?Q?1uyhFQAkcm7NDrfgZt6dNYb0jlwNSJXWHkkpRoDLDb9D9gdooHun4tVwyqte?=
 =?us-ascii?Q?sRZhLGwu27Zmck7xxTujflwPAtm5YLjrWRxlgT92fsat6FJOMfhxVtXSHoRE?=
 =?us-ascii?Q?JMS2MoK3+jwleKVof4WHJoidcFePhdw2EAQ3vZsOOF89gOUuLM4C3nSbgZE2?=
 =?us-ascii?Q?Pl4B9PYbmjCtrNXzxyXzpKnPJcFJu/4+g+UwkrYoCw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1UsbSzyiI61T5SsTr36o85PBJbdabAK7ty8HfipBvqc233DwL8sNpjIovvzq?=
 =?us-ascii?Q?D8Of/ipWPE/+nSIuXlvVjq0Uj1afYOWcRJAxGf3zVe1v7v9a2N37YQVpne7K?=
 =?us-ascii?Q?RZ8yKvmcc4mq6HPsqDU026g0aHgvAYrYBqLW5EU1EStaOyWpT0YMw/kZ5DtM?=
 =?us-ascii?Q?ny04jluUYvSP8ClEUGHTqo0KujD9DaCYKvPHhgDBZ8vwt8Al55pbSmNWuSYZ?=
 =?us-ascii?Q?j6cL1s5Pikwv95HrLVLYBBo+/F9SJ1I3VOwd2Z1cEyWIgFNVPOoEMMzZHO7c?=
 =?us-ascii?Q?Jnwwwtk9optRLiqoYxhkQL91OzbFgZtvumBqum+WxXiJ/S5U0wqTTLTCQCe5?=
 =?us-ascii?Q?8nAvVLOFuoAjJHkEUWjudRIRs+o0iumGZBxfEEOzRWwA3oXCZB1u35oPXSHJ?=
 =?us-ascii?Q?r61skFXvTOq5PlkeyfP9qvBi/uSprHMrc0c3qegm4piUYhZDAxmHw5VdPwJo?=
 =?us-ascii?Q?H9zkiAHIZomtLa+ZufQkeWQe1Iif2pmXifML3b50NQqU+cHBFG9nejx374ds?=
 =?us-ascii?Q?8aP/q00fAx7ZU2MYSdb/MA2KCT4AQ21ErmRKDLZMOZ13J0qiQKO7nZqiMjqD?=
 =?us-ascii?Q?MNntyqWhNNLPOdJK1lF/dLYYOJiHZuD7GV8eXuzpKWUL7BuvVfBEi/7hXTC/?=
 =?us-ascii?Q?N9Kzq6Z31faGIG5s6X3E9sMW7ZliYuvzvGM8hhE9fBMqnEx1vtScRp+H6q+v?=
 =?us-ascii?Q?XYEfCcXTb10pmK0e6EmDV0kGcL+tLU6ZZDunASS6WtIQlICRLJvXSqAX/+2w?=
 =?us-ascii?Q?9FX3KiHw+0Jt3dkVlyI6z5aKgRhp2FjK3/+Pi3WO/p2x6fdK7PIRQ0m7FMmh?=
 =?us-ascii?Q?jD9kx9g4h787G2upi3y9Lku3g9jxoRFlKa6lm1SXouYG4AyReKD46kubCSCp?=
 =?us-ascii?Q?igl6idtn918AkbuyV6EhE8aelqJevGtSbtZeO+5tSSq6aOTGFx593xwrat3S?=
 =?us-ascii?Q?YzGzMPj0Hr9h+EVepMIZqG4jTE3t2SG4nkkBFmWcGnjo0npnkhx8yL0bwmWK?=
 =?us-ascii?Q?79ww8fcDXLWInNkiSyE9y1+BNQbL3c8qUOZpDDNI21pbyM6bdVYND/JyXI2B?=
 =?us-ascii?Q?gC5O5o+QwJb5zKOr4PR9uQNZ0j5yeFU2KGzXethqWz/Ym4TCfW7OBJUEWxhE?=
 =?us-ascii?Q?vPsXKYXIHxIkQi4tuVjBSvJZ73g2C6zpMUtWvocRQCqh8X23c2zCFUyW314Z?=
 =?us-ascii?Q?mcPRdc1AOkhPuAk2ckPuA1jN1ZodvFRLdcPc7XxwjyWdYf6teE7aGKPvUtqT?=
 =?us-ascii?Q?rpckpo6ZuFmVJBYDSx8XKAt5g3O78owKVO0DCyWRWRyae53a/o5QHJRC5+Pf?=
 =?us-ascii?Q?xuS/OpCoO7ng3DZxY81ciy9Cc9WOnu63TmC7/t85O7+fPlStwVFW2+DAWl9v?=
 =?us-ascii?Q?ibcv6GMwoZfBXM7+Y0UhjT0xx/N3qPkz6FD3Mwcm7DM3g0Z3i2uwXzC4Btj6?=
 =?us-ascii?Q?3q0y+XlWnZWCzyL95IFMy7DtOpG7xwD4xlNiKSCwcD3Xi/IgFHbvU3v2JYoB?=
 =?us-ascii?Q?gsHKa65dalkrRzt4ehcqtkNuvDx1Y7Uas6FqtwOB8KF/41rUZETRsCvyR9Cv?=
 =?us-ascii?Q?Vn3dwss3a3bXY5FseBA7kb8hOdq4poSSUwXOJmK6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a40110a7-de19-4d1b-00df-08dc6ae25970
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 19:59:18.1504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLOcZXXv1NxJ7zGRBJ/v2NsLjdQl48LA7i+HUXqlrfy0GUJnyuv7c7sxNhyKvlIyetci3iD03z3WVURcUhBNrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9130

dma_set_mask_and_coherent() should never fail when the mask is >= 32bit,
unless the architecture has no DMA support. So no need check for the error
and also no need to set dma_set_mask_and_coherent(32) as a fallback.

Even if dma_set_mask_and_coherent(48) fails due to the lack of DMA support
(theoretically), then dma_set_mask_and_coherent(32) will also fail for the
same reason. So the fallback doesn't make sense.

Due to the above reasons, let's simplify the code by setting the streaming
and coherent DMA mask to 48 bits.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2:
    - Rework commit message according to mani's feedback.
    - Not sure why set to 48bit at original patch.
    
    Ref: https://lore.kernel.org/linux-pci/20240328154827.809286-1-Frank.Li@nxp.com/T/#u
    
    for document change patch. DMA document sample code is miss leading.
    fixed patch already accepted:
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=f7ae20f2fc4e6a5e32f43c4fa2acab3281a61c81

 drivers/misc/pci_endpoint_test.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index c38a6083f0a73..56ac6969a8f59 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -824,11 +824,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	init_completion(&test->irq_raised);
 	mutex_init(&test->mutex);
 
-	if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48)) != 0) &&
-	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)) != 0) {
-		dev_err(dev, "Cannot set DMA mask\n");
-		return -EINVAL;
-	}
+	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
 
 	err = pci_enable_device(pdev);
 	if (err) {
-- 
2.34.1


