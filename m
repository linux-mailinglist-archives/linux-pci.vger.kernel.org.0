Return-Path: <linux-pci+bounces-5635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EC78979D4
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 22:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86DAF283971
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 20:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567A0146018;
	Wed,  3 Apr 2024 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X59qCXuq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650D15491F;
	Wed,  3 Apr 2024 20:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176580; cv=fail; b=Yn6LTurld7IVgVlUjTqZu4tAs1cAV7mDFt3uHA7ANSiEhypRYBxmXwXFvOPDWw+IciDMQ4oeY0wpryDc58IzH0Vf4GvLrj3WcECQ7OA1ZXFqH4IefnkBkQcvahiQaYwq6fan3xA314TplWKWkPmTHf6bYENLU7Vq91M8cpVozQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176580; c=relaxed/simple;
	bh=8BmaQuSQiFLjHsXCfxwVu/mUmR4eZiik5UV5mKbsBMs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Inr9xCTtrH+kBvL5FgOBWAYFlinOxeao8J/05PvZBhqcH9qVwGZ62sRW0i/ipeFI1NKLRDYIK6HRM1PusT/ESu3BUzBR9fsB4wMPuTzUl4ud1Qr/cpsHOyQ/QtAKFt5NmCcZhVpqJp5nDDmY1LOrWap/NgSB4P6GsGYGOjJVuHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X59qCXuq; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712176579; x=1743712579;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8BmaQuSQiFLjHsXCfxwVu/mUmR4eZiik5UV5mKbsBMs=;
  b=X59qCXuq6sSno9Pz6apu4YOrY83scb6l/4pk2poeJddfLXAHlCMoU7YR
   B0h0l0FzDX3jUz0nBDqdNiQ9MAV5CtKpf1p0ASWb9Hhfx0+lC5rbIni2m
   5NxsMUT3CA3FX+7ECW/yaWclnbt5w5MISfW9Q3zGUsqeKn/XUDvguxdm0
   ReQLgRFPEOnEQ5ltadJYsACHXbOC8+OJZA0tMM1BaM6IhHteic02mL/fk
   Eo4ekMNkQxsHPqcwJ/NQAX1FoZReOZbznegI+v2nJ/wSyFF8qPBvkmMfw
   URaFIL2yvM3N+rLMRNNRbqBI0CgSPa9VKlgO+/mzEhkQlXgemhZlyiEvY
   Q==;
