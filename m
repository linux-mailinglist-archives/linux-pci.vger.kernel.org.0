Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8656C637AF1
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 15:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiKXOBw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 09:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiKXOB1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 09:01:27 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2107.outbound.protection.outlook.com [40.107.20.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAC512E20C;
        Thu, 24 Nov 2022 05:58:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFbmvOdYOY6s/pYCAs7+dqloVDVoqKsUCog5qCRTGFso9RUujkpTD5gChpiZK8vS1VtbONsbAzJk3TjwZGQvmfrrCzP5umYNzUw5NZUoVEmc/aQHm60XoeCJ8MkazOgLZ5D3TrDn3Q9whQd+X1qMCE4Wsm28PnWUi7VKVYEPYfYvHrtzBn+C1i4fJzie4usWvD08mPnYzxC1OM0YsHo2KAkM0FLbIGkOdyXwxwUbto+Egha7v1Xn7EWVGpEXseYH29RQeGWETJH3qmrDacAsFPRzs5rSiOTwPJWmbK3WGlfubPqzUBFTVtLWw9nF/IZSbf2gXRcfMs398w11SKNueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSW9mb7hJKg5sJ5pS5fwisM0fho8WR0AVyVEjndyNn0=;
 b=CACORGuX4Jbe1thMSSGdJH/aHaLc5swTG5QxxnJpMUjL82F1EhAsIm0tknOP2taeQAR+oJ7btoq/1BZcsk18IgdCOnN5gI7JSWUG97xejn63ziwYt1gKS/ZUzKZzE0AO/23TLZvU3UIBVFatR8LSdtCCqyJ5bU9Dxm7j/Vw7GhfJmqTfbZR5fwI7tyRb1y0xnoqeRw/e78LCTf+JquqKQpCioZO9jtzoXdlWtd5VCh/M5bvcG+Sc93YryHtOMR8dOvZSZIkb3nVt7w0NmY2jOfcgmMcLg9HF5CS4G5Y3y12PyaDlG4CDlEN4D46qXmi6oyZWagbmHt9YESPneP6/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSW9mb7hJKg5sJ5pS5fwisM0fho8WR0AVyVEjndyNn0=;
 b=F5Z+PRioAW9GKoEROrdugTYHEdDDpQ8GfLmKrwhBT9PRnolm1+NTHv5IT6gk4vxWx6IVSb13o++5E6ii8JgX30C3Ft4BegLSeOMYJ9GcVwsAwJJpfhEo9Dst0hEKDvf0UC79PknDmKRQTXfnai/GVtXgDNO16SmR5i/k/UuKyFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AM7P190MB0758.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:117::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 24 Nov
 2022 13:58:52 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a%3]) with mapi id 15.20.5834.016; Thu, 24 Nov 2022
 13:58:52 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH v2 0/3] PCI: armada8k: Add support for AC5 SoC
