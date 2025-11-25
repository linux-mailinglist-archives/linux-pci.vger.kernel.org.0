Return-Path: <linux-pci+bounces-42017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B31EC83D5D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 08:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6176C3AFF3E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 07:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9FC2F9DAB;
	Tue, 25 Nov 2025 07:56:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2096.outbound.protection.partner.outlook.cn [139.219.17.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF12D7D42;
	Tue, 25 Nov 2025 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057388; cv=fail; b=oMDs+R5f8pfG/6NpVpxS9D2cQXDsHy6mtldPCLT8hTYHYbHsqLhym3sBpeZ+JZu4b/gZKudbCP19pLRW9gpnmiofyqLll05q5DLxGjAti/IZVKQEHzsRos2OjEkBYHJp7PetWc5KkUuf0Xl/cjJIqco/Wyi/GJZ6I5CqSLA+hvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057388; c=relaxed/simple;
	bh=sCl7c15XPNfM2DQVduY5R/2uLdSY35FS+LwzWiEEmvs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U0srZjPH0xxhnd/tzF9nvokdD4TgPZqVr16acinEeQyjp4xYG0WSegIcODn7zNM40mj6d6bVqNDZXNCgmnI2buUwj4m/U46pSl72hsIm3PJ7B3dVt4ob4vZQH6ojkXKMagAOdbtncW0EyhneMoaDgOsku2PnaLsgPSRcQp+DFAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iac+k4AG8EuzAIk4q0qIC5WTnPVabL3+9y6PRS7V8EeeA+YgwmNBPRqWHTTCR80xLwodRenqyq9HIUl94fFjF45JPaHtoBn4sqRZLsFxZjOyp2v7JjY/0ctSS0DNkMCh07LP99ChHPvr01ZtmEx0T945xJB25VTlu/e2i3RQ06x1ZPU8tCzfp7T6ETvH2w+bFD0nB3SwZA1WP3KkLc7e1FaNx86Qz/vn9pENQRu0Uqhebtgc5Te05H2ROP2K9cIpN1jEyoNE8u8KOX/sCUfPOMPVayRL1Bkqe5PwUxFBlliJ3UiecXKICZE9koXqFeSvoqepr6BtoE8qcsabvNU3vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/W9B4rVkTyRyqqZydAZnsxYyIsIqgz0uyA80j4onAe8=;
 b=loGjd5XciJ37G4UsfI0ObBBGK6Zr18eHPW1j1yeFomQJW4f/wo2wazO2tqLOjUV2hPjlXkBJUheP+VoZcRKv1Fsk/QX1Rog2G87V85sryaCIlWmSn/oXlNJF1IN2mnA1fhTX0EpsP6J0WMDtXKzyWJlzjQJjFAFMeJSJ0U4BS1JXrRjMJ9skaEAXWcsGLau/Kb4uLFSZC4JROD7nBsCBbDctY93/5GAaFwBw/cWeoyCI9coYuyc8VLlOAgZGOdHeC4wkl+F6XWCJJSnBEoFQfpkZFcXq7wKoNcBUM2t2zMCGeyo8e+z9xJ8KikOxazaQF1Iicl7K+sZMztiiFgDJ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1241.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Tue, 25 Nov
 2025 07:56:12 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9320.024; Tue, 25 Nov 2025
 07:56:12 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] Add support for StarFive VisionFive 2 Lite board
