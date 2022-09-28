Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D5B5EE870
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 23:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiI1Vja (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 17:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiI1Vj3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 17:39:29 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D76697D5F
        for <linux-pci@vger.kernel.org>; Wed, 28 Sep 2022 14:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvENDMliue3/FxlO9ZBOmjNG1ODpOacSDWAQny0wJ+9rNf7tM2Mx6Lc6YsBncABeIns51ajrRu9hSIEB1XTUcZ3jDFqLkTUQGLAPkIk6K51d7QObcc6vY3Z6QxLiF54KtoZFdQ8nPshRJURGTxvUjU2xBO0zUDU4jMqN9aAqF+E9GNjuUD5tYRnJb7KEZx5pzIPUxchjCvV6weDhLRwrxGsLPI9yCNcFLkQ/pYMNiirhugkfKaWAskbF7CoAizkISugalRpa5x+n9/aWWcxDibqYrlRzNK7OqSPAPOS9RsbnlNdClvbjvqE+16KjKuGfyZh6sPznRqX0IvC7stQvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rktDTD4A/iB32/kZ63Y3XStryDpmWWe53Z18bX+2+4I=;
 b=ZEreDjflt9PuMM1xjkCQbVgO4EBqO1P83oyOQEMLStbJKqsQotkC1n7JyjvP5OOLInBJYpgDQajLl3NAgairHxycZBVWU9sNkfMQtpdYwYTfyi9c1cxI0AsDOt3otQs/PjG+TMufIakxcxeWST+5yizUZnHMgWT1P8KKMPM9eEg2f701QUFt5ORIkt8ES7sbdnDer47XLfPMpMJlbDVsked3eVMc/FmS+m89ZRQUJ1BSJiCGcT4HeMFLhUlqs3xXgXfap/moG323Zeu7nxjsP9OYxaIU6SyuIDgC5qddapLXr2luROyETWkLA4Qtkif9SsZLARKlNMKB9FgeOJ/Bjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rktDTD4A/iB32/kZ63Y3XStryDpmWWe53Z18bX+2+4I=;
 b=VZEswMuhSS/o+AwdT4KaR/BheEAS+63sGX+xxocOe2kQf02199eEhEXdTCIAOCgENDJ0iF2DNFdchBsJdfBn/a/viKrMgdCiXw/ZsO/Hiyb01EWz4mUQrsXyOy70+ia3fA6PH2XpRpfjU977qQCIM75E9CIpkhp7FfW3AosH8hM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by DU2PR04MB9100.eurprd04.prod.outlook.com (2603:10a6:10:2f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 21:39:24 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::4d5d:40ae:e0c0:63a3]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::4d5d:40ae:e0c0:63a3%7]) with mapi id 15.20.5676.019; Wed, 28 Sep 2022
 21:39:18 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     fancer.lancer@gmail.com, helgaas@kernel.org,
        sergey.semin@baikalelectronics.ru, kw@linux.com,
        linux-pci@vger.kernel.org, manivannan.sadhasivam@linaro.org,
        ntb@lists.linux.dev, jdmason@kudzu.us, kishon@ti.com,
        haotian.wang@sifive.com, lznuaa@gmail.com, imx@lists.linux.dev
