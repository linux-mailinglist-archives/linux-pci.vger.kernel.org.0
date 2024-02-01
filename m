Return-Path: <linux-pci+bounces-2939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B73B845CC6
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 17:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85E01F2CDF1
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 16:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492D277A06;
	Thu,  1 Feb 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V3NPFSZI"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2088.outbound.protection.outlook.com [40.107.104.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D65E779E2;
	Thu,  1 Feb 2024 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804029; cv=fail; b=nx+VmDCYtNkp4StdXFDF61XCrbzY5u+ju2hnz5/7ypFCqckB2zjAJ90bEmx5iiRQg8XCdylc65vK4lrN+TSHG3lg1rxzL4zfXtmlwmMugHdocf6fFShI4akxr+cqdxTR0Q5Xmdgtj5FZYGLXFJuGjJabpk/w/GROUmUs4N8p1To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804029; c=relaxed/simple;
	bh=l26KsReRhgM2C7kbGDUQzugdouvzriphT23lNWx0xPI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=FNAPC5TqeszrDJ96tWepYgZ3BV63DsAfSuwBJUKvMbpl6stlquXVc9kT/lRBnKLKf44SCImV9z07zIaK/4w+FT+wZcA13M52VkR8vd8WWdtdBISILU3J50KIB185ZANyjdRvPNC27uG1IISi5RW75xU9nqZXD1mkJmAilIJs5Ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=V3NPFSZI; arc=fail smtp.client-ip=40.107.104.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSD+eekJYQAdU2xpd9Kvcpgev9Kmku3aNsCHqtK6jaNt+pmTLn4nYouAcRJLwsmCVvSaSqOPb5J/TOrcPVaTXeHGVmPfiW8S0tyCY3K6//kM2Ab7PhiOIckdzDj9tdO2z1lWEK79yMSy68Qsyu94gNz1Y+fCaynHdpGK5CmDK/5KIoulttpiVXi1XhQ72nLbGT4G+stvhfn/aFOpwQnt/0Y7ndfPoMHrVA7Y8/HM7QSy8Z6o/JmWYmi73VKCYzaueuB3ZdCv9Q95p000VUKBxgdrFPG1VDPXGZ0nr35S/eW0ppsVsoX40bQt9NO7jASZwDlQoZs/AifcXdP/0kj1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tekF0dzNY3P4bRczl6CIJryxj96n+dq2Y/qjnOHeBqM=;
 b=hEKSPXX+V6spxBAAtTxsSoJwRBFIJ1ZZKzqf0j3D1LV7RwewMFDAkOxsOl+wB9DGnYpKv9G79PP3yLF79t8Rm/UVa2FC8a4j7vfzeQWq0jxqN0dQVqjWwQ5PqOZBC3xfEC4iBVLstBtthODeVMAKf5WSkHzlPa3BpSb5BKzGFOU6H6JHPuu5vlaKESrAPOGKfiEPpi/wtKClICHvLDRmmW3MRLAgvJtr+xJz4H04tmiPohL/VYsQXhm3DMhpiQNCAbTptJabpXq6xzoLaydnSk6u2Q7uKy3ItWQlL3Jz7vroXOKc1ekKbekJusYlw2ygRWXL+Yg3loZongG7eL+Tww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tekF0dzNY3P4bRczl6CIJryxj96n+dq2Y/qjnOHeBqM=;
 b=V3NPFSZI8XAdThDTFJz5GkLwqnrh8N9058guccXSz1ohEeGZbpykIP/KERzhj9nrdYqRON2S5CB74NkXJbje12oqp4tfJQD98c3ZxYFRhxAihTLlwl76X8cKNmECgx1C9tixQGSXarbC2bPOowcCRbAz/mwe53t2bdFGM5hujL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9110.eurprd04.prod.outlook.com (2603:10a6:20b:449::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 16:13:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 16:13:44 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/6] PCI: dwc: Add common pme_turn_off message by using
 outbound iATU
