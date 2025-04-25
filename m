Return-Path: <linux-pci+bounces-26752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E50A9C875
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 14:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344F14E25DF
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 12:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021E9247296;
	Fri, 25 Apr 2025 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qjAcK3HJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF20218EBA;
	Fri, 25 Apr 2025 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745582440; cv=fail; b=qHaAOquTTSRpwUobJ2GwAAnb9j8cDVrXNleyCYUJcc/x4ykccMurskGU4bwfK8rXAC6wUzadM71C9NJGN06NC15X4Jc7gEjXMcYt8cb0kItlyHagvhJhrgsqrqSnWJZkvoYa6H2CIJXxMUDV/dS8kArxXfffjeCNPHiuGmgftqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745582440; c=relaxed/simple;
	bh=F1YkcS4E35F57wrsnWWYyKHj6uPVFFjSIEKtGUCTUSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N/dqnRtJzyL5hyQG96sTF0U5dpr+YO/CdxJ37dZZChhWrkbLzfl2erkLPVEvWlw9ElpFCCsvH/y5dzzZMCIrg2ro6UTZmqIYYluRrdXPw7Qr3UFhpWZSq3JJW2E+ZsC4BNtVJIvCeEx6ds9WCvuAGdUsxX5hgIQoZcXu7qHIZfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qjAcK3HJ; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0fW/0kKayyG63nBQ3awHgf2tIeLUInkTcCpHJoBxiTEuEdr6cgaG94UKvIujhFMnC6B1m3QNX8Nl4O0dxD29UOoLKLVoRu+tjvDsUSg0u3Ivw/BZ3D/TL/lIwb6CBZp2cXUXcfspcReOaeWDNN1Til7cTVImub+2fnGBotKdLU2DK7Z5YkpET2gy/0bcwGKWGGhIyTStKRIUINN23wj7TH4naWFwiEH0zntSTHLw5YvK0dz60fht9Y51YIcK8GDMA7m9bM74B/H+6Y97cJ0MbkI7c19oKgp4W4bqgqu6i1zmcqLEq0UCicunzCugnmIODSYiPpL8P85hBwPwlMTBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D18TzGv9if4t3GXNk+F3xJFoyM7AekSIZ99DKJoYyUs=;
 b=PFPWdNlCpJkhBTJBlArVIL7FHj9sL8rK8drRp2K4rgDa1EOjAUAgxc2rJaxqglphHugJ4fUMa3xpm/Lmhq33CT4TZfpfq+BTUB3XEDhMMo1WS3TgYzknRPeCKVma44Q3MJF9G2J3CWm3zYXGY4NrJUf0UWTKpTCNRWRAZBh4pHATjcj2YXFj//r/0Nn/WkZEFSeNgtggrcnoVBUCSM+qzVOax6H1S1N7t5MPWIZFULmJIdJom2FsldihPKY4LK2a4HpkV9yk78ACb+590t5Pko8BqiX2p702LuS0v7oA7VYJOQ7/xA0SbE9j4PCz3OEwQUbwRF49bjlfQruIuVSqaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D18TzGv9if4t3GXNk+F3xJFoyM7AekSIZ99DKJoYyUs=;
 b=qjAcK3HJTFVzkEEW1oiIZm4AJyQuyFcCy2qhYkouQWTP5Dfx2SPeqL8UObmxRhbwTEQYw8/WumbCL0MjuNMYSCy0MNG5u729beqblGqJfw2AhYU3mhX+7ury/wHF/f5TUEZjX7lyCipXjW+CwzZhkvoPDJ5yFFhTBW+TbH0VOe0aie95LSZj+S3dHj2uBOEfTY+lLK0R2Ws7lEKXNkQ3MY5EAJKUhOf5sJY6fuWoj7OTwqLCLt1jU/ArUWp1PXYUuY5Ymm764hB9GaCpWPxfpd8dyhAGWDYAsug8o541hrdKZEyAtskRNHOMIaeH5Am/DqU2SDvWG3VsgKaYmb3ivg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB8441.namprd12.prod.outlook.com (2603:10b6:8:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Fri, 25 Apr
 2025 12:00:36 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 12:00:36 +0000
Date: Fri, 25 Apr 2025 09:00:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tushar Dave <tdave@nvidia.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>,
	Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	yi.l.liu@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH rc] iommu: Skip PASID validation for devices without
 PASID capability
