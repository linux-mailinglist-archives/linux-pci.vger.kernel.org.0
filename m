Return-Path: <linux-pci+bounces-5042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E242887EDD
	for <lists+linux-pci@lfdr.de>; Sun, 24 Mar 2024 21:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFB57B20ACD
	for <lists+linux-pci@lfdr.de>; Sun, 24 Mar 2024 20:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485CBDF78;
	Sun, 24 Mar 2024 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lr1TRJHr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F253FDDD2;
	Sun, 24 Mar 2024 20:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711312686; cv=fail; b=rwgiVJSPncEoptOV7wgBiSwERbxfi5yN2jKovfm+AWQWfVtRHH7+9IIXpJp2hFS/DNw45I6WPv6awfh+GgRjCkSDQk+9E+7ZSlwfpoqfaGX5hv8JV4KHWccg5UKBU1XuRp47BKDNLLuqkcTxKTjmOG3SvkElIPGLeUa+j1DlwC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711312686; c=relaxed/simple;
	bh=a0MsdY5PqD3cCpK3IjxIFUXswWLXoQ1EVUDRfRbi5SI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cIEUV2Tm2lUszAZrGjWbKG5j7Ih1VmXN2o0D0jGuW0/knK6/uqBSGof1m0pofwwba4LCjmClCrkWEBwiqx6ZrwCbxRnPFi5m71+a7u6cyJJRL214TD87T9hl5oCM8c50GT54CTN7Tg/Sd8fsXlYAcmK3y/GNjPEPV5gSB9DawQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lr1TRJHr; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711312685; x=1742848685;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a0MsdY5PqD3cCpK3IjxIFUXswWLXoQ1EVUDRfRbi5SI=;
  b=Lr1TRJHrnvYNWR8nY/O5+yIa3+4jHvAj3eZ7738iudO5EudXXqEIxjiM
   BOGClpC7zIx8sLhzuuVqBCvD0d/t6C3IC1KMBgwEx404bf6mOanWN8jb3
   UjyG9GysyRUrggTLzu5tAn6l31GD/1psIKV/AadhVQGceEWUBe0gs48kB
   g+97DN1NiEJ3rZRoKjgT0AvM3/hRdpRDnAtNua+YrSQ06ZNR+cTKrciS3
   DaGtBMWqRVJYl+L/ZKm7lRzIrbXI00/p7YR93xrIhoRQnua1tacqysdM0
   N+qdkgR2gduGSDAhsxBAm5RejBuRR5xrimViWCCHx7FSFCpZOs9s/mlx5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6198419"
X-IronPort-AV: E=Sophos;i="6.07,151,1708416000"; 
   d="scan'208";a="6198419"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 13:38:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,151,1708416000"; 
   d="scan'208";a="15448066"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Mar 2024 13:38:02 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 24 Mar 2024 13:38:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 24 Mar 2024 13:38:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 24 Mar 2024 13:38:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwymoFD1Td6ALIReqhg67tgSlHqoRsnTISXWja8keRN/M2ZKuwVfKAk2ECXH9Xdmy0lBS+IHZ25AIjPRedB9oQeURC61f6qZVcJoKTJb+ILe3WKvAkvYGbK7pnBKV76dh9GxfqM0/z2aYyl1RmhJV1OWwlIMdb2ml8YXC1r8ZDt5UdtFXCF71UiI+u4T4EiYS2Sy0eznOZuHIo36+yp4O8B0OCvTqutE0rqyco10mpdBhMC2GmHo/6TSXUpN3NclCsQhlbtM8EcQOyCNJDJ4llycd5CqtUIpN1M5EKrnV28VHmodi76paxucJzrCW4egkcksg25B7mIJA3qp0qZKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fp7+kFPFneM1fTQk284WMCBhT1FSG+YyNs8SDrD57ic=;
 b=HFh4C9g6/I0c9pTJiw9872dmwnaqnTMcJ6GJb54imTDwQTJYIbFlLFFgzG7d47ndf0vUK78gx6atlvFiKa21pOGVSVCoWLYdnEl2hFn+eMwZZVS/udWmgUVJkhgaXr1Tb7x+ityAgw6n0+NM4g8Owi70vlBlirhemIEr6ljyacKzpMiwXHDrDSTL7XKFrQG3qKqctNKSqeY6gM1VBnoxhJKhrhoux0kTfN3stT1cUSod4spbkhHqFK2ESVpMdfgQvhMetYkrx5ZBJ8I6uEDjRyaJJUkEHnjf1sdrpzkrYwz7Y/MtFXbwgJM1dztn9G+nMuR+1/Xiq1CfX33aYGfsVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by MW4PR11MB6786.namprd11.prod.outlook.com (2603:10b6:303:20b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Sun, 24 Mar
 2024 20:37:55 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::545:6a88:c8a8:b909]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::545:6a88:c8a8:b909%4]) with mapi id 15.20.7409.028; Sun, 24 Mar 2024
 20:37:55 +0000
