Return-Path: <linux-pci+bounces-6287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A53588A5AA2
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 21:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F18B1F23BFC
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 19:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C36156641;
	Mon, 15 Apr 2024 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WI74KUu0"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EA9156645;
	Mon, 15 Apr 2024 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209637; cv=fail; b=dhPKsvy5/bcJFhJDe5CpqDOsU9MgFEbS4KU/GsVdfKwQ3SzBpb/smnH/HJrj8PrLDyegKK6RGcTtjoYHU3e6ohn+oU7RTNF6OKFO2cr+pMeKuW+ah5Jm+/i4wAh5ohH0Lzk3xb4SHact9c1W1toEyQxg2JmeXjqo7eTqBCUxPxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209637; c=relaxed/simple;
	bh=4bifr+HB+ny4J7a2OHKQ19UFWKzmxq85d7V1umB39/0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=LQCLv/JemB2iWVR3n+5UIA3th12R1EGSL/pIqHxjrqzOhm8esQRgB20iEib8o8Eh8gIqKd0mSifMhNsExJ7WuqUjCM18DGqkeTGkKCe5hiOdLaALtvF6Q0BQ7on3yYc4uLc8BKg0JjjvuXCLIAHHrSF4OtpTb81Gw8IPFuG9YZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WI74KUu0; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVGO9atmLSfXhkJF23KS3AYo2cN+OcCcvV3wrbfyoU8s+MbZSfUyRdSHFmKo1bv5Oo0kBctsATyS8vhWg8QnmttVDv1Do/mjOBqKhvr4UsIoOt52/AA5OGxvXrwEDgarFNDY6j4kkicgOD8TE/mSvKpGmEUgmE29XqYlzJX2wmomG2qHyDklhzpvbDJSQ7iOF2V10TE/BCaa1eVPQ1mIBCZQ1G6aSadxlTCaGdhwx6VQlXDC0KqYo116gXVdIa2QgdBOtg3irWjE+IDVtJCa8NGH+NMRZM42hx0ZMnbDhJefpfVgJXIMUtJ9I8edUSM7dvU7fIYWD9y0nd+PXmN9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkVEr9PP8WBtHdaG52m1H2AFtD2Ve1Cw4auksLyuCfg=;
 b=hkkHVnsfxzE+bmycSGRgTrNXzOwlBDU7Ax4jrOlOSAziTkhC/lvoEVM7S7oQOAJDZtM3roHT60HRrI1mQ6zt6jtYeoMiBDGy99YvlwuX6FCiS/ozidUe0yYFcm8xoHJbZDwIrMOMH/qWql89/hKaV867aS7DLPjg+d9xgvyVyDSeCuLT0VDq4HLsiupwPnudRjXIONIvxIzS0m2r7ObsrFK7MZAmk/eAYpbiONTb7uVKB5ctFZDFGB3NygK0/6w1hy5p4OcuwPG68NEtQqzrWY2cUckRijP3s7ogWsFGEVJhSaYSTholaqckUt5jjGVkp+Hd6gj71SBVuv9Qlhk8Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkVEr9PP8WBtHdaG52m1H2AFtD2Ve1Cw4auksLyuCfg=;
 b=WI74KUu0wiyLgHD7wg43hM/MJYv2x6o2OSCzj/nfx9wU0BKwqKvcz6Kz6HbFtWGqdozG8hecX8OTSeUFWsQBbQ8iLkKpNR+UD1mSnCZvT4PLkFek+k2a5PK+esqb4NmjpYk7u2yoponCr2lOkfUvdC6hTQaifcouf8rGi8ldkno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10279.eurprd04.prod.outlook.com (2603:10a6:102:406::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Mon, 15 Apr
 2024 19:33:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 19:33:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 0/5] PCI: dwc: Add common pme_turn_off message by using
 outbound iATU
