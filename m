Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1487CCC4B
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 21:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbjJQTcN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 15:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbjJQTcM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 15:32:12 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2043.outbound.protection.outlook.com [40.107.13.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667B1C4;
        Tue, 17 Oct 2023 12:32:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlVcQgPGUMdIQsrYWHpHz15ByUlNYjk+GxMVCB42lUpdS4woyrorX5eYeXoa4OfnRU7sVao7swRxQHs48ddYK7DuOXYLc/JmZqKzV6L10U6+NdrAvenW89MmEJrvAaG2OauqMaq7Naw7elnvJEqf9WkEue6/OmfKtEeqKwW4w33nmYTtCY90M1WDvNQL6k5J1AyRbq1oBypEOAElLohyLtwk9U/ZOp848UgFIyk3cseLLRRc6jwiCFT2rr7st7d/ZEpvWZm90cjZ7SpvJPO41qrvZymLnUaaEPUOZoLW9NSaa7eakl9IEsqAKfMYu1aWogUNOFBmcBD0Du9HTpg/Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cfeszKk8w6TW4nMrPU/DpKSdTRFOt42vitndWutXd0=;
 b=L0r5+k59qoa1esMQLH3qVSLdloe8eI0HbuPwuDbvDIkYSlxg3jfZz3kpGkoTEDCfHuJ+PpZQ/7i1J1NqXZKFk1DJcF3FF0cHyNt8EnLkfMQWH51o1kcVVOTOD9aSWreZHnZvJBEP3sBNhLrefrHOnihEfObjRJcBow7CqmMXH6UwakgzUZ5+w4dcQIZEfZ0TC9tgVvYoVfj9EHZDArgifVDqzhm2PWBCpY3/EFrd8xw8dpKk0yrCfm0HrFGH0CnpJzy5q0l9MBiEadGlDsRCYo5FuGZQ+lCnmYgl4/105WMoeWeObS/OsE/aw3DhlYpqHPrCdApQrJYRIpAoIuyOMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cfeszKk8w6TW4nMrPU/DpKSdTRFOt42vitndWutXd0=;
 b=n/z8KEDE2XdgJ17PBXEZHkXaghw+635HWOJEMg6AQ4K981bWD2+gSe/RTui7HjtiLoTSR6Cya07ec+xQ8gyNvt7s/x5eQ+EBknNytSQGxH7ama9Vw3leVh/SQ9kEhPiZfoRr1hWA72h7YoMGN8SZuzGnlChgi8RDViKmeOusjiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 19:32:08 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 19:32:07 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     Frank.Li@nxp.com, bhelgaas@google.com, imx@lists.linux.dev,
        kw@linux.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, lpieralisi@kernel.org,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com, robh@kernel.org,
        roy.zang@nxp.com
Subject: [PATCH v3 0/4] PCI: layerscape: Add suspend/resume support for ls1043 and ls1021
Date:   Tue, 17 Oct 2023 15:31:41 -0400
Message-Id: <20231017193145.3198380-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0013.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8948:EE_
X-MS-Office365-Filtering-Correlation-Id: e7940adb-31ca-4933-56be-08dbcf47bfc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N4JHb46povOEgZLiEySx7nf/XW/i32eHz7kzPWBKdFCsy5HN6uJfQHDB1vZv1yUkTkPgqw+b0eQZAW+7Gd72ZbBu+UeWxUx92CTyrC4bHfdVLIzM0nJjd5nDx3wflKXbo3mhwz2hnjYHiyAwrY0Oh65hE+0QKohf9VQlE8Bs/eFBM+nbNM8KpZ832NPqChCvLczi0KnRhXQRaypFrz3w1K0RO42Vs/JocjG8z/PYjQCg96It7x4k3bdM27h+sr1BWo+kGZ8Hk1M6e2XY1rAu0Vsc9BM+8PgHK5YrDqgrRNdXk4Z0fVWktXxarNwSWkXsPfzf973056kjc/Tk9ChcwoL/zokQFw9mMc0LlyPOFY1jAUqk0MVhJv3+M3fQ0XC6T054zGA3zpyr981zIm+XHrDHY5w/KoYGSMhKFoCPV0Sx5Jry8Exy3cMQRyzEmBlulQ5Enp6cn2KOd7XQP5pPyzwr4Z0SPjwehGHsw3d8RrpwUeVb/MxC6nPsd2e9DTLJdrza+fOBM+JnJNGzmEiLcmkkxd6wz0ibOjit8FxoNeyuREednpOU1kNgA1PLSABX1auGCEvafWDlg3cWKwoP4NKdCF38XuOhIdI7Iwiyesmv9wyZ6jehs8LYH9jJGGUS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(136003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6506007)(52116002)(6666004)(83380400001)(38350700005)(26005)(6512007)(2616005)(38100700002)(4744005)(15650500001)(2906002)(86362001)(4326008)(6486002)(5660300002)(8676002)(36756003)(8936002)(41300700001)(66556008)(66946007)(316002)(66476007)(6916009)(7416002)(1076003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2BYnMHueQ8SQG1bNPcG/Jiu2j36CdW/6khwiF0skhnU2++UH5+05sp+joF5a?=
 =?us-ascii?Q?J59tDlEEHzlh29s6hpb8o8HOOdnA9Kb0oJkIJkztZz9x0jn5Q0g4RDsbrUJE?=
 =?us-ascii?Q?i1qtDF+CB+S1bGPO/PB23qXlgRltFDIJIlRr+NrVV+yV2OGVHpqX3tunlUhP?=
 =?us-ascii?Q?6n8iwKFuTNQLJe80jtdQZxbj7QxikhhH/pKgeuKltZLgW76HeOHpl8scSbP2?=
 =?us-ascii?Q?VdSwQcpzWMFif3i6K0i6AOBQGlfF14PBTaO7rXdXx48+8Ppzq+2sfuCNthpc?=
 =?us-ascii?Q?my9/i2sT72QRF2YtsPb9b4aAEG6oR36AZwOp4nJ5gZh4ZVgtGeASrP6j3FJ0?=
 =?us-ascii?Q?1JWjHSWwNfASQebox3OF8WyyGLzDPzrfkynNWe/nkiZVq1p/HqI19MEuqXgV?=
 =?us-ascii?Q?aQf8wFyVMA4a1loXPVYFxGZ/W7b/MebWKr9JXiZlasqhh/92YkPjQIJYz31m?=
 =?us-ascii?Q?JPGEmlHYa1yRcWc25DmHBoFwl87F5uaeFtQj0dbu6TXZrDGYG9kmskpPRatP?=
 =?us-ascii?Q?Rh7Qq3vwNiSaPWoLJYiiJ2yynSsOqhc2HAvM+67KdpuvGQLFbqxBTI9Awp1t?=
 =?us-ascii?Q?oiZMmbBpolHP/lHrBUwqaH5J47KKZ3Rh+hPYLw9NvpLRuSgavZLyuHymIVwN?=
 =?us-ascii?Q?SW/SnQFPPHMI6bWXR84mI3s1VhqRMbpHqk7vdrTb2FwweoUwY5j29Tlg0AqC?=
 =?us-ascii?Q?lRsSwz0NcSnNQlM3ddceyRQ+fCERuaUOowR39v+AZulhQoR7Uf2xcqFur6UJ?=
 =?us-ascii?Q?wDUadvucn+OwV+eAUx57tEpL6iffNwwI5eiYzD6Eax0vgCmmETKZvcSa1jnJ?=
 =?us-ascii?Q?/elKuBrDVkg2V8gQrZHC+QibhSxRdudGms5MoW9FNIfcCadMYNQtY7QM9X9B?=
 =?us-ascii?Q?+XSTRFYyB/n3FzHMJl1Ny9OX9v9nzdFZYY3bl8w+akSDLgMdpfc3ycEw3tvH?=
 =?us-ascii?Q?vRai0cxwdt5Pyzoqr5Wod9XN+h/+6pr2dPpNZPOo7HcFbs8CiMnLDe9wdjob?=
 =?us-ascii?Q?oJ89yDwPwEHudSdEU0woUbyyYGvcHt2HlAi30Q4ymYcfQ948M5htMI7A2uwr?=
 =?us-ascii?Q?KFA30L+k9Kk116pWOsLl6RFSGvkxnG9iEaDtSulgb+JBKPshTHiBTccqdnhM?=
 =?us-ascii?Q?KeQkJ0owb198O2U4CSDfBNx3PaDnuJBgAmnXY7pSKLB8M0oyeE6DWUdPE0bq?=
 =?us-ascii?Q?3OFBwaSy0CBWTU7YBLSRcqDmEwHzcXobr8yF9sCy0+TIf6u5HtZU6rqHsL8W?=
 =?us-ascii?Q?BiRLLgCtWpfVK8T6zwPuDv7T26lMCq9fOyUHSyrM0rvxBJxUrTqPjL7fQKbP?=
 =?us-ascii?Q?VnsBH7zNXF2SMvN+xqFCsvQuQmnL1aPThtNdCYuBJHDV6g+mSIGzHNybJSbo?=
 =?us-ascii?Q?tYJggt9IycQy12e72Te/VbMNlcvmnudd0fhKTf++fJ6ABg91DRWiXuIbehOj?=
 =?us-ascii?Q?HJnTNzki7nUHOtSa4M6439nH33MezgXjaf1kcwAnbEMgzVzIe/4yYsxouQk5?=
 =?us-ascii?Q?SqIPMp+DQsI/+Mx0aC4U+YjVn3Z5zfkoM+bGjxdHiTaDoEORXue+7OQ5Ddf2?=
 =?us-ascii?Q?0hEquX/1vG9jT7v8zODD64CoYwdHRsx75rb2szax?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7940adb-31ca-4933-56be-08dbcf47bfc8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:32:07.3527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3fCI/lRTJDuZa6y7GFuMPwuaie0F/3DzYgsNK/gGeSwIFCiJ/4aNxVxdmuPWMPDBG6EucZpRAeMqigluo+3Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8948
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add suspend/resume support for ls1043 and ls1021.
Change log see each patch

Frank Li (4):
  PCI: layerscape: Add function pointer for exit_from_l2()
  PCI: layerscape: Add suspend/resume for ls1021a
  PCI: layerscape: Rename pf_* as pf_lut_*
  PCI: layerscape: Add suspend/resume for ls1043a

 drivers/pci/controller/dwc/pci-layerscape.c | 217 ++++++++++++++++++--
 1 file changed, 196 insertions(+), 21 deletions(-)

-- 
2.34.1

