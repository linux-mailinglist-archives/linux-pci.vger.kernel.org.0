Return-Path: <linux-pci+bounces-25982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 086A9A8B30B
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 10:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6405419048B6
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 08:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA95722F15C;
	Wed, 16 Apr 2025 08:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JU8eyqG5"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE3C158520;
	Wed, 16 Apr 2025 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791285; cv=fail; b=A3ypbCaIjxOsVr9fWLSyGCtA02xtopTqwSQGgh+t5nfLz4/Xm6vIIaFvHFE4NczZdsrIZDDdxryGXEeUuy0J7m9E3AsvaENGZhLjXVSyU2lfpAFpyn6g5Ex/OE0rj8wjdYy9JOpSQult0CESM7bCG7N+SpEOnN5GfblkPV8TITc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791285; c=relaxed/simple;
	bh=Q+7aj89sP0BEmGHS9YXA+++Al9pMuTGaiBGV3A7vJ7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BMYFf+IqqFAPZGZejiFgSmQnV9EUoqzrGSNDzd0zbT0Yri/qeuA6GRVI7u7OcGb2Iis5ydvBENNK1aoPFJunrBQZNFnvQQ/5h5KSwmsxh4NmoY3WJ3AppcEmGYOsdQY5eio3Bot6K7KPJXmwI+Kegr1u+ajMmwdvA3oKWv+xi14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JU8eyqG5; arc=fail smtp.client-ip=40.107.21.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMRA2jLL+5V/BzwuiKsoF9ylgrGCAfpwISNvzkPMlWyk26HgMwMwNwTAxiWVwTESn6lJX2xhXL1fArBsUjZYYpf1XjDQ0RwIszJh9Cjlnp0u5K+c8gBhd3bVDfQ6YdERcrX8l7iteEV80ddVqg+Wik8UUYQrmjtsXo6kwlqEaDr5PNfj3zedDx1TMgtf8Hnj//YgW7HA7tErSOj8+S+NM2j5hK3eE9Ql/qnmxSvFIGvaBq0rKiEGd761gB39MGDc2lQrkDKFypdNq3nr6saCMyGV8zoJDDiMXu0Fnu4toGAKWe9NOLz6u61DeLVuzll5At/MDowaTj/LuR4Ixu/AxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zEWZQN+n4oZe8uJZywWn6S5+wYmTl0ZjXEmh28ODIo=;
 b=Qwpn1TXZyy3V2NCJzVa8quNXHAyjVGdWNnYG3lmEbzQXN4jzWTLDcwFaHlmU7TEQcFzCHWkRG9hJqREgIFNIUhlqTP4kBTH+l8+Gl74jkRIqGp1XaXJqqffR7Xpc8xejdW1+NfAhMp+U7wIPRYt+nU+Mf0gnVEhR14VOxRmzBLcbDwxmQwjcGFUbvhoz76bzvF27LuCkFRt/NTYhoiUDT5nUd8HczVszVv7Wmt14X8cPeLARLOgV4Z+ese9bjDypIt8rNpHwX+WrT1M4Q+sHuwXIJprpMTpey7v3MLSiF6ixynw7kWMngKpx5YcMU0W9yGMzWBy/nMD5mXuJIVqyKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zEWZQN+n4oZe8uJZywWn6S5+wYmTl0ZjXEmh28ODIo=;
 b=JU8eyqG5OZLvW+ayREg652L7raZ+ZYStbDQ2P7pYZLH8WnJzn/7XRHOGjlEm7tm4wtdSJkKfp8sLXL4Vbhdj6bikDnKb+1TFe+PonxUlziL/SI+m2pHKASlU6DNhRRqocQqv+CaWzC2Afhn3/AOH4M+sSQXU0YTaH6fvpTHSBNB3nC7hKz7cYqiuLxD0s0x+LmD7du/j8d7ejnuUNMdhBhqvpO6SLChvwhdj83WYTCUw8BcUFoVmPlNqGG0zB5Yinbdf0AbcrMo40Hkg2dEmKNU/olLqxlHDE0eaY6qGeOZcVyNtbP1iTtDiQ7KQpb/K6pPOeRvm3QVhpdQ5IXoPZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB7103.eurprd04.prod.outlook.com (2603:10a6:800:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 16 Apr
 2025 08:14:40 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 08:14:40 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v6 0/7] Add some enhancements for i.MX95 PCIe
