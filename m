Return-Path: <linux-pci+bounces-30192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C62AE092D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 16:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E0518877FF
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 14:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37F223BF9F;
	Thu, 19 Jun 2025 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C3s5ZB4i"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012047.outbound.protection.outlook.com [52.101.71.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8A6230D0F;
	Thu, 19 Jun 2025 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344568; cv=fail; b=EIqlcA49UcbJM9dygt9ncQOs3kwnuRHxpQhUrqbtQVvUiUKJFjmsx0QxUFdlSOYGy4Qkog19ALkaiOdQ2IEyRBWBsYPkt+fh+55iO6Mv4IajrenEiZQ9TXrGQoUNsFHHcxJGfAX+psrPSO3dZeb3rZsCxAR6ww0tmfZXSZe1ibA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344568; c=relaxed/simple;
	bh=CBLw76R5g9UGgfhuUZd4x5bUTBReP3olEULAJAf20a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ashwlV2R0izraDZivn+ctZc+PNtE2yDE4i+gg0ZPztkiJT6o+h8ywgRadv1Q4ja39xytJ4TeEwks2hSakb1qW4mEGax7N7mXtDUv9EqcypDgeDf6MxsvOJuVdZS7DxhJSWGCJMJysnHOvCgLubXw8+OYrD84vOB6e+z7V13jxtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C3s5ZB4i; arc=fail smtp.client-ip=52.101.71.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAhv49qu6r0aGh72gqxsevO85mbI7f/S3A33rk1uwsZ1AJCPMZJrglncaKUFqr3eomxYockhtoAvVKvRvb4q0m+lMgo963ZGqaxsLtNcUM52OHzJZ/qaRFOjY8V9rxtEasjIKYVScrpVMWEj4mdQeJktzwT87Fk24KV+aMntyO9xlqnGKA4nHMAT0poG/P6cJdaJz9r1yquQFG92/JlNUQ7oYtryI42ziBTe78AgTp+/2f61eeckaMwXN9hO7KPs++JVMe5LeaNIB+rdyKoAQD5SucXEyaihLSf52ECxw1wHCgZk3wa0cqwRgGi7544dOWvQ87xW3uAK+UzsiqswgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5iBHjZSs296zhN+BuT7NXvKeJYL1VlJvd/PUitwoco=;
 b=JIkYVhfPj6bWwBfx8XrrGYyZESR5CyYGqsJsxY/orKeRk2EpLVAMt/BiyU8uv3wzILyQbpOYAnalKPTw132QqnVYkYXSmK0ogMsMXGt7UxEMJO/swzLdq77p2Qeqv/2eI9oY3d2rNMR6wPvInyYL8hmWqzYK3WvxCx87Md5m9gzsE9heNXf17LrtDSZ4Vdk8ULQJ+X7ykONgaYDp/oUv4RoqWws8IVtUBNkhNSd7L9y5llwNfNKhOKDlFLYt8AJglnIqDfLnBBxJ2t7xsM6lldvmS+XuOjgFWuCxXYaVGi3NY2tCT77oA5+uUiPhf/ZVCIY1ddx+lp0adco4SW7Iiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5iBHjZSs296zhN+BuT7NXvKeJYL1VlJvd/PUitwoco=;
 b=C3s5ZB4iboZTWcdMZN3a6U4F3/MvNsXJkyAj37MwJJco0rIMnr3AVFt1aKHuudOwKJ+ncjgKc+YS6jtTfT//M7DGXOB2LWdgYOdgtz9nPB+ny3UMIHHujCqW3a52Kdl6mYvBzA/lMPeuA6E3MoEvXcd5qTB+zj17ZtOh2OPc107bNWmilEj8xSUEDfi9zyPVyH0VA4dtww9m9RaL4wgS5Tk5vCWo18UYF7jdXNxd4IP0J0kSJRT8HjD+G/ecnl+fIoRbUP/atEvxTZmCYMSIts8Z1WN0nyCSPn8gkLpWDzTwYUYk892qogvWMShNBF28zldrb2kuAV1sMX+26aFKkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9264.eurprd04.prod.outlook.com (2603:10a6:20b:4c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Thu, 19 Jun
 2025 14:49:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 14:49:23 +0000
Date: Thu, 19 Jun 2025 10:49:15 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-binding: pci-imx6: Add external reference
 clock mode support
Message-ID: <aFQjaxITjVGmdW0U@lizhi-Precision-Tower-5810>
References: <20250619091004.338419-1-hongxing.zhu@nxp.com>
 <20250619091004.338419-2-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619091004.338419-2-hongxing.zhu@nxp.com>
