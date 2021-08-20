Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C90E3F2E31
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 16:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240861AbhHTOhH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 10:37:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:59713 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240895AbhHTOhG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 10:37:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="216781007"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="216781007"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 07:36:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="452797041"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga007.fm.intel.com with ESMTP; 20 Aug 2021 07:36:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 20 Aug 2021 07:36:27 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 20 Aug 2021 07:36:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 20 Aug 2021 07:36:27 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 20 Aug 2021 07:36:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRxrFDwqZxWyNEGv5PkKR5cibKwEolfcukbeTXFrVJ3aMCwNqiv2Inx/50AUDrZJ5Ym9fBuFzEgZKsVpaUXivayskMA4YJnuLFMZDhN9MdiBSrs8RGJoQsSqop6ME8Dp3eWdkCRi1rMInLyrp7ZzbU18U1ZSK/TppA9kMsU1F58FV44I6JXwtOUz5tuFJ+YIzUigPL+u4xLgKiGa8IvZIlc4am0UPbTXxRf1LQLMWplEWvdaSXqcoU9KIyTO56gw7MvAVER6mHaArc7AEDvibK2Tr/fbVYgLydfjxqRicU8nqQHus2RrSkZbJdWIn72gdrxxr8BhreekXg4jVtQchw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goKjo9W3/SMM0xfEWbt/pWaWUWCS/X13vYtJZzv2IVk=;
 b=OTUEBjGw38f4ueg7e8K7r/Ahk7N26B3SLGlzfSCsBNYphnXEiC3Q4ejr7bhw8VEPsV0qi4Fo/sutjC7sW94cjNFZDjwgd5iY1e5IAFxG6/5entHtrE2VlbkWZ9JE5Q25EG91pHFYQd5xJ/XOapRLGe3+l4O2a0CfucoA6TXvfrgwoHFr9QPdImMhZ8E5ik7q4SNFRGsCNUXdEmFYHLkoInGs5x2z6F3FEVNEHGIRRzzMGh/BEQe2S+QBg+/WwqGedh2kBvEMjm5i7dfIF9enskZZKuuXYN+MX+wGjgawiHkKfjEV6rzxT+1lMMA8pX0bvm96fexynCbv+saIUcAIRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goKjo9W3/SMM0xfEWbt/pWaWUWCS/X13vYtJZzv2IVk=;
 b=YWMfZSrd4KuMUotJ0pZ2cLeN4riqvZwZSp+6bYHE3eSnS0QALcFb5ru1tvPyq68EGJdiqB7WFqF8NtWVnVbKjuU7DKSwmiJ3h3DkC4Ck0dBMtRbnAIRwTcfc/YV+lNQ+IqXVGiRiWQIQLM6NC5ZiaeeEFISqRTZOd0O/0bXv3ok=
