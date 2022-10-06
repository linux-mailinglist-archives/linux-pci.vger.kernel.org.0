Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5A65F64FE
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 13:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiJFLM7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 07:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiJFLM6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 07:12:58 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2100.outbound.protection.outlook.com [40.107.22.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E0A10B7;
        Thu,  6 Oct 2022 04:12:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwVnzbOUMre/HYxT3rbKONP16ARHOEi3Pd3sOgF40iHGcoPW50L3uFNnJFTzN3yVlq5YSVgmaOCHKKWYlnMrMh7FtGmeWfxpZAKpiiSQTgV9ax8jsuL90TwKnG3wl7WL9YIRR1yXrhA7ZwSdUy3xr/qahmbGzkjkxb6Bq9UAYKZr/gcWcF/biCSq/a0yQ6XIGPG6iSdeGrOhbpclKLdro1ecM/wiIeYHOBU65t6mc4VzHVacp16VRfm4B+Do41VlP9ZElSBSpLabrpbllR8Eoa8DTDpt4Z/hZEJHQ2PL8oTgSIpY6ZFqSxgmlFKCMj2l7D217Gc0KVN1aLHjtAV10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1VJV5aAVPmlaoHBDgViAOB1KtaZR4hu5YycipLWMTM=;
 b=RzRomFZpbnMdhbZQa0DPIXRdQs4CE6RZlQkxOe9KWmPRpfLJ48KAEKKqJ1jbzTYA5kCVutB50ZnOwmtfqK0QJ0O0fVOuA/DArT9wDj+x6zA+GCu6FwomnyqMnuEpf4JOU6M7kYD3Be+ajJh6b1vYx7jjaGmLxNLEQ+/F09xeQ50Yphu3/kzMsiVKFz4GnKEZ1lnqoO3oCpqg1SXA2IX4GLSMJ89CDNOAqml0xwTH0M9KwzbqNufc33qwZaNxx4FSo4t+iE/W3c7xDkaR7KJsLvfcTaJSG1hd302HD9h5uj4YsDU/B8Xq5aRX2xVWzsn6B/FFBbh3FJUP5DDMaA6MpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1VJV5aAVPmlaoHBDgViAOB1KtaZR4hu5YycipLWMTM=;
 b=eLiSZYsiJ/2BpF+Kf1VjQbOueQsXlRNxS2WlstyXWwlNbJSjpqbphWuTUggipcnLFrYAksMDewmMsXvr5ct0EJ2RC7Bqag5V3BBCKgiu6zRv/pclOAnkD1nV+DsyvpId7NOXPO0saD/iA2kBIm5PC5YYuJSru1sEk7IXLx8KnhE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DU0P190MB1929.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:3be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 11:12:54 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::eb13:ec7c:e027:8404]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::eb13:ec7c:e027:8404%3]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 11:12:54 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Yuval Shaia <yshaia@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH 0/2] PCI: armada8k: Add support for AC5 SoC
