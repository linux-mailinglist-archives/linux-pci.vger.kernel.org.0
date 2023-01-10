Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829876638B1
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 06:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjAJFnk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 00:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjAJFnj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 00:43:39 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C2E3C3B7;
        Mon,  9 Jan 2023 21:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673329417; x=1704865417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Un44orzEdFpMKbehDrBxqFEOpZXArp4/k7FqlhGhph4=;
  b=SQXoCOZH/9KBtq11aT8XRRK/9Zp1CnWaQS5XIajWbj9MZ0y++zO2WEc8
   nojypdDgg1uBZnv25zy5UkNCgzKsXABEsQpeTQujN0ajiBDb5O0zzXjDt
   4r2z7/Qzikd4ZPufx6q2M13GqfrCjp35GCVxXtguQHY0Hiv8QhGrtQqnP
   ia578Zaj/kgjeJfDwCinxGJYpvkwqt2RbOJtDbdIcOD+rF5UExWPa2wFA
   3l+mGj6u/GmP5Qn1wmWAzj8K2NJTU8Klij1eSQ/+JqE9/3y66G/gSgGWj
   VLgQR/dMqISUlkaUPMQwpOU5bORybrDzXxgze/GXs3gxlyl2xZHxRom55
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="323137418"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="323137418"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 21:43:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="830877000"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="830877000"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 09 Jan 2023 21:43:36 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 21:43:36 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 21:43:36 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 9 Jan 2023 21:43:36 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 21:43:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfzrhCVe91ScpttrKhcnqwCMjEZILKTCZ4fbyefip3Q47KZ2qesNElLVZOvg/zLvSd/I90r9x3zSXBwu30rgNga/ON84ys4dl9oXsSMPvl1fUQ4y+nrEkjTe6uahSB5sphW5n6UTzyfoiIY6UTYx+bRiYwZ1ReQrD1Pu0VkuRUB2vnaSGN4EcbNKltbGDmSSWME1vipxUkBPXoWGa0j+Vq1ISsmw9HMey6iLG3n6tn8KvNXoeIFPEdoMlcF3HvpRQJkp1sUVW/xFalZaRRS8hYv0U6kegrF43VOZJ9Gdgb45IXtS2Fl1YX+hVaKLqtdZDZyylmZ87kYByz2jimATug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m83idNkQEaoDXbwQ721i0Wif2YR6JRquERm98E17ILM=;
 b=AEq7NYYzL0nR+5zWUp0fT5/y8spdu5A2sN+5ZZPKwcsodv3fsUJ1yQP7B2xjzOpGz5B7orttFKuJ8pNIlrMGACEC3yL/PFB2UGANV+AeaA21xtKCg241Khh0EiVl7dEdctm/8f1Sk5N7WXIWPRY1KHHnAvQJbTjbwH6ON95/BUQW2QwL3eNAr2DFMLDM2JV+ahFtaIwPULBX8CC/meFa1r6oJJNCwpGT9i2IuUONjMHeo7NRxhsV8NS2Zjtbj1EWai43Z6N4UL/1n4r54ztRjqOelRnBjVkOaMXWiiZECMXPA6SAOb3Bto1LedkuXF0dXqpDNxOR7l1tEGyzryU+bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4092.namprd11.prod.outlook.com (2603:10b6:5:192::24)
 by IA0PR11MB7305.namprd11.prod.outlook.com (2603:10b6:208:439::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 05:43:31 +0000
Received: from DM6PR11MB4092.namprd11.prod.outlook.com
 ([fe80::a2b4:899c:a82b:eb14]) by DM6PR11MB4092.namprd11.prod.outlook.com
 ([fe80::a2b4:899c:a82b:eb14%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 05:43:31 +0000
From:   "Sun, Yunying" <yunying.sun@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "kernelorg@undead.fr" <kernelorg@undead.fr>,
        "kjhambrick@gmail.com" <kjhambrick@gmail.com>,
        "2lprbe78@duck.com" <2lprbe78@duck.com>,
        "nicholas.johnson-opensource@outlook.com.au" 
        <nicholas.johnson-opensource@outlook.com.au>,
        "benoitg@coeus.ca" <benoitg@coeus.ca>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "wse@tuxedocomputers.com" <wse@tuxedocomputers.com>,
        "mumblingdrunkard@protonmail.com" <mumblingdrunkard@protonmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Box, David E" <david.e.box@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: RE: Bug report: the extended PCI config space is missed with 6.2-rc2
Thread-Topic: Bug report: the extended PCI config space is missed with 6.2-rc2
Thread-Index: AQHZIEp5QwkO/GW1JkeMAQNxX48tXq6QaryAgAASXACAAAwngIAAByUAgAEZEICAAAhAgIAAL18AgAAMYwCAAAe+gIAFNLkw
Date:   Tue, 10 Jan 2023 05:43:31 +0000
Message-ID: <DM6PR11MB40921AA8D47A7E603085F496F2FF9@DM6PR11MB4092.namprd11.prod.outlook.com>
References: <SJ1PR11MB60831BF4EB453AB0EF5A6F0CFCFB9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230106220449.GA1255065@bhelgaas>
In-Reply-To: <20230106220449.GA1255065@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4092:EE_|IA0PR11MB7305:EE_
x-ms-office365-filtering-correlation-id: 03ea67eb-878a-4efd-06cc-08daf2cd9b6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8cuMBKNCFeapXgG4R0BvQyCyEag6QJX6PSm02bdjRj9ptJYcwQ0CA+GawdI/kybeI1wFoSQgWrRgAqbt/lR9ILIO7wzM5SqnCdRFYfHvt9Wif/RbtRVvzA5ZSGhShj9MTDaWi3ik3GUsDcbNwlwqfdFugQX1/N3t5CV8NzNIMmQ4Tdex4JivTuxf8KImGlKK3fLfQOZqImd4tcwRV0AxxegNQKp/CMIq8+io2Zd6G77irvW0e3LXOh0/4QmOu6Rmnxl88O6ef4gSDosvNS3LWVY6NvUIxk/NsR64JdSQbfTRdvnDYxVZFgImi0Mpm983t2F01ESARfKrch+d5qgKdi8dEQtZRhM3Ouml/ufcrATlkEb9CjZbVVa8DIU3hgcqBYfoxl+dDSp51GSQwOTs58TxE/eXjgxnu3EnGqPUx7RatM14ww3RqE6aPm+3HjZTI0MlCzhFnnSENJCkctTE5N7jAzB3xcRFoeTOZHyJoL9L81quSu+DTlI3khhBr7MFVqBmGPqX9Vjh/oZfq7dfHvaergYoivmJSTATvpl5bK5Uh80a45SiU2H/a2S7xq2xYohJCS5pVs/op8KBs/4+SAjqqwg0ZYBiOvnA3sb5Xd+bS94wVEyQkV4yglOtk8LFuQWhznP1J0V5wBDyfPO6btaQRlBpJ6ywZ+YSYZ878wktLiAG3gUMDUSY7P9qEQEFeG0adAoYYNJVwKfgAClwEzZiKaBK8IEL6eGk80COLGE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4092.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199015)(7416002)(33656002)(5660300002)(71200400001)(316002)(26005)(9686003)(7696005)(186003)(478600001)(966005)(45080400002)(41300700001)(110136005)(54906003)(76116006)(64756008)(66946007)(66476007)(4326008)(66446008)(66556008)(8676002)(52536014)(8936002)(38070700005)(83380400001)(86362001)(55016003)(53546011)(6506007)(122000001)(38100700002)(82960400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hiaoNLU+qCaT0y4HpAqdRufJo5sKngs4e/TUjrmhiLH0IEwO2ZIArh21fElU?=
 =?us-ascii?Q?RSy8BsRCuC/W/1AOBkcMn+oeUilMiODWfYqR9XsFsFMmvvN2w5cuxtB/aINR?=
 =?us-ascii?Q?9g3d4beoXwsZN5FV5dLW96PSi5tDBBujep2ABJkXk7CsMzPQyLGK0IWfItw5?=
 =?us-ascii?Q?p+rpMmUD40aYivFUVw1EtOwnZ8YdxP7W1HFhSJogIjLHvXE7gFP4q1sFMb0q?=
 =?us-ascii?Q?jVe0LWYd2Mz9N0TZWIOJXiRxNODHXHwaZ7nhmgFygsFFzJq+MDbbZSdkv2Bq?=
 =?us-ascii?Q?R3a8jjUK5jKcBbTKKBCp9llN5mVmc/tFoSfATa7462CYqstRP1rdb16/5O8q?=
 =?us-ascii?Q?EzLIVcb85TQkiuK0+DwQZ6fUDt9b3akczBZjzA9omosp+UbEYABXrgYpxjDd?=
 =?us-ascii?Q?yvxN+qMrazrz0FXZCp1tC6dv7HlHDuLbU0nUozW+6Fg6FMjwWavEJEffayOO?=
 =?us-ascii?Q?w3CxgjJfssfNsBd4yYigibaMLaWB8TvN7V/IbnmtzqCL9xlYMZn9n74cilwT?=
 =?us-ascii?Q?5wJeCZ/1p3awjRwSfMKWF7e9spdBPO5ODw46OEYITHCRSxKtimKK6qqxW6xJ?=
 =?us-ascii?Q?KdqfTIYfPEeaw2toWTvgK9Nsyj2AO3UT5Dz1xmOsQI+d1ESfUZfqmWVLN7Un?=
 =?us-ascii?Q?jCui1a63oBB0/SSVJh83Mqeoxt4O4toW1VAVJweTP3vIPBjrpXR6PS3yfFap?=
 =?us-ascii?Q?qEQwogff2ATiJKSi+KBv1MhidGoZRHidGNTKvmwN859Z2TmVkopFqPEzOKQU?=
 =?us-ascii?Q?+0iFK9BPUdgyqLw6cX3R6528l8A/eNuAotmFU0MjsjAYtil34sY1/e2op2c7?=
 =?us-ascii?Q?IhvUmrLiqgVCx+wRG3zbYzgIdyKNTGXaLWAWtrZdFHJiWmQR9oyvnkYX14Ey?=
 =?us-ascii?Q?bH3gNaur8PiyNRdU/M9/5PmcwNhn6K/6u1iSUSKOxePRKKahEuVF/3yOvdha?=
 =?us-ascii?Q?lAd8ONSYxBK/+2TGyz07GtcoFLRC3z9Ye8cHJCOpR08aY0/PndDgfXRF8A9T?=
 =?us-ascii?Q?7Ba7YSdAvhmwOKImscm61ce66169yEcyaIgQy0KI/Jz4Q4RO83bNkUoB8+Cr?=
 =?us-ascii?Q?zGsiH1mzzBVGmvqvnZIF8FMJFHV/hTl8GyosVGvuLw7rx3jXbf4oJgV4ZVFy?=
 =?us-ascii?Q?5v9t7qP2SllUL+oT5G+7DOcYtltLieCFNmA/xH/kHVKWByzIGOKjTtab3rQ7?=
 =?us-ascii?Q?hHSA65NsWf79sxcAKglPcq/fjHYHR+VVjIZjQPPtuLSbNcYAfSvZZGTGq5Z+?=
 =?us-ascii?Q?2/KbBwYAC5+/ypbBgQHQVh07GedI5NFukpgGbHIZVIODOV8vQ28mstGVRjUr?=
 =?us-ascii?Q?y9LU7eLIyFmERp3E7NKT8h92Xl6m6s5K2ct44eBk4UhRPvZS4jvAdIrlFoDn?=
 =?us-ascii?Q?wJw1uIz84La2gD+bd0GHSPHNx89FjFBAiexpXlww0aGGwQVsxUA2UIsj7fDu?=
 =?us-ascii?Q?cfnDN5NuahIiS3YWP6Dwwsb5mGdZQjFFeeIGQ1zt/jguGG79rtYdhry74hz5?=
 =?us-ascii?Q?+WOHGHCqE2aZdpH0uqxCNraj16W1jNks8CSZv5hKErgVpTftq/zX+LCkK4Eu?=
 =?us-ascii?Q?qmdbdRIeqb6KG2xFYgeT/aK+f/4qQNAU6fNyU+3d?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4092.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ea67eb-878a-4efd-06cc-08daf2cd9b6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 05:43:31.5668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bL4K3sQdNeygcSdqMrNgcJMtwIHlcUdBSN5r0pjVMHx84r1nU7QTnE5bRIXE5vEJIaZB+MnmPErKc61cTnrjvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7305
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Verified this updated patch on SPR DNP and SPR MCC, it fixes the perf uncor=
e driver not working issue.

Tested-by: Yunying Sun <yunying.sun@intel.com>

-Yunying

-----Original Message-----
From: Bjorn Helgaas <helgaas@kernel.org>=20
Sent: Saturday, 7 January, 2023 06:05
To: Luck, Tony <tony.luck@intel.com>
Cc: Williams, Dan J <dan.j.williams@intel.com>; Liang, Kan <kan.liang@linux=
.intel.com>; bhelgaas@google.com; hdegoede@redhat.com; kernelorg@undead.fr;=
 kjhambrick@gmail.com; 2lprbe78@duck.com; nicholas.johnson-opensource@outlo=
ok.com.au; benoitg@coeus.ca; mika.westerberg@linux.intel.com; wse@tuxedocom=
puters.com; mumblingdrunkard@protonmail.com; linux-pci@vger.kernel.org; lin=
ux-kernel@vger.kernel.org; Box, David E <david.e.box@intel.com>; Sun, Yunyi=
ng <yunying.sun@intel.com>; Jiang, Dave <dave.jiang@intel.com>
Subject: Re: Bug report: the extended PCI config space is missed with 6.2-r=
c2

On Fri, Jan 06, 2023 at 09:37:06PM +0000, Luck, Tony wrote:
> > Thanks, Tony!  Something is wrong with the EFI MMIO removal=20
> > (obviously), but I don't see what it is.  Could you try the patch=20
> > below (replacement for previous one, with more debug)?
>=20
> Swapped out old patch for this new one. Booted with efi-debug
>=20
> New dmesg attached.

Thanks!  Ah, off-by-one error because e820__mapped_all() expects "[start, e=
nd)" which means is_acpi_reserved() and is_efi_mmio() must use the same, an=
d I was thinking "[start, end]" like a struct resource.

The below should work better.

commit 696ac9286d3d ("x86/pci: Treat EfiMemoryMappedIO as reservation of EC=
AM space") parent 1b929c02afd3
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Jan 5 16:02:58 2023 -0600

    x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space
   =20
    Normally we reject ECAM space unless it is reported as reserved in the =
E820
    table or via a PNP0C02 _CRS method (PCI Firmware, r3.3, sec 4.1.2).  Th=
is
    means extended config space (offsets 0x100-0xfff) may not be accessible=
.
   =20
    Some firmware doesn't report ECAM space via PNP0C02 _CRS methods, but d=
oes
    mention it as an EfiMemoryMappedIO region via EFI GetMemoryMap(), which=
 is
    normally converted to an E820 entry by a bootloader or EFI stub.
   =20
    07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map"), remov=
es
    E820 entries that correspond to EfiMemoryMappedIO regions because some
    other firmware uses EfiMemoryMappedIO for PCI host bridge windows, and =
the
    E820 entries prevent Linux from allocating BAR space for hot-added devi=
ces.
   =20
    Allow use of ECAM for extended config space when the region is covered =
by
    an EfiMemoryMappedIO region, even if it's not included in E820 or PNP0C=
02
    _CRS.
   =20
    Fixes: 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map")
    Link: https://lore.kernel.org/r/ac2693d8-8ba3-72e0-5b66-b3ae008d539d@li=
nux.intel.com

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.=
c index 758cbfe55daa..5c6cadd60fef 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -12,6 +12,7 @@
  */
=20
 #include <linux/acpi.h>
+#include <linux/efi.h>
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/bitmap.h>
@@ -442,6 +443,34 @@ static bool is_acpi_reserved(u64 start, u64 end, enum =
e820_type not_used)
 	return mcfg_res.flags;
 }
=20
+static bool is_efi_mmio(u64 start, u64 end, enum e820_type not_used) {
+	efi_memory_desc_t *md;
+	u64 size, mmio_start, mmio_end;
+
+	end--;		/* caller supplies start, end =3D start + size */
+	pr_info("is_efi_mmio %#lx-%#lx\n",
+		(unsigned long) start, (unsigned long) end);
+	for_each_efi_memory_desc(md) {
+		if (md->type =3D=3D EFI_MEMORY_MAPPED_IO) {
+			size =3D md->num_pages << EFI_PAGE_SHIFT;
+			mmio_start =3D md->phys_addr;
+			mmio_end =3D mmio_start + size - 1;
+
+			pr_info("  efi_mmio %#lx-%#lx\n",
+				(unsigned long) mmio_start,
+				(unsigned long) mmio_end);
+			if (mmio_start <=3D start && end <=3D mmio_end) {
+				pr_info("is_efi_mmio true\n");
+				return true;
+			}
+		}
+	}
+
+	pr_info("is_efi_mmio false\n");
+	return false;
+}
+
 typedef bool (*check_reserved_t)(u64 start, u64 end, enum e820_type type);
=20
 static bool __ref is_mmconf_reserved(check_reserved_t is_reserved, @@ -452=
,23 +481,24 @@ static bool __ref is_mmconf_reserved(check_reserved_t is_res=
erved,
 	u64 size =3D resource_size(&cfg->res);
 	u64 old_size =3D size;
 	int num_buses;
-	char *method =3D with_e820 ? "E820" : "ACPI motherboard resources";
+	char *method =3D with_e820 ? "E820" : "ACPI motherboard resources or=20
+EFI";
=20
+	pr_info("is_mmconf_reserved %ps [bus %02x-%02x] %pR\n",
+		is_reserved, cfg->start_bus, cfg->end_bus, &cfg->res);
 	while (!is_reserved(addr, addr + size, E820_TYPE_RESERVED)) {
+		pr_info("  %#lx-%#lx (size %#lx) not reserved\n",
+			(unsigned long) addr, (unsigned long) (addr + size - 1),
+			(unsigned long) size);
 		size >>=3D 1;
+		pr_info("  size reduced to %#lx\n", (unsigned long) size);
 		if (size < (16UL<<20))
 			break;
 	}
=20
-	if (size < (16UL<<20) && size !=3D old_size)
+	if (size < (16UL<<20) && size !=3D old_size) {
+		pr_info("is_mmconf_reserved %ps false\n", is_reserved);
 		return false;
-
-	if (dev)
-		dev_info(dev, "MMCONFIG at %pR reserved in %s\n",
-			 &cfg->res, method);
-	else
-		pr_info(PREFIX "MMCONFIG at %pR reserved in %s\n",
-		       &cfg->res, method);
+	}
=20
 	if (old_size !=3D size) {
 		/* update end_bus */
@@ -487,30 +517,42 @@ static bool __ref is_mmconf_reserved(check_reserved_t=
 is_reserved,
 				&cfg->res, (unsigned long) cfg->address);
 		else
 			pr_info(PREFIX
-				"MMCONFIG for %04x [bus%02x-%02x] "
+				"MMCONFIG for %04x [bus %02x-%02x] "
 				"at %pR (base %#lx) (size reduced!)\n",
 				cfg->segment, cfg->start_bus, cfg->end_bus,
 				&cfg->res, (unsigned long) cfg->address);
 	}
=20
+	if (dev)
+		dev_info(dev, "MMCONFIG at %pR reserved in %s\n",
+			 &cfg->res, method);
+	else
+		pr_info(PREFIX "MMCONFIG at %pR reserved in %s\n",
+		       &cfg->res, method);
+
 	return true;
 }
=20
 static bool __ref
 pci_mmcfg_check_reserved(struct device *dev, struct pci_mmcfg_region *cfg,=
 int early)  {
+	pr_info("pci_mmcfg_check_reserved([bus %02x-%02x] %pR, %s)\n",
+		cfg->start_bus, cfg->end_bus, &cfg->res,
+		early ? "early" : "late");
 	if (!early && !acpi_disabled) {
 		if (is_mmconf_reserved(is_acpi_reserved, cfg, dev, 0))
 			return true;
+		if (is_mmconf_reserved(is_efi_mmio, cfg, dev, 0))
+			return true;
=20
 		if (dev)
 			dev_info(dev, FW_INFO
-				 "MMCONFIG at %pR not reserved in "
+				 "MMCONFIG at %pR not reserved in EFI or "
 				 "ACPI motherboard resources\n",
 				 &cfg->res);
 		else
 			pr_info(FW_INFO PREFIX
-			       "MMCONFIG at %pR not reserved in "
+			       "MMCONFIG at %pR not reserved in EFI or "
 			       "ACPI motherboard resources\n",
 			       &cfg->res);
 	}
@@ -536,6 +578,7 @@ static void __init pci_mmcfg_reject_broken(int early)  =
{
 	struct pci_mmcfg_region *cfg;
=20
+	pr_info("pci_mmcfg_reject_broken(%s)\n", early ? "early" : "late");
 	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
 		if (pci_mmcfg_check_reserved(NULL, cfg, early) =3D=3D 0) {
 			pr_info(PREFIX "not using MMCONFIG\n"); @@ -570,6 +613,7 @@ static int =
__init pci_parse_mcfg(struct acpi_table_header *header)
 	unsigned long i;
 	int entries;
=20
+	pr_info("pci_parse_mcfg\n");
 	if (!header)
 		return -EINVAL;
=20
@@ -661,6 +705,7 @@ static int __initdata known_bridge;
=20
 void __init pci_mmcfg_early_init(void)
 {
+	pr_info("pci_mmcfg_early_init\n");
 	if (pci_probe & PCI_PROBE_MMCONF) {
 		if (pci_mmcfg_check_hostbridge())
 			known_bridge =3D 1;
@@ -674,6 +719,7 @@ void __init pci_mmcfg_early_init(void)
=20
 void __init pci_mmcfg_late_init(void)
 {
+	pr_info("pci_mmcfg_late_init\n");
 	/* MMCONFIG disabled */
 	if ((pci_probe & PCI_PROBE_MMCONF) =3D=3D 0)
 		return;
@@ -725,6 +771,8 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8=
 start, u8 end,
 	struct resource *tmp =3D NULL;
 	struct pci_mmcfg_region *cfg;
=20
+	dev_info(dev, "pci_mmconfig_insert %02x-%02x addr %#lx\n",
+		 start, end, (unsigned long)addr);
 	if (!(pci_probe & PCI_PROBE_MMCONF) || pci_mmcfg_arch_init_failed)
 		return -ENODEV;
=20
@@ -788,6 +836,7 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8=
 start, u8 end,
=20
 	mutex_unlock(&pci_mmcfg_lock);
=20
+	dev_info(dev, "pci_mmconfig_insert returns %d\n", rc);
 	return rc;
 }
=20
