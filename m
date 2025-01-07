Return-Path: <linux-pci+bounces-19451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4519EA04895
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 18:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FA73A670B
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 17:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4427F18D65F;
	Tue,  7 Jan 2025 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AgdUbUnd"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E63915B135;
	Tue,  7 Jan 2025 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736272134; cv=fail; b=jO00UAd/AnEQEvQ4WFU6O6F0E3EamhEO3voBtZYtmZqIiQz1kLHO/WjHKRITSg3F3WqI2eFScTxa28HXNEfYlQ+OU0065icF7Tzz6cw0q1rZi+zdFbv5IiJ3XOC095uO8gx+em/IJQ4bPeYOfhlGhAUVZeZ8w6+U2Et+ZJDIjLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736272134; c=relaxed/simple;
	bh=oZq6FgbrktaIe09c8MC+I1qbIg74zLcoBSmVJtJXw/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ml1ZHUi5Rn4GrxBLy2knZabThDiTSZ49R0Todr4diWnBhLHjXdicKmKLh5vCTfzdSFlNqGyI2w2dOrVoNwV+GGtiNk0Pan/SH/VfGCq2HchuSC5Io/VvmKSUxdiR5t81TMw9SkuCxSr82QvQOuMX/CjYX1xUt5TRiUNTa/Cwk64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AgdUbUnd; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyXqOvVP8SsVWRQ0yA+U4S55Tkte3pnzddb3sqq2WKt/xZ6BrKbBsQwUtLR8qeasDyTc4O2rFj6GtHwiK0JKBmAfIM7vF2/X64zLcT3CwSIQfQmcsQuKTRB53L0S/6LhNsd6+cMES6Bpd4MlypqcGKTTGePlrMKi29iNS75f93zDbu7kjGhuoGq+Sa1QXyyCXgtn/TjQPQxyKftXcSB2CSix06QbM0IHq+50sxXS2u4q8ly+10peZs+bRhCnNwHNYtdZ5NTcquY5RzpxNzN6iTiUq4DvMeOdpHNccpO8mO2ILXbcZwjkM2G03ZJ27kdweYwQnv9Zdb166ZCo9JMxaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOjE6/7CMhF55ID/7hvJZYZNeZITd8ztR+CsRHweEPA=;
 b=nRY4KhpQbapsLd76pdjRUa4vWjoyisu6i6CKL20xcyXEh38PiXhO4q4e15r6lD01wCO5sLCyHx7yssTVAK81Go2pI/0ZYfdMUcoUeqSh0aitha8RS3EPmf+zKhSwbVvs2yCXdYIwGlh83fAciC5QnHg4zM8G10wSJHn8FeJ1t58tGf08I5oI8G1grstnT/RiHjhgna7HYKIFdKFODdsvImvMWcqw22IKaV8HMXB8/SAy+WoVTbP6BwxBXww5iqg74J12RMo8u1ppRWY1iiRACIAXBPHlaKIvTmnqje5ESMbicFHIEHoyuiQqn84r0Jt1Prc1qtPLe3gJxX6diKIX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOjE6/7CMhF55ID/7hvJZYZNeZITd8ztR+CsRHweEPA=;
 b=AgdUbUndJM+Im374q0eXtGIdGZSzT/xZO0iNKiWZNseAPyvpg4Rl4tPwjA9dDM7eFlZmGAKHTTjoY/l+YjdnJBlwWHxAfdJf5SaI9c9MseltC1HO+OC9Ud+HrB2AnF8x8BhG3culRS88mQNINLEzNwsVdKFszbB0aG9nPLWeOLjovC55F5udiqIxiIqSRgVgRVLKbHsdp+izZbXQGlEZaZa+JGNKMPvu2H6eJ17DpMwsQufe3Q5MCwqqFilKTZlAq1XmLBvKvv2eESHfaekKUKSICOpBorOEF+sNhkfsM9Jf82SEc70VKlY9XthLF1fFM5gUvaOIcAa9oObF1qQJOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7371.namprd12.prod.outlook.com (2603:10b6:806:29a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 17:48:43 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 17:48:43 +0000
Date: Tue, 7 Jan 2025 13:48:42 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Wathsala Vithanage <wathsala.vithanage@arm.com>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	lenb@kernel.org, robert.moore@intel.com, bhelgaas@google.com,
	wei.huang2@amd.com, honnappa.nagarahalli@arm.com,
	dhruv.tripathi@arm.com, rob.herring@arm.com
Subject: Re: [RFC 0/2] GENL interface for ACPI _DSM methods
Message-ID: <20250107174842.GN5556@nvidia.com>
References: <20250106163045.508959-1-wathsala.vithanage@arm.com>
 <20250106180140.00005132@huawei.com>
 <85fb2b19-9d15-44ea-8f76-b3cac14e2810@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85fb2b19-9d15-44ea-8f76-b3cac14e2810@arm.com>
X-ClientProxiedBy: YQBP288CA0035.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbcd46b-c25f-4efb-5e7d-08dd2f43872a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hEtchJomMXibyeJ8GdXbk6ZIwp+5sFve2J3ieJzVXry1CXEJVDlqG2w0tmJD?=
 =?us-ascii?Q?liOc9vV/2c2KUDRIaWpZBfolN3fG2k3DevunXvTuMsNnOOw9wmjGXXDwL8HI?=
 =?us-ascii?Q?Yol2YYrOY9i1fYrLF2m75YLTE192W8kUxQPGiErSDLs97Uxdfd2yU5a3YW/q?=
 =?us-ascii?Q?uLhYmp1WOUkq95W3QFRAWi9eazXF5o7esZST2f8eQuL+f2quOXXfkOfXuhd6?=
 =?us-ascii?Q?6WaJW1d299xgmJFHstik6t9rRxL8VlbkHM0hU2GGQc0hYtmCNguxI39gZid1?=
 =?us-ascii?Q?bLyIlDzo9JRgbfQYuWV7Zkq5xJ5uvSVP7mJzAyJa6fZ+1ivxRjLgToi5OQgA?=
 =?us-ascii?Q?IjvS7XDtcUdJQnrlSnm4s45Eb0bKs286cAMBvV9K+6w94KXg6MW+rJ9VpWE8?=
 =?us-ascii?Q?xUt6qOE/4GKmJTruOxn4e8KTGJ2pyz201m6p0o1swcuXlu7IB/55l79KoEhH?=
 =?us-ascii?Q?zjSdIdPJQ8ib1vAIdG68aVLOFPZuFIhJy++3LKvTs1O+PV/xPW2LrT+B2qeY?=
 =?us-ascii?Q?GBwSVrqSekp7xwxn5OT+RhhGnADWH3Hffq7L7HdWXrUBm6P2ir8tG8j+7vU0?=
 =?us-ascii?Q?h6v8AB1IJJ0rtjvutQocs8KevXve912+l+4B47H6Fde0se9o1+wLB7MDkjZN?=
 =?us-ascii?Q?HITa9TIVRtxgqxSgY+eZ9jFnOHhKndI5Lvl1+8RKl3SO/G62lxw6pn2aXIl+?=
 =?us-ascii?Q?tHxzXdgee0SlJIsFKWYl0buyBpv5ZvM7rc4tE7udxDO0+6Ggzl4L06b5XskF?=
 =?us-ascii?Q?xBIe+eoDWzia77jzPkxoPUv1Cga5/CtgCzuPb6KZ3bHHvY9hMt/q0ToZoDIw?=
 =?us-ascii?Q?Mc0GU1BDW3Ki7qhFkwWhkZO/ONTtplSJB8gN6qKkKY9sS2RZ42oMLdzKuVdV?=
 =?us-ascii?Q?42eCvoBJNUns+aMELiVbstr9YvUJZebJAeVMCbO06ZNAc1SjZg5Ute0K0vSR?=
 =?us-ascii?Q?zPn1ADYd3zrRW8okPXeogO0lPxjQDsdOrcF9seoKH583KnVfFT4Sk8XwdatW?=
 =?us-ascii?Q?JAM1KMQy2p+O7fxqptwDMhieEuzaLw/BtMGpcqLQQuXC8V2LoSf+4WnaL/g/?=
 =?us-ascii?Q?tHvsxQvdvNKVmQpunf6NS39hUQ2zXvKPjdLRG7bQMBY1x0Or7eR3snxRD+XC?=
 =?us-ascii?Q?SPV8lQv1wvOhzgE/2ujxbrSQbIm2sxlWOGadlPE4Hj2Ab3LiOAl+Kn3a06ro?=
 =?us-ascii?Q?7jXXwBTvQZOQGA02j3sNBx9kAOR3xEzjTKmuH8VDOmOi0ME8ASTwKRxHbnhN?=
 =?us-ascii?Q?Y7j8Z1igCnQvvoCS4gGZPLjs8evgBYTFsJcfS/ZxEXnRHTdV+kbWmqM08CHb?=
 =?us-ascii?Q?husGM0UDzVaV2AY0iljjZ9OMoaOfu1Gmn4jmErQ76zBY0SAFcBoCO+GJ4lh3?=
 =?us-ascii?Q?kaem7qoRqs8FpA50dzwz/CkqsKVN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a+8A1hj5OQqWMqgBbVKKb/CKC/crrnMZeUf72aPooatRSSMuBBD4AOoUfRWk?=
 =?us-ascii?Q?l3W6pL1obDI7/aZJuChOUapBtm+FjUUbYBXraHWodAvVTQecKPZLu2T/FqD1?=
 =?us-ascii?Q?J831sxUAUJ7lK2B91E36nKs7h+56KI/eDd8MbA6eY689m/RmAIU3R+dr6xGA?=
 =?us-ascii?Q?GP92/Opek+sNgQuYoYMpUGOMDpnevLOgTp/TcKy5v5GV312Err3dhrEX5Goo?=
 =?us-ascii?Q?Q7+tKh0OI2PbrOTJqETEpYn8jurnFKazWY6QjEwYPdbQlFMpPX06ksfExddO?=
 =?us-ascii?Q?uu6ovdqqcXgqLekk75yRZcwvwYz4lzBkWDBMEcyENszGyr5sRxI4ToihmkqI?=
 =?us-ascii?Q?jvTu/13r5IApepLZydF/uUvu+bYdd2uSV6GPbRquEKMMvjrBkpCcQyJwjC8+?=
 =?us-ascii?Q?3sOHdtCruU9d3s0zDod3eoL29w5fpEeJqGqr67Laf+Xgy5IDbJHdSsoNwVD9?=
 =?us-ascii?Q?olqvYrvngR9Lb85trq2l88iegLyNnNLEZXH8zP1PfLXwPOtieLp8FGuBj11Q?=
 =?us-ascii?Q?Du9pok2uiX/Aymt+5BMji18ywYdfLJmxBf4DrPAnsY9yx6UbJXKG7vY4UL7Q?=
 =?us-ascii?Q?YuFSG1b/MNQnyO7rFatghnbr9qC4LTClCDzNetLsFwqXuNGuXJYZfI/S1Gm8?=
 =?us-ascii?Q?i95tLteUJZOr4zmNRMaTl4xOh9qFYfWPLVIBJzkHqSColG7VOQn3wL74kMwP?=
 =?us-ascii?Q?giq2VRJx0o+VFZszgaiSezaHskUO8UNNUk9iMXyifpnILVyE2Zh5ds+5rXPy?=
 =?us-ascii?Q?ry9EwRrQ+sxf/0ozHV7OpI8gbVg4l0FPcokjexkt/f2zPzpHcwztkMJ25Kke?=
 =?us-ascii?Q?qMWxBvCiCSK6nU9lFX9alZCi6gsSwEjmNUY5RlHyfHASwqXN4tZT6d7jQ2cN?=
 =?us-ascii?Q?TUqCTjMuyj/0jSOPFt2sJ0AQL4avhQRr68TCMmd+JXk58uPSQdKASNoZIsvb?=
 =?us-ascii?Q?e1W9g6L2+MRNYN6AQ9S9A1yvMDlXPDDpkLaKRlwmwnuNNYLVea4r40x5+DiG?=
 =?us-ascii?Q?TVkM8e7gRELSt0cxgUE+NJ7QICMrwJSvUo1LoVWYhj82bMpnfsL+nGKzuNcj?=
 =?us-ascii?Q?MOVbPHWOLlyhQ4Swi7dK8E2JljYGOsO3nJHfsMgE7y95XjqDi3v3YnKb6YGx?=
 =?us-ascii?Q?ahaoG76sbfhJwsBvEqQLPhr6uaZNC/P2r6I2/1kkF56BUNV9WcG3/q4qC/WD?=
 =?us-ascii?Q?u0tAAhxJ3h+2fM25obeiYu5xv2rfWVadxgwnZwfIJ5+sQFiBbb6e1FSEauQA?=
 =?us-ascii?Q?wbM+vosr1ZGkEX9IPCxB06zum5SswgYiwsgyV8ZahxIKWvLVJeFPYQqsjZtB?=
 =?us-ascii?Q?hcERPpaiVA3fWmSvyYfh4j0nyZDjgWI8sCXp5OrSZfsABSr13L39QWYjU9OA?=
 =?us-ascii?Q?puqkW+1UQ6Ycl3J0ZG0jdBxipXhmzQ/wrW1duQR8bKCg9UMNZUW2n4iaH+q1?=
 =?us-ascii?Q?Rkm8CdzQozWYf67pAcKbdNMO77EZ9fQQkgxgdPFt0A0npDgaMWrOtB62xhTy?=
 =?us-ascii?Q?qAuFk9HP6R1G+gsaOsbpDhOMvWnRtVvnzFcfgyqcAgVy1oEygi6e1+bXWdTc?=
 =?us-ascii?Q?MsZTiyhy1FgXXU702l0kQ9jKx8sODqyouIv0usfn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbcd46b-c25f-4efb-5e7d-08dd2f43872a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 17:48:43.5317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lseGUTMBZtduSYIPVgBxC9gVCjE/oLQDs7zOqrmcn4f7IuSOBtKyZ9ai+/tS9/1s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7371

On Tue, Jan 07, 2025 at 11:37:01AM -0600, Jeremy Linton wrote:
> Hi,
> 
> On 1/6/25 12:01 PM, Jonathan Cameron wrote:
> > On Mon, 6 Jan 2025 16:30:43 +0000
> > Wathsala Vithanage <wathsala.vithanage@arm.com> wrote:
> > 
> > > Linux v6.13-rc1 added support for PCIe TPH and direct cache injection.
> > > As already described in the patch set[1] that introduced this feature,
> > > the cache injection in supported hardware allows optimal utilization of
> > > platform resources for specific requests on the PCIe bus. However, the
> > > patch set [1] implements the functionality for usage within the kernel.
> > > But certain user space applications, especially those whose performance
> > > is sensitive to the latency of inbound writes as seen by a CPU core, may
> > > benefit from using this information (E.g., the DPDK cache stashing
> > > feature discussed in RFC [2]). 

There is no way for userspace to program TPH information into a PCI
device without going through a kernel driver, and the kernel driver
must be the exclusive owner of the steering tag configuration or chaos
would ensue. Having a way for sysfs to override this seems very wrong
to me, and I think you should not go in this direction.

DPDK runs on VFIO or RDMA. It would natural to have an VFIO native API
to manipulate the steering tags, and we are already discussing what
RDMA support for steering tag would look like.

> > Superficially this feels like another potential interface that could be wrapped
> > up under appropriate fwctl. Jason, what do you think?

As above, I think this very squarely belongs under the appropriate
subsystems that are providing the kernel drivers for the device. There
is no reasonable way to share steering tags with unrelated userspace
through any mechanism. Basically it fails the independence test of
fwctl.

> I think this was similar to a conversation we had internally, which was
> basically to detect the PCIe extended capability and export a 'steering'
> entry in sysfs on each PCIe device which can take a logical cpu/cache value,
> translate those on write to the ACPI cpu/cache id's, make the firmware call,
> then directly update the PCIe device's capability with the result. 

Seems wrong, driver must do this. If the driver was already using that
entry for something else you've just wrecked it.

Jason

