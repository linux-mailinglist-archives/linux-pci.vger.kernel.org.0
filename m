Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989386737F4
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 13:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjASMJi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 07:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjASMJc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 07:09:32 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B99474E3;
        Thu, 19 Jan 2023 04:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674130171; x=1705666171;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XkuQZnkE6KE0U+xLe8Jrde7T21dOfTyXM2rkCPoyPxY=;
  b=NhIN19+GszLYFe2ThjJ8rKJeGgkM1GC7yuJQOy2ByTr7FzqqMvnD+4pq
   CLxWCDK+4dlOpha121XST3u6YUwqTgkcZ3pLsMU0P1X96VZ1zN2ab5WVy
   915i6KlxARyxMVSMXb3UkRM9NrsWQF45mEq/1ZB1K5zE7FjoHdNe/yPNB
   XqiEwoDBCyL/5W1cvEGVITRn8xEKairhfgSvJyNwlRVp2hRf1C6O87zBz
   t6QY42ZMk4dmfdz9b7fq69CI03PZ0LFvhweU44BWmlDvOIuQKpqdoqbDb
   2iV8/8TrB9dJ5Vf/3LSls4NKrbeVNnD3yuneBMSTKRQj4r7qwxw7fOQfQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="323956198"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="323956198"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 04:09:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="723471520"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="723471520"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jan 2023 04:09:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 04:09:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 04:09:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 04:09:30 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 19 Jan 2023 04:09:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VE1/Zs7bfK4G+G4XmtgKvyyWW5+VOiRHNTFjK3l/1WZuvaA8gdgmDzYEIr7ShZesBieqb7TGMBTnVr0PBlj99uODPGSuZxfUU1fsjZSb0K5MRMsfRP6ZBZ0OGfJs8y7WecneouRewVr1A37wyk/bNy+ve7nNi2zYbRm1qkOOnznAgoF640zZf0ishqoOXXKvMZGr0/3G5TDPsc6K7roXOaWvk4jT94d6OPIsEu5AqJlfU/f8WuXljyjwcqfXOSL2SYlzic5qvI9cIlcWaAAxx/4B5N3q3+H1W+8YFf4R7ORkQqZ1MykDGrzF429VMHL0J2u9Y3G5LYtAhiMObLMaew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IryLwD2F3irmGhDeEKk9JU8L6Bov8PgEt+IXRi/dhb8=;
 b=gnY0DmeBpf+4SebwEiK0KhgkROc9Pk9F/5oVbC9LPQSIP2UEm9rZMPRSXZo0hfQDD965SmQJrO7KXdcRw/mr8X3wfHvgEPQXGY8o1Xhi2UEBXaHmrxHF1E9SWtyXcUsa82o5Njm8dCHkLxa9TP651QDLkDJZFRQ4c6efqHr9ulTv1/Dvvrbpha87FREQNOFazPIS3P6w9X0oBtVSDKYfJ6X3fb5RluJY8dYPOTDd0vE1aY32ErtQ5a50qjdCehS2JAhyaD3F1AEK0ZW5aPGd+cpH46LomVYGYqvMD/FSoR998R9ioJEbc0cruSe/Zx4LisG4siRPIIOEq0olnV1sSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by DS0PR11MB7632.namprd11.prod.outlook.com (2603:10b6:8:14f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 19 Jan
 2023 12:09:25 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::ee18:f0d6:8983:5a24]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::ee18:f0d6:8983:5a24%3]) with mapi id 15.20.6002.026; Thu, 19 Jan 2023
 12:09:25 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
CC:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "kabel@kernel.org" <kabel@kernel.org>,
        "mani@kernel.org" <mani@kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>, "Wu, Hao" <hao.wu@intel.com>,
        "Xu, Yilun" <yilun.xu@intel.com>, "Rix, Tom" <trix@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "Weiny, Ira" <ira.weiny@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "lee@kernel.org" <lee@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v1 00/12] add FPGA hotplug manager driver
