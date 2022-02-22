Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6754BFE70
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 17:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiBVQYp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 11:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbiBVQYo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 11:24:44 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30044.outbound.protection.outlook.com [40.107.3.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9D9166E04
        for <linux-pci@vger.kernel.org>; Tue, 22 Feb 2022 08:24:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCUvNp0fHnPeqjzMiSsNDFnUceQq5oYCfBFhLoSuZMl92oGBFLFbQLyA8ZGCIRVs+0brqF4Cgh1KtFogE7QK/H8OlnHZB+E+PgpOlQ48++bETaTPH/+aUWSdgm3UkTcBK1vt/JQi+ufnQacdIM6xfgyXZk0OVubPxV3+HoA/GUSCOS/xzqXU5Qc+9EHSHqz9EDEAKh+LJnqwwzXXg6mtqgqrnIoogJN0JIeVvdLf0pY29+7WIKahAoxETyhDvS1FwCkAEFVqiGortZ39LtZg1RF+N6E70uXsqbCKMEjIURrKCEGQVtyIHPRZFZWmhM6/6XJnFNYGvBB5+8QcA5wVJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qs/jkr41pVJhlqjqIo4Dp0IOTVGhXFDkBybRJYaF+dg=;
 b=Z8b2j7hP2HV5oFSno7ZZFUqFCc0f8aGYzhVYAMOmDKWJ9YHv6qJ+EUJrVfZ/9qF0KXEY2bJrD8IVldWxlqHYo6kZsYReHw2Eegr/ZpE4wlYBteXzGYjdVDqrxtvcFpeBCqXbi31BRJqsmmF9KdXgzt3AYikCSJ1uxCMRQOs/Vfs7L0vMODZdBm58doqAdFQ4852eZ6o+85sEgvxisOo2PwlScg5bcpHKmKzMAAIEu4F69hAVvfzh9KnV2R5K2l706od8pjl1NowcFQ3exsU0hvJzxm8yuzNYcXIpLa00aMYYnXKQPCztBpEfD9Vycp7emjV3wcr6saCC5Tf8BRnrHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qs/jkr41pVJhlqjqIo4Dp0IOTVGhXFDkBybRJYaF+dg=;
 b=ZsVXiqQ4eyKhv25t6kY+0D0ILrYCsaseQR9MbO/ZBn7Hf8zv3s4L4QwBLOwo0GTL5RReQNzF/J+jIT+AvSjMAaGL/+rRKrF2tMxWtx4jd+6dnBD4bVuXc/JEBKRWfjcq0Y5lRq27y6QWYBcBIZDaHFhj2vTd47FaouZG3iXmXr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DBBPR04MB7899.eurprd04.prod.outlook.com (2603:10a6:10:1e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Tue, 22 Feb
 2022 16:24:15 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::9ce4:9be4:64f8:9c6]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::9ce4:9be4:64f8:9c6%6]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 16:24:15 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     helgaas@kernel.org, kishon@ti.com, lorenzo.pieralisi@arm.com,
        kw@linux.com, jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lznuaa@gmail.com, hongxing.zhu@nxp.com, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com
