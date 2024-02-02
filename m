Return-Path: <linux-pci+bounces-3026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BC08472BF
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 16:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4671F24EE1
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 15:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831991468EA;
	Fri,  2 Feb 2024 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QvtML1je"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9FB1468EF;
	Fri,  2 Feb 2024 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886718; cv=fail; b=mYWa1uMVbDjDvUozFRddSKSxpC3aaGkvpCy26zyEWqKTiFZ+QgEp9Os3N7aV/n9hj+jTn6LremGXmKWHI6sn2UKgt1shp9yAV48O0tXM+ZL5ThSMqNBXP9byweoeeUjAKBHFT7F9zBubMqXQa50ZRhHLYTO4lJhLTkPhiqW2xVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886718; c=relaxed/simple;
	bh=hzGYRhAZl9U+Uvuu6aIidx5j0fhBAx2klPXN/eaV8Q8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=el0UI5lFY6zmHSHbjX9jjXfPCJzgjNJUl9Ae+zqHE0JdkY/EXbaI7FB0UIfdtaVIFPvqEaUp3Hh5Th0E2Kak2g3QG2aaJ+igSd1S0mwHKKNf4BSieZCudarw4v59jeOOK49yXAL/AgYjEn0llQHWeZrP+t2ERgG0ujVWcfKjtYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QvtML1je; arc=fail smtp.client-ip=40.107.8.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQc0slGMVDTRdu+UHbt8nwjDSNDbLPmmf4XSuln9vwzFGppVuVDLVp444dyzSGpHZNK5V08nagV7s7HuNWeVXtfClAH9DLH3+c/CvOmbGwUNOAK4a94TvesFMTboHzL+KFeS1wPDuzCz2IL3+bhuV5u0ppcrM4DnCIv+7BdFDdrh8BVdnRsPdQ3sdAuoGu/YhxljBhXpXcMaDoTol8Hv7NvrcLXDh6QdHjQ+JlkFMl2WnxY2pws4ht81f3Ca199uH56Tilt7cWP23+4nbMG5V0tyxGDpOHTmOeBf1trZ0idpKhxap4qpvmj9c9/P8J6ebRPvIZ1Ncup59HSAs+mgQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0z4U3sEC3khiRNkm46MPnkPrIySIybGo6ofqvEZ86Bc=;
 b=Z0Q7iQxK0pmXXYk5rH8vzTyE2ZRSenOGQMrzgXfcyPvgIyaJN4EwjymHussImRZSb3x4w0w22dJolf23voDPOEARjtNW9vd2TUwB/4WFLkeZ1jZQYKeze3DGeXHJ5/Pg8PRxSqlLbnjz8hQ60qxe+rhD4WkNBWJqQVdDdldonnj3egw3PeXGZP8LyYD2o1M0GMmc1H0WyGE+cRPsVkyiuXQ0hHeQJ320ty4Egj3e1mvTCS+RhR5Aj1bVuYvrOi2fWTcCrJDSV2C/pRGd5GT4vCVYnpmjKTXbgmo28SSFNpmjREwliaXKXgxqBJ/CFQOqPRTvOU2OS7TuQr6FX6uQnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0z4U3sEC3khiRNkm46MPnkPrIySIybGo6ofqvEZ86Bc=;
 b=QvtML1jePYcH4t4Ax/vw9lWvPGdAvjmWVlgTNzTNzmjHbCyIAyUmn2BGoRvPSZe/GBO/5QF+SadjLSi0sxnKfXt4cl/vUlwV3BlKBX0WX2q6GhbUCVxkXkLWALekJYvy4cNZ15PgwGk38sxxHACRaJlnD1nWZeWWescbXSYphVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8425.eurprd04.prod.outlook.com (2603:10a6:102:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 15:11:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 15:11:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 02 Feb 2024 10:11:24 -0500
Subject: [PATCH v3 2/6] PCI: dwc: Consolidate args of
 dw_pcie_prog_outbound_atu() into a structure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-pme_msg-v3-2-ff2af57a02ad@nxp.com>
References: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
In-Reply-To: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Serge Semin <fancer.lancer@gmail.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706886696; l=12761;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HU4ER7vz+HwzR2rHdE/BVWAKQXG5UmDhW10DZ8OHeTA=;
 b=Wb6TeTgDxhL+6MsGMhfsKusGwdtb1L9tsrtDoDvlwC0csLj4Fwd+/wtiSG2BqxgvgJj60P7wo
 yVxHMBRNnsvCVG8ElH1b1mhJO8iYI0kJVNjf36n1Z4b/PYsO5Eu2PL9
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: b6438c80-dc10-4938-4591-08dc240146da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qQRtarmiZFZD8UeulPB/v+u/G7hTOtAVW1C5HgrSHaZK7Sp+cnFrGKB0rYZcyXVHyOalPGkRTDDXDfTMluOK9oRGgPW9i1tL+cZkKUPD2u4st33EH0widQU6RMDpsg/hvb339ItQuGmYyj/feOveSz4+QX5itZ+BgxPUaC7i650Z9ybyEHxmYOLXdhe3MpvNEQh0fqNYhxjmzyMy7Laml3Xwd6jDtQcuUy6UykmJvFruZAAAeUUSSLfU6py//wz8VGYxv8tY5Nm7ejQ388jR0KIcvWXr1YojQygCjcpDpNBcrjIhw7TDtRJfT7qRXsXcXMizqFMW2+LjUDCyYtFBKQl3aTNWtvVRJbO1UwVfA3zWpUCYX8pgqDJwzN7yZaEIEwN7E4UjHM63/Yb4yEXJSiSpkat3B5CDwO7c3bdCYvhVG8DC0LViJfYD/8Bq8uNBJ30HnzW8PolJTNyv0b2QtW893KFhWX1VywZmVOf3PI1fAKmNou8e4p8yUZ9WIEwjwQIee7PqpSR4+5ee2RHkdpZq2wbfMbX7JkXT4QNfOEt0LcczW2zB9YJRsGhVZnqmMnlGON7fKOp1UNAFs/tRQ8aa9LuPNtyj48P+BJeH8ejyU73ZVLKCkNzdutiPN8V4wAHbOHAkwJzTySI3kWm/+Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2906002)(478600001)(7416002)(5660300002)(30864003)(83380400001)(921011)(38350700005)(4326008)(36756003)(66946007)(8936002)(8676002)(54906003)(316002)(66476007)(86362001)(6506007)(6486002)(52116002)(6512007)(6666004)(41300700001)(26005)(2616005)(66556008)(38100700002)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnpkZk53OWFiWFdhS0djRG1BV1N3RE9aZlN2aStKcEw0eTAwVjhwdmlZSUJO?=
 =?utf-8?B?RHRaR0xSeXhkVldDZTYzMGRSMXVNNWNQck9UU3pLZk1FL3ZkMkNYblBXQTA5?=
 =?utf-8?B?bFJPUVZEWmxMaDNEOUFMeEdZZ3c5R3FZcWJKampzRTdiT1FqdnYwZFhyNkVZ?=
 =?utf-8?B?K2hmajRqM2UyRld6SnhGOFJvTmhVQjRCT1N3S3RkRFVEQmlTSDZyNTdNdmJ5?=
 =?utf-8?B?QnV3cVI1V3lmRTBaNkdMcmxLQTVRMXlyMnRHQVdlZEJ6bnpwQ2xxaWJTaGlk?=
 =?utf-8?B?N3N6cXhuTDArWW1zRitDMTk1dU9WUTVGQzZpOXpXbmlnMThjR2FqMWlMcDYv?=
 =?utf-8?B?c09GYzF2azUyc0JpR3AwYTkyYndnaFkzTjMzYzlNWWZibmdvbWQvY0FxYkZX?=
 =?utf-8?B?Z01sc0dqMFBWMGRxQS8wcjAvMHhIL1hQekpJVnpFdi9iMVZ3TGx1eW11Tm8w?=
 =?utf-8?B?cmU3MkxNL2F1cVZjTnk2YUdoMG5DL2NGTU1ydmVpTkwxL1JFVURmK1F3ZGFl?=
 =?utf-8?B?dE9hR3FhTFQ3ZXd6OFZPd1I0T1FTZWhMMnh3bStFTHBHYytXRUttZXljT0NN?=
 =?utf-8?B?NUFrVXZtZmxEWVVYeGVuaEJMa2ZFbWIwUDl3RDVYbUlFZ3NiQm9IcmswdHRR?=
 =?utf-8?B?ZVUxMjhseSszUmVGOElmQ0REZGxZSXE4UWI3akNVWnlSS08vMU5lcGVnWERY?=
 =?utf-8?B?SlEwNjA0ZG9mRWpRNzNIK2w2OGszMGRGbUZKSmdXWGpnMmpNRzU0dkVHd0tZ?=
 =?utf-8?B?T2NXYVg3UjFzTGVKcHVpby9JbmR6WWdkTXJaSFVMSy96RmtheEMzRmM0RExY?=
 =?utf-8?B?dXYvSGZvVnJ3djBCUG1GdnlDN3U3R0VHZytvbkRCQUo2b25aaWtxTHQwUHRS?=
 =?utf-8?B?MjIvbWNYbEZFcDhYYUcvL1Fod2tnY0NZTlYyQkowV1MxM05tUGNPbHhUcXVY?=
 =?utf-8?B?SXZ6QXNLUG9BT3I1TCtuMklXUFRXcXZhWXZMbDAydUMvNVUvT3hIZjQwMFpk?=
 =?utf-8?B?NVBBbHlWV2N4bHlqSTkzNTlDZTEwYm5YZ3ZucXZkTkRMKzEzQzhveUJTUFA2?=
 =?utf-8?B?OWMvdmVKYWgxT3EvM3grN29BWkVSQS9RNGI2Z1lYcWwxazUrZ3BuWGVxc1Vi?=
 =?utf-8?B?MHYrTHJmMkRRSVFOWWF1c1Rxc3NRY29hQUZ6L1FiMFZIa21ZdVpjNU5CRHBP?=
 =?utf-8?B?eXJOQ2k2U0FjZGEwV3FmaGtpVGVGcms4amZtSGNBZEtGWFJvc0w3bldoMVhK?=
 =?utf-8?B?SG5PZ0hXd3kwYnlpcm1DcmhacXo3K0NXVmhCUmNKS3pwUVIvTkFLTEtRMHB4?=
 =?utf-8?B?aCswcGxscDZERmM3MTh2OWZTcXkrK3dHekx2QVhrL3FJVHk5blFVT3RiZFl1?=
 =?utf-8?B?a3pjaVhvYmJaRk5jOUlBRUlSc2xuOTRpZUhSN0szSmZXSEt5bHRoRWRpb28y?=
 =?utf-8?B?V3MyTDVpK29BNi9HR0ZlUjVIVTRMeDRhTEx0QzcxRmVmaTBTWENqQ3dZUndi?=
 =?utf-8?B?cm5STFA2MWJKRUg3aTZRZEM5VXZ5L2w3U0RPUGIxc0ZxR0FwTlYyS0RMbXc5?=
 =?utf-8?B?dHNXVUhObnlYeWZYRXVCTWhhNExoOW5oOFhTdW1rSkkrMXNVcWZaRksyNFFl?=
 =?utf-8?B?YndvdlZ0cktKUWtlQTN1V25QOHpIcjgwMHI3YlFQSkk2N3U3MmxXMVBCU0Jk?=
 =?utf-8?B?T1JqcTQya0dJQ2IyYlN0ZFA4Y2JlNS9xc2owZmZDRGI3ZTVWbnJaRGxJUVpU?=
 =?utf-8?B?Zk16K2s0bzZ2L2VEMUpVTndvSVdxaUFFdDh3N2NnYnd6RGZCRTJBVU5aUW44?=
 =?utf-8?B?ZE9ZNHZvV2I4TlR5VFRaWUhPZUtSMys4c3orYzlDaCtCN3Voa1FQbGxUaUpk?=
 =?utf-8?B?V050bXlNc1JiR3ZsNkZBUG51YW1Cek82NktqVFQ2Nko4MnhkM2Y0MStCb2lE?=
 =?utf-8?B?L0QxM0Q2VEU3a1YzUlAzbzZCeDluajg3anNqN2pvQ0FkRVJoMzU1d2x6UXpl?=
 =?utf-8?B?WFBSeUh6TEduNFNUUThkQUJhbExEelFDK0NMUU4vMVVQcVpSb21ZcVhvYnNM?=
 =?utf-8?B?S0wvMVZueHI5U1lTajVIYmJCUXcvcWFvcUROdExnb2VwSGs5dFZ5aUtudnF3?=
 =?utf-8?Q?U3KoPzjXT06P2waBHbcfYNRBG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6438c80-dc10-4938-4591-08dc240146da
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:11:48.2959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8SNz2wmhP97LVU3gVKyYrEzBLBy/+Fkl0akUjXPI74C9M86zsvcZcY04kYEsiDkGq3U5j9O61PXAtoAX3NMywA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8425

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This is a preparation before adding the Msg-type outbound iATU
mapping. The respective update will require two more arguments added
to __dw_pcie_prog_outbound_atu(). That will make the already
complicated function prototype even more hard to comprehend accepting
_eight_ arguments. In order to prevent that and keep the code
more-or-less readable all the outbound iATU-related arguments are
moved to the new config-structure: struct dw_pcie_ob_atu_cfg pointer
to which shall be passed to dw_pcie_prog_outbound_atu(). The structure
is supposed to be locally defined and populated with the outbound iATU
settings implied by the caller context.

As a result of the denoted change there is no longer need in having
the two distinctive methods for the Host and End-point outbound iATU
setups since the corresponding code can directly call the
dw_pcie_prog_outbound_atu() method with the config-structure
populated. Thus dw_pcie_prog_ep_outbound_atu() is dropped.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c   | 21 +++++----
 drivers/pci/controller/dwc/pcie-designware-host.c | 52 ++++++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.c      | 49 ++++++++-------------
 drivers/pci/controller/dwc/pcie-designware.h      | 15 +++++--
 4 files changed, 77 insertions(+), 60 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 5befed2dc02b7..27956b2a73be7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -159,9 +159,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	return 0;
 }
 
