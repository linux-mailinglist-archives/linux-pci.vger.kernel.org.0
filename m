Return-Path: <linux-pci+bounces-4047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FB5867E61
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 18:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E1E1C2C7A8
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 17:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EDF12DD87;
	Mon, 26 Feb 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZWrD+lGR"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2045.outbound.protection.outlook.com [40.107.13.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A056512D766;
	Mon, 26 Feb 2024 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968256; cv=fail; b=MasQ0W3FsnjXRu8QxS2fGYP+NQ8Ye5n6yd6EyXoV5nofZKN8YIjxXxB4aHvXB+mumm0FcDdTo+C6xSfHNRhXptZ+1MzXVldwcahfFQaWGBTRknSbN18I8oZNw/lgrp0xKCapTkgCRVWgF2F2PWpcSGhsyW638PRfGjb3n9eWoH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968256; c=relaxed/simple;
	bh=PM2wD2xjzF8cCj78haADShcp5zW7p1XSRQy3pL/CEwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dugei2T22o4fh571KV25cMvz5b1XkKHZXAJtC3JWThJt8988yH1f9U3m4+rqMi6pZaR4QQIovQwQkzVqJhUMLO6eQgYubD8QRuEzKnLefliRHCyFyBXjJDogv2x81BIbJuXF+Lc3u/RinwP+fvt66cly5TWltm9trYtWkkwqkXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZWrD+lGR; arc=fail smtp.client-ip=40.107.13.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMNKdXTuUzsXscCP5A+vO9+DMAVevTYYtwE3IT0ID3hcH5k4zkAr1wXlLlh0PaWi4uYWEEJf3ESNtmgCyzEGg/meSY/lt27wEOqCVpnGYXoDd83mbkgwz4spff4l4k5XutITfq0622FZ4xYKLdr4grc4+8t26NfmjDq1ZGeT/pSlDZ8gBCjMhEkh64BNhqJxC/wsQGWl8rEikWLeW9soj1T8eIHt9yjN0XhDaHCRu6K3nZCrq+whnm7sPpB/x2f6Sq/+4tt+5pLGYikS9o2sNDFOSz20OoPfbj823ULMOqtUd9bA1570CXA5C4w3t2992snf0p3SMNQxYYDHbTHjAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPS+uPdsb/Im+iMg/azpKnFlqsqECX/yjPTNVc2JlUY=;
 b=gfi0Q4QKDUsjpNAKXZjSUoOIirqn73+kZneTjVN3SUkMUjxovGoshfm/Y2xM+3b/QB9q5VGZNkmDTudU+d4Bmo/UqorpqMEjZVrkhiGZO+ajNmZ9iJPNEkDt7CudOGolvkfzp/oyNMfZZuQpRNnQGzNC6CKsb2hROlEZJj455kfGyVuSYNIWay4yN84Uzz7o9EoVkjh/gZ2yLf1Hf96b+iREUnd8+0spl98BZKeNBdvvheWKFcuJMzSV0bLLAgTI/Y5NGwgPTskNilt1mTXG4lLW3kwyYix2ZF9vrCRskXUmztcixjHla3zF6zulFzcOow62GLlG3tOXJryy6XE8DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPS+uPdsb/Im+iMg/azpKnFlqsqECX/yjPTNVc2JlUY=;
 b=ZWrD+lGRP/ZA5cLPVqfDMRCX+0O1VrP9xAbasVtj/3rpdlWkr4tjA3IH0ZU8zwR5nIF/c87ImU1+LV+eYWi3mT31zSfDHr6HBdDM+c0x052Jyl5SdDqmWs671Svz8R0eey2kbAIhyZHycKYCKUnohX8m1P0qVwFRar3tZplzEPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10230.eurprd04.prod.outlook.com (2603:10a6:800:240::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 17:24:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 17:24:10 +0000
Date: Mon, 26 Feb 2024 12:24:02 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v4 0/5] PCI: dwc: Add common pme_turn_off message by
 using outbound iATU
