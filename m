Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2F0770786
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 20:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjHDSIP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 14:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjHDSIJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 14:08:09 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE5849F3;
        Fri,  4 Aug 2023 11:07:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdLoa2o6kP1R6n3Omu2UrT1dp1Hr113GsdeuD3IBoW9Uh0bQtOwVofuUk5GnIyj79IZMVG0w2fUrawUs6sFQfqGWNp4fyiYHHEGUateHKhk9+x7CGrnWIMWXN3z6vrO18zUgFN/AiezG9Aqcsf6NgjYHAwCJv56gfmJif/0ca9whP1H8RW53uGkwRsLZWM6CK+++5s+Dc7ccTY/17LDXsyRvSNHP8xSEmvy0/y6e4Mpefi9THWtUHVhct2uKq0CRYiBaJ40PIFpPjt4srRyMdmkASkx1azje4uOTEm8dXjxF2VPyOYVDIzQmsUpl+f3rTglh+vXII38a7E9eyAsY1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtVqdYZfmsrnwaU5mI/76vuCYFsj2AIx8nykMKAiWCw=;
 b=hd1s7q5KE0QKLLqlsSDDd7FdJHjiMkxCPEWivC7EoWPtiWN0/MiyoF6v3YpK8SRhAfGyFRHKfxBk3br4kuRcRqBe7CE00ZV+6giyUbDX2VPKRPwbKFxzTDY3KyT4yzc1OzNDdRYsSNFicqFz0fli3B/uJj2B62sqG/DkxJAlyora0sPB+F6pYly+ear8P39jzhlcoBzDGe/KncDlaN7CmR7MZBISDZpQDQsfU2Nxdduqe7b7YJN6TiVyyHcL02VRbULsm/4oVD010UHgDQ8wcLkDfltvdYr5ftG5flN65JczF08j5TbN6dqi2TRGKOU7N6szsEElx8O5tRrxNk+N6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtVqdYZfmsrnwaU5mI/76vuCYFsj2AIx8nykMKAiWCw=;
 b=dbjg14hZYEUQ2y2WJFaculcNfeCQRx887nRYvrtQBuEM2d7C5fAJDcYDx5UXvlIcU3/kfqQ/iYonRX+uf/rMVYUxAiLUWgtwu3ydf7LhvOQnUqjOS7c4sF5SOYZ96Faj//gtiVm1f2inbXwVkm97TT2HSAr3tUMV8JEdCosaxuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU0PR04MB9273.eurprd04.prod.outlook.com (2603:10a6:10:354::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 18:06:59 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6631.049; Fri, 4 Aug 2023
 18:06:59 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     helgaas@kernel.org
