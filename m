Return-Path: <linux-pci+bounces-19363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30543A033CD
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 01:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 465617A234B
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 00:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60516259491;
	Tue,  7 Jan 2025 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iwRnpG77"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C90C15A8;
	Tue,  7 Jan 2025 00:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736208629; cv=fail; b=soYGt+VpWe3EKPHa6X9GQ/lAJNbxawBkp0ckJNUqxccKo8Vc72YVGNEJQTKjl7Vk7MJzcOOS0jDT1vMTIrjKLBQaTdErSSTW+f+O9HgVvx4llEQLrmcVcf32qAV0yoN/k1h6cCBihyfSRC4LqVmQARPY3NXbdLgrhhXnbBu2qNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736208629; c=relaxed/simple;
	bh=quLFH93gakE2QbLEhSPD+nQG3ZXMDoLN+47uaB5C1C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oJuH0PVLfbwj5rynHGsr4w0HnGZniXEsdDpyVJjHV2Cd/zafmzR2kaK4zCPssYq75wBksnBk4gNEDRdasXKaWxuB4Sj2uukpt5N/8yLj9mKaMI6sT+mhS3vcde4hKD86GhTYsJpsddF+GdAlteFhPFDTV6+09uxuXw9coBeD2vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iwRnpG77; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihL2kWVeS9wC3YEKtmaxLS+RmfevLBxoSZ/6G4/Bd19UDpyhMm1B9aN6oYf06oZs6CVGfCiK3Zr0ryp+gLE+H5pO6nDvyL0BzOMAACZqgSnESjnrAqbuR4I90B0yJqCtsI3ZE2MRV2Avsp8yqiggoTft8cepuNXrwESaC0xUB2RfQSaS9U34gZXlFlY2S28K9eOIbitY/97iYlyAX6VkgfhQChNEHTglNWMwSdn88U/OwTPZ+qP6lIOIyPObJ20seyHBQ0nfPnmNFYwIuPD+lGBrmpqyBS4ejE/DsO4Vv229nr7OBEpCTfuGANkcSJA/kLrzKOJ9ky0nSZ47xavxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEH0iuoNPE3DVeXOzkGw9f2anDRwDkvsWKMU9H0Qtss=;
 b=VjnXd1IYEx8w7uxKF3+pxIywNUDSxyOqMLAD2TsWs2GsqYew1JoHe8og/3v3ei5NC6MO4w61/2eIF/+HB59gg7GxCROCBr2N554Vay5Zx8n8SxZavs5E1QruEBU5vSsjADIKrS6grPaGgcGbKeaGVKvPLBnThPTklVO2mfxUCQl08mS37kkmkzbLMBYWugJ1Tr14ecV7My+IEyjXmHL0A65WUuIXi4VL+pj3VQEWCt5+sakskPTJFTc+5VCr4UQHYu1x1ZfpPMkHhIR/XYfGP8M08cMilt3snx0znyhTMoZuq64Z4fn1KCBOJl076Cy+BafWehkTynoCEqpkEOJ6uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEH0iuoNPE3DVeXOzkGw9f2anDRwDkvsWKMU9H0Qtss=;
 b=iwRnpG77b0rN4Hffx/iqZiF8vibu9Nr8VrZOqBAGcBw2xXTnzeYu3kZaPASQPdsbipP3+WVuvBOxWTCAIiLohqQ+e3g5Ela/dy24w9W/coA4MumCsiuEsfHCSEIWQWdfpkuSzOP/L+EHrVg0oQkHQaKydpF/AU+cWqaOs9eVxjP7v3l7wPw5MsxHXRXKgcynsJWjLhwYMIDXO5LPclAK8yps4Ev8LF24QZCXk+0LMO/4BoH0UkkA4wwUy/ngKY+3T6Wce7AL7ilAkGAB3fP30YOn+sD63ISGeCMlyxcBkvp39PAh8+HuZZQ3np9MNPX2jqUEFZGx2ZxTRcBqoCgn2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by BL3PR12MB6642.namprd12.prod.outlook.com (2603:10b6:208:38e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 00:10:20 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%5]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 00:10:19 +0000