Message-ID: <ZdzJMtgcaCPpJNNW@lizhi-Precision-Tower-5810>
References: <20240213-pme_msg-v4-0-e2acd4d7a292@nxp.com>
 <ZdNwxAi2KH/P07bi@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdNwxAi2KH/P07bi@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR05CA0146.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10230:EE_
X-MS-Office365-Filtering-Correlation-Id: ccb9418f-177b-4995-d234-08dc36efbe96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8aLdQBtIqTkJaDm956sx+zMAmj1+c+QTHsuztAD7KVq6/luVOFQlD+QrnB3x625YaZr0MrflBM/tO8zLJs2jX8fphDsX2+C4/vJu6aZplMUBmfl2bXwJfLUcz2cO/sCCv8MVP8/jkW0yR/r1pS3bi/mBNXMNLb0c9IFD/RDervmBTOArKHSXSvYWMCqs5ViJW7qUfXLzhULjaN3bbzQwv1dhu98fgeIPxTlQgc0N4kFsQjphCia0lLdxVRUhF79FItKcCqfJ/AE1WEl38jJZ2/LldK+1C+oZ2ukeWXYBJ7lCh6Zo97l4UCnD04ay1iPNaW4RBbx+RXX2y/OYN6pxGl2bSbjlpwrn6TdNZsbtMkdpFG+fyvxerLXW6uBae/5XJWrcXhKai1zsT+aq8wW9ZU1/XbrRe2kQ8cjXqpy5uNnCafZ+WHZbcTT2yW3SYFvEVJ+bRLvn4pC+qofsCNJ5M5OvXF6cX14BH6EwxVnFw6SdCyaWZ1EnkKZMDujrps3ND5Gogsd8vh9sm5zn41eWaWn2iLE+OJNrnGJXRtS4owj75+XG293/PDeJscujVl1/NfugRpo8PLdH3mxlfvpHKTQrOscmLp5w8+goibl9WvuIaV5QEWH8iw7tWvdyIL22F6vWnNPgkfE3lqo1Yz+27jxZgdGBjj0w1NoWv0LTRw/bTvHd6lxFd5o8qIilo5UXsrwv060u1b6G8OS4hpe+wA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y5nH9hqu1egOP6aj81T76uBN2MuuByfy803xlD5vB/4lR/gLxcENuWccBCAz?=
 =?us-ascii?Q?I1InH17e9Kndwb1kFAt0p84KCrr8Eh1rZRHjZYeKo77hdh2f6Yy7bNsn0+WT?=
 =?us-ascii?Q?4x7JZhFmXaM5OYKM+QpJoNxm16MvfAlUY6Lx0GCZSlRvoalWJw3D98vun1EE?=
 =?us-ascii?Q?6N8aOKHjpUWn6dKTms1o42sDgXvGGtLYf+p73hnTESBBATwRfYFL/uttPoV4?=
 =?us-ascii?Q?ZplbDFNCBCkXAgS1R0znbUUWDXDnank5sPL2UuDLTzYTce+dlQlkPDVkEFJN?=
 =?us-ascii?Q?ZCvGUVoxZA9bt/a6bdYF7FikYSAUHff21WogfcP1aBSrmGjE8roR/gPm3gsy?=
 =?us-ascii?Q?W1eNSathrr6lBzZo3Z4GDbJ3EzroBpWPR1Ir0/GTbaUaPg47TgDW3tDW3t5V?=
 =?us-ascii?Q?IUKIi9epTjuoZLdmJEJ/LiYGLhLm6MNmrFceLu1ZSkF1F9CLcpDfTcWoE557?=
 =?us-ascii?Q?K1T/6WJqJ64H59782iDHq4yn3zTjipbff/9HdXGrfWqoiq13Ala+lqVtDhMN?=
 =?us-ascii?Q?/k0zg5qEvxqwSBuoTx+g7wEx2wXguTslHJwF0Sl0Z69Q7gFHwufdrOhsjcZ0?=
 =?us-ascii?Q?/XvssGi1j/VdQ+JDbZtvsGT/QfIkedLg0y5VFZf9qZGm7Yxm6O9iAIVB7zBd?=
 =?us-ascii?Q?d/iXKtQ+a04Uj/0Pt/y3pv6qxOi2p+lFLEa/0Vybb6upQNaCL+rTiaJOeoFI?=
 =?us-ascii?Q?Arauy1fRBzqMLH91GXK+GodXOtloS8honizZ2L6S1T9ZL6F0nKAmci6bn4EZ?=
 =?us-ascii?Q?f8+RqcKXwM7BvJn/F9L93e1sZA3KnrhpfwJ9CIzIqAVSTfDcmlDVBVSc3CV0?=
 =?us-ascii?Q?mZwq3QHzRSLPKC1p/K5Zos0/FBWtVZlewaF9nc0AMKk6NWLq7Dy7RtBlyqdV?=
 =?us-ascii?Q?d1elEziSaDn+7PGirVWVzGNotFDUPeBfr99/XbT7b3iPzmlQTJWxBVKb5BI4?=
 =?us-ascii?Q?MR+5bHsGWaldUTskvnAVddcEtlCjpi2nWPWF4H8FJ/QIeZF/J25AMp0MnmVc?=
 =?us-ascii?Q?Z1uo/lXr+2icZaGsDrG2zxzVTKI6JdX9rlySAJ/rChaq86PUs5RtAOVLqpSC?=
 =?us-ascii?Q?AmT4rlD0BGX9M4pRvkN3BO8CcqPrtJTD9JF/GLRqn3WhypB7skvbEgn+pHEt?=
 =?us-ascii?Q?ZnE+Uh842fVp1eD/9ZpA/QcxqtLExZKtEA/plR+QDI9V6mAx1uefbSxJvzpU?=
 =?us-ascii?Q?us23AB6ocqWbeOXHKU1GhVqw3sadUzkk0ul/XY4kFrLwIpIeAqj4H1w8iMoq?=
 =?us-ascii?Q?XvCYuBbZszFWLzeDjfLvxfB3GOVVTGfcichQAU9cB2n42PGMJuqc3XVbV6e3?=
 =?us-ascii?Q?XAZ38wyEKx66EIoRbeUDoeY5ZO/RK8dANvNc+KdanTmlV/wx7h6Ho0XqN5zB?=
 =?us-ascii?Q?kN9crR2K/AnZ7ldapLjKpc9BVCx8xvT0FfqPSNRmt8s66PrruX8WgwgFjKMC?=
 =?us-ascii?Q?STIn4C7ldy8VviG+ua0550BR6S6mF7qr6HZPZsz63/zust3vXNc8X0zrlOfs?=
 =?us-ascii?Q?2yDa6YAk4TAOEsKmRsz26KhGQS1TGM9cDhNjjyQSAtov+itfsvfH+n+6ChiJ?=
 =?us-ascii?Q?2ewJ1FFqS/3TB4vmGmEkaicvixCUczJJMBYvTu8R?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb9418f-177b-4995-d234-08dc36efbe96
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 17:24:10.6112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50eSc3KRNvmKxuAVNC0t9GGAvKBA2zoXKZ5IUbATEUdkK6O6ewpKWqghRasEVqbJIibLZ7Ei8nW+l+jRNEbB1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10230