-static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
-				   phys_addr_t phys_addr,
-				   u64 pci_addr, size_t size)
+static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
+				   struct dw_pcie_ob_atu_cfg *atu)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	u32 free_win;
@@ -173,13 +172,13 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
 		return -EINVAL;
 	}
 
-	ret = dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, PCIE_ATU_TYPE_MEM,
-					   phys_addr, pci_addr, size);
+	atu->index = free_win;
+	ret = dw_pcie_prog_outbound_atu(pci, atu);
 	if (ret)
 		return ret;
 
 	set_bit(free_win, ep->ob_window_map);
-	ep->outbound_addr[free_win] = phys_addr;
+	ep->outbound_addr[free_win] = atu->cpu_addr;
 
 	return 0;
 }
@@ -279,8 +278,14 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	int ret;
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-
-	ret = dw_pcie_ep_outbound_atu(ep, func_no, addr, pci_addr, size);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
+
+	atu.func_no = func_no;
+	atu.type = PCIE_ATU_TYPE_MEM;
+	atu.cpu_addr = addr;
+	atu.pci_addr = pci_addr;
+	atu.size = size;
+	ret = dw_pcie_ep_outbound_atu(ep, &atu);
 	if (ret) {
 		dev_err(pci->dev, "Failed to enable address\n");
 		return ret;
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d5fc31f8345f7..267687ab33cbc 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -549,6 +549,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 {
 	struct dw_pcie_rp *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	int type, ret;
 	u32 busdev;
 
@@ -571,8 +572,12 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 	else
 		type = PCIE_ATU_TYPE_CFG1;
 
-	ret = dw_pcie_prog_outbound_atu(pci, 0, type, pp->cfg0_base, busdev,
-					pp->cfg0_size);
+	atu.type = type;
+	atu.cpu_addr = pp->cfg0_base;
+	atu.pci_addr = busdev;
+	atu.size = pp->cfg0_size;
+
+	ret = dw_pcie_prog_outbound_atu(pci, &atu);
 	if (ret)
 		return NULL;
 
@@ -584,6 +589,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 {
 	struct dw_pcie_rp *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	int ret;
 
 	ret = pci_generic_config_read(bus, devfn, where, size, val);
@@ -591,9 +597,12 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 		return ret;
 
 	if (pp->cfg0_io_shared) {
-		ret = dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
-						pp->io_base, pp->io_bus_addr,
-						pp->io_size);
+		atu.type = PCIE_ATU_TYPE_IO;
+		atu.cpu_addr = pp->io_base;
+		atu.pci_addr = pp->io_bus_addr;
+		atu.size = pp->io_size;
+
+		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret)
 			return PCIBIOS_SET_FAILED;
 	}
@@ -606,6 +615,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 {
 	struct dw_pcie_rp *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	int ret;
 
 	ret = pci_generic_config_write(bus, devfn, where, size, val);
@@ -613,9 +623,12 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 		return ret;
 
 	if (pp->cfg0_io_shared) {
-		ret = dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
-						pp->io_base, pp->io_bus_addr,
-						pp->io_size);
+		atu.type = PCIE_ATU_TYPE_IO;
+		atu.cpu_addr = pp->io_base;
+		atu.pci_addr = pp->io_bus_addr;
+		atu.size = pp->io_size;
+
+		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret)
 			return PCIBIOS_SET_FAILED;
 	}
