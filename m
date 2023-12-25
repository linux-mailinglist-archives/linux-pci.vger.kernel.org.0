Return-Path: <linux-pci+bounces-1376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A9F81E009
	for <lists+linux-pci@lfdr.de>; Mon, 25 Dec 2023 12:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B481F21655
	for <lists+linux-pci@lfdr.de>; Mon, 25 Dec 2023 11:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B918A51014;
	Mon, 25 Dec 2023 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VbNM4t4a"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206D651011;
	Mon, 25 Dec 2023 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDUYBct9k7qUNLWE0m4xPhNxra6htCQhogy+aUUJNstnxh1bYc9nCIAJg8eM24PmOH5SIjB2KZkqdEC3900cHE60avFzRQlGXvTC69TYy9ooTSoOUzK9lXC2BpId1DDct/bEMGywHxJLcBiBOrp7wmbhPkhyoSeler6nIELX345L3kvF3nZ2arNbxz3/IcPs92l+bCxd/3U+7r5/JPRWVp3/YKvViQdWSm9j3XT9gG0yYR742SiLrXvXMhjfWRxIPO+8bnK5gvageVTWgMj+n7f/9sXEpxjRqE082Q6ODsukxkUrWsvwwpsWWMexXwljS+NY43C8xPBzDJo37eNOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5r4j7JCxmADrBMK6Ljqv1QDm5g61WN2P4IRuuwH0gA=;
 b=fXJa2MumLZM/RySI3PFGgyiizlZxrWzxegTK36L5hqPdue5OEFliqDMZ4fGp5yIq9YDm7f4r3PmXhv1aH1Tw9WpzOOfDDMoxysOrFzZ0Q1xklg4USsBWwky4eMZSd99I0a57IIGDokFboYpRfYeBGmXI8th3A4pvCz6uYzUwfJ3FU69bchgisPluT1mJimwBq7pyHmqH2B4hqAo96swVsKJuO695b9piB3fjeZjrS6EtX9yvAGaEwnIF6ii2WMQRYOjMAUzya9258RaGiCy4buLCBxtkswKDm71g/qKGDY93CjHCLFpmT9mc3IQgVZxc38Ay+0qSA7Ww6p2zwX3I3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=samsung.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5r4j7JCxmADrBMK6Ljqv1QDm5g61WN2P4IRuuwH0gA=;
 b=VbNM4t4a/JF1+8/hhVT0VaZZJYqa8h2rYh0t53NjSqT48eo7TV/68PPf5NvQWzsS30Yo0Zj4xpovqbTxErpxOc/GBJO+XaEjq0nkLlTqNF2t/K0TAuLHxwGiVXKs5Qoki7W1Jgxv+udbmxxQwFtgCWdl2eH5sjN7UBjOwxb5HDPzD+ei41yEkF/mKCboxGBp5TJVzv9UAs+CKwPSlYBuxH/GKeQ3Lb6KJJqNtvP06GYoGcKItW9Hp7TTQC04iYFhaOWO2yx5PXaRmIusuKTZzFYmK/kKreZ9YU28puT+9P4K1/jvGku4aLnF99irlgEsZb8amfZ1NGh7xAApGYCKnA==
Received: from CY5PR17CA0053.namprd17.prod.outlook.com (2603:10b6:930:12::24)
 by LV3PR12MB9402.namprd12.prod.outlook.com (2603:10b6:408:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24; Mon, 25 Dec
 2023 11:20:22 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:12:cafe::5e) by CY5PR17CA0053.outlook.office365.com
 (2603:10b6:930:12::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26 via Frontend
 Transport; Mon, 25 Dec 2023 11:20:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.14 via Frontend Transport; Mon, 25 Dec 2023 11:20:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Dec
 2023 03:20:11 -0800
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Dec
 2023 03:20:11 -0800
Date: Mon, 25 Dec 2023 13:20:08 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Jim Harris <jim.harris@samsung.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Alex
 Williamson" <alex.williamson@redhat.com>
Subject: Re: [PATCH 1/2] Revert "PCI/IOV: Serialize sysfs sriov_numvfs reads
 vs writes"
Message-ID: <20231225112008.GB59971@unreal>
References: <170311143880.2826.17853753430536108145.stgit@bgt-140510-bm01.eng.stellus.in>
 <CGME20231220225818uscas1p1e01e19bc82953b21b473ae1daf17e839@uscas1p1.samsung.com>
 <170311309712.2826.11254260046040224092.stgit@bgt-140510-bm01.eng.stellus.in>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170311309712.2826.11254260046040224092.stgit@bgt-140510-bm01.eng.stellus.in>
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|LV3PR12MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: c0216ef9-f45d-4be7-37fe-08dc053b7bc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HseZtoBZXq6FnYW1hhHv3+T3cJs1FllDj1s7Nf50KyRxe79BQd7mx2aB8glJASEJj9LuItGSNo8o1B1Ze94ciHml8KmwT/Rnv1dmS6GzPAnmo3HshiJEPZLpbxkm7OoAmhBWB8CkmCIXmE2Tlw+IAyuCQzfwItEcx73LDxKXLuNNVQdacndIBQUZFfZAJHVrAEf0ASBARFRCv6X5PN7ObvFskJqBUYeq6JO9E9WM9qrl8tArt+3cUGCYRdaDAqAwXkOzTC8d6qrpta/nLz3Bqi/A6S9HzaAQLdSVPFuf6MqV0o1PiX4L+fmyc/rw8al8GvdO98Cm5bzbm4cYh9xhG8ZTmILb9wE8EbiN8SaaOZRQWEsjaeaJt3f4sZUnHeJ6HS5vEVe7i1KnYyrnkWxtY6nyucnctmAqzVkjYytlWAyKQdEP/0j8fXrpaCrGkninrZJdjdvaGB0qWtwC9t6pzoAy19cTbgYZoXK7xEzqZkeB8uivuWyk7RRCiGF6qhWzhMmnBWWGKlx5T2sBmRqEr0XDQgYWjLSOYgKLj7U2MQKh8oDP0hjQz3orFa48RK+SXU92CFO1TB1udDt9Gb3ndEQWFDMnv37FlQCS2zKEGy5nDVFe/Ki5SgJlIegFUxEYRYcQOsUkNhFF/Tos/RD99fiafiDFgcy4YQnuUxk9roZWi44IYnV9J3nIm76ln1ZHdL8PbaAnocLOl7Bn/9sKvFs0JcEAroy7FrSy6wNBTHW5tE/H/VbPdUUvMyt4SYJq
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7916004)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(5660300002)(2906002)(4744005)(478600001)(6666004)(9686003)(1076003)(16526019)(426003)(26005)(336012)(7636003)(356005)(82740400003)(70206006)(70586007)(8676002)(8936002)(6916009)(54906003)(316002)(4326008)(86362001)(33656002)(40460700003)(40480700001)(41300700001)(33716001)(83380400001)(47076005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2023 11:20:21.6536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0216ef9-f45d-4be7-37fe-08dc053b7bc7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9402

On Wed, Dec 20, 2023 at 10:58:17PM +0000, Jim Harris wrote:
> The proper way to detect a change to the num_VFs value is to listen for a
> sysfs event, not to add a device_lock() on the attribute _show() in the
> kernel.
> 
> This reverts commit 35ff867b76576e32f34c698ccd11343f7d616204.
> Revert had a small conflict, the sprintf() is now changed to sysfs_emit().
> 
> Suggested-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Jim Harris <jim.harris@samsung.com>
> ---
>  drivers/pci/iov.c |    8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

