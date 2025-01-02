Return-Path: <linux-pci+bounces-19181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 827F59FFFC8
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 21:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C3E1883C64
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 20:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71A61B4238;
	Thu,  2 Jan 2025 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mMt++m/I"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBF63D96A;
	Thu,  2 Jan 2025 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735848270; cv=fail; b=Z2Tgy/UAyggXR9L/gGqe5AE4Wn3WmAyQoDSzB0IJwe6VD7Q2R2VaelSZxpb50HcePvbx0XTlB1YBNm66qQtE4Cko1P1DARNHmrcHyP6+lmCzZRf/jpYW13DB5x1+/RN/j16K0pYR8erRkwid4osiSS9WhlTLa9dGT2mRjjXSc/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735848270; c=relaxed/simple;
	bh=pN4N2dRG2oYrox7RDYqTb/sjdg6DzPt2kdJ0SPohnGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h+HWhXdovcPwnDix8Z9TAdg4aHXl9uQqHEtv2wTWYqSBvNy3HrrEEMAXeTWIrNYXEJ9U3rtluVciRLCMRdPvvTMH+6w0e5tn4DAgs5pt5aedtrC5PfGKjZAJM3M1yvFW9gp3coBZpz387jeY8ztlhRD/4U14UJh/rsJs+COoRjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mMt++m/I reason="signature verification failed"; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njHgWZ/1Ufasazq2BGDQNqjRLnJPJyChrNaHLk6cBtUUF9uy+UMMHSYEu3KRWFHNgY5kqrxdRECUCGMkzqV3WuMI0n8af+pOoRfJttGodd3T1UT7WGrG3SaSWOLKNW1h5/Zvwcxob9UZmK5ek/ZXDMBPo3LdnUsAXGkBQdmXeY5294P1L3VeJNPjjnZZWtWOZxeOqJWd0T0a5VR24sfdcIMBLzDNihQVORYbH6e1i9dvLqfZm2JJTyZHDYy+92pCrA1Zjcyl/WOvt7CkEYXHqPOeHK756RukTyFYwRhumoeS8NuUUytpFFU4niWEXmc7+uQcyNGe3zv2SJVFkf7QMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YeQHdBvLlloAo3Wm+FPiIGD28sFeU0Ioeytu2G9H+0=;
 b=wXCvzW3DpezX/b5Y4uC1MImjNeImM+rGvoYIvaoWqKMA/6pnasM6Iub8mqSlUw2GZBg8yqiDeoIk517lHs+SKdIa79nAxhJFJqGPpcRZrInGU1cvc2q5DFLXjNCAUFC2rOo4edKul0QCeWN2Y+3iFKkp6G0Qgp1yyvzey8gEnb9qmAIZq1Y2c89uUW7VyN+c1h9wiG/VRwIHmRXSPVb7qfBvKXRL1p7JgZtCzLfUjI4t0hDWxD/qWuCvoBmWYhSpfBBey/6iv9y3FMyQfXInRdl2AjtgWrLRg/A2GHPsv6qfvFvRi2CWuU3p3KaqN4Vx41Q6Qklo9pNenkFcfefK0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YeQHdBvLlloAo3Wm+FPiIGD28sFeU0Ioeytu2G9H+0=;
 b=mMt++m/IeXMAMLGmmTKTJ2sFiuJ/Vd6frwOh54R08oUy95TK/WdzmE3kbTNZqvDvGrDiNX+Mkrs6teGL+Bwn9p2pLpS9eTDxmE+hfhOC1qWH6hT9wTC/ppS2imtWtfoOzRFkW3MhD/+JjPfCIZ9WSDCC07+eNG6uMcusQYjon0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.16; Thu, 2 Jan 2025 20:04:21 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.8314.011; Thu, 2 Jan 2025
 20:04:21 +0000
Date: Thu, 2 Jan 2025 15:04:11 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Suma Hegde <Suma.Hegde@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, x86@kernel.org, tony.luck@intel.com,
	mario.limonciello@amd.com, bhelgaas@google.com, jdelvare@suse.com,
	linux@roeck-us.net, clemens@ladisch.de, Shyam-sundar.S-k@amd.com,
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
	naveenkrishna.chatradhi@amd.com, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2.2] x86/amd_node, platform/x86/amd/hsmp: Have HSMP use
 SMN through AMD_NODE