@@ -650,6 +663,7 @@ static struct pci_ops dw_pcie_ops = {
 static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	struct resource_entry *entry;
 	int i, ret;
 
@@ -677,10 +691,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		if (pci->num_ob_windows <= ++i)
 			break;
 
-		ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
-						entry->res->start,
-						entry->res->start - entry->offset,
-						resource_size(entry->res));
+		atu.index = i;
+		atu.type = PCIE_ATU_TYPE_MEM;
+		atu.cpu_addr = entry->res->start;
+		atu.pci_addr = entry->res->start - entry->offset;
+		atu.size = resource_size(entry->res);
+
+		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret) {
 			dev_err(pci->dev, "Failed to set MEM range %pr\n",
 				entry->res);
@@ -690,10 +707,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 	if (pp->io_size) {
 		if (pci->num_ob_windows > ++i) {
-			ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_IO,
-							pp->io_base,
-							pp->io_bus_addr,
-							pp->io_size);
+			atu.index = i;
+			atu.type = PCIE_ATU_TYPE_IO;
+			atu.cpu_addr = pp->io_base;
+			atu.pci_addr = pp->io_bus_addr;
+			atu.size = pp->io_size;
+
+			ret = dw_pcie_prog_outbound_atu(pci, &atu);
 			if (ret) {
 				dev_err(pci->dev, "Failed to set IO range %pr\n",
 					entry->res);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 250cf7f40b858..df2575ec5f44c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -465,56 +465,56 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
 	return val | PCIE_ATU_TD;
 }
 
-static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
-				       int index, int type, u64 cpu_addr,
-				       u64 pci_addr, u64 size)
+int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
+			      const struct dw_pcie_ob_atu_cfg *atu)
 {
+	u64 cpu_addr = atu->cpu_addr;
 	u32 retries, val;
 	u64 limit_addr;
 
 	if (pci->ops && pci->ops->cpu_addr_fixup)
 		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
 
-	limit_addr = cpu_addr + size - 1;
+	limit_addr = cpu_addr + atu->size - 1;
 
 	if ((limit_addr & ~pci->region_limit) != (cpu_addr & ~pci->region_limit) ||
 	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
-	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
+	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
 		return -EINVAL;
 	}
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_BASE,
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
 			      lower_32_bits(cpu_addr));
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_BASE,
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_BASE,
 			      upper_32_bits(cpu_addr));
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LIMIT,
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LIMIT,
 			      lower_32_bits(limit_addr));
 	if (dw_pcie_ver_is_ge(pci, 460A))
