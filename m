Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01502690C79
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 16:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjBIPLU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 10:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjBIPLR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 10:11:17 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2065.outbound.protection.outlook.com [40.107.6.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0C835A7;
        Thu,  9 Feb 2023 07:11:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPvhVFddvbgbvMw7eR0WckRFJzsz+LN6o0giXwlCAEBk7jbNUyzvfeLh5Tsmte87+efkteosJjDCgwS84kTYCXx/uiM5XB2a4LugZSdPHQ2iAIHBq4HQIL6Qw85tpk8d7jmURWNN368C0Xg0U37jCZz8mnwKrRr8K4tdLuf/+m8slRqMujeiDhebMfCrs68bAJ67a5U7m6BSR7U5ZHuDI2Vd2e4zBQJ/WQYTSQs5h6mP8aqR8f+XSm4GSZlkgNh7/ruBSV+rtslqisTf29TtaFwLCqGJDIngsz8OLYmh2xUHnQTyb3PZWT/eiyFpitcj7LnVDuEVZDkI/cr6tSLrrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eCKELkzm0RadPllJjq5XECDhc6ulA547lFXboPemWk=;
 b=irrvK+FcGy6F1VPKksxbTdfE9nWTCGJgzu5VDJ0MjNsRBlQ41dNXaGmm6HtoRFnqnaTD8EDcG7u3jLs1GXjdgEjZBIvDxFeNxOhEYDS0aoP/0dln3DBb+W0WD7QB9kkji3g2Z7Op3Yc5XXCY5r5xtxJlh56VMzjYH81/FdUCB6jb4irTXrmhOvKB5MM/k1M5kw0oVGLMbZoE88piZv46UnUQf3imoI8/PNahauPMZ467bG2gMhVE+UmpTOyNuW/+wHinubSBBjFtzDAuuVe+V8mih2pD6XvQtYxhK6ypo/ItgWEEK8t6uyuaEGgaslSDmNhiWEvQJVpJJ7FR0TTriQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eCKELkzm0RadPllJjq5XECDhc6ulA547lFXboPemWk=;
 b=Hej9tGoMjh4IXBfeYV7uzZ7grTLnaCObcOGdocQIy1NmbQYIovNZeNLTyI9yNgc1X4hAC6yZ8JijfHH461ke6EC819+tuu0RvB8qhyyBSqkDSq08ktp6cexG8ptgYvmRAFyHAKDivgeeIzzSjg645CeZ9svqXXyqX8VYJNBXM9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DU2PR04MB8693.eurprd04.prod.outlook.com (2603:10a6:10:2dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.18; Thu, 9 Feb
 2023 15:11:13 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd%6]) with mapi id 15.20.6086.018; Thu, 9 Feb 2023
 15:11:13 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     helgaas@kernel.org
Cc:     alok.a.tiwari@oracle.com, bhelgaas@google.com, frank.li@nxp.com,
        imx@lists.linux.dev, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lpieralisi@kernel.org, minghuan.lian@nxp.com, mingkai.hu@nxp.com,
        robh@kernel.org, roy.zang@nxp.com