Date: Thu, 01 Feb 2024 11:13:24 -0500
Message-Id: <20240201-pme_msg-v2-0-6767052fe6a4@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACTDu2UC/2XMywrCMBCF4VcpszaSRKvRle8hRWpmbGeRC4mES
 sm7G7t1+R8O3wqZElOGa7dCosKZg2+hdx3YefQTCcbWoKU+SnWQIjp6uDwJRI1GEV2MOUF7x0Q
 vXjbpPrSeOb9D+mxwUb/13yhKSIG9fsoRsbdne/NL3NvgYKi1fgEuLbwOnAAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706804020; l=2913;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=l26KsReRhgM2C7kbGDUQzugdouvzriphT23lNWx0xPI=;
 b=ohoHABmi4M2ZpD5Bx77/xDFSKdFNecTnzxlNYQ6yVBEgZHXv1TQ9fsWml0Yfvk/bK0U5VWbE6
 3cLMtKuP6l4CTLWiH/hKJtsJuvQHRA70HLS/b/vPDcft170OD17MAw1
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:a03:74::42) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f6156ca-e81c-43e0-a21b-08dc2340c34e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5gUR0BrnfJB13vHeUZF8EGmNdiLZJisjZiwQ2mDRvTcW4VRTpMd8IoNd7Xk5O5Hc3dxWgV5SQK67JY0lbtr1G++n6ZXFhJFAFeBQtRBq4Xm011vkditnhBHf8dZdX1yoHEyD4LUbm/UPocXMJB/GKrIuC38ztx5DMSmlLMEJ4lQTV69zAc6hu6JCCc9G/d3qZkZ4d25p/U5S4ADci09hDfVIRbQLpUm4YyePHruIG4wpFTgPeXi42t3WKJ9iAt3kiKZQ/IJRrCZxx9eQ3ueA3IbVFgh5d40JTI34vKyU0OtsK9ht9h35NA0aWn+vU9crhy381uzeidBBc8Ao/wO7w4t/AwpL6DtyqzvATfRCAK164z+UVQj96J9w/x1O+kcBW3QXwBnd9UlN1K3EMSL3DzrRt3xC9Ntdh8+Uup6nyPuLp/HrIBhtdnz/Gvi1sh8DuUAaxD0ZAboTcZkqvOfnR5qCHL0yjP0GL/Uxjodx8zJ/V2Act6IrwT0WZV55GbD7F6agdD6Mk6ywE7oRNy4LfA2vXKl6s9c+7Q28MLwEPh0DnaXVhbp4tAjIuiIwgO53g62jsYc0TI5e2oOb0DP2pJ45h14glheupI8uEm1Vb27Za/gy4f7FT9XQEFpmIW67
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(15650500001)(2906002)(7416002)(5660300002)(41300700001)(6486002)(36756003)(966005)(86362001)(38100700002)(478600001)(38350700005)(52116002)(83380400001)(6512007)(2616005)(6506007)(26005)(6666004)(8676002)(8936002)(4326008)(921011)(316002)(66556008)(66476007)(110136005)(66946007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGNmNzhldERYbXdHVHNmQjFVb0dYZWl1cE8yeXlrRVBkRHp0SFVqSG9lbFBq?=
 =?utf-8?B?QTFzakY0YzRFTTNrVWRZa1ErSG1rRUNHS3pRNUh2OWRSQzhsa0VSQ0d3VmNi?=
 =?utf-8?B?bkwvWWE2Nk50M0JzdkgzN0JtUUNtVnZ2aGQxQWNWcVVqYWxIZDlMempuVno5?=
 =?utf-8?B?dzhLSHBiNVFDeDZxbStCUm8xWGdBb2FabmhsYjJjRW40Znd6dHA5Z1Q0eUZW?=
 =?utf-8?B?OW9xYXAwOXRzN1REYmtNRlpzdENyZXl0WjEwdk1DemVHRk5WQk1MQ2I0OG0w?=
 =?utf-8?B?eDZzV1V1RFF1Q3dWTC8wVEY3Y01zdHYrWSt4WHZCakR0Z3NIY0tjZ3NjWWlH?=
 =?utf-8?B?c0duOG5Wek1pWC9TS2NDTDdDakRpSkxoR2xIeFp3S1BhVmQ1TWVtTmZVSEJu?=
 =?utf-8?B?OWFES0RmdGJ4aVRYR05XR1pnMUdPR0FYaG1BT25wNTlVdGNJQkVxcE82TldL?=
 =?utf-8?B?Lzdybm50MFFWd0FYellhbEZuUzJUZGFZc0x2Z0ZlQVN2UkZJNmYyVWUySTFG?=
 =?utf-8?B?U0YwNllhTTRXemFuNjdWd2FlTy9pN1M0UXNIS3huNDAvRk1KeWpMbjJ4SlQy?=
 =?utf-8?B?aUNFM2taZE9KdXFheU1JVVZOMm5Oellia0FyckR1K3RMU084TjdoSFVpL0NJ?=
 =?utf-8?B?V2JrTWJKZ2NpWWs5M0V0WEIwUmR3UFpTc211TW5DTTFBaVgwaFJwY2RVd1M5?=
 =?utf-8?B?bGp6THhHMmR2Tzl3NVNLV2tERklGUllLWldONmFTTytVZGpad3FmNW5QYjdK?=
 =?utf-8?B?MXZoVlZ0SlloZmNJaHlwOUpLZmdtazVTdGN4MG81bXhRakRLTzVUc0Z0SHIr?=
 =?utf-8?B?ZHBsdlE1czlUM3NBaVlSM3hXeHQwc1lHNFErV1hSTnc0OXF6MGZUcDhwOFhH?=
 =?utf-8?B?M1ZVTE5GQlVVejZFVGtscWdUcU5maWlrS05OSG1EL3JqNUIvSGdHTms2bUdP?=
 =?utf-8?B?TEl2bXQvNkNJSTZiVkZGWllTbW1qS0lMdWZ6VWtkYXNySGZXcWU1UzkwSE81?=
 =?utf-8?B?UlBMRC92bHZiSllsUXdQbHd3Ny9pTGw1ZGFPNEpvSVZxVnIvcUFNRjdaTjJu?=
 =?utf-8?B?Z0M4VTI5SFA3SGZJcmM5V2VwaGQ1QXlQZGZ2Zm9oVTZJUkpxNW5xQ211VzlD?=
 =?utf-8?B?SVZSdzN1WURXUWg1REdsOURYeHBoMlU4L0FaSkozSjJpVWY2eEtiaG04ZVRU?=
 =?utf-8?B?RlJhcFBYWXhEM1JmRU95Mm9iYmluajhaKzBKQW5ZRGRaRmFQZy83azFuQkRu?=
 =?utf-8?B?UGwyVms4QkFpZndHNEgrbDRnWGttblU4RTdvbEVMZW8wVlNYeGhGRC9YUkV2?=
 =?utf-8?B?R0lOcytPdjNXdzRzMzBFV0hNSElOUENxUTMwbEE3VFRvenNUZHMxdkVsejRh?=
 =?utf-8?B?alJqVURGVHpBajk2YWFPNzF0TXYwWGFlNUZVcDBGUmdWbU5Lbmhxai9zSko3?=
 =?utf-8?B?ZWVQcFowTDVPeHVBQVZUREd4VHg3U0dmdjZTRklMMmdWZ3dQWUJGNGpoRVZw?=
 =?utf-8?B?UlovRjhKbWE2eUEzTXNVTnVRWkhlS1NQOVNseWFDZk5ta0k3VlB1THdNN0lG?=
 =?utf-8?B?NnhFRVYramdkeVdFcXQ4bmxQckx3aWUzNFdIcXlpa3JXUVpxYkZIeUtvMFpZ?=
 =?utf-8?B?ZGJnZm5tVjlOVGJUVldxTnFieGsvWDRxV3kvYVMxQWxRQmp2NkZyaFJKdVJW?=
 =?utf-8?B?bDlyellTVlpKZC92Yjg4bjk2SjdPOFZDN1BYRXRWUmFxaENRV2N6eWRIc0sy?=
 =?utf-8?B?QnMyVms0VW4wSFFhK21QRFdRUTFyS1RzSW16Q1BxMVBvamxwMUFaTkF4VzVU?=
 =?utf-8?B?Q3FDQ0UvVG8vREtrT00rRTllWDN3TXVNUzFIb3dzMzJ0SEpJVGR0R0NuUlVs?=
 =?utf-8?B?WkhmVFlkcGJqWkNJRzNKdVVhVmljR2ljaXpRVllFSEZDOEsyQW8raHFQZmtl?=
 =?utf-8?B?TGVpUTBQQkdsYms0cmttUjRUTE5tSnpyL1JXTTdUaUluZ1ROdUNoM0tObHRZ?=
 =?utf-8?B?cFpmTzVMVXFpWCtYRDV3ZCtFVlJLNEF4RzJuVlpZT08rN0I2RWVQSGhMaEFB?=
 =?utf-8?B?L3VmSHdjWUVFTFkzSnNTazYzbjR5Um9WekYwMzE2OUVTLzR5ZHdrN2dWcm5T?=
 =?utf-8?Q?5kw0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6156ca-e81c-43e0-a21b-08dc2340c34e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 16:13:44.2763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BdipdeTyCQIBwxIaOA5EGm/DNtf7i1kL5m+g8027jg4NuzpMYVWvYV2+pKlmJCp1UmxZv/PogASqIC4C9/4KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9110

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
Changes in v2:
  - Add my sign off at PCI: dwc: Add outbound MSG TLPs support
  - Add Bjorn review tag at  Add INTx Mechanism Messages macros
  - using PME_Turn_Off match PCIe spec
  - ref to pcie spec v6.1
  - using section number.

- Link to v1: https://lore.kernel.org/r/20240130-pme_msg-v1-0-d52b0add5c7c@nxp.com

---
Frank Li (3):
      PCI: Add PME_TURN_OFF message macro
      dt-bindings: PCI: dwc: Add 'msg" register region
      PCI: dwc: Add common send PME_Turn_Off message method

Yoshihiro Shimoda (3):
      PCI: Add INTx Mechanism Messages macros
      PCI: dwc: Consolidate args of dw_pcie_prog_outbound_atu() into a structure
      PCI: dwc: Add outbound MSG TLPs support

 .../devicetree/bindings/pci/snps,dw-pcie.yaml      |   4 +
 drivers/pci/controller/dwc/pcie-designware-ep.c    |  21 +++--
 drivers/pci/controller/dwc/pcie-designware-host.c  | 103 +++++++++++++++++----
 drivers/pci/controller/dwc/pcie-designware.c       |  62 ++++++-------
 drivers/pci/controller/dwc/pcie-designware.h       |  22 ++++-
 drivers/pci/pci.h                                  |  20 ++++
 6 files changed, 168 insertions(+), 64 deletions(-)
---
base-commit: e08fc59eee9991afa467d406d684d46d543299a9
change-id: 20240130-pme_msg-dd2d81ee9886

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>


