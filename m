Return-Path: <linux-pci+bounces-4077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2008688FF
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 07:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04451F21DF2
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 06:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DD6256A;
	Tue, 27 Feb 2024 06:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6cVerxJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37D41E865
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 06:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709015754; cv=fail; b=H7TRC/+3ZhRws4rdlBw4SlyAebFDogbqkGO+GE/BNCiDJojV26UH2Od5rY/deZcLuUoFAbpdLJN5xVwOFNb8RBYG5aiY4km1k1OXi5x09QfK9FkNW49kK+6NiIW6KlY6totJJBHgFtLEeyP0uQISp0ssl23uFEdhFtAHFn3UTgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709015754; c=relaxed/simple;
	bh=k3xywqcaGl5EeuNxxRVltHiJQkJcxPsNV3oXDBN68Ks=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PbP6HoV0aObXCL10yNmyY7c5/Kl3qCrnmJjlffl9i4N86ihdLmSdl9nGOf1WsDHoFF7mMNKxrHCOnFuVMi+uhEaYVSD6v9Dc8/8dyik6CRONQBVclnpDjQCu7r8bBO4ULxRtNRlzZQgQAzUVMeRi1ev17aEKgRyvG+AHj/ii7wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6cVerxJ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709015753; x=1740551753;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=k3xywqcaGl5EeuNxxRVltHiJQkJcxPsNV3oXDBN68Ks=;
  b=j6cVerxJv3sDMu8fwOO/Gcw+PjyiUX+4AwK1vC9JLiZnFBl/flqxdr5W
   0ZsOdWMe92l4K/yR2Bl904PlxNMSaFxmd/gFTO7tM/H+HNEJ1zwbBmlTJ
   7Z8JT4pxcON1GI+CZxNt4fiY/ETlSe1lgc6O6yUxnHgeO3tBQtWs2ydGQ
   jW1obQdpbyh/ZgxtToI7WXtCQzvvvwufzODYfoJczJ/6pkP0HT49HkHkb
   4MUTAPTmISJiJvFOLir3/YXElS80IpWuNqeqHo3UZ99XI0UvmYV4AYuWb
   Pl25Z8Yh5XFYRBjH5MEVizAzFP6V5MCThDiKYe1vQyuvEglQjCYq00Ld7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="13892568"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="13892568"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 22:35:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="30104230"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 22:35:02 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 22:35:01 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 22:35:00 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 22:35:00 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 22:35:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ip6HXWhjgmOPdPxSQRy0Gi4Kr/0bOuex3poUcJVWP3IZ8W1hN0ccdt252a5qO0FgU78e+6967uhAuW5X8Z1bXGLj7yrzbGq6TA4PyhyX4mzE3eh+J9ttvXN1SsCcZUm1KVF6hq3C13PxeAMupgmtjKMjpg7BShIhonaIB0Fqa1xPxad+RFIk3i681dl6GNh3kj03xfkwmKscDzNDJOuQTG99r6B+GL0UXi/6yfyF3tu+BdoqV0P1Q5AxIG+8Zl0pVcC+AddXOwxsvaDwn97FYzLdrqdj+wt7IeuQqI64I32RXk6VC44I+hjBODPa8dNNegEwwgD54w7hfCmstA5qow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhKHJakSzh2ebNxuGar/2OH0VymHItCmF/saKwHWHYw=;
 b=Os7LV5CKGVETzIvgqrZno4dWM/RogyB8KEL+tbIRGRDLy5kD8dsrdEGp6VnsMG4l7eUS4OZPFMYEIfmt8J7rS38jI/8IkMLzlUyHodMJAVXjl2XY/bXDaDtHHgZKbM6Uun43NY7xt1H/lmTM98ivzZdsYqnS4K5v8oMCCyz0ahzocxUXBnpYlbbaXDohsh/JzM9sUcrm3+ArmJuiIs8xZriMVgVXlgosjITugA/YVeFJ44B03NUBfGHkFVGON7zpZBaHaXEb5NiSqsx6xxNP8HHEtcvOsyhtofkwx0k/ZR9oiMjENIb2V6O91+yFv0PjYPLeLMuc3Odwa7Xvd3Rqig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7987.namprd11.prod.outlook.com (2603:10b6:510:242::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Tue, 27 Feb
 2024 06:34:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Tue, 27 Feb 2024
 06:34:57 +0000
Date: Mon, 26 Feb 2024 22:34:54 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Zhi Wang <zhiw@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Wu Hao <hao.wu@intel.com>, Yilun Xu
	<yilun.xu@intel.com>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <zhiwang@kernel.org>, <gdhanuskodi@nvidia.com>,
	<cjia@nvidia.com>, <acurrid@nvidia.com>
Subject: Re: [RFC PATCH 5/5] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <65dd828e928d5_1138c7294b2@dwillia2-xfh.jf.intel.com.notmuch>
References: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
 <170660665391.224441.13963835575448844460.stgit@dwillia2-xfh.jf.intel.com>
 <20240226133708.00005e8e.zhiw@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240226133708.00005e8e.zhiw@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0292.namprd04.prod.outlook.com
 (2603:10b6:303:89::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b21783-b32e-41bc-47c4-08dc375e36fd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RERJ1mhXIyt7bv1oftRDVf6Uu6Q1fxpMTnaPZUfHEBfYLWNskhmx2HAajNnqIXB9fG5dKT0DVDK4KLhVQdCfsPvlhta4mNn3Y2NiN2yY8S323EKnN3k6nSwSEK8vYVEBdxFQoKFEqmHRrrEv7hUywtT1cINjSs+RCl8GB/V9koXJyVV3ahpttV2PQ8hB/IXMeihZzQpBOqsbElIR0gTnCBqKextpQXbdkYLKGCwQ3a9obQRvXJCeRn/NOeP3dUya3NJeWPT7E6BUcUSXt4wIH0BHYJCNPKFdbsqLauorodNFnwtYJbXXIYcwWvV5G3owhSti7VulTOHkmnH0l+QfwczPR19aDjRAhizYefIi24dXcDrVTaO/mDJzanOzM9dH7fXgdmlUqw+pIUkO8+9KeUJCB8DgVF0jCj+2hG17hw7d1o0+P20wdkp/5JsXDUxQ5rJAxT50BmN9Nx+L19p3DakA+58fh7Xq6toYWgHPiQvIxhVk0jiVZf+gGTTkpRy8F9cQUoxgvva5qzqSTYQC4V0DIk4ZC/Ea3OaE3lRhCFv5pkTuFUTuVplTtSl8SsNCzLWopqrwdS7oAS5Xo4r8V9rZzBPEkPFqE+URTLcfXt7PtsJ0L1PAvoA8LI8m/IY/yMt6di82Gc/oTU4mizdMfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1WtsUEYKa4K7P6jRo/wq/LGBX4Otyg2PlIxgaFpY2uFRFu7pAt8+kH6GGJr1?=
 =?us-ascii?Q?1hvLtPt3vwzj3YTVhFy0uO5i8OMsKy1Wb3PzS8f7AScF8bCEFJe4XfLQXhm8?=
 =?us-ascii?Q?d7HFw9Foo3Qry+vk7LylTGGc92gRdvLGvxeD2sUQJv0mlcSmHfvIDn2DzGMB?=
 =?us-ascii?Q?VX0dFDeoBPlQP38W9N+qPZL2qhqZgf0UA/RltGD5oz3WM+CQJHjaw16Rmbqu?=
 =?us-ascii?Q?MpIKhP3VeZFXCjWUyDxpk0xdDUEdox3Ar5XC3PaW57It47MkfgNmobLLGv5Z?=
 =?us-ascii?Q?7kHETHIab+WpDTp4HA+faoU5h9dL5vTbGqFAmnFOfI9RFW9byK8S16JlL39/?=
 =?us-ascii?Q?0z3S4fEpK0j71ZRKYreWVzQQ56g2wIPHGa2jF7j8fo0634qEGXobDG/wbdau?=
 =?us-ascii?Q?wB/if2EoAyMDGd77pDasgb3eKYNEJNyHVeKSmtdW1TFSmw9C9RnWkig62MIa?=
 =?us-ascii?Q?eX474SsMYvZSADBPqa5GDaqYAx4g9mGqipOEihbbsxw749XJnDHT6T2geAfO?=
 =?us-ascii?Q?XzSqDos9nvw1X4DneLa07Uyh6MmjkYEmEqUcEhnh5n3RUVSkKu/04Cx3BtIn?=
 =?us-ascii?Q?DR79ZFPwTq4qFqtS9awLhJgKadRGT/7WgTn24M1lWCJJgCfEpaRss+qNC2ee?=
 =?us-ascii?Q?9HCHH83PQ7ZssEdvQUiZIogqOgsCrFx0QTXZ2QQToneqx/YB1IaJwojZg0dd?=
 =?us-ascii?Q?1paekFQx0GgM753q/DPbtMW9SgZkRIS9y5LuexWiELEy7mCmMXB96wPI7iV4?=
 =?us-ascii?Q?WwoPZ+3f+af8bp4u1VBLJ8RcResGqGfzt3KGL+fT+4P5wF1q/GAPrLJR7I8t?=
 =?us-ascii?Q?m4pTM0FmAFcw4pHcMB4YSLSwRZiE1cEyUtBAhhC2raPB5za1L2rg5LJEfWdw?=
 =?us-ascii?Q?5dspVkvla4dZwTMln4ZKA8vxO4xiZIMxv8PL0SQdBRpaisN8hh3KSxkWto7R?=
 =?us-ascii?Q?PiXhv4aBOGdqW8Mn4WXMbgIuhdBTSU1MCa2ab+fHGQ8BdSbsikv3T8eY34GL?=
 =?us-ascii?Q?DcjTtVU3EAPLDQEmbl1stvqyaP9Eb6vplDXVtPbe8ZpV+9zNjOjk0irH/rTJ?=
 =?us-ascii?Q?T8Cbi6VuZhJya5Fg3rTQucxArjG4g+raXCCFA4PVYqLbgdwkkmZFLJwEN7DY?=
 =?us-ascii?Q?fBsE3EF9cvH8pwzKPdyrH6oKvMoIWI+IZMDrRriSG6WW425TPddi7IsJgIE3?=
 =?us-ascii?Q?VfwA8Kdnj0zISTh0gtQkYoKQ9XtaDsxuRSrSfkhCuoDg3Y3Nym9cGv/pZm8D?=
 =?us-ascii?Q?YtKIE+EHKN6SZI3+eZQOtpagG6cpjJGQrQEgbTxM1Mb6EQkWdHOZ9Et/x/D5?=
 =?us-ascii?Q?/xjyoWt2q+ALxaii3S0NkUx1iyRObFsHqK6ZB18ksotN88FWhOAs6oXnLI8U?=
 =?us-ascii?Q?XY/Dbi3iX3k4QlsjmGdV3btGKZ1Uo0CEbVwmfICAMrjpBpluAVaZjAEDfCht?=
 =?us-ascii?Q?D9UE13cMUrk2GCZ9h630jjjy+fBAQQ+JqUi9o1mHoa+xK34zImlshXpTWMz7?=
 =?us-ascii?Q?RuORBlR057wr9kHCk5B897DBux/Q9sTlQzW+2ffuY9EuHoJGE6KcEwY8XEK8?=
 =?us-ascii?Q?A1u84QLQgJk+vssudg4hLPPvpds/dIRv+CHZ6aUDA37rk5WYFp3GLAe4CUoS?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b21783-b32e-41bc-47c4-08dc375e36fd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 06:34:57.0220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vslUNh2gJSp2hBccE1qjR4jy4FYJjS+KVlqdxEBaxXYSatC5QYlDIBnV7vKMCznwJwQ0H3jlECiGVTm1ZTxtiZ1xXh2AaRDOhUfJEptsR/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7987
X-OriginatorOrg: intel.com

Zhi Wang wrote:
[..]
> Hey Dan,
> 
> 1) What is the expectation of using the device connect and disconnect
> in the guest-driven secure I/O enlightenment?

"Connect" is state of the link that can be automatically maintained over
events like reset and error recovery. The guest is responsible for Bind
/ Unbind.

Now, the host can optionally "Connect" in response to a "Bind" event,
but it is not clear that such a mechanism is needed. It likely is going
to depend on how error handling is implemented, and whether an event
that causes disconnect can be recovered. We may get there, but likely
not in the initial phases of the implementation.

> In the last device security meeting, you said the sysfs interface was
> mostly for higher level software stacks, like virt-manager. I was
> wondering what would be the picture looks like when coping these
> statement with the guest-driven model. Are we expecting the device
> connect triggered by QEMU when extracting the guest request from the
> secure channel in this case?

I think it is simplest for now if "Connect" is a pre-requisite for
guest-triggered "Bind".

> 2) How does the device-specific logic fit into the new TSM
> services? E.g. when the TDISP connect is triggered by userspace, a
> device needs to perform quirks before/after/inside the verbs, or a
> device needs an interface to tell TSM service when it is able to
> response to some verbs. Do you think we needs to have a set of
> callbacks from the device side for the PCI TSM service to call?

True "quirks" would be driven by bug reports. Outside of that likely the
attestation information needs to have multiple validation entry points
for userspace, PCI core, and endpoint drivers to each have a chance to
deploy some attestation policy. Some of these questions will need have
common answers developed between the native CMA implementation and the
TSM implementation since CMA needs to solve some of ABI issues of making
measurements available to attestation agents.

At Plumbers I had been thinking "golden measurements" injected into the
kernel ahead of interface validation gives the kernel the most autonomy,
but questions about measurement nonce and other concerns tempered my
thinking there. Plenty to still talk about and navigate.