Subject: [PATCH v3 1/1] PCI: layerscape: Add EP mode support for ls1028a
Date:   Thu,  9 Feb 2023 10:10:50 -0500
Message-Id: <20230209151050.233973-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::7) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DU2PR04MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: a4db015e-a9bf-4255-f8f6-08db0aafe1ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EKcszQ/wAKmVLacaMH4O8QYjgJbIAc0xskRfgHrrv2rJNWKRWsA7W3cWjBzwbS/WO48R+5uj9+VL0mU5GjiWGfjQZOwOvfFScpQv8b6+0ZncqWw3q6kNMetjtWxm3j31hmBAkw9ivrMXITHidngNKLekK3IgLQHz5SBbqNG8mcPJ6b/fQu/Symh6OyMWFqTV5SRoAhiKUsNQ11osl/5VLvJkj9+6Ay/g1gKUO/aVXWSWa78hjojOEC3eJRNEVtzdI8uxe+fvehLOyaEvDfQoGGL3rbWhHt+69XZE7uJpt+SJck7WKlw+kb9AUjGyILaESX8Sx0LdYLZTTA4pJhTZNQz+xDcaPtOlyLAU8R52+4gGpKZdq7Ooq8SoPyciv6EX5H20HKUNSiuOJVYMqLeiHsKuhOQtjJPmMDSeZtvcwQjxkSa/pTsfNpqf874WvI53Bu/3iToosNamVpuufshqX2fZSqGZmTdNhDHnPVb52q1HsTXBmv2ZITcdKzEcVzPtiWuBsCFxshg9iRxFhRlNE235GcuR471eRVfulSgQ0UYOQr4ZoRVANAZcJAiJ+LGZ6axl40SQcoul2eOuyxq8LDU/P4RfCVJxBkN8DjxfWSjb+WzAHL39D+hFfw9NrfkKbuBa54DNzi39X6lVt6Gz7loaqI7EAFmwvbqEyRBLprm5OfyPcUpWpPrALMkLBoUOssNjOvJLWXRoATSPS8x/h0PAM/1Mhs6UYrwfWPrHwS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199018)(2906002)(7416002)(86362001)(6512007)(2616005)(8936002)(26005)(5660300002)(6486002)(36756003)(52116002)(966005)(6506007)(478600001)(1076003)(6666004)(186003)(83380400001)(38350700002)(38100700002)(41300700001)(8676002)(66946007)(4326008)(6916009)(316002)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?62veT9hz2euXOACDGL0hgG1WQ4e6rxIxPU1UDipxt9qZCb97pq+2U3VFY+/q?=
 =?us-ascii?Q?UakLOpQ77+9jjZItJ1GOqk7XspxahQLpI0I+SNUYSElTG1Z9yjT3jrY2s1NK?=
 =?us-ascii?Q?XkXF01UCVBm1TSEyWAwgW9DfXcLoxndq1E4iU/E7+58eCxKwoKMZI+/+jwEM?=
 =?us-ascii?Q?CWh1lvj4Ul9EWNQ+YbVeD6xd5F4gYMZRL3HF5IauZ1mMHbLhEpV5GUSiS0lv?=
 =?us-ascii?Q?OS2HrpC0CbzQUIf8P8CG/YIMeR6XnQuP5xb6Bk02sO+qI+hjfBzkXdvhOfd6?=
 =?us-ascii?Q?giOEHfY2NmT5JTkdok8X4rvYc5SEcG6o9TBophTzPiZXtUIjY8vgFLQlUQrW?=
 =?us-ascii?Q?ORIfabcnLBpvdM+2x9sEmx6nT2fULk1fT63LFJaf749PyPzl02vhPRqH3x3w?=
 =?us-ascii?Q?WU6nn7EzI3CQVXKVRCMXDUwp6iUJ5/h7RBLsvzybO87LIA6/gN3VanBVuC/E?=
 =?us-ascii?Q?Z2FKMK1C1aSVXhsrlQWUGBko7Zizm2kHPsmbbiCTuGeBkeM3q6QsG/nIFQax?=
 =?us-ascii?Q?73CUCJtysWExTzc2Rkos1+zfP0cAGiONld3gYo14q+wWJmoBxuKIzN+gyoON?=
 =?us-ascii?Q?eANjVAuY4Yn9nN32QNAEUBhRi2hTTFmeh8CR6JScw/kW6doR6QwN4Q8GCueN?=
 =?us-ascii?Q?m8bSrddKuzsxOV16MFxw0kr+5W75Ko2tDRTV9k9RQomRmbh8/36x2XKsPMry?=
 =?us-ascii?Q?xM6+KIdu6z6TMVofXCuGVftew/o8UHQDPf683XjZyRXXUwNtEtoQ1TGLDvaY?=
 =?us-ascii?Q?CpHySBJVywqACtmj6HRTGFGYYOTHd7U71gGJE+veAHVoNDDTjNpGWwqroBgP?=
 =?us-ascii?Q?s06M63C3SnJ2hTpgnM8YYaZirRC4TLEIXsSXKfb8ffZimNSkejqyDY50VeIy?=
 =?us-ascii?Q?U83CJzbq/gkyc7uN77lrG4yl16Hl3+FMtXm2mhszZCkhXFCQMP5D8xBwZpzK?=
 =?us-ascii?Q?TrztT6B8DopgPDw3VJtPVS2KKGpgqdgJkHjCIoY7yX7tHAtcNACRWXovEW2i?=
 =?us-ascii?Q?RHMAgPZLu886kXhTM9VaWsEOoJUHWtOhNiIp7ClBHvg/mdSuT+0caRgs+x/r?=
 =?us-ascii?Q?AYWJCIAsbz9AqKcrsP0ims9+0l0yhklGSyXAxgKJv4H2EB7sCV5CT9JdsVwv?=
 =?us-ascii?Q?DhT/5QtMJ4NE/NsCUKf0+ni3UQpbYysuiRNHrSuIBbgp/m/5fsNIy5lWaRDn?=
 =?us-ascii?Q?e3zyUAAk+V1fL7xrpxJBkjzE5JCXNpBph2RjK36rSpzp7edbI7RPuWbibqSk?=
 =?us-ascii?Q?sCzJz6Ldaz+BOcVYFutkdev1UKzQYIgRk3Gf6K/THYyxLFfguErkWwhso0cx?=
 =?us-ascii?Q?7+61l3erCsdj4ZcOqkVZGyu5V+lmaomhckpztSawkwwiSP4Ku1vkVJoo1zjV?=
 =?us-ascii?Q?QgKKxbrBk3ZxoIL2VAz0JmORH+lxRZZY66qGyEl4Ihll7PCZ0Tbenhn/0BHa?=
 =?us-ascii?Q?2zyMUvgsRrWBhuKljvFsE+qgx+wgovKOlfQkNR8LOSoF6npzl2Rshyb34XV5?=
 =?us-ascii?Q?vqH4AYARnbOJ1fQZMKLlfDEZjOFzuN7002thDKOUdd+ZfT+nQcW3ih20Ioev?=
 =?us-ascii?Q?mBX7xJiUvlr1ug5oRQjKcvY8NlEw29fYGttdjvey?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4db015e-a9bf-4255-f8f6-08db0aafe1ea
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 15:11:13.3102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xtw6PeQVYv2tY50TsPzh4CNU2xe1aRkSxgjBTOJAdLNT+XC0odkH1cqAIyw6zvOqC0qhxVTkp0EIFn73ayqxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8693
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Xiaowei Bao <xiaowei.bao@nxp.com>

