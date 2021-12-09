Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C35346E26E
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 07:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhLIGaS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 01:30:18 -0500
Received: from mga02.intel.com ([134.134.136.20]:50388 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232960AbhLIGaQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Dec 2021 01:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639031203; x=1670567203;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3CbC6kR+mPuTqGzo2hNaUUNvT4porqlcwwmBHZkHrqM=;
  b=k7QQ1FP1E6/5vCJd/a2mGVOHJgt4LeGg2OBPTc1MmFjjFVXBEstlAjNl
   ELF7e7S6jWCvU1qOh7Re0Z1fHjfZNuARA94j+YRiuPMqkNv8UlzNI0yS+
   EXPgCcRuUFNtrAMD0VA7rJH7pcepfQjJukemo0lF21epkItdGqRawJJj3
   dwHNu9lkZ8x15p9qsi777Sklh/79w92PvyAAy7XaJltAPf63C6xp/PQZA
   43JMkPSRrqAGj1unLw5k9psOgDRngHIDNARkritBhXJxcdabmt6Iuwzdj
   AvZHj22ziyxf771ch0cepY1ZlR4YPRrfKg1cX0VMBKIPQd+FIbkXbHytQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="225289796"
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; 
   d="scan'208";a="225289796"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 22:26:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; 
   d="scan'208";a="606738481"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga002.fm.intel.com with ESMTP; 08 Dec 2021 22:26:41 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 22:26:41 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 22:26:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 8 Dec 2021 22:26:40 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 8 Dec 2021 22:26:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJYufEHEWfFnrOZjaXH6Srgv9KYJUuH5PJV8QMOKYoZLyYs4ZeMdS0Ep8QhLOeM5xZRQ8hYe/f2ehlGxPN5GaMLCBICjuQ4tC9ci3I1wbyJ3CX1VDc2ChWHM3znjplKIG0GHx5YYh3hC5ys6seoFJyscid5VZJpfTeZPf0FeuMWrKsc2bv22gv96aVH5Zoi4wa0deBSjJ4E7C+sppjYvKsQN520dNFKFRjb/N3KnuxoUi4cVznpjuLqdImpu9Dz92899KEx9VTuPHNU7LGDuO7GxlYtJWQhD1+jxkCef4LFhnVGn1xX7wJitZ0jreY6K/wVMlGtqXYi+sL69q0t1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CbC6kR+mPuTqGzo2hNaUUNvT4porqlcwwmBHZkHrqM=;
 b=GWSBvLASsSD5D3F4c1S9tfT42b150OGtjYEhGN7iBv1W07QeZNC11Wde2zMNw3CmazVwSbQn7sz4P3ry7IvHa9FGF1JK785HIpCUOOFam+vnVapCA8g3DjcjmHohhY0smh4Sg88gkzG6wRA+iGeEfk6Yzs4+htvjqIkzHxebBSJH7QCW9pVW8Bs89P0FU1xGsVsd+mdqQgzwz6KVCtIwEF0jMGzbUpq1Qeoi5tnLpgnahk/6EPWmtut1FqDLydSZ9NhYtklMvOA5QvrY8zS3bk5kFWc6MbR8bRR2wBlZ6RtHjT4Ic8K5gA8rLCTM6Xp2FbRkoqzup8PFs8B3cMnnTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CbC6kR+mPuTqGzo2hNaUUNvT4porqlcwwmBHZkHrqM=;
 b=mv17MgIpQyfzzClvamvaVCqQsUkC4hOQcSmzeOPcTEBcD8qirx9XmSEmJnSKBx0V2pU57wpiASBV17o8rYtqtcfygWHvAnn56dvgh9r+CMVDXRnMPmLGUyqX/+5U5iudUmC081rrPK9UuZLK6eIgNKfLSMsg9vp1ARBKGw16+5o=
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB4177.namprd11.prod.outlook.com (2603:10b6:405:83::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Thu, 9 Dec
 2021 06:26:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4755.016; Thu, 9 Dec 2021
 06:26:39 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Marc Zygnier" <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Thread-Topic: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Thread-Index: AQHX4y1VNaiO68omHEet2J9DWrVARKwa1YEAgAAp0QCAABreAIAAIi2AgAE8MoCAAAd1gIAACyoAgAAPcQCAADDDAIAAp1uAgAAttoCAAEzjgIAACsMAgAAjl4CAAD2IAIAA6NQAgABcawCAAAmigIAAKimAgAAjYoCAAPMeAIAAGgMAgAis5HA=
Date:   Thu, 9 Dec 2021 06:26:38 +0000
Message-ID: <BN9PR11MB52766CC46D3D4865308F61D98C709@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <87y2548byw.ffs@tglx> <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx> <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com> <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com> <87o85y63m8.ffs@tglx>
 <20211203003749.GT4670@nvidia.com> <877dcl681d.ffs@tglx>
 <20211203164104.GX4670@nvidia.com>
In-Reply-To: <20211203164104.GX4670@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e03f4057-bb0e-4ce1-73c3-08d9badcdbbb
x-ms-traffictypediagnostic: BN6PR11MB4177:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB41774DD97D83301AE6A54C6D8C709@BN6PR11MB4177.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dRU46MrjMSZE/C29hoUpnfsLx0qt/ccfuQRimZv8w4r5cFir6w39S8BzPYeQBUh2OB18iRkxljNCm5PrvW6smiCLDdnF/3QGrA1sW+Dz8LcwiIq7OFgQiCF65NBXS+EPUE4rlIOTAJZyeSrZ40P7jkGD4od+ociWbhZVlz8z7WoiYMt83eCegQz9ZOTdR5alPKxktn6up1AYfxH/8VTIFNbKYrWOUmGtGMWq04L9X/SunQFsRu+xCz2Mq9E8zeypP3UplZdHVA4hecp4pKchRg9XzCQ8AZbc7ArHQDVTa5OiXZJH4D7bjMI4eVbPCtbWi4nirwzuG2x1Pbq4p1pxlDUshnEUtu494KwoDbh0hDt6FzWwCk2QPJNvM4cnkJ059wWw2gTfGe1uwXHQDdzjXW/azOkeHEUuS0IkMkGtMomOjykSAsda8aGRERC4UkQBRtmSCDQRH9PBIfXsLWlxnqrnnnw9UEFsIuWNzEEePEUNSA0JmijyPT3YGPLUSShKPhzQhE/RrxkAnoOMZ7fQEz7H8KSMe5/ZhM8crr0fpzz9qQzlQkYafi5Rt/01y3GK1r78cXI2nes3LBYE3/zlodm8xo8c2EEN3JATVhV6Q/Z+Z39JIr8/LmdwDqD11DNVZ9dOKofgCRHYty8IQd5DsVzqXpXHszkQSsgfKeb456FS633XUyj2QzsnlkCkEhjXgGQsHeD4laBwPuHuKHjirQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(52536014)(6506007)(66446008)(64756008)(316002)(82960400001)(83380400001)(55016003)(508600001)(186003)(71200400001)(110136005)(33656002)(38070700005)(76116006)(66556008)(7416002)(54906003)(122000001)(8676002)(66946007)(2906002)(38100700002)(7696005)(8936002)(66476007)(5660300002)(86362001)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N01pdGxhT0h0VjFrZEM1SS80d3Y4MDN6QjRKK2NRNFBDUmZDbEFMQmtoK2J2?=
 =?utf-8?B?RWlZRnpyOWVjQU05RmdON012MFBMcHQ1U2V4elpaY0JhS0JiRnpVY01kRWR2?=
 =?utf-8?B?SUFjcEhUOFdPM3lIdHpxd3ZtOVVyNWx2NGd2RVp1VFJEY0xhZERRaTltSWdz?=
 =?utf-8?B?cFRQelR6bjdZajBWYnJtSFJmYVh5SHVWeWtXUmxpR3hBTU85cUtsWmIxTFVC?=
 =?utf-8?B?aUM0R0NLcXBvcktaNlVPdGNhQVhYWEY0T1o4aUhIZXgybUNqN0psSnN5Z25q?=
 =?utf-8?B?N1YzQWNUencvZVgvKy93eE9XTkIvZjJCbi9WTTBwd1ZabDVwTkZpcnc5L0pl?=
 =?utf-8?B?SUl2c1BmcHlKUVQveFRKRDdKKzRwZVBRRk4rNUlRekkxZkw5R24vS0RrZnMy?=
 =?utf-8?B?Zkd0VkNnZ2ROaytzVnVwMG9VZlNaNDgrU0g3K0VweXNCQzlJZDA1NGg3T1Qv?=
 =?utf-8?B?eXVGenBNZEhmdTR0eXg0anhid2tGSlhBcFc1Qi81d2x0NmNtQkttcXBHc2ZH?=
 =?utf-8?B?SHFmVnBRYXI1MFFWcCtiQjhNdlcwZElZUlFTbG9LdUVZSER1bEdaTlFDLzV4?=
 =?utf-8?B?MU1xdGRTL3c3dG5FYmVlQkxybWUrVXFvdUI4UFRxdDlNQUlSbTVoUVZ1WGR2?=
 =?utf-8?B?SzhzQ0xNZmJpWVVjeU5JdzlVaGQ5WnhEdDhTWmVMZU40aS9OQTJlYTRqQjVZ?=
 =?utf-8?B?b2RTQ040T1BMMXhkMGlycnA5YmdkVmtxR01rc0ZjNGE3K0lKaEZCTkl2alhu?=
 =?utf-8?B?QUxVSklYdDVJcHVrbE5JaTQ1SGM2ZXl6U3oyTFZUNWIwbWppVHRyNXV6NTJW?=
 =?utf-8?B?QXJsWTdPTk5sN2xGdk1zWkszeGNLd2Y4NWZwMmxDT0g4RlpONEVkWVJjcTAz?=
 =?utf-8?B?RzNubGxlUmdJTThMdnc0Mjh1ak9sRE5LaHhnenJCa28zLzhiZWxxWFcrbUda?=
 =?utf-8?B?N2I2SGc4SzgzbUM2VFpqZk1JRS95cjRjRjdWMmlNbVZIcFhhOGJzQVYwZzND?=
 =?utf-8?B?cFM1Wk1NUU1ScndKdDJ1S0VjSjlhZXMreFpWa0xwcloxU2JQT1k4M1VTVVIy?=
 =?utf-8?B?c3BFWXAyVCtTbzd3dVNNN1FicXdyVkNuamFMYVJkOENUVHJhN21veThWMzNs?=
 =?utf-8?B?aXp5TDdTZXEvd1NEU3l4ZWlnL0grQTF5THFKOUJqWWJlMHdaelg5NnZMKzds?=
 =?utf-8?B?amdXTkhmb1NoZS9CK2E1SU41UFkwRW1CVjdmQ2hLZ1o0Z29xYjFEZ0tVa1Bp?=
 =?utf-8?B?eFZCUXBDbjVKN0lxWWlMSnAyRXc3V0dLUG1memk1bVduRGxlMjg4OTk5Tmph?=
 =?utf-8?B?bTFvZEdmRFNpRzNXNW5rVThGU0JmaTJ4ckVndk54R3FXc3Y0cWZNeldpSEFp?=
 =?utf-8?B?R0dZdGhNNENNK0lOMU9ZOHhhdEdMNzFGMHZXYVdVMHZiS2tPZGNFcmxQemdI?=
 =?utf-8?B?TUpHaVNyZktUaVVtMmdZOWM5bkZhbzFaT3ErUHFEMldlR29KcDdpMDl1eTFm?=
 =?utf-8?B?RjVZcTJQRjNtUllXMDV6ZEh1cHlRdjBmU0haQVBpdDM0UjlxTVN2b3NsakNV?=
 =?utf-8?B?L0V2MDh1MkM4U0l3ZzE4NHZpb2d2NEd6TGQrcHJPZ0wxaXI1QWJkekticHVw?=
 =?utf-8?B?OXY0RlMyeFZWRkxhZVNQS3I3NERZK1ZhcXNpbHpGbEQ1N1dCU1RBbUR6ckZ6?=
 =?utf-8?B?Y1FCU0dvQ1oxUXBSRHhJYTFjb1hHQ0lrdldVUU9Hem45bi9reCs5ZHY0MDJr?=
 =?utf-8?B?YjFmbjd1WUtjc3hvODJ2RStSNFJZL1k3VDZhQnNpcUozakZ4T2tMVHBpdDRu?=
 =?utf-8?B?aXRkK2R5eTlhMWIwbWlpcWVndGtiK3R4Rnl6TGVaS3N1SjFqcXVrR1N2emRH?=
 =?utf-8?B?YktvRUJ2cEhFd0lpZkVzTFU5NFpicTNkS1lva0xrZmEyMEhYVEU2MitQdHhJ?=
 =?utf-8?B?VWtXdUhJRXowWjJPTE1ZQWlYalNudm0xVDU4KzJvUnFEejFTN1QwVU8yQ0V5?=
 =?utf-8?B?VnJ5ZVhKT2xJb2UyNEJ0Qi9ROGRwTUVma2w3dDUyVGtmcjFwdHEwK0dMN0p6?=
 =?utf-8?B?aGlLcmlIVjRIRFdHc3d3ek1jQktNNVZoVXJnT3V6NHFTSmZxeXNSekUvTkFS?=
 =?utf-8?B?SnZCS2U0YmtvTGdzUHJHUWs2L210ZTQ1eVpOQmcvV1BudkIxT3V2SWZDcGRG?=
 =?utf-8?Q?38ddY4JQaz8eV7w4ZI7HB1s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e03f4057-bb0e-4ce1-73c3-08d9badcdbbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 06:26:39.0039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qermKvcryDL0XryjfM7mTmXFt77yVW7Pj9J8KLivsc+dNfVNpUocSEouUPCUmCBngMbtp9rNUi7t3zIUG8LjVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4177
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBTYXR1cmRh
eSwgRGVjZW1iZXIgNCwgMjAyMSAxMjo0MSBBTQ0KPiANCj4gPiBPciBoYXMgZWFjaCBxdWV1ZSBh
bmQgY29udHJvbGJsb2NrIGFuZCB3aGF0ZXZlciBhY2Nlc3MgdG8gYSBzaGFyZWQgbGFyZ2UNCj4g
PiBhcnJheSB3aGVyZSB0aGUgbWVzc2FnZXMgYXJlIHN0b3JlZCBhbmQgdGhlIGluZGljZXMgYXJl
IGhhbmRlZCBvdXQgdG8NCj4gPiB0aGUgcXVldWVzIGFuZCBjb250cm9sYmxvY2tzPw0KPiANCj4g
PiBJZiBlYWNoIG9mIHRoZW0gaGF2ZSB0aGVpciBvd24gc21hbGwgYXJyYXksIHRoZW4gcXVldWUg
cmVsYXRpdmUgaW5kZXhpbmcNCj4gPiBtYWtlcyBhIHRvbiBvZiBzZW5zZSwgbm8/DQo+IA0KPiBP
a2F5LCBJIHNlZS4NCj4gDQo+IEkgZG9uJ3Qga25vdyBvZiBhbnkgdXNlIGNhc2UgZm9yIG1vcmUg
dGhhbiBvbmUgaW50ZXJydXB0IG9uIGEgcXVldWUsDQo+IGFuZCBpZiBpdCBkaWQgY29tZSB1cCBJ
J2QgcHJvYmFibHkgYXBwcm9hY2ggaXQgYnkgbWFraW5nIHRoZSBxdWV1ZQ0KPiBoYW5kbGUgYWJv
dmUgYWxzbyBzcGVjaWZ5IHRoZSAncXVldWUgcmVsYXRpdmUgSFcgaW5kZXgnDQo+IA0KDQpXZSBo
YXZlIHN1Y2ggdXNlIGNhc2Ugd2l0aCBJRFhELg0KDQpCYXNpY2FsbHkgdGhlIElEWEQgcXVldWUg
YWxsb3dzIHNvZnR3YXJlIHRvIHB1dCBhbiBpbnRlcnJ1cHQgaGFuZGxlDQoodGhlIGluZGV4IG9m
IE1TSS1YIG9yIElNUyBlbnRyeSkgaW4gdGhlIHN1Ym1pdHRlZCBkZXNjcmlwdG9yLiBVcG9uDQpj
b21wbGV0aW9uIG9mIHRoZSBkZXNjcmlwdG9yIHRoZSBoYXJkd2FyZSBmaW5kcyB0aGUgc3BlY2lm
aWVkIGVudHJ5IA0KYW5kIHRoZW4gZ2VuZXJhdGUgaW50ZXJydXB0IHRvIG5vdGlmeSBzb2Z0d2Fy
ZS4NCg0KQ29uY2VwdHVhbGx5IGRlc2NyaXB0b3JzIHN1Ym1pdHRlZCB0byBhIHNhbWUgcXVldWUg
Y2FuIHVzZSBkaWZmZXJlbnQNCmhhbmRsZXMsIGltcGx5aW5nIG9uZSBxdWV1ZSBjYW4gYmUgYXNz
b2NpYXRlZCB0byBtdWx0aXBsZSBpbnRlcnJ1cHRzLg0KDQpPbmUgZXhhbXBsZSBpcyB0aGUgc2hh
cmVkIHdvcmsgcXVldWUgdXNhZ2Ugd2hpY2ggYWxsb3dzIG11bHRpcGxlIA0KY2xpZW50cyBkaXJl
Y3RseSBhbmQgc2ltdWx0YW5lb3VzbHkgc3VibWl0dGluZyBkZXNjcmlwdG9ycyB0byB0aGUgDQpz
YW1lIHF1ZXVlLCBieSB1c2luZyBFTlFDTUQocGFzaWQsIGRlc2NyaXB0b3IpIGluc3RydWN0aW9u
LiBJbiB0aGlzIA0KY2FzZSBlYWNoIGNsaWVudCBjYW4gYmUgYWxsb2NhdGVkIHdpdGggYW4gaW50
ZXJydXB0IGVudHJ5IChpbmNsdWRpbmcgdGhlDQppbmZvcm1hdGlvbiBhYm91dCB0aGUgY2xpZW50
J3MgcGFzaWQgZm9yIHBlcm1pc3Npb24gY2hlY2sgd2hlbiB0aGUNCkhXIGdlbmVyYXRlcyBjb21w
bGV0aW9uIGludGVycnVwdCkgYW5kIHRoZW4gdXNlIHRoaXMgZW50cnkgZm9yIA0KYWxsIGRlc2Ny
aXB0b3JzIHN1Ym1pdHRlZCBieSB0aGF0IGNsaWVudC4NCg0KSGF2ZW4ndCBjb21wbGV0ZWQgcmVh
ZGluZyBvZiB0aGlzIHRocmVhZCwgYnV0IHdvdWxkIGxpa2UgdG8gcG9pbnQgDQpvdXQgdGhpcyB1
c2FnZSBzbyBpdCBpcyBub3QgaWdub3JlZCBpbiB0aGUgZmluYWwgcmV3b3JrLiBJdCBiYXNpY2Fs
bHkNCm1lYW5zIG9uZSBxdWV1ZSBtaWdodCBiZSBhc3NvY2lhdGVkIHRvIG11bHRpcGxlIGludGVy
cnVwdCBlbnRyaWVzDQphbmQgbXVsdGlwbGUgcGFzaWRzLiDwn5iKDQoNClRoYW5rcw0KS2V2aW4N
Cg==