Date: Tue, 25 Nov 2025 15:55:58 +0800
Message-ID: <20251125075604.69370-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1241:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd38fa9-e98e-46f4-07b4-08de2bf81a0c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|41320700013|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	tvgVUitx1wqAO+B7X9m5153Ql+ob2EfjBRN0PGIAjtIOD91qFDtAuG5LcoKUAkyjX78Tn+angj33lb7o83zuFI1w11WpC1PSko6DiBrd6JMJ6rtH18yJ1zmHxWEzLseLSehrVhYPThMswSMVZalH8mYi+R+rhtNUnyTXWQI+tnzmgR8ElDkSdAAKAmKTGSKNORszvulLdDWwWubUCDXFrZCL9smG9XnkcGtRSTkFmeMIOu1weZKWfDZToNmal1AWbRxGfwjuTOiRBKQL9ZQPiYLj0WdvjQ/so7Cq6g0sdTaql0ISc78zzPYvXHPRgkhfZrDp7EnMBztWqu/7S+j1W9mC34Y/vEHNyDwn5smlfmOTXb0IYne/LqauOExnulPs72GWu406kdeqSUBOUPpUq2k6tgzkpxKrk3Gx3X/XaMLggiuGJVaSWmCCCLhhCC6IuZVJVGk+F5zlkcvSX5D1SNyEs/24YUWGsSeo0XBdTvJIKA5aVY929TpHasFJsnykxFn3t5VCJamRUrd95N2c3406dyhBzcxEkTxenBj5J6g+NxkoTBD3+c5V5Or+YohXXjO/9PmP9pSfEl3IZM+lou/ZhNdJDWR+NUxYiBq9UNs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(41320700013)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GYAlKPFTeThkn3xrm8aJ85t4hC446LEqVuHVxKGNoDrC4lA/VJ/MykmfL05p?=
 =?us-ascii?Q?xFJspbM5RkaubQm/Qht+GWSaQe+Ed+XyDa8EW/2iK/XWY5a1BAwqv6FhHMMq?=
 =?us-ascii?Q?aiVqEpALJOO9XNimaX28JmjKiyKdW9yNLi/fMQa3/B7+YDgk6r2U4QRtKXGN?=
 =?us-ascii?Q?8VfWs7gc0xEHSgH/0qk1v6GhK+LzjSUuc0uxPMLx7jz7f7//MQxgNhvGjfyY?=
 =?us-ascii?Q?aeYqKLDnQLCynJ59lX604L8ZmYg79qFL8VeCCycwYgdOTo2M0qj8WSYWMhiN?=
 =?us-ascii?Q?hPGeO8sXHI9FE+bDALHs+zXx+pw0EiapdbMYIFBAxolYX4UxeDT2e0mUHNFO?=
 =?us-ascii?Q?ExCNvYp3phfxtC7qPYyDwMFKAjd1V+dt8U9eBqhkShpSMNszisZ8yFtAAZWQ?=
 =?us-ascii?Q?dCzaAEtDQh4u1kdF0dbS3+8JomIdywTW27S0p4FGYNflc/8rvJ3TC1I1VsPZ?=
 =?us-ascii?Q?GrL3pIFPTR+UqTVs8PXfjN1Dk5A3w6PtvR9JA2Q0n1nAarucRzelV55NhtIj?=
 =?us-ascii?Q?YbAfcn/h7teQ/hh7ZAlsl/sRgo/++iN4obPhcTFHTX560uP8eHaPDTJH1WWL?=
 =?us-ascii?Q?K/vKp+B1XksveFiG3q/qyNcEgUjDPKH7pIUAYub/tzXDe/6zOG35aQqRIZnV?=
 =?us-ascii?Q?qIwS54HrsniFWP4HgaKeSuiamdTO+z4CnLB8WVigIVdOxTesVVWeZuZJISLm?=
 =?us-ascii?Q?eAYfKWPmL+z79gSul5gtDE0EK7eLJ+4UNiqOpvJ0rvN1Jkr50JtCpeg3M+ri?=
 =?us-ascii?Q?W79tlw2PEndc1kN3wq5zLyVtJ74LfLAMoKdV5LNiRBpo8Ku7ZtzlVQlRt7iG?=
 =?us-ascii?Q?k/3aOLjhjkhJVmuxhfMhxTQVp7sQJbkT63BQMN94D6C/N5MB1FZXj3VjC/by?=
 =?us-ascii?Q?/185UQcXRoAOtN+Gisaj2RhJL7FxFUSC4ROQRUj7tfJjH054hnJVEgV/rQDZ?=
 =?us-ascii?Q?aawAUu+AD49j9D76HafspeJj1ZsYyotQ+JykqbwhpSGLh9LvU1zv4lUpUiaq?=
 =?us-ascii?Q?CT4+hlJiLoIzmmPvX1iuGSzwrDwUPV20mMvcBKnkcnc6KLBk5B64hsUJ8ZZb?=
 =?us-ascii?Q?7uMeeXQ1qzMxPGiP664iOupIqbu9dzhoIgcYOT/xpE6u2MBc7P2PCnHOazXM?=
 =?us-ascii?Q?xEVXk9XrNhRU5xMDiSeOkTQvzp77hZYD6J0wH8kJgzEroxE1xjiXyRjAh7xy?=
 =?us-ascii?Q?sKWD8oa08kzhCbitlf+Jz1xm1G2DtJ/khTx96RrKS9r6hQmNnZRhEv1po1ck?=
 =?us-ascii?Q?fNoAnptTEptqMCqGEtyenGcHsHLavFIUXdFBED64h+M0dGYN+4qq937O1Bmo?=
 =?us-ascii?Q?/3CVkf3Zm/l88T/wkzRAaEj8LuSiF63eJAwqbdO9XhgAZhn1eWsI+OwjbZtt?=
 =?us-ascii?Q?aZMZ5gV93JJnltXlTZ6FfIIrBAYpGaGkxnv8Ii0zTEw1aYYw93jugFrxYQTb?=
 =?us-ascii?Q?gy12PETywKPUz0q91ossKqHzTsgPO0LtFOg7dPD4YwPi5QQax2kAlK5bLK2w?=
 =?us-ascii?Q?Yxf+UtT1i8DhLwkuI5IOUP+rjFUtnklUxMGNUxi6Wj9B6DdPkDH8aLyNFqd9?=
 =?us-ascii?Q?PSU7CK/oWfX/MKoNbpJcdOpkZs5paVXogwD7JYM3EkOiJKBYHciVsWgPA5bQ?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd38fa9-e98e-46f4-07b4-08de2bf81a0c
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:56:12.3744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npzpvTdXZ0p6UZGjGdBsb2tAqBC7jVMWZjejXp8Q+DBB0dg+18vYqRqk8v7DWJWMaFDQIibwO/xHyvWzlgsHo2stYgYsMa0UoLse/ZpMSOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1241

VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S industrial
SoC which can run at -40~85 degrees centigrade and up to 1.25GHz.

Board features:
- JH7110S SoC
- 4/8 GiB LPDDR4 DRAM
- AXP15060 PMIC
- 40 pin GPIO header
- 1x USB 3.0 host port
- 3x USB 2.0 host port
- 1x M.2 M-Key (size: 2242)
- 1x MicroSD slot (optional non-removable 64GiB eMMC)
- 1x QSPI Flash
- 1x I2C EEPROM
- 1x 1Gbps Ethernet port
- SDIO-based Wi-Fi & UART-based Bluetooth
- 1x HDMI port
- 1x 2-lane DSI
- 1x 2-lane CSI

VisionFive 2 Lite schematics: https://doc-en.rvspace.org/VisionFive2Lite/PDF/VF2_LITE_V1.10_TF_20250818_SCH.pdf
VisionFive 2 Lite Quick Start Guide: https://doc-en.rvspace.org/VisionFive2Lite/VisionFive2LiteQSG/index.html
More documents: https://doc-en.rvspace.org/Doc_Center/visionfive_2_lite.html

Changes since v3:
patch 1:
- Enable PCIe slot 3V3 power using regulator APIs instead of GPIO APIs.
patch 3: (reuse the dts structure implemented in v1)
- Add a new patch to move out the uncommon nodes in jh7110-common.dtsi.
- Include "jh7110-common.dtsi" instead of "jh7110.dtsi".
- Add the regulator-vcc-3v3-pcie node and reference it in the pcie1 node.
patch 3, 4, 5:
- Use "jh7110" instead of "jh7110s" as the device tree filename prefix.

Changes since v2:
- Drop patch 3, 4, 5.
patch 6:
- jh7110s-starfive-visionfive-2-lite.dtsi directly includes "jh7110.dtsi"
  instead of "jh7110s-common.dtsi".

Changes since v1:
- Drop patch 1 because it is applied.
- Rename jh7110.dtsi to jh711x.dtsi.
- Move the content of jh7110-common.dtsi to the new file
  jh711x-common.dtsi and move opp table to jh7110-common.dtsi.
patch 4:
- Move the uncommon nodes to jh7110-common.dtsi instead of board dts.
patch 5:
- Add jh7110s-common.dtsi and include it in jh7110s-starfive-visionfive-2-lite.dtsi.

Changes since RFC:
- Add jh7110s compatible to the generic cpufreq driver.
- Fix the dtbs_check error by adding the missing "enable-gpios" property
  in jh7110 pcie dt-bindings.
- Rebase on the latest mainline.
- Add VisionFive 2 Lite eMMC board device tree and add a common board dtsi
  for VisionFive 2 Lite variants.
- Add usb switch pin configuration (GPIO62).
- Improve the commit messages.

History:
v3: https://lore.kernel.org/all/20251120082946.109378-1-hal.feng@starfivetech.com/
v2: https://lore.kernel.org/all/20251107095530.114775-1-hal.feng@starfivetech.com/
v1: https://lore.kernel.org/all/20251016080054.12484-1-hal.feng@starfivetech.com/
RFC: https://lore.kernel.org/all/20250821100930.71404-1-hal.feng@starfivetech.com/

Hal Feng (6):
  PCI: starfive: Use regulator APIs instead of GPIO APIs to enable the
    3V3 power supply of PCIe slots
  dt-bindings: riscv: Add StarFive JH7110S SoC and VisionFive 2 Lite
    board
  riscv: dts: starfive: jh7110-common: Move out some nodes to the board
    dts
  riscv: dts: starfive: Add common board dtsi for VisionFive 2 Lite
    variants
  riscv: dts: starfive: Add VisionFive 2 Lite board device tree
  riscv: dts: starfive: Add VisionFive 2 Lite eMMC board device tree

 .../devicetree/bindings/riscv/starfive.yaml   |   6 +
 arch/riscv/boot/dts/starfive/Makefile         |   2 +
 .../boot/dts/starfive/jh7110-common.dtsi      |   8 -
 .../jh7110-deepcomputing-fml13v01.dts         |  14 ++
 .../boot/dts/starfive/jh7110-milkv-mars.dts   |  14 ++
 .../dts/starfive/jh7110-milkv-marscm-emmc.dts |   9 +
 .../dts/starfive/jh7110-milkv-marscm-lite.dts |   1 +
 .../dts/starfive/jh7110-pine64-star64.dts     |  14 ++
 ...jh7110-starfive-visionfive-2-lite-emmc.dts |  22 +++
 .../jh7110-starfive-visionfive-2-lite.dts     |  20 +++
 .../jh7110-starfive-visionfive-2-lite.dtsi    | 161 ++++++++++++++++++
 .../jh7110-starfive-visionfive-2.dtsi         |  11 ++
 drivers/pci/controller/plda/pcie-starfive.c   |  25 +--
 13 files changed, 289 insertions(+), 18 deletions(-)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite-emmc.dts
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dts
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi


base-commit: 422f3140bbcb657e1b86c484296972ab76f6d1ff
-- 
2.43.2