Add PCIe EP mode support for ls1028a.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp>
Acked-by:  Roy Zang <Roy.Zang@nxp.com>
---

Change from v2 to v3
order by .compatible

Change from v2 to v2
Added
Signed-off-by: Frank Li <Frank.Li@nxp>
Acked-by:  Roy Zang <Roy.Zang@nxp.com>


All other patches were already accepte by maintainer in
https://lore.kernel.org/lkml/20211112223457.10599-1-leoyang.li@nxp.com/

But missed this one.

Re-post

 drivers/pci/controller/dwc/pci-layerscape-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index ad99707b3b99..c640db60edc6 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -110,6 +110,7 @@ static const struct ls_pcie_ep_drvdata lx2_ep_drvdata = {
 };
 
 static const struct of_device_id ls_pcie_ep_of_match[] = {
+	{ .compatible = "fsl,ls1028a-pcie-ep", .data = &ls1_ep_drvdata },
 	{ .compatible = "fsl,ls1046a-pcie-ep", .data = &ls1_ep_drvdata },
 	{ .compatible = "fsl,ls1088a-pcie-ep", .data = &ls2_ep_drvdata },
 	{ .compatible = "fsl,ls2088a-pcie-ep", .data = &ls2_ep_drvdata },
-- 
2.34.1

