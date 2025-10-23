Return-Path: <linux-pci+bounces-39196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B743AC03211
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 21:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C29F3A1CD7
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 19:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FC93431E2;
	Thu, 23 Oct 2025 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Io0uDMB9"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013022.outbound.protection.outlook.com [40.93.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C1A34B695;
	Thu, 23 Oct 2025 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761246284; cv=fail; b=lpBe0HU5/V5eMxMyEYvZma9FbYK17FkxpJZQ7mdtVAssXiV5qQ/mXpFdqf05dIx1gikC+usA9+MnWv7WJndkt+GF+l1Nqv8wpAKgYVociK8kiiUZY3Q+0/LbWxC/fLlhVR0nG96yZpXK75z7S8wjIYaIeasyojXAnJdKYnL0YfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761246284; c=relaxed/simple;
	bh=+nB0FBK5qn6iITc7wCz/OZwyz6P6u667OpC9V7Ercaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K6H6kQJQSR7XJUlPWMzHgdXLgMndirULRRsnhOJpNNBfW9Tcl6mkXULt899JCv6H0gcGvEPayevjO+VoYeMacKu4J0XD7ASwmr/nSmFe0GEjKmYo/qcL2Vh+WVXdlvqtOwgPJ7LljfuEo1H3mEg/iw67l4GyAxRmckEHJ/T8g00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Io0uDMB9; arc=fail smtp.client-ip=40.93.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XO3mZGu73Cvqx8rCczTWu3LygP1D7gDlJVBvqHUYd7vohzcCLMrzWRcuUiscPpWrkaxeIL/QEWKZlRxJ8BKPs32EZoS0R7iKA/6J7ZEGiSaI5a7jBcjIbMzomD8oVEVl6kQhsE10qLE9TYMdkM3NpNKVnadsFZiAt9zXnH71012WCRlzxdTpP2pwBU/h2cFMhZhjwoy6nkXwWcyrmjyLShC3dHzmWwnvOvpA5yRk8YUzIVVfaJr7R1Ew8XRbtFwOtb0zCmwDqDCg4lbmz1hg+ltTVDn2zfMUgJga3H2zVDw+PchunxM/i18PRRJPKxKk5MEN/giNMA7L4O+RFRQoFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Md0aQaH0NbYfpCEyWWdr3Sdb+WLcnLvpj0EZEvRtHuc=;
 b=DIYVlZU8M1YqUjthbdC4EIkYkkMS6yRvQ9/hevLisOl1CuvlABNTPmhyupjS556mYbvMV8427wsurr1Mijv/2xlNwd2hUa8bbwNLIkzC4Li3W437zwOX+RM7nhv7CdJQLOGvBklOPF8Jo2CwHv/TlvTDUqqouN3TVI2E8IngYfbOMGm5QgViouXyWsud96yUaohJ3aJ6W1f8KH9162EPRouMNZaCZFxde14GwUokXTXBRWPxjf4ZSjdfQkAMu1PLtHFAGjSkHklQQi0kcVNcIXiuEUo2ih0fw1BdDDCTpaYP4EQWU8yUd1ZBbhqGSmjZUJhlg73BsvHszJJ+2B25OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Md0aQaH0NbYfpCEyWWdr3Sdb+WLcnLvpj0EZEvRtHuc=;
 b=Io0uDMB9wP9a0FApjP6BfJwyarCUHcWLQN/XYsNs/gLqOhrVbbiY7ZodBf5K9IPGdn/epcTBDibUCljeTQE+QDXQYjsjytrBP3lWRQgkbBscYy8+RS3CQ7wuj5azzyVt4PK/vKy+1xFmAaMUXfvx0+f56zxTqIkAxnqPgDlr3wI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Thu, 23 Oct 2025 19:04:39 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 19:04:39 +0000
