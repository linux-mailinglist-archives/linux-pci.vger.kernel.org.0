Return-Path: <linux-pci+bounces-39197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD27C03248
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 21:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8EF14E6218
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 19:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A7534C990;
	Thu, 23 Oct 2025 19:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oBP9Oo9p"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013050.outbound.protection.outlook.com [40.107.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F110346782;
	Thu, 23 Oct 2025 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761246551; cv=fail; b=l6+VSXBQYRJa450FuWcWPgtPF/KMAHc2lo3iuPEdC/HVKKj2p7FwFviq+65PF2uhwYWV0hju0A5eA9T4EHYIHDHn/V75kRC7NKf3E3WTCT9c0/6pRzrJzuru6Q9hTb45kxPmexv2NgUBeGA7MvUm6f4wOJzjCT8CY8299wr/Ea0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761246551; c=relaxed/simple;
	bh=nxbNaROOy/qxB8R7sKCNrOoIQiHGC9UBBnBUo5q7Doc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vEPZScnmYuAuM1siKZBlwJP/GOIB43gGh+htURkSVNnPxD/7GLAr/uL0uY3yNkXW4NoBn0U/68dzzS85DIlLZXjn6WzqCQZIZuIb0dPfo1LZuprBo6GWkIEqwFdvMR8e+Xyu2Z5zbQwzv5N9JMP/AbdP0BkWhMEQjaYWX3Xeu50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oBP9Oo9p; arc=fail smtp.client-ip=40.107.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/4ZDky4eXydIMRpDXm8ACuWAB0aaQ+onwjtASfIqHIVtnnXdodqd1P3OC4dT8qktHC2J2ZzeCs3BvMRzYTFplBI6HCoJYXILm/Otqc7C1Sn6olkXULtyDpctNSLtjM2ugQ6WC0yVVgrgNohyIaQJlCR1arll9etdv36rb9FAJheyzzUHAZmHFOeN4cT7seuwfrXYyMsAf2Ls5CmdEOlyXeLiV5UAhCvSV2J9vpbiUHS5Mx3FQFlwhrksSBRjcrRT8AxB/eA8Ss6FQFfKAT+r4qzreqCo8jfwuhmQeHD/GgyEzpyR3TCOIF86kEQVu1Kpxb/jefTWZGahfJwmNlYDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kM6wVP+i55jNn1ZY/bIPi2QftgwW9vljGRs1YiFCgMc=;
 b=wuR9cXQprsrShCnuLHwUDC28mo/ZMR79179wi9ow/h8lAdRFEFz2VX/V1iJUTWYznpifGHOeor/VCWUZo0j23gNTA+fioX9PxPzTVUHBzC8CxtCzrdPFsr92UA7OLTSnf8/9U81f/yqEZ8QbSWDDoKerVmiILxoyNgI5FxCWtwPMZ94ke9ezyuGQficm7X88YDuFFcqHPldB19aRnEHzzl1cCBVbtrphig3GiZfHsFBbBTx9GrG89NemC/6codv6ZHrpl5fKe7nnOvQqZEMYUJ0G4mNL4kEBKAHRdOQZfXUyBR+e6nagaXZ0LWcHWjS4uqEKJZuUtPVoJYcxIC1cMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kM6wVP+i55jNn1ZY/bIPi2QftgwW9vljGRs1YiFCgMc=;
 b=oBP9Oo9pFUx6fVATgBitcTqX6jdXflcF7mAt5LG+nsAnpHnbXCUEH/umP9vUO66+7rqjz9rNmJ5Anry1TRe5nPG2CRs3XBOXYWpp6FXU9EXXBBsPz4ThrfHZqb7ZGT01t860afr0xSArC6JVEhHqDhZb2wWUjY3ZjMCXlzSBC0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 19:09:06 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 19:09:06 +0000