Message-ID: <20250102200411.GA230071@yaz-khff2.amd.com>
References: <20241212172711.1944927-1-yazen.ghannam@amd.com>
 <20241213152206.385573-1-yazen.ghannam@amd.com>
 <20241214100507.GAZ11YU_9llLRq5AoD@fat_crate.local>
 <20241216183338.GA542682@yaz-khff2.amd.com>
 <3a616457-7f8e-4add-a363-58dea914e3da@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a616457-7f8e-4add-a363-58dea914e3da@amd.com>
X-ClientProxiedBy: MN2PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:208:134::14) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CY8PR12MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd89e84-4f56-4a65-00cc-08dd2b68a5b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?lvoD3WlqTNhhtEjBYTPq00A4OszRKpOFXtp/6TZvFMgq/GUEROkLAussSe?=
 =?iso-8859-1?Q?UuRMb19cxiOk0UbCFmxDFky2ftQG3f8vnvTxd4Va8niJIsyKxHA6tL+qV2?=
 =?iso-8859-1?Q?KkdDUW1ajM3nDuMtX9R8iIz8OTbXLcylsMRPgf6m/aAsQcqv7Mvcc7fdZj?=
 =?iso-8859-1?Q?2jVdbF0AyO2KlBPGX/BVXwhW+IixYifpPT1KidOZNfv3FQWtroK2d8dTrB?=
 =?iso-8859-1?Q?HAHfo5pheGpYTyrjdW25vYZUjdKby0WpfKuHpGhDDUs5ywHEEt5EM4yGkn?=
 =?iso-8859-1?Q?4mfn3uFcjjmMoqdlmIvlzag2+AQ0mzuU4GcXplwt8j3bSIQ537KhmUVr9m?=
 =?iso-8859-1?Q?izFYsFLL30XvYqlHOc3fPOCUVglPdJSUXXJTU18dub/lnIWcl1/zzp2eG8?=
 =?iso-8859-1?Q?jYKjluE3UQ8/sFLq7qSjBvxe4MA3NSPQJ+lc9UkaLtps84aXaVVcsRzYJQ?=
 =?iso-8859-1?Q?tHUjLnYmRnLyW9waB6lvKQVpFjn9uhrNgVXITuah4kilgmqG8e/K4cTSkN?=
 =?iso-8859-1?Q?HrG8txPaLAvcaPYGttbxBGHNzEObJ9Kbji2gO2iIVksXZmEz4Q0JwkY/3k?=
 =?iso-8859-1?Q?XzfIPDTyi7xFC77T80I32/cXP370j5pllwN24sqcA2I+KWYc6gKHHs1+GP?=
 =?iso-8859-1?Q?IX2y2dUaeKHgLkHggO6UL+Z9yY05Tg/SEc1kyXPRaEO5zMGAu83vk7TBN0?=
 =?iso-8859-1?Q?EjIg7xLLdXvxxtr+TCb13vBtsKLGdc/tTTYNeO4bZ3FSQHz6KaQNcRV3FI?=
 =?iso-8859-1?Q?MDsoJ18TvZ4+B11R2y88nwINcc1PzZ6BDnzjsfp+l4TfAgmdfKIQt5mqE/?=
 =?iso-8859-1?Q?QMeLq34uap8CxXNsa3DNSkZ2x8BnVLX7s3dQpCTI4eS2QTpbjr1IZ+8UCL?=
 =?iso-8859-1?Q?XkI3otXOdrF/PdgONxpLAIyWBixFTGO+8MdrS000wuxdIpaFGyhIXDP8GH?=
 =?iso-8859-1?Q?UrRNbSp1eRCLErB3Rtx58y7TcEWjutwipsLt2X1kBWngOkhnivXl54eH1U?=
 =?iso-8859-1?Q?PO3Wp5bDnQEaZoNWrMNcGPE9rMEKHAZJQHpxd2c9TZUNSWB4pH4vc60Te+?=
 =?iso-8859-1?Q?GYCoYpzl73TOONe0MZ5UeM/Jr6ElelQ84JHg7l6VBC3Buve9OtHgOApL9u?=
 =?iso-8859-1?Q?6VyWByTNmNnuetA49JQZUdKGtGUC9iRH69hRyDCu49yPmuw0ZBg9YYjRL3?=
 =?iso-8859-1?Q?Q24EAqaKdU3uTGVU7Tn3lsUhhL+SQ69ORWc2U5eCfrj1IYFcQHUpnUr6MJ?=
 =?iso-8859-1?Q?6NE8mqp9W1p0Mt4tTMgKjgkXx0a4675u22/oxjOeUISIKvU8znf6UAPIky?=
 =?iso-8859-1?Q?ncw+Igw8Q+vMBmKiyR6MwAZdeWPvWDkNSI/kcOT+wB0PMjr0pfKWA5xmQ5?=
 =?iso-8859-1?Q?km6PAyjKrzt00fCVEhMajK2HMz2nfB5DECV3eYpyqCGoqEWCUCQZel4Kbp?=
 =?iso-8859-1?Q?FMuWKF0QrtfWdcHM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?XIOHjZBGx0KGnUHxXRQIVQB9TejfneSigUWOUilTdob8j+Q7FAY3f0ZcDQ?=
 =?iso-8859-1?Q?OmBQEojh86ZEM0GqIMIDPsImohlX41HTJkpTUIS747GZVhzKBzRw4tE4Ac?=
 =?iso-8859-1?Q?jRjKjGP/0PdXcD1Z7Vyj52Ks1BvfQ1Bou9gQ+++3lkiFTK620Sa9MrppEx?=
 =?iso-8859-1?Q?U8ELDZGTh+aCTSkHPq4J2D/F+Zpt6V0EAe8S+VBXCgNycNZhuHW556dtIs?=
 =?iso-8859-1?Q?BZ4zaTlyBZN3+gzqSj04GCeNz8XZ065kk6aGd8CO4Z87fLWYTi37r7Rzix?=
 =?iso-8859-1?Q?eWhXm/XJFo5/yaYuPMvzrXAA8cUxi+ylE60GlnaqFMwHGkxwjj0z2nq+38?=
 =?iso-8859-1?Q?gtxUvqras5AIU9nkc3g6oNtnGOSVXc6wq4ZGTaC+L41yPjHMbG0y1mOhqG?=
 =?iso-8859-1?Q?rp9jv9CdeOqpQGb5mnh8x6mz81ufGxZBL6/f5ejQuehjc9aeGwGdOV9jpe?=
 =?iso-8859-1?Q?WyKTGpC08+JxdpQE+Jf65hQqfbjQjA+Jp1v0lQwwQlTnGSXeUrGKkaGxUa?=
 =?iso-8859-1?Q?3jaBWDjFtgcDZTek5X1hJ5iWclWrrgaot//eBgDdbFLMqnMkqON4P8JV29?=
 =?iso-8859-1?Q?KzDKJHu3HONrkKRgwKUwttcoxVR6+Q9qyHzDwyi9O4ZGCD/Ue2nx2pKkhj?=
 =?iso-8859-1?Q?ySNADiQiCze7mk+yyoBl7dIMtqNjqPxoFZCflXPf3tGWbhvSq/WkzXPTlU?=
 =?iso-8859-1?Q?RZtg54p9g/V76gwd5qTDuH2CaVmqUd8Y4p7WRlauOJCZTqIjg3bugEhAwM?=
 =?iso-8859-1?Q?dqKyvrVuO8qLIsehf58qBMkMaIpxBuMxCJjPWrM8vLlwqT6n37X49G1ma+?=
 =?iso-8859-1?Q?MR2z5Aqidla3blArQdfKBwE5AXQ8Ds6AAxzaqcH67flhxyCSr+CvGOe/PQ?=
 =?iso-8859-1?Q?vdBFcTHLocYJro518wmHlGHCuF8uQY4MDTwRywgzDujNH0bY5BLV9fD1Fn?=
 =?iso-8859-1?Q?OalF1XnyGuIVVjF8/7XrkzU4A4h7Hi/nSjK3eDFdQODSghax1NrI6l5GbT?=
 =?iso-8859-1?Q?xJjycsqvcI8wYu14zidsMorYDcfnFsu2fd37RtfvMSW9cNU0/akQaol9aR?=
 =?iso-8859-1?Q?rgbdxIU0PUZYo5Fkv2fK//qC99v3ohaJGoWpA5/mK/iu2GuAcp0uVo6SR9?=
 =?iso-8859-1?Q?rFE6enwcahuvl5x9RlgOdGsuRwy6A09CO50HSrwZvU6ecPLkIEW8nP91vy?=
 =?iso-8859-1?Q?wZFPFwobud1nf1XUKSgxS/LqAYxnPxA2tdVjR4GVKcl6y6FqmTnAN/9ETx?=
 =?iso-8859-1?Q?OMTuziYjwzRUnJ+KO+MXcpTpR7YvB0616HDDum12Ew/qFcbGZoNp6c+3eV?=
 =?iso-8859-1?Q?eXwTQvx0N9hViffiHsDiUsv4eogctuB57n4RGTLq9f11S20GMUZtcO2tk4?=
 =?iso-8859-1?Q?CF8WFE5olS/XbJ8AAwfFzoFPVCVvbwy6YmVUQl9H9HfAsofASBjiKNIZ3u?=
 =?iso-8859-1?Q?FxQEI/jD9wU5Z4oU7IR01/v5x3pSftv2U/fQOdVWhokFoJYIKWzWFn/s5n?=
 =?iso-8859-1?Q?253YVXuc1J/f/fLNwkoslsy1MX3txpckjyRfLGzI7x8secyG+BArEaFC02?=
 =?iso-8859-1?Q?xsuULY/7KVvCe7CccW/hEyzdJcQYRm7JbJxqSpiVrlbis73ZhEWYJ5GDv+?=
 =?iso-8859-1?Q?/ryWJu1N7bbyNqLTGEpRbwrvQieIEAt5vJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd89e84-4f56-4a65-00cc-08dd2b68a5b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 20:04:21.5844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xYcbsxQaTXt0WIGjzAl1Ju+QwoYG4flghLH8gRTFoXObI/Gv68ARO6sKwCs1qRWUqoNCFwbcMEtboXNQ49HtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610

