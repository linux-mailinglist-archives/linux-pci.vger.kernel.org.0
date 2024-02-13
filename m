Return-Path: <linux-pci+bounces-3413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099CE853D97
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 22:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB10F283D5D
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 21:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044CC61683;
	Tue, 13 Feb 2024 21:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mTcM80r4"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E58D29B;
	Tue, 13 Feb 2024 21:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861076; cv=fail; b=sQv4nrc7PrVemawnc7FRNQCaT+8fj7tSBrNQxPdNr8dDTThNGi+XXPAScKcbUG8+zxmdilGhozdzCNKAl7eSIuDJAafOmW28d8bBirHYG1ThuF2k7mkBRmp0bb56tijSYLDg56BwL7J9eSRu5RM1gP/iZEWijyzUBhkM7OmZTR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861076; c=relaxed/simple;
	bh=AyyJMp2+Qcrn3pGor6mbyj9sliBRvWPHI5MD/RL7Wdc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=m6PxHyMQdkBFexJ7IlrEX9J3MmES2b/Atrwq1tgZP9shwQEEl4J9H0iOdGhOs3nRufYMaktaV2Qhcxfn6QSbGc75XwoP4opAFPfVaRtNNE7qYwlnWqajKkSV0yHNLCIvMaQwEGQwa34XH8YpLkQRyreLcP2AwC1vq0aT69xG2nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mTcM80r4; arc=fail smtp.client-ip=40.107.8.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+suZKBuryl87zsHs4XZPNtCD9MV74NqrTGBVfQo18r6rH/SjtN7TLu5IzDqa1HGfrHaA6ssj7uVQBbod/3a+4MrFSBvPW/u8oLyzbp2HXNDKC6MkwfNc2YQ4LLZyVMgAdY7/EH83pjwQV8lePdGBI0WrDq39jSVRgMt3rmN0fGoXxRdWJ1PjRxgnkqfaVf03Pp/LU3X2Oieqc+JfNiEJpsNGXuJQ3GMKEqOYG1oNMTAf6/WqM7gLxSK89NL1jsATtnp364fEkm3WDeSEptY9EgsDthdO9dzWu8eOhrfL6R8WXyevYmhip05Vv0QLymlloUuOGD6g7hMxtfS+EAyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLY0mjxBohsr00gjCctd9l2dOKJPBvUHKCM47QaKh5Q=;
 b=TrJ1U5XPIxuOFXILj4RE7p7y1KNWRiDGTDlrCSU1jO1URhFuzJqAv37Hu+hvFTbaFNrZS62y7Rop2IERPklgRiaCHnmG+4Om4Bm78JCHkfd9+pI6DDRIzzMS/flBWe1jEzw11qw7hAglOjOsXG1VxaIXS46kFXicNOGcBGPbMR1IwkSaBw0UsB8N64fpd4QS8/r3qlcktcDU2KcZf3xoCAmAx2CXu0+Ds6zKIf1RmwZaOgyeK/S4VjjxdcdE4fjVYqkuXiuwB9Gwoo+OnQYbAeDt8gSXLdQd3ioRK76Dg7ZyCodOXQyDnwl4C0VA/65tTRh2MrMXqPKDnAQVY0irDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLY0mjxBohsr00gjCctd9l2dOKJPBvUHKCM47QaKh5Q=;
 b=mTcM80r4/RAilCUTHbfq6uDNgaq3dnSz0LvxWsGRwIVxVAvfSIx6Q1W1qG4lh5z8tV4gykuAreEp49003R/VxbinIUJhwGbbW9KvNxLhmrhN2iZsTTR4fceV01E/DxfuSdSbj6fTcg1/abXC1tSk+FgHY2cffBr8fUS/GprCq28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8837.eurprd04.prod.outlook.com (2603:10a6:10:2e0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.44; Tue, 13 Feb
 2024 21:51:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7270.025; Tue, 13 Feb 2024
 21:51:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 0/5] PCI: dwc: Add common pme_turn_off message by using
 outbound iATU
