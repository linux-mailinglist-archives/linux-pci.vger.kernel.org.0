Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BD44B62F6
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 06:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbiBOFjQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 00:39:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiBOFjP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 00:39:15 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130059.outbound.protection.outlook.com [40.107.13.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35471EC49
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 21:39:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJaFxI7gd2s6/1fAa6U7uUDYwP0avq4JLwOtHzRpWNBsfBShXWwirjRTnakz7mpHZ+5KUGtChHXdJcrqvN4Nm/RypFZ/RMaIofuAN8Wj0UCQ3+KCD0uNsFlr2Ofepwb8/Upe3/Xsye0dO972HZgTXMx3W0eAak84l7xoG8NgjY2lGJDbGngS2BGe6VU7JorliTagXVifUkr9I1FMC2aJ6OATpjfEVfSv0jTVwAmTaC1zkWAYFCxRrdOkdjDN8ZbxFSg/iYAQ1Mudj81pHWG62rXp2liWLmWjmfUrVHcuOPKu74ev5FSBvORFm+DzJLTWDfjQWnCb8QQ6MdPt6jRFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7E9TI302vmvFAdeq+fTHqpTTfbu243i1Ka9tnIaM9ZU=;
 b=Tty3KzevGKYXT/hpNLWqcaIKgo7L++LRQk8Qja+JmG9W15FdfA9B7Pc5BtMUIQ9qhh/3JIVWeqJcRyTRUwpLpMbanUUKMOnECV5QSuT/c1mxPq7HWH1cg+yvD1ugQovKmnM62VWYC4yPXqTwDPGO1fnz0ps/ecJ8qc8o85zrHOQNhvYECgUaxTHSlGzMokKDDe8aH8/UGxjdZCP+vMD7g23OSbEf1InQFR8+zot1k0POcACZX0pd0IEyM/UDCZM1I3teMgGNcJalecM84D1PyAX1D8EnBp0MBxRZY/gif2it2b8uSA1ibQnP8Jy0uIll3q500aVU5hjDpV2n8Ub1sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7E9TI302vmvFAdeq+fTHqpTTfbu243i1Ka9tnIaM9ZU=;
 b=mW6esEQCaa2gTKA/b6y/DwQtel+7E+oA2acxTXmQAlZjH+boDXNe2CkEZQlGbiZm0Zw01r6N7gf8e+TWdEaimqRbIXo4Y3qPvois797ghWYpK7QfSWZXnrA/jmKYK2PW5pAw/UVWCtJCBGvvUHiyBWN3V3J5mD6ta4StBrgBAh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR04MB2976.eurprd04.prod.outlook.com (2603:10a6:802:8::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 05:39:03 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::4881:43a4:4127:f25e]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::4881:43a4:4127:f25e%6]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 05:39:03 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     linux-pci@vger.kernel.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com, kw@linux.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lznuaa@gmail.com,
        hongxing.zhu@nxp.com
Subject: [RFC PATCH 0/4] NTB function for PCIe RC to EP connection
Date:   Mon, 14 Feb 2022 23:38:40 -0600
Message-Id: <20220215053844.7119-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0007.namprd21.prod.outlook.com
 (2603:10b6:a03:114::17) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18c67916-507d-4428-dddf-08d9f0457971
