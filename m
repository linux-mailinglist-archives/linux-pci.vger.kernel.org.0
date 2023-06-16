Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A041732A0B
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jun 2023 10:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244439AbjFPIkG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 04:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343780AbjFPIkE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 04:40:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB75B2D71;
        Fri, 16 Jun 2023 01:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686904803; x=1718440803;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OUnthE0dShY3CBFrJQspprXvqOY/Qdst0Sh9Aab6Q0I=;
  b=eNC2If+bo8itCr75fQ605HJVaXHEI12LzXdfybaXovnYYzC+7ZpCbzK0
   YI3fhthPLJdLiXZ24jd8bkj2lU2r/89OOGn1+hUz/Bu2IJZ9fCeCx7GV/
   8+75wgxfsrxo/d743EnLXu7lpBchH0/24nKKn4nrUNoP3CRay9dLQh9JI
   Izq0ZJfyVwSJJWQUnHfwemQjT26usR9nDzk8Z5ODzULfaAJyW3ZHbs6Ji
   fYfkpo9wYMZTE6F6zKbWAUHtxW9qZRkVp8JNBpB8CtmB/p3IkdfvHdK1W
   WDM8IDKROqeBmAkG2aqGeydG7W7uvQwtJOTneBnzDmUvY/TcNf2aaCrPx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="338777739"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="338777739"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 01:39:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="959544039"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="959544039"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jun 2023 01:39:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 01:39:54 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 01:39:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 16 Jun 2023 01:39:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 16 Jun 2023 01:39:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ig8GyErNLeSpHs8UAwtE+ZgSdxNLglxmleXKN8fZVUDF/VAeHSIZ4A0Vnp6mUaWcy30uBpQN95nnotPw9nQV06rlv95GsVz0NEtuTtezeU7CYaADdwGAq3raZeHgwvqc5a4ypIE+tk/2Wn76qiVqPw3HRO4DanwRi/AhLz5dYDuvMZFCdUflBahEkxiSxNfAg8dELvZwrnV0KsP6tSG5G4VbA+z3DGCCBnlG9HwuhDnTsalbgVR3zbmgI12LPFv2peqEaFnRj/iZSYKJYsY6SPXpmReUEIKKqsAqYz5fqmD9YZrFI7tFAKMe3i6AnKki+M+v+E0IIwU6fwM1dvtPDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUnthE0dShY3CBFrJQspprXvqOY/Qdst0Sh9Aab6Q0I=;
 b=LDAgRw+mqkMFERscpu2Oc7XUGCmQqdqd5FVfNU9QPU5Clmmb1G/HEvc81SwzsF8fjWSOpWVb0N8KB0AxogQ11RCZOj6jq8e82dCXPQpd99L3Q9Ud9KEHhkoNY1Y8tQqKbykgQiUj0C9JKowous4oH98h1D9/VbZO35htGcpl+uCCglsuO8LCwsqgjf9APC9sFiDDsQMzqHJTr+82Cj+T0FFhQq6CKUVzshm3xTz74SfPnIrajuuxKkTT7aIOMIt/vCeheLZTL6NhqNzdhvTCjA/Hc5egFTxlsnR2NdeMZyu0GsAFsU+xB+un00AheeaWAxUxTZR+tIyDEYOT+MUuIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB6714.namprd11.prod.outlook.com (2603:10b6:303:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 08:39:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6500.026; Fri, 16 Jun 2023
 08:39:46 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     Baolu Lu <baolu.lu@linux.intel.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: Question about reserved_regions w/ Intel IOMMU
Thread-Topic: Question about reserved_regions w/ Intel IOMMU
Thread-Index: AQHZmZR0JpzuQIuRD0G85gaP7++jm6+AOJSAgADP/QCAB+LmgIAEOrcw
Date:   Fri, 16 Jun 2023 08:39:46 +0000
Message-ID: <BN9PR11MB52765C24405D2475CF3CBEBE8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <CAKgT0UezciLjHacOx372+v8MZkDf22D5Thn82n-07xxKy_0FTQ@mail.gmail.com>
 <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com>
 <a1cff65b-b390-3872-25b5-dd6bbfb3524c@linux.intel.com>
 <b24a6c7b-27fc-41c0-5c82-15696b4a7dc1@arm.com> <ZIiRK2Dzl2/9Jqle@ziepe.ca>
In-Reply-To: <ZIiRK2Dzl2/9Jqle@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB6714:EE_
x-ms-office365-filtering-correlation-id: 9c77e599-48c8-4aa6-f534-08db6e453d8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bL0PGHQ6/kOPtfZVd2lRRtj26Sa//lx+hIDoZkyuTsWxO3ZCYClzEV6tK3qOX4VypA2JQ9oC0tROrGmE5vQxMgKnqc2PbGnv/xrxPchkJJ3vgcxlLMQFaJojnT0r5ZpkO2q04OYCyTZThHWm9+5SSFW3L6qp9a+swJN9DbMDu80piLErV5dzsRlal51kNC5a3K3/A88In1eH+7ixa/Fc5rtomPYaYKCQTfnpaK4vWxQ5agWc4XmNM/8HMwF+2tD4cbIxnsrk38oPnCivh6fI0c8I1WGA2rS261y+gYYQ4jCWHxhG9qrCs3HtX2vqsHmZ0Tw8Qf7r6tPFyVXG8HXW0Ctvx0vCpWOmw4/blOq1WaM1wEtw9ZWCU+8rMl3T+fF7xeFVJFjjytkwDQaf3QzPsDGGZpdEqNHXPxvY3gN2M9xB8B/InKiUYFGHpHkxzuch3XtWOCk4d2WT/TRdy6IZwzJNjE0JohfaEdfX8AuVdDCefsUOYJOkSneAfv/PKWbwLwhc9wV9VepJh7ZyZF3+jV54rD2RoAoeVFC10mgGtwd1OBpyJarGjdpH9uimV2odG7CCUGpIxqhkfVh9LgXgrMer+Ot0Hb4wAY7Z+aWqH4YvuxtmWo9TYnh7btshdFBV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(110136005)(54906003)(41300700001)(8676002)(86362001)(7696005)(64756008)(66946007)(66476007)(66556008)(66446008)(8936002)(316002)(33656002)(71200400001)(4326008)(76116006)(66899021)(38070700005)(478600001)(9686003)(26005)(55016003)(5660300002)(83380400001)(52536014)(6506007)(2906002)(186003)(82960400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yFpPsARGunojYpUy5CXUGTNvVTnCLkBXfWkrZfC0I66UZfqbLCwBIMQCrmBu?=
 =?us-ascii?Q?+ySf/xPLkmkFhQI6iXjy/NXg5dEpmG44W2svcM5cXWZw1ZNJG2KemPOcm56m?=
 =?us-ascii?Q?idX9ro30x+aisT3jw7QH57p+yp57S8uW58nFn6+Vr26edWVowWCQ3KCgN79/?=
 =?us-ascii?Q?kjZ94QohNgQzthx9LhRjZzBUa3FI0Q1d3z/SNZC/+FG0jrNIOpl49KfTohX7?=
 =?us-ascii?Q?Ie6DnOuiVKgK5COBSa3awxlv50M5baGQOvs5KcxWuv68GOUFSnRryifakX2Q?=
 =?us-ascii?Q?jikTAFjvGN+mFJR9yXezw5oGtlD1HLXywXmNpqDg/OeWZ4N27UDnshI1GT73?=
 =?us-ascii?Q?IQo4BqXXcYM8Iy45TKlKdciRruP/lRUTCgyAd0xcvVzQZ6WIfT1H4JpDDOHF?=
 =?us-ascii?Q?RpyG5peN1SBD5cEp23lyw+glKZdT82+VSJNFx1aU54+qq2tTX6JImdi5jzvN?=
 =?us-ascii?Q?zCctedp1ZgaX+nZLXF3eXWWZ0C4PVPm33zQEsK1Vy+PV+ncpiaAhLeMst7xa?=
 =?us-ascii?Q?GFFYQNh7dTYvu+C5EZr/sjSknmO7rVBlZ3FGWnRz95rDheC5MNioS+dEd8SY?=
 =?us-ascii?Q?fTu2AZHynMZoI3KV3wJvn3O5vlOdC+QV1vQE+hTCBtQypuzMp6dmmuFhCMlY?=
 =?us-ascii?Q?Qtz6FDa9ESDGmC9chJF4Dy7smKXwCYWEV3d/mUqx7yp2IexKEowrgiDLTLUt?=
 =?us-ascii?Q?Jrr4dcEOzAtfhh5g29/FpK6yGcqrWCh0DvaMRrF9K9Lnjm7qbpT+KiNDuk4U?=
 =?us-ascii?Q?+EbJyLqawbKvIT7f3wl+t7PzcoCo/dYGr8Djrxr6WC4l9XhK56odf+nzzjjT?=
 =?us-ascii?Q?tWQIqbvTOY8CdM5eSBUH+uK0ciqvO8WqDE40/H3t9AF74jeZNkb3aPlHXvi6?=
 =?us-ascii?Q?RlohaR30GX2M2KwHqTuZmgjR0kP8vrzxy558nY21DVzDdqhFNpP/dZMBCAkU?=
 =?us-ascii?Q?9wQ32PBRRNgivAmuFIMzL2RpI2h9UqUEICnuaFyUbzajU3TCu2YljRk81EkW?=
 =?us-ascii?Q?Uvt1Mt/8JkIRECpfFW/bOfxS+43BJ066vsL7JIaIInV4PXwZ4lsdwVXfrmIT?=
 =?us-ascii?Q?a64g1B66eRcZsY1RXA07ARvPDEbytmz2etLahDKbjvm89yINkoZJPfiYJ5f9?=
 =?us-ascii?Q?XsuKi5aQYX/NW0kNnm0wxngPFqN1ETODkePTSmwuxD/mz8B3I+YztgLIU7cp?=
 =?us-ascii?Q?5evxXx7h8sKtrFspSBkh2jk/YhWWz9Oem/zwIJodSmYhM5t99fsz6HZ8TQZ0?=
 =?us-ascii?Q?tfp5IVCuz/s10GzIfR+FzP3L84LZrWYOnkQjNtDkqKxWqJYrDBbCqumL0S2U?=
 =?us-ascii?Q?zz0vaQBfCaut78SLUFJuY6YMhlBZUUjrYLdYgm9MNA7bV6+KNwVAZw3k1x8D?=
 =?us-ascii?Q?RY2N+jTKzu3M9VjMc+fGHVRW+kRedmz2/PdbDpWOCTpkGGFQijJwbE2994+e?=
 =?us-ascii?Q?vw7ptS5/mWDMy9Q016Q9kTFWc0JkvD2alUXRMMD1+jRIIOJ0eFkgGTeQ+Cra?=
 =?us-ascii?Q?tIh5A9txqr7GaP58k/wvOG2e/UfBeqgn7+DepnCSRCnh/3ELXJe/7WjJ3C6+?=
 =?us-ascii?Q?/8XVd1rN6okOHCB9SkbXRwd9+FRTX0CH+Gxvzcx6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c77e599-48c8-4aa6-f534-08db6e453d8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 08:39:46.7104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8AEgxb+BHw07ZI4TDf7nnm46DZV02gSYyHds1cQuaMf+npumahV1JdHRVZVpJpWGDzqXMOUIhEe03QV+sCzu+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6714
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Alex

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, June 13, 2023 11:54 PM
>=20
> On Thu, Jun 08, 2023 at 04:28:24PM +0100, Robin Murphy wrote:
>=20
> > > The iova_reserve_pci_windows() you've seen is for kernel DMA interfac=
es
> > > which is not related to peer-to-peer accesses.
> >
> > Right, in general the IOMMU driver cannot be held responsible for
> whatever
> > might happen upstream of the IOMMU input.
>=20
> The driver yes, but..
>=20
> > The DMA layer carves PCI windows out of its IOVA space
> > unconditionally because we know that they *might* be problematic,
> > and we don't have any specific constraints on our IOVA layout so
> > it's no big deal to just sacrifice some space for simplicity.
>=20
> This is a problem for everything using UNMANAGED domains. If the iommu
> API user picks an IOVA it should be able to expect it to work. If the
> intereconnect fails to allow it to work then this has to be discovered
> otherwise UNAMANGED domains are not usable at all.
>=20
> Eg vfio and iommufd are also in trouble on these configurations.
>=20

If those PCI windows are problematic e.g. due to ACS they belong to
a single iommu group. If a vfio user opens all the devices in that group
then it can discover and reserve those windows in its IOVA space. The
problem is that the user may not open all the devices then currently
there is no way for it to know the windows on those unopened devices.

Curious why nobody complains about this gap before this thread...
