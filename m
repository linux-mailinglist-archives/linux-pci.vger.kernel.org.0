Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3A16973E3
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 02:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBOBu5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 20:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjBOBu4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 20:50:56 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F39E29155;
        Tue, 14 Feb 2023 17:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676425855; x=1707961855;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rtnBJVPMNCZ1Xm6m0NPJtEtRLmB1nr9qMLzmrv6pntc=;
  b=cOGPhtRANp99GVaaGKKyL4Np/SqXTrVP6OfZyHeMwcB98AxmdnjUy/SR
   g28NJ2JikqHGT+RrfavK7nv+G+oDFkUYH6/oXl1hHVPj4NTlWHhE9inbK
   qH5RTI/64iPYWg15Jcw07aOdruXcByGXtZIxDjcxBnJEV+mqATERduzDA
   tsXdglRFAkibJm1BM7CUYw7kNoG8CO+4ovKhgxagMmCCqRBcIlUfkQQRa
   AQLLNagnOxadiBwC5ZJG+scm9XGhx+6cVMokkDwpEM0nWx7XmQx6jaLkS
   xA/OBYULWMVMCgLkAgHtxJ5ZlnPbUBXEzAvOKhlwhPVul9yEPrFXtzaJ4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="395944851"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="395944851"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 17:50:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="733098628"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="733098628"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2023 17:50:54 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 17:50:53 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 17:50:53 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 17:50:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=covsIqVvU835oAqZlIMRlhF9R+9ScXpWmk66YhIcmPppL0KxFEbdqVZpBqT6aXvTwbyItaZXUgdVw4XCDOZzCNfZIDUBAXzFs4Q3/XzfqMapdYuwJoC1Z4arQWuNYpWFGNFDVxtzerHCGJvoXo+jiidb865XERePIeW1tf5z6aJihGuZE8+rDa7CfYerDPX/FgQVW2oht07XP0AQkgPhQPQzuj9/kFkLwhrBlXKjZxwiY11YnaY1bmgn7my8WlOCWGp+GEoa5rdCMGug8UJr5njQ2nCD/YST3XbnpBJKiGYVXjj8S+dUKy6k1gsZ633MZl8i0qAUin9yI9cWGdmvgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nv2uD7TRqjt3wik9uSSQED4YuEEkLOxAmQqDyg9PVOE=;
 b=Qzp48c/OAiRBn+YOdPJE834Ytve6zX51VtK38A4F7VRiR6JFxKRPm9gRDewvd/1tbTiOxBMXs+azzNXvLTP68SfP/D+ozrf+XgWsNLXFEc+sri7dn1YM1iSG2cn0rCy2F6gmApAjZKSul35hLDqk5fqp9+5NgNJntSkzKL7N0zLS+TuPgoTU1gP76cJiixN8sOyMpLrIWEtyFCHdoTT0P+Uz5i+nSPPIjO2zW1GHdE2dh9+8VIPr0F+hXfxIpliMM6LjMogt7V66X84Q8Tdjcez/IH2TrRwu3u+t/AJZqqhL0gkDpR+V+GSkTEbbAMr8BAzPJ0pahexV97R3cgf7lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5056.namprd11.prod.outlook.com (2603:10b6:a03:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 01:50:51 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 01:50:51 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "darwi@linutronix.de" <darwi@linutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>
CC:     "Liu, Jing2" <jing2.liu@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] PCI/MSI: Clarify usage of pci_msix_free_irq()
Thread-Topic: [RFC PATCH] PCI/MSI: Clarify usage of pci_msix_free_irq()
Thread-Index: AQHZQLk2P/B6OLz9Wk6Od5Zj591Mm67PPPHQ
Date:   Wed, 15 Feb 2023 01:50:50 +0000
Message-ID: <BN9PR11MB527628F9C11C51A334A2861C8CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <4c3e7a50d6e70f408812cd7ab199c6b4b326f9de.1676408572.git.reinette.chatre@intel.com>
In-Reply-To: <4c3e7a50d6e70f408812cd7ab199c6b4b326f9de.1676408572.git.reinette.chatre@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5056:EE_
x-ms-office365-filtering-correlation-id: a1516844-c41e-4d90-296f-08db0ef7111b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ynyhVpWVR+DQa2RXEJuMGzQvvy2CFw0NdxcvQZpoX+EILgn6IVAZGtWZ1FlGKT2MNyDF3NbWnSJFQwH5C8LMhvEV2Ei/uhaZAmRTVU6voNx2qkXyMB+u/d94fvCpWDRU9HK5QJBSDTfgirMlJ5KVa0quvxB3hIG267NRPx0MxyRwUA/O0TrfyxLnpIpBxotPoziXVsiJMdJ71pq1g7Q/+qZHsTlMiyTNiUmfEl7IY3T8tSVC0u/GHO8tELi2f+AIol2ige9sUNjzj3q5yFUDzIEMF54vFpyBl8CrKt2NyWemWtJhkVXXMnOaeI5M3/l9fcXE8Hozza14LGNHCUvXIAA22VfrztzX6VDBQvv5sJmrrA2iys6yvax25oqYG7q5K1QvlyxgbE44HcQMl9q890vAoNjn0DZtIib5cxhAwwdNm/Bs7vGjnLKhIwIr4Mb8abiu+ukV7vjcu9i2a1+iVbNWrQqECDbqqPxKxROUuCaURXO3/Hvt/n6IPJozLpjW9MpSPSiEy58i5qjsAA7XePkt+YSKUkel3PqYUCg6ponu4gJsnMGzEZSSsKOjjkBRP1v5lIYR+qbynaAayCFPuQ8eh//0sP7pF6TtgqdsfJnxf+nmUBhRBGIcHMpXIbsEXrU4YrynlTkOAbyw/CygSAyFfQap5flwBHcpYbGoWZSjaOLmHU6Xuxc8pssPvxx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199018)(8936002)(186003)(6506007)(5660300002)(52536014)(41300700001)(26005)(9686003)(122000001)(86362001)(38070700005)(38100700002)(82960400001)(33656002)(2906002)(55016003)(83380400001)(71200400001)(316002)(7696005)(54906003)(966005)(478600001)(110136005)(8676002)(4326008)(64756008)(66446008)(76116006)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1WGNKSDqjdOoV/zTgE3um6IeUXwav9oGF3KoBh74m0L4iEjAdzADCMbH5g38?=
 =?us-ascii?Q?cXwwx89pt2B4PJVKLBj9ma/RtWa60ZQ3xCLxAu+stpnqSdtguh8CsKcBGZeC?=
 =?us-ascii?Q?7O3WIETnkFHuYzjcPuAETOANMcbz5aP1SJ3/cmoapSi16OQIqUAT4vRLGObS?=
 =?us-ascii?Q?CiA84Aq+W7P8a9A+v5+pizSalK2nxNjvbOD2Ibuacsq2hYWvbTZ5F8hc0Gtu?=
 =?us-ascii?Q?2a0uvKZhIYzfnDWSWjaUAupg0q3j8ftIbLFl58JXPhW6Arb9D+i4jNsb+Wzf?=
 =?us-ascii?Q?JecyQ2ZzTeMJHgS1BN8wFBJpem+9UuGyaG41lQzZGECXecAOdUtbUkcUJU40?=
 =?us-ascii?Q?GuXv36g6ob8FZLYtt+Mm6cZeDWVbEDs3ykIJ4FIlaFkj7hEYKcdBL3fUO9uT?=
 =?us-ascii?Q?pVIFUm88c8HS3ZF8yHtk/tvSfZ5DRHbgnr4jtTYbePmAv4eWUEWFxkH9x5X2?=
 =?us-ascii?Q?pqHDiJL5hOiieaALlwQmeectgYIAf8uzCjk975FA5rtGVL1f2O/NpiUzh9cE?=
 =?us-ascii?Q?jpk6/UQclrCHyr74XoXbMXPt65mQrUY5Z0FZU1VsUxYh/Cs4wFPDf30bgGYW?=
 =?us-ascii?Q?6nq4kDdrc06NYoWSNitdP4joTwvtqtc+KWHCu//UmHDX28UV9GnO/dlaMCNk?=
 =?us-ascii?Q?ThqV4wsZC5RNM/zCGc8LQgKjb6jfa0Q2RhXW8w70Z6LudsYnnkakWD29AvR/?=
 =?us-ascii?Q?NRF/te1rYKTHubOhYW2Q0eVv6ALanhsNLyJwf1MxL6D281utdRsrbHyITUZb?=
 =?us-ascii?Q?ZuVmY+MkAtedwAXCtQcRbwTrP8Ce5hgDh/nzTRoUrhIrP8uMdyGpY6lqKHMc?=
 =?us-ascii?Q?OuaMDr84XGw/8ikT9YjfEax1Ykt685t7uUAIJxb7a54TZP2MO97bB4lXYR+2?=
 =?us-ascii?Q?EF1kFXQ1uL+YBNqvVmGN258p9xziBLC4efV5SrZSpgk4eXrzVNZw5bWp9t5i?=
 =?us-ascii?Q?6wp92cxBwp8lXEkdkit9Gag67No0gFEKVRb6XlXJoRMMWXBmJJ6XTorEhbhp?=
 =?us-ascii?Q?KeFhG1WY2wlwknbqS/oRyVKpaduvXUqParx5qxGPjyoGy+deVmGNTVxxqo0N?=
 =?us-ascii?Q?JOcKB4sGFlycSQRyhUbsz3Vm8JNGUs8CH4rc276sdIlZCRHts4/Oy1wg7Cs5?=
 =?us-ascii?Q?H1+Yiv97+qYO0uD0+NYEpQ3FUJvOtkXB+4z1hjMHnzuS18RPHixn9SkyHHfj?=
 =?us-ascii?Q?UczZ7zbAT7MYzq61ixaAcTCU9PTTxtrdXC4X/EJA5pQaGn7JmVFqfdHeVW5Z?=
 =?us-ascii?Q?q3rNaa0tuRvnHXQlXzhPXKzvwUpMKlNJxu6uPv5pmXVQccJxEqqcn4Ir4h2C?=
 =?us-ascii?Q?87q+xJClpA8LGUkzYUejYFkStqCxHQHAR3Xoaynts3ExZBPb3/1He9LJnaUR?=
 =?us-ascii?Q?sghGiNSTZU82K/lGOJM/IfJq9pYCkAwHA0FqU/lLC2w4FKElboqT65uhVS8T?=
 =?us-ascii?Q?ihU4HDsp3DYRHLSuipwKlX7bubTQ0SZY1ck6vi/eVb9/xWg3wC8aw5H8VjD+?=
 =?us-ascii?Q?Z+B5+jDXdXnCdILnl4bAZDnoqHCaMcJMaLgDQU/jBVkXK8021rAzZcu7jfwz?=
 =?us-ascii?Q?sa304TfsIUV3AU/mvjzrqSU+XMsnA+DpIlxFj+Ni?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1516844-c41e-4d90-296f-08db0ef7111b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 01:50:50.9292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NnL3aimc8qcjXmx2Aj89kKi0DV0ea7sPZtZgJW5C6Okw8dXAzADcEGXekc8u1xy+xgCREBR8A4z44iV35ChDvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5056
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Chatre, Reinette <reinette.chatre@intel.com>
> Sent: Wednesday, February 15, 2023 5:13 AM
>=20
> pci_msix_free_irq() is used to free an interrupt on
> a PCI/MSI-X interrupt domain.
>=20
> The API description specifies that the interrupt to
> be freed was allocated via pci_msix_alloc_irq_at().
> This description limits the usage of pci_msix_free_irq()
> since pci_msix_free_irq() can also be used to free
> MSI-X interrupts allocated with, for example,
> pci_alloc_irq_vectors().
>=20
> Remove the text stating that the interrupt to be freed had
> to be allocated with pci_msix_alloc_irq_at(). The needed
> struct msi_map need not be from pci_msix_alloc_irq_at()
> but can be created from scratch using pci_irq_vector()
> to obtain the Linux IRQ number. Highlight that
> pci_msix_free_irq() cannot be used to disable MSI-X to
> guide users that, for example, pci_free_irq_vectors()
> remains to be needed.
>=20
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Dear Maintainers,
>=20
> Is my understanding correct?
>=20
> For example, from my understanding the following is
> correct API usage:
>=20
> /*
>  * Enable MSI-X and allocate num interrupts.
>  */
> pci_alloc_irq_vectors()
>=20
> /*
>  * Free one of the interrupts allocated via pci_alloc_irq_vectors().
>  * Possibly called num times, but not required.
>  */
> pci_msix_free_irq()
>=20
> /*
>  * Ensure all remaining interrupts freed and MSI-X disabled.
>  */
> pci_free_irq_vectors()
>=20
> This could be interpreted as an asymmetric usage of the API, yet
> found to be practical when trying to use these new calls.
>=20
> Your feedback is appreciated.

