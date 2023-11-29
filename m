Return-Path: <linux-pci+bounces-252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FB17FE236
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 22:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959C81C20921
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 21:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A8C6166B;
	Wed, 29 Nov 2023 21:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fwm8Qc5w"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2059.outbound.protection.outlook.com [40.107.247.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F01910C9;
	Wed, 29 Nov 2023 13:44:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2zwfe93MEcyp5v/in0baLITQx4uwJXHo5rIS2mPwFLj9sLl7KfDENUXUKjzSUaY2lkqUx7AjNNiXUztephzEEKIr95CR3fj+7qYP4BoP4TZA8v2ShwyVFN48wseTfIzthou+Dk6jiNVjaBy58xn5AJf8ua05Zd/Y8lKwnuZIu1Bo8c5WybGetDOMFTkx61az/hRD+XRVUe94tTmez/OjBqKsdzfkAcvDj3QpPv+FIcqwE4ImtmT7CEdJUfewbOxXEicdm4vV86R8sujSnRCaqbrGgH0d59teYJgp9YWIs7cky2pbPy/ig/3pwJeFlcRj8bbys+KpjC6GWb/YAU53g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNR5nva9cphYOl5n3WTk/K88y95S8YANkVxkCeZvI1s=;
 b=ZcKmTNVrJ93h/ITrmuoGyqNMn7qePRoi06Q+f9DkkYkZA3Xtd/bwGp7uR87vAqAkSpSGgrFv78Ei+dSKk5yxXMNCpWdTKHavoMlHb4C2jckGyywi/9T/fuyHwpnqPHviRXV6Nddg6ruDfYjlva53zK81Q3dB7hWL6d7a9BsASUNq7cRs2RxRZl1414AQRVFjY3qT7PKQBsqGvErvV4ffWoZQpdAYG27CBLanQKjPqwQjG1IQyoQJ+/RYjXynKxH4YRPCQmLRwLRTV517lzqQx415nmLp1B39BBXeTLL6fihVt4Rlfj1+teRlYNoKJ2UfDFUX9WgIH27VxF2EZ0tk5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNR5nva9cphYOl5n3WTk/K88y95S8YANkVxkCeZvI1s=;
 b=Fwm8Qc5wZP+XYUk2H4pY0wJgbQ2LCf5+3U1Cvgasp7k2g2ye+SnzPIWOoYFFXfwGBEvVokdg4SJI5nOayOoPCv7UkVixFDPVmN5oI+lWh/JY/iKeGibujOwxUuNdEhV8UEQPc1HIel7CEfN7Kbv6wJ8/qgqYTYZayB7qpzMkfDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBAPR04MB7416.eurprd04.prod.outlook.com (2603:10a6:10:1b3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.11; Wed, 29 Nov
 2023 21:44:29 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 21:44:29 +0000
From: Frank Li <Frank.Li@nxp.com>
To: manivannan.sadhasivam@linaro.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	imx@lists.linux.dev,
	kw@linux.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lpieralisi@kernel.org,
	minghuan.Lian@nxp.com,
	mingkai.hu@nxp.com,
	robh@kernel.org,
	roy.zang@nxp.com
Subject: [PATCH v4 0/4] dwc general suspend/resume functionality
Date: Wed, 29 Nov 2023 16:44:08 -0500
Message-Id: <20231129214412.327633-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::21) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBAPR04MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3f2b74-9a4a-4fba-a1aa-08dbf1245d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G9kEgLlHr5Zjp+XQhF+E8+oSalnCbeGR4CkxfhlhVRImY3gOpeVlrsFs5lueghj0RJAnlaHoPQD8UaecgHPDxvj16YJwa6QGsVr0pidFpzj3O/Q0FnBlzhVcmJwTAxnmkRAPH6Sg3Ci5Pcv/rrsceU+t1XRjWiBRZHxkoMidSomkrsKtpUnAvPmM/EcrBIt/wP7wJdXVBWPcbBHYXCJNPoVTEh/OipymPHDUNl0Rx0BBf5VJf/zYXVZOU2p/K9pWym3wNMwwej0Qz8eXODe+2fd5k2DpK9Gun9iRgtIUU8i3VO4+Ti5OkSPZnORanzPs1G8RbJWQi6VWyLtGd0F+f3Qsw5r7VHsq9mlgCIhk6aafrfTpasTLVVU4uVBv7yX4DSJPe3ToLR10H7nk+CrnQ6zasT0MxQUZeD829Mr3vxH7Fs0b7yTgO7znKEHg1pY2VSyRA/WIQGIsMlsWwcPMQwFdlCnPdnyKT//KrlYrl6R2FMKpLaBchM4i9QZsrz3yUfT44NcJYgsaHSOzcETOj0q2oke3nzAm6e0olVJPUBXpn/l451FGeygeKyibFhhkF8Ps2Z5hQy+pHk2LrAN6JLsI8W6+ESvyywi/mGyjne8oWUtcDAd1eJN3sd82klrL/bEXMsqXhxpZ1l2Gs7KCoCTe4HnIP5zUTtpsCs40Id0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(26005)(41300700001)(8936002)(8676002)(36756003)(478600001)(6486002)(316002)(86362001)(4326008)(6666004)(38350700005)(38100700002)(202311291699003)(1076003)(2616005)(6512007)(15650500001)(4744005)(52116002)(66476007)(6916009)(66556008)(66946007)(2906002)(5660300002)(7416002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MdpPYLLvYzyjnZI/5Gvy+8jUySzazBIwh1dwSaF5CbEvZkOvz/pxKLJX/GpY?=
 =?us-ascii?Q?oyWp5gGAMQhQSH/o9G7VmCLy+/RaAQjcofSO8+b9B1UQ0NP8obW5NRFewkKW?=
 =?us-ascii?Q?uo3MSiNXavqCzawzjkk5p86d9zu9aa+w2rWMnCU4nWpA7Ie4btwQRxNCN6kG?=
 =?us-ascii?Q?dsjtLJBYCsgAIQQ5h9S267gcbT+fIf1MMTY0kdOI3zEEc9GwMNViftkx0lJX?=
 =?us-ascii?Q?l8pSrATVWpibZpuYICU8TPsnevb89b6Kj50AFXawoMkNf2MGItM+OrFNPJ20?=
 =?us-ascii?Q?sFI5bpCaAxJCh5FMGpnIZaVjy/9HR35y2PqPzofzS6+y7LuAzGM5jYjnCCEa?=
 =?us-ascii?Q?w/MOEtCtNisVh7gieUxRlsdkjqIymqGavlhkdTClMCbswYMLPJ1J1SIrO31o?=
 =?us-ascii?Q?01TYB5iftgem33PnJxBrUjwyo+ACSX1rCY7N8DKLOwL3NLgq1geda6kLdf25?=
 =?us-ascii?Q?ZCXnhqu9NZmMPgYSx4HnRCyjIt383s11zE/wpJtC8x5Z4jJE3r9t7bmFqyg4?=
 =?us-ascii?Q?xXFUCcWMzkvAO4rh8Lk1BmtbzMGrDJzd8PQKiPWN4sR9YGfTeH4S8lvc0hln?=
 =?us-ascii?Q?IjUNH5cQYtZCvzjS/FviOLUFlM/JNWrrg/RLvaW0kYboPaqTQTw9WXmtLh7T?=
 =?us-ascii?Q?51Xzjt0zRubvZXlTqFGjDuRczVLI4q11/Qw/YnkCR8yauyK1eTrziqoWLf/c?=
 =?us-ascii?Q?kepSZTRrVvUZ+lOEood2D6Z04l0tu+LeEji8wcMASHzQhSSKuU885l2WlQ5C?=
 =?us-ascii?Q?OUQHGlkUK8VAJaU801dc6LIPHChUeI0onDz9p3vjoQvPz0HC1Z4+Qt+QjZe2?=
 =?us-ascii?Q?Q7js8NkO4oMz07IED/6pNf1NV1WJr81zXPB0e2k/QfjHDCtl7g4W8f5dX/lI?=
 =?us-ascii?Q?4f6979jwDwyeDzh8w9CX0i8YUfZFkge4rA2WNzlAiGUnzlf9l41Z/VmzRBUV?=
 =?us-ascii?Q?lkjjRdxxNyaNeOdnpAMnM/jVin4A0vf9WXcAnpYHxVYcrT4CDMr81jD150t4?=
 =?us-ascii?Q?9EkXfBtC3cgUdXNiLFuE2aenKprJkRU0rqNraj5V/huVFNCnsoCvL7fBkE/d?=
 =?us-ascii?Q?wmRnxyJPSvdliUyWa10Hp3u7Rg5A8Nf1mAgBM91cKcXUeEEvW+vI7dNQkClE?=
 =?us-ascii?Q?CQub46Ci4AWXPHcvg1QF5tDKCWzb+o3zOWCm+hmv41bERpB/7z85Rqfqqmsu?=
 =?us-ascii?Q?8CFfqB+rnipWRvVu3fPreHXsO2EU99xZ53iYNk6RmrqXnx91fRYnMvLVvJpO?=
 =?us-ascii?Q?W+RG/llDlKo9zkTo/AyDYog1VhSVhj56CgZY4WydlkXmLemNzGoD83YDl31X?=
 =?us-ascii?Q?LzJ0D/4neFqfwa2GQvWkOEzLumgwd63QWq9lkDfq1UoXbnSO7KKYviXsVlsW?=
 =?us-ascii?Q?5cyKcmniyBTrKpCd7Dhku5C0IGQfkwMP3vT6Jbwk0iz+qexd6WtTYq+1ZVRk?=
 =?us-ascii?Q?Xv6AL7Rf3G5+X4SZiWY0UWXqy7gMnXSixV2f20Um7dOmk/UwIQrg6emsnahL?=
 =?us-ascii?Q?or1ucNPr1Mk5DtiSM+tMR0HSUmvWWcWxuvgJrn8BcmmiwkmmDc1TRhry0Hfz?=
 =?us-ascii?Q?c8b5a9d3EmLfK7rLmg4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3f2b74-9a4a-4fba-a1aa-08dbf1245d5c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 21:44:29.4068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHhgXYGF+tP9eeCB/17xRDZ7nBZ+zc/TvjZzdos5htjF+xZTFc7jM/WYHXolo2rzuG5eDx3K4ifVc1NxofdTKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7416

Add a API for dwc suspend/resume.
In layerscape platform call this api.

Frank Li (4):
  PCI: layerscape: Add function pointer for exit_from_l2()
  PCI: layerscape: Add suspend/resume for ls1021a
  PCI: layerscape: Rename pf_* as pf_lut_*
  PCI: layerscape: Add suspend/resume for ls1043a

 drivers/pci/controller/dwc/pci-layerscape.c | 191 +++++++++++++++++---
 1 file changed, 170 insertions(+), 21 deletions(-)

-- 
2.34.1


