Return-Path: <linux-pci+bounces-34090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AACB276D2
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 05:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979E65A6E3A
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 03:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D009C1CEACB;
	Fri, 15 Aug 2025 03:32:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022101.outbound.protection.outlook.com [52.101.126.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735D1311AC;
	Fri, 15 Aug 2025 03:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755228766; cv=fail; b=rmkCVL4cYFYRecs01OytHZP+iaObfkoGLYPc/l7bSlsJoB/sCtaHV8fU2wMuQ4eHYn7yL9STVEkkMz2Ng/gPpzPpZrd3XL0L225bSArLXtA1spBPjmr53sMptbJ6nQZqIuHaoItVf+SvVtrnSLeyL1KRTJUpL4rQER+HM4X4EU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755228766; c=relaxed/simple;
	bh=Q66HTFaMULyAbRbl33u03Xct/wAknZt6XG0HkItsTvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDpCFhE3cS0mTrBRpT+118mFUKkWz3hKp+BHY5+L3oofDM6zVhzJJN1qbSNVRmW7EXidAloTeePCl0D3ab7/vzdVkecf3ZGJpoAijRHAH5ZjwbF0GA+t+FOk14d7RDwn4G34+dAe/Lha2BTCtvm26xYfxzhY74bb+mCMQbk79+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxCqiViWgBYvKZFl8Ho8cncQd2ODtgGGNfMvZtvFW9kGXuoqJq+P2wjXwjMvLvVwuTNyo3iF/YNRLhs5Ffmm3Q0AoeU/HC9Px2QxGY1N3Bhh2vp/KS+W4zginNtO+OPwF9lxMEsmJ/d/IWk5HelbSQv+43h2MpclnAN9kPchst4N5QS7uUDevlBujzn4G/CPcEfpfE5wWAPZAQ3D6vr2upuE9SwXu7WD62+2HmiFaX1JG+cpU6jJLDEGfSTBbhd/Iqnloa6C3j8lAh1BHdxN+RnyTKawqE40rxrLr2Y9cXrXhi9XXnx4mtN51GV2JjUbr3fDJ6Zbi8/MT7KcFpIWFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEw2TGSfoqpAKSdLNMhmi98zujzXhh9VhwbGbjDjzsM=;
 b=uTDriMttQCzcBcc1gr1H8yKFd07Hly6iHFpn9eKuTtFSvdYo4NjdsQKWJA0pSsgx9CXy5NIFouAMZzinekN0sC8Z6tDlwY+np1sVLMyx+MjMx4qTRSVBrcw44H7QmUkphx3j0s5cE6ACCFgoHc0b59MAM8dWOIGu1dH6CRNcKpbUB6p2+CAOEp/Oa56X+IJde8yTJNtFop1Di3Ctmo1R9FBD3O7cExAJMTl6b9uVXZM9XmgOZIvvRVxdzZvSynaj32xB6U6rNMmFFAyFj8Y+M1fC9vACJnO/kxapcvSTcI/VEboRpaH5cgr47DqAeY3oAQ8HTAZpoJG79G0W8+5wgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR02CA0085.apcprd02.prod.outlook.com (2603:1096:4:90::25) by
 JH0PR06MB6938.apcprd06.prod.outlook.com (2603:1096:990:67::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.16; Fri, 15 Aug 2025 03:32:37 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:90:cafe::a4) by SG2PR02CA0085.outlook.office365.com
 (2603:1096:4:90::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 03:32:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 03:32:36 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id D9B1F4115DE1;
	Fri, 15 Aug 2025 11:32:34 +0800 (CST)
Date: Fri, 15 Aug 2025 11:32:29 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: hans.zhang@cixtech.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, mani@kernel.org, robh@kernel.org,
	kwilczynski@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	mpillai@cadence.com, fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/13] PCI: Add Cix Technology Vendor and Device ID
Message-ID: <aJ6qTdA1f21SAr_l@nchen-desktop>
References: <20250813042331.1258272-10-hans.zhang@cixtech.com>
 <20250814222358.GA352330@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814222358.GA352330@bhelgaas>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|JH0PR06MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: a3e1a52d-5eae-4a01-daaa-08dddbac60ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QvZFBtobBAhvPNekrO+K9QOLe6DEv1f4wlCR1ukpSK01q+w/lPZmyd9Dx150?=
 =?us-ascii?Q?P76MhoQnf+BjamwggtejHaaZqWbU8TZJhhfDKYFVA/SmLe5WDd0UMyJjU0ru?=
 =?us-ascii?Q?jZEpKRu7ZkJH4C/d5ewqjTCaijJN4WfLpjrHiqe0ov1s7/7avPLUhYOJvj4W?=
 =?us-ascii?Q?ZIHvzTW7U9SVUOc6RVnzIy9xdQUmjlgKbHauRSYsO20oHdarPXOzPyNb98DG?=
 =?us-ascii?Q?NWc//Qil2h+MYtSdNwbw4/hJWXULi1aDCj6zZTn1m3JFq7hTaG23ll1pCX6C?=
 =?us-ascii?Q?JgPFs+N8+aFirr31rsZ+rDrcRb5k/EBc2YDraSXQ17HJ+2DYxt7n57jZtcts?=
 =?us-ascii?Q?jkyYivoMijpPwP9Gx9oXIpvhptz4IwzBk3nqC6y3u6c41WAfq2HJiWQJe9qY?=
 =?us-ascii?Q?nRsrzS6FJ0IIxPsFWxOav+QH84LfCbD8ajzC22FIBvT/J5v42r8EwKcdo26J?=
 =?us-ascii?Q?BDjsUzUGT00Ilr4ZgvwZlVjXQUX31wjkEok41G4KGIz2aGfRMCpfGZwgx9LJ?=
 =?us-ascii?Q?RLAuNJjWO/crPnA1HTVBDZDkBMq61jkZgBGDCV4RbIiVIGWXHM5s1chLSxfz?=
 =?us-ascii?Q?2WlFtHTcTXUWU71zJmSs0NumHA3mntvq6jHGho3q/0WOefgCA3bX4NVfvtLU?=
 =?us-ascii?Q?PGiEY7QRvGioEThx7w1BwVTKV5EAOm8OMH1i1TvYAM9yetSDed+fFyFw04MQ?=
 =?us-ascii?Q?Bs5UhBu2tRNmw5jw6BtfVSqAgTBrfJ4QGMN0u3gf8RoGsJQFm/KQZMeRK09Z?=
 =?us-ascii?Q?obggkFntZ712zIc3Zkkq+Aw9MMzcAxL6X4S1YHm1O33IThtm1EdpK1qKUURa?=
 =?us-ascii?Q?9pZHLwh9wwhCl6ysCf8+feaVFJTGQa/AI37AcIAwASHgfpgmDmnszMdJv6vo?=
 =?us-ascii?Q?7LMxx0Vpab9aLkvJjqgFyuZAxgPxnS62Z8jbH7hwEhL8zfTG8v7FR+YAFy/c?=
 =?us-ascii?Q?+xNhiUxg9UOEnAe/ezplb+Qxuhlgb8sHW0ApKk0PAUr0oBC4vtJvNjVnWUz3?=
 =?us-ascii?Q?l/jgPV6PJ8OftTNrbVsx7a3s7j5bwaOB1c1vXbbxGBBkbFOXEBg24wkh757q?=
 =?us-ascii?Q?USqsStd5PCdwKeSQ0Inj64nfuZFRiVaS+cisijIcy35aUYwDAQYwqQBa1dDM?=
 =?us-ascii?Q?DgGyZq2c0glcFto9eH1ElgkfZbhlxrCRh5FK4hLZUxmRtRPJ4XnlvzrLQS+f?=
 =?us-ascii?Q?X+py497WBCFm2Bi6RSwrkhalLALIcKVYa6azRQiaMMkf5DsItBi6j7nYPT5l?=
 =?us-ascii?Q?vS4v4MpSVcle6iXjMUiBjLzU0T42JGfTanYQViGcuNXsKFUjtmGzG7GmIZ2V?=
 =?us-ascii?Q?7f86/6qZZbh5TNakkXYHIn1av9ZDBL9e9MTWBTAiJ2uB409FeBvhYIK8Anpk?=
 =?us-ascii?Q?AIdr5fUrn2Mj7iCp+ytVcaypBDUzOTlGqesJUEjdTosY6ZnKcyR7ZkAAmgeP?=
 =?us-ascii?Q?eUSOeUl9uKbU85IHGivrJlgGVoz++PfeUekhofs5V4HsbdpCIEK4OLZdWWrM?=
 =?us-ascii?Q?hxgnqfJQGHz2Q59ByXLFwfrbCEqowceVUIKk?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 03:32:36.1829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e1a52d-5eae-4a01-daaa-08dddbac60ee
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6938

On 25-08-14 17:23:58, Bjorn Helgaas wrote:
> EXTERNAL EMAIL
> 
> On Wed, Aug 13, 2025 at 12:23:27PM +0800, hans.zhang@cixtech.com wrote:
> > From: Hans Zhang <hans.zhang@cixtech.com>
> >
> > Add Cixtech P1 (internal name sky1) as a vendor and device ID for PCI
> > devices. This ID will be used by the CIX Sky1 PCIe host controller driver.
> >
> > Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> > ---
> >  include/linux/pci_ids.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index 92ffc4373f6d..24b04d085920 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -2631,6 +2631,9 @@
> >
> >  #define PCI_VENDOR_ID_CXL            0x1e98
> >
> > +#define PCI_VENDOR_ID_CIX            0x1f6c
> > +#define PCI_DEVICE_ID_CIX_SKY1               0x0001
> 
> I only see these used once in this series, so they probably should be
> defined in the file that uses them, per the comment at the top of this
> file.
> 
> Also, https://pcisig.com/membership/member-companies?combine=0x1f6c
> doesn't show 0x1f6c as assigned to CIX.  That database often seems
> incomplete, but please double check to make sure the ID is actually
> reserved.

Hi Bjorn,

Would you please check below:
https://pcisig.com/membership/member-companies?combine=1f6c

-- 

Best regards,
Peter