Cc:     Frank.li@nxp.com, bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, imx@lists.linux.dev, kw@linux.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        lpieralisi@kernel.org, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: [PATCH v9 0/3] dwc general suspend/resume functionality
Date:   Fri,  4 Aug 2023 14:06:34 -0400
Message-Id: <20230804180637.462573-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:74::28) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU0PR04MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: b61ce3f4-ea47-4497-5b47-08db95159874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cxAbUpJuS2rkVMSM9vJonxOyIx+ZXERw1Ci4HlHn7VlmKgDwfAR541FPUmBKhUQLPZiu8zzcjEEQP8L8yWQHQg6HXPmc8mSf1IqTKZ288OMdMtSX7Z1yELG8T/yHVKAfpO0ooD0Q5TtCi+uzX5YyE++K7KNRuq7OCLFZeDpiSnRSBP5FQ1MCcbvgQ+n1Q818rDKPWCBwLis6mWBMCuT/VZoRrqmxvLIlnSNi3RjfdxqoG0y7G1agz+sVLnE490jAEkE/6jef1oXS32ZB+3icgKgaAflRvrkKdCRIgYRJt2kaCM2lg9bRdDLDa37E0yTH1svr+9LbCJ0Lpj6ak6/rQA67s0+ZreSAAqcQXAika3fl79fHqJEnPdyUAOqfZUuLzbBRRROOJVQt5Z82MNWhMZFPw1RHlHTqeUkZLEq7WupYpkRsOKgHwxW4eFAfG2zl86uUJue/e35YnszZ4H35eYvtFQ7hNGbpSSukDAfmVE/sdZGQmEKwtG4FlsKDDflpijOy0AWveD/5SYcbZvWw9eoL0AMA/FOvl9xpOsumpnOyZFrZbOn+m3wajhu3291UcCycyhtBqykhSpmiHqVCgpePuPem4ClXjGal1f+5u6KGiAh/Pg8wKRDm1MN2AEZP4pZHGWOjtWTwr/5gttQPDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(1800799003)(186006)(83380400001)(1076003)(2616005)(26005)(6506007)(8676002)(316002)(2906002)(66556008)(5660300002)(66946007)(66476007)(4326008)(6916009)(7416002)(41300700001)(8936002)(6486002)(15650500001)(6512007)(6666004)(966005)(52116002)(478600001)(38100700002)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lz3rS8CJbAg+9Piu/a7tQrHtHh4UHPkecOBwGc3m1+Q2LKFsAqeOxjy5Z6P3?=
 =?us-ascii?Q?yt+f0HCZqB7n9hE5fK1cqiyIr5jHqJ0eS4NQ3zbAEpUX1I1/Qx5WsvB94UaK?=
 =?us-ascii?Q?bk77agiUWBQw3Eymkeuqm1Q8NqDeCpVetK71ETAzDid37sc/C4/KG4qW0Kih?=
 =?us-ascii?Q?9HMxVGl60he37gUkSBlZE4pP4m7G7ZRyFm/npaXS7oTqdl4ybquhhjg48+3p?=
 =?us-ascii?Q?FGp3DzpRKlkrhmer018Kdlv64lxt2GvM/Bm0jMfl/dxNmmUN9yqL3dXdIw4B?=
 =?us-ascii?Q?XJSOq7MNPKGRiaXANkzKIvWIwuzCqrjZMz1loNLutGQYdADKbpItbMJaQze1?=
 =?us-ascii?Q?6iF4KGDTLE4aKhh1V50FZ1kTNvSE85O0tJcrppGeLs2sR7cj3RgqUUtm61BV?=
 =?us-ascii?Q?lVTmZ6sb3T6sfCa9sEFBiYxGtSvIYTC0qR3akKRg6WCQ7xR9k9veyU85VVGL?=
 =?us-ascii?Q?oZiThX5C/y5By1PeQRU3FGh0s9XcMkDe9fCYGOO/jhALDA5WDN5bdUieoJFD?=
 =?us-ascii?Q?YTWJ7JjgkCLlwbRp9muEt1BniwgkECncph0ammtL5gvJSZ8kFlVhIX6d8QuI?=
 =?us-ascii?Q?i0cXx/TrXAcuLVE96O6Pkh9VLGlcE0PcYTBaMvOXO6X02vsc+h8khJTFhPwF?=
 =?us-ascii?Q?FSwx6OX2MIZ5m3wTiLQsCqFpGO+HV0S63n2qP6RvWB5nI0jt4PIYlAoZDzIU?=
 =?us-ascii?Q?CuTVS0bCZdOSWhCXogPb9f4Osxc6pV7e8JA4Oo3hqTFPlVZQKBfHbcp9w8RM?=
 =?us-ascii?Q?tj3/0fHBo3ijO5G6hFbM7OfEP4wGz4z8e3XM9Vz4TpahhzvhOrntI2x/aTYV?=
 =?us-ascii?Q?aBmSckQpr1XDDIN3BcPj9m7lfN0MjS1krR8so0mCA6FPPOcj4DAMOCWlHJOe?=
 =?us-ascii?Q?13U/ICIWx/UQZqvW6p5TGEMpQ0yzRIF021d37zKo+kdNlFcvI8Ng4TygTE+R?=
 =?us-ascii?Q?BKfjZiFER/kzXIer0EWCO0ENrjtBcoirtwMesPKsZ5K79smKoY4B71+N5mT9?=
 =?us-ascii?Q?Bml+wOWh82LJaB/mnLTvHGef1rKCyEFhQfp6GsCtI4/niycbJMaywXJO5pyD?=
 =?us-ascii?Q?nc8cpPGidqPusOWpdDHJfMTJgPiE7tkT1D/eFbNKBvyfiUlqvyDHJr5XOn0J?=
 =?us-ascii?Q?Osy5BCWcN1P50Q2fzPLAGPMKCR+s6HQWg/ExzsZMAHZcwll7ftpJ4tc5I4SU?=
 =?us-ascii?Q?LDmPntoN79X0U2LNBgTTo1Dqsnrrz1CoZI/Op84nYdyeMHyWLF6zGojj6FnS?=
 =?us-ascii?Q?Zpwro3hB3rj95FS0bIUrxEC5azlksCyPGycycqYPvY9wpQ9h4nlOeISRNKEx?=
 =?us-ascii?Q?61Mz4SZL6lV0653B/75op+A0ob00gq1T+jTjKttHcNOpiEoMxAui7wphE55j?=
 =?us-ascii?Q?H+bmG+KTk9eRfyqH2L0fTPkH0j7sSR8ZiC+Vu52DwpLwFkxbuAt5ahOpa6oL?=
 =?us-ascii?Q?Y7SSj8uf59UBzttrzUF3pC0tJcZV/4CszvKhhXJmGVQYzA43+WA5auy4gzMb?=
 =?us-ascii?Q?HZjCFer7acdIfY1AjISqx14gRrAFUeSO+MIA2MuH57g3wqwN6YpNq6XEEdiF?=
 =?us-ascii?Q?HDQ6zouHb4OKMyqkudc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61ce3f4-ea47-4497-5b47-08db95159874
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 18:06:58.9855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9qobV2kvf9prqG5dgEbFDmABLbt04y9Fr9xTukuchMXe21a3kx2Mtywwgs0jfGacwGEVTyJzvFIaNMU1AKe7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9273
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change log
 - Change from v8 to v9
   Reported-by: kernel test robot <lkp@intel.com>
   Closes: https://lore.kernel.org/oe-kbuild-all/202308042251.yGAFqeDw-lkp@intel.com/

 - Change from v7 to v8
   Add new patch to add common PCIE_PME_TO_L2_TIMEOUT_US define.
   timeout value using PCIE_PME_TO_L2_TIMEOUT_US.

 - Chnage from v6 to v7
   Remove local varible struct dw_pcie *pci = pcie->pci
   Change according to Manivannan's feedback
     remove unused lut_off and lut_base
     fixed  100 to 1000(for 1ms)
     using dev_err for timeout
     refine commit message
     fix sleep value 100 (should be 1000 for 1ms).
     use dev_err when timeout

 - Change from v5 to v6
   change to NOIRQ_SYSTEM_SLEEP_PM_OPS to remove #ifdef PM_CONFIG
   refine commit message
   change according to Manivannan's comments.
     remove reduncate step dw_pcie_set_dstate()
     return 0 when .pme_turn_off is zero
     call host_deinit() in suspend
     check .host_deinit and .host_init point before call.

 - Change from v4 to v5
   Closes: https://lore.kernel.org/oe-kbuild-all/202307211904.zExw4Q8H-lkp@intel.com/

 - Change from v3 to v4
   change according to Manivannan's comments.

 - change at v2 to v3
   Basic rewrite whole patch according rob herry suggestion.
   put common function into dwc, so more soc can share the same logic.


Frank Li (2):
  PCI: Add macro PCIE_PME_TO_L2_TIMEOUT_US
  PCI: dwc: Implement general suspend/resume functionality for L2/L3
    transitions

Hou Zhiqiang (1):
  PCI: layerscape: Add power management support for ls1028a

 drivers/pci/controller/dwc/pci-layerscape.c   | 130 ++++++++++++++++--
 .../pci/controller/dwc/pcie-designware-host.c |  76 ++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  28 ++++
 drivers/pci/pci.h                             |   6 +
 4 files changed, 231 insertions(+), 9 deletions(-)

-- 
2.34.1