Date:   Thu, 24 Nov 2022 15:58:25 +0200
Message-Id: <20221124135829.2551873-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::18) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|AM7P190MB0758:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b56fe9-ac78-4d11-5ef5-08dace2404b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i09jDPJWzuUGz7lcVnQzrCGXG/JCctwgwC4jskBSw323X+NOTaOkuMhKkKZdoxfSh0/JN7W2mbyW37hIsvk11eo+JGOLSCAaCVUKmVLZZ4quIoqEkg2jV5QnPPr3TCzWl1JOtTI95AxEoNzvSoWuEYfGsOG+rZFjlU3IyQ3O0a3h+i5FMfV4QYw4yRXCf1Ngh0exmZfv0VFQiPiiE11AhE+dUmzclwkKuLkN5FlmyCHe5ognM6CDBsRo4e7yIAnfzYHA6fOFKURt624LDj/bmg3fKMY7Cgbb385XxRB4A0Ojun1QPbKCwFSOjBDxdFwDudX5W76b1WVJHER4PIvVWocPxwfsRCxIp7F+hck93d6sdKsre/GxGfAlOsFkSwrIDilWKaPHDyogFDknZUE2WjYcd0IvLEkkyqU4Q524CvXIQE1X7mMjIWKoXFT9tlTJB6IYGouhsoJpJB4HTUdVHhvMT4VHXr0B/kmISoZX9wOVKyHT45zGZC2O5na8GuuxjVNdUp7cJnkSR0MqMmQlVgG/w8fk1w0gN9e8qNUBeNkyLXQdzmlGhdhBP6R0wph6ISYKy/nlBpfS4vSB+ZAae9XBY0Rhi6jm3KO8pl4ejXmYrofoEegyzCudJHa+eRF9dDG/smUUfwaPorKRiq7EqeJW2YC1YM5Ua1VCSe7TH8vfmW+5quWGkHpQpOsafvMRvJt5bmamWMH8DMWCOl/G3bHJteul8KW89M9+u//h5P56gQ1WDCKX4ZKIbFIDaEBs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39830400003)(34036004)(366004)(346002)(396003)(451199015)(1076003)(8936002)(36756003)(83380400001)(2906002)(2616005)(41300700001)(44832011)(5660300002)(4744005)(41320700001)(86362001)(921005)(38350700002)(38100700002)(6506007)(110136005)(107886003)(54906003)(186003)(316002)(6666004)(52116002)(26005)(6512007)(7416002)(508600001)(6486002)(66946007)(8676002)(4326008)(66476007)(66556008)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wk5RCbFHQ+Y0+KuOv30NWJ1ssTSmsAaPpfx0ugissuCnPjGd2uPGhiswF7NY?=
 =?us-ascii?Q?SIZRHsjg4L05phX0fG7pDeqvl3X4ZFyOE0j0mKEJxWZSZEaQsB5ZN8eDJ9LE?=
 =?us-ascii?Q?8hVKCPrleRuAApYQWRg72/C6LxxZEtzvkrtMOMfR7sNooZJ/9DPKfcoUfR3+?=
 =?us-ascii?Q?cQPmTw9Jrnlc4LymzeJVFsT6zc3WkhOOVTbSNtFDcSdCzhFO5XlZ17vtHGvJ?=
 =?us-ascii?Q?uYRd+uEt4b3PoIIPzKRRR1p+LlfauOXRNo1OQ3W8uYbdYa13BKF12OckQ77l?=
 =?us-ascii?Q?I/umIIUGmLKaXD41IDYXVZy2wuYJBeLkB/+RCIwZz12a56C5xoXwzgvFaSEj?=
 =?us-ascii?Q?4JCke68qyKBVrRkg9CAk/cXxuYsWtPF0FMAg7mTggZaTFJPRAmVbdwWtlLeG?=
 =?us-ascii?Q?AtC9qNqBs+d1CnEHeOsyu5X78m8wOO30/csHQCLzqjH9/bYw+oIF4xPjrJqC?=
 =?us-ascii?Q?jUGvI8i7FdZpyaRPwanGWg5frS2HlGe8eeBYAXtH5Et2qLlB+sa0iYn3JA1s?=
 =?us-ascii?Q?6iYNFDi2rYgtfVqaopc7VuaSsXw0G5scGB29b7mtFkJUxxb1VYUg1+ReX+cT?=
 =?us-ascii?Q?9tcxTbonHCHqmmMX1MccPvqCmYTApjeVq1k3t1myU7NWpJimDqns2VuBqU7x?=
 =?us-ascii?Q?P5vq9sHIWZSrFlgr/eP2dT9VZqgID76hW3nFJMKh8Ov1mNTeUceBFSu6lTdJ?=
 =?us-ascii?Q?l+on7Z4sfGY0pWEpPeMfbB5zp98iYTpyE4E6nhJikAOnUSK+JzmVY8pvXe11?=
 =?us-ascii?Q?0/LJ734tuffvr8J9i3uJKvudSdKKwb+yH2SDym7gcsQ1lJMypUTY+rCldDef?=
 =?us-ascii?Q?rmERxnOdh/IzS9R6SFpBYObJtcIe+GRTT8XsXhhPkopL88No94LPmAn9TAHw?=
 =?us-ascii?Q?k98jV27i2kmjCDUZghIVBspu1hIWMCvfLeUxylWouxNqNlIsrpmrYoUlFUaZ?=
 =?us-ascii?Q?Uj60mgdb79q6yGgFKZo0Q7nWi/hvbS8K3uhOzm/7D/y2sscRbmhsLvcNkEp8?=
 =?us-ascii?Q?m2ryflMw9mHGfrWE++HtUTvtfcp4i8xmxpp6gyendMoWi/q3kDvaUUQkhFma?=
 =?us-ascii?Q?Ui/vIuesey9aBuvsoxQ69Q1ZEMApiDXpn5MZl/rbIvQXmXtjGPXi5QBq2OxH?=
 =?us-ascii?Q?kbUq+m/fWPzJFyWV/ZR264gVpSJKrNTMBZyhbRs2nKHSYHaUVCmpanpSy+b6?=
 =?us-ascii?Q?R2b7u+vmVK/sUJkHq46DuOPgh441XIS58MHPyV7nHYDBr43ckvgcDy8TbrOQ?=
 =?us-ascii?Q?wiwrpiPaJUHDpO3Mna1WHtX3C6MLz6itY4g5TLIbLCSiRlEOfYeLqTUeGkiB?=
 =?us-ascii?Q?1RSZg54GEOPnwdNmRJ/IlTRvRwmWaFQ1IA5Zc/ah9riKIsMnS06dO7hkgH4J?=
 =?us-ascii?Q?aaSwG+JNI17YGI7QXlE3kJlgEyZ57gWnGjsBFmTOZQ/INcq+6EAID7adronw?=
 =?us-ascii?Q?ZA8DsvlFSs+AfJ6arTwKXWbcPqWV4mx0IRcSCz3KOXeZHv0fhxi64mBqED8G?=
 =?us-ascii?Q?mhDGjjokJ189pvRi8xc9Acvt/YfLB5AYXD4VQTPVf3JWNx5oUkfD92nKVRCb?=
 =?us-ascii?Q?OFdn9uPPRqDu5WMLsQZNVzSlsLtzno6s5lsvLSeS3KFt9895syQHLYjNaD6T?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b56fe9-ac78-4d11-5ef5-08dace2404b7
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 13:58:52.1335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ILWYaZQvw57Jfy7Pc926GpAJgQ+5BdVu4P4bbI3DKUdprf0MtW03E9wGWhvabTSdTErCBR061rlan6N8URLPc9UH9UGhYqWD3Jp1qSAP0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P190MB0758
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for AC5 SoC with MSI. There are differences in the registers
addresses.

v2:
   1) add patch with adding compatible string for dt-bindings description

   2) fix W1 warnings which caused by unused leftover code

   3) Use one xlate function to translate ac5 dbi access. Also add
      mode description in comments about this translation.

   4) Use correct name of Raz

   5) Use matching data to pass the SoC specific params (type & ops)
   
Raz Adashi (1):
  PCI: armada8k: Add AC5 SoC support

Vadym Kochan (1):
  dt-bindings: PCI: armada8k: Add compatible string for AC5 SoC

Yuval Shaia (1):
  PCI: armada8k: Add MSI support for AC5 SoC

 .../devicetree/bindings/pci/pci-armada8k.txt  |   4 +-
 drivers/pci/controller/dwc/pcie-armada8k.c    | 171 ++++++++++++++----
 2 files changed, 139 insertions(+), 36 deletions(-)

-- 
2.25.1