Subject: [RFC] PCI EP/RC network transfer by using eDMA
Date:   Wed, 28 Sep 2022 16:38:56 -0500
Message-Id: <20220928213856.54211-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0232.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::27) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|DU2PR04MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: 76cf1657-85e1-4ee0-0eaa-08daa199e5e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q3P7dBtz1Vacsa/Ua7XgzYoUpj5UUEFdx57CrUX4ojmAHN4VDwRALrXsjflSN72IKh/pBaDPRlAJs222qFi5yXavK1WP61N1rJwlR385bnBHvuG08nfCStO5BzTDFyz6i1FH7lYbQrXa/s3qx/D6GKzGv2vKDazBARO5j17jzzTHpLRXKxurxKYKseVBUVb0Env7+XNx5H1ENJNzqpo2UkJHidTU3QODub6UpynTF3wOSlaAQlftJRrWE6XaIS542gOSD07KE7owALxnjzxKH5OtguP++dAfd3WPWIQWmPenTXzFZ+ST2ilKihQoM2KTrXeVrqQkr4ouwY8e2W0y2ffFolXM5hFo9oUpr0AnAtHizgXj4Py6SJIcfQ9BmG83/2MKfdXEaQ7NLJtryfBLHsZ+efJhv/COo51Rx317ozwmhaOovFB1OhWBfLumkX8esKK4nPDk21Neek8dLRskXt9Akjqn3QzbMijmyP2jLksjZRsEf7OePubKb6neZDPBpTAzQpFaKV5a5o8u46EEhO9WG17t7i6XCMd3J/AFB5r4Gnq7Cb+poWpLceQmuRbNsfQqFPfIJvir1vsx+HJ8jysZpyLkbHWe17L6ZHAsWdLXQvPFN1GENgG/D2FuNzhsBlK4um2o5jjf59xIv0jGsFNG42DN6wU55ZrdD/ch7GGhOSwotQPaTBoutj/e8ofm34ffactiRDFTKY1Xro/jOo3QeHFUOqBRFsVexjbcrVcjd/p13q8S2V12wU9BoSt3umwBqx3e4pQ2OuEcqW/qbxZ0uPAB3BRtQ//NLfS9jHUleOfs2ZhwSKB0MpVcpDOpeeJ77F0OyWgOlkanCKAcOMF9d+TCMNCUidoZg/Pi77A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199015)(38100700002)(83380400001)(316002)(921005)(5660300002)(66556008)(478600001)(7416002)(2906002)(66946007)(6486002)(38350700002)(6666004)(41300700001)(66476007)(8676002)(6506007)(966005)(52116002)(8936002)(1076003)(186003)(2616005)(86362001)(36756003)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkdhL2VxcUVaZVYyYkFCRktjTURXc05Tc0s2NGF6eTUzZ21hZnUyUlJqT2wv?=
 =?utf-8?B?M3F3L213d2tZYitIK2ZKQzRVQy84YU0yblZ5Z0g0V1cxNnpLempNZG1MVlQ5?=
 =?utf-8?B?OUs0WS9IOGdOUU80YWRBRGJCU3FkczZ3Z0pxZkcrTzlieXpMM09nOTM4Y0RP?=
 =?utf-8?B?dlErbE1rM1I2bjRaOTZpdGZuRHV2MHZCVld0bnpOK3BaVmNoS2U5S3VPWSt5?=
 =?utf-8?B?UHlEMFhsblhzbGwvQ3hGdDdNQi9YZzBaRUd5MVNtYzZqRFhPNFkwaDF5Rjdq?=
 =?utf-8?B?SmJHWVMxR0FFMDN6aWpTSHY0elNuNU9nclJGTUFpOU9FZE9VYXlHek9XUzNl?=
 =?utf-8?B?SGdEZWcxRFY5UDhsWjhjelZzZ2FUQzdRZHd0SWZNZ2FIV3F3L3lTTGM2cVB3?=
 =?utf-8?B?UmFSNkI2YU55QlFjNVByV0JybzF5OGtuQmFHWmFZY0tJN0NRWnVZWVVieHBI?=
 =?utf-8?B?c21BQnhhUmNKejJRZVR0cmVKZlJJN3g0T3RBTlNpODQ1NHlqczVuSyt1c09D?=
 =?utf-8?B?WUNqOU9FNWN4UFZscEFybjZ4UUlMVkNmbVA4UHYxV3FjNzhwNWQ4SDF6TzNn?=
 =?utf-8?B?NFM2d0F2eEhWNjlBMkl5U3MrWXVHSmo4anNqaytmRlBCclFFUEUxdDZtaEht?=
 =?utf-8?B?cHZpMHBTM3dPbVdiT1d1dm5MTEdGbktkM01KaXVhaWxXbHl4S1U3a1QxdGdr?=
 =?utf-8?B?LzIwdWdYa2hkdHJObEhWeHBjLzM0dXcrdjQxRitFOGxEdmhESTlzNVZOSG1G?=
 =?utf-8?B?c0VkT202MzZDL2lLN25TdTl2OEpBT2gySmlSQnV2RDVHTkp4ek82aHNEb2NK?=
 =?utf-8?B?VkVBUnd3SWZrS0ZRMGNYYWNKTTJOand4b2tad0p3UTY1RFBHejJjM1lQUHVl?=
 =?utf-8?B?RHhVb1dqcFg3M2tYaUlhSWVJcldIYlp3Zjlqam11Vjlqa1VvTjBPRlZzeno4?=
 =?utf-8?B?REFrSjBBeEpRYytKdEN2MDdxMW1laXdJUXBrODhpVHJUcUE0bmR6VytGbEpX?=
 =?utf-8?B?OFA1NW5JT2dVRklzTWRFZFplRnlrMmQ1RUhxMnUvYmlMRTE1akpxQmRRa1Ey?=
 =?utf-8?B?c0k2UWV4OUFJWFNKU0V4SDNtSDREcys2Nzk4MlU2UWxHZ1p4QnMyUEg2QUxS?=
 =?utf-8?B?UkFrZGVsVXRsS010WUVWKzNaamU2NlMwcWNlNHpVcWMva1RFR3pUSnU1WWJs?=
 =?utf-8?B?TUdPaEdacFBkNEdjZmFVQ2lZeTFRYVpLS2ZwVXVZY2VmdWVqY0YvV1pBNlFl?=
 =?utf-8?B?Mm9rT2RRSkY0U0RYSzhQT1E5Mi9WSDlVaklFajQ0TWVxMkZhZmYwNWw1R1FB?=
 =?utf-8?B?ZnR0UHFZajBtTVRLdTVtdUppYUtKbUREZGc3VGZNY2UzSDh2bVZpZ0w3QTYv?=
 =?utf-8?B?ZVp0Y1pGTTJtS3o4eGJXNTJmZlE3aS80SndyWUFseFUzRE1xSzAxSFFkb3BZ?=
 =?utf-8?B?aStUTlRxbWJnYUxtaEw2cWVrMWNaV2dkbmZvZTZkZ3VYaTNGN1dhMGJVQmI1?=
 =?utf-8?B?ZVZWTVRtWW1PbWxmSVF0dGk5enNlY2M1b083Qlp3ekJwOCsvckJFS3FlNm0r?=
 =?utf-8?B?ZkF3R3NLR2I0S1VwMzkzUUg4ZktHbkd0bDFzQUFpYzBLWGxUSVBOT2tidlNr?=
 =?utf-8?B?WnJYa2oyUTBiODc4OTQ1N0JCSHRHWG9uN2ZHVWJSc1dYSzFwR3hMTWZrSnBY?=
 =?utf-8?B?eWRtKzRDczRPcFl3RW8xcnBwNkEySFRGeHVWM0xacFRhbnU3cnV6UXRCTWZj?=
 =?utf-8?B?K0JlSUh1SndHTVYxNVJqbDg2SXcvbjZWKzkwTmhBbHdNMEw0VzIzYzBPYTJT?=
 =?utf-8?B?L0NiYzdWakdoSG9WcmYxcnFFempQSkxiMks3NVZ2ZlhGeng3RjNzSCtYYXZD?=
 =?utf-8?B?ajJMUklReUtEbzBYWDlheFI1bGFrdXBNV0xWNHFMdFcxUU02N3AyeTVVYy9p?=
 =?utf-8?B?UlBmVFM5Vk81Y0RVQ3k2QUVmbFF5L09DeEQ1QVVZOFF2aU4ybEJxd1VSMzdM?=
 =?utf-8?B?K3hHOFlQTTFiaWkzTCtsbm1LL25nQ3huTUNSQ3g4MmFrWWhqeGdvNm1Fc1V0?=
 =?utf-8?B?cElqTjBvQkJ6T1VIcnBZY3dsRnRSSmpMTythdzlDb1pBMVpKRktBM0IwZWda?=
 =?utf-8?Q?AGn6uOExHgYutdkT/LOr93GPK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76cf1657-85e1-4ee0-0eaa-08daa199e5e7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 21:39:18.8976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DybJM5770QIckJIi6UgbeANIP5GnytgOgZ3FNSQM49jJ72oKSBLMVPm4xLbENQjaku4ARXPpD/MwDhWoT/VRwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


