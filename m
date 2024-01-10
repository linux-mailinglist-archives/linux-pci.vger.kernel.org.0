Return-Path: <linux-pci+bounces-2012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2997782A2B1
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 21:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA1528AADD
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 20:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA23C58110;
	Wed, 10 Jan 2024 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpJ/3OUV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A589458101;
	Wed, 10 Jan 2024 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704919305; x=1736455305;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ffGcAklL2lninX1ZFIw2hyes7AsdGzZjRBETjam5ZnU=;
  b=GpJ/3OUVuwx3RkI4scY91kFZ+DLAXNtV5OwpABCOpxKPIHFzLg5owPD2
   IY3gXAXT+jTbOKaAvN/v0AyYPlbSBivl7jjImTiA/QFqA7kerKHjDSg+b
   kgF3xMDX41ThQHa5zcGmp3x4hrZEurHYqlMG8ehpgx3HCf1CjrfqrGbqw
   kN4K7sn/StAnbQHPZcpQr57w9d27Qi1BM0/IchRdNDRYW3dIDPms/tdIA
   0Gfb+rG/5hJAZhDgZrMh8Wi9ZJMV5uYiWlc31FU4Jo9BvxqVyYjRChw7/
   vdI8tUvOEHcilqg0I7ZGhFLFlI4sg+04PrrDA8Qk2A3YDXkgtLdVELs15
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="5380533"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5380533"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 12:41:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="925771272"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="925771272"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2024 12:41:28 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 12:41:28 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 12:41:27 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 12:41:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Jan 2024 12:41:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+VmXPUrY8yfixC13vrL+6Olyi8MuDoq0uSIB5tMXHzG58PbK6bZ6GHXHOujb6mBW1nzqrLCo1xNZjxLH99gMtUwKCJi7Nh4TbYsBicuPaR0zpZAzvOm98HoNx1mUc5vAup0wGCHNXUFibK58lv38/Q1lTFFSymbJYc+jShun4P1w9GzneQD5rO3Vt0iFn9L0Op0+RLXvgdItIY15Rr08qB0fv+Z15Sffrlj4xYR52UOjhHlPs6teDnTqv9jHYUB9lzqsae33j3SdrehgngWqyYtnRj9l+QrWn/aO0WIz1XpoE8uwWPPw2Ow3E6fOkwdWWsgVCVdP1Vz/7CO0svrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6hZCnv3dg+fI5RBw3kVRLKzndNDUh/Q35f8fBTjEVM=;
 b=lTn9g8TmGNt1pIteWrIRkfrJ/wOMQqKTjMGGxKTNnD7N+AaFAKme0FPmwyj5UA8jJr6+I83GSuHDbB8bdwIqiX0SN/wyUK9NOx15xRSw+lV6wOrj0zE+n131ZdwozXo+LhIwD1djLJrkeaSrfxeuxCMX3dAeimyL1EVtcyty12e9kZmeTq0ae1e8ZWPLr5mG+dMj05OBBnjxF8nuf0/tb/LqOCoxZowm7WUDnSllq70dRrY9YwX7P2KSHtPjCiX9PqcvR1JzDTyKSKVM7v3qxLayf5508SN0phldaCZhO5gY6jfgHpZ5447KWvSQYUAj9sSXX4jewfzsePwPBLxu4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7678.namprd11.prod.outlook.com (2603:10b6:208:3f4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Wed, 10 Jan
 2024 20:41:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 20:41:22 +0000
Date: Wed, 10 Jan 2024 12:41:17 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Lukas Wunner <lukas@wunner.de>, Bartosz Golaszewski <brgl@bgdev.pl>
CC: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
	<konrad.dybcio@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Heiko
 Stuebner" <heiko@sntech.de>, Jernej Skrabec <jernej.skrabec@gmail.com>,
	"Chris Morgan" <macromorgan@hotmail.com>, Linus Walleij
	<linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>,
	=?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado <nfraprado@collabora.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>,
	Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman
	<terry.bowman@amd.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Ilpo
 =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Huacai Chen
	<chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, Srini Kandagatla
	<srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-wireless@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>, "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC 3/9] PCI/portdrv: create platform devices for child OF nodes
Message-ID: <659f00ed271b3_5cee2942@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240104130123.37115-1-brgl@bgdev.pl>
 <20240104130123.37115-4-brgl@bgdev.pl>
 <20240109144327.GA10780@wunner.de>
 <CAMRc=MdXO6c6asvRSn_Z8-oFS48hroT+dazGKB6WWY1_Zu7f1Q@mail.gmail.com>
 <20240110132853.GA6860@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240110132853.GA6860@wunner.de>
X-ClientProxiedBy: MW2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:907::14)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: 6369179d-9efb-4eee-f92a-08dc121c81a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p524JGEwFSS2uHxKmuFSyqimT7zAyPY8tLoHD/cFs83sOUyLgZngMed10qNrbE4qHc+VJuFds0300I4cSkry64wrjdvmP26tmIxMX8t78RVW6FTXEp3OCNZUl+8Dl0o+5Mo63E9vlx+0Sv3n8JT9Z9h9csYSESyGqVlWuJ3O+OT+CXmgYqKN4B3l5cBsPgenV5hIMZqQjaOcRiL1IlSjR22BMsIH6cwNk+daOPc9hDPKeO3EsZu5VR9l6/RgWIdenNZuRm7iAXX39jgobRW3KarrdObyCGEzJU8VGNZhMmRp4latG1spI9Kr/NLCPmcHrxxek/E9nlt/cAax57/RgtqQJyERW0uqI63txRYoCRNcBLENty1++XCVa7oZ1dihEYOt+00dP+m85zfvKyNfRzQOx0heckAuWMHti+kwdx1L7Q5AwlsG78uYSm/uBAGwsoGtHhIenNMAV0xuQSUMlPGjC3t91135c9RASIj0SgyMA6nYkq+JJQJhOBzp3HY9RCgLsXMbiEeCTDt4gpMwS7NR1wkCTTe934iw/p5QBsM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(478600001)(6506007)(966005)(6486002)(26005)(9686003)(6666004)(6512007)(7416002)(66476007)(316002)(83380400001)(41300700001)(2906002)(66946007)(5660300002)(4326008)(8936002)(110136005)(8676002)(54906003)(66556008)(86362001)(38100700002)(82960400001)(7406005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OUkq4zuUmoXIShFbM6OuObXnRqokWY8iG1wKStMKxlJnCFzLmri9D8eAdVcx?=
 =?us-ascii?Q?xld7Nwf7xjvmQWiRIcsAZIxNLMkgGBkQHJFVG+YJsn0mQdCZUu2/eQ5/BFto?=
 =?us-ascii?Q?Z7s0Ou5cbg/Pj/0hoeMu6YjRGgxAwss7kL03ItxUPWFOH8eO+eVoy1clm2RI?=
 =?us-ascii?Q?Dh5NM4ejAVmnF5+VM7HPwsHDi4luUtrTZ9WrFCqVPQIAjBhC0l9IMF8DfcJZ?=
 =?us-ascii?Q?pdjC6d65rPGf2xWB2EoucL8L3JvGRUWEKWMLIRI6pLyS8gmzK6I1ubYTr9Ou?=
 =?us-ascii?Q?how6V7veL0nN3osHFJ+KmZvnYm9pRgAvG/wIYebr5mhoERZrI1uiBgbkTySS?=
 =?us-ascii?Q?GDJINlXz565P80ymUjdEhS1gdhow8Ozl7enUpwFb2h/UdwgNCaWMSw5tUJb0?=
 =?us-ascii?Q?kjojftNUdXrY4ScWDHZUzkljMUIrrH/DSgsafE0HgKWThyOrsgmnfl9cMhvt?=
 =?us-ascii?Q?2vmk4JT9Mv3A4fGbfnop9sDzjzCidg9o4cLE9lnFfYfx5zNhakpVZmy1jkBy?=
 =?us-ascii?Q?33RENiwhYdiKzdA1sUvugLRWeVZmdVu1WDn6ctcILpb9JyMTCSd5a49BzIpc?=
 =?us-ascii?Q?nnxVjPXpIzZEfRObBw9ta3dIiciQmucKJvZQS2urLFD4XXt9iq+IyuNOzyIo?=
 =?us-ascii?Q?jmKJIa5BJdy0FIglhuYZJQu4eaMZnOunuKgNR0nhady6XW/AzsB+yR/aENfD?=
 =?us-ascii?Q?JgZ7bSGzZfuvX0FXkWN1+6+rlZ8zKPBjaoqhLhwzbDjneD2udrTbU1sgntEj?=
 =?us-ascii?Q?THoQOlaKoD4qrnQJIPQwtXrRtM455IOLnQhM4tExOPHNBsGIPM4BcdBs9ECk?=
 =?us-ascii?Q?dUGtFcQxzWccmfAcW3ZjBN9LmzOfSa/THRe5ZENnv/Y3aCTL/DrcOAsIF2h9?=
 =?us-ascii?Q?gBMdpP59CYTfoieGdtSktG7o5tLHUaoeCpcJrbqYDkESXzfJFM3NLSUSHsbe?=
 =?us-ascii?Q?exlIo2F8Pugmh5gJp25de5iGAgsHKtnXlLHwmmKpUY8iD9rp5Vu542/n2mTP?=
 =?us-ascii?Q?9zt/OnTeBJ2saUpmEiXOxNMBPZS6F1fvRQ0/IYFOqvHcKpzbQOvgFV4B0vPX?=
 =?us-ascii?Q?OcKOPJWTWEcGUyd2doPx/nrYtlSFUuvnHA3CaaeGZsdMIe3zzyEtkjUswFDc?=
 =?us-ascii?Q?S17aXN9q+NoqladvhFLg9awFkVM5Hip/V85OdB7d+Rc2zXzQPEfqMq8n0D+m?=
 =?us-ascii?Q?XrK1U2hiypWoKZ+E9TFu2rdvYSiOkE5Tm9cEFNsR1aqruVwMGeknZpY0SFVY?=
 =?us-ascii?Q?KTWpy69zRvnqFLqozK2dcRADGrviNbRxBLtRQXItWwzasCrBi1qA+V++Lf4j?=
 =?us-ascii?Q?wi5ZtWdDiKYbHCxWENhmJx/HGB5S5huwIu2i1ZD9TspEjbVPV+P14OOr3hKa?=
 =?us-ascii?Q?uYwd9KI9FkAP14dRx1XbZ7FeJVe6cY1JyaxnuNV5jwvM0YLxYUiaPfFRvNuX?=
 =?us-ascii?Q?pXn469V7S0NPnUg/ZBFiJrdFtOlgDRs45lzdazzvb5iGy3QDAoMf+oX42856?=
 =?us-ascii?Q?2wHxH5nWtrqs5Cp+Xzk5JKbCjlnv50gC9HRzMwKN/jqg5o1yclwCUErJuS0K?=
 =?us-ascii?Q?eMp5dlt3dxo6SjIItoD0sVpRiKFqLOAdUrgU4uqTWMhNwYFFjTML3f1y6dzd?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6369179d-9efb-4eee-f92a-08dc121c81a2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 20:41:22.4522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMgbOgl7lgfXWezTYZtX6Mp6rQowgBZRqFhuSApoHiCPASKMnvS2Lm9UOxqIfshoNLNjMCv1g5dHS7XffY9DGAKCjDK3NnKhvj6+HN0lz5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7678
X-OriginatorOrg: intel.com

[ add Terry ]


Lukas Wunner wrote:
> On Wed, Jan 10, 2024 at 01:55:18PM +0100, Bartosz Golaszewski wrote:
> > On Tue, Jan 9, 2024 at 3:43???PM Lukas Wunner <lukas@wunner.de> wrote:
> > > On Thu, Jan 04, 2024 at 02:01:17PM +0100, Bartosz Golaszewski wrote:
> > > > In order to introduce PCIe power-sequencing, we need to create platform
> > > > devices for child nodes of the port driver node. They will get matched
> > > > against the pwrseq drivers (if one exists) and then the actuak PCIe
> > > > device will reuse the node once it's detected on the bus.
> > > [...]
> > > > --- a/drivers/pci/pcie/portdrv.c
> > > > +++ b/drivers/pci/pcie/portdrv.c
> > > > @@ -715,7 +716,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
> > > >               pm_runtime_allow(&dev->dev);
> > > >       }
> > > >
> > > > -     return 0;
> > > > +     return devm_of_platform_populate(&dev->dev);
> > > >  }
> > >
> > > I think this belongs in of_pci_make_dev_node(), portdrv seems totally
> > > the wrong place.  Note that you're currently calling this for RCECs
> > > (Root Complex Event Collectors) as well, which is likely not what
> > > you want.
> > >
> > 
> > of_pci_make_dev_node() is only called when the relevant PCI device is
> > instantiated which doesn't happen until it's powered-up and scanned -
> > precisely the problem I'm trying to address.
> 
> No, of_pci_make_dev_node() is called *before* device_attach(),
> i.e. before portdrv has even probed.  So it seems this should
> work perfectly well for your use case.
> 
> 
> > > devm functions can't be used in the PCI core, so symmetrically call
> > > of_platform_unpopulate() from of_pci_remove_node().
> > 
> > I don't doubt what you're saying is true (I've seen worse things) but
> > this is the probe() callback of a driver using the driver model. Why
> > wouldn't devres work?
> 
> The long term plan is to move the functionality in portdrv to
> the PCI core.  Because devm functions can't be used in the PCI
> core, adding new ones to portdrv will *add* a new roadblock to
> migrating portdrv to the PCI core.  In other words, it makes
> future maintenance more difficult.
> 
> Generally, only PCIe port services which share the same interrupt
> (hotplug, PME, bandwith notification, flit error counter, ...)
> need to live in portdrv.  Arbitrary other stuff should not be
> shoehorned into portdrv.

I came here to say the same thing. It is already the case that portdrv
is not a good model to build new functionality upon [1], and PCI core
enlightenment should be considered first.

The portdrv model is impeding Terry's CXL Port error handling effort, so
I am on the lookout for portdrv growing new entanglements to unwind
later.

[1]: http://lore.kernel.org/r/20221025232535.GA579167@bhelgaas