Date: Thu, 23 Oct 2025 15:04:29 -0400
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
Message-ID: <20251023190429.GB796848@yaz-khff2.amd.com>
References: <20250107222847.3300430-7-yazen.ghannam@amd.com>
 <20251022011610.60d0ba6e.michal.pecio@gmail.com>
 <20251022133901.GB7243@yaz-khff2.amd.com>
 <20251022173831.671843f4.michal.pecio@gmail.com>
 <20251022160904.GA174761@yaz-khff2.amd.com>
 <20251022181856.0e3cfc92.michal.pecio@gmail.com>
 <20251023135935.GA619807@yaz-khff2.amd.com>
 <20251023170107.0cc70bad.michal.pecio@gmail.com>
 <20251023160906.GA730672@yaz-khff2.amd.com>
 <20251023202503.72987338.michal.pecio@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023202503.72987338.michal.pecio@gmail.com>
X-ClientProxiedBy: MN0P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::35) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: eb06a30c-3a81-4fe3-ccd2-08de126703e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aq3+7jM0yI7VQLRv2HCRKjrvZ1gw5+3cM3IVYFaGNgbH4hhDkc/QZubTDsDw?=
 =?us-ascii?Q?t2US3Sks2hdiKO66MVoFoB53XK9+t6WVoYQ3WVyQwQPGr16t5VSlfOlRMFUg?=
 =?us-ascii?Q?iZm7JFe6KNbzU5vrIIJvo6CwQ0TDLjoSLqsb1N9BSJkagP076cscLO7RzAJT?=
 =?us-ascii?Q?cx0aGLJ8+PueVn59wFhaWo3419KMZSkvA69B3c9Mp1buMIYbz+XsMZX2275L?=
 =?us-ascii?Q?jSnAXWb7UaYZo/rdJLtHx6WL0sfB78zcl+mo57NK4qq9v/+iUzoVzVkFvWjA?=
 =?us-ascii?Q?IvulnOciGEl4lxOOeHjfsczHxCV2/fPDqnEJoRcppwb4/mqtJzcN4d50g1s4?=
 =?us-ascii?Q?RD/MPshlmLjVvFV2CF6ZTtwIkB2fXbCCPi007LNardPiPdVQiswaf3o6Sypo?=
 =?us-ascii?Q?xqs25jgC/nxTuM0DVlrnR0+F/SjMHZMHGHFdlSxE6A480GHCoAzmu/TGzy6F?=
 =?us-ascii?Q?9Wrcg3QqIo+xcHO4hoXeGfC6WWSHwtfqnwTd1vEfF4WNI94eaRgXoKzoiP4q?=
 =?us-ascii?Q?Z/SKNGYVyKSrYHcTVPbOd/VBJ2kSFYpFDWT3EmsLPIP77iwSTbMijEBf8VVp?=
 =?us-ascii?Q?UP9PT2OSvl0xwybsGgq4ZfjS0nIRGK9Nu98gbgo6Jr202KosTHWsPS2MdIIu?=
 =?us-ascii?Q?XX7ROJbtm0xpcLlt00bGXTWLGTby1PwsmjugNlUZKe+7Ey8lbYPZoWrYYI6U?=
 =?us-ascii?Q?uDZ+6XRyvkrbKp7G+LJyyp2FSau9mHuAjI332BMis9wH5YyJaZ2KhQxdcKPn?=
 =?us-ascii?Q?DGq5b3Qs0gAjoT+N2aBN4Zo5sKLsgYEg/Z7kGQWjD7xcknxn/R2/y0Gwq6fR?=
 =?us-ascii?Q?JnFUBVqW41Sbis/mEpGCG1I9OkontPlXrA0Ck8Ggpjw+xsa/srgWz0c8hUOH?=
 =?us-ascii?Q?5PBtMawSOHDdin8n/IEa2FEbnaORZgmLp2sFk/xOE/VIsNhzvvmQTA2ewBfF?=
 =?us-ascii?Q?SkCo7tHAEs6wWMAF5tEC7a5ek7BP9zJ8m/LIdNQxovIh3G7VnAXu0s0HypOm?=
 =?us-ascii?Q?WEhWkKNYNZxFZarNooMp0CK5kDiRYVQ0c3XiBiKhZuj5Wz3UHxulvmNUJHcZ?=
 =?us-ascii?Q?qhmdrrQYCdzqXlaTtzkBlOIRQyu1bKKC2MbDwwomG8esczafHptL22064tdE?=
 =?us-ascii?Q?sV+x3RUH7MRnujhmch8/fACSc0KUFw6lxXpztTRi9ZGuBqAETbJQHO5yTt0H?=
 =?us-ascii?Q?JyQqrAR2IufmsDhKKbRj9px2urytI+PMFldCbyJ4q/3j8e8YT1kz6pzgbiIA?=
 =?us-ascii?Q?BHMlKeFGwTsQQHFqxRHuUvrntxwzm9UGJ3zZfilYQDfNp61Wc5PiNCkPERUd?=
 =?us-ascii?Q?PBSafXbyiUQMFyn1vZ1xnZJ3b4jUvgQu4TGBgZ4MH2NSAg4YJUk5nS402PQT?=
 =?us-ascii?Q?Oas74+ecLP5rvwhwFDrj/3elmkGQ/XLel/J76TXQ+msaVC/f9qhfHjkWxrZd?=
 =?us-ascii?Q?gASLkR05zCZM0BHmxrS5V/4JsVhCaBqn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1AYWU/dET7bVw6bEkj0QsDU1PN97ufeg2B4h+EztvFf8V0hNMvZEZf8W+7no?=
 =?us-ascii?Q?Hg6RK+oGpWPDyxq62BTTLkqDbMSyVk6C7kRWHm7/0bkf/h9JdAp8GSrSCs8z?=
 =?us-ascii?Q?/pchIXZtquM5rTCg8E6sTifkqSeFZRA9+IZYs1jxY2XAKHfxRCZvLCNQep57?=
 =?us-ascii?Q?2yFxIeG2opsYbAy6FFsubHZS7RN67Z6/XyX/ubI3YCSdkUduUQi3PavujIyz?=
 =?us-ascii?Q?tUgeJ115WJjOWV2va8WSPv9xQfWhuGEnxRrrtqs+cdOFtmwpP1EhsMG0naqN?=
 =?us-ascii?Q?8WMyIvJw0rYRf+ybgHwUD4q5EZq9fwe6u4Bj/3ywF7fVUhjIFHgeKDNF9GoW?=
 =?us-ascii?Q?h7o5kwpyln5aF/ZtNyXtec3nfUdj+SXBpu7tctNNkgahmUMhKEbiYVjlQXSG?=
 =?us-ascii?Q?rmxMKH/ogovRxEkxSDUaWT1+hT4SD/N+44fywjstydLqBYXqs1UutFsjSjtZ?=
 =?us-ascii?Q?xa9TfLER7AWnqa1eVItafBgDNr6qqIWKlLXjHbk3znwdw9OP82yQSZBumHDB?=
 =?us-ascii?Q?4DFE33Y13gMA7vAKXwNiCOobKvR0Xz/pHpj1t9dcdw67fMj1rlk2zxOs98t7?=
 =?us-ascii?Q?e8+xJQa6ytMm4Ipgj6vss+PBIZsTo+4Fm5uXmqBIZP94ENxLHfIyoItTiY3o?=
 =?us-ascii?Q?J3d1d+yHt/DN3FN2CwtJm4giBRLfTgMnyipGuZVqNAbzVqKPGVMDJx0R4R3F?=
 =?us-ascii?Q?eeLoL1L620RijyHFQYJRq1eVBovn740S/HktTbQ8MoxDqVUQSYLTblq+rNMC?=
 =?us-ascii?Q?yfvfg59HVwY0wa9534w69tCzOc6jrHicMyVFSyxwAPlxH9VBRkQd5B4e61p2?=
 =?us-ascii?Q?6iel1yerDZWBJIydHZ3lubQ39meRHhdsJYHwo2oADgiSoeMx+9+CXMt61W+0?=
 =?us-ascii?Q?kuropKBtJrkEYu4cUwFhASVF5tWKOsORizKFswVjFhtkgdyrcDwcyzD/naDy?=
 =?us-ascii?Q?iynuBgaHuFJ5S81XnEYkKiCDhr8qMB1b1Lz+0tk7fMKbUSuVK5zeM5e6TqWO?=
 =?us-ascii?Q?1NU3UOnkxMrJOZDof9RXTr3v6S6tTMRgpAOkzZYu/iueEQAcrsoab5FYt8iZ?=
 =?us-ascii?Q?Wu5F543saTVpJ4/nutzcSBv3I7SeUPOvnBcOMyiE1pZYKOGyOrIINh1hPtK1?=
 =?us-ascii?Q?ImEnZfRDxlWTYDyQbq3F2r2K/GBlKke8i7r6NtvfR5aIkwJ9S3ZmOnXrt/MH?=
 =?us-ascii?Q?q4nbN2SEO2CZfxxbUmhy2NwAkW5636x1w4U/rURRF8Adgt7ljDYmylJYO5Bl?=
 =?us-ascii?Q?xgsHrUOXVf3Rcznha3Rj3rx/ne1Ru2pC88nF6dZ/ceI84bBUgZ/QHrR7kau0?=
 =?us-ascii?Q?mYRGXA0EHPttM8dpQWeQMOPFw0qmADqpRM5Lez9pQQpgfmBpwPgh5BcLo3EZ?=
 =?us-ascii?Q?w02q/Ornaywn7tfO+6kWJykEustDIn+zxQBzTfEyqBgjZAHeydZ86CrvtTbE?=
 =?us-ascii?Q?zwvOZgkVcz1DUwzRT2Z4ASuixiH131KhnfAGsZA2wBk+A35XeK+/rLtcFPev?=
 =?us-ascii?Q?aTsqNiC/BSlyhikqFD1uO4sDB5twa2aHU9Ysllg1cxIKcP52YyWKc2YhnV8A?=
 =?us-ascii?Q?N5R0HK0sa0NMTPgqddXbYBbakrNkqLcF4aowm9KW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb06a30c-3a81-4fe3-ccd2-08de126703e8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 19:04:39.2062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AjZ5R3gpgUs9DTkkQ+fcqWODqs2BAlzmZi84KtgVr100sF5gkJxwYlKhThcp/3xQNf/4uTySCFGwGsiHoXuew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420

