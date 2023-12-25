Return-Path: <linux-pci+bounces-1375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F8381E007
	for <lists+linux-pci@lfdr.de>; Mon, 25 Dec 2023 12:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB1A4B20BD5
	for <lists+linux-pci@lfdr.de>; Mon, 25 Dec 2023 11:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD7A51012;
	Mon, 25 Dec 2023 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nS3GVFHc"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140BF5100A;
	Mon, 25 Dec 2023 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNtekH6T9nsXK7IcXBTuVZmelmcJD1ZYGL+9YcM7eV+EbLE5Y64cx6YOQZoXaZJ7bmm2hOzTwzsRNttP5yt3gaWhbvKHoBCPeixMoOCnu7yoIkYuyBGl+eAmsnNzXkk2dKHUpoa+CdNnCZWf4cgsmpwynIQp0YIQGEfy1R9OX4FppMQTeb3e3Kk386AaZ7cdu4t4Rfribe7nN3x6Qzu9VzlPDo8FyLS9KRXM2MJ2GVE6vGWoIAZCvYC/GKbI80KcTJkVjMZmcARBp8sgXLJmvNZoEQMHe29fZwSA5ubpYGRDjO+xxB9bmp4YmR87za0TKqoxawOexMu8L4agDzfxYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMSK96zwF2iIYjMppSSg8U52HJkzJratB5WLsyvpNJs=;
 b=ijVtfCaHc26iPEh7GimIvSIX2WJ1QC87ECTA7VroyLOHJ6Mzpn8nNKzQq72JvxmLNy1yHF4kWs7mCj1fzb9OqDcErIUhfNEwiKkZw+Lw+fHhPW0fdiGJVEh+6Pem9kaX0kx73KxddcVQJlMTjONzrb3oPHLU1WzzE07qJaAr8yx+4GNvF5fQbsdujwGlIItzJ9gexB6QVEuSlQeOqQxybCB/DQa6TrAGImdXqmHuQhUvaL1xHQhrPqyewjyj1WA4zXfF9yIsf4VvkDVq2FG92VL8+KVuQNHqQp7HUD5CO5sxmC7hLyhYLafIQY73exZIfqAIKwSNY8SWQk+VQzu6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=samsung.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMSK96zwF2iIYjMppSSg8U52HJkzJratB5WLsyvpNJs=;
 b=nS3GVFHcl8Yc0Z6MpiRhwBNtOWUAAYMsgpsZvzS2Y5qWpkqUv1NJWSX/Cuthqas6FJxPTYXdunEVFtjJ0AATRv6lnwZUEMLNqK2XNaPFN2gV9F3GfDOZXQE59EL78ZmjMEkej+qUWmPdtbAiTjY3ovXn7nMkhwQY06KvlTxcaJXGWRDKJhLo1Y1An2gd1zt2fqHw5XLk/UirA/6p0PivWe0LXlMt1nFdVO1Xay1ycQR32YVDqdG5jZxXma1RqhIbG3WUZUGREOzLzLxC8Aq7MXInGmjZaI4DWfiMYzmgwNi3tHIwP0QBzbrCN++bGMfJBspjp0dSbq7dFmED9crJGw==
Received: from CY5PR22CA0060.namprd22.prod.outlook.com (2603:10b6:930:1d::23)
 by DM4PR12MB9071.namprd12.prod.outlook.com (2603:10b6:8:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 11:20:10 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:1d:cafe::1) by CY5PR22CA0060.outlook.office365.com
 (2603:10b6:930:1d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27 via Frontend
 Transport; Mon, 25 Dec 2023 11:20:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.14 via Frontend Transport; Mon, 25 Dec 2023 11:20:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Dec
 2023 03:20:02 -0800
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Dec
 2023 03:20:01 -0800
Date: Mon, 25 Dec 2023 13:19:58 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Jim Harris <jim.harris@samsung.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Alex
 Williamson" <alex.williamson@redhat.com>
Subject: Re: [PATCH 2/2] pci/iov: fix kobject_uevent() ordering in
 sriov_enable()
Message-ID: <20231225111958.GA59971@unreal>
References: <170311143880.2826.17853753430536108145.stgit@bgt-140510-bm01.eng.stellus.in>
 <CGME20231220225823uscas1p12d012a034806edd76fbc66a8d04e15ee@uscas1p1.samsung.com>
 <170311310235.2826.17048185824437453415.stgit@bgt-140510-bm01.eng.stellus.in>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170311310235.2826.17048185824437453415.stgit@bgt-140510-bm01.eng.stellus.in>
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DM4PR12MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: 088b4631-9524-478c-3569-08dc053b7436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WpiHp78TTvcZZEzVKqYD8eCvsCZZY30aBBNoXvb+6xggNPMT3sbwdzs75oLQuAKjN3Qy4FTirwVpSJaI5BhQPrHsuibVvbXuI9bSriNlbK5NrEsjAVIFUcXUA5O+kYAlGYM6uQP6aI3730pEhBc7xkE+O1UyoFYNTM481hKdfHe7xvcSrIUhSyTRFq93QNGtG4YVzoL5gzWouskncZvtQ6QiAZZGux7x6ggyX77K3JPdha8t2wJj5jboe7YZ0kLQl/uOaXhLv4aJMYjHEdHh/mdQICN+x7mRnzAkf0zlgUxea05L2xLhFxTuGjIlAenlejjGoxAiVmAPAwlaG5ypehbvXgksJvtN8fGFzdDlSbZELE6Om9I51BqOe2PEpxS+wBC0ItZqkAeuTX9hbzvt1VQJcOU/QedrpUGoL8lu4Llc09e+D2BSk13GmrLsCpF83izypR/pRm4Tg2QhI/qTq13zkb+Aa90Zj576IHNUjuyd7iD5nKg1jytCZbSHErZXk1+RC+89SMXGQJuDl7ix5+0wwV/aTN9CnAmFOK3q31zquX10oT3/rcBSZ2ZPNoXNSqbxHZ2RW1Z3Qwb+a1FBdZwwcJD8MzR/mSJ+nf3kJZk5qTT5DC7VdauWddleM6cUVpmt/eckZxpXbuJ8N7BUaTxSJngtCsMYWcz73Lk9S4PpoGSnHowFc//39ZCx776j1tUds9pWVGD2VaEZ+kZnAWR3EhObhAs2L1sZRxNIGi0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(7916004)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(82310400011)(451199024)(1800799012)(186009)(64100799003)(40470700004)(46966006)(36840700001)(40480700001)(16526019)(26005)(426003)(336012)(1076003)(40460700003)(86362001)(33656002)(7636003)(82740400003)(356005)(47076005)(83380400001)(8676002)(4326008)(5660300002)(9686003)(6666004)(36860700001)(478600001)(54906003)(6916009)(70586007)(316002)(70206006)(41300700001)(2906002)(33716001)(4744005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2023 11:20:08.9593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 088b4631-9524-478c-3569-08dc053b7436
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9071

On Wed, Dec 20, 2023 at 10:58:22PM +0000, Jim Harris wrote:
> Wait to call kobject_uevent() until all of the associated changes are done,
> including updating the num_VFs value.
> 
> Suggested by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Jim Harris <jim.harris@samsung.com>
> ---
>  drivers/pci/iov.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