I asked same question before. Thomas gave exactly same thought. [1]

"
The preallocated descriptors are only relevant during setup, but not
post setup. So yes, you can do:

pci_alloc_irq_vectors(dev, 10, 10, PCI_IRQ_MSIX);

and then

    map =3D { .index =3D 9, .virq =3D $IRQ };
    pci_msix_free_irq(dev, &map);

It just works.
"

but looks the comment was not adjusted accordingly.

So,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>=20

[1] https://lore.kernel.org/lkml/87r0xsd8j4.ffs@tglx/

>=20
> Regards,
>=20
> Reinette
>=20
>  drivers/pci/msi/api.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
> index b8009aa11f3c..be679aa5db64 100644
> --- a/drivers/pci/msi/api.c
> +++ b/drivers/pci/msi/api.c
> @@ -163,11 +163,11 @@ EXPORT_SYMBOL_GPL(pci_msix_alloc_irq_at);
>=20
>  /**
>   * pci_msix_free_irq - Free an interrupt on a PCI/MSIX interrupt domain
> - *		      which was allocated via pci_msix_alloc_irq_at()
>   *
>   * @dev:	The PCI device to operate on
>   * @map:	A struct msi_map describing the interrupt to free
> - *		as returned from the allocation function.
> + *
> + * Undo an interrupt vector allocation. Does not disable MSI-X.
>   */
>  void pci_msix_free_irq(struct pci_dev *dev, struct msi_map map)
>  {
> --
> 2.34.1