Thread-Topic: [PATCH v1 00/12] add FPGA hotplug manager driver
Thread-Index: AQHZK6VLCdlhIKUsp0qb4AVuDG8fX66lYngAgAAAWxCAADf0AIAABOfA
Date:   Thu, 19 Jan 2023 12:09:24 +0000
Message-ID: <BN9PR11MB54838DF14D9CC7F1F6E2D4A3E3C49@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20230119013602.607466-1-tianfei.zhang@intel.com>
 <20230119080606.tnjqwkseial7vpyq@pali>
 <BN9PR11MB54839E8851853A4251451719E3C49@BN9PR11MB5483.namprd11.prod.outlook.com>
 <Y8kpKm51YryPz9F5@smile.fi.intel.com>
In-Reply-To: <Y8kpKm51YryPz9F5@smile.fi.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5483:EE_|DS0PR11MB7632:EE_
x-ms-office365-filtering-correlation-id: 21220889-e570-4636-66c3-08dafa16014d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tjmAlka2c0t+YWUOIFnyqW/QVn4jYGESmbC+dj1YTH7bit4bfDZksT+UEDqVneREMFSFw2CMucMlhtF11KUdnig0RvgAlMF1Z4Jk1eDVZKxxTwcgwDrQix049lpV7ioeZfwHEQEmA8YnjzcjyrIgANS1U13XZhqfrWK1s/GC5ZQc6w9UsBm7B8VHtSwAIZ9NxSux2zJJHIBEwL37g3/b2Wd0Cm0sf/w4wQ9xJM+50zR/k8JHqz4ZYfL1ng4nPWpI+uSi6CjkEpL7zd5nHeEijDtL5oxsf+1s9Ph8Iho0Lo21dbqGDYWl5VkGYNAG6DywNievqYKyXUJQrn17wUdD/XKUsMEzL0h66sOsgd2bHBy98Zut6bDElBwBUaH/ZEPG8uFsYIzvIOlIs/oMHw/eXmfVkXZr9mngZVas4+KYvAUYH34H5OuO77mMjS9HTbif8fcV7fpGtV+XbE9d8rts4TQJpkavj+tOyLa6eVe09oCRD1ovYcKl/FSTLS9xS8s1lqwVo4lhsYPhmgCJav3qMdqousZuceSiVY30RlNCChuk+nhsh8DaKcJPdpEjXpXh9ApXVOShnz77p60G6GLkaJQSOrATMlZnjqsK9/NRNOkL+NClvwXzCis6NMmIaAfr/twc5QwXiVZ+hEjx4HWBFQI1IvfoV8c47oDtzHc8i2A/Ac/cDCGn0j2+gnoxbOguanrq+CJ8Drfa7i8FEoidEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199015)(86362001)(33656002)(71200400001)(55016003)(478600001)(186003)(7696005)(54906003)(9686003)(6506007)(66556008)(66476007)(2906002)(38070700005)(53546011)(4326008)(8936002)(316002)(7416002)(5660300002)(8676002)(6916009)(66446008)(76116006)(64756008)(41300700001)(38100700002)(122000001)(66946007)(82960400001)(66574015)(52536014)(83380400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?psn1nOx5L+nrOtpes4hTRGMnuxD6o6gAl0XF4pESvSqg2y9SD9I0V3McDf?=
 =?iso-8859-1?Q?OTCAH+S7NP9lSiZZHgCjggijIFdecflLj0H5KZMmFMNoe6k/kvDowhdYh1?=
 =?iso-8859-1?Q?hKZUq0EUw/yUBDkY9PkGy/OUG9jv8bJRBtEvYEw6Bk6bKDqQqUpfwvtW+d?=
 =?iso-8859-1?Q?JYIbcFf18lNMzc9wpC5FhxZuuY5tpt/VDFR0Pgw1Nz4kJF8+kpBySbTlEH?=
 =?iso-8859-1?Q?KQHTQARVFPMBV81IyAEd/44wpmIk57Bz0sEQV/RsmYTeCGWeJbyh+vmG8+?=
 =?iso-8859-1?Q?pfg/zTmvSnaDHS9c+1fc1VCcKjYXbhjWOyt1U/EAQU9jSnle7b2ZHpcxct?=
 =?iso-8859-1?Q?LQhhH6k1CdLNmhY0L/yG+BP0v7zA+vlz1E3QPSqsK/klQ7lEKxP1d5NKie?=
 =?iso-8859-1?Q?yDsVLdMxwNXZ/nJaIQ5rM6TM/gaIt8ipOmKH4FU00nyHxFyW83eagdxlWx?=
 =?iso-8859-1?Q?k2apoNtnblRcLtUHd3uHm/GobVXEgNyX9um31SGeyHkIm5pp9jKpvnd1nH?=
 =?iso-8859-1?Q?2ZJrmbI0yn7FNYT1VpE4UYDhxNZq5WQQfthd1Jq/iyYahGEEGdYe76hUwS?=
 =?iso-8859-1?Q?1Kr1kViQq62ECfGzuI9vmog52FZjdettiYPxuXnoF6uHlC3AfV0rUKos9p?=
 =?iso-8859-1?Q?MR310YYhI/q8fu45nlf6B/TDruUvwQ5J2d5GUv7eY3YXNTEOSPI6kcjrF1?=
 =?iso-8859-1?Q?k6dA5tRr9Gbjjb8QautBP/JeTMoWGYp+s0H3JGoyU2t8xYFoIIDJf1xpw9?=
 =?iso-8859-1?Q?7mmy7W8diLikS4/Gf2VHFnolpduxkycFuhWjUUXQMaOCF5VzMnqgq60vGl?=
 =?iso-8859-1?Q?ruczQGyS5hr5L9Ve/Bi5jE0/mLmEB7b1ue2+K5R6wj5kypizsgRlxYN4WR?=
 =?iso-8859-1?Q?1SfucMsueRNb6aogBYoLajuZ9obgwiuLDkDK7hvkKaZrYMEoVEDQadNqAh?=
 =?iso-8859-1?Q?psD1DSpGdINhtMDUIdlUuy6s98YP1BCbQsUJzaHGfBzsdPzk2YvB7K7tRA?=
 =?iso-8859-1?Q?an3paCfcqTzRyCPp1xUEwsP0wtAkE9xLDmRluPgfDRuWgAuH3LAtWGw5Jz?=
 =?iso-8859-1?Q?NiN9zr5Ng7NbkL0zukjn8JE0IIYIrbdIK6R4CrMixBgQnZQ7xiOtyAMcjq?=
 =?iso-8859-1?Q?VWWuvD4bf6/NUrLJRMPeFe8mmWh9bBU2OfnFpwXVVPiozUv9s3/+Dhwdjb?=
 =?iso-8859-1?Q?xpzTiEuRN61udkapdDuv3J/g32i9W7twzOYlxT9lZJwONia8ks7/wgo9Rb?=
 =?iso-8859-1?Q?88LNp8tuAsm6CUgRNdlyLKFfHOj869vIUvjGmjastRF0iX6hExgHxcI+3s?=
 =?iso-8859-1?Q?aC1J7NlI4wi4X3noWycmTBNLJZpfCcJbX4n1Rt2fGmxFj7rX01vTdx4U1K?=
 =?iso-8859-1?Q?hpBc24T4LjXTh2/vpAnesXPPaj9O4WeD7U5lLflfvcDYVeoq0hpKijm4HC?=
 =?iso-8859-1?Q?vNS/gNyYL7W1TMzDb85PYrPtUCgRInEbRI7oGT4PkMc5frtfU9NBC/EBQk?=
 =?iso-8859-1?Q?lBqIlthX27wMJZ0kik7o6NvtjPm9izI34/XfBi0TlilBeXXfuqWlpKJfoj?=
 =?iso-8859-1?Q?jwZrGM3NsRbi5z2AAJoLRzUfNhxVZr1S/9C/Y8wcsO+gKZkT51du9Z1LkU?=
 =?iso-8859-1?Q?PxvBULG39FJ5zgJcEYc2+GOYsbrQXv8dDU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21220889-e570-4636-66c3-08dafa16014d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 12:09:24.4264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wejRrZpo0xkR4ONctNIRuurzW2WFkv1k23Bap64rFdzxI7lqolPtozq0B/vIdFjx33PAJsGqpHS3u9TyyDMfUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7632
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: andriy.shevchenko@linux.intel.com <andriy.shevchenko@linux.intel.co=
m>
> Sent: Thursday, January 19, 2023 7:28 PM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>
> Cc: Pali Roh=E1r <pali@kernel.org>; bhelgaas@google.com; linux-
> pci@vger.kernel.org; linux-fpga@vger.kernel.org; lukas@wunner.de;
> kabel@kernel.org; mani@kernel.org; mdf@kernel.org; Wu, Hao
> <hao.wu@intel.com>; Xu, Yilun <yilun.xu@intel.com>; Rix, Tom <trix@redhat=
.com>;
> jgg@ziepe.ca; Weiny, Ira <ira.weiny@intel.com>; Williams, Dan J
> <dan.j.williams@intel.com>; keescook@chromium.org; rafael@kernel.org; Wei=
ght,
> Russell H <russell.h.weight@intel.com>; corbet@lwn.net; linux-
> doc@vger.kernel.org; ilpo.jarvinen@linux.intel.com; lee@kernel.org;
> gregkh@linuxfoundation.org; matthew.gerlach@linux.intel.com
> Subject: Re: [PATCH v1 00/12] add FPGA hotplug manager driver
>=20
> On Thu, Jan 19, 2023 at 08:17:05AM +0000, Zhang, Tianfei wrote:
> > > From: Pali Roh=E1r <pali@kernel.org>
> > > Sent: Thursday, January 19, 2023 4:06 PM On Wednesday 18 January
> > > 2023 20:35:50 Tianfei Zhang wrote:
>=20
> ...
>=20
> > > > To change the FPGA image, the kernel burns a new image into the
> > > > flash on the card, and then triggers the card BMC to load the new i=
mage into
> FPGA.
> > > > A new FPGA hotplug manager driver is introduced that leverages the
> > > > PCIe hotplug framework to trigger and manage the update of the
> > > > FPGA image, including the disappearance and reappearance of the car=
d on the
> PCIe bus.
> > > > The fpgahp driver uses APIs from the pciehp driver.
> > >
> > > Just I'm thinking about one thing. PCIe cards can support PCIe
> > > hotplug mechanism (via standard PCIe capabilities). So what would
> > > happen when FPGA based PCIe card is also hotplug-able? Will be there
> > > two PCI hotplug drivers/devices (one fpgahp and one pciehp)? Or just =
one and
> which?
> >
> > For our Intel PAC N3000 and N6000 FPGA card, there are not support
> > PCIe hotplug capability from hardware side now, but from software
> > perspective, the process of FPGA image load is very similar with PCIe
> > hotplug, like removing all of devices under PCIe bridge, re-scan the
> > PCIe device under the bridge, so we are looking for the PCIe hotplug
> > framework and APIs from pciehp driver to manager this process, and redu=
ce some
> duplicate code.
>=20
> Exactly, from the OS perspective they both should be equivalent.

Additionally, for FPGA usage, it doesn't need physical hot-add and hot-remo=
val of the card for FPGA card managements=20
like load a new FPGA image in FPGA deployment of data center or cloud.  So =
whatever the card support
PCIe hotplug capability or not, it can be done by  leveraging the PCI hotpl=
ug framework and APIs from pciehp driver.
I think it also has benefits for other vendor's FPGA Card to do some card m=
anagements by using  fpgahp driver.