Date: Mon, 6 Jan 2025 20:10:15 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tushar Dave <tdave@nvidia.com>
Cc: corbet@lwn.net, bhelgaas@google.com, paulmck@kernel.org,
	akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
	xiongwei.song@windriver.com, vidyas@nvidia.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com,
	sdonthineni@nvidia.com
Subject: Re: [PATCH 1/1] PCI: Fix Extend ACS configurability
Message-ID: <20250107001015.GM5556@nvidia.com>
References: <20241213202942.44585-1-tdave@nvidia.com>
 <20250102184009.GD5556@nvidia.com>
 <2676cf6e-d9eb-4a34-be5e-29824458f92f@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2676cf6e-d9eb-4a34-be5e-29824458f92f@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0445.namprd03.prod.outlook.com
 (2603:10b6:408:113::30) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|BL3PR12MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a79086-4bca-43bc-355b-08dd2eafac17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YRXlPT5jvhXmp4SfGQBD5W3/3uorkIAN8l3BW3eFhJtR8Deqh91noVtYMkcC?=
 =?us-ascii?Q?7KPy6553bxqnvuFopOnyQPcA9x3JqLzGy65yX4DQTgpjwJoRS7Hh06gA8vD9?=
 =?us-ascii?Q?vxe7lbzgohYBwetP+ZcIzjaJg91ynraT2F4kN6qUDynsCMsMKI18xYI+E1GZ?=
 =?us-ascii?Q?Z0gMp3OxXJYW2my4o7fFI0IkVzN9SWk3bxLJyzIj6wGxe/St7BrfgSbmuiAr?=
 =?us-ascii?Q?O6O4SdU8Qi0MdC10urvIsTknShUzqdEnUWbpNBoLpStivu7ro2o6BIBJidg4?=
 =?us-ascii?Q?OsAGkm6Wm8tsF6G1KEZ2pClfFnhfWxFB1b3StXAomOwYrsNpdQLf3dXs8aqT?=
 =?us-ascii?Q?6wsC338Z/9xx4l5uFmw8YouMnr6L57gV8Zn13RvMLzjJs+eDHGdO9wZsbg2v?=
 =?us-ascii?Q?gh5eYPmaz6oKhhpCaB7KGcW1weVzT8W6Lhu1hsbb3KZ5Iqje+V3tVQJfYjsy?=
 =?us-ascii?Q?rFgwerBItBdZw/NCl39f47IY5aA/Bu7q/pu8JuZYSAXdFXI9MeofkRgmtWEn?=
 =?us-ascii?Q?ghwkQLGCQdsDKo48Qd9480zvoNOD7vRfb4HFum/aP9fvmfAfBLl0nbV4P6xX?=
 =?us-ascii?Q?6T2CePJCJm2nqOwzWfcP8Cq+zXffqKZY3TCfUq/d7F+Nov9TSsGbw4aWhGjn?=
 =?us-ascii?Q?coVBGk5fKUFhehIvNOWmY4fMXNRhCAziY46DmnqSyeOeb6z+RVVG0fByFx+g?=
 =?us-ascii?Q?IjPFymxHKCJqy6hcgFG4V8YnPfox2UjtR/+ZrWqTYPZZMsmkBf0+JaOQAph6?=
 =?us-ascii?Q?Mpj3Sd8hWI6W3rKcNFMWJ4FweGxyubLRC4hMRgcgbD36XOLW6q0u3pRh3JIB?=
 =?us-ascii?Q?5RUNQRyTxjh2+hFl5ADC34oZEuC4sQ8ycFTxvP6KcjsnG/nTGvC3JJi5XAFi?=
 =?us-ascii?Q?eQPr8kl9BpiybfRuddK8PLj5oMCmgTIEUDy7WJks9GFZAjSVjcybhF5OuVQ2?=
 =?us-ascii?Q?KhXSD1BNPSZ0zTWgSGkzchKwfboulWVJviAlcPn509qsBWiUzS7iaCQo1Pk3?=
 =?us-ascii?Q?wSfD5yjyGZKncgi0ryXPjo6HizIr0zWX0QxHtk0tRD7pWatozfnpVkagEyJa?=
 =?us-ascii?Q?Va54/MzigATDSpcAUCymjiGu9RYepYz6GZVBzo6zYD/brTz520CCMI6b2Es3?=
 =?us-ascii?Q?us4DppvBNuNPnl7YZyo92DlQcM7QLJs0mNmygD3H7y+rYR2CEJjCo9gZnSYx?=
 =?us-ascii?Q?CGg5V7tGaj6gf8U/iARHZwBrmAKbr6BwTyPaDIRLDciIHD3sSvy///VtIdr1?=
 =?us-ascii?Q?JJ/QrqnBOccZqCXOiU5nyvRMJhCI+k9y1wQ9tZR/2T7vZSBfXmOhNKgpGwwv?=
 =?us-ascii?Q?MT8CuAhZDDRwfg0V0AbFdYPEtdDxwBuw9BKg2PyKyUILGBUyUhfSxiDp4pp2?=
 =?us-ascii?Q?7unxe4Yz9wyiEI44AW83917GY/5E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B/5Wg59JfgUZ6vPwDwJwZ//sLqoxflKAuqDMAAKqUJRbh7w3SbiZhRD9Njx9?=
 =?us-ascii?Q?R0LOn7jx+VhUFEVQIVTqrjfJai0wi35beMRpUY0sHYq797bbPGvn66oazmW7?=
 =?us-ascii?Q?02q3Gy5ChDVfp/lCLnRMedJWskri7DpLQwk+lU1PgltEWq8GXLWql62nNYEt?=
 =?us-ascii?Q?56K5TGmK8EcwfdAP5chz4JVI0PGgdRdQOvUhXUn9/wfQnO8v+iZJAW1wKBnW?=
 =?us-ascii?Q?RVbjqAEaKdAbFMyb9WnycLRyTmhlmUT8JBCup+752oZb9p+cRRVQbkIN9sDn?=
 =?us-ascii?Q?09PQ1OBryLBfEYIGFYzASnlG1zdKgNZotQt5VmYs/DAXLSWSUufDUnF/BMlE?=
 =?us-ascii?Q?XsfV4yeNLEq5nsOyVDxsOxjX39rWzgDGiUfqIIg7idqOLSD2K9YreFtf2LOF?=
 =?us-ascii?Q?rYxIxpqXQijCh/2aSy5V5wxGAoVA4TVeRItWmVQ02lyzZfGBfqvl5HYrO4d0?=
 =?us-ascii?Q?S0OVrK9Krow9NZ23sozoZe4INAgw15vpYx9NiBRCroS8pPExWbiOyGflRBrV?=
 =?us-ascii?Q?Qh0BpaYbVhou9dspWOmp493c9BySpixXKui4PXIjr0YeUHmvtlJ8cMav05Lr?=
 =?us-ascii?Q?eCjF38HUgze3RRAZV0wBLa5NaggMxQis5UUGMPXNkz6UqtMQyGgl0K0krOBF?=
 =?us-ascii?Q?jjOg1EYh0VJdFHceasujE5h52PuFeCS0j53Uu/lmhjsA1adXEMuK9I8LJvrx?=
 =?us-ascii?Q?RAqdh5wm5wVKguj22iloa0c1UnVYSDMKXlV69aWYhf0XpwXCWm2AUR7AnZoQ?=
 =?us-ascii?Q?2ftHJXgrQntauysQcZww/lOOoKFAQw6CMD1+ac6Rs9XtcyjSc7rI3mVD+uRQ?=
 =?us-ascii?Q?C/8kpHRgBXQMXFOuHdX9jkOD8f8vS0VqjwW2Rg3tnQG6qUnCd1bg7Ok84NVt?=
 =?us-ascii?Q?CPJRzu+N5qNlkQE8KYb0OKPWmm6yPEjcJ0GdJwT/hdUiO3NE0jLsLIxG09jH?=
 =?us-ascii?Q?UJVRi8eZjZvMtC4MVpwJJdhIOv/DioDmge+M2L179SywG0kE8efsFkNukHZo?=
 =?us-ascii?Q?AJCi+F720zhh8I5tYQ/snqYyvh3S0ikYfTYoJmGCtxckWPg/RgUAwlQXXRut?=
 =?us-ascii?Q?td+ZgQ6acegKWUlrbwM8MhmisEwR9+qddFCisk969KQWNmNZ/eGglf70yESa?=
 =?us-ascii?Q?jnzsoWf8zw1N2elB64Dw+E6RgwwDbSvipCrp5l15TSp8bcIJ8/1RKOpmkHYg?=
 =?us-ascii?Q?wfew4iJ40fnac7l+CFOnJp6QVl6T385UsFfPe+9izwF+DnX0lnwsagOkoOJE?=
 =?us-ascii?Q?IteYLmfa4+/PtjGpipSxEAR/uOw6FOpMJ2mvJmvm/jgXTbTZCf7abSnud+7w?=
 =?us-ascii?Q?w3sMZ7hwGZBJ7m32KgfvXcdALlhuzIrIu96dAUbtOIUGIMkA5TgOPMWBhfkL?=
 =?us-ascii?Q?6Zhm+1sLapjPeFgH6M0l6NF9Q06pByrtDkrNQadHKVzQgcYuo44sbTuf6kFm?=
 =?us-ascii?Q?MQlh/qaKs7L/Oe3XUHPNoGA4bcNuoI/eSbL4/zYgtevu2r61OjyVBaoxM9m9?=
 =?us-ascii?Q?OZbkHyKPRTTwl9JXonJt+JK2n+cr3WzLrhoS4v/bPKdI8iZx5juSvYDRfbj+?=
 =?us-ascii?Q?6VjAtF4oZWdnbtVy5/9Z34PsTH5cyFCoZNaWY25Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a79086-4bca-43bc-355b-08dd2eafac17
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 00:10:19.9062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWygM7fXEafHiyu76P+YQaLa2FqoyF40C0t5atNnOMPbYkMmUY/e7RfIMn9asZi7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6642