X-ClientProxiedBy: PH8P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf32059-f0d6-44f1-dd87-08ddaf407ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qQlW7n16mEoAynxAi+0cz84mWG0lCFaBYK+DSk6w3fyhq4V3bjHi4dhWp4bv?=
 =?us-ascii?Q?hDCk2Bo/79Efw9dfWWTjX/Ta6G98fS2wsIWDmaA9JmzCYFUrnqwCmd3yZtQ5?=
 =?us-ascii?Q?EGdb9nMi/BRL7GMx928H6Heby5boxY0IAzDwRUuA1TfiOS33iztg8AEXx+rt?=
 =?us-ascii?Q?BvN+eWcZNJX+vMlDZCJQkq5l6bd3yfdN5Ms8BhZbGe5xTm32HHXeA5mFYxwV?=
 =?us-ascii?Q?Rhy/QWEhDshLFmPKGrfBhKI5ejvwX4GlVQjshWkNXxKEbTxBJwjV9Fklcf5p?=
 =?us-ascii?Q?DMWY3pv0XGXV4PRe0Wv6CiZ0J/0x1JvALQU5/9zyWf9tfRwNZMe3pm3BDfwi?=
 =?us-ascii?Q?WtPhpuzsNKLqHKVhpV3pKVQjrJL8LFNlj4+8Vmwuosv7Ar0QIksMGxNI9xjt?=
 =?us-ascii?Q?JUprW0V6yAkDooLTcI0z7anLXcetpN1LjPiHHA05hfAJQ0wxwqYi36My5x7d?=
 =?us-ascii?Q?ddF7EFlQiMIbAGwPT55TO+dDFU5UGV73Fg5acJO9ouYjX5we+IFBVffcxIIK?=
 =?us-ascii?Q?41bwoeCGfF3yrBWujC4CSyMGmYgheExyHfoGurjjjx3M2x5DrseqeRXr8ctG?=
 =?us-ascii?Q?OhuxnRSJ+Aljm/Arep6fjerFLhxmkluwmEgcrsASZQlxkVjASDGGKDCcaq3D?=
 =?us-ascii?Q?LmnBG4OYWkpA+wayIcMefNhi6mDELEkMXfBCuYBhiha+TEgZZALN6vyk7Do4?=
 =?us-ascii?Q?CiHJhE/Zi0dFyQVAsURezySqyGBBBaWzZcDgBxU0Aur9K7wXLanEYs+zaQsH?=
 =?us-ascii?Q?f+WjTbHpD1JaUcWsM1MKTbKUih+OHanuHl6ZSXoduZkw9uYYgTjB+qBkPsB7?=
 =?us-ascii?Q?4FLpym4Yg0ee60/VQXuHTjJpSTF7m3atab93scMmtnsgpBApEESdiTf0jept?=
 =?us-ascii?Q?rQO9cXSvBNblYHznHX+ocI4kl09d6sCPRwyMAlnKGsoxNWndlPiwYKMaY6h5?=
 =?us-ascii?Q?MYAiqFv2lOl7wgXXktE5aG1QKrwomAQVP6y5NqB41pieta5ZlmujO+PlTAFT?=
 =?us-ascii?Q?YJdJhjNfeLd8HpRtKIOyYiYa7Gm5hOJJjiNDawH7aaBVE+umNVkjrJWuWfZS?=
 =?us-ascii?Q?FM01QorAezVzCOIHhhEpBsEprwfgRg5Ui/b4033J6CHIeKZjnOoMIIOULITX?=
 =?us-ascii?Q?LqY5CWBGxAbaB2E26v3Cl2o2h9uWh4oUswErzwvtqiyCukMV3uJjwFbqedmY?=
 =?us-ascii?Q?E9Yf7ZLcx9KaCCoBVWSs2G2RimORLA4TB2BrwH1TqjLZLfMWcCKeG5Xp1UMW?=
 =?us-ascii?Q?lNOZ+qrPVOU1tmEu9DArfKv4Mdv+xFm4w7Mh5ks8z6idW+eAV/EywSVmo3zF?=
 =?us-ascii?Q?57KYO+AIOQAw/Vd+iTzB1llNa8pePoVOBv8nR+n+l/eKXByOGQyLvDeb1LjE?=
 =?us-ascii?Q?cDcTaZjt3f8b7fvfIwNUKit4yonZgpEkZRYaYOU0tvRTTMm9WtLQXVlfna20?=
 =?us-ascii?Q?l4v6qFrF6eLHjHPAuP6P8cvDX0IIYsFFZr7hSa6G5faRhndZRaOux2y6dFo7?=
 =?us-ascii?Q?idMEJ0/uahd5ASA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uaZxUKz7gAi1GvW6XZdsU2JWorqyWZJEvVLEg5qPIXXD+CDH+75al1E5sB9B?=
 =?us-ascii?Q?rWBw92H4SHkKNgDVcaTioPtAicjdq48oJnShJfFbidlim9RjRbLTNwacDmtg?=
 =?us-ascii?Q?PY4JCDYIZf2OrA4T+MCCY6eGRxNqWBmSeTfNeuO/xxIDwXwVk1Kh06pwhytu?=
 =?us-ascii?Q?64N4689xxKfNUWBRJsDT6Gd8iPwL5qFsM/W1LuCbdWPh+I4IDU31XvK60bMy?=
 =?us-ascii?Q?AjZaRL05cARl/0ShWRXBM4qTjXmNLzRYSu5wZOG2Cpd+Ysx0oRFJq7Q3m21q?=
 =?us-ascii?Q?j+cHBYAihxiuIqV3VG0TmPI6B2+8bRW24JbOVgOs4SH5MwxVdAFfZnnFU22N?=
 =?us-ascii?Q?+jNpTVcwsI0AgBk8vT3xEtn3w6ahAIixCa/GRXz9lRZh6h97IP9WvxXYzkKr?=
 =?us-ascii?Q?VjUu9BwQz3eNrgcLRZ1qOlYDA9dAMjl5161heyGjwSZqYLd/4H4SvDNCC3rR?=
 =?us-ascii?Q?KRt6sDAIPZbrPs6a55jJntruHe2OwYXt2TgdcarY6MxjBq+frouAWti+UPgI?=
 =?us-ascii?Q?etOpf9QsA1pnKMdY+X0cKUAmPlaagemP/godv4zk7ejfJo+xZK61qZHPXrBd?=
 =?us-ascii?Q?BJObPprq5QCo50AQvuOR88al7CO8FXxfikpBZAlpkIbJ3bUvv4gUic93Mg7/?=
 =?us-ascii?Q?SREsy6GYMGKXeWM5QKCQ9MULZ5dpqoq3zQ6cFvAXlTVxbRRk6Kp3/PYQ1kD4?=
 =?us-ascii?Q?of+bglczJqdFUI7NTUfBvP46Cd0IedSbuzr/CCQTMlyGTEVF/PRoSjZ0ooYT?=
 =?us-ascii?Q?e2VH1+tgFSCrzlQ0lc3h4JznmNV4H0Jeu9CRuJjxR/jVm7WmBtAuXEdUUIAh?=
 =?us-ascii?Q?N1h5xC4Y1+I+PLHiAUe35lm811X1U6PqM6nD4Dmmwg1dfzA6qksU8b6SHU7Q?=
 =?us-ascii?Q?htheBi++zbwF41szuL1bo5E04EJ/h7XFINsZX/DQuZUasY+FlL3KVDLhpcAY?=
 =?us-ascii?Q?GUIWxmTqTx817oqCiFE0CKglPowHVa2yjSZb3a7Wq2/sjkn3w+v1RTts4rx6?=
 =?us-ascii?Q?MHvC3eeKWHZtyedpEdnkXEX8eExZbg5u7Vf/1iToaV6IPhe72UsX1dsp2QQZ?=
 =?us-ascii?Q?/15oL5LgJjNPd7Zi9AdgMmGt7ZQ+nMyjAxjR6rvti16ks24dvY7n474Vx7Fp?=
 =?us-ascii?Q?fnet2rTzP9UY58RjoPFN8D7xW1x8J9S+it/mzvfWYtku9ltehmfEpiRZHQUE?=
 =?us-ascii?Q?OOARgRpSgban0vtv0eZ53OjqvJDof/KAWd8zerS3XB51IBj45DGsYcoYbUBN?=
 =?us-ascii?Q?ssWmVq8E1X7pvElzXzjVFVPuqq6Y03Y0pvKAgeJTDvbFtFgnzDeURQjYeAkN?=
 =?us-ascii?Q?rzVYCuTTQPR47HEQlZjQkqx6c5FHVLJP9P0mnZdBVcV2CAa53P9iFRoJntXi?=
 =?us-ascii?Q?Y3Y4F5bjvlWlBuC12DXi0uIEcG30NtuOW6JhRCVid09BI9kbHNJXoAEeF2pP?=
 =?us-ascii?Q?IW8YzR7HrDg7zI7102L3jrIrQsWkPb8OJXd2Lk0van8NhWedL2K7E2D80F2B?=
 =?us-ascii?Q?7g1+buSaIkvyD+am4/8NEL0p6O3EfGlKCiQDCZpQTwo54JMdSsFZEMuwwrkH?=
 =?us-ascii?Q?BiqwZ8SnNOviCVllTZszyygoCYJGgaEzo2oNNDrv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf32059-f0d6-44f1-dd87-08ddaf407ac5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 14:49:23.0661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPll8OqxP2roXSSnSNxamxq749WQGbdDd1Shx4FGCDosmK1x+7K3BPCaI2lCKJakGyGjUfNHYuLRhDpGKJ5HGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9264

On Thu, Jun 19, 2025 at 05:10:03PM +0800, Richard Zhu wrote:
> On i.MX, the PCIe reference clock might come from either internal
> system PLL or external clock source.
> Add the external reference clock source for reference clock.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index ca5f2970f217..c472a5daae6e 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -219,7 +219,12 @@ allOf:
>              - const: pcie_bus
>              - const: pcie_phy
>              - const: pcie_aux
> -            - const: ref
> +            - description: PCIe reference clock.
> +              oneOf:
> +                - description: The controller might be configured clocking
> +                    coming in from either an internal system PLL or an
> +                    external clock source.
> +                  enum: [ref, gio]
>
>  unevaluatedProperties: false
>
> --
> 2.37.1
>

