Return-Path: <linux-pci+bounces-35130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24726B3C02F
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 18:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46363A4CD8
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 16:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491012236F0;
	Fri, 29 Aug 2025 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GkE0P0zN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A97263892
	for <linux-pci@vger.kernel.org>; Fri, 29 Aug 2025 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483350; cv=fail; b=cNENgX1YqBfVI4wSYeduukbPSJU5OoVIucKGLvY6v3i/8xMuqIVwrLtKoZOUJl8nSztz1XazconqcD/1VnWmGL5WIQ1YYJvxd9B0tZOowP1uFua5DchQWFoPiSKtPHfAGYDoUX7Sz2cqJmxd/pzRW80yDL2zA7Ng9rLglVxdC6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483350; c=relaxed/simple;
	bh=eJpzZti2Oieyb7mEnL1Wt5bM6xbOkP5o+8F7jkM3Q9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JHbvKAZ66AXdPLSWr4KrZ7XnHfC3ykmopQYlr+oSKckDQpjfdav5LFmUq693bQYvODrys1QUkYVFHRjGPXV1EDwWmRyBQizOU4Gl0HxZ0T1y7QSUiR4zZ3BY4EJpYXNZ4z2dkLPzqJjPIDf+/YUxeQMNZMH7owplawlVrrevg+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GkE0P0zN; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8H+tP1HGnmo5QvS5LioccDfO9OnNtLgisRZ1cy7akspPc4sLHg3oupwG9Uv44HZ0FpObt3thVR2XFcNCOANh18S4emvN+fOdbwpVqjOA5wz056e9TN0Az+im7GkRZMGwbeKu+EfmI5qTx+aBb5tuBANcDPJmatG7DsjgsMsz7FY16DptCqvrhFYT1Od7nSoTNRHHnjmjytLec1qQzMO6Ufwe14ypkF84vlKkml7fQpulgw6kxCUjWZSJd05iYBYanctLJwIOLdqZHfszaw3jtSyEDZzjshvR/WPujdTKEtDvIsnnytM1Hf4qxIdjeuTNOlCHRlzDPb2WKafcptqzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGdBF24OB8cRxX9BOgVzeDrOj7TVtKi+jous1PLX9RI=;
 b=gIM3QfTtVJtyRzSS1aOprRUPB8m4DkyW/eeJxqjXugsErfQhCQPB/FJr6cvIC0MBGNiZ8TILX+nIRrenpGiZqFBkWqkqmM97jbl4wUVz5w7niM0l7nBCeDyTpGAOstKWLTFZunwzY4lAG4aI9td7s/A2z5vkuB1BJD8pONITMbEmMkB/HK9+zWBGOp8Zmqhgd3hMkAD/ZjtGIvrqKTNzNC2b77+DEN5Qoxszk4oEeHerlHZXlvd3r21E6Bl6x4vULyz1PTyo+OYpIQ16us9y14HoOSe550CN0HmMI6CfLFA+R1Nf8mDPCLttsfXDqv960AA7jJYIbYN3G4YKhnVGxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGdBF24OB8cRxX9BOgVzeDrOj7TVtKi+jous1PLX9RI=;
 b=GkE0P0zNlGoK4wOUD7FhwGWfjz2dd5MbX6JHjDLa5/Vi2EVCu/tCUWP/RxC+/k1LMWSAWZ202sVSNRB6I6y5s6alNWYXflzYxTqTodWn3vf2LdXLrds0/Jgj+PR6Uo04PjIrc6dbS6a4CoD7fIIz0Xft4M4d7q4gfy4OX3M3C5haZkhjU3AlkBDT2MyIImGfEkzTSwF3tSqcyp2Fy3TE3qOQJh4pnrtM36qpx9sLs/5uRjjFuNQQLvpjP3Cp7CltjEY7kIf1O1fVE6YJQMPZpjA8rTDHKKVf15F0y0hOJpzg4cUrHdX4BIWzDgrwjIStcvn249swsPUYkcSmxmgj4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by CH2PR12MB9543.namprd12.prod.outlook.com (2603:10b6:610:27f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 29 Aug
 2025 16:02:20 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%7]) with mapi id 15.20.9073.017; Fri, 29 Aug 2025
 16:02:20 +0000
Date: Fri, 29 Aug 2025 13:02:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: dan.j.williams@intel.com
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, bhelgaas@google.com,
	yilun.xu@linux.intel.com, aneesh.kumar@kernel.org, aik@amd.com
Subject: Re: [PATCH 6/7] samples/devsec: Introduce a "Device Security TSM"
 sample driver
Message-ID: <20250829160217.GL7333@nvidia.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-7-dan.j.williams@intel.com>
 <20250827123924.GA2186489@nvidia.com>
 <68b0cc4632fc5_75db10074@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b0cc4632fc5_75db10074@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: DS7PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::24) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|CH2PR12MB9543:EE_
