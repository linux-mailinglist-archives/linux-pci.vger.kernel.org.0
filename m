Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA686EFBAD
	for <lists+linux-pci@lfdr.de>; Wed, 26 Apr 2023 22:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjDZUfE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Apr 2023 16:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDZUfD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Apr 2023 16:35:03 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2048.outbound.protection.outlook.com [40.107.13.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9322121;
        Wed, 26 Apr 2023 13:35:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZR6NzBv5r/gKiTIMB7e3Ul891aPv1cDUrqQD8GYLjQU2jvhirI7sQCI5NhOEkqX+3EOaI5wBleesQKqkJm3cuLGOZjKLyVtCVXohzg5kqYG0LM6+yZ1+Uu+Y9JiS0luL8leUNhy7kKFQDCmJ5+JsEsVSjtH3G828BNvj377sVAZkNGH6oa5/wQEDZEUhsnqxJiqRGgK+YJhbkDKwbni5OAhAg2UupS2wrQD21g0gfAB1baSuPiVye7f/GCJdw280A24c+kei7XSPjt9saXiYrtjzjHZyyRxb+yeptu4cZVm67+NZqaNKwSnkeyJcRRpBUBKOu9fGYRy/VgaoEjX8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiVHaMhmDj61Kp1nQXMKb39/IpM3UW+bl6bbn3rc+8c=;
 b=LFgSEPDeU9oHk6yZ/jCoc/X1mMyKcbQtcgKU5FADpjJkx/1g1NxElmx9GMEDPz5A6jdaJ61MEludY76PrL68VZhBmBDtK8Ti6nmZ5QQWiL5+VHUuri2xafQncJBV413FOK5HVhgsVJuMJqfXVKyxozFAxYIH+/7yNR+BrSJUosWBucJNgFcgcMIFSZTQglC0B+5o13JaKqsfdgmqteeNzQIAIg+qCpKj3McwvV5pGJdPI2KNh7Nk2WCvzNaz6lXPVtYq8G3RuE68H4z6Ia4SMRc2dh7PuR2MYmT9y7vdIZdKcmXoajMmVYTYvdYqmjC2q1NN0DZZlkUDEsG98y3VTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiVHaMhmDj61Kp1nQXMKb39/IpM3UW+bl6bbn3rc+8c=;
 b=i5EQPGC9OZojkaPEP6X7D6H3MK+fG9j+QJPcE3cMTnnLfH0DAro3L4cLVPiDGzSfQGQ7buqDmu9f6zg0my98l4lks2bpiXTUwJx010d6KSGQxj+SMKaIsustQHo5B9W+xiBHjYnIgU9n9kGijyiBgKmG4Kc+OQjD6hwji8Sgqx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM0PR04MB6867.eurprd04.prod.outlook.com (2603:10a6:208:182::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Wed, 26 Apr
 2023 20:34:56 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::f1d6:f05f:b8c6:4353]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::f1d6:f05f:b8c6:4353%7]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 20:34:56 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     tglx@linutronix.de
Cc:     aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com, frank.li@nxp.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@ti.com, krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org,
        manivannan.sadhasivam@linaro.org, maz@kernel.org,
        ntb@lists.linux.dev, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH 0/3] Add RC-to-EP doorbell with platform MSI controller
