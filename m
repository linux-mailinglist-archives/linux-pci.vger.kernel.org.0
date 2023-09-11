Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E01C79C1E0
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 03:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjILBrw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 21:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjILBqI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 21:46:08 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3342019230E;
        Mon, 11 Sep 2023 17:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9dYN8WWtZ/F9Sbw1TeZn0TTxoTFc+PRp3p/MI9QIcne6RW7NwXUolnVLBWC0M9gxwHTIlC7+IoU5IhZc8muCjOoreVVFzmENRmhAVjFNkVhPSWUDmlZ0u1Z7GhMwlmWIZcmsQMKqFgpo3+86WTFKD7wMy1BNAS+x0GjI1+8V9iKllIKWOtXaYDMwgnOde9xJuH3mjzqyGXnlDJ1U3fGc9rI+AG+N9OCgGkIquXbYkJg8zZdVT3HBlk/h6Ha+8wvwHhqJcqDsdJ5MUDgu4fOWmd7ut92CpBxLe+/I7II/RUHunVLQA1tDCRVk5kkJKtihtXjCizfURisB4dVm7HJTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLgA4KjVjqR3Bv7DX5oD2kznX4A/CBf24jgYyJhVCfg=;
 b=c46pFdO1b7FyGLGTCAB4lgzGAkiF+45msS8U6gGgqANXgylbKehvTjI31iKZc4h0Du4l568Q6nrzuCSUwktgG0EBa7dhrWGB/4pl6aIpNTmXMbE6jOA404DEW3hmmEXEi/w0EuG5Um7349dFzR71h5m+C9GEgd0J9mvq2oO8tw3uLva9vTU+jBUmoaUSW9Yg71w1ZTPDvJIOMVfVJqVNxSYXdyknS2p9v5iOolXOwz8AHq3iDLxsTrm+xDHXmEvUJiO/AY7v4M/Wt+Xf2yPDreAx8wnqPPeofkOB0C/A4QSE0j+6INaPr4SDaM0rJUSMzmnj0adarw8SGJjcIiAG0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLgA4KjVjqR3Bv7DX5oD2kznX4A/CBf24jgYyJhVCfg=;
 b=GM7xOWiQKb/yFWaqK7lnsL6iL3no6kf8Xj2BI0OJ01R6NpeOfMoiWYDwRIb2n9i2/R52i6wqPnUfmDAolJaj60Gh1NvemeRAPn9RVStdkjnTn/gikrHoAChH/J4VJA+cfWNkSWY0dOw/lgBO3WDhWLLxab4TTr9OP5GDfSgvjUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8125.eurprd04.prod.outlook.com (2603:10a6:102:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 22:09:42 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a%3]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 22:09:42 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     Frank.li@nxp.com, aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: [PATCH v2 0/5] Add RC-to-EP doorbell with platform MSI controller
