Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6C6614FCA
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 17:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiKAQ5e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 12:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiKAQ5d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 12:57:33 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70041.outbound.protection.outlook.com [40.107.7.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B9F1D0E9;
        Tue,  1 Nov 2022 09:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bu4w7NopQqBc4GLHWxJNDmgJWaYQSVzdSOl0oJdW2t6EvXnbFjJJPuUm0KqB76MAgjc0911ddTFxbJXr1Kn0bNdUDbYHyhfwJl53bjwT/lTQSFTsCucweHVA5C1astAS9qYU0AJMKrAmaS08w0vpTLZLdbte8NpmwvQOsmxOHT+yy0nFOkKOMMWl3gUVWnreoM4/U2wAw7iKKWdRQDcjcHDCd7/ygv3A2VRMl+0BP+s8yjGR9mqmcrvFerMEDYn8bPOW49W+hwlPFXJCzRolJqerSOKzjOb8N4Wj/1EUJ7WpKxSak8q7VCzwt6LVjqZbeGfUZHoywZ30AYi/gO5uIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeTODQmwChSJt61Q7k9ZgH+AYvs45jSmtcS6fVifIs0=;
 b=EiXByY2Ic5LroE7WW3ni90nGuAk9AVxo9iqAjaEcSX3DlfRWzmX0AfjwVrN6gBdo7/Iodgllkhvuybq/eb2MXpJ1RQ+5rmBRVbsdIYneGv36D/uYbgqMYnJs8UkRU5i6ENew5ty44hMF55BTdqLSEEXWpIXqNnVQ3PBkbH/nz87ddOJgmmjGSxsKS5aTt2FPDzxZpktwnkObhGdo80ZOkmQVbkJyh/4cTrPqHgm60kIPZq1jrHa0/256Ugqv3nHaraxy6fc3v6ATqNzupeoD2N/4j0Sq09TMgLr20g5qA4o7sp5Ey8IxXBnTV5mcbtVWTf03rzefZL7jR8A65SoA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeTODQmwChSJt61Q7k9ZgH+AYvs45jSmtcS6fVifIs0=;
 b=qOV3WA5JS8hs2csHGpnXUHlgvNNGYrmFjtNhzxr9nOhrc1+iUmJWVOjn4pxoCYzNnoXoV9gxoFK8lmZx17ReO/gUrkiz4RZAybRnhWYyISHnaJYNmVYAnGF7XmagL8GDbaVByhEFyVIwBhAHrIzwalw0Wywzx+RrwcfyL4AP80k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DU2PR04MB8631.eurprd04.prod.outlook.com (2603:10a6:10:2de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 16:57:29 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%11]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 16:57:29 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     mani@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, helgaas@kernel.org, imx@lists.linux.dev,
        jdmason@kudzu.us, kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v15 0/7]  pci-epf-vntb clean up