On Tue, Dec 24, 2024 at 06:44:17AM +0530, Suma Hegde wrote:
> Hi Yazen,
> 
> 
> On 12/17/2024 12:03 AM, Yazen Ghannam wrote:
> > On Sat, Dec 14, 2024 at 11:05:07AM +0100, Borislav Petkov wrote:
> > > On Fri, Dec 13, 2024 at 03:22:06PM +0000, Yazen Ghannam wrote:
> > > > The HSMP interface is just an SMN interface with different offsets.
> > > > 
> > > > Define an HSMP wrapper in the SMN code and have the HSMP platform driver
> > > > use that rather than a local solution.
> > > > 
> > > > Also, remove the "root" member from AMD_NB, since there are no more
> > > > users of it.
> > > > 
> > > > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > > > ---
> > > > 
> > > > Notes:
> > > >      Link:
> > > >      https://lore.kernel.org/20241212172711.1944927-1-yazen.ghannam@amd.com
> > > >      v2.1-v2.2:
> > > >      * Include <linux/build_bug.h> for static_assert()
> > > >      v2->v2.1:
> > > >      * Include static_assert() and comment for sysfs attributes.
> > > >      v1->v2:
> > > >      * Rebase on recent HSMP rework.
> > > > 
> > > >   arch/x86/include/asm/amd_nb.h         |  1 -
> > > >   arch/x86/include/asm/amd_node.h       |  3 +++
> > > >   arch/x86/kernel/amd_nb.c              |  1 -
> > > >   arch/x86/kernel/amd_node.c            |  9 +++++++
> > > >   drivers/platform/x86/amd/hsmp/Kconfig |  2 +-
> > > >   drivers/platform/x86/amd/hsmp/acpi.c  |  7 +++---
> > > >   drivers/platform/x86/amd/hsmp/hsmp.c  |  1 -
> > > >   drivers/platform/x86/amd/hsmp/hsmp.h  |  3 ---
> > > >   drivers/platform/x86/amd/hsmp/plat.c  | 36 +++++++++------------------
> > > >   9 files changed, 29 insertions(+), 34 deletions(-)
> > > ld: drivers/platform/x86/amd/hsmp/plat.o: in function `amd_hsmp_pci_rdwr':
> > > /home/amd/kernel/linux/drivers/platform/x86/amd/hsmp/plat.c:44: undefined reference to `amd_smn_hsmp_rdwr'
> > > make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
> > > make[1]: *** [/home/amd/bpetkov/kernel/linux/Makefile:1225: vmlinux] Error 2
> > > make[1]: *** Waiting for unfinished jobs....
> > > make: *** [Makefile:251: __sub-make] Error 2
> > > 
> > > Config attached.
> > > 
> > I think the fix is this:
> > 
> > diff --git a/drivers/platform/x86/amd/hsmp/Kconfig b/drivers/platform/x86/amd/hsmp/Kconfig
> > index d6f7a62d55b5..fc90ef11a8ad 100644
> > --- a/drivers/platform/x86/amd/hsmp/Kconfig
> > +++ b/drivers/platform/x86/amd/hsmp/Kconfig
> > @@ -7,7 +7,6 @@ config AMD_HSMP
> >   	tristate
> >   menu "AMD HSMP Driver"
> > -	depends on AMD_NODE || COMPILE_TEST
> >   config AMD_HSMP_ACPI
> >   	tristate "AMD HSMP ACPI device driver"
> > @@ -29,6 +28,7 @@ config AMD_HSMP_ACPI
> >   config AMD_HSMP_PLAT
> >   	tristate "AMD HSMP platform device driver"
> > +	depends on AMD_NODE
> >   	select AMD_HSMP
> >   	help
> >   	  Host System Management Port (HSMP) interface is a mailbox interface
> > 
> > With all the recent rework, only AMD_HSMP_PLAT has a hard dependency on
> > AMD_NODE due to needing the SMN register access interface.
> > 
> > Various HSMP files still pull in <asm/amd_node.h>, but they just need
> > defines and an inline function.
> > 
> > It seems COMPILE_TEST is not needed, since this change allows
> > AMD_HSMP_ACPI to build without AMD_NODE which seems like the intent.
> 
> COMPILE_TEST was added to provide build coverage to HSMP based on Ilpo's
> suggestion.
> 
> We can probably add #ifdef CONFIG_AMD_NODE and #else as below to fix this
> instead of removing COMPILE_TEST?
> 
> #ifdef CONFIG_AMD_NODE
> /* Should only be used by the HSMP driver. */
> int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool
> write);
> #else
> static int amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool write);
> {
>         return 0;
> }
> 
> #endif
> 
> May be Ilpo can comment more.
> 

