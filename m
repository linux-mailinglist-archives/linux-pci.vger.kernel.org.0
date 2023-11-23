Return-Path: <linux-pci+bounces-144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199307F5887
	for <lists+linux-pci@lfdr.de>; Thu, 23 Nov 2023 07:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C326D281325
	for <lists+linux-pci@lfdr.de>; Thu, 23 Nov 2023 06:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6E5F9F0;
	Thu, 23 Nov 2023 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Poz4avN8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5007FC1;
	Wed, 22 Nov 2023 22:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700722016; x=1732258016;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=6veysPuJzLRlmL1oCsW44FDJUbrC/i9PNRn1gA5fqDw=;
  b=Poz4avN8iaMJXVzzP/cERpxD+T1JH5QslIsALvgdt9cv4ov+Xjbx98aE
   DihD6TUW1vm01S5HCKa8E/D/SURXS6VVmVLaSxJAaTvElGq2/Uy9tWnyy
   ExskUhlquLvmLI0d+ItRTPgnoVbLtg3Eg1XXvPD5U4f6etwmlvxECLxcp
   rbaHb5HKkfj/kRi8mUDdqJPNjlC80aENICrVwcs4qjnqkuH5HEwROy5Ae
   PnldcRRvTLtXq7kW9cl67F6yAB7AY91kxq3frF2bAgiMuElDtjhrgMizi
   pbZNPOdHyksPa2+XUhtEBJuqI2BgB7SeqkyJCqmdjm74nQiFwKGg/X9q0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="396117579"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="396117579"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 22:46:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="940508920"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="940508920"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 22:46:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 22:46:53 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 22:46:53 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 22:46:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvlTfL7uwwup/GnZ5EpQSLKVEEUobeg3ewWBHUFfG65zNKCTw+5I2OVe0wCd732wDrvJ2NNO6NiDTFUjt8hfwAL98lZZKTt6EuuFP/8WI7JnZiYt4fgucfbBoX0IF7LlMby/QpH9FsO1dd55NKBix+A0gH2yE351jkoDR/1DCGFSQBsiznT/V/M2XkllHCf7LEB6zBgVygxstW++jiLzYg5ghHUR5GxVsgbnxhkxXBY+yFV9MdGuaWOCXWpPppwPfDOlHaSYJeeZ3NRlMQk1JazBaNLZ+uJFIODd4pM7RyoELmqWnJAD0Sy9m7VfAOaNln5e8tsZv4cyCHUKQvMd7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/EVdO5cZhuwdL74nQHjM9LuljB6ajDZI1cTJDNcCRg=;
 b=Ks8i6g65mPFCv48IytFto63H7yxDdwL1Mp+P9Jkmmw5tNUnlVM5o7xaUhS2HYLRmW3Mv78/N1JmwRH6z52n75r1Kq9fGbyHCvBXwvZLkOEP6ltsfSo/EPjZzlHNdyXfwJuXqbyIS5EMn2GGP5A/3LboSkNvWKFySH6+vbvAOFmW14IpwsqazjcmOvzn3DSSlaXPQ9+p7oqoEu9XH+8hWkKU7+EgnCfs2HzCuJdp8UhTSZWBwpqfjj+mbEzdpi/L2TqLv0C+1OiiLxwP2vwjD12e+4SjDvpr7tDgjkvIp9BiI9xR1TTh6QJXJdC1CZrOJRVQgh4WUMWTOZmN8tRbHRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH8PR11MB8286.namprd11.prod.outlook.com (2603:10b6:510:1c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 06:46:50 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7025.017; Thu, 23 Nov 2023
 06:46:50 +0000
Date: Thu, 23 Nov 2023 14:42:05 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Philipp Stanner <pstanner@redhat.com>
CC: lkp <lkp@intel.com>, "kmo@daterainc.com" <kmo@daterainc.com>,
	"keescook@chromium.org" <keescook@chromium.org>, "neilb@suse.de"
	<neilb@suse.de>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"arnd@kernel.org" <arnd@kernel.org>, "yury.norov@gmail.com"
	<yury.norov@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "helgaas@kernel.org" <helgaas@kernel.org>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>, "ben.dooks@codethink.co.uk"
	<ben.dooks@codethink.co.uk>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"Jiang, Dave" <dave.jiang@intel.com>, "jbaron@akamai.com"
	<jbaron@akamai.com>, "dakr@redhat.com" <dakr@redhat.com>,
	"davidgow@google.com" <davidgow@google.com>, "schnelle@linux.ibm.com"
	<schnelle@linux.ibm.com>, "sanpeqf@gmail.com" <sanpeqf@gmail.com>,
	"wuqiang.matt@bytedance.com" <wuqiang.matt@bytedance.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "paul@pgazz.com"
	<paul@pgazz.com>, "fazilyildiran@gmail.com" <fazilyildiran@gmail.com>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] lib: move pci_iomap.c to drivers/pci/