Date:   Thu,  6 Oct 2022 14:11:08 +0300
Message-Id: <20221006111110.8574-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0243.eurprd06.prod.outlook.com
 (2603:10a6:20b:45f::6) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|DU0P190MB1929:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a783b5c-dc56-4723-9fa8-08daa78bb6fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bud1891KL4MMsMOVoDujGXbP/NrFu7WAdXrDMuMUlG5za9v/+IfD4yyom6CU1gZgH6DjhB9jazRZctyO/6Q+WPqg56MkC9qVQBNKBr3gFzid47J3qjxf+cFn8SIijo1taEFTct8vwxsRKYOUuOm6goYpOjetPWyxGLD60JPJHAa6XpKvae7DcWjXo4YGs5OZGBJPZjXOIls+dTGYN1I0czBk10SEmQ/oNPNqjSnU6HyCFKgU8GijgLl8zC0DhMmt3rnSZ23eBVF2qfnN8ytSSY9VCWktKhh4qx1xnTkH/un9O8fln+jefBO6a/QNcRRiy1pKSq6dajpmUERjGhL01ZrMMYDQiP/barbOTqin1tESfNzCKc910YXEC4F5bQnRZ3iN4n+OOcAkFh+iG2j1vn7hwklChnlbU3qWWPKGqjA/vPOxg34yH5t7jajh+YwNspLSf9KB6SRyhQhdOoK7eUB3XyMT9bdIOsLs7vLcuGfWZ6hHFaO2/6crNYsXGac94574Qx51Pl6OTXFA+kWzXHS1BPkKRgqGf+B3SMWjFB+w1uFKn+WMILmRybdPok9PPP/d4tmB7JqmKLEiFdybYg3jWuRtqJ8x+0ZvS7P/24OySIaMuE/tVcAJ7DpDilp1E8I3tCrOg91zA4chAiGP8WD7jZMGCxA0JGVZOtr4eDSw6PV3rbyAUD2yHQU7WsJgUNnYjPhIWVP4qTLOGhqNw7j06/jsnlNTTJMcJYq+dzzN1n4DyhEPMeCmWaA8t4+BuhBoE19jxB8c6bNjlk6Wl1J+UqszrVR32+47YEjTBEY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(346002)(39840400004)(136003)(451199015)(86362001)(478600001)(110136005)(4326008)(8676002)(44832011)(41300700001)(66476007)(66556008)(6666004)(107886003)(316002)(54906003)(38350700002)(52116002)(83380400001)(36756003)(38100700002)(6486002)(7416002)(6512007)(5660300002)(66946007)(6506007)(8936002)(26005)(2906002)(2616005)(186003)(1076003)(4744005)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A97CObxgkFAmUibHHaIqH8cC/v2tZ+/hqSybbgM1I94exX9g1ScnL+bijcZI?=
 =?us-ascii?Q?hSaxyZXGsjBWsTMFONsskleETI+Gago3/YpMy0aqxsrOyhqJfIgS1Grt8xPy?=
 =?us-ascii?Q?AZD1pYv6RNvwfZe2nJRcvGfrs4UJgiAozEfs8ARJxuDIHcNU9gETTxOIRZ+q?=
 =?us-ascii?Q?rZZbWJXxDZJI46ArSPqBt1Y6Ubw+7F6Oqg5CdNEUrSwuoywV1rC5MbtLThGC?=
 =?us-ascii?Q?iuuav8d5eNNyerIVxNGZfU1/klGvhSDl4SmpQgbnAnFh8wx5FBVl1UmY/Zva?=
 =?us-ascii?Q?E+Ah+jGThzvt3xYLLqP7fOTZXCc1zB3c8vUTeGiTB/AFUci8EchMU0A4BQry?=
 =?us-ascii?Q?2yEp1iU6S6DEvvc7kOhcS/vFCcXez+cZlZJnr0RTMABROAcJHEOXEguP6aBO?=
 =?us-ascii?Q?FbZmOcvoP0lSJcRTyJ4Sv83DFtWQ9z/COVOTWDl0ZqsaUKqilK4LZdwjzQLT?=
 =?us-ascii?Q?hyu1PB+fKIvcJkWw20+cwhss5nbEmeEjoas8qOHugb8cTEUP6hUXMdJpUK7Y?=
 =?us-ascii?Q?dODRUcZj43/2M2o+aI9/oqoDLyzCclEVZsz2HDkNuUZYLyDPbKdRM2AGMIGj?=
 =?us-ascii?Q?LZZOmcIDi0dX3Ky9ijjFq1YwsCfs1Q6y/1cN1mV4AG5m680JiFSvll5VSeIh?=
 =?us-ascii?Q?pXdrFvHVxDx0bj0YAqD4oSXMYkQR0ona7f97Yp+7bhBBXsMuM+4cdM2yQgSm?=
 =?us-ascii?Q?HtbnCYRL69v2ymGYSy0SWftsrNz+TpmC4pcmJ931DIJspG/oyphWNaDVB065?=
 =?us-ascii?Q?7wws2Xn0sJpCeJ/fDkW8sDXqDKsQzjitivEVStsGmHadUymMMd07haEpAE6a?=
 =?us-ascii?Q?kh+cwWodQluzPzOjWnAOsSzvZ6qWH61DhD4P+Ola0AEBkVMH+JVJem6y7/0Z?=
 =?us-ascii?Q?+ww3emMEhgWtO1AhwM6QlvRLiOcaOVU23u3xyFY/Jc8MdrEq4vX7XYsOFJqV?=
 =?us-ascii?Q?zfISRPX1o5BdhmQ0DXjQ45dM5VjapZW/7Q0E5yDqn5MAz3g0UR7au0fQWY67?=
 =?us-ascii?Q?b8DM7Mf/sLiHfQrw8HSPZJJ0KP8Et+udbjuT0lqLL3XeACpbQiggmXIwYxAn?=
 =?us-ascii?Q?PAgacEhjJjOS8qSvXC8jGSId/McmgiE5DIxMbMtpZcvoMfztcxnoTP5sbu1u?=
 =?us-ascii?Q?ejlAVA3GK79Qn8pbfq+IndYZpGQr8xSb9pLuRYABYTCEWAZTCA8GMdGL9Ion?=
 =?us-ascii?Q?T1ypPum23N1yj9zKLzzMMbMNeZW4LnY8FZ51drUzqILw+jYLc6/vV6EZV6Ax?=
 =?us-ascii?Q?bX+7+Jh64jDeJpPXQOSRDplkKscUQS88KG6q1e/TS4Pzsg8k0tkpc4YuCZYT?=
 =?us-ascii?Q?8eonvt1MnbEOT/4OS6VjnAoVwfLOVzRRIY0jRHYAAO/ZSz1ygg3mbFBW3tGy?=
 =?us-ascii?Q?a5Hg13HV8qm1JQTskikpGQznrP4PVISIJk0FODp32EilDfJaDy1iq8H4HSGs?=
 =?us-ascii?Q?s0kHSOJLH/pN2QV7Ec4etEm/SDlsb1TsiC5dtNdpitO4iiJ9aqPpqkL3/Zj/?=
 =?us-ascii?Q?ZiyUQu21KIbm6m5PMZ+/frSQ4OdKHGtuu+aBSH1jwHxoKFOJbO1Kw80Iv+u0?=
 =?us-ascii?Q?4bz1FHd7CaUc/Fl/rawXvRMai0gTVVgwpf7AP/oQscoKC/vAEeM55sXqxX+I?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a783b5c-dc56-4723-9fa8-08daa78bb6fa
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 11:12:54.0079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UBXnANdXCmVpflhb56c4cA1G+7tB1Nqy23XxxLxSb8ooy+Atdm8WsiHWyHzVEtZxk1XoXr2umK3l14qcRNPueHxnqm9Y4Qo6r3DJjgAroY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB1929
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

Yuval Shaia (1):
  PCI: armada8k: Add MSI support for AC5 SoC

raza (1):
  PCI: armada8k: Add AC5 SoC support

 drivers/pci/controller/dwc/pcie-armada8k.c | 144 +++++++++++++++++----
 1 file changed, 119 insertions(+), 25 deletions(-)

-- 
2.17.1