Date:   Tue,  1 Nov 2022 12:57:02 -0400
Message-Id: <20221101165709.983416-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::20) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DU2PR04MB8631:EE_
X-MS-Office365-Filtering-Correlation-Id: adf7a13f-5e48-4cb1-bce0-08dabc2a2934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +MCBkA3wMPNl5anPOaBWm3vEaauS5ybDHn8/KHwcUx2eIrRJ4TSQhmZqQN8w5u66M0XIV5x8E7KU7W0Fi1oqcoojZesOiPxFmT2yQhwu89CW/IgUvbnV06FQOrrlNvjX5nWERKnHggmAAUeohqPYKt3DAW0UE/VH0IvvHkP0Bfhv5PTLdItKMWcOyuBG1/ITCqvzcvq3HE5Mw9+gIn6ekfPl1egqlX+y8pj7KUZaDgp5CGsLPZV0T2jy9+o3S61QLfd/Ml3sWNhh7xu7dKWvrIiTDRw8VPb82YifOAq5Vx+rHQUBDMaiXPMhS5nGBoLealSyoUCWwVCu731g4DEYvwIwj/S2gqRyMTRjNPdAt3/MeLf4t3fdmJW1ibHT2LwFEWR5utrb4aycN1ZG2eLKOM2VvXxyF/GXB2I1Wqgh8CVKO+nU301e76T4rVNdl+XCJJBbGZfYFVGvZgKFJJ5/KJY0mLDuouOdJ2ed7y0Sa0L3bD65ykQJ+aFKvxkR+AxsMsMkIn+vTZSDRWQH2wijbIg8mHsH8W1zIUQ34JWQ7wsEwovtQfRSKzs06i/TkPLSZGpqYQU1sbSoneairLTLwHZvnvFaM3hRgu2eRgsDoA+ykU1ZnsH2FI/oQ3GmeBi1g402leyu6XpokTFYySnYnrhPG57DQ0OM9RDP7kqgNO2qqPYcfwQnbNI6FwthX7AQ1c2YDuoZovu6MWBsHUodVNFkgbBwpBiREmzcnKS/x8FA+3RmE+nWhDj6KgXPkm4AwXgbgO8rvcsCKP6MfNfUkAzbvfk+VU+LBc1qFAyL8rKD3XN7h9AdcyxzRLrC8qjZ5H0vC1A76B8bs5jkMtglXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199015)(83380400001)(36756003)(86362001)(38350700002)(38100700002)(6916009)(316002)(6666004)(2616005)(1076003)(7416002)(5660300002)(186003)(6486002)(2906002)(966005)(6512007)(26005)(41300700001)(6506007)(8676002)(4326008)(66476007)(66556008)(66946007)(52116002)(8936002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a2AcB4i1c+ygHDMWFTxJx+IVT5f8bU6MuMZz2Q5TL4FPCfrdH36+A/jJPPn5?=
 =?us-ascii?Q?5m2rlj/WJZtpr/MfwYnjladiXOtoJcEyj3sth81qAAq2w/O0Ss3SNPp++Qo1?=
 =?us-ascii?Q?m84p0pJCfa9G0OSLcFMIL25uvzaQHIIFW5O7w8KqKmvQKsXIyV8kvAszwIV4?=
 =?us-ascii?Q?K3Ll5ChR52Z04lJCqCLQUCcN5L1oSlBXz166uC3jJx4rmZD+8kH+7LfsT4lf?=
 =?us-ascii?Q?+p5UKaGHKt8w9VzUwo137XqSWVL/lcywCwXNBPwhq8sTtjfd1mpfNwr7yC46?=
 =?us-ascii?Q?zvZShrbuFzVZdCDuY32/XsJ+4xmUV8qsqGeBdrSl6gpDm3YX+Hot3binzZ8B?=
 =?us-ascii?Q?onJuPp97pJsnASvgDWM4wg1irysbVN9tWReBIulYurbZhqF5At32BnirMO+m?=
 =?us-ascii?Q?wlS4eLs+OHQIsbdiJ7RHGPGJAPW/N7QvhBoCQ+T7V1Li1xjv4VgYTanPcnRA?=
 =?us-ascii?Q?Iztu4lJgktWFFkCFTkyeA4zzZKGXh8c8y5lyGlLe5gExak5/kDNkaMJvjddm?=
 =?us-ascii?Q?1uxMoG0k0qXTQU+wT5Bge0jOgOLQfJlqeVkvZLUEV64skyiTDYopdU7s2y3I?=
 =?us-ascii?Q?zh8vWyC/AZodbOkkjauMarxsK31nBvhRo8C+HbkxCttq0mYlfI6bznQNlBUj?=
 =?us-ascii?Q?gV5z9lhOPyLlu5KVjMMQuyfaavT0lujw6ZOjBpEing9Tpi9b6T3QELrhGWZb?=
 =?us-ascii?Q?nI1Y9UwBiIo+hyjL9fbA1+hlwXlDx3qLlq9FKvENK2AY0PKVyx2opisrceEZ?=
 =?us-ascii?Q?+F1AatiQASr/nipAm/XJBbepVBKlppZUT23SYfYLd9RanDyZfme24a3/VhRx?=
 =?us-ascii?Q?ch5kcR9V/SFPNse4rNBQFokjykdLhvhPdrktkculwLDqepQguwivb1wLHdgA?=
 =?us-ascii?Q?GRiCioqXmcr5A4/cBSZU1FVdFoFSQGGim16jtelWe1KvWLd/NEIvmVNrju9H?=
 =?us-ascii?Q?/FLKyeykjvOS6Bw7AJ9tH3P7zwhiVtW00G06yQebw2MBMhKCuI4SGBraQHtW?=
 =?us-ascii?Q?ojSsIUQe0zfWOSr4TfeeZA/ONcupj+8sZ7wYpH8tjLUot2DAhBWoRyldDV7K?=
 =?us-ascii?Q?El03dwSNOCxWo/ggZ2/P+fel+DuUo8i4qabvy1cEOcvuFQlsvsJVn6p+8SkW?=
 =?us-ascii?Q?oBfig1daFgiSowJeuDG1iMS82uKLYZ3QIVTIhEAZ28C3SQRpOwwbKOIVaLhm?=
 =?us-ascii?Q?PfkbTpAyOdOq+47o2m8lKQPEL5KxHbxoT/D1P0bZDEi+vkRPYUgAClGXbue9?=
 =?us-ascii?Q?WBxMCSEKdq79og26BGTiOTT/MiuSVMSnn0iCcZM9P4AaJlMPmE+8jh7sP3gV?=
 =?us-ascii?Q?Ufrfu04qpeP2Tv8xQBk0bGwv9SPavEPRAMFWIUYRwT9KV2DC8XtU1OWfVb9q?=
 =?us-ascii?Q?3VhnSXcILQBjkcCupoR+854r85ivY2p9kLbrNQ2c+7HOJ1FRSXu9A8uKY4gI?=
 =?us-ascii?Q?4g7trL2eGKr3nwdhAlZKH/6WQgPxSnT8sLwbjSF7TL0H6a2bZMwygmQZWD+r?=
 =?us-ascii?Q?1pSWJEH96wHcvmPaVxbcHUAOYRx+PNLq77FD+fSop3ZxbnNP8XY2seDP0bui?=
 =?us-ascii?Q?9rl8WDWn7ACpS/h2j7gGljjAMrbomOLcFG0ac8tW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf7a13f-5e48-4cb1-bce0-08dabc2a2934
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 16:57:29.5910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cztrjIerqSnI3URdxdy9aZtJrXVo0jA2foqrpxHZqi+bzn5zo+NPtNkPVodDriI9iPFXQ3GK98bbJAYterUhHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8631
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

continue patch series https://www.spinics.net/lists/linux-pci/msg130372.html
https://www.spinics.net/lists/linux-pci/msg130924.html

Lorenzo suggest create new series. Version number continue from old one

Change from v14-v15
  Fixed according to Manivannan Sadhasivam's comments, except endian
problem. Endian problem is out of this patch series scope.
  kernel test robot report sparse build warning problem already fixed
at patch 6 and 7.

Change from v13-v14
  split spare warning fix to two patch
  remove local variable reorder

Frank Li (7):
  PCI: endpoint: pci-epf-vntb: Clean up kernel_doc warning
  PCI: endpoint: pci-epf-vntb: Fix indentation of the struct
    epf_ntb_ctrl
  PCI: endpoint: pci-epf-vntb: fix call pci_epc_mem_free_addr at err
    path
  PCI: endpoint: pci-epf-vntb: remove unused field epf_db_phy
  PCI: endpoint: pci-epf-vntb: replace hardcode 4 with sizeof(u32)
  PCI: endpoint: pci-epf-vntb: fix sparse build warning at epf_db
  PCI: endpoint: pci-epf-vntb: fix sparse build warning at ntb->reg

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 149 ++++++++++--------
 1 file changed, 85 insertions(+), 64 deletions(-)

-- 
2.34.1