Date: Mon, 15 Apr 2024 15:33:24 -0400
Message-Id: <20240415-pme_msg-v6-0-56dad968ad3a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAWBHWYC/2XMy2rDMBCF4VcJWldFGt3srvoeJZSpZpRo4QtWM
 QnB714lG9l0eYb5/ocovGQu4uP0EAuvueRprMO/nUS84nhhmaluAQqs0kbJeeDvoVwkEVCnmfu
 u86J+zwunfHuVvs51X3P5nZb7K7zq5/V/Y9VSSXLwo5DIxRA/x9v8HqdBPAsrNAVKNwVV+eCDc
 pDYoz0qs1fQlKkqJcDkAipAOiq7U9o0ZatiwEiWAkIPR+WaMrpvylWFqU+JXUjW7NS2bX+Do3U
 vdAEAAA==
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
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713209628; l=5828;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4bifr+HB+ny4J7a2OHKQ19UFWKzmxq85d7V1umB39/0=;
 b=0udhBvFY/l2D0wAAs5hePxvesJw5Q+TlDE4K7wyMVJls9gGyoccAxr1lFbiObMFTBo8Q0Hy+I
 +gQ4hlW4gGkCAVVQ+jZhrDvuGPKc5MXovJgmiZlq33e+58i2z5OT+/j
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0102.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10279:EE_
X-MS-Office365-Filtering-Correlation-Id: b17a073d-98fc-4c5f-228c-08dc5d82fb13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LTdvMtwKoQQZDhe2hp5KbWvoe1l5jt8aGUiixOeId0swTnOsoioZtljhgThB5vSaGgv6FwZYQ+7Zh3qsgLIuA4Jc4JdCKuEUcm9BF1r5s+E5LzOfnFfqaH0RNFcwQbe3/kcUZLkVkcUAqDAXdVTPHPIM+Txnr3bx4+i+cTGTCw0ie/fbTPiprbFoOAxNMpeVUkOFrSceUKxwQnQOCARxPYK6vs+pRCJKifjnnaCUAE7/N2wjXQSEz+TWt7dWryk0gvudF1m2B49GdG9CaiVW/KrfYpG7l4sFYO54P6/t1detWstlljMxSyQMpE9OK7aze4WBwrI3Yd2WoPwM300Gen0uNMHN2c0JcyzB/Q7vrVf3MUKMHzqXrKuwLUtgjHieVJNnds6Z8ezaiSC60/7jnvvvYQH1X7EjRFWu23Z1jDxp4zK1oGQnwQpgAcqJjwUIXgzUsf8W/SmKxW0WyBoVtJ/wrH/E1Vsei9kalujJ8iHp8r7WeXJhaP9/ivumPoKb1glqBwRxskE5PC15YK6+nPajxnCeGcN2hLJYHc02VQlcbBX2Uo59a6DLYOYFb2sPHQH3brAhy2V/IRDNQ6VO19tN7nkXIJmJWRRb7sXNl7fMpBqR6mkjlEd5raclH37teAu7qsAnX9Q7ApMMNk4CsdHNyWdZaLypXJD/cawENHAi5SJgu/fz89SBEt6J5Kz0RhNRhjNlIi/WvDpiwhGI0/NyzDCsOZd+E6aggtF4mrc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(52116005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjIvZzZLSDB5ODl4bSttNTNOdEF5YjB1WXdMT1dON3JBYy9vUjZ5cHFSUWNU?=
 =?utf-8?B?NXY3TnZRdEFvSDhjdE9LelJKUys5emhlWkJYZm9BOFYwdmRUN2kyTGlFRi90?=
 =?utf-8?B?N2wrQ1p2a1V1SFY0ZnNwaXkzQlV0TmZiOWl2Uk4xSHl4Rmg1WWpvbjRoUjBZ?=
 =?utf-8?B?UkpNN1RPTkhJaHU2ZVZmUExGYmdaL1dJU1NHY3B2SEhiVENDVCsvWUVoSjVB?=
 =?utf-8?B?M1lsNFpkTzFjbExNRCtqZ3ZJcTc4VWhwRloyZExWaVRLVE1xajhHTnFyQjA2?=
 =?utf-8?B?WFk1WHNEZjIrcVNIWGZsWGtMbC9IcStTS2srMEJNb3c4RWhDcENCV1VNa3BV?=
 =?utf-8?B?bEtrR2k2UHRPVHJscUdSdERFQ0J2RUROT0JVcTJPcGhHcW1OcEx0UUV6ZWJt?=
 =?utf-8?B?TkswS0dEYUIyNmtha2xqT2tZRXNXcC9ncm1URFBpYXNWM0ZRS1VuSnEzSW04?=
 =?utf-8?B?VXkvYTdEN3NHTTFrWEJDTkVackpRZlZEbXVqRCs5NzJqbUhCeE9rWTgvN01N?=
 =?utf-8?B?blgvd1FxOTJZbzgzY01PTndBcWZkc2l1ZFkrSUNzYXVOem5ieDRZOUVuWStC?=
 =?utf-8?B?M240VWN1aXhJOU5CdGZYTFErWnJYc3BOc2FVT2hPOC9KT21jTGRndEJWZTNa?=
 =?utf-8?B?RlVnaUJZWFpuTHRVazRsL25aZkpIaTVPVm03ZFlVMStGTE5YQ2dJWmhXNmdG?=
 =?utf-8?B?OXBBcytCNU1DV2JaOG1HZFBSVXZHRlpFUEY0S1Jwa0xWUGZwa0M3ZXFQYUd6?=
 =?utf-8?B?Q1c5YW5JZW9zRnMwbGY3dFdZVnFBOVR3L255alFtOXo2TlVxRGtoeDgwZlJt?=
 =?utf-8?B?YjhJeGluUnh5Y05FOGlRWXB3QUVwRkZXc1QzdjFUbWZVR1AvcnJ4KzJvd1Vq?=
 =?utf-8?B?WGpqcXY4UzVRamV4Tm9mcDRJYm9sdk4zK280WmlBNHRaeGJPWU4zUW5zOW1q?=
 =?utf-8?B?ZDRCK2dMMGlndGV0UllsR1BvLzJiSG5hL2V6eEF5djYwUTR2TkFkc0ovSDBE?=
 =?utf-8?B?OXFGVzMyMEc5QVhleDIxdXFEbDg4SmZzbURRVkdnOXlUaEVjRktZMGVHWFFY?=
 =?utf-8?B?cENJbXUvNFJtV1VpbnZsNWhQQ3h0bElITHEwSk1OTk5GZUJscVprZkZVOGE5?=
 =?utf-8?B?djNKUyszbUd0NWgvR0p3Umt6cU9PV2g3N1orajNnK3gxdDM4bmx2My9BWTZa?=
 =?utf-8?B?cEgvR0llemhpOUd5TW93cEpmOTBpdkFXbDlQZzZXcXRnN0RwUWxBK2JlUU0y?=
 =?utf-8?B?emVldjFWNW9TZlhCaGNPZjNYZHp6QzhkNm5UUjNsNVpBT2N5UWJCdFhWSjRE?=
 =?utf-8?B?Q01kelJMazNSYTB0TEhIYk1YdDZiVFI4M2F4V213UjRiV2szQmU3YjBjQklt?=
 =?utf-8?B?VUlrMUU2N2k1aVpha0oyRDhNK2VGV1NwVGpvTTVWTWZSbDBEalFBK2RSMjdy?=
 =?utf-8?B?b1puQVBBRmFhWkloMUFZaHFob3ZWMTgxWXR1TlZ4c0JsY09JeGZKenhGaGVq?=
 =?utf-8?B?MUNDOXpxcXplM2E0TDN3TUV6SU5XU25vU3NieFZqYmh3T25CdGFCRkFpZG1T?=
 =?utf-8?B?MHpmWFlVa1RDcW9oQkVSL2IzS2pkN2xqLytjbXVRQWp1cjJmUng0ejg3TWFy?=
 =?utf-8?B?UmI1eDhCSWoyeUE4RU1YQXpCVGhvUzFmWG1CMTZWbmZPdkxDNHRyUzd2VEF1?=
 =?utf-8?B?RWtqSVJ0K3ZQUW1GdThyM3FOWm5EeXBacnV3RXNLSE1vS3pNQ2N4YUV1NkJ4?=
 =?utf-8?B?QUJKMjU1ZFZYN1d1UDhwUFhYdkM0dFhkYXVockc0QzJHREx4cnJpY2p4RlNr?=
 =?utf-8?B?OXpsbWpXT3M1azgxVkc2TjM1TUdGRjlkcU5nZjJZYjFTUmZ5T2NxY3RueCsy?=
 =?utf-8?B?NU9BZjZaK09ucE41YlNDQTQwTjRhbUFCYXJTcmxKb3VPRjFWbG9lbXdRMG4z?=
 =?utf-8?B?NGJqcTR1U0hZY2g0cllXZEZpdngwdjAvTjdXajVkeFhMNkpmN1BLakJ2cVJU?=
 =?utf-8?B?aEJvYjRDN3Z2YnlqRnB5d0kzWVpYaXZDaFc0Qk1QSy9ZZk5tWW1MYlRMeFph?=
 =?utf-8?B?RmY0MlBHZXdxZ1RKNWtqMTZ1NEQxTHRLSnR2cy9GWVFmajZPTmt3ZkRQcDJS?=
 =?utf-8?Q?lHyk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17a073d-98fc-4c5f-228c-08dc5d82fb13
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:33:52.0186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lusVt2LRI7hmyF2yhqslOR19hrvTfQmaE4/SbNtJ61LpYM6XRdVOLn91Ccn6nbr0dmWAdFAmizKcXDg8ouieww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10279

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
Changes in v6:
- Move PCIE_MSG_CODE_PME_TURN_OFF ahead before INTx to keep the codes
sorted.
- Added reason why not alloc_resesource in commit messag.
- Change title PCI: dwc: Add generic MSG TLP support for sending
PME_Turn_Off when system suspend.
- Rework commit message
  "Instead of relying on the vendor specific implementations to send the
PME_Turn_Off message, let's introduce a generic way of sending the message using
the MSG TLP.

This is achieved by reserving a region for MSG TLP of size 'pci->region_align',
at the end of the first IORESOURCE_MEM window of the host bridge. And then
sending the PME_Turn_Off message during system suspend with the help of iATU.

It should be noted that this generic implementation is optional for the glue
drivers and can be overridden by a custom 'pme_turn_off' callback.

- using devm_request_resource()
- using mani's suggest comments

	/*
	 * Allocate the resource for MSG TLP before programming the iATU
	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
	 * on the value of 'region_align', this has to be done after
	 * dw_pcie_iatu_detect().
	 */

- Add comments, about use_atu_msg, need glue driver set it.

- m -> mem in dw_pcie_pme_turn_off()

- remove redundant check() if (!atu.size) in dw_pcie_pme_turn_off().

- The reason can't adjust windows->end
This windows already reported to pci system before this function. It is
not good to modify window-res-end. It just add child resource like below.

windows is root resource, which will create may child when call
request_resource.
          bridge -> windows
		child1 -> msg
		child2 -> pci ep1
		child3 -> pci_ep2.
		...

Although you see whole bridge window, 'msg' already used and put under root
resource,  new pci devices will never use 'msg' resource. 

If change windows->res->end here, I worry about it may broken resource
tree.

Detail below thread:

- Link to v5: https://lore.kernel.org/r/20240319-pme_msg-v5-0-af9ffe57f432@nxp.com

Changes in v5:
- Default disable allocate TLP message memory windows. If driver need use
this feature, need set use_atu_msg = true before call dw_host_init().

- Link to v4: https://lore.kernel.org/r/20240213-pme_msg-v4-0-e2acd4d7a292@nxp.com

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
      PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off when system suspend

Yoshihiro Shimoda (3):
      PCI: Add INTx Mechanism Messages macros
      PCI: dwc: Consolidate args of dw_pcie_prog_outbound_atu() into a structure
      PCI: dwc: Add outbound MSG TLPs support

 drivers/pci/controller/dwc/pcie-designware-ep.c   |  21 ++--
 drivers/pci/controller/dwc/pcie-designware-host.c | 146 +++++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.c      |  54 ++++----
 drivers/pci/controller/dwc/pcie-designware.h      |  22 +++-
 drivers/pci/pci.h                                 |  20 +++
 5 files changed, 199 insertions(+), 64 deletions(-)
---
base-commit: ef6a734484e939cf67bc41c45bc936a78ea210f0
change-id: 20240130-pme_msg-dd2d81ee9886

Best regards,
---
Frank Li <Frank.Li@nxp.com>