X-MS-TrafficTypeDiagnostic: VI1PR04MB2976:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB29765F4F973B08FAF1690B4088349@VI1PR04MB2976.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZg1vqjLIPM84qtMw6L051JIGf9gEwyxckxV37LiUG9R61kzQ1UugB71EpKVzZOQZexq9yF8b44eKRwp5GpH3ZRu2iRhShnnsEzMcncsZKdeGF8UZdQlp3mMee69Vv+Sbvm85O8p1AH2M6ZkfDPN8TIsBGdXegmHWM+o6Qe5qUZR5NNgRa/g4ei1IchS4XWrMG365hbPCTb5v+G7LcG4Akw3KTJR1kPD/bps8w0d6Lxe7rZqugEjpssh/+CzbnIiKe9UsRqZa7XvYp7x1gpxV1IIAKs3wicLRv4lM32zxVJh18S4NI7Zqm9/cEZDpautA5fVKXNrlN7ltq29AI9g2g6hz6S/gp7dQ57sIheRjvejXZknR64nOpya7Z4uw5oyeyvPvC+Yklijz0eRjkIsTg1Y8THEBe/sqR25t2d8sGbjNNh+9+ccJl6P7/5+47ti3383T+b+IBjVqv0S2+IMpbE1sreA+mjzGPjkZ25uiIlWrdBqXVMgYgsNrjE5MV52IXDD9dLLVp8g8Say8Xd/RpmMmBnmQIrp1bNHxrjj9ndFSTOc84E1dCiI41S7iC8STnPwKdp5OJGmNkG2p/hoeYjCZGNDjz3dkYbdA6thuaBbVOTWkbkCeZYevME0nWNqpaIJNi9UZiTCms/DJ99Wdb3wqm9qWFZgXQkbJ+uoMItF0f4Rvx1DEt4p76a9qEcehJ0AGA/HPESKtkE+GqUrIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(5660300002)(26005)(52116002)(38350700002)(186003)(6512007)(83380400001)(38100700002)(86362001)(36756003)(2906002)(8936002)(8676002)(508600001)(66476007)(316002)(2616005)(66556008)(66946007)(6666004)(1076003)(6486002)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTRDZTd2RkVsK2xBSU9RdE01TFNlR3Rpa0c5Ui9lSVZPcXEvem9PZDZVak1v?=
 =?utf-8?B?UllPekhCTitlYVc5QmZBNGlTZ3BneXBRZVFLOW9EWWxWbmQxdzcxMVZwbFND?=
 =?utf-8?B?U2NIeHhpbmNIcFlhaXcwZEhMZ0hzZkcvSCsxaGhteHpKMXhHbFF0ZXd5MzIx?=
 =?utf-8?B?NkpWZ2NtZ09RMENzNXRKUlh3Q1E4TTZLa2ZJd28xRXRUVDRHZmdJZTRGdnFo?=
 =?utf-8?B?SlhmeFZIRzBIYWFISEZBRWZRNjBxSkhHTmJ0UDM5RmhmTmhpVml6MEwwK2Jp?=
 =?utf-8?B?SlVNTXdEZ1IwejlVN1VJY0pEOExsdUh1TzMrbXpja21QTHN1ZFR2OXMwb0Jo?=
 =?utf-8?B?d0xmVlRBcndPMkwySWxWMG9EaloveldWa3RPUFNiRmFOSjRUVzRQZjFZeVM5?=
 =?utf-8?B?Wmt3RzZmM0hSOU00ZmpDSFN4dlRkcEs1UG1reHQyWmdYNG8ybVVpelFWdHR4?=
 =?utf-8?B?SW1lZnhzSW1YdXozMXo0REkzS0M0dnIwbXZkM2NwRGdaWmVjUlVMMVUyZWp4?=
 =?utf-8?B?RVlCQktyL0JSVEJ3VGVqMVlIdTMxRittRktCRENqQzRiYlB4K2hrZndMUElj?=
 =?utf-8?B?a0wvb0ZQWlJuMC95bnN0MS9pWE9WZTJhZElHUVlud0h0ZEJCcWFFMW92Nnhj?=
 =?utf-8?B?ZVozcjJtNmlmSDlmS3lBd2MwQW1Qb2dpbnhhU2tuZ2NsZVEvSjVSblFSZVpQ?=
 =?utf-8?B?V1FSWmx2UnQrbWdqUzV3U2k5d2x2dXBscTMzRUZpb1piNVJpVFBxSFZWNnkr?=
 =?utf-8?B?RGdZMEJMS002bkhqcFcvbTFqelRwK01qY0h5eStrWVUvL2RweGcyb0lFZnZn?=
 =?utf-8?B?d2ttc2VvWHV2RndBVW41R1I5S2FxbGFTT3FwZ3NxbjJlUVhaSFJhVVpxRm4w?=
 =?utf-8?B?MmE3T1V6dXlnODdzNDhDZVNOYnROYnpKaWUraldNbjhocGg5S2R0SGdrS3lP?=
 =?utf-8?B?UWpQYS85QnlxeW1GU3FSMDA0ZFhkLzlxbkp0amhoMWJwWEZPYytxazcxRTJM?=
 =?utf-8?B?Q3JFdkd2Vk43eVRlU3p6VEJkTHZ2b2psbVJLMHltQjVhVEttdm5paWt2Zmho?=
 =?utf-8?B?NGVxczQrNGd2MFhMUnMraHBlcnZjVEdzWi9nS1VrMW1KVUNwWmpvVE85T0xy?=
 =?utf-8?B?dUpFVVhpcGFGdHJXSFhoc29YM0pvME1JOU5kZjdMaEJ5MVJWRFBCVDE4Q2J3?=
 =?utf-8?B?SzUxZTkzeUNWVXVZYlpKY0VaOWJQTWUzSHZvc3lmbGN4bGZKYUxpNEZpZ3Nn?=
 =?utf-8?B?eVdjRWNIWVI0RElXYUI3ckZiekk5cHZkZjFBSGJjM0xmZ2hFRUFMcmZTMXBK?=
 =?utf-8?B?VU5yTEkxaEVxdll3eldzd0hVditwTGc5RnhNTFhtVGJPM1lKQkxoUUNYTzVl?=
 =?utf-8?B?aWs2aUhxWUZwODk4RXR0WVZHT1h5TTVRRWdpUWp2WGRnNDFHUHhxODRXanli?=
 =?utf-8?B?cjNucXpYVUlFQStBVmtVZXZKN1RaaXpwNEErYXI3MlQ4MlNDYjYzZDFrMzdR?=
 =?utf-8?B?aVJIMm4xZWZ1WXRKZElWR003OWtuMDFTUjd6Q0h3R2gxNEo3c0lWSDhFRGFR?=
 =?utf-8?B?clVELzl5NWlmUS9ZLzdTa2lRd20yb01YT0xTYmNOTEVqaGZHdTNjemtETWRa?=
 =?utf-8?B?UXpoT1h2aUhkM0w1WndsVUZpNW56Um4yRWdtc1picXRqTWVWdWFVN2Q5MHBC?=
 =?utf-8?B?VGJxbUhad0IzRC9hajRRT1F6RkplUUJzNnlqR2NOY2trZ0djdjhGUzNVb3RP?=
 =?utf-8?B?NVhlSFVTd3c5OERNdjZibmhxaURoN0lxZnlNR0R6Z3J6elJJbkVpTmo0enpG?=
 =?utf-8?B?eVVmMEZvMkovdHhYQVRnb3k4UHNxNmFSSS9yYXZJM3FQamFXekltdE92K2Q3?=
 =?utf-8?B?aFh5MlMrSk8yeC84N0NOSDFVQ2ZlbndzK0hLWUZLWkljYi9IcFBrU0Z5NHRL?=
 =?utf-8?B?Y01RcFdjT2Q4R1hYVk5vTk1XdHlWMTd5YXJmUXdnQ1BmYzlWNEplNkJOSE9x?=
 =?utf-8?B?MWpSTzcrZTk1S2pVUEZGeEg4UmtZTGhIaktZRUx3ZGVuazk1dkFESWlWeDly?=
 =?utf-8?B?d1FhZ056TEVuMytRMkM2RnVoU0dEcy9KTnREaWRFMDczSk9vQzdrYlhqTnZ2?=
 =?utf-8?B?Q2ZaV0FSeGdSNTNkVGtyV2tjZUl0bWVsV0VaVlFNQjFhNDdIUGJEejd3bFZZ?=
 =?utf-8?Q?+DeQZffFJ0YCk0/p3SbcbJg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c67916-507d-4428-dddf-08d9f0457971
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 05:39:03.3675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnGeaT00NXQCErXO334dIifXtFepdIZwTWsbwRQEiG6Hrik+LQZtJ7RT7lGSGJMJ2WRaeWlRZe4wWD1G/wRlGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2976
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
  PCI: designware-ep: Allow pcie_ep_set_bar change inbound map address
  NTB: epf: Added more flexible memory map method
  NTB: EPF: support NTB transfer between PCI RC and EP connection
  Documentation: PCI: Add specification for the PCI vNTB function device

 Documentation/PCI/endpoint/index.rst          |    2 +
 .../PCI/endpoint/pci-vntb-function.rst        |  126 ++
 Documentation/PCI/endpoint/pci-vntb-howto.rst |  161 ++
 drivers/ntb/hw/epf/ntb_hw_epf.c               |   48 +-
 .../pci/controller/dwc/pcie-designware-ep.c   |   10 +-
 drivers/pci/endpoint/functions/Kconfig        |   11 +
 drivers/pci/endpoint/functions/Makefile       |    1 +
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 1425 +++++++++++++++++
 8 files changed, 1770 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/pci-vntb-function.rst
 create mode 100644 Documentation/PCI/endpoint/pci-vntb-howto.rst
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-vntb.c

-- 
2.24.0.rc1