Date: Tue, 13 Feb 2024 16:50:21 -0500
Message-Id: <20240213-pme_msg-v4-0-e2acd4d7a292@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB3ky2UC/2XMTQ7CIBCG4asY1mJgWqC68h7GGIShZdGfgCE1T
 e8u7QaNy28yz7uQiMFjJJfDQgImH/045FEfD8R0emiReps3AQY14xWjU4+PPrbUWrANRzw3jST
 5ewro/LyXbve8Ox9fY3jv4cS3638jccqoFfBk2lphlLkO83QyY0+2QoKigPGiICuppGICHEpd/
 6rqW0FRVVbOgXZCaQbaFrWu6wd+bEGhCAEAAA==
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Serge Semin <fancer.lancer@gmail.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707861066; l=3521;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=AyyJMp2+Qcrn3pGor6mbyj9sliBRvWPHI5MD/RL7Wdc=;
 b=iZ8VyJbTRi46TWI9JpwSDS13CF2/LN7wY2j044YmJEIesdYvgGmQxb9t8dE41Sp7G+YyboF32
 p2fcGtHko+nCyfuPthOQajfvx+waNf/01aKWm4/LT3LzCW8mmzZGc6k
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0211.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: 77502cbf-c3dd-4119-c22c-08dc2cdde444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BNuMlZsL9ma0jZouMmn+Ijp4QgPm5GiCY51jX7lIG6X+m+WEh0WuV8yKGhNIB15rdr/Bceky0/IHgqWVh6FnIvheZm21bU1LUy7/4YuiY28k0bTZixvl1+Z0EC0kxP3F2R68bm2+1y0b9xDv3E0YQWcT6Qg4TWOJXPx16/KYhfY6IEGSJ3PZs3cHHycHPxobTLpSWf+U97Bb4a2BnxNphT/+Ask13H6EcNJpcQR046ckCfnW35bt3OzITyzkQeN/sZJ6XwBRUl8yqmtr5ny+vJLGX5fjwSi0WO7IwSzY1O5kmDl5mXrUEcYYxFIHPhNK8wRwYsMNpUQxSKl2RUoaxXtS/Stnft6OG7l9OLpd76hx0hoHB0q9yKuA+G0d6cjMoF7v2AWiyV6OsQrMnxeNOIZuHJP6OI7KUXbPTHHJXIlSAVa27BoMuxJFN+QU2UoC1wtK3RW/elcKrStGWhSg/6K4hz2S1TKwU78fQe2RNZuk7heuGHkC54U9X7hcxL1dv8YsYH6o6Yf6dEL9D2Zq/rwt/8W7emBybpUNErXjBmB5qENVQKGpo9ozoK9EveLRhLBDcDDcT+HOsGqFunUdExKUmNzOubgGaaE2Zu6lmPeJFP9ffWNmMZpokGwbjqF/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(136003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(83380400001)(2616005)(6486002)(478600001)(966005)(6512007)(6506007)(52116002)(7416002)(26005)(316002)(54906003)(110136005)(66946007)(6666004)(66556008)(66476007)(8676002)(4326008)(38350700005)(8936002)(5660300002)(15650500001)(2906002)(36756003)(921011)(86362001)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFVFcDdrU1BvSzVaaEVqT2ZvcFcwczVHUlJPUHRHZVZNVEVQeW1XMWRwZzNN?=
 =?utf-8?B?MjdUZE4vdXVjWXVjaitrMVY5YWF4bzdBYTFOTjIxRmN3NGQrUFMvSG5XWFZl?=
 =?utf-8?B?MkxFOFNFRzJuTHM0ZVZFVkRPK2lGUE5JK0VMMGwrcjZTbUNnSWg5b1dUcThQ?=
 =?utf-8?B?NFVPYWhkSW5rZWxGalhWYzFDQlZtc3lTR05nR3c5M1pvdnNmY3dBckRBZGRB?=
 =?utf-8?B?VUI3WDB4a25ySWc2M0RyQm1lOXhZdkoycGtNNWRSSU1OL1FycFBDTHlPV2J4?=
 =?utf-8?B?K0lvTUZtK3FyaTloOE02eUg4UVl3ZFNmTGVxZ2syNVVWRldiNEU5Q1pndS9Y?=
 =?utf-8?B?dmJOWlZWdEhySEIybXhZRklIU2dKdzdNYUxlVmt2NlFNQWlKMnBuUGdkWXVH?=
 =?utf-8?B?OThhQXI2K2k4cExDek1TbGhjdjBKUDAzN1lmSG5HSjFNalFrVXlEbTFiK1Zs?=
 =?utf-8?B?VTJ2SWE4Y2dUSHF4ZkU3UGJMVWtTbzJxcytvcmtkeHd1dnFVYkl1UXVzdzZt?=
 =?utf-8?B?UUZKdVZtZUQyQ3ZsSEFQbVJRMVJBSFNUYUhCY3dXUERKcXkyenVzaVpmbDJp?=
 =?utf-8?B?aHhiYkM4K1pDdlBCT0dwdlVWRzdDM3pwN1grZTBVZnBjRFMvZ2dlRk9OQzA4?=
 =?utf-8?B?S1Qxc2ZFc3dtbHdWT0ZXNXNXQWU3RUExWFFyN1kvRXluY2VleWM4cDF0T01N?=
 =?utf-8?B?Z3RNWEhXTXJOcVBvbkFHa3FFWEF4M1lHcTdOdGU0eTJUdUZoUnQ5dlRvUnFu?=
 =?utf-8?B?VFNSdFhSOU5rT2R6SzM1cExXZkRncnM2d1dtUkFCbmI5aHhMV0IzZjNwbit5?=
 =?utf-8?B?MkhRQmo2TkcyUkNmNHp1NGQ1dzF0TXYxSDJ3dE5zZ3NGVXg4WHFQSjZsSTR4?=
 =?utf-8?B?Slk0UW1xNUNReHVreDFCYzM1REVhb3ZwemJGOHNzMkJ5UlloUkQxVXFrbWdD?=
 =?utf-8?B?THRkMTQ1eFhlZHcvaTRTTDQzMnYvaXVGSFNpY0JXNlhJeHdDNUt0NlVpb1ZG?=
 =?utf-8?B?YlJYdjI4TmU3WDZEREhGeU5sVFlzei8rbkMrOUpZZzRiaUtkRlZ3blpWbElh?=
 =?utf-8?B?dmJBQndGR0ZETlU2dEl0UEx6QXZkYURHNXRWcVE0bGRjSHZ4MENVSi8ya2RP?=
 =?utf-8?B?Nk5BejFWeHRuUkg1MXNxS1lVTkRWS3JEQ1kwNmZ0cEIxS3JUNGk5VjEvTVdZ?=
 =?utf-8?B?VVV1VngxVXFqUmVOdFVKby9OekVUYmpoR254enBhSVdKSHlYZnlaNjZBWmc2?=
 =?utf-8?B?bHBNeDhzaDZaZk9QOXhpNDFuRlV3cVByWklhNysyUTArWkhLUDNaaGJxVG5Z?=
 =?utf-8?B?aC9MRjY1MnFBeWNrejFmRjRrVVhVeElJVER1OWVzSHdnY2s3NDloN1FYUGF0?=
 =?utf-8?B?WXBHNVdkQWwxWDBvVnE0bklVdG9BWGZrVzBBOHYrZ3hrMnhhSVVYcDRiRDVR?=
 =?utf-8?B?SmtLb0lkOEY5bWtuU050VHlrQm14Ukx6YXBMV1R2MXZ1VjE1ZXk2aE5PdlhV?=
 =?utf-8?B?OGRveWk1dUd0SENNK08xZGVvODlKQUdEM3NDYXk4V3RBU2dtOVlxcHZwVDRP?=
 =?utf-8?B?cmVsbUgvNTZQYjdTeS80b2VlZlpkVFhKQWFVZ1ZrSXBybUgzeFVmb3BmbXZJ?=
 =?utf-8?B?Y2YzS2RyS0VPdW9kUG9tS205MENEeWc5V04vQ2VjV0R6Nlc1SWpVZHBzd2J2?=
 =?utf-8?B?Mkp2dmNWT1ZkTFM4NnE4dEtkYWtnZ2gxdlZiblVleVk5UzIybndXWXY1WnA0?=
 =?utf-8?B?OURnazBoeU13Y3RzbEZveFhOcVN5Z2laMXFkWXRQOFd6K3RMbTFPU0lNTHhl?=
 =?utf-8?B?N2JGb01mVDRKdjNuYTdzaGhPd0lKckN0OG5rT1ZCVlM3QnE3eGI1SzZsd2p1?=
 =?utf-8?B?LzBDb1N3QlFmTkVITE5vTzRuaHZKUWx0OGlBYXpaaGFuUXNZdDRVeUFERzlF?=
 =?utf-8?B?cStmU1d6NXFoams1T1RGNnlwcEEvRHB5aEZWcXRrcHFaaWJ3TUZjdXoweHZm?=
 =?utf-8?B?QTY1T0Q4eTB6dFIyTndxdG56RVNvTnlDVWdrRHdHSXRXMTBSVmJLcFc3ZkJs?=
 =?utf-8?B?RTdIOGlKTlFqb010Y3lDaGpodHRoaEMwWTlleGlwbEpHQXJsS0dWWS9JY1J5?=
 =?utf-8?Q?wpaJ36kLiP/xD1ST5u2d0UaUP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77502cbf-c3dd-4119-c22c-08dc2cdde444
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 21:51:10.9900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3O839UJa/5Fml9DHV6qojzQeWlMfcrrid91c1iNmHn3MbHfnBSRJyxWReoQZrHtbyLBQeTA6VaoiVzfJJr+v+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8837

Involve an new and common mathod to send pme_turn_off() message. Previously
pme_turn_off() implement by platform related special register to trigge    
it.                                                                        
                                                                           
But Yoshihiro give good idea by using iATU to send out message. Previously 
Yoshihiro provide patches to raise INTx message by dummy write to outbound 
iATU.                                                                      
                                                                           
Use similar mathod to send out pme_turn_off message.                       
                                                                           
Previous two patches is picked from Yoshihiro' big patch serialise.        
 PCI: dwc: Change arguments of dw_pcie_prog_outbound_atu()                 
 PCI: Add INTx Mechanism Messages macros                                   
                                                                           
PCI: Add PME_TURN_OFF message macro                                        
dt-bindings: PCI: dwc: Add 'msg" register region, Add "msg" region to use  
to map PCI msg.                                                            
                                                                           
PCI: dwc: Add common pme_turn_off message method                           
Using common pme_turn_off() message if platform have not define their.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4:
- Remove dt-binding patch. Needn't change any dts file and binding doc.
  Reserve a region at end of first IORESOURCE_MEM window by call
  request_resource(). So PCIe stack will not use this reserve region to any
PCIe devices.
  I tested it by reserve at begin of IORESOURCE_MEM window. PCIe stack
will skip it as expection.

  Fixed a issue, forget set iATU index when sent PME_turn_off.

- Link to v3: https://lore.kernel.org/r/20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com

Changes in v3:
- fix 'MSG"
- Add pcie spec ref in head file
- using function name dw_pci_pme_turn_off()
- Using PCIE_ prefix macro
- Link to v2: https://lore.kernel.org/r/20240201-pme_msg-v2-0-6767052fe6a4@nxp.com

Changes in v2:
  - Add my sign off at PCI: dwc: Add outbound MSG TLPs support
  - Add Bjorn review tag at  Add INTx Mechanism Messages macros
  - using PME_Turn_Off match PCIe spec
  - ref to pcie spec v6.1
  - using section number.

- Link to v1: https://lore.kernel.org/r/20240130-pme_msg-v1-0-d52b0add5c7c@nxp.com

---
Frank Li (2):
      PCI: Add PCIE_MSG_CODE_PME_TURN_OFF message macro
      PCI: dwc: Add common send PME_Turn_Off message method

Yoshihiro Shimoda (3):
      PCI: Add INTx Mechanism Messages macros
      PCI: dwc: Consolidate args of dw_pcie_prog_outbound_atu() into a structure
      PCI: dwc: Add outbound MSG TLPs support

 drivers/pci/controller/dwc/pcie-designware-ep.c   |  21 ++--
 drivers/pci/controller/dwc/pcie-designware-host.c | 145 +++++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.c      |  54 ++++----
 drivers/pci/controller/dwc/pcie-designware.h      |  21 +++-
 drivers/pci/pci.h                                 |  20 +++
 5 files changed, 197 insertions(+), 64 deletions(-)
---
base-commit: e08fc59eee9991afa467d406d684d46d543299a9
change-id: 20240130-pme_msg-dd2d81ee9886

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>