X-MS-Office365-Filtering-Correlation-Id: eb940108-2c8a-4609-66df-08dde7156f1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kM9wRejQap8GCUebXbAif65Dt4froj/C6FJAuwDkxcAIPZJP4FIQf18WZznS?=
 =?us-ascii?Q?p1r0Yb0MOladEk5qB7JE3v1TtlyumbygNLdM2o+0WWmoAqKLTrfGe+fi8vEH?=
 =?us-ascii?Q?sLbyMqQIP/xjW8/We+dlwF/WoRENX19ly1ix4kHdiOjeMjJzqV0bovwZWLQP?=
 =?us-ascii?Q?Fbriy8SrYosZVjPvtlte7mlYmPy+JaLndmmpqOpmHx9yHiVEw6WEp1OWtG4B?=
 =?us-ascii?Q?RuBgUrT6Bzmv6U+nulEsDtuVyLwesQAq4WpaibMo3UHAfEtgDQFxc3M97E42?=
 =?us-ascii?Q?/ebB/Q1aiZA7pDGNrIhaAJmh32m6sQzMeteQO1K9YEx1e79Cf4HVIWfEuP+N?=
 =?us-ascii?Q?nJDQWVuPylojxtR3KxSS1iFFnAWkXJ4mguOB6C/Tvm/NTfyYri4v449R520r?=
 =?us-ascii?Q?jQioGr/TjahJap2qeX76NioqO0BsAv3NhoTcjijkkU+AkgGoEYqw9yi7gdi3?=
 =?us-ascii?Q?WjHLdpt6qaNQsyfB7naxEiAKjt/BWx6h2liAfWN0brO33/SX1iiA5Rca6Nmf?=
 =?us-ascii?Q?CpcdIFjta8UX3qS8pQHNaxbw9ylFIUrCbfP5QxmC3NOJgdts1A3XgZPVFBQt?=
 =?us-ascii?Q?OtgjtCpVhUfxetzjvTYdpG1QJL5u8HG/bNFboVdXd0npjchwCWaiMhX5dHLL?=
 =?us-ascii?Q?lUakT3TEfshsopL/d/5Bj/seEae9pRw9xqKMcgJahKUSiAZ/PZkW5x1zmaJc?=
 =?us-ascii?Q?VDT/UDy6Of2tVkLToCstSr94bQ8K5jcxKnPC79sWuTe5y001ngRLK3FzJBFB?=
 =?us-ascii?Q?S9xDHnK93iX47L7dZ3b8qBImvk95rVAp2zZ/ZpGUsBk/i3i+3QAG0U/u9rEp?=
 =?us-ascii?Q?uxwhvpfh/aFOXYbrv6CDnFSOc8Nv/pc09hQOKOVpGjMzJ0JYoBbotAYaZCQH?=
 =?us-ascii?Q?AadX/rShTS5SG0XGtlS+2y58bY4xZZsaWWkhEmrmqwjMtPMVdORzmgceOpdQ?=
 =?us-ascii?Q?+3fCBbFNf/DH5VFaaR+Wf47bXJV0qE6PGvvjFN/ub1TipZCqn885kuCwhIBf?=
 =?us-ascii?Q?vniGov2t2+2RQJQtow8vqOGeftws3oFyYx/jF4M8oneGoX8W1JLcQ09PD9Yf?=
 =?us-ascii?Q?nuvrskBHvrWOXw0Y17i9V961lO0XClo696ScwYhthGNw13ZIlKlr8mYXvFIO?=
 =?us-ascii?Q?tnxfMAAek4/qxwb/qco3TkMD+2eif9AyK/vrWHQoSEcF667icT3p6pnndLDP?=
 =?us-ascii?Q?7Yc59HpzS7HjBE38VKNugyVPQMRpUQSA7aguM2AEDzvIfZ/iYgDp/8/EH/41?=
 =?us-ascii?Q?WVe7Ps133B73LmEkbvjA+ztboyGdAq0LELXh7DSR668/FvwX4zEUslVW13Nw?=
 =?us-ascii?Q?tQ2OWvbI23oAtHNi23EI85KYVES4sFQsaBquFw/5DVWl9kOrYN9fHnao1W4p?=
 =?us-ascii?Q?/u7WSVAA2gQh5MC50+U0tl0hNWFlkBzTMiKNMq5ify6zJ273fzis/6LL4R/p?=
 =?us-ascii?Q?bwWr1jVB2hU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JepTjw+6RWD5AxwrtDTFUUBfBzcX8Yv0OrQtQKYy94zZcg+HGY3u5zfE7eea?=
 =?us-ascii?Q?SoEVxRHtUoMfCmr9nCKdwXpYBcMYxm+ZDFxk8axJW9xjU3fjAtGSDvhRUYHj?=
 =?us-ascii?Q?fT9+UE3YSZoTg34UPAdv2BrkP2TYT/Ahj6VGwB7/SsrlMLi+V8383bUmQkcM?=
 =?us-ascii?Q?VgB40cbSykF/tdY0vi6srl24qxNvhTNTICPN2B36x61TE8TIXzO8CFotfFg0?=
 =?us-ascii?Q?H/BApbtTz57DhUacHev1/5dKodRYeYJZ1JlhY/L29UpRdSkLoi+pLILm4j+W?=
 =?us-ascii?Q?M0/K2SkE96PK2AjJ1IBRg9/TnuiMbalqrp18Yg8eAxSIaErVEVvBlTvdkoP+?=
 =?us-ascii?Q?SZm/fouN+fFOr6LZ8A7EwaB0Ovc2ereYFNuws7+WYwGG+Cp+YfK7Bp6TtdEO?=
 =?us-ascii?Q?mLfNGvgoGknxTjHEY+A+gAGfanhzzmwYHiGZxTmu5QOHIRdLEOpHOWNOzM7L?=
 =?us-ascii?Q?V5ePuoWsjfEMgPPld5BX1AIkSN6BLBbL/SVmKeHADYZzS4WhsvIZhr3J4cwO?=
 =?us-ascii?Q?AxqS5dmKawTiREDuR0y29FjbqLgblvn2WQEEo+kysqj3ipzNqXcsUuexXHtl?=
 =?us-ascii?Q?oP2e5FpReFafH3yorWTq7mWCq2js2EseTSCzsM5OwzNNG9SPnRnxfoQPQYC+?=
 =?us-ascii?Q?Lk/6kzD5WXhP4cL8ZA5hthywe9RFz416FY5R+/PYBpn44EXgZdeLcZJ65yCv?=
 =?us-ascii?Q?Chd/quaBpfUNWCec3ry21RBsGIG7tc1Y5ngHDpSDOu6FegeY5EyCVEG/Etf4?=
 =?us-ascii?Q?A6l1QZT7S+oVwQGm35/62d4NtsTFMqmOHVjdsbOpxbFWrNnaKzcSfXvHjizT?=
 =?us-ascii?Q?0nCWjIZNb5C9dgyjUUT7Kdz/ekMoD+itTMjoqbVYs8buYL4BXlZDJhVWEw/s?=
 =?us-ascii?Q?wLNX6URE06foy3mQBUjlUlU+Mfp45vgNsctxEVGXndIBSqzQyToQz3vP1iDM?=
 =?us-ascii?Q?pYOk+yWWkcGMS6TX3V8blfRJnm727cIqDlUmTh+UK7uJwmmnMWvLlsdpJBgV?=
 =?us-ascii?Q?4QBkowC3/NDp8fPXfmFl4Y2+uwhJv/iR5hX+ao6gbHEDu6Cra2m2+1FodswG?=
 =?us-ascii?Q?rvVVHzYDOs80MqIIwmpfBix3UxHSuat9RzJI3d7sJhYI4EqL5Y0aqFSIET19?=
 =?us-ascii?Q?D66wZQgSM5E2TjqFcOK3GNmZK5C6wAk0Ro44sLaPnEu8XcKjEwUqzK2bgUSR?=
 =?us-ascii?Q?6/c4QINt+fi6vKiQEC7ApU4460unomf8y8br4SMs+K6MWuYa0ij4rV5NAzaO?=
 =?us-ascii?Q?xP2F5JzUqOmcs1cDTEJwKocI1Du9zQjt/52p8ukr7vjtSS+hDDBnHKYduDzq?=
 =?us-ascii?Q?K+K4OwcPAgwp7wwJXOgHnB2yS18yIsglZWb5+iefSB7YJzoNBOCxBzukJJS8?=
 =?us-ascii?Q?dPHG5o8icgzf3tVWdyr9Jxj3/LWtvvbxC00qe3QpNgBoUsZXm7Y5VXE4GOxs?=
 =?us-ascii?Q?oi+V978l2epVB5VgJmJjHLtgNLE1GvKDldDubcXoxjJ6cK27AhSA64U/mqX6?=
 =?us-ascii?Q?+AGZtyYZgq2M5FaMCE0EjFgSVwxWx3G/Ha53ZPXwF3ZQ5wuYPCBIrlJL/cv9?=
 =?us-ascii?Q?/QIAaPCGtU1U5JBoTHoRJ96aP2rGpRnXgNxhtYLt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb940108-2c8a-4609-66df-08dde7156f1d
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 16:02:20.3430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tP1k8i//1+zCIRzDWeoCL7FQHY9B5wzmgngK7nb58ePtvlSkNXb1K9qets9XL5Oj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9543