X-CSE-ConnectionGUID: lA/zRt8eTM+68RPpIbZ8yA==
X-CSE-MsgGUID: 8sxhNcg2TnmYNsUz6HyaPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7570984"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7570984"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 13:36:16 -0700
X-CSE-ConnectionGUID: vqJ/893vTLSjxw7Ev8O/EQ==
X-CSE-MsgGUID: HytbTrokSVmHhcJ6sIhg1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="41724945"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 13:36:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 13:36:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 13:36:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 13:36:10 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 13:36:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxOyKTanNIdZ7lWRKvROCIty+Kplo1crxRyyOU94SrCD/u3jIZrUWfoyiJJCb/Z/prFiUceQwK73T/FHetW+LuaOesE2ufGIXs9a95l3pwK5TlCbXkY0z9lm74lvWG7f7gvd1ocppT54rTQvKeTdoE+ZIItTsv8worliZGjGwrxlFRMNJKlMskg4LWvrBOiipb/N1JEdoL5xNe8V0kZPLmNsCdDj0QlzJ3lNBl9MV/NpPjFRRssEdAYVQ1m6CV5/HivGt59RK+JIbTQGNKX4cbyPR8rYW3UDOLUdhEOojgN+SgmRIrXcBNIXjpSRxT11+ro9W/06+s9EhWWHPHThOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOAt1ture5nTeZv9kmKcznS1CfQiptsEsi85FmOzDSI=;
 b=kBx5kdaRqxMZcU37xxvjJHcS/Kg5g83Pb7GdlYSL/fCS+JGXCFxzXWSqAjJasl26pwKv92EVcc0xi/+0z7KhSZKl8htT94gj72RGQZj1b6MqGjQ7Ehz1tzXYt70NAhKWnmCifhXgfN5jm/7YgTvon7HCLg9refvkAXTlGIYFm1l+Xk/8uSQ/249fK3lt6eoWCpUfu4pVSkQZXTMLOFZ1FBS6ZVIlSGJNMkR5EN8Ulx+o/ajwvYpXhYAfrNh60iz9Xw/VCBImqW3Z+IdbklShTUohOjR1SFWCk5sW2SkxvMR3TgECuUfGPCJCGfTPs8ae7IKEdX8cJI93A9U85MsQmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB8043.namprd11.prod.outlook.com (2603:10b6:806:2ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 3 Apr
 2024 20:36:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Wed, 3 Apr 2024
 20:36:05 +0000
Date: Wed, 3 Apr 2024 13:36:03 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <bhelgaas@google.com>,
	<lukas@wunner.de>
Subject: Re: [PATCH v2 1/3] PCI: Add check for CXL Secondary Bus Reset
Message-ID: <660dbdb36159_15786294a8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <6605bef53c82b_1fb31e29481@dwillia2-xfh.jf.intel.com.notmuch>
 <20240402172323.GA1818777@bhelgaas>
 <660c44604f0a3_19e029497@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240403154441.00002e30@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240403154441.00002e30@Huawei.com>
X-ClientProxiedBy: MW2PR16CA0069.namprd16.prod.outlook.com
 (2603:10b6:907:1::46) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB8043:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lcw75jI3c70xO59Xr2OCD4DPQYe6BonXeD3ZWAZPIM018WCjfAiEm7OmX1c/jZRcsqFCuyhSOS2s/6d1ML+QvFtC90C4XYOZYS3LBkhnaLwRsunRVcz3LhW5hxPYZkbfmtrzJQxA/WoEFwLQg6vCZJ1LYMH+RZmPui+M2UJsnUV/MMALzEOxojpYvRf1eO3fLQYOpZPAZZNMpA9rAfU+/xCsnHcQhQI+tQ+e5g3A4qKqDuIWxhxRPO9QeB6+vKYUYfBi+dtWtARHHhaBVaqHSAVSUs94gnScM2nLSh4QTKNrlouKank7EG3/MWU+o4gpSn49aQNPhgGhDVkk0b2zR1mBEwnNzyYOvX2gMsXcELJtyTOHsNstDgZCB37DwlyaOtyWSHvmuTbd1VcnbtPjBbTC9RtiyR6E2ckuTT+jGViyUacjMIQ0oeTYZgW5mUQTzIUZ/kvPFkvxkoEhszpO9huSSsSQoaNxsQ8SiahJtfJmL00D0HlgoW1beVMIWu3Td78CSsXRmpdlvn01pvN+7wRtId4f2sz/CCg5I8RJXoa7K6WtYNeCFrhhrqNaSAPcLH4Rmxrm9nWAwqKRRPhd0U0DX9YjZN8+fczEhsT8WAT5wq6sTgh4XnjbtdKKMmQmKdgA2q2/SNMq+W5uuIooDMVQq1i80WGISX9QPhWc66U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CKnN7Y8eZAzddA5A54zWQVf+9cLiYreIFYCWaMhDUQymOEzYXlsPbGTARxhY?=
 =?us-ascii?Q?2zYkTx4j/0RAVEJTcwSpi4PDsHOlxa3Jt5ylWT/SOX+Gw2pVjWBo4nFIwo4y?=
 =?us-ascii?Q?0/mEti7c4k03kS/zrxXjKpLyngVFXKqd5r5JdpkI1o7UA3sYQALTn2yL3vVU?=
 =?us-ascii?Q?TOe9KprfbtMF5kO1s3OocmxqIX6IFm3aXnu5wc5GtX8Gs7y/Y8jtetrW+v1b?=
 =?us-ascii?Q?Fc5Ux9HbwBM5pQ4wt0v2vZ9Ll2debq5K+3XouZse9P/vJcHG36D8SETnywsj?=
 =?us-ascii?Q?a2ab6HiRwiGUStkYTJnMdQ903+Ia2KCKyYVWlLadC9P6dgMTt98lfa9daDpO?=
 =?us-ascii?Q?02CMBzWkmNWEkP37I6e+lunxoQCXa4sFiFTRlaTcO+wPqknr4JL9yghRqqF1?=
 =?us-ascii?Q?XCH+//lpU8vs9Yh0e0/oF1xMGhefE5BDjgKHA7t9wrl273OYSLUCbGsVKmC7?=
 =?us-ascii?Q?wFJQjmXFLmOabN7NgTm/HCgmXxs17lSxgYfF0A13h0Hh86hkVdsy3Q/DlTii?=
 =?us-ascii?Q?9ZN0J9n1AEw0XRlclY1xkmBoE9FtIPV4bxUZAlRhvO1CJk3wuZGQoCHJIS4L?=
 =?us-ascii?Q?gXewsxXaOKhBdQtyx6VKZyYJAZpP2OulTFeX39UTuv6MwEgkawHabeACy6WN?=
 =?us-ascii?Q?jzaJiGrEbfKuV2bhYdh1PQ539sCNvtle7Q9WIbho/Q1OJdbTlaTlbZ/3RNVp?=
 =?us-ascii?Q?lm073OmCuQWASMeomLqtUeB2v72DRSm8smiMvVHoHYUJBDN3dWH9lg1gfK4e?=
 =?us-ascii?Q?bSD7bZWf3bq2Tc25tYWS0QC37ALEseGmHkNRCMiCjM8sB+UhjRVsgvG69iCO?=
 =?us-ascii?Q?OiB1XezIy9Qxkxq1Hs8GoiTHsX0VfRDFPDqA0ovPOVuZn1pBq852qjaP/Pkl?=
 =?us-ascii?Q?3+kWy0tfqxupjry5pBhP7hQ8lB+i2vFuMy4wuRZ88WsNKBJG3sAdLLixKWqk?=
 =?us-ascii?Q?GApJQ+jwb5szOVIHxA5xv0OOKA3vAiB/VY+fuR6L2DN+HVeiAJeOvDdytzPA?=
 =?us-ascii?Q?qo8IW6H/RC1UYZ0E2ZCvbwHSUsUqMOLQTHLUTi8kgcg0QpVmOuns+fnjvExH?=
 =?us-ascii?Q?1+tF8fArIZRnDF+E/zfoM1uqVCXVzPJAwg54BRpi+zZm6kRntsTU/vanAzpE?=
 =?us-ascii?Q?/IVbQSTSs/jaOsFZ1aaZ75ixKu/m3kdaT+WGRJTFPBzDD6n0UuZI4jjGSqgB?=
 =?us-ascii?Q?1aLk5HMHUPdYUIcCh5NzULNc1YKcuEDH9osetgfOorg5YAT9iAyUF1u5eG/e?=
 =?us-ascii?Q?JZ9Buf0staRNMo2x59OgY5N/NIlNWmZhX1qYxq57E1nzwNH7Rw0lXROv87nJ?=
 =?us-ascii?Q?tqQ5jR6WKFpj4vnTlQ6kiOH/zTKh6dUFeaa2Q7CHMKzNlQQx+eEvAxXuWY97?=
 =?us-ascii?Q?rI2E1M9xoXRRlCAc54jhPFNjR7HCoczL3rhECGihJAaczUhEx6A/cPrzfzwm?=
 =?us-ascii?Q?0E/xlBHcruGzpWSGSxPaukqDzi6SUea072YYW4DpVdnHumCDFVtaFuRk13Zi?=
 =?us-ascii?Q?uyJR/g0eQT4b+YG7GhRK3d4SGZ1oxUgjOMtMmeEgx70yTGUf53NNyi4UgaOW?=
 =?us-ascii?Q?AEU7bI9I/Hxi7XBET/W86/KEnbHFRMtOjXAcGZa9cbv5J5gn8VFrBK6eWl/Z?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae404635-d2a3-44a8-25e5-08dc541daf7b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 20:36:05.6068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SM28LSdSIfWOTsDpyQVZhF4ESqDahG8QQj8Swa8tejoI6J4TZBqPSk9FEk0szYx4jetexkgLYnp7DbIktHnexrbCZraQUkD1KDY+HObOk+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8043
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Tue, 2 Apr 2024 10:46:08 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Bjorn Helgaas wrote:
> > [..]
> > > FWIW, I pinged administration@pcisig.com and got the response that
> > > "1E98h is not a VID in our system, but 1E98 has already been reserved
> > > by CXL."
> > > 
> > > I wish there were a clearer public statement of this reservation, but
> > > I interpret the response to mean that CXL is not a "Vendor", maybe due
> > > to some strict definition of "Vendor," but that PCI-SIG will not
> > > assign 0x1e98 to any other vendor.
> > > 
> > > So IMO we should add "#define PCI_VENDOR_ID_CXL 0x1e98" so that if we
> > > ever *do* see such an assignment, we'll be more likely to flag it as
> > > an issue.  
> > 
> > Agree.
> 
> Sorry for late entry on this discussion and I'll be careful what I say
> on the history.
> 
> As you've guessed it was "entertaining" and for FWIW that text occurs
> in other consortium specs (some predate CXL).
> 
> It's reserved with agreement from the PCI SIG for a strictly defined set
> of purposes that does not correspond to those allowed for a normal ID
> granted to a vendor member. As you say CXL isn't a vendor (don't ask
> how DMTF got a vendor ID - 0x1AB4).
> 
> Hence the naming gymnastics and vague answers to avoid any chance of
> lawyers getting involved :(

Linux has practical reasons for renaming PCI_DVSEC_VENDOR_ID_CXL to
PCI_VENDOR_ID_CXL. By this change Linux is asserting that not only does
it expect to find 0x1e98 exclusively used for CXL DVSECs, but it expects
to never read "0x1e98" from offset 0 in config space. If someone has
reason to believe that assertion is invalid they can speak up here, but
otherwise the naming solely reflects Linux's expectation of where it
will be used.