On Thu, Oct 23, 2025 at 08:25:03PM +0200, Michal Pecio wrote:
> On Thu, 23 Oct 2025 12:09:06 -0400, Yazen Ghannam wrote:
> > The kernel seems to think there are 6 CPUs on your system:
> > 
> > [    0.072059] CPU topo: Allowing 4 present CPUs plus 2 hotplug CPUs
> 
> I wonder if this code doesn't break systems which actually support
> hotplug, when some sockets aren't populated at boot?

I don't know about other vendors, but we don't do physical CPU hotplug.
CPU hotplug, in this case, is there are physical CPUs already in the
system, but they are not enabled for whatever policy decision. They
could be disabled in BIOS, and so the MADT entries will reflect that. Or
they can be disabled by kernel parameters.

I'm curious though: what happens if you try to 'online' these extra
CPUs?

> 
> 
> 	amd_northbridges.num = amd_num_nodes();
> 
> This count apparently includes potential hotplug nodes.

Yes, but see below...

> 
> 	for (i = 0; i < amd_northbridges.num; i++) {
> 		node_to_amd_nb(i)->misc = amd_node_get_func(i, 3);
> 
> This is a wrapper around pci_get_domain_bus_and_slot(). Isn't this PCI
> device part of CPU "uncore" and absent until a CPU is hotplugged?
>

Yes, and no. This PCI device is the Northbridge and is inside the
package. These don't get hotplugged. If you had a 2P server, then both
would be there from boot time even if you left all the CPUs on one of
them "disabled". You can do this today if you have a 2P system and boot
with maxcpus=N or something similar.

> 		/*
> 		 * Each Northbridge must have a 'misc' device.
> 		 * If not, then uninitialize everything.
> 		 */
> 		if (!node_to_amd_nb(i)->misc) {
> 
> And if it's absent, all previously found northbridges are ignored.

Right, it's a bug if part of the Northbridge is missing.

> BTW, kerneldoc seems to suggest pci_dev_put() should be here?

Yes, I think you're right. This should be unwound properly.

Thanks,
Yazen

