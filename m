Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566E04712B4
	for <lists+linux-pci@lfdr.de>; Sat, 11 Dec 2021 09:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhLKIGm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Dec 2021 03:06:42 -0500
Received: from mga01.intel.com ([192.55.52.88]:49962 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhLKIGl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 11 Dec 2021 03:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639210001; x=1670746001;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MutaXoDyrnuDG9K3qm4nrCQ5Zpz/ufOIDif4a1FBlz4=;
  b=YoybmTRXR+nqEGl0kjDaRyT4RQCELjMvwMqYEe2muWwugXlao0ZUsFUw
   lZWF3kEgDewMJvHtxNr+ccJTPmrFUCIQV3+U1BWURSOdbJGx1Jn4LI8m2
   lqcJXcwu9yeTid4CSrHZTYSzHr7RHNJIew11+vGdYQpl8pU78dTg6X4nR
   oa7+bOe2kxpjIPevES3CZaOFX0QMYmxqOH7WtwVyuUF7KQ4GxJZrQn0VJ
   xFdi7BdU8HljuXoKGX4vTQ7TDLUZS5Hrylcddld4tz4jmWvJLuMgO57GO
   O9Z3R7pZpUptjistHmIeM5qKIsa96f4XouMkU5kvwFjOHPuag7D7VU+6M
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="262631290"
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="262631290"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 00:06:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="517080608"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 11 Dec 2021 00:06:39 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 00:06:39 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 00:06:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sat, 11 Dec 2021 00:06:38 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sat, 11 Dec 2021 00:06:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7mzjHQKuWhOl0yyKwFoKguL3QQ/xmHqSksGSXxFUWkjJudQ7TQ0R4FycKw7RrjTDiAjDHTznIrZh0o2W6cIIhcbPnphuIpTm3xFrBOWqWtGvxbNxJMOKky/a9/3qg6laqIEiuyYiJBB1SaworAn+g4LdWfYiOYYSRrKC+YWBzJ0b+96BowJfZ3P3ddBQBsd6Us2b4V039dWDt1OsFiU0nF6BdazOo/acgKg10lqfga7wXqvx8dsCe/XggyfIIl5yhH771QTkhAt0WkMr3q3NUPMy+9TmWlBwu3s/8zm674JlOsWMlKtahqef3TQO0DmmBBhxO4/z2DOqZlN4BA9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaQYUrgmkGontwUl3LTo0owEPnGKWHqfRW6shL03ms8=;
 b=ZG/keCEnKqWrdgGWJj2kmUetf5T5/dxmB3akq6B3XFBcK8jdXky8mV4nBryc5icqGIcRuspkLbH7vDtj7xAfWTnjRaP8pcmI/5IbM6tMDNh4fHqc9YmQQC8Ahg/QH0Uyxsc1CC6vEjqwkas4pUDyEJSgLh9PBENjw5v1Zt0zL3oDLRp1wbKbWtMyiNWvuDqy8mrrSjf1koSi1Y2zi7t4s/KsdsMoA+qXFwkdMDbB+Aygq0PUdgno36qE91Wv2RM6CJODQIjDf8/ST2XCW6Faqg4mBF8Fpa9eG2HRnBnnSnzaObkJ9xdZbGkZypNa+KkaBIXnlZ9bGaK+rGBpoiyO3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaQYUrgmkGontwUl3LTo0owEPnGKWHqfRW6shL03ms8=;
 b=IC+cqKfvqzkKO4iuHXn5nL+w4nsMsALYhKZAxKHaQL5jI1CDmuZKX02Ffu68x5Ey1406T302j0XUCMSVuXcR2HyI9RWPE2n3GGxeTlZiaR/HrQvjHQBo5KH5Gmxvu3865wYnOMBpaZcVzvxKQemqfbFFI0zu7d6bDKsX0LtsfSQ=
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN8PR11MB3572.namprd11.prod.outlook.com (2603:10b6:408:82::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Sat, 11 Dec
 2021 08:06:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4755.016; Sat, 11 Dec 2021
 08:06:36 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Thread-Topic: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Thread-Index: AQHX4y1VNaiO68omHEet2J9DWrVARKwa1YEAgAAp0QCAABreAIAAIi2AgAE8MoCAAAd1gIAACyoAgAAPcQCAADDDAIAAp1uAgABn9QCAACTxgIAAAdGAgAAbd4CAAA94gIAABpSAgAt9SoCAADlJAIAAgb+AgABGMACAAAc8gIAAE+oAgAAmHACAAFJ4oIAAcxMAgAFJwrA=
Date:   Sat, 11 Dec 2021 08:06:36 +0000
Message-ID: <BN9PR11MB5276AD88A1D1A1AA313E228C8C729@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com>
 <87pmqg88xq.ffs@tglx> <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com>
 <87k0go8432.ffs@tglx> <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
 <8735n1zaz3.ffs@tglx> <87sfv1xq3b.ffs@tglx>
 <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87lf0sy7xd.ffs@tglx>
In-Reply-To: <87lf0sy7xd.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b953aac0-9cde-4f96-d012-08d9bc7d276d
x-ms-traffictypediagnostic: BN8PR11MB3572:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN8PR11MB35726B5F88FB0364CC455F5B8C729@BN8PR11MB3572.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Sv0dth5+iq7R2NEox1Mpg8LUkrt+8Jo7aRRR60lJ5hOwuXt7WZ52uO/dvg9OS6cr8v+WtQ5h0Y4hvXV27+TPbdofYVL2danKva/11y+iwe9tb00osR4Qs/SOPQ+8mC9Nhm8L8lhW/7IU6OX8m128rMcN6C8VdGbb6gZh7lsIO9Wh5oXFh5Zhq9xaAP05qy0Dgkd5Q2bE+qrCPF/B7QnUwrttSngLrZHx2voi0OV3L/xFo30ynJhHXsfrB0nSEeI2Z/E8JXOgh8igshC+ZNuR38Iem/KqHzYBT/h21HUAaeGBtw//KV3n1ZM9/2y+cQ0toeKIpFAlHFCFaO4pIEKFVSKhljmUzRRlOSLPXDooLGwxi1G2zbfxaT56dmnZ9Rz1jPqpXB3Ip/6oc6hsWCohSvoBBFfFX2T6SBxsYg91XcwIaokeXP9XDrrMrFU9eE8pHLaSzSw6BMUP9zfznvk0ZP3M0HnrbAhyS+07NgINOUeBTUBTGal0q5yKDJE9hJ/hpkOpTqIS6NScQfnzhElNY6NFW37qClAinB1yfbzlSzBR/ULOJADbXQQJTjQEtu2qbhJWl6LlDGZQJzK5Y3/ovZBu1J58U+g8XycrSmjKjfSBoPCaLrtoEcaopfaU2WbXWGS0MMBfkGtBenmaTL1IcyA4UX3BLz+bSQzyI/emQ/gmldzvXIweDN0bR5Q4qApz2619yQGGZqYHDbCuWTjPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(71200400001)(9686003)(86362001)(52536014)(66556008)(66476007)(64756008)(66446008)(66946007)(76116006)(83380400001)(26005)(82960400001)(7696005)(6506007)(55016003)(38100700002)(508600001)(122000001)(54906003)(38070700005)(7416002)(110136005)(316002)(8676002)(33656002)(4326008)(2906002)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TsgFBzavXdHiXThggHYvSi/xt+Ng+1jTWFoJQx6uaqQKakuwGDQ567cacjau?=
 =?us-ascii?Q?texhdPW92aWD68jliOwTD3iZGtWsZEXVnSsT2i752vIvEmXn5NsRq9Mym+Mk?=
 =?us-ascii?Q?8ENLN0vKL8A+FO+kDS9ZHjygwWuycV1pYtrp+35XnnweJ7X9zKeLotC6fzM4?=
 =?us-ascii?Q?eXT4jP8DZXMRJ/ztYDsfQI014wFjfKxKbwSBbM7yY0l2SxMI1GkBy9W9Gvlw?=
 =?us-ascii?Q?SDGI6lIf+f3RVl5ar+Q0no+tQZIN7PQO3VfA12aphKmu22ysRWcdWCiXRDqF?=
 =?us-ascii?Q?p1FFp9EdyD8w39es+9fOW+rdl/CBLIb2uBjsSgY8ONVPvL3HrvACgHEJHFoe?=
 =?us-ascii?Q?9APDLpN0LYSR94MXwhFDUlt3lFG3eVmXDiQMNtuoHIMySe5GWnpkor/nF50s?=
 =?us-ascii?Q?w7IvL2iuxTyF8nx3CV3xBuwzQzjyULO9/lugkZYC42eIDxzWu6mZdRJTNgPy?=
 =?us-ascii?Q?wgH6D5CdKa69K6qH/c6NJ+pNE+FPljAWEFJBX9OIfYiGpPh2kxKOvE0QPw9Y?=
 =?us-ascii?Q?19LdzimIG8JswZrj1KjXd9E/XRclNSiRhNaQhxbuoddaB1k6fx9TgIaMNZ7m?=
 =?us-ascii?Q?XU0g8xGwL0kt5aIeUiPFMaWZ7+1qmMTZdUy4tWEQr0AJQnoa2ywCMaxkLohf?=
 =?us-ascii?Q?V4MlL00VCUeFfbWwAIjxianMzt9+c486FtrFecgdhnhez4c8xthcbea0UUEf?=
 =?us-ascii?Q?lKpu9zNcBXh9Z7xd81TI3dowybdVXaRrAo0tT9RroS66nASTV4LcEnNX5KP7?=
 =?us-ascii?Q?XvRUas3cWm4UhYJ6PgEUckA/mjnylYGuQRMY9LeanFzPKx6KZf/VOagLfwVa?=
 =?us-ascii?Q?Mmx9rV1qznI9hspKc9yVdLqiXMPM9zMPzor6ogj/XfPjDEAiQJNDOkenqzQl?=
 =?us-ascii?Q?N0QerGBNIF/C8tl8lzAl1HMG03yp6hnW4LJpDM+sZYXJLgD3aP54oYKrTy7d?=
 =?us-ascii?Q?YG+TsiygdOXnIVyO2oHAw1kqhiQuWSUf6m0MskLl8LVcoPNDOU1BMyZkJG8c?=
 =?us-ascii?Q?NdqB+w3HWumrDf1K76rctPL4+5IeYlj5nCi6RCt+4KEIJURRA8RmFf+DlcEh?=
 =?us-ascii?Q?SpC/fsUdH0R0IgwlDW4+P+wcvzPtXH6nYMvR/DqTqisz2DFOFZl30GkPopli?=
 =?us-ascii?Q?LtRgYCgz9jCUn+sHYhd9G535ehy0oLS6LJpCQnP9DgdJ4yh61gla3pqFbS/s?=
 =?us-ascii?Q?2UyWfcICoJc5zhcIVUSZhbc1SW74EkJgb61GWWk0oi7r2aiEW5Jf7tCn0FUM?=
 =?us-ascii?Q?nekBps9ieHsrlWT3au0QOlCzh8CNGI52F/PjhoQdeV/8UOHvBVjA831EYUXY?=
 =?us-ascii?Q?w+ptO/3RHvBZivegtvECF/CugBVGv5GXDcG+4j9+RKZuM9sJZxh3DgDwAE7F?=
 =?us-ascii?Q?52F7umerPGptF2c3TvgGx+o0/0QIliqZUEso87Is65f0oXxPfUPUTlFT8YPc?=
 =?us-ascii?Q?+kMKcqsgyWHXzS5tvu4j2D5ktNfWWyPP5yJF5tvkTC4iV1efPy1tU88koGPI?=
 =?us-ascii?Q?z3D2JyNkySXpnBnLuU8t6A6OpRXNpTgdw4remPAeYG0vLBUuWT+Gl9+eLCr1?=
 =?us-ascii?Q?9cZL/zIQbPLsAGbrN8hc9hqEQttTdnBqpxEJIAUJqU95Yfx+7fxXMDOmBN8l?=
 =?us-ascii?Q?Qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b953aac0-9cde-4f96-d012-08d9bc7d276d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2021 08:06:36.4692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ghq/f9EJPdoLe2ekr4h9pOtrW3oDDEK+WqdPDQCC8tWD4nPRZScmflVOX/hPLQxB1fU509Fzut5blRkqdz4O/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3572
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Friday, December 10, 2021 8:13 PM
>=20
> >>   5) It's not possible for the kernel to reliably detect whether it is
> >>      running on bare metal or not. Yes we talked about heuristics, but
> >>      that's something I really want to avoid.
> >
> > How would the hypercall mechanism avoid such heuristics?
>=20
> The availability of IR remapping where the irqdomain which is provided
> by the remapping unit signals that it supports this new scheme:
>=20
>                     |--IO/APIC
>                     |--MSI
>      vector -- IR --|--MSI-X
>                     |--IMS
>=20
> while the current scheme is:
>=20
>                     |--IO/APIC
>      vector -- IR --|--PCI/MSI[-X]
>=20
> or
>=20
>                     |--IO/APIC
>      vector --------|--PCI/MSI[-X]
>=20
> So in the new scheme the IR domain will advertise new features which are
> not available on older kernels. The availability of these new features
> is the indicator for the interrupt subsystem and subsequently for PCI
> whether IMS is supported or not.
>=20
> Bootup either finds an IR unit or not. In the bare metal case that's the
> usual hardware/firmware detection. In the guest case it's the
> availability of vIR including the required hypercall protocol.

Given we have vIR already, there are three scenarios:

1) Bare metal: IR (no hypercall, for sure)
2) VM: vIR (no hypercall, today)
3) VM: vIR (hypercall, tomorrow)