Date: Sun, 24 Mar 2024 13:37:51 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>
CC: Peter Zijlstra <peterz@infradead.org>, <torvalds@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Ilpo =?iso-8859-1?Q?J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Lukas Wunner <lukas@wunner.de>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] cleanup: Add usage and style documentation
Message-ID: <66008f1fddaf9_2690d294f4@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>
 <20240322090630.GA40102@noisy.programming.kicks-ass.net>
 <65fdd7ae82934_4a98a29429@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Zf8_RYHW7QmCzl2-@casper.infradead.org>
 <65ff7a88e93fb_2690d29429@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <871q802dzt.fsf@meer.lwn.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <871q802dzt.fsf@meer.lwn.net>
X-ClientProxiedBy: MW4PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:303:dd::13) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|MW4PR11MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 41eb31f6-6317-478b-f54d-08dc4c424887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QjA7YQmTYeaZLrY7jZ0PzJQf63MEuIpHdX15JcGlFh7oMqfRTB8ihbTGr39ue1K9U1yS+0j50GUryXv+3VL2TYMFHARnRfkfCyG2jkyfLWaouS/TUiv+O1UrvIRy2efrTq4OFz9T7M8cCDO/C/DSDLSqIzuyFNuNugxQrALX87pl9FbOT4kCrufCise/fVpDECX/ni0So/E2ZIJFHe3qReJFSSQw6DEPB95GSjH4cDx5+lIPN5BH2DeTbJP6tehxJ1Crdla+LFDTYs8qbvGL5y0wD6haFTLs8Kv22wrvhuNO4vSuCwfOW0RErdLA4U2/S5b/Fz/bgW+1vOgq6lUMpADwWzRJuSSPttG37FTzZt29smQXq6Z7HPq4TTHvc4hJhDqp6Ksa9ZBwnGLBm+XnBUWEPBls+zfC7V8liYmM5SCUMOHFU/gHwKjOdRBHfVW1aaLrk3hF8qJcYWQv803xP8obm0KXlR+jintIOR+ypMqKe8nOZLmDfZ0qP1XPLhJ8vJt7tH7oLdI+v0+Pr7srZmjzDhBqtxqbbjP/V68n9qs6uQ/B3w06AtectOb74l9S094V7+aXe/vTsw1yYVB+YVVeee6EA2uwb6mlenooMKu8/7nCld19O1t4LsX0n8nDEWRHumM6DgcEXpdoLo+t7dSuLUEoGVpz5lxkhf+Q3YQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u3Y/MJLW369HkqXG/o3Xie+D+EuwlSchmPw+6PJLXnFPYNejnxTasd+2EKNZ?=
 =?us-ascii?Q?dtTRH68UL6y+1wvzL+pFk+qcsLFk+UhPMEOw7at9Wbb9556PgNE0ICo03FiA?=
 =?us-ascii?Q?upqn5Fx3ZHEeHomDB3ovNv3dHBoZv2l69mKSVVx0pzMlk7uvHSytaFiU7T2V?=
 =?us-ascii?Q?WlC3Phj2pFn+mgF28qsdifreaOBTY2SWUjiv0T5M/bqxMjcdGlhko0XQqYzJ?=
 =?us-ascii?Q?9I0PcnCkAWR8e3mQ+ONeI4QQgGmY+IZX04uuXTBIFsscBGw/SXQRrkdWe9fB?=
 =?us-ascii?Q?giRVqKhxcB6qT64gKcdixxASsKooEokv1aZCe4JxaCDB/3arU6Vz7WbhXxhD?=
 =?us-ascii?Q?/s9CLUPiUkMPqwbUtI3ijl9Z5J+pcN9GSiasXmrAAEaJU3Lel4SBb+Hi8hYJ?=
 =?us-ascii?Q?XDZI/OthXlWhnDxsRrRlW5w4LXmbhF7ymRWowpgKRF/C2mAL7guxhs8djR8l?=
 =?us-ascii?Q?Kdiu9og4KnMEYxJxoJwDBbvYv1kPAiNXUKU6OG7o/oIpAXO7YZ2vLQWDUfVP?=
 =?us-ascii?Q?5lbGdBYfbUNTvCbGZU8OzJA9iOuo+TT/i/Ff/L5Uq8GNHb9TArJA/kzROCST?=
 =?us-ascii?Q?xWgibwVs2VrLCUCLP7pQZr7mc/TMRkgLg1RdAZuQD+05rm2XVMzkIIVfFpw7?=
 =?us-ascii?Q?n5omFW1BJz0GCqP5v21dYoPRyMSCcinuXs9p4Wal1eWiLXtZS0jPcw9YCxFI?=
 =?us-ascii?Q?LHEQ2zC7PQQMGb7lKMITfCL9YCsPjrvUtY8IAxh92kdmImpd75SKV5Wf5cMe?=
 =?us-ascii?Q?hHpXMJgku6BUemiOqF50Nbe+oSMJ7V6/Ro1XLqWq1GLav5W+1EPzUCP5E3tE?=
 =?us-ascii?Q?2RqD6pX2tV18+eiC6GVs0jtNx5EwhY/Lkn2zCGAigYvBuCNInv2+v/Tnuppn?=
 =?us-ascii?Q?ZlopE86z57bb0AxHq8idYM8cIIF8Gsc8yzUj/7Z79Vjt/Kugqsm8SaEEh+LQ?=
 =?us-ascii?Q?Q6H6XpNbW3/WuQC+BAynbfMUZE/UPgtVhMxqcfOiJCHj7msSA59HeNNU2Dg7?=
 =?us-ascii?Q?zp+MisF2t8t6w8xrgooKMOZHRzX1+v5p9yPq2ENy/VQuJDB68B8ygBiaRUYw?=
 =?us-ascii?Q?J2nLbWrJLzqqi4/Bp8oJF7ooDtcyL0Q+hjOPYTPRcO2RuNka/W8cNONVgY8B?=
 =?us-ascii?Q?SS/domoc9m6WXW2rUmqQ4UF2EIulRDEN1DWzTkN6WAazPhbjrYYkhvzLe/WO?=
 =?us-ascii?Q?VSwSZ4f/sbvyLW0vKNiBA8LUkGpdDJH7nMqEOm+/83m0VujZLxKdnGlY6lgR?=
 =?us-ascii?Q?dSKrScUFQGsY06x08GUtQlxRMBfJ5ZUp4Ap3PNTVniPC59LeOsXW7no4d8Xy?=
 =?us-ascii?Q?0M2s3nPTIY+RagRauhxZKwmBTsdXWyobthTEK6o809KBO5AObD973rZyIt3x?=
 =?us-ascii?Q?BNxGWmHnbdRho5Vj/BQ7FZUVy+w7qlgUqcn0Tl0psVPKs4LsKawOnnqRNW+s?=
 =?us-ascii?Q?K2ep5aN0gV76AEpCfsSx11pxXDOwLyUd9shNwNFqjRbpeA5oV1+rCJ1uR/gr?=
 =?us-ascii?Q?2T9E3T0tp2hcFk4Z4H2iROfI+nNJkcqy545chnSdpHcbrgPFmA1OYM8YEFOo?=
 =?us-ascii?Q?ujLnEHIXnskUmH0giquezuXKZMQbnXnwZ8t0C1TQrDPIQ7la6PMNQAMvk8Zh?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41eb31f6-6317-478b-f54d-08dc4c424887
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2024 20:37:54.9451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDcGF39CN2i4S7zZ4OEp1A4GSjf9MazkhnrUL5YHpkre3Q2RedFzag7b1DaLLb+mnb+p6BT/yytGFykJFu+J838a95Hjsl0blVVDuUvnvKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6786
X-OriginatorOrg: intel.com