Message-ID: <20250425120035.GA1804142@nvidia.com>
References: <20250424020626.945829-1-tdave@nvidia.com>
 <a65d90f2-b6c6-4230-af52-8f676b3605c5@linux.intel.com>
 <8ef5da0e-f857-43a0-8cdf-b69f52b4b93a@amd.com>
 <20250424123156.GO1648741@nvidia.com>
 <77be6671-e4e8-4b17-bf72-74bde325671a@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77be6671-e4e8-4b17-bf72-74bde325671a@nvidia.com>
X-ClientProxiedBy: MN0P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ae23855-f43b-4631-17c4-08dd83f0ca1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?guB0CZe14il9TlvuxsX+d+uzp52zWJ0x3PKJbG4p5LcZ3KFUD0Utg+47QCr4?=
 =?us-ascii?Q?GAeIxq1VZd5uJchQFO9Qx5G+kifdHm2pdRNgi12gG+7id9j5dN6yqNeVsqHo?=
 =?us-ascii?Q?BbEMe/f++AvZh2d1M7J4Yo4pkyz98xbqkcaI7xFCIR6Kwgu4+CPXqffUkwYK?=
 =?us-ascii?Q?g0NKV1eyCKbi7UdwlCVXEssrgeZI80sLfSG6OcRkxEcv8Udom7xPxezFFMo9?=
 =?us-ascii?Q?iuP37DkzcjiLfoSPipNQoR7zBloL4G+QH+LGp52t3NEI/xXMFAmgiEF2Q1Z4?=
 =?us-ascii?Q?rXcCfXiNCGRxIfunPn8GdmcdZfa7yO1H5x89JMgfSgEzDfr/DxMJjUHdvcKQ?=
 =?us-ascii?Q?VogOKJLdpRHUbO80fdKoZDUt3sYptF6dLETyxBdjShVSP49dDbTbx+9R4Y4e?=
 =?us-ascii?Q?3JZePO6CKuemwzfFy7bh1kyInlgvKJaggp2n7CZJGqBZpEN35KEkIkmepsne?=
 =?us-ascii?Q?sXcP0SI2fM1CUm8sDz3PaRaxU11oU9cjlNTSNkk8DiM2lmGI4WLlR3XtGSji?=
 =?us-ascii?Q?jmHHz98521aJkpPVJ9+oYDD/0qgtQzExyLUMbZrvt+lWajnz/5j+AXKCZLr7?=
 =?us-ascii?Q?d0IoW/89mI1zzkhKFL0tkNkjJ94t02G5mLxixqMo0iDeRnYhDgiAEfn1GTP0?=
 =?us-ascii?Q?qmVd+abcj8xNhiakj/4UVgwAOjExvLVkvvtGmeXmBGW4xbwg+o03BL3wLWQ8?=
 =?us-ascii?Q?Ie0qhV34LblWamocjbDmDrLgeDHm9zFB9UfxB7AoS85E00YqRhzVL8zMjrvN?=
 =?us-ascii?Q?93CAq2ytnZeATRMG/GB3BFs6ACLdNXVt/q0xUdIzHik276kcU53rsGhIpOeG?=
 =?us-ascii?Q?nqKoYrdLt5ODzXnCLFRtcE1GWMnxHj02kNxolxi0k2fL4WYr0ygGWSVy5tNT?=
 =?us-ascii?Q?Rgu38N4BOG3RbyCp2t6ejrSM66fp07SunXJc3RZvgUm4mtkstoVDGYlXK146?=
 =?us-ascii?Q?jz9uWjwsoLon0WjriZKDzCaajjvF9C06AVO/cbYs53ppZvkO1DlJwz+zXWMC?=
 =?us-ascii?Q?JToF5/l4M6mQ5bYIMzotebqbSqW71Qrd/r9JKlomU233Hccn/ziUqNWOhjMh?=
 =?us-ascii?Q?fCsR/OJ4fXtSNBGK7e5GmWNqwTnfngp6pohvDCOgkk5uQrq+24gOvi/DzOus?=
 =?us-ascii?Q?iI8PL0gvPX+v5YQEtexXXWImWYhFOwuCSPmH/3EwdZNK66jGI+jrn0rXSyp1?=
 =?us-ascii?Q?RRu5IlT95xFZwANL67FQ/jPbusTQlAwcWpbj5ZkF3h8xoUTiI5czAwEwDQiE?=
 =?us-ascii?Q?y/wF/YPE+hM9VqqOxnxYm2gLoPqoX/GyeLrGA50c37JiOcFrAVIQZRMW1vCS?=
 =?us-ascii?Q?Q+OZYEgPCrNmIfdaX9UhSU8RKkbi9hOCMeSbT36Yl44yEProbw8ID7xnoRFx?=
 =?us-ascii?Q?a6B/QuCK6zrAZfC+em0bKGtXdisrKD9wc6PUQsVp/PPiPbGgbi8lT5nfzCw1?=
 =?us-ascii?Q?B9cUCmXVcS0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C5b+v5eI37Y8OUa+t7g8CpO5y6nLttssGSlM88p5v9cWSOHxtgVINrbvBx/l?=
 =?us-ascii?Q?aN+bDzPvzcpsykhnKZyWeSG41r+JdCZ0lrjwGG0G6NoLEfaeFJimYqv5pLOk?=
 =?us-ascii?Q?vb9T086amP6JZaJ5PljM0A+mv+3neRXen48tM38NB2elPlSH8+DwfwBHkCKa?=
 =?us-ascii?Q?XtKjRiP8snIWWhO1xeEU2pZ+R65/N0TSDLSXgJ/ZXut0pDLN4ntxVswTFdH6?=
 =?us-ascii?Q?I9cYx+mLi/K01+ms5JZw5PQVfsA427yEFlIxzWqaRqtcFFVVXd6LgyBxbeHr?=
 =?us-ascii?Q?NwhhI/Wzxwg1y5VonCRvw0XXtpU50gTSAgEYwp105RaFH0xXXXygW/ARF6o6?=
 =?us-ascii?Q?IrP3nu8sM27xK7TKFlZxJlKx5TLJIHTdp1fVkj5Bk9aqB/7ncl29IITdGTuy?=
 =?us-ascii?Q?LbEWhOK0plL82BbcDInnDpHrFvpcDl+mf54AFrBBmgYY7DC4IpTwCcWy+eaM?=
 =?us-ascii?Q?GX53mviBocTSBrfQFqar4r4i9cv1Wq35m8wTUU0sOlEsPy/d/ujrm0lzbDVN?=
 =?us-ascii?Q?OSBAyMPMaDGB2kp9pXqOsDZF+CJrvk1uUJgVcBBKCwJ37DhlsHnaaJcQefph?=
 =?us-ascii?Q?1+xFfcom3GQiUP7tqjTG/w5b2AC6cX5Rx2jzbF8+LGqxucbCkvioKW88KpsS?=
 =?us-ascii?Q?CZKQyFQD1CRxgiAI9SM7blsftKJTYbWmsILlPPZRJ5LrG8D2d7oh86a0vj51?=
 =?us-ascii?Q?RPvPMM5VqWbvhrk0urRd9O6GjIa3sdgGXQD7ZVFyTPfdECAK7mXG6nUADSlx?=
 =?us-ascii?Q?muN70wNtX/++05E93OcuKu64pokrGgCJIqpEafhZWmwspLfnYbGmvzOd32Ea?=
 =?us-ascii?Q?A7fTwKqqTpZRuzDGBhrSreVF5k5P6PqlV5BbmKut55jhoi9roCVAo9h8qdHh?=
 =?us-ascii?Q?j6Oc8FfWcOTPom0kXasSouwGadBfgJSFd4oNk325e2QWniUza3m/evWlGm3j?=
 =?us-ascii?Q?dWN5plt2ORf6x8wT3GiaJj+Ff3PuTx/DPp0ZDvHTr+omlv9r8qu1irGnJoDD?=
 =?us-ascii?Q?N2bZfBk+b0BhEG72pFdh+zHS/GJTta4KuTGW61+4U7MFOKY8sf3R3pSK9jOr?=
 =?us-ascii?Q?W8/MWPhDjV5lJUs319EV5d0RLOctK3/cMjNY5J9fpvcn3sS/yo/q6CUFQXkh?=
 =?us-ascii?Q?4Wq1aOXcm43VZDA8r0SeJtDbMGmtbYKqyptCPSbbVju1CwVhTIipNnTlHeCF?=
 =?us-ascii?Q?sdPyzftZYFajNXzfUqXxPZgWdjNs96NJOnCFiCMGUz3xlD0rIA96wOwiiSMI?=
 =?us-ascii?Q?AD2JA9sYTuM1Bs5U4DQqq+sDCdHg2wxtYiy9xK3qUaey9iTcVSZabTyRegeU?=
 =?us-ascii?Q?Emf01mkLXpuSei9/Pp/5GdAExbr1Q5phw5VuD/Zba7S34LTyH+t+ijVIhjr7?=
 =?us-ascii?Q?ACAgyb72KTyZZzLBgR3l4mD/Aaaw6y41fEsI2id4p57Bsmv0psknX/hRC7NC?=
 =?us-ascii?Q?TpKX85Bu2jvVtSMvpaCIOi8Ls4NHIFomLCPW/ZyQBMvpEL1Dxbv/8i3ZICOG?=
 =?us-ascii?Q?Ur/jMgiU2i3ofzLKrZoqwoIT9L4vFxw9wNIv8A2D791mPXjr938h+PU9N38y?=
 =?us-ascii?Q?zZ1NzueG11PgPNBtD7OzJHObZ4RvlBxLfqbUA7OW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae23855-f43b-4631-17c4-08dd83f0ca1c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 12:00:36.5815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJ6I87cg5P0tMTCcKE+aBdd1c6OVr/Bwi6JpUkBcpw7xoeBNFqAvoS4AJVfju64n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8441

On Thu, Apr 24, 2025 at 05:49:20PM -0700, Tushar Dave wrote:

> In the above topology, we setup ACS flags on DSP 0008:02:03.0 and
> 0008:02:00.0 to achieve desired p2p configuration for GPU and DMA-PF.
> Apparently, this creates multi-device group with GPU being only device with
> PASID support in that group. In this case, set_dev_pasid() ops invoked for
> each device within the group with pasid=1 and doesn't fail.

Hurm, it doesn't fail, but it corrupts memory in the driver :\

int arm_smmu_set_pasid(struct arm_smmu_master *master,
		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
		       struct arm_smmu_cd *cd, struct iommu_domain *old)
{
	struct iommu_domain *sid_domain = iommu_get_domain_for_dev(master->dev);
	struct arm_smmu_attach_state state = {
		.master = master,
		.ssid = pasid,
		.old_domain = old,
	};
	struct arm_smmu_cd *cdptr;
	int ret;

	/* The core code validates pasid */
                ^^^^^^^^^^

Which is not true after this patch.

The core code may not call the driver's set_pasid() function with a PASID
larger than that specific device's device->dev->iommu->max_pasids

Jason