Date:   Mon, 11 Sep 2023 18:09:15 -0400
Message-Id: <20230911220920.1817033-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 25b7f5fc-19df-45db-858f-08dbb313cc9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: khpcHQOldWYaBPhtCGaTRJlHSPq7Lvl3qU5VO3haAfDqpairjKVHavFuUqy/TYFdV6wJBnbg6xorrZ4sVk1nmq5JzGPqUmBP5LRvs0fzD/4+GbSMzr40XgNqJCIHnQWDGgi0zAUctlsYXzynSCN+TDkig60g3ZM6k9Ck3Trtm5vwYCc4J4ynUAn/TNMQ7pmvOZDFIGW+pOLaFtYZ86zTtxH18HPGHrEFkuB3HEzyk7XpEr68V6jr8sL1eTK0cM2Kb9mQhTBnFzBu3R8FfZx4MLj7OutjYv7EeTid8Uk3UihVWJrevQkNS9F2P63ABmTtG7q98re3SwOZDVt+39TCtgymwrWA/eRkMHH16xCn23e7YH3hDil8hGn8JJfuoY9UR33eGcujPHq14zOndNY9A+HzVGi30rrfAE0dYb1NR4QgchwA6IorMUV0ffgNiyzvuKvqLm7z9xN0iVImq8ufmT6HVBc0+lPncTbtDnYYeVI1FV2kNo3T0Vl9eC8fphbqYaJF9wQH0U6EU7O6jvfaunZlQUhRvdn6vXW9QZJCZp6qYD9kAnsFKERYP3XA0BinsvLCZF04mznfKwzMRNhaLLcG0V9lH4opPzfw3nk9E98=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(1800799009)(186009)(451199024)(6512007)(26005)(1076003)(86362001)(2906002)(83380400001)(6486002)(2616005)(52116002)(6506007)(6666004)(7416002)(38350700002)(478600001)(966005)(38100700002)(36756003)(5660300002)(8676002)(8936002)(66476007)(66556008)(4326008)(6916009)(316002)(66946007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0VvMHdBSkRqZ2IzR0JKNWM5OGR6VzNCeGxQSEtCLzVocHJFOXduVVVzdGV5?=
 =?utf-8?B?MlRaeHlUWlhVVnZidHJvZUo2THA1UHBUSmVwQTRXZDBBUThubkpPd3k1Szdv?=
 =?utf-8?B?VzRqS0xtUjNJMVJRaUdDdEZsS0tMeEsyVnFYNllGUW5RSzl3NUVKS21lT1ZX?=
 =?utf-8?B?UExjNmxlUk9RT3Naa1NGY3JmVGtQSlM5OVZvL2FyYmxYZktVK05jdEVwS3hw?=
 =?utf-8?B?UXNwL2Rmd1NieEJmYVFkbWh5UElueDlyQnRUQXJQVGFoelVQM1VGVUlPZlgz?=
 =?utf-8?B?VXVRVlFmYUl3SjJhVkk4WWJjZWR6Q3dCVmNVUFdoVHdRM090dFY0TzBESWMx?=
 =?utf-8?B?bkwyY1VCK015aVVDbEkydHNiOWtzOEs3MkhRTHUzSUFsYjd0VUlkZ0QzVnlB?=
 =?utf-8?B?dDU4dzhqSVgyWEVRdEpGck11MGZEY2hsSjVXTWtmdGR6azc0aUljYXZubFhV?=
 =?utf-8?B?SzhnR2sxdEd6aVlGdStkVkYzUkpFZE8zUmVmaENPQTlISS9QMThOV1A5bnNu?=
 =?utf-8?B?eDFndkdjWHEyR0l4VFh3VXJpQjZVUTZ2NTF1L1Y3UnVpZlVzeG4xWGNSZkdY?=
 =?utf-8?B?WUV2Y216RHZwc2gvM04vWXRuM3Y1emR2N04ybmtwOUpUVElCVmgrc3VjYTRE?=
 =?utf-8?B?M2ZSVXB0RldacjVnbHphQ2czWDZhUTcxZjNhRUpoME1YQW5xSzFjNStKWkZh?=
 =?utf-8?B?VGY2NWo2amM4QXlhMUQ4Ri9mZHFUREZkYmN4UFFmQTFqLzRrK1FFS015cWVC?=
 =?utf-8?B?SklIcTd2RlZYb3hXWVNzQzQrK3VUd09aS3Nra1hVQ1pNUFlGdk52SXRlNjBn?=
 =?utf-8?B?TDR0dkxHYVZjTzBRMkQrQ3NkcFZKSWc3Y09rQlJuNkRoT1d2eUZNTThiMXZC?=
 =?utf-8?B?OUhGazFFckRjNjdOVDJLdGt0K1dvQUcyYll3b3ZuVWgrOHRNNTF6VEZZOG51?=
 =?utf-8?B?VndrMnFXQm5ObUJRRVd3bW9sMHBkRzRhZlJNTlkrdHZVR3oxSytuNFZ0MmJV?=
 =?utf-8?B?UUFPUFpiQW9ZVnVHWTJ1aStaY28zaThNSHUvS1h5ZmpraGpxeUw5bWYzMUFt?=
 =?utf-8?B?ZmRiU0YxbHdTTk5la095QnFFaG5WbDNhOWgvYzdWdklweEFlNnF2QjFuVmhq?=
 =?utf-8?B?VVRYV3RKSVFsZWVnRndUWngxVE9wUGEyS01YTkp1N3Uzei9ocnhNZXk2RHlL?=
 =?utf-8?B?MWxpTndpVFFaRG56WlY3eGx2OURyWmswRGVMS3pab2V1bEwvaXFod2ZkZXJB?=
 =?utf-8?B?NDJvRE1iZW5EQlErZEpEQ1I2R2MydzNybklxeXR6RmsvYzVRU2JNSW53NGdS?=
 =?utf-8?B?czIwV05yRTBPSUQ4bUg4S2xOOUJ3Y2ptTWZIKzVRSVlVbnVrOGt6MFFwTEs4?=
 =?utf-8?B?R2dFNnArRndidDBaMTlUSVlHNWhKem9JQXFQdE5GKy9qdHhNcHpmeGRPQnpO?=
 =?utf-8?B?MStZWXVKVmRoejZBcHpaR011TVJTS0g0NlU4QTFHTkFVVWVMYnd4Y1RGekc0?=
 =?utf-8?B?YUQrR01KWUVIQTRqejZFRGZZUVZFRGZPRnFLVHRxOHNXR2VXdkppaFZPZTkx?=
 =?utf-8?B?TVBNTmN4YW44NUNJeWpueFlORlgrUndoYVdsYWZNSG10cXYvVC9WcjhYV3Fy?=
 =?utf-8?B?TVd2c0pjOTdYQ1A0RXN1bVlaNkFla0ZTeHdLWkdZTExheGVyNzA5UHhPQVFr?=
 =?utf-8?B?eDhqOHVqR0N6YnpXYW4vTXRHc0U2NCtvcTVVdGxENWdxQkZrQzhGMHc3U3Jk?=
 =?utf-8?B?YkQwYnNKdHg4Z0NXVng0NldmTXhlbkNpZmdZOUdtYmtFN1pEbU5vZjZ5OVZZ?=
 =?utf-8?B?U0svZEhhd1l0cDIyYXlhV3lUcHkwNlk0ZE5tN0hqRHdxVFFOZVdRVmN5bVlF?=
 =?utf-8?B?RFlockx6NStPS2pBR3d1T2p3SW9ZUDh1T0JYUFJqWWt2M2Z5ZnFUbnJJQXFu?=
 =?utf-8?B?d2xneThsUSt4UzlLaE1VWm1WQkJ3UWdYaXU1dmJZcGMwNWs5bDFIV1YxMlI3?=
 =?utf-8?B?T1RaSEpwRUdhZ1M0OFllS3ZJelpYdXVwS0lEZHJuVWdURzZVd29QYkhxYURl?=
 =?utf-8?B?YkVUZDdSbG9rSEhkNXgwNFQ0Nm5SRDBINjhPczViZW1HQjB3eGY1L0ZXM0px?=
 =?utf-8?Q?KQHs3B55GgPG9k+rNNCEQB8uL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b7f5fc-19df-45db-858f-08dbb313cc9c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 22:09:42.3823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4GS3wIhu3Rn4PPmVAu/pwrCtSBGzsc1g+8FrXdghyp9RbsWc7cz3R5v4OYABpi2GPjx5pryb3Cc+XiwfIBE1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Change from v1 to v2
- Add missed patch for endpont/pci-epf-test.c
- Move alloc and free to epc driver from epf.
- Provide general help function for EPC driver to alloc platform msi irq.
- Fixed manivannan's comments.

Frank Li (5):
  PCI: endpoint: Add RC-to-EP doorbell support using platform MSI
    controller
  PCI: dwc: add doorbell support by use MSI controller
  PCI: endpoint: pci-epf-test: add doorbell test
  misc: pci_endpoint_test: Add doorbell test case
  tools: PCI: Add 'B' option for test doorbell

 drivers/misc/pci_endpoint_test.c              |  48 +++++
 .../pci/controller/dwc/pcie-designware-ep.c   |   2 +
 drivers/pci/endpoint/functions/pci-epf-test.c |  59 +++++-
 drivers/pci/endpoint/pci-epc-core.c           | 192 ++++++++++++++++++
 drivers/pci/endpoint/pci-epf-core.c           |  44 ++++
 include/linux/pci-epc.h                       |   6 +
 include/linux/pci-epf.h                       |   7 +
 include/uapi/linux/pcitest.h                  |   1 +
 tools/pci/pcitest.c                           |  16 +-
 9 files changed, 373 insertions(+), 2 deletions(-)

-- 
2.34.1