Date: Wed, 16 Apr 2025 16:13:07 +0800
Message-Id: <20250416081314.3929794-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|VI1PR04MB7103:EE_
X-MS-Office365-Filtering-Correlation-Id: aef97e71-a5f1-4d07-a698-08dd7cbebc30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nhi4kka4PnPsZZ4tfp2tla4mPl2HfsF9qpIkg8zKzDipdgemJRs8s8fZd1nv?=
 =?us-ascii?Q?qf/urItjKhXcUAvUe2CuqK87jxYN6pV3VNS2uw3ixkla1ygfsqYv5l2T/y7u?=
 =?us-ascii?Q?JCe34+EmYssePs6mbTzWUq9QuBE/7NoHwf+kd5pMyhpLxM5lxREiCHh3hees?=
 =?us-ascii?Q?U4i+Za3f3XOIab8EIb3tU5VKCCFo4+TKpRT9qDC5vD3WYOKiOHDZEdY4RqnZ?=
 =?us-ascii?Q?x/NCVEblh7K1PdQCxtsJtsbXszlQXw/Ru96Q59/nMyx2BJ7R1PBhKR9eLjHk?=
 =?us-ascii?Q?Qak05MpRUVvttM6vs7ba1ltmPwB0ZIcajOEqWYkGF6zGhM5vNX8F2Sr9X1Id?=
 =?us-ascii?Q?uVjfmPzqecRyNuCiCVzttdurfdqVDSxKTDajzZmA0F/8M3DduInYicUD9B9/?=
 =?us-ascii?Q?o8Fmg17QXZzTyYJQKiLuL2vZR2yUKrvwsuNQI8+zh2sicYAB+hxIY2rEHxxP?=
 =?us-ascii?Q?dS0c3hGD8+uFbmlyfVs+kEDjS9bb3v07qjwkKD7c6lCcUncpsKqhMn81KrUd?=
 =?us-ascii?Q?ILxp5MJTk1yFe/8a82x8IFtqV+AKrOPLnD4i2OGvpz6a/HLX+URSQsgQjfn2?=
 =?us-ascii?Q?Rd6rATsylZm1tO+ottVnu/cwBbf030YrU/5C6n74TZqY8sD+U6kLRAbJ5AB7?=
 =?us-ascii?Q?ZF+RwXYrC429w2FBHtwflkug4FphBo7yExDSPH7jPZXpUMJRA+sYuI/ZuqQj?=
 =?us-ascii?Q?LYDB4+BMCo6ESCInja+iqtX+F60FwmXVY6rF4SLfVUVYnvdMtUmuetyCrV8N?=
 =?us-ascii?Q?9c33iLhKYgQMnAL5B+dXmzzp+SufP4GH0u4XIa9kfbTobYwqJgddLNWBOJna?=
 =?us-ascii?Q?r/d2SHEUeqzR+G6f2QCMDE+t5eZz2xZx8ffB0Y4pPQtC1EPxVDw122nsOVPX?=
 =?us-ascii?Q?sroh+EQyNakn/lTjmS4jIenh8rBxVegtirF/1mSg99Sl70jO4q3riBcgIQEl?=
 =?us-ascii?Q?tmVE8MLrhAN70/6g/0+PujH6keOkDnlvvWFBr4UDxiZky0d1KC/cP6VQFkT0?=
 =?us-ascii?Q?GRM5vTaxJaYgGrGewLQfM1uZrrYY0l60gj92SPiSVf+2wWxkDZOwynoyl+ZO?=
 =?us-ascii?Q?HS1fM+iowDHihAoEaLGqSGUiD8ODSIPmaIyGcxYKxIyzuHga7YJci5UnXd17?=
 =?us-ascii?Q?olz4SoD64y0/lbAqTq0vjbCSBLOEb1AHwsJYeTgM6CQOXtVzYGZsFoNEVtiv?=
 =?us-ascii?Q?a6PY0BO7ro0zCpqjo5+Z7mPPfq/o+6BOGIeVa/4IJUY0MUQcPBkss4eeAlb6?=
 =?us-ascii?Q?5ERTOsgDeMFqF3sMgRm6pt0ikAetX+BNCiOzG+bTcEL0+LgDqJ4pmxkx/edj?=
 =?us-ascii?Q?V8DMO5GoKkP0SDlhmvzFcoBqbuA8/n0sm6vMU+WecH+V757Pp8Q4rQ7FlPi/?=
 =?us-ascii?Q?fVT3TdXHsv+6OOIo9tFV2P3Qo6sujoQ47SD3cLXf8cX56aDaFh3l6vLEAQ/w?=
 =?us-ascii?Q?8MPEYcaGo1k5NKLHC+3hCGHeABvw8noby0//pyj3bVETiXUtzTbqhWqQz9kL?=
 =?us-ascii?Q?b362qKurIF1f0nE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?131EIMS+ugIjvM/S+QohK0zTroDQe2R/COP959UyCeTDVy0Ch8xUGj7sQ1sd?=
 =?us-ascii?Q?P2xfoaj/7qIhs48xh1+shSE+TbV6RtGYu9LTnv9JwjKRaoupCuOEd1pKNm+a?=
 =?us-ascii?Q?BnUPnS8ayJmm7KGCMGcDJJ0EDN5BNMdOkFWcmhWgFi0dn/8hngoR65jXc+kM?=
 =?us-ascii?Q?MZ6fFbQwAOnoOSwoYo9sM7nsHkYDqQqQ/YIXvgzKuvloXfFYOwcsIayqUthb?=
 =?us-ascii?Q?EXK+RPq/xM0udbJ88zwgUB28sRyUeHandscqqDOf+I1S/so/e/sgdeoRfcwb?=
 =?us-ascii?Q?OVYMFRdaY7AELD/sZOzREbkA6L7/ofd3+lHPaJ2oBd20hijIncdYnjpA/GpD?=
 =?us-ascii?Q?tUVYulRqEDuhdrE0Bkql+x8U6d4m721MoJ4uDDhX8R2n4S3oOt7atX1cr2bP?=
 =?us-ascii?Q?ZmuuUOwUSdd6rl6WSbEJ9LrUtKjOv8kcsWqvgyPH26MnqM7Fu6Z6YGEvJkK0?=
 =?us-ascii?Q?X31wBgtOgVstFb6MWc+k6SGtnMWSsVkOfckeP+p9EPYvjkRVgYRXx/tBzLIp?=
 =?us-ascii?Q?l073euY78rQpDary06rgKMLagA7Ta1Y8g8/2BlVOn7y8+2ifMFHF7bjFhCQq?=
 =?us-ascii?Q?F2TM41L5R71L0Lcd0aP3D7fTDlyTHEZcWkeKu2BDDQYte+VdDpWL3mcRCfsG?=
 =?us-ascii?Q?DVdjAEiYCZ+ekwjDaKsNw1vt71+8uXk2or26RMCNxSb95YOunmDRwp2s3W2f?=
 =?us-ascii?Q?Swv9ZhXeG2C7df+5+mNILl0Rag6rK3GTl7yKh9/qXrxfZwd2KOWJAecCXQqN?=
 =?us-ascii?Q?Ic+1JspUPnXUTDey697K/HyOpyxsvJguqbK6V3nh/btTzFD/Yq01SNivxXo9?=
 =?us-ascii?Q?owmYv8w22L7732iatJC22AzvNfXo6t8I4uJuNpwJGHoX3V/maeCcai6bijVW?=
 =?us-ascii?Q?0HNkTuWeb6QL9YCQsbumVfGJhabV3y2LiyiYt8ivoYzXyMGqqHP6VG9adFyb?=
 =?us-ascii?Q?IlYwOXIgH91NzQzXKU5t+Ny5Kw5s09xS8Sii5SZEfR8c6AaCDX0V60J2RFVM?=
 =?us-ascii?Q?3i/JGbSWjDD1TKdj9z15CWWA00ORJuPQUIn3mfHgbcD+xT/OjYbukgACBIWf?=
 =?us-ascii?Q?0CPLFeeJGc17zDSrVk+hwe2e8lJaKu1fxaGqJYD6Yiu+uwgt0k7c+nCmDEM7?=
 =?us-ascii?Q?DSAeaxq3r55NFcWtOZbBAnPyUjafbzTn8pr1LuXs5Nif9eQHHDVQNEMIxoOI?=
 =?us-ascii?Q?szfzQGurlAcTeb2GjVqfNfmdhE38v3BwT8KtY/MT60g89PH0QWLDdpikozw6?=
 =?us-ascii?Q?I+vTjQRo8PLsnVKJ2HK1jV3ra6b30HeaKv7/i1G2K08uj2DoBaxqt6TUyDul?=
 =?us-ascii?Q?Z4LXrJch9Mbh/u3zRjVQI+0oWcxzkoFFvsQSbOSIBH6q9rjrrS1IkAlIn6JD?=
 =?us-ascii?Q?2taUmlWVBqmCtw4RFZooUjfWY6XUtW3/26+2+YUpJBEeg8OoTNbbiSLFUCK+?=
 =?us-ascii?Q?BcisyCwLW0IzUEQ9eQ6X4eg8q6JsreveERy3pBKOvsr+DmpUaaV+Pcsi0aid?=
 =?us-ascii?Q?L7fm76OtBArMO++7WuRSlxUc77Fs9kaDjbEDVnfKiBTCZwn86D2Dc7OX3DPL?=
 =?us-ascii?Q?AW58ZN9DYMltuoOasFhXd1CkVt9wW/tK1RQFa+a3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef97e71-a5f1-4d07-a698-08dd7cbebc30
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 08:14:40.2452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lysmbeJcVh5YMem/d6B1n52p2MYRAas+Dftm/1ECiWX3Y7JQmJNRbE0SDPzXMiPl18Sr0lNiMvifVNsBrH2ytA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7103