On Thu, Aug 28, 2025 at 02:38:14PM -0700, dan.j.williams@intel.com wrote:
> > device_cc_probe() doesn't save anything, doesn't this just get into an
> > endless loop of EPROBE_DEFER? Usually the kernel will retry these
> > things during booting?
> 
> Hmm, no, deferred probing retriggers after a one-time boot timeout
> (extended by driver registration events) and after any device
> successfully completes probe.

So it is not "endless" but it is also not "single probe then wait till
accept". I'm not keen on using this mechanism, I think the things
people want to do in the T=0 mode are going to be time consuming and
repeatedly doing that time consuming step is not a good idea.

How about this instead:

1) Drivers compiled into the kernel are "safe" and can freely bind
   at will during early boot

2) The first thing the initrd does is set
   /sys/bus/*/drivers_autoprobe to false.
   This stops all kernel driver autobinding.

   Maybe we also need a small kernel change to allow userspace to make
   drivers_autoprobe false for all future busses too.

3) Userspace then evaluates what devices are present, checks its
   policy, loads modules and issues /sys/.../bind operations.

   We need to close the general security gap I gave earlier, userspace
   policy should be able to implement the statement:

     mlx5 is allowed to bind to a RUN device after measuring and
     verifying it, and never otherwise.

   a) For non-TDISP devices userspace checks if a driver is "trusted"
      before binding it, a fancier CC only deny list stored in the
      initrd.
   b) For TDISP devices userspace runs through the
      prepare/measure/lock/run sequence then binds the final
      driver.
   c) Something something RAS driver restart

   Basically userspace policy is entirely in control if a device is
   "accepted" by the ccVM or not. The kernel won't auto bind
   a driver to a physical device. It would be driven off of
   uevents, I guess through new CC focused features in udev.

   I think the needed kernel support is already here, the main gap I
   see is that the modules.alias does not include the driver names, it
   just has the module names. We ran into this with vfio (see below)
   so it would be nice to fix, though it can be worked around like
   VFIO did by making the driver name == module name.

4) Userspace sequences the special "prepare" pre-T=0 drivers, perhaps
   discovered through modinfo matching similar to VFIO:

   $ grep vfio /lib/modules/`uname -r`/modules.alias
   alias vfio_pci:v000015B3d0000101Esv*sd*bc*sc*i* mlx5_vfio_pci
         ^^^^^^
   PCI driver but special for VFIO usage. So I imagine a
   ccprepare_pci:... driver variation.

   Userspace can inspect the modules.alias, find if the device's
   modalias has a ccprepare_pci: match and if so it will bind/unbind
   that driver before going to locked/run. When it reaches run it will
   find the pci: match and bind that driver which is the operating
   driver.

   Policy if the ccprepare device should even be permitted is also
   controlled by userspace.

   Userspace sequences all of this based on its policy to accept a
   device and push it to RUN, not the kernel, again probably
   through some new CC features in udev.

   The kernel side of this is a commit like cc6711b0bf36 ("PCI / VFIO:
   Add 'override_only' support for VFIO PCI sub system")

This is much less kernel change and gives the big thing CC needs -
driver binding policy decisions in userspace.

> > As we discussed in the prior chain we need to have a policy decision
> > before auto-binding drivers at all in a CC environment, I don't see
> > that in the code though the cover letter talked about it??
> 
> The aim was for the "'struct device' has an acceptance flag" discussion
> to settle before starting a "device-core policy for unaccepted devices"
> discussion. I am ok to put more logs on the fire if there is an appetite
> for that.

Sure, I think you shold drop this patch from this series and have this
series focus only on creating an accepted struct device environment
that a driver can bind to and operate. This is a long journey already,
once this basic support is landed we still need to do all the arch
support to enable DMA/IOMMU/etc as many followup series.

The questions about when and what drivers are probed can be left to a
different series, at this point it will be usable for development but
not secure like it should be.

The device_cc_probe() type issue should be solved in yet another
series, IMHO, and that should come with a really strong justification
why the kernel needs to do anything at all, vs just rely on userspace
as I outline above.

> I was hoping to put the onus of that on the vendors that think they need
> this Enlightened driver path. The path of least resistance for device
> vendors is design the hardware so that it can be locked without needing
> a driver to take any configuration action ahead of time. Otherwise,
> explain to users that they need to adjust/replace the eventual udev
> sysfs script that does:

So if we already imagine changing udev, lets imagine the above
instead?

> > This also disables BME, we talked about that a lot, the commit
> > messages didn't seem to describe what solution was settled on here?
> 
> Your proposal to put 100% of the onus of not clobbering the RUN state of
> the device via configuration writes to standard registers on the VMM has
> grown on me. Make VMM responsible for trapping and declining requests to
> clear BME and MSE while the device is in LOCKED or RUN state.

OK, worth explaining :)

Jason