IMS should be allowed only for 1) and 3).

But how to differentiate 2) from 1) if no guest heuristics?

btw I checked Qemu history to find vIR was introduced in 2016:

commit 1121e0afdcfa0cd40e36bd3acff56a3fac4f70fd
Author: Peter Xu <peterx@redhat.com>
Date:   Thu Jul 14 13:56:13 2016 +0800

    x86-iommu: introduce "intremap" property

    Adding one property for intel-iommu devices to specify whether we shoul=
d
    support interrupt remapping. By default, IR is disabled. To enable it,
    we should use (take Intel IOMMU as example):

      -device intel_iommu,intremap=3Don

    This property can be shared by Intel and future AMD IOMMUs.

    Signed-off-by: Peter Xu <peterx@redhat.com>
    Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

>=20
> > Then Qemu needs to find out the GSI number for the vIRTE handle.
> > Again Qemu doesn't have such information since it doesn't know
> > which MSI[-X] entry points to this handle due to no trap.
> >
> > This implies that we may also need carry device ID, #msi entry, etc.
> > in the hypercall, so Qemu can associate the virtual routing info
> > to the right [irqfd, gsi].
> >
> > In your model the hypercall is raised by IR domain. Do you see
> > any problem of finding those information within IR domain?
>=20
> IR has the following information available:
>=20
>    Interrupt type
>     - MSI:   Device, index and number of vectors
>     - MSI-X: Device, index
>     - IMS:   Device, index
>=20
>   Target APIC/vector pair
>=20
> IMS: The index depends on the storage type:
>=20
>      For storage in device memory, e.g. IDXD, it's the array index.
>=20
>      For storage in system memory, the index is a software artifact.
>=20
> Does that answer your question?
>=20

Yes.

Thanks
Kevin