On Mon, Jan 06, 2025 at 12:34:00PM -0800, Tushar Dave wrote:

> > > @@ -1028,10 +1031,10 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
> > >   	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
> > >   	pci_dbg(dev, "ACS flags = %#06x\n", flags);
> > > +	pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
> > > -	/* If mask is 0 then we copy the bit from the firmware setting. */
> > > -	caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
> > > -	caps->ctrl |= flags;
> > > +	caps->ctrl &= ~mask;
> > > +	caps->ctrl |= (flags & mask);
> > 
> > And why delete fw_ctrl? Doesn't that break the unchanged
> > functionality?
> 
> No, it does not break the unchanged functionality. I removed it because it
> is not needed after my fix.

I mean, the whole hunk above is not needed, right? Or at least I don't
see how it relates to your commit message..

> If it helps, using 'config_acs' the code only allows to configures the lower
> 7 bits of ACS ctrl for the specified PCI device(s).
> The bits other than the lower 7 bits of ACS ctrl remain unchanged.
> The bits specified with 'x' or 'X' that are within the 7 lower bits remain
> unchanged. Trying to configure bits other than lower 7 bits generates an
> error message "Invalid ACS flags specified"

But the fw_ctrl was how the x behavior was supposed to be implemented,
IIRC there were cases where you could not just rely on caps->ctrl as
something prior had alreaded changed it.

What about your fix to the mask changes this reasoning? If nothing
then it should be its own patch with its own explanation..

Jason