Date: Thu, 23 Oct 2025 15:09:01 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Shyam-sundar.S-k@amd.com, bhelgaas@google.com, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
	linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux@roeck-us.net, mario.limonciello@amd.com,
	naveenkrishna.chatradhi@amd.com,
	platform-driver-x86@vger.kernel.org, suma.hegde@amd.com,
	tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH v3 06/12] x86/amd_nb: Use topology info to get AMD node
 count
Message-ID: <20251023190901.GA840389@yaz-khff2.amd.com>
References: <20251022011610.60d0ba6e.michal.pecio@gmail.com>
 <20251022133901.GB7243@yaz-khff2.amd.com>
 <20251022173831.671843f4.michal.pecio@gmail.com>
 <20251022160904.GA174761@yaz-khff2.amd.com>
 <20251022181856.0e3cfc92.michal.pecio@gmail.com>
 <20251023135935.GA619807@yaz-khff2.amd.com>
 <20251023170107.0cc70bad.michal.pecio@gmail.com>
 <20251023160906.GA730672@yaz-khff2.amd.com>
 <20251023202503.72987338.michal.pecio@gmail.com>
 <20251023190429.GB796848@yaz-khff2.amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023190429.GB796848@yaz-khff2.amd.com>
X-ClientProxiedBy: BL0PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:208:91::38) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|BY5PR12MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b95ff7a-bc7f-47b5-717b-08de1267a31f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QQ2c9r0tkCnQ9uFCLIWM/UPn/gkHWomYRomHWEu49wD7tlvI7QJIUpmh/viF?=
 =?us-ascii?Q?S/KBN6OaJ3tgsfnUCTGngVsIMua6Ef6EJyyaYYEvvp4TAQSLhmASbSKMAAGi?=
 =?us-ascii?Q?hZhcfVwDDgv6zxhXCefCON6EA6zvTClKlwNHJHF+/Rh7dger61TnaTi1Dfov?=
 =?us-ascii?Q?aA3BusPVK9IUgPTbOA8fPw8hPhOpkI/xROgUwyJvy87P8NgJ/Nvmod8ZKD+D?=
 =?us-ascii?Q?a8oK8V6Q0Up0Vtjm7IEJMqBEN6bHHAJ7kEFkZ5aMWdlnh7uSvtE5KglX79Cd?=
 =?us-ascii?Q?6uKusVNZmwlorW44yf3sih0byG39y3T4HyWTon/0SuuSi9mcrmg+DW5G4KE8?=
 =?us-ascii?Q?3Csd+MUl2Tgv04+MPY/YNV8pzkNYJFxgXUIhkvVn5p2LsaErDjXooLPCsLTO?=
 =?us-ascii?Q?20I3hYYlkYuQUB18GYDiFB7FT/yj2xLJDOHj5ZOS2OZ7B2WQ6vodm/51nd6x?=
 =?us-ascii?Q?GqXACFMjvTPXrsB8ewQ6u2W0+DS0Wrqr6WEyX8K2JSFTcZFONLlibdAZol6A?=
 =?us-ascii?Q?kfghu06OMBPXACB4/IiWYSkg2c1GXfmTops8iE9tPG3JXvicNb1xPSvckBZ2?=
 =?us-ascii?Q?clu//szEitRJldjrpJkb53xQ99DxnHR9v8W8NQ9GLj8I6hf5Jqte8iSktdNk?=
 =?us-ascii?Q?z+mUD6iKbKnN4BrRoaHU8gVYcQfTHeJ9seR3+WFM7AUfL+VIfU2ufLeVm1k/?=
 =?us-ascii?Q?dYh7ListE1acOfU9cXHoKHMtCAJ1IJ7xvi5H6qAxlyVGNqpxf3jUtkFC3qGL?=
 =?us-ascii?Q?jbKGNdbVGWShd7zG6GOsPojocrmIh/uTUpyWVplPInGWj77oXLuoquizb0Ao?=
 =?us-ascii?Q?Q07J2BrKuasNeUsJDtQtSbsxhI+bivc/6zvoxjlZ8kMCrgegCQwHuhBjvA9U?=
 =?us-ascii?Q?6yL2SOg39ta2FWKDlI/+xAkXSD/YT1lNiBXeMmH6fW+DaMZY/t9atAMVI55T?=
 =?us-ascii?Q?5IVCsoxV5/igJCRUIVKaxer8xECwWXvz1oYjYq6z1GQ0shvXU9MpfvKVFu1y?=
 =?us-ascii?Q?/BvsOu0O5IQ+giktTzy5z1fzuA6ZzqCOEYroiWmZMOzEieEzlUfICkf1rhjH?=
 =?us-ascii?Q?IO1azhnmKUuzFx5jOrp1/AKNb+GsO7GcJBPPpZH10chL3EQFT5Uet99Ug8YB?=
 =?us-ascii?Q?gpQhiHpWypuJyvQAXpmKikbyjKpt6KNiE0zUIaOlErBjjL9jLpsOWhFTSuxM?=
 =?us-ascii?Q?Tr61vitYJ3uBR2C+Thq3gxGb+lqm6tnKdlKxXzBZ5QZLaxRZBAkiNb7zK0vB?=
 =?us-ascii?Q?1YkDFvO10q2kA+TRBvzJgHKO8bQz1gvA2h8fUrE/WMBuamXF1GDO4nAS+nJm?=
 =?us-ascii?Q?A0hksNisgXkBer5OSu0L160lGPU2oFztIi5puE1KhpjhHn9zP75c9n8A5dx5?=
 =?us-ascii?Q?yXlOba5MGDNFO7I+8nXSbMOsyU6ORJlJB3OjKjKhlVLXqH9o8MGNb1+96Gxr?=
 =?us-ascii?Q?gftjIfG56rxfQMdq+rcR258E/uLRpHC6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KXTn9RzuLwWIijMl4a2b03lVb/8cAmIJOiXUugVGlSVrTz19sDK+or8e9Y6b?=
 =?us-ascii?Q?szf9ixvJm3ZLzkhXXymHgZy4PDOceqBfaF63Ky6zhSVtDfXd81u3yxIgcdwy?=
 =?us-ascii?Q?Jr+Bky+wx4tztPtqi8xwDzkQU+lYShlEo5J8i1lWGspkQNRox7r8pyS3uLe+?=
 =?us-ascii?Q?MznpAOL6ABF9TDGKtUAfAtlD0ABcukFvDW0zvO2wqhqcUjey/UdQwriyQD7V?=
 =?us-ascii?Q?lRWQvEC6jFNr7/NlIYkJv7om/fyajnNvOsJF5u/5beZY+PfZTAFtm25Dzj+M?=
 =?us-ascii?Q?yR2ncIWosR2IiKfPW9tPpgohfycnrkaMvGl6kRNx71+/ISvqZmyFPV3kq3UR?=
 =?us-ascii?Q?OTG1y2b96jJYLKq5zRh4HjL/gbospXq9fyHDq/8JJ+EzLFAlUp3YCwSLW5ht?=
 =?us-ascii?Q?YT5x5O6THAfB4f5Yb5hG24HAZp+IkqYK9Yw0XTrgr0iQaWcQbOr7v+Pa/okX?=
 =?us-ascii?Q?MimeRlzbwwTAadvQ0lIrXENXm207RJPMPvbIoXXbdc6M29+ubCQ3jSvSPGXJ?=
 =?us-ascii?Q?EsddX8PkeC0o5v/qxiHQz6gTTQxJ4pU7/Zlkw2bIxRMs4SvEvG60wpme02CL?=
 =?us-ascii?Q?G5qi4Ks8Snd2Ai0hKXf+aWLuTu+F7iuzHanrytmbGL+gDlkAbEuQxOD+IziT?=
 =?us-ascii?Q?UQqT717gVtnImrtDFtHlM+o8XXrmvkZ+u0B5snoM39099ltuVLKT3RUImaLq?=
 =?us-ascii?Q?/OQZRmwuzeA02P8X14/6Sw6O5DAL29cwpk06z04KlTji4oinnWUl9F2LdnK9?=
 =?us-ascii?Q?0ojlM8hCed7AOHLnkvweXkEzXYSSnsR9P8soTI2Mr2AETLPBbtr49bckqA4z?=
 =?us-ascii?Q?dh9ccWpmFGNoJnO78WFLq9cEpZMsVzZxjFPFny2i+XUW7uDPCjnV7zyDt+hN?=
 =?us-ascii?Q?1uWrcELp2T7oRZCl7MAzu8fu8RpLN5KUOwhszSxLqDkqUwn2iCs6TCVNczkL?=
 =?us-ascii?Q?bvcJp+Upo5W22ob+kVlxTtzeFFuWyHWGTROIAQuAHRnZMgLsg8dJrARoIHQ7?=
 =?us-ascii?Q?rye4rNuU1i5lGpaAHdESsMbvRwA1B5GCgUE2rVuta3RVN2eB2NGWxd7gfs45?=
 =?us-ascii?Q?dnQEPLcNdJ9SCy1qweFZTwP2mo7fKQTCVhg4Jy+pdUhgbT1aBB21jrkuM1g9?=
 =?us-ascii?Q?t4Yw73cuJslWWhTE9wx2PY39iLN3V6jgOHNClDoEKbQglIKTEtHDmiysK2QA?=
 =?us-ascii?Q?oubGfMGd9mq4PjZVLnojiu+3/r790RGJ38lmqGXrl5Y8AKT5l7R2Gb+8C6hS?=
 =?us-ascii?Q?4Aa3BA995cNjzCgPm0VZGD6FWAAYSdRBcpO9XIr50WDVXteTVmYso4hdHRC8?=
 =?us-ascii?Q?voorI+jJoXlNSpAQE3dowHpLywBi72i91j+K9DZKwZ14fRdAGr2tdSePuTSv?=
 =?us-ascii?Q?6m6x/jJ5cV/2mMdVqTxAdnX/X4aVLrU3BCOhCDOUNxVVLpxg+pN7++oIonwi?=
 =?us-ascii?Q?EUFu77tBs8tm8ueREXn4s8hAjB40eIBdC6hY2SAXGKtUuLtWxmI+rqGu34HJ?=
 =?us-ascii?Q?8QqOZjz5HeMKK/EQBCFumUteg7mNouZ12rsEA1kRCwSs2kczW+G9uQyfZNEM?=
 =?us-ascii?Q?Hj0uemqNIafR4ylAP+p+cTGaqWII1+blRn9rbAXi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b95ff7a-bc7f-47b5-717b-08de1267a31f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 19:09:06.2772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7lmUspHVwHG2+NKa6YKFpWeZKETvRcvKKm5VZJLmX5h+l6Yoqya+ecmJp8CwdHAbxNhP98pHSQO6HGiVcN6mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324

On Thu, Oct 23, 2025 at 03:04:29PM -0400, Yazen Ghannam wrote:
> On Thu, Oct 23, 2025 at 08:25:03PM +0200, Michal Pecio wrote:
> > On Thu, 23 Oct 2025 12:09:06 -0400, Yazen Ghannam wrote:
> > > The kernel seems to think there are 6 CPUs on your system:
> > > 
> > > [    0.072059] CPU topo: Allowing 4 present CPUs plus 2 hotplug CPUs
> > 
> > I wonder if this code doesn't break systems which actually support
> > hotplug, when some sockets aren't populated at boot?
> 
> I don't know about other vendors, but we don't do physical CPU hotplug.
> CPU hotplug, in this case, is there are physical CPUs already in the
> system, but they are not enabled for whatever policy decision. They
> could be disabled in BIOS, and so the MADT entries will reflect that. Or
> they can be disabled by kernel parameters.
> 

Sorry for the rapid emails. Here's another interesting commit:
f0551af02130 ("x86/topology: Ignore non-present APIC IDs in a present package")

Thanks,
Yazen