Date:   Wed, 26 Apr 2023 16:34:33 -0400
Message-Id: <20230426203436.1277307-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::35) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM0PR04MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c934bd1-919e-4bc0-4c0c-08db4695b29b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HNLuxTTKRPUnLoTN3vKFo+YXRMGOwLF9kPBRHzcTsPuIOWM0MxkJeP5tz+8UHr5r/R88Foj8ezwWQIeZm5rkGmOicG0jXyBKJ9eFYuQnXmFunOF+TiZsnkTA3eCWMRtiotJBLScHJTFjXO1J1odZejiPNlB67c1QesVBuXSrmxRf4bweIzjQBYc/zReCkyXJvJBqkSsVuPJwzpOoScBwrbrsUymdUFy/ykeopVQ0zphhetvx8G3sT+ISRCrGl8x3AnG5PzwQF8JW0WjHoM9QW6ksXMyQ0Cg7nXyWVeSHjxEgL1NlCj2P6SMUn5VzQjV25zwgVat3D6wyiwStS2ItD6xGv3xi766WseZ2897m1EysJZnbEJaG+5R+oH11aSq8fzGTXcNwcqyEiJVWUUUaDBq1dOVppHeb86UQYb4FU91VZt0/5rSKUUMC7pJOsVBuqz52K4tVyRMWNTGoR3EjpQcxnzwXsW6ULPqntWBwPndiC6IVq9Dxv+nPR/tMBACeDzqNnaqnuMCHDoheXx8bIsoa8L0BlNWzHlvGxPNxBJwExbdKWqIP9p41u9Z9IRbjwYt3MeUCb4kOVnSmxb5EWRxm+JhWT2Ny511+pH0K9tE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199021)(316002)(6506007)(186003)(1076003)(66946007)(66556008)(66476007)(6512007)(4326008)(26005)(6916009)(966005)(7416002)(36756003)(5660300002)(86362001)(478600001)(8936002)(8676002)(38350700002)(83380400001)(6486002)(38100700002)(6666004)(52116002)(2616005)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2orQkMxSUhaMDZLaDY4ZDJFZ0NsRlhWbm5DZzhKcHJTSEV1bW9ULzBhL3U1?=
 =?utf-8?B?K0paK1dINlpJcDBEN0dwR0x5aUtSeTJNWkRUUTIwZTRGd3JFQjU4cDV1V3ZQ?=
 =?utf-8?B?YlZXYWpSVVV1VUpqa1RpcmlRTEdXQUJIVTdMRXE3UHErcXpwRmNNaG5QbjNB?=
 =?utf-8?B?dU5CU1RYZmxNSmwybU1LVTNwNElocHJIYmd6MFIxUGxsMlNUTWdEcFF5L2V0?=
 =?utf-8?B?eERwTi9XbHFXRlUzTXQrNjUwQU9lMWhXMkFnY3BRNTNUYWY1UGxDcVp4UlB3?=
 =?utf-8?B?S2t1VWgwZ004aXJGNlA0LzhjQnRTa25uYWNwdW8rUFl3c0ZhUlYrSzY3a1gr?=
 =?utf-8?B?ZGdHc0lxcjhlcTNvY3dycWxCck1yT25nYjNsaEM2RXM3MjZsL2w1T3JGSDZG?=
 =?utf-8?B?T0gzTUxrcHRTWWZnUFJpNWpoQThmVWdOTEc0OTZyaElGVURLcFJETU1TL3lj?=
 =?utf-8?B?WmFTdTZHK2Y4OG1WYStlQjFCNnNFNWxVdkszOG93TjFmUzlmd2xhTnhjdXZU?=
 =?utf-8?B?dFYxc2hidk5uL0VtRDdxWnczUjg0eVhiNkNSVnBmVnV5ZHRkMFg4aFBjQTRK?=
 =?utf-8?B?M1ZYcnlqZ0FRUFh5OVdsV24yMW1vbW9XZWtiellCQWNMRWZpdld1eUIvbEt1?=
 =?utf-8?B?U3E2eWQwd1RTM1F2NFV1NkxlOEhoWEg1dkxld3F0U2ZTRVdVclAwMFpZWEJI?=
 =?utf-8?B?TTJURFYxVnpnOVFsVXVETjZULy9GVVlxUzg1U2k0UzBaMDdudndoWDJKdWZI?=
 =?utf-8?B?Y1ZyejdmVTU1bVhVTWFTNzhOcjhmNmI4T0dTRDVHdHR6TVU5K29PZUN2L2Ni?=
 =?utf-8?B?Q2Y3TzJObUw3MHhqY1dCMldZZU5UNDdlK1ZjV2JMMTFRRnFGR1YwYWJjOGlY?=
 =?utf-8?B?WWVJWVF4N1Fac1k3NmlRd3RsaFFZbHNoT2h1cGRoQXJxZiszNUZHckN1QmYz?=
 =?utf-8?B?NE1kMC92SkUzTWRuTUx5RDZmU2ZmRENGaWNrL1N5ZVJOUS9XTWJ4U1B4dnBl?=
 =?utf-8?B?dmJYblVoaFBwQkc5cHVVNlZaSVROSmRpZytIR3hZR2dza0NMWlM5UEk0ak1m?=
 =?utf-8?B?S2J0a2lwcVlOTnRWZ1lSaU5UajdBVzJJcjllM0RWVy9ISUhCRTM2T3B4alRJ?=
 =?utf-8?B?a2tUTEEyOS8vanQ0QVo3L1dWcUJwVGo1N1RmRmtwWVVTTXZoZXFqdlcwb3NE?=
 =?utf-8?B?MFlGQVF2cm5MUW01eG5EZEc0b1p5V0VNMmNLNVREYnNUOGdBZEErY1gwcDlI?=
 =?utf-8?B?RXlPdDBLaVBCN0JjbE1aQXZuTWdZbmlqdWh2TUd3SzVmdTVKQW9aYmlJYlI1?=
 =?utf-8?B?RUdlWjMzMmJxQ2pTbXJXeXh0aU1paUJjTXg4TVJpcVd3cEhKZHRVM3ZsaHhr?=
 =?utf-8?B?VS96VVlEY1BETHRQWUJOb1RwUG9YdDdscllBS3ZhQnpzdUlmSzZHUXFXSUo0?=
 =?utf-8?B?clRKNnZxTHNNUmtOTFBnYk9lNG5xT3k2MFNVNTVEbEVuYkVHVmZpcGVQNlVD?=
 =?utf-8?B?K0xtZ0xJTVdnQXJTRnVMcVpBa2x6S0JFRzFWSTc4dUk0VmpVb0JLcVl6bWJC?=
 =?utf-8?B?QW1aY3lUNHo3VDBySzlPSkFaRklRWldvLzZXcWtYVnQvQkd3QmZpZ3BLK1JH?=
 =?utf-8?B?ZGFaalBYQTFad3IvVHpKWkdIU0g4UTJDVVgxUUpkTnZwVTdCbXozYzU1c21y?=
 =?utf-8?B?dVUvQTdZQ0NyTGEyT2xxS3F5TkIxRVR3NkpoUzJKY0l5Y2tRaXVWemtaKzk4?=
 =?utf-8?B?alhOcHk5OFBkUERZWFpkbHNGcE1RY2Eyd25tSmRzVS9BRGlJOGQrYlFrMmVZ?=
 =?utf-8?B?bm0yUTU2a1lUbGNNcHUyOVhrcnhIcmIxVGV2N3ZpbG5mV1lsblpCR1lrNnhJ?=
 =?utf-8?B?OWQwZVBQRGpnbGlqelJLUTBSVm1XM1BVcDg5bGtaYitIMVZISmZDTEhLZnVJ?=
 =?utf-8?B?WDJYcWM1c1o4czZaTkxJWGJTNEhudXo0c0M2ZVE1ZGdNUUJhSFZPL2ZBU3ZG?=
 =?utf-8?B?R04vYWFKMHN6bmdlS2NCQ2dCeEx2S0xZTEs1TzdGMkN1aEZadFBlZlFsc1pD?=
 =?utf-8?B?MzlVcnNST2dkREtCWUhJczN4TVBJQ1NrUWVtaFRlRk1lbFFhOG5UVW9XTENu?=
 =?utf-8?Q?QcxVjsqCwxOg0VLbD5dz8J+Ca?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c934bd1-919e-4bc0-4c0c-08db4695b29b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 20:34:56.6011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtWzb46rXu0SPBsQjyeW2LPZwFLZbqqe19cpqUdO9mSlqUwMyLXR2dJQeCTHGpu2I2h24aCaCVth4alsDFvglg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6867
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
│            │   │                                   │   │                │
│            │   │ PCI Endpoint                      │   │ PCI Host       │
│            │   │                                   │   │                │
│            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
│            │   │                                   │   │                │
│ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
│ Controller │   │   update doorbell register address│   │                │
│            │   │   for BAR                         │   │                │
│            │   │                                   │   │ 3. Write BAR<n>│
│            │◄──┼───────────────────────────────────┼───┤                │
│            │   │                                   │   │                │
│            ├──►│ 4.Irq Handle                      │   │                │
│            │   │                                   │   │                │
│            │   │                                   │   │                │
└────────────┘   └───────────────────────────────────┘   └────────────────┘

This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/

Original patch only target to vntb driver. But actually it is common
method. 

This patches add new API to pci-epf-core, so any EP driver can use it. 

The key point is comments from Thomas Gleixner, who suggest use new
PCI/IMS. But arm platform change still not be merged yet.

git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v2-arm

So I still use existed method implement RC to EP doorbell.

If Thomas Gleixner want to continue work on devmsi-v2-arm, I can help test
and update this patch.

Frank Li (3):
  PCI: endpoint: Add RC-to-EP doorbell support using platform MSI
    controller
  misc: pci_endpoint_test: Add doorbell test case
  tools: PCI: Add 'B' option for test doorbell

 drivers/misc/pci_endpoint_test.c    |  41 +++++++++++
 drivers/pci/endpoint/pci-epf-core.c | 109 ++++++++++++++++++++++++++++
 include/linux/pci-epf.h             |  16 ++++
 include/uapi/linux/pcitest.h        |   1 +
 tools/pci/pcitest.c                 |  16 +++-
 5 files changed, 182 insertions(+), 1 deletion(-)

-- 
2.34.1