Cc:     linux-ntb@googlegroups.com, linux-pci@vger.kernel.org
Subject: [PATCH V2 0/4] NTB function for PCIe RC to EP connection
Date:   Tue, 22 Feb 2022 10:23:51 -0600
Message-Id: <20220222162355.32369-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0190.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::15) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57f58000-413a-4639-ece4-08d9f61fc4be
X-MS-TrafficTypeDiagnostic: DBBPR04MB7899:EE_
X-Microsoft-Antispam-PRVS: <DBBPR04MB7899AFF61F4FB5019426F391883B9@DBBPR04MB7899.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UkBvm86E+OYUUtZUYHBY+oyfYgfyhR0jPdpPnvsYkQPJNcs5243aAv+gcB8EUQ3FZWX+McgUR86SMdg9QZLljvcQmA2ZsHifZrurTi0C76kurUqV2jpjGH9uX7KuNaX1AgBd/sCkBe7YpztGC56yk/oEZC7fI4Qt9e1NLeTS6GNzzHppqorM3KMPj+TPeAIDZMPfN93zFwnCXT6VYECOBNUztoUBk8gNd07dXYFv+kgfnICDAeaKV83g7GbFvHR4EGs0GjdbxiI3W0V4brb9GCqn/0g6kR7qpa2PJxdHplbSHUdWk68Nnz+Gl3D36FppSStRxYllRZMm7giBq3Dlua6GIIDGLQee+OLGSO5acfHkvXvf+Utib8FwF762eKSYDZBnvfgWSfWRQRDCxF+3jyy2XhoXfAhegvgwmVwT1gZulF9JPkxNft9kg5+UvcrZktFYH7LoUWWqfjVftswQFpC7XKF+jRBmG4Jln3In87fPi7Zwp/AfrSraNXU0jDCEujXJH6HSgLtDnRuNHgJSD5F96tFLvykH3RpPf+NI/dWbUElRWr3QYt74H+Ws+xwM8Y2OvnObRDStV5/k/2R6cc+HSgLpaeoWtGLSPk6y3OjOfRfj2iK/x0+rZ8RKOGLEDKDsfRC6GfQYihyvxFMtH1IqEGUFuVekVoxbedVmTshRJMWXBc9UihODh0E3ezbrfAU2YpMTOmBOPYo97w9NOcnfNEedf4k8LE5cE89cQ0w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66556008)(83380400001)(508600001)(4326008)(36756003)(8676002)(66476007)(6486002)(52116002)(6666004)(6506007)(5660300002)(26005)(1076003)(186003)(86362001)(8936002)(316002)(7416002)(2616005)(38350700002)(6512007)(38100700002)(921005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0sxMXpOY0QwMUNOZWZVL1JIZExrZUo4aURrbUlJckd5TFloVjF5TnI5a3NB?=
 =?utf-8?B?bmRUSnphMDErV2JrTkN2VzMrNFZ2STBsZmhITjh1Z21NejZ2Zk9hYmtmSzFN?=
 =?utf-8?B?akc0RHlVSlFGbVhNSkViS01GaHZVZFBSVEloNzR1MVk0OWliWmxFSitkQXJU?=
 =?utf-8?B?aE9FUE52SkthUmJHcWNzaEF2emp4Q3l0Qy9MakxuOVhDQTVneEZwZWpFZmE0?=
 =?utf-8?B?eCt5NndPa2J1RGFXaWp2NTV1N1U4bnZiZ1hTN0lNaEdYRTJNYzNteW1XWmFU?=
 =?utf-8?B?RldEYVBnRGVVS1RpV0FtNUxkSzV5eDJJbEFaNkpkZlN5cVpPNTVmRGk3TndN?=
 =?utf-8?B?MXpoS3lzYWdBR0dscWdRM1lmRi8vbDl0aXJGcXY4K2NUYzd1ZzNLd3BtajlR?=
 =?utf-8?B?amdQY2N1TFd2MzA3aXBBQUdVdXNTcmEwNVp0cG9maXRlUDR5MXhZTi91ZXhz?=
 =?utf-8?B?YXV3UGRsVktvSFdPWnhsZVJKRjZDTXVnOERWQks3QnUzYUdXR2V1aUIrVUxn?=
 =?utf-8?B?blNyRmE0eFR6d1d6VnRxazFCYTAyeGJXdTZRaVordGh1bVdxY3VyWVBtbDNt?=
 =?utf-8?B?SHg0dmZVM29oMmJaUWtKdFE0bnJVNlVYbFJTemVZK1FSM2krM3ZYQ2IrQVZy?=
 =?utf-8?B?MUkxTHRFNWNDTG9rSXVCbVpIVUJlemRmVndGc1FpKy9WbEtmbVRHb3FId0ZI?=
 =?utf-8?B?dnpONnZNY1dCNy9jMDRjdzhIbXkwZm4ycWxmeXEwSmZwWmM4Q0dDOVdGbFpY?=
 =?utf-8?B?MnZYMm9YclUvd2N1L0VmY0NiVG52U0FQVVlXQlF6WWVveWxjRkVGaTZrL2Zp?=
 =?utf-8?B?ZUtNbVdhSXEzYjN0YWoxcHJYNkNPVlo4T0tJMDdyQ3B1T2g1THEvWDNmUEpi?=
 =?utf-8?B?Ni8zdHJWYVQ0WjZ2YTVMNGlrNUhLeUpEdzlrYk04WlN1SVNHUG1EWkw4SHZV?=
 =?utf-8?B?bGliVlZ5S01BdWFyaTBNbjF6NE1QbUdnR3VHZzdyQldSelVKYS9STE5jZkYy?=
 =?utf-8?B?Rkp2d0Z3TWw3MHBjZmxzVExGTGpTeFRPMGJaMEZkR2VjM3FuaGg5WGhNaEJl?=
 =?utf-8?B?UzI2NGlmUEJ3NE9CKzdaZ3NkU2FkUUp2TlNKUmkzVksyYUtndVlTbmVDSERO?=
 =?utf-8?B?T2VLcFdGa0pTNFgrKy83QXhoaXJZMlhWd21DazZNa2duUFpTbHVVdEswSkYz?=
 =?utf-8?B?OWRMaWg3NXgyMTVneXBnck1qc2pHRENUWCtqQTlqU3BWWUFUMUQxbFdDK012?=
 =?utf-8?B?VjJWbkcyK3Uvc3F4Yi9UYkJRd0NLV3hzd2xycU1qWGZLQ0V1VzR1R1JWV1Zv?=
 =?utf-8?B?TVc3TE50VUVacUlwS0FQd3hBNW5IRzhEcjIvZHlhY1hWUzNrc3VGZ3pvdHFE?=
 =?utf-8?B?RHd2SUhvRWJEOXd6VFoxcEY4dCthaU1wSFA5VTExeEZKTFBxRnJvektpYk5M?=
 =?utf-8?B?a2s4K004M1dOd3dRZzB4SFk1aXIrdFJUOENqWXk5NWlaWGdsbG1jdHJxM1Q1?=
 =?utf-8?B?Q2haZ3dPeWZVVFRKOWtJamJWNUNjR29zV3FUK1J6SWJzMEJxVS9XaERXcTJO?=
 =?utf-8?B?V3NWcUdqak5Ga3piK2hOVHNGRTVrZW8vZy92U1Rkcm5yQVpyMW90WHdIKzA5?=
 =?utf-8?B?WS9rWUhIaWRlSTh6OU5oSHNlSURxN2MyK3c3TFd1NDkxTUtTbm9HNU4yMjVz?=
 =?utf-8?B?enZlTWhwdWE4b3Flc0xXMkplcjRFc2RzME9Wdjc5MEdBRXB3RDg3L2FUZXlL?=
 =?utf-8?B?TDFwT0hHci9oTStSMWlLQjR5YXFQQkFWeUlEbTd6blcvRGQrTmVod2tDNkhw?=
 =?utf-8?B?OGg5dE9FS3JpdlBybmE5MUZUQ2U5amlYMktYaUJJSDdrdllHcCtCazVJbEhL?=
 =?utf-8?B?S0c5YjBaWHZ2OFZxelI4L0RIV1EzQnJ5SjJkRUk2V2xVQ1o5MmJJR1RmckVr?=
 =?utf-8?B?YkdnemV6cHRqeUZ2ZkV5SGJIWkhybnFpZzZUNWlEK3RhbEN5SVFoenhWeXl0?=
 =?utf-8?B?VGc5WWkvblF6cUtUVHVmV3NBM0w2WWxQOS9kZTZRZ3NsbDN2QUl6SUp3cmhN?=
 =?utf-8?B?UWhzU01PMzJlNE82bVozbGhaUGF0NDl3SHJSSlYzeGlYU0FSTGJuNC9ad29k?=
 =?utf-8?B?eEFkaUV6WHJSK3ZLRHFNUFpqZFVvcmp3M2YwSlRFNk1HZmhTQ0UwY1lPTDdm?=
 =?utf-8?Q?I6OfXAFLu24k4C5acFbBcAM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f58000-413a-4639-ece4-08d9f61fc4be
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 16:24:15.6776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjXjyyESD3oBD9tx/tUC1/kPc4xkYfD2jKW7I67TJm1LJPktEhRLTuqBovRRhTVIPaGRxZSvKkdn26ZpuA1iWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7899
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This implement NTB function for PCIe EP to RC connections.
The existed ntb epf need two PCI EPs and two PCI Host.

This just need EP to RC connections.

    ┌────────────┐         ┌─────────────────────────────────────┐
    │            │         │                                     │
    ├────────────┤         │                      ┌──────────────┤
    │ NTB        │         │                      │ NTB          │
    │ NetDev     │         │                      │ NetDev       │
    ├────────────┤         │                      ├──────────────┤
    │ NTB        │         │                      │ NTB          │
    │ Transfer   │         │                      │ Transfer     │
    ├────────────┤         │                      ├──────────────┤
    │            │         │                      │              │
    │  PCI NTB   │         │                      │              │
    │    EPF     │         │                      │              │
    │   Driver   │         │                      │ PCI Virtual  │
    │            │         ├───────────────┐      │ NTB Driver   │
    │            │         │ PCI EP NTB    │◄────►│              │
    │            │         │  FN Driver    │      │              │
    ├────────────┤         ├───────────────┤      ├──────────────┤
    │            │         │               │      │              │
    │  PCI BUS   │ ◄─────► │  PCI EP BUS   │      │  Virtual PCI │
    │            │  PCI    │               │      │     BUS      │
    └────────────┘         └───────────────┴──────┴──────────────┘
        PCI RC                        PCI EP



Frank Li (4):
  PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address
  NTB: epf: Allow more flexibility in the memory BAR map method
  PCI: endpoint: Support NTB transfer between RC and EP
  Documentation: PCI: Add specification for the PCI vNTB function device

 Documentation/PCI/endpoint/index.rst          |    2 +
 .../PCI/endpoint/pci-vntb-function.rst        |  126 ++
 Documentation/PCI/endpoint/pci-vntb-howto.rst |  167 ++
 drivers/ntb/hw/epf/ntb_hw_epf.c               |   48 +-
 .../pci/controller/dwc/pcie-designware-ep.c   |   10 +-
 drivers/pci/endpoint/functions/Kconfig        |   11 +
 drivers/pci/endpoint/functions/Makefile       |    1 +
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 1424 +++++++++++++++++
 8 files changed, 1775 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/pci-vntb-function.rst
 create mode 100644 Documentation/PCI/endpoint/pci-vntb-howto.rst
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-vntb.c

-- 
2.24.0.rc1

