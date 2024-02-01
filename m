Return-Path: <linux-pci+bounces-2945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6464845CDC
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 17:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A8C1C2CA66
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 16:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C02E15DBD0;
	Thu,  1 Feb 2024 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZAXPm3/S"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8BC1649A1;
	Thu,  1 Feb 2024 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804052; cv=fail; b=Esj6iRBTSsIYYLkVhLU7/LwKAGqp6FcgUg2qNDtzrwhBgB4+IkR/5xQ2M1eQzr/KerEgNj6zJa4YL0ywSPdDoMj3M7eLE22wBvCz6XewTYVhHGVbg48XwbezZqPfhPwvG/fYaj6TMYgDue4p4vxTZ+6T6Z4+uc51QM9xquPG79g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804052; c=relaxed/simple;
	bh=T8i2d5YcwxgVg17BF/Je9te+972ffy5ilUf3q6l9KnY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DSI12Rr6EpQFQ5Blv1zuQObuTFaZTbXWXa8yAGwFJQl/TMp5S0Vnc3rvQdLiTgLOZMMhmyyeabbHNp81kKmUERwszB5rVrhtbzvWk6DEacfkya+SPkfe5x4K8Lwh435Nh2b81mMl/WZpcKlU5PYYn5uGOMqLovfxpoMsWlB6wqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZAXPm3/S; arc=fail smtp.client-ip=40.107.104.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcTpyBXOApbNFOCK3H6VhZR9Bpc1caqeA1/5+Dk8aiVwKMxcfSphGV5pmTpGCp/t1qXqAm4l4OoTyMZw96ctShoW9vkGAmXhbIowwexYrwksfmrHPLp2T/Dpz2liTlV30MWU332ZQCo6Z/Gjf+ZY+RKos1DNALHXtSSEHwi3o/QYFWLGv1OHinw4yioeGNs/ClQ3G1QUxXfk+Awqp2/poE6JyfUayfqRZtlBXXXmvVrdQULT8MG1KnjmsmAQ+9nG2eKqOL16AXL4OyBy8BWuTInUBue2UWZPmlKhqqKduZOFEsPQ0vHAlHZlYaFhbPuWgXXCHLdiPmPsJ9VKf+41Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUTNSMRiKTw9QCuf4fVh7hiPiSF/yV3M3KoyG5PLijw=;
 b=ewU6gM4D1HObqUgaO0QlybYd5/ZgtrWoBevcEq1KG0Ik717FVqs/ooiBhCWy/9OAQBVivjiNcLT5gqLWcIxbz21VIdRqZ7cazbO8R4Y1+gybG3dkdJBCpxc+5d8v0SUhqt9x7qneihCMa+VUnWy0EcSBmjUirKR4fI5Basy+HeFX8iqtO41Gxye4H/JQC/NranmM7YzfmBK7Kz8xdvloO5m95JCpbOsWFn05VejzzQa24K5rvL0S6fulFH7pL6cs+sXFVOZNLHTf6rp/qgqg0PalA9RPM8+4DtQl2JTpICDBiNn+hkkTC16nW43/jlxHIJk2E44QYnQ7PP9dK9BhFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUTNSMRiKTw9QCuf4fVh7hiPiSF/yV3M3KoyG5PLijw=;
 b=ZAXPm3/Sjz09hQcBL823GM4xGKEOkTd7nOKpDfZdpWWZ1VIlUTBfI1o7JCh1cAR6ZY15KQsy5rexfjMz7Rmw6GQMnW19UFGGoQU9VG5RyVRZaFrLPRRauCnWzPO/vga7SgClXJT19SBmXW0yiqW79bPNS7zC8jSRcLIABfZWdsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9110.eurprd04.prod.outlook.com (2603:10a6:20b:449::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 16:14:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 16:14:06 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 01 Feb 2024 11:13:30 -0500
Subject: [PATCH v2 6/6] PCI: dwc: Add common send PME_Turn_Off message
 method
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-pme_msg-v2-6-6767052fe6a4@nxp.com>
References: <20240201-pme_msg-v2-0-6767052fe6a4@nxp.com>
In-Reply-To: <20240201-pme_msg-v2-0-6767052fe6a4@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706804020; l=4224;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=T8i2d5YcwxgVg17BF/Je9te+972ffy5ilUf3q6l9KnY=;
 b=2ogMPxh4HPH8Hgdna2hIpwSM0R5Jt13ZQe3qobHiYtMb81KYKNaL2HzSYVn6QfJtjOcyo8DR5
 4jJCrQgP5yPCu84EhumQVgRatgSAq4QHljbyI09wOZUPdnaTF/v8ElM
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
X-MS-Office365-Filtering-Correlation-Id: 8fdf7ccc-a3af-4668-e2f3-08dc2340d054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G1i5z8YQFvArJc/mR4i5StItmdwlEVzQUfCuPRhxm1LeQ4FC5aSLbGGyivJoLf+xPBALQ4bexEu98sTkh1isjBXD3b1cVG2EuDj23yZM0vf7vBt8EFLTOm1ZXey0PGY8BDdgSkFLK6w5UG9CMzj9j7AECyYOJl3V1FyhbGnlMQgcOSJ7uXDojzEffM3wUg1XR9i6ogIoR4CHTe4OIGz2mUrcQVrHmUe9WFefwyJJpHrl/kk8eK752BSkxcd2aQfYw7V7/IIeJ4qU3+FPaYOGv/JDJly4KMwVXneKHoirlhV6Zl+RbOX5RJz/yE27as/okQFHKi6nYm+B7fKcmDkHCEHeHuPo5J5dulObHWoNuwocFjlIXPOVxujUcpO1joGeBRtQ7K5X4zcgPVdAZxpazzHAbJhr66yg6GxcSETOveq5nA3mxjJ3kyRYLeStAaGMwrKtDZriaP7bSfB8u/f/i1j/RDtEeElmGke9/fJoKpGHSe8em4DbMmeAkkKyhW3HbYo6lLBqXaWR9whmxc9soTYrOa46vsqeIxQmSw1l6GgfoyxWW/+AKMJngccXKTUEqgZeQY0IeAepm6lm77Qx5nKQhNZGNuc0cN7toJ8AO+RaqoN+z0sWrEZ+WZsGCVTIrZhGOuqMxMBrgD/yJ2ROOg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(15650500001)(2906002)(7416002)(5660300002)(41300700001)(6486002)(36756003)(86362001)(38100700002)(478600001)(38350700005)(52116002)(83380400001)(6512007)(2616005)(6506007)(26005)(6666004)(8676002)(8936002)(4326008)(921011)(316002)(66556008)(66476007)(110136005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUV2L0xQUFZMN0p6UnFRdFJHTTdlOEM2NEFRVkIzR0FsVlNHdk5zNVlsYU9V?=
 =?utf-8?B?ZkFRMlBJNkdzSUdUZ1czV0IxUWJORm83Y0ppRUIwKzR0NmEyNHFuZVhkbHdC?=
 =?utf-8?B?UjNJOTRwWU56UHBKRC9vMDdkdy9zdG9mcUgwVVRDbUxRSXVqeVBDTzFZenZM?=
 =?utf-8?B?Z0ptekVqL3VCeFpQeTZQVDE4Y1VacGZQMnJWb3QrN0cyUnZxUlVjY1RJRndR?=
 =?utf-8?B?RFc2ejBvNzZ0R3ovR1h6UW45LzJvOGhGUzNaUUlIM05wZVh0K2J4VjAya1Vs?=
 =?utf-8?B?b0dYZDBMR3F3U0pZYVN2cDhrcktnRDdOc1hNOTFSV21vcmdqRzJpejdkZzVB?=
 =?utf-8?B?bTgwLzU2UTY4ZmJBcnFnMUVNRmNuZEZQVE1NeFJRdEZ4ZEdVSXdxNnZsREZl?=
 =?utf-8?B?K2lPMjRQSTQ1NjcvQTBmeDFzV3RkT3pGREowK1JhQkp2QVIzRU9mK0xyakVo?=
 =?utf-8?B?UFZGQzhOaE8xWVY3YUN4VWc2RndmbllnR1NpbFgvTDkrWUFyRTZiU1RQSmVW?=
 =?utf-8?B?WkZhK05pcnlsdU9hZ2YzMDI0UUdBNEw1Q3VGaGE5eEV1ZCtzWWt2S3ozekpW?=
 =?utf-8?B?dTBzakliVmJTNVlUUW1TVm8zRFdqa3Irck5oWjF2MXF0TXJXT240cTBLWHp3?=
 =?utf-8?B?YjBDOU9qRUE2RlRlbHEycmg0UWxlTDZmYStlTHNQZDhkcUZPZ0J1SmtUbzZX?=
 =?utf-8?B?WkR0SkZxK2xBL0RvanN3YnVhM05vTUswYUx1TUhpUnpmZDdmQS9nMzNQYTk3?=
 =?utf-8?B?VHRvaC8yaDlTQXI3NlV6eENjNjE1d3htblRobmxxNUs5UTAzNEticnZRL1hG?=
 =?utf-8?B?aWhFQnJwOXFnRThleE9WcmtWKzRrRnZOZzZiSndYNDFEQnZDVXVoMW1tcVd2?=
 =?utf-8?B?bnZMM3lSUE9TaG9KSDRpRDlkdnlCUytMTklsS0dMNEIybE14QXE0ZXV3L0kz?=
 =?utf-8?B?WmhKdVZlOVhvYXl4UXUrNnUyVkI4RkEvQVZmK0c2Z0kzSU1DKzRFQy9hZjBr?=
 =?utf-8?B?M0d5M3ZRVHIxcTVvZ0JnZFFmdUNsSHVoT0crZDM3WWgrNlRXaEhhN3E5SWlD?=
 =?utf-8?B?VWZjK1VMcEE5SVF3QnEyUXBadGdGS1NHa2hnckVpN1FUNDBiV1NiU29DNDRj?=
 =?utf-8?B?VTVLY2x5b01qZ1FuVDk0RWtkNGJ3anNNeWo5WW1qT2NFaExiRUdUN0NEeGh3?=
 =?utf-8?B?RzJ4TU85WUN0SWFtaW1iQ0Fad0VRSjhRL1Z4VVhKeVJHa3UvN2lmY0FqT0lJ?=
 =?utf-8?B?d3ZPM1NPQzBnWFFmcWxXN0lMVVBTS1g0aXllbHgxZktObnBpNEdSMEdsM0F4?=
 =?utf-8?B?Rmh2eElsMUlqeTAxKzQrRFV5SDRpYjF1ai82aW41YjcvRiswaCtpMlBod1hn?=
 =?utf-8?B?aVB3cDFHR3pkaDVnYXJ1b2tUays4bDZMSW45R3M4RUl4NS9nN0FiU1RBNTRz?=
 =?utf-8?B?ajFIeTE3QzBwdWN0dlR5ZDFBQVFvelpjUFZMZXB5T1l2dHF4MWV4NFBtTUFC?=
 =?utf-8?B?bzhkL3I0aGM2YWlTWXZLcVhCZTk0Mmt0aWpmeldNZUg3enh4czMra2wvSHhN?=
 =?utf-8?B?Q08yQ0t4aVkybE5WU2N2RGg1ZGdrTDhkUG0vcWl4cHBsNnhHZG1KWUVhZ0NH?=
 =?utf-8?B?R09aNU4reUlPRXcyRlN5SW9VNGdGOFNjaHNsR1B3bnB4d0R6bEEwZDFBZ3hS?=
 =?utf-8?B?OGNBaU95SUd2SVc3RU42cVBCRlJHOUV0VDVlNTRsbzU3TnJWeEJqbXRRMitw?=
 =?utf-8?B?QlF3UDd0ZlBJdXVHU0J5TnoxUFo1b3FoNkpFQnhpL3NKamZPOTRVblUwV1Z6?=
 =?utf-8?B?aTkyTTk2T3EwVGVkQjZPY2xtT2laWGgrNzgzaUVWVHUrdWU1SWlHV1VWb1Fx?=
 =?utf-8?B?bFEzQmNoMjcvQ1hJWm9CR3Z5WkVhNW1LR0p4NFhKeGljTlBBUzIxeERjK2pY?=
 =?utf-8?B?VUVTSmZya3lESlJ3Qks3WWFDSjJDZVRPTWdTZWJUVk14bWxUbzdxcVcwa0FF?=
 =?utf-8?B?ZWxQVUxmUC8vTWx2emtraGtNbDFMVFJQWnVwMmMvRWNTTmxObHVYZjZoUU9l?=
 =?utf-8?B?WUs0Y2VqUllvOW9yTHkrY1BVMFpiK1B2SmtFZ0cvZnJoMnlsNG4xWHhkdFNR?=
 =?utf-8?Q?hDtuzVCbg/+pyg1g8MFz4f9yK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdf7ccc-a3af-4668-e2f3-08dc2340d054
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 16:14:06.1518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kM2tzmi2l+WfADq6NLC6zENN+VfWgg+GuYbN1CwsFCHM7D8bQlwMBYIXpLsRw/WdnP86y2LwXvLJWh3Uzvo2xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9110

Set outbound ATU map memory write to send PCI message. So one MMIO write
can trigger a PCI message, such as PME_Turn_Off.

Add common dw_pcie_send_pme_turn_off_by_atu() function.

Call dw_pcie_send_pme_turn_off_by_atu() to send out PME_Turn_Off message in
general dw_pcie_suspend_noirq() if there are not platform callback
pme_turn_off() exist.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 51 +++++++++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.c      |  8 ++++
 drivers/pci/controller/dwc/pcie-designware.h      |  3 ++
 3 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 267687ab33cbc..2a281060f3aad 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -728,6 +728,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
 			 pci->num_ob_windows);
 
+	pci->msg_atu_index = i;
+
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
 		if (resource_type(entry->res) != IORESOURCE_MEM)
@@ -833,11 +835,49 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
 
+static int dw_pcie_send_pme_turn_off_by_atu(struct dw_pcie *pci)
+{
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
+	void __iomem *m;
+	int ret = 0;
+
+	if (pci->num_ob_windows <= pci->msg_atu_index)
+		return -EINVAL;
+
+	atu.code = PCI_MSG_CODE_PME_TURN_OFF;
+	atu.routing = PCI_MSG_TYPE_R_BC;
+	atu.type = PCIE_ATU_TYPE_MSG;
+	atu.size = pci->msg_io_size;
+
+	if (!atu.size) {
+		dev_dbg(pci->dev,
+			"atu memory map windows is zero, please check 'msg' reg in dts\n");
+		return -ENOMEM;
+	}
+
+	atu.cpu_addr = pci->msg_io_base;
+
+	ret = dw_pcie_prog_outbound_atu(pci, &atu);
+	if (ret)
+		return ret;
+
+	m = ioremap(atu.cpu_addr, PAGE_SIZE);
+	if (!m)
+		return -ENOMEM;
+
+	/* A dummy write is converted to a Msg TLP */
+	writel(0, m);
+
+	iounmap(m);
+
+	return ret;
+}
+
 int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 {
 	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
-	int ret;
+	int ret = 0;
 
 	/*
 	 * If L1SS is supported, then do not put the link into L2 as some
@@ -849,10 +889,13 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
 		return 0;
 
-	if (!pci->pp.ops->pme_turn_off)
-		return 0;
+	if (pci->pp.ops->pme_turn_off)
+		pci->pp.ops->pme_turn_off(&pci->pp);
+	else
+		ret = dw_pcie_send_pme_turn_off_by_atu(pci);
 
-	pci->pp.ops->pme_turn_off(&pci->pp);
+	if (ret)
+		return ret;
 
 	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
 				PCIE_PME_TO_L2_TIMEOUT_US/10,
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index ba909fade9db1..eb24362009bb6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -155,6 +155,14 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
 		}
 	}
 
+	if (!pci->msg_io_base) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "msg");
+		if (res) {
+			pci->msg_io_base = res->start;
+			pci->msg_io_size = res->end - res->start + 1;
+		}
+	}
+
 	/* LLDD is supposed to manually switch the clocks and resets state */
 	if (dw_pcie_cap_is(pci, REQ_RES)) {
 		ret = dw_pcie_get_clocks(pci);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 703b50bc5e0f1..866ab44df9fd1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -424,6 +424,9 @@ struct dw_pcie {
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
+	int			msg_atu_index;
+	phys_addr_t		msg_io_base;
+	size_t			msg_io_size;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)

-- 
2.34.1