ALL:

       Recently some important PCI EP function patch already merged.  
Especially DWC EDMA support. 
       PCIe EDMA have nice feature, which can read/write all PCI host
memory regardless EP side PCI memory map windows size.
       Pci-epf-vntb.c also merged into mainline.  
       And part of vntb msi patch already merged. 
		https://lore.kernel.org/imx/86mtaj7hdw.wl-maz@kernel.org/T/#m35546867af07735c1070f596d653a2666f453c52

       Although msi can improve transfer latency,  the transfer speed
still quite slow because DMA have not supported yet. 

       I plan continue to improve transfer speed. But I find some
fundamental limitation at original framework, which can’t use EDMA 100% benefits. 
       After research some old thread: 
		https://lore.kernel.org/linux-pci/20200702082143.25259-1-kishon@ti.com/
		https://lore.kernel.org/linux-pci/9f8e596f-b601-7f97-a98a-111763f966d1@ti.com/T/
		Some RDMA document and https://github.com/ntrdma/ntrdma-ext

       I think the solution, which based on haotian wang will be best one. 

  ┌─────────────────────────────────┐   ┌──────────────┐
  │                                 │   │              │
  │                                 │   │              │
  │   VirtQueue             RX      │   │  VirtQueue   │
  │     TX                 ┌──┐     │   │    TX        │
  │  ┌─────────┐           │  │     │   │ ┌─────────┐  │
  │  │ SRC LEN ├─────┐  ┌──┤  │◄────┼───┼─┤ SRC LEN │  │
  │  ├─────────┤     │  │  │  │     │   │ ├─────────┤  │
  │  │         │     │  │  │  │     │   │ │         │  │
  │  ├─────────┤     │  │  │  │     │   │ ├─────────┤  │
  │  │         │     │  │  │  │     │   │ │         │  │
  │  └─────────┘     │  │  └──┘     │   │ └─────────┘  │
  │                  │  │           │   │              │
  │     RX       ┌───┼──┘   TX      │   │    RX        │
  │  ┌─────────┐ │   │     ┌──┐     │   │ ┌─────────┐  │
  │  │         │◄┘   └────►│  ├─────┼───┼─┤         │  │
  │  ├─────────┤           │  │     │   │ ├─────────┤  │
  │  │         │           │  │     │   │ │         │  │
  │  ├─────────┤           │  │     │   │ ├─────────┤  │
  │  │         │           │  │     │   │ │         │  │
  │  └─────────┘           │  │     │   │ └─────────┘  │
  │   virtio_net           └──┘     │   │ virtio_net   │
  │  Virtual PCI BUS   EDMA Queue   │   │              │
  ├─────────────────────────────────┤   │              │
  │  PCI EP Controller with eDMA    │   │  PCI Host    │
  └─────────────────────────────────┘   └──────────────┘


       Basic idea is
	1.	Both EP and host probe virtio_net driver
	2.	There are two queues,  one is EP side(EQ),  the other is Host side. 
	3.	EP side epf driver map Host side’s queue into EP’s space. , Called HQ.
	4.	One working thread 
	a.	pick one TX from EQ and RX from HQ, combine and generate EDMA request, and put into DMA TX queue.
	b.	Pick one RX from EQ and TX from HQ, combine and generate EDMA request, and put into DMA RX queue. 
	5.	EDMA done irq will mark related item in EP and HQ finished.

The whole transfer is zero copied and use DMA queue.

      RDMA have similar idea and more coding efforts. 
      I think Kishon Vijay Abraham I prefer use vhost,  but I don’t know how to build a queue at host side.
      NTB transfer just do one directory EDMA transfer (DMA write) because Read actually local memory
 to local memory.

      Any comments about overall solution?

best regards
Frank Li