-		dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_LIMIT,
+		dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_LIMIT,
 				      upper_32_bits(limit_addr));
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_TARGET,
-			      lower_32_bits(pci_addr));
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_TARGET,
-			      upper_32_bits(pci_addr));
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_TARGET,
+			      lower_32_bits(atu->pci_addr));
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
+			      upper_32_bits(atu->pci_addr));
 
-	val = type | PCIE_ATU_FUNC_NUM(func_no);
+	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
 	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
 	if (dw_pcie_ver_is(pci, 490A))
 		val = dw_pcie_enable_ecrc(val);
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL1, val);
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
 
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
 	 * and I/O accesses.
 	 */
 	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
-		val = dw_pcie_readl_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2);
+		val = dw_pcie_readl_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2);
 		if (val & PCIE_ATU_ENABLE)
 			return 0;
 
@@ -526,21 +526,6 @@ static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 	return -ETIMEDOUT;
 }
 
-int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
-			      u64 cpu_addr, u64 pci_addr, u64 size)
-{
-	return __dw_pcie_prog_outbound_atu(pci, 0, index, type,
-					   cpu_addr, pci_addr, size);
-}
-
-int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				 int type, u64 cpu_addr, u64 pci_addr,
-				 u64 size)
-{
-	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
-					   cpu_addr, pci_addr, size);
-}
-
 static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 index, u32 reg)
 {
 	return dw_pcie_readl_atu(pci, PCIE_ATU_REGION_DIR_IB, index, reg);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 26dae48374627..d21db82e586d5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -299,6 +299,15 @@ enum dw_pcie_ltssm {
 	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
 };
 
+struct dw_pcie_ob_atu_cfg {
+	int index;
+	int type;
+	u8 func_no;
+	u64 cpu_addr;
+	u64 pci_addr;
+	u64 size;
+};
+
 struct dw_pcie_host_ops {
 	int (*init)(struct dw_pcie_rp *pp);
 	void (*deinit)(struct dw_pcie_rp *pp);
@@ -434,10 +443,8 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 int dw_pcie_link_up(struct dw_pcie *pci);
 void dw_pcie_upconfig_setup(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
-int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
-			      u64 cpu_addr, u64 pci_addr, u64 size);
-int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
+int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
+			      const struct dw_pcie_ob_atu_cfg *atu);
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
 			     u64 cpu_addr, u64 pci_addr, u64 size);
 int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,

-- 
2.34.1