Message-ID: <ZV70PWDGfrEgr50K@yujie-X299>
References: <20231120215945.52027-3-pstanner@redhat.com>
 <202311212316.a0awwkaE-lkp@intel.com>
 <02aebbffd1b70820648c93efa1003df321b3b19b.camel@intel.com>
 <9828583bcb49e1adeaa9ac16204b2ad80bd77d4d.camel@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9828583bcb49e1adeaa9ac16204b2ad80bd77d4d.camel@redhat.com>
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH8PR11MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: d060c76e-9d3b-461c-456c-08dbebeff7f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/AeCMTNaI99xKjjMAo7Kfi25BZgKpJsfVI7ekh11dQRrbf5qi1YP5oNFvuAl0R/6gTjTunvcIwTlKJr0HURpfbjA3xHqTAsOalQ53Z/Kk5gGlhVqZcVwsVS4n2RgQXNFjzEqBWvgtjtcSTKRLN5/efh3h6sEioDhcPfI21C0BLxwVn0r+Rnr15lqxy0lwX1enGDXlazsu9m5PdN3QTot0kBvcYDe77QW2sgdM99gBXhOl1lnd31j893DFECLIytuVwKBATrpHEQitKr8juBNv/TASW4gnfp2ZtyEid/J9lBVa23YA15cJQ2NfxtobJWTDJ/SYJOLQDrGDVGBdCV2G2+/h2HHSmweHG47vyfh4MEQFEE1bzly87S4iwRWI4l9ZnbwDmH5R6YxjEgi5DRsUfo0IxeiJRIGvgylajirMixy7Hi/YKM/WbabVmsiC0OxRttuCTfIudhSIDzDx7D6qS3kHK6loZvkGptQkrg5Lacm3nrhnzuankrwa/G3SXbcSxpBPpT9KA6ja/Q8mYbumD+QrFmwqT8S2YE1AsU5IXFNRxtF02E63tnDV8yjctwh6o2qN4GaPjg998XHocCUfOitpLK8pQmJQG5vvAP9AQ38DLKDMeTo7JVwZbIT3/iQR5OOHO99RFiXlIb3n42sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(366004)(39860400002)(346002)(396003)(230922051799003)(230173577357003)(230273577357003)(451199024)(64100799003)(186009)(1800799012)(44832011)(41300700001)(4001150100001)(86362001)(6666004)(8936002)(2906002)(7416002)(5660300002)(83380400001)(4326008)(66946007)(66556008)(66476007)(6916009)(54906003)(316002)(966005)(6486002)(38100700002)(26005)(478600001)(8676002)(6512007)(9686003)(6506007)(82960400001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Zest90YJOtAbnALVeswVXPtAByi0RwCcjtf4LATKkHoHTUX9tjUmec5cG7?=
 =?iso-8859-1?Q?PegsKOIJm8ocK3VqjfJb1TPLX+n/ZDdjDqPi3n7AY5MSW8R98GuyYg0ZJz?=
 =?iso-8859-1?Q?NCVH26rgqE2ycWhummm/NsYvcMWpXEscJZX+TvZ93zsxhEZWqOBwsh+HKQ?=
 =?iso-8859-1?Q?qzmJ/BH9SUN57UpPeVCvgs6mnvPfHa80bltKzmKuAkQFYS4sKN7R4dbyMY?=
 =?iso-8859-1?Q?dUH59DWLk7WBn5cc3CJE7aR6L875Medp5ut7JiV9QdlWdVF/hESBK9dv/I?=
 =?iso-8859-1?Q?RT2YkiBhThKligThMt1QfJbWRENL08SCr3u+lBT6ds0mkWUrXzKU48J59z?=
 =?iso-8859-1?Q?hHCUhe0NcgQxuE00Yoxu/VZpXImErQx/EfBzjaNtSVaN9fw+1f+ApKgK1o?=
 =?iso-8859-1?Q?WypSz40NN0wsJAO4WBTKbnS9ux/GbhdK3oPdL3hPBtAeXl72Ms886OXfQq?=
 =?iso-8859-1?Q?belF1MI+ezyaOQcbpF3aiHJgPOMSlG4mF8g1zTYqFx8tt6XhEdwuFNvvo3?=
 =?iso-8859-1?Q?tnDZ2BR9z9uVVEqg5Re2acZ3A6LBpnWEVBq/ZHT4Lkwy/NBWnYPU49d93R?=
 =?iso-8859-1?Q?pBI5ZZfvsS/ewwrGP6lJaE1/SfVcRoIA7EZRKRNs/WOD4bYusKJ9tukw6T?=
 =?iso-8859-1?Q?D2YcVh3EpO7qqBSDcnlQtw4p08Nat9YBPIKPpAv+6MYr0PS3bFW+ZEa5Od?=
 =?iso-8859-1?Q?lY0sbWg1GqNfp2JBdNXV8RORoO3UiYoRYeuj6XXfopXlYSiKCgTa5KIlpr?=
 =?iso-8859-1?Q?8nBDpVdHJlMl+LVHVgU3U7GdSXBOUSy/vA6sMNSNYppFBgjBsEFj/QJt0u?=
 =?iso-8859-1?Q?oGtd6fudKaDNRO1FECbkxgR9yH5u3B1vOjVzzD7l5GEv0YVo5tmsRTXu3Y?=
 =?iso-8859-1?Q?ZWOqOrAu7hlyyxt/M3O+qoukHkPGQfF5aAUFRddUXfLI5CTALdpjVg/lE/?=
 =?iso-8859-1?Q?grH5O9DCgMyXDda8V5CfM8ZO6EhO3XmWceovfRwvV5AVHDgEDl4vifB4xN?=
 =?iso-8859-1?Q?ehX053bz2KuVnVPawq5Hrz4VV3LoBZi6JLIL4qHzG1dNGTofw6UF+9UNWZ?=
 =?iso-8859-1?Q?q4WnLhbbwLku/6j74OgYaZKt9HzN+A26cx7b0HOhdXCuVyJUUo5mSRVP73?=
 =?iso-8859-1?Q?soUJZkb2RrXA6KS/KkkCXTegnbwokVeU6tbjzorS5i1iv0XjZGZNZG2EP7?=
 =?iso-8859-1?Q?A41TCZBkbvC8DPJJpJpnwGy1KHvLkB/I8UOaImQJ89FGU2wvMjcrh85TBy?=
 =?iso-8859-1?Q?neM5RviKAwYDD4OxZwH73acyDs4QZEjoUAimpfnjww0y/BBT9QSkDexgh5?=
 =?iso-8859-1?Q?O45+xIDT29qEiISGOvtBM/NsYS6rpJPuOpIE6YBKUbTkytwphEdyNvPUx/?=
 =?iso-8859-1?Q?q/Op31fGqBV38Lh9rnn/WleJ/pCFeGH8+J6SQSntrl4PMaBpilCQUzmPaG?=
 =?iso-8859-1?Q?BmAS2bibJ1nXtiTwhJXhvMWDOE7IY1ep/+Y2kQm2HJLwk7j80MVS9lBhAF?=
 =?iso-8859-1?Q?zbX/8Hd0CkxdevfF7pYZ0pEakGPGVYQwQ5SBp5f5TU9boKJWSiZMGZzvlh?=
 =?iso-8859-1?Q?upb/qa0MgJeJQ7M86k5R9ziK6kJIT9UKAIsMBTLw9dWEb3hgiJFWvgMv7V?=
 =?iso-8859-1?Q?ZSpGN97R8uUgDmSZ4l2l2Ue1nK2ngPKt2u?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d060c76e-9d3b-461c-456c-08dbebeff7f7
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 06:46:49.4879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U47r/eNOBFsxO/0di9ziQYl2cbliqi6mV47zNVEY/2xX4X0Ayj7qIHp51n4O18KgEZ7mxoUsRqUbbJdNyNQq9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8286
X-OriginatorOrg: intel.com

Hi Philipp,

On Wed, Nov 22, 2023 at 09:15:52AM +0100, Philipp Stanner wrote:
> On Wed, 2023-11-22 at 01:51 +0000, Liu, Yujie wrote:
> > Please kindly ignore these duplicate reports. There seems to be a bug
> > in the robot and we will fix this ASAP. Sorry for the noise.
> 
> They are not exactly duplicates, I think. You notice that by the mails'
> bottoms:
> 
> Mail N:
>    WARNING: unmet direct dependencies detected for GENERIC_PCI_IOMAP
>      Depends on [n]: PCI [=n]
>      Selected by [y]:
>      - SPARC [=y]
> 
> Mail N-1:
>    WARNING: unmet direct dependencies detected for GENERIC_PCI_IOMAP
>      Depends on [n]: PCI [=n]
>      Selected by [y]:
>      - PARISC [=y]
> 
> etc...
> 
> So it seems to me that it's testing all the architectures and then
> sends an email for each one where the build fails.

Thanks for the feedback. Yes, it was testing on various architectures so
they were considered as different unique issues, and a separate report
was sent out for each of them.

However, there is some noise info in the report as shown below, which
indicates a bug in the bot. We will fix this ASAP.

   /usr/bin/grep: /db/releases/20231121182703/kernel-tests/etc/kcflags: No such file or directory
   {"timestamp":"2023-11-21 22:16:15 +0800", "level":"WARN", "event":"kbuild.sh:3942:in `add_etc_kcflags': grep exit 2 (ShellError)",

Best Regards,
Yujie

> 
> P.
> 
> > 
> > On Tue, 2023-11-21 at 23:56 +0800, kernel test robot wrote:
> > > Hi Philipp,
> > > 
> > > kernel test robot noticed the following build warnings:
> > > 
> > > [auto build test WARNING on pci/next]
> > > [also build test WARNING on pci/for-linus linus/master v6.7-rc2
> > > next-
> > > 20231121]
> > > [If your patch is applied to the wrong git tree, kindly drop us a
> > > note.
> > > And when submitting patch, we suggest to use '--base' as documented
> > > in
> > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > 
> > > url:   
> > > https://github.com/intel-lab-lkp/linux/commits/Philipp-Stanner/lib-move-pci_iomap-c-to-drivers-pci/20231121-060258
> > > base:  
> > > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> > > patch link:   
> > > https://lore.kernel.org/r/20231120215945.52027-3-pstanner%40redhat.com
> > > patch subject: [PATCH 1/4] lib: move pci_iomap.c to drivers/pci/
> > > config: sparc64-kismet-CONFIG_GENERIC_PCI_IOMAP-CONFIG_SPARC-0-0
> > > (
> > > https://download.01.org/0day-ci/archive/20231121/202311212316.a0awwk
> > > aE-lkp@intel.com/config)
> > > reproduce:
> > > (
> > > https://download.01.org/0day-ci/archive/20231121/202311212316.a0awwk
> > > aE-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a
> > > new
> > > version of
> > > the same patch/commit), kindly add following tags
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes:
> > > > https://lore.kernel.org/oe-kbuild-all/202311212316.a0awwkaE-lkp@intel.com/
> > > 
> > > kismet warnings: (new ones prefixed by >>)
> > > > > kismet: WARNING: unmet direct dependencies detected for
> > > > > GENERIC_PCI_IOMAP when selected by SPARC
> > >    /usr/bin/grep: /db/releases/20231121182703/kernel-
> > > tests/etc/kcflags: No such file or directory
> > >    {"timestamp":"2023-11-21 22:16:15 +0800", "level":"WARN",
> > > "event":"kbuild.sh:3942:in `add_etc_kcflags': grep exit 2
> > > (ShellError)", "detail":"cmd: '/usr/bin/grep' '-v' '-e' '^#' '-e'
> > > '^$' '/db/releases/20231121182703/kernel-tests/etc/kcflags'
> > > \nstderr:
> > > /usr/bin/grep: /db/releases/20231121182703/kernel-
> > > tests/etc/kcflags:
> > > No such file or directory\n\n", "hostname":"community-kbuild-
> > > consumer-123", "host_hostname":"lkp-worker50",
> > > "call_stack":"/zday/kernel-tests/lib/kbuild.sh:3942:in
> > > `add_etc_kcflags': /usr/bin/grep:
> > > /db/releases/20231121182703/kernel-
> > > tests/etc/kcflags: No such file or directory (ShellError 2)\n  from
> > > /zday/kernel-tests/lib/kbuild.sh:3971: setup_kcflags\n  from
> > > /zday/kernel-tests/lib/kbuild.sh:4016: invoke_make\n  from
> > > /zday/kernel-tests/lib/kbuild.sh:4122: make\n  from /zday/kernel-
> > > tests/lib/kbuild.sh:5623: make_config_allyes\n  from /zday/kernel-
> > > tests/common.sh:209: redirect_error_to_screen\n  from /zday/kernel-
> > > tests/common.sh:217: redirect_command_errors\n  from /zday/kernel-
> > > tests/lib/kbuild.sh:5630: make_config\n  from /zday/kernel-
> > > tests/lib/builder/kismet.sh:156:
> > > generate_make_olddefconfig_warnings\n  from /zday/kernel-
> > > tests/lib/builder/kismet.sh:297: builder_compile\n  from
> > > /zday/kernel-tests/bisect-test-build-error.sh:94: main\n"}
> > >    
> > >    WARNING: unmet direct dependencies detected for
> > > GENERIC_PCI_IOMAP
> > >      Depends on [n]: PCI [=n]
> > >      Selected by [y]:
> > >      - SPARC [=y]
> > > 
> > 
> 
> 