On Mon, Feb 19, 2024 at 10:16:20AM -0500, Frank Li wrote:
> On Tue, Feb 13, 2024 at 04:50:21PM -0500, Frank Li wrote:
> > Involve an new and common mathod to send pme_turn_off() message. Previously
> > pme_turn_off() implement by platform related special register to trigge    
> > it.                                                                        
> 
> @mani:l
> 
> 	Do you have chance look this patches. Actually other patches
> already reviewed. Only missed
> 
> 	PCI: dwc: Add common send PME_Turn_Off message method
> 	PCI: Add PCIE_MSG_CODE_PME_TURN_OFF message macro
> 
> 	This patch will reduce customer's PME_Turn_off method. Many code
> can be cleaned after this.

@mani and @lpieralisi

	Do you have chance to look these?

Frank

> 
> Frank Li
> 
> >                                                                            
> > But Yoshihiro give good idea by using iATU to send out message. Previously 
> > Yoshihiro provide patches to raise INTx message by dummy write to outbound 
> > iATU.                                                                      
> >                                                                            
> > Use similar mathod to send out pme_turn_off message.                       
> >                                                                            
> > Previous two patches is picked from Yoshihiro' big patch serialise.        
> >  PCI: dwc: Change arguments of dw_pcie_prog_outbound_atu()                 
> >  PCI: Add INTx Mechanism Messages macros                                   
> >                                                                            
> > PCI: Add PME_TURN_OFF message macro                                        
> > dt-bindings: PCI: dwc: Add 'msg" register region, Add "msg" region to use  
> > to map PCI msg.                                                            
> >                                                                            
> > PCI: dwc: Add common pme_turn_off message method                           
> > Using common pme_turn_off() message if platform have not define their.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Changes in v4:
> > - Remove dt-binding patch. Needn't change any dts file and binding doc.
> >   Reserve a region at end of first IORESOURCE_MEM window by call
> >   request_resource(). So PCIe stack will not use this reserve region to any
> > PCIe devices.
> >   I tested it by reserve at begin of IORESOURCE_MEM window. PCIe stack
> > will skip it as expection.
> > 
> >   Fixed a issue, forget set iATU index when sent PME_turn_off.
> > 
> > - Link to v3: https://lore.kernel.org/r/20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com
> > 
> > Changes in v3:
> > - fix 'MSG"
> > - Add pcie spec ref in head file
> > - using function name dw_pci_pme_turn_off()
> > - Using PCIE_ prefix macro
> > - Link to v2: https://lore.kernel.org/r/20240201-pme_msg-v2-0-6767052fe6a4@nxp.com
> > 
> > Changes in v2:
> >   - Add my sign off at PCI: dwc: Add outbound MSG TLPs support
> >   - Add Bjorn review tag at  Add INTx Mechanism Messages macros
> >   - using PME_Turn_Off match PCIe spec
> >   - ref to pcie spec v6.1
> >   - using section number.
> > 
> > - Link to v1: https://lore.kernel.org/r/20240130-pme_msg-v1-0-d52b0add5c7c@nxp.com
> > 
> > ---
> > Frank Li (2):
> >       PCI: Add PCIE_MSG_CODE_PME_TURN_OFF message macro
> >       PCI: dwc: Add common send PME_Turn_Off message method
> > 
> > Yoshihiro Shimoda (3):
> >       PCI: Add INTx Mechanism Messages macros
> >       PCI: dwc: Consolidate args of dw_pcie_prog_outbound_atu() into a structure
> >       PCI: dwc: Add outbound MSG TLPs support
> > 
> >  drivers/pci/controller/dwc/pcie-designware-ep.c   |  21 ++--
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 145 +++++++++++++++++++---
> >  drivers/pci/controller/dwc/pcie-designware.c      |  54 ++++----
> >  drivers/pci/controller/dwc/pcie-designware.h      |  21 +++-
> >  drivers/pci/pci.h                                 |  20 +++
> >  5 files changed, 197 insertions(+), 64 deletions(-)
> > ---
> > base-commit: e08fc59eee9991afa467d406d684d46d543299a9
> > change-id: 20240130-pme_msg-dd2d81ee9886
> > 
> > Best regards,
> > -- 
> > Frank Li <Frank.Li@nxp.com>
> > 