Thanks Suma for the feedback.

If the intent is to increase build coverage, then I think AMD_HSMP_ACPI
also needs COMPILE_TEST.

We could do the following in addition to the #ifdef.

---
 drivers/platform/x86/amd/hsmp/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/amd/hsmp/Kconfig b/drivers/platform/x86/amd/hsmp/Kconfig
index d6f7a62d55b5..b60933806eed 100644
--- a/drivers/platform/x86/amd/hsmp/Kconfig
+++ b/drivers/platform/x86/amd/hsmp/Kconfig
@@ -7,11 +7,10 @@ config AMD_HSMP
 	tristate
 
 menu "AMD HSMP Driver"
-	depends on AMD_NODE || COMPILE_TEST
 
 config AMD_HSMP_ACPI
 	tristate "AMD HSMP ACPI device driver"
-	depends on ACPI
+	depends on ACPI || COMPILE_TEST
 	select AMD_HSMP
 	help
 	  Host System Management Port (HSMP) interface is a mailbox interface
@@ -29,6 +28,7 @@ config AMD_HSMP_ACPI
 
 config AMD_HSMP_PLAT
 	tristate "AMD HSMP platform device driver"
+	depends on AMD_NODE || COMPILE_TEST
 	select AMD_HSMP
 	help
 	  Host System Management Port (HSMP) interface is a mailbox interface
-- 

The scope of AMD_NODE is reduced to only what needs it. And each option
can be independently built to increase coverage.

How does this sound?

Thanks,
Yazen