Add some enhancements for i.MX95 PCIe.
- Refine the link procedure to speed up link training.
- Add two ERRATA SW workarounds.
- To align PHY's power on sequency, add COLD reset.
- Add PLL clock lock check.
- Save/retore the LUT table in supend/resume callbacks.
- 3/7 relies on "arm64: dts: imx95: Correct the range of PCIe app-reg region"
  https://lore.kernel.org/imx/20250314060104.390065-1-hongxing.zhu@nxp.com/

v6 changes:
- Move the PLL clock lock check out of core_reset, and collect to a new
  callback function.
- Update the commit message of 4/7.
- Correct the typo errors in the commit messgage of 2/7 patch refer to
  Alok's comments. Thanks.
- Add the dependecy of 3/7 into the cover letter refer to Alexander'
  comments.

v5 changes:
- Rebase to v6.15-rc1
- Update the commit message of "PCI: imx6: Skip one dw_pcie_wait_for_link() in"

v4 changes:
- Add another patch to skip one dw_pcie_wait_for_link() in the workaround link
  training refer to Mani' suggestion.
- Rephrase the comments in "PCI: imx6: Toggle the cold reset for i.MX95 PCIe".
- Correct the error return in "PCI: imx6: Add PLL clock lock check for i.MX95 PCIe".
- Collect and add the Reviewd-by tags.

v3 changes:
- Correct the typo error in first patch, and update the commit message of
  #1 and #6 pathes.
- Use a quirk flag to specify the errata workaround contained in post_init.

v2 changes:
- Correct typo error, and update commit message.
- Replace regmap_update_bits() by regmap_set_bits/regmap_clear_bits.
- Use post_init callback of dw_pcie_host_ops.
- Add one more PLL lock check patch.
- Reformat LUT save and restore functions.

[PATCH RESEND v6 1/7] PCI: imx6: Start link directly when workaround
[PATCH RESEND v6 2/7] PCI: imx6: Skip one dw_pcie_wait_for_link() in
[PATCH RESEND v6 3/7] PCI: imx6: Toggle the cold reset for i.MX95
[PATCH RESEND v6 4/7] PCI: imx6: Workaround i.MX95 PCIe may not exit
[PATCH RESEND v6 5/7] PCI: imx6: Let i.MX95 PCIe compliance with
[PATCH RESEND v6 6/7] PCI: imx6: Add PLL clock lock check for i.MX95
[PATCH RESEND v6 7/7] PCI: imx6: Save and restore the LUT setting for

drivers/pci/controller/dwc/pci-imx6.c | 213 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
1 file changed, 182 insertions(+), 31 deletions(-)