Received: from PH0PR11MB5595.namprd11.prod.outlook.com (2603:10b6:510:e5::16)
 by PH0PR11MB5626.namprd11.prod.outlook.com (2603:10b6:510:ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 14:36:25 +0000
Received: from PH0PR11MB5595.namprd11.prod.outlook.com
 ([fe80::892f:de9c:2fce:ddf3]) by PH0PR11MB5595.namprd11.prod.outlook.com
 ([fe80::892f:de9c:2fce:ddf3%8]) with mapi id 15.20.4436.021; Fri, 20 Aug 2021
 14:36:25 +0000
From:   "Thokala, Srikanth" <srikanth.thokala@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "kw@linux.com" <kw@linux.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "maz@kernel.org" <maz@kernel.org>
Subject: RE: [PATCH v11 0/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Topic: [PATCH v11 0/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Index: AQHXifwL/F/NUr2vzEOZ3/rNqsn+36t8bziAgAAdVNA=
Date:   Fri, 20 Aug 2021 14:36:25 +0000
Message-ID: <PH0PR11MB5595F2EB088FEA43E21484FC85C19@PH0PR11MB5595.namprd11.prod.outlook.com>
References: <20210805211010.29484-1-srikanth.thokala@intel.com>
 <162946366363.6132.9269397652737555918.b4-ty@arm.com>
In-Reply-To: <162946366363.6132.9269397652737555918.b4-ty@arm.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 302f2707-1139-4c7a-5c9a-08d963e7e3ab
x-ms-traffictypediagnostic: PH0PR11MB5626:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB56265D167D5064A5E461BC3685C19@PH0PR11MB5626.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yzakkgr5TyyhXwnJ0PsjgVzneLxt58iP0wg/5L26jg+5cp9wIJiJeOi9GAXY9fqNS4Rw3Uk5GkgdLTO4qIM6bAHRIs2YKn3UoB+6v1i6BitR/AYAg41KyCx/g68tkAGW/m6AyXjZzwMfbmyCgm5QJAKvIJfbZ8N0CpW6Od0k+etRgZyBhtq7wy7tT1U3yA6a3cioYEkEiZbEfxyAtnoI3dimvZVCqOYN4m4AQ6Jp5tWnCzHd/EKdymWYCP5W0edgJ234aI1YOohjYIIH7mnA3XmL7uO1/RoS4vllO36KhAwQmr97rqHluik6hnkEvXJzxhyuzi1HqTzbfndmrXqXkk1ZyaKc6NDb6YoI2fVA9BnL5V9P9xkzAl/0BahNKw+QV9iNXSHlLJjFss6FzIdmabh1GW3cvZU4Fz0opPqVcj9DkBVH/nJ+26yZ29sKtzFc7zA+GmN1XNryrDZQohaej1ND/BSRX/Iaaol90hlqAGxTedJWGHkaxIp8wjhlHQ15fagcRz0wX25iEQWcvWbDov8lZCtLQ2ynsFok102Oa9HoW9Br9PgK6FdZhCcKOQAXLWMEfh5RSqi7pVafXMNGbuzaU2IJTPKbNpILUbSuNklUplDNFJZH9SB3E9jN6N0ohFDhJsHPmIgdLJ2vAWKWE9ZSMancX1IzQLaPmMtf8wmSHU6DoyZmo8kEi1pWRT0mtJnLUvbe000VUFPxkZL4sT/GNAJf+YA0qASZrd5F3KqgYduQvDuhkN9LOqmNlXOjDTJuJlKl/c63/PwS7jAt5t2QTtVvzTXNRdDwhxmDukQhiqSGKDzmaOkeuK/PouZg5yg+qPl5B/zAOhTBiSf7NA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5595.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(53546011)(7696005)(38070700005)(33656002)(66476007)(186003)(55016002)(9686003)(6506007)(66946007)(8936002)(54906003)(83380400001)(86362001)(76116006)(966005)(38100700002)(122000001)(52536014)(110136005)(478600001)(71200400001)(316002)(26005)(64756008)(4326008)(66556008)(66446008)(2906002)(5660300002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xddIKmk5Rsn49avrQDYzK6JnDJsX7+ZfBucy29rajigUMv0VTb5GBQICPzug?=
 =?us-ascii?Q?u9CZ9SL97bAbh/yJ27tNQdamX7+vGwLnNnvHWa0tH5rE1LJSrNjz7WAV9bzu?=
 =?us-ascii?Q?EuIt7P3OOLG/LnZIkyKn9dGYFnI2LyhlQVqYqL+q6C5ZzLti2ZYBXVgzs5xm?=
 =?us-ascii?Q?zUtmpZmcScJaMFM7WWS4o6Ur74qeQh/mvSV/6eBaMcO30XB9cjlyarVcsrcI?=
 =?us-ascii?Q?9BIqoDRuh19N2YMMjEDOq+eG32T/gL46zpM9UTtE8k634qCglIPSZvvqLA4j?=
 =?us-ascii?Q?jKn2wqBisdYZyr2qsGS69stKWBZS5iWJYRwUKuBzJEOtfevaOyLkn7jBcW0F?=
 =?us-ascii?Q?Pbszb7ceAVp0e/wFt0s2u+zp7bljmPWSMyP7smW8KMElmMbSkhifxuB8ufqJ?=
 =?us-ascii?Q?l9jRl8dYtrEb6uOeIGU72L1Kj3lLZnFP98nEJKCjtml6KoffG2dqZvQ8t2HL?=
 =?us-ascii?Q?JhXijJhRAsQ3OD9Ar/VThP392Yu5I1ZxGAMe7L9SqJlgNuaC0oCt7OeJTryu?=
 =?us-ascii?Q?p17vUAbYuXdM9UXxVXFt98QAjC0nPaeJ7BUXnbwyi7XpcHytehgidsrB0mm7?=
 =?us-ascii?Q?3z2WZYbTGGV38lLgswOhuBLASXGx+jniN5MC+/ny8rRXw+bLg/AcYaOMZiPs?=
 =?us-ascii?Q?wDrPgU0BxIzPMNwTsD77C4KLZF3YvkPRf2Z6a8WN0JW30ujdMnUBR/Cnb4jy?=
 =?us-ascii?Q?ssUeg/iXcrj3HeaoKXitW9qydjI7Trz/fEfuTirGpxqOJEigf1+SSILlAH0b?=
 =?us-ascii?Q?jIT/fSx5C6BItrqShMGQzcggBuVRI2iQ5pL1AWg8nt6lv8FDjIkQsFtYbhBV?=
 =?us-ascii?Q?PzA5k2YWc61GG+o66zh8Tm09VsiGSkqlXjUZel/o2i20kj/kHrrgnc2n+LeP?=
 =?us-ascii?Q?JrnWBrG0FqtUb0JqrhzBNvAfo79xeQXE2bkqBSzds8muIDBOXEpp1TogiS4v?=
 =?us-ascii?Q?er3cmRcbHH/x9wHOtmQMSTIA77wLTZXbNH5SjRAgAHHO2XhnRUCh60qbAocK?=
 =?us-ascii?Q?3AgOtXQByBcPmAbwV7PVQ2bR4Es6yjaqR/pUVoDO52sc0NphHvizpmn3dnCI?=
 =?us-ascii?Q?Rm/5M1tB5+/ei8U4AdtVNU/PhLBiERPxwBHpAcb7aGnSdNMgbQJqiMuV1m0b?=
 =?us-ascii?Q?f4VUbJ2pToLi7Feu5YZsOSfOgYf2dNfMIigH1+D5SDlNc7JxTp4UH1Xp84rs?=
 =?us-ascii?Q?ihxa/uxYuWgbqMsmtwEMAq5TDzNRJ/ezFGY4gA9QSjsGy4RrCKuVpDPuV0iG?=
 =?us-ascii?Q?X93EgsmyIzbN8/NvUE2Ud7RgD/rSEP+reaUUFoj7m3BqebQOVIAT79PTMHb4?=
 =?us-ascii?Q?rkwmnQhvl0K2wCAWY3+DAKP9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5595.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302f2707-1139-4c7a-5c9a-08d963e7e3ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 14:36:25.6356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N+ZPnkdrPGOE0vcJkfXTnj/AQz42ezR937fbPV6sFQQYA0n9BAKeqZR/i1/Bi07sQH8QDquPXhtY2JZ/RGhInc6PI7cLVKTwetGQC+K2iK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5626
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Friday, August 20, 2021 6:18 PM
> To: Thokala, Srikanth <srikanth.thokala@intel.com>; robh+dt@kernel.org
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>;
> mgross@linux.intel.com; linux-pci@vger.kernel.org; Sangannavar,
> Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>; Raja
> Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>;
> kw@linux.com; devicetree@vger.kernel.org;
> andriy.shevchenko@linux.intel.com; maz@kernel.org
> Subject: Re: [PATCH v11 0/2] PCI: keembay: Add support for Intel Keem
> Bay
>=20
> On Fri, 6 Aug 2021 02:40:08 +0530, srikanth.thokala@intel.com wrote:
> > The first patch is to document DT bindings for Keem Bay PCIe
> controller
> > for both Root Complex and Endpoint modes.
> >
> > The second patch is the driver file, a glue driver. Keem Bay PCIe
> > controller is based on DesignWare PCIe IP.
> >
> > The patch was tested with Keem Bay evaluation module board, with B0
> > stepping.
> >
> > [...]
>=20
> Applied to pci/keembay, thanks!

Thank you Lorenzo.

Srikanth

>=20
> [1/2] dt-bindings: PCI: Add Intel Keem Bay PCIe controller
>       https://git.kernel.org/lpieralisi/pci/c/33d2f8e4ff
> [2/2] PCI: keembay: Add support for Intel Keem Bay
>       https://git.kernel.org/lpieralisi/pci/c/0c87f90b4c
>=20
> Thanks,
> Lorenzo