Jonathan Corbet wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > Matthew Wilcox wrote:
> >> On Fri, Mar 22, 2024 at 12:10:38PM -0700, Dan Williams wrote:
> >> > Peter Zijlstra wrote:
> >> > > So I despise all that RST stuff. It makes what should be trivially
> >> > > readable text into a trainwreck. We're coders, we use text editors to
> >> > > read comments.
> >> > 
> >> > Ok, I will rip out the RST stuff and just make this a standalone comment.
> >> 
> >> I would rather you ignored Peter's persistent whining about RST and
> >> kept the formatting.
> 
> Dealing with that is definitely the least pleasant part of trying to
> maintain docs...

What is Linux development if not a surprising ongoing discovery of one-off
local preferences?

FWIW, I think the ability to embed RST markup directly into source code
documentation is a slick mechanism. It is something I welcome into any
file I maintain. At the same time, for files I do not maintain,
maintainer deference indicates "jettison some markup syntax to move the
bigger picture forward".

> > Hmm, how about split the difference and teach scripts/kernel-doc to treat
> > Peter's preferred markup for a C code example as a synonym, i.e.
> > effectively a search and replace of a line with only:
> >
> > 	Ex.
> >
> > ...with:
> >
> > 	.. code-block:: c
> >
> > ...within a kernel-doc DOC: section?
> 
> I'm not convinced that "Ex." is a clearer or more readable syntax, and
> I'd prefer to avoid adding to the regex hell that kernel-doc already is
> or adding more special syntax of our own.  How about, as Lukas
> suggested, just using the "::" notation?  You get a nice literal block,
> albeit without the syntax highlighting -- a worthwhile tradeoff, IMO.

Sounds reasonable to me, will do that for v2.

Lukas, thanks for the help!

