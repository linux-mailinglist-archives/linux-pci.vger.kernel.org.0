Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DA467F5CC
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jan 2023 08:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjA1HwX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Jan 2023 02:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjA1HwV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 Jan 2023 02:52:21 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6630577DF0;
        Fri, 27 Jan 2023 23:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674892337; x=1706428337;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WfJ0oWnmvMY+kxu4W+LLPeaptays4P2uuR1uEATi7Lw=;
  b=XUPZ6mabyD7chwCIskqBEcwJqpLJQ3AGOoVdn0ZVtFvi/EgdMhZqCIhX
   2lGu4QN3un4wcZugutSUT/5fNWKWMIknXxmdyFgkfi/8YncJyRQTH7pdR
   h9q+/iB/T2ifQJ1a/+YmKLCIkA/yNlCnzynJdu5GxuqKjrXUuvhyNPvqa
   J8WLiNoRzIqZIT61wEJpQrbu4taaQmpu34F70Ia8A+3I937XAbrh+kQF3
   PGbjRPZYJAwfyVLi2kuBjiD1CNe/MCPkrGg6ofvIu2ni5im9XC3JaEd1i
   eMFuuDPIE3U92mnJprKNDch7D7ZtLhD3jPX9w9KUhylkf88l52ohs/9e/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="310895217"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="310895217"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 23:52:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="732126330"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="732126330"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jan 2023 23:52:16 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 23:52:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 23:52:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 23:52:15 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 23:52:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ty5pZzDfiN1oZ6ipBFVbWRoIHZr3phq4jyWMp7eZxZHJPmjnn48ozlxO+pmhb2S79G/JKaRQmmLP/5zZa9/hLjjv3qFuZcBflt1YtBjOUB7FH7PhpmlO2HW0SG98HrjbZZfUITeMdfD+RV4zHVdeI1EYOO/MdRKFqiN6ukfC0uI+7a/v6JAr8ofTH2nS/B3WC+BS2Rgv5NggjUlx76PtkxYsD1lEvg19VtxRAA4RPtqxMu4LNMGhdy4W9gK9qIvCjHR4M1ymwBjqnxHXfMbv4f66YeQ6RhsG/Ay6AYTvr+t4E0Iq9QmuNnl7bshX/XQOpxXbpFtqE/CycwHk+aQEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIYwjPDKyISsgBQzmAheeNaTwDlOMufJ+3p1VmhRvU0=;
 b=Xf4lWa4KSV4lib8gFsni1K5nIEKmHKZlghKJBBQIVFhzGCeVn4vuncg8+RqbV3eV+AuN+beAg2xv6OgCagwwjC4Eq0Voz6Tm8c8CU/MrUcjNajKpkCinRJWCQw6jV4dYXNXhNmTXL5H7ZInVhWzg7zYBtZQuWsmZnV1Kpd87+U61c1q3ppNoXVFbj2FnfVaLb2Za5RajAJaYdI22hVR+tgX7fkMixWwsP85lWOhbxG+Jtb4jtCiJ+S6F6oG9i3v6icq7twdwt4bijt+b1nt8oZ/foHS7xWCyf1yj7G2sY8I9MQGBItunNc0C7/bdYTeepwHwNJTnuaEnsoHi/nPaDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5677.namprd11.prod.outlook.com (2603:10b6:a03:37e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25; Sat, 28 Jan
 2023 07:52:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6043.030; Sat, 28 Jan 2023
 07:52:07 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rodel, Jorg" <jroedel@suse.de>,
        "Matt Fagnani" <matt.fagnani@bell.net>,
        =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Thread-Topic: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Thread-Index: AQHZJ+u/izID69X8S0CIgNghGwY+ma6ymkmAgADulxA=
Date:   Sat, 28 Jan 2023 07:52:07 +0000
Message-ID: <BN9PR11MB5276B53481C374BDE839824E8CCD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230114073420.759989-1-baolu.lu@linux.intel.com>
 <20230127173035.GA994835@bhelgaas>
In-Reply-To: <20230127173035.GA994835@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5677:EE_
x-ms-office365-filtering-correlation-id: a9fcaac2-0565-4eee-2c8f-08db01048e11
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7sDa4TqDm7YdqXDXThxD5zZ9mx4wmqoOmeTfXhojIw5hYy+voLJoZaNMzSaDRZ6qpHcu0vDBUFVyetZjBencimLwy9xxIaty+ykmH8bWZBg6HtlYI7Wx5slm4COc/uws2Zk1i1Q9sv8RknHcvTigVGntV/7X9wZOrZlc53ZS0Znj4z93gqJIcMYw1w1hJJM+Kg9U1bk/elh2QnYYNGYCu7rbgOhHjKWz1xLyj+ovPgNTcK+JMoZmFrjtvV3/EM3GEqxU3diMdn2lzkEJ5oinVxlNIpmt8RNdjPkbXFE7RVHLuf0iwicRxBZ0ZPzm4xGhv4/yFrRdMBxjPswS0wls940UZBfKCHtPUa8Imf3KQg+7EwkdkcCq5SJnIdoHjOSH/xKI4H/0lrvmewvaEfJ3yXyf1BfLvISFu2HUnKCd3QMeYJ4ntIcO/hPrH1AFmgCvzSTjd/c1COLsUcQoX8Qsm99rnwNQhz9D+JpnywUZPsSUrUvOMrJIJAjk+g5ySK4ZKcrd7IwNDtJkfNuYMdWD9+ja7eLqQqrqCxCgXmzzjPNMuDioQasbL3/0kJT056MJ7TH9u/WKIc1KlLalHozutH+VgtmtEJR8EyE7KqiesSVpOa2vbBwSU2pVEwaSSixvSedhxFbLlh0D3O4QxdzVScpJ8rgnYZDvJAzzBMFSLguvsBJVAK/vXCnhnuL+visBEA3981SgHfccAooX3LxkuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199018)(38100700002)(83380400001)(186003)(122000001)(6506007)(82960400001)(9686003)(26005)(2906002)(55016003)(110136005)(8676002)(54906003)(478600001)(52536014)(4326008)(5660300002)(316002)(71200400001)(64756008)(7416002)(66476007)(76116006)(66556008)(41300700001)(8936002)(66946007)(7696005)(66446008)(38070700005)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xpCu0NOC+RTgZewy1ob8wSx0wvTkV1zdFMmqPmOmlqKQ2/y5zZfijDbI3W?=
 =?iso-8859-1?Q?u41ACEPrVqDssXPPtP5qS/cHvSXQXAqRjqRA+mPOkha9eCZf46bFMl5nkc?=
 =?iso-8859-1?Q?xdWWOCenFzjoVLvIQmyTj3ZHgYnnypT+T/tkAJnOD/sgm4xaeFW3Cu9LoV?=
 =?iso-8859-1?Q?NPFb8bdl/ecW8GIh6uGi7EmY9b4RPeHXPnSJ3hX8K9UpQGp9mxKEDEgMcX?=
 =?iso-8859-1?Q?LIHIx7MSc2t+b8w2ITpkT/gEOkuRwbRUmFd2ALs7TqxmQ2/ACbGMkAJLvr?=
 =?iso-8859-1?Q?bE+CO2EAqS5dXOmnCTblfyzy8p9pw71/Zrmgvy0WqH2AG59uQad2ZJWBy0?=
 =?iso-8859-1?Q?BWUbt+6VDR3+FFgPzy7bmW395T/6igLVaqebOitHlhplhA6ZQUSSahmSBL?=
 =?iso-8859-1?Q?KnjX++4HLOT8kTIzuV/8+fH4WVXAzrX1EkKLpbc2/Fr2ivKg1H7T29ilpb?=
 =?iso-8859-1?Q?2/asNjX8S9DLZjiZuBNkODuvsvEIbdb1zVizZvCrbH/mJisZ1u8wGhg4ZE?=
 =?iso-8859-1?Q?ZOcjj0D7eXxJN7LOsM0AM+eAJW2SM+1iXiL+D4YkNT4QLEMk+ENFsak+XS?=
 =?iso-8859-1?Q?Ru0wzJodczKC6XN5p4tTfXS2mHBXA+VpGwaHbAX2C/Gn/32606Km00iJcO?=
 =?iso-8859-1?Q?N5gPmJHMM4MhaUlROk6RJd6WbIs+p92VcYNu2anICza+apJQ/sBs0ucurf?=
 =?iso-8859-1?Q?Jew3yKCNhHRj4XOL5i/azfCY529PwqV1ZGCfYAEV7ldrvPnmP4o/qw27nk?=
 =?iso-8859-1?Q?x+S1giU2sn55oZgOEfkdk7woHu7Bi5qmfNaKr6c0gOPZXwvOUdLmToNRM9?=
 =?iso-8859-1?Q?vekaBX19IW4nbD/QcMSh7g0+MKcRG6x8QxmoNOL9pZZrfUqYZI7Xuy8dei?=
 =?iso-8859-1?Q?yA2S0DDDvLpE4W2NUBREtopPtMCNf3GDq4En4cIfTBOavZZ7kWZbhSDcHJ?=
 =?iso-8859-1?Q?mSLMmqnHdfkiIRunmqm+Er2dKbyWGicCuJE8IXq7NFsUCfR2U8KtT15PmH?=
 =?iso-8859-1?Q?OVJwtQIofd+3ptqDgVBGpHuBJgX+wpnoxevSm6fEyYhD8bzKZ3LKdOIRq5?=
 =?iso-8859-1?Q?PoUnv88OVSzxffUC4G1yynTxzluBhrLe/+MB7MPekGldZlS6XeLnQlsx30?=
 =?iso-8859-1?Q?l/dYddQnd4zz320InH8gTARt7eE5KaCgugLMtnjvp/KswIep7A8D0kkYL7?=
 =?iso-8859-1?Q?h3J44KbxsxQn0riFdGl5UY8kzJeleiyB+KYYiQiFiz4mc2kEOcIw7SNs1q?=
 =?iso-8859-1?Q?qNkDxn4sPY0yG2VPztMSmCZLVPBy6UtNcyt23VyptFoVFl+c10sfOC0Gab?=
 =?iso-8859-1?Q?kKXj06x10jRpZCGQNbRwfKK56thwAnQL0u62MxvMtT3V/9M2stnd7W9e7Q?=
 =?iso-8859-1?Q?+DDSW5n97LXBs7UknT0mB6vMm40VOELIr42uvi7i/nVGqOaZMQFNo0/HkJ?=
 =?iso-8859-1?Q?l7j6Kg8vmW1KkMzv7X7lq8YHkConVPXPgE8Dkz7O5YS+c9Lgypmb2k5q7n?=
 =?iso-8859-1?Q?7ewrUVpCER5HxEAhVdB6gZ6FEr5cFUlgsaBIVS8uQ6Z3AiAz5caj+LPu/K?=
 =?iso-8859-1?Q?q1F+M5+6d9IgnimWfJUxqx85rkAehTuPkp0aidb2HL0O/z3fKSn3vOkInQ?=
 =?iso-8859-1?Q?R16cFPh5nNlhTyS2xNOVJc+eCB+84AR4fV?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fcaac2-0565-4eee-2c8f-08db01048e11
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2023 07:52:07.7731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jUEp+BLlAqUhMJYPDANXHvsej+B0ROFmJ3ay7Bcg80TtUjM0/M2OZO21KjU2GXmn2j1Pnjpd+TCy/Y3LbK9TAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5677
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Saturday, January 28, 2023 1:31 AM
>=20
> On Sat, Jan 14, 2023 at 03:34:20PM +0800, Lu Baolu wrote:
>=20
> > @@ -353,12 +353,15 @@ void pci_pasid_init(struct pci_dev *pdev)
> >   * pci_enable_pasid - Enable the PASID capability
> >   * @pdev: PCI device structure
> >   * @features: Features to enable
> > + * @flags: device-specific flags
> > + *   - PCI_PASID_XLATED_REQ_ONLY: The PCI device always use translated
> type
> > + *                                for all PASID memory requests.
>=20
> s/use/uses/
>=20
> I guess PCI_PASID_XLATED_REQ_ONLY is something only the driver knows,
> right?  We can't deduce from architected config space that the device

Yes

> will produce PASID prefixes for every Memory Request, can we?
>=20

No, we can't. PASID cap only indicates that the device is capable of
using PASID prefix, not a mandatory requirement on every memory
request.

Similar case is PRI. Having PRI enabled only means the device is
capable of handling I/O page faults, not the indicator that it can
100% tolerate fault in every memory access. That is the main reason
why vfio/iommufd can't simply skip pinning guest memory when
seeing PRI enabled (well, though PRI is not supported yet). It has to
be opted-in via a driver specific way e.g. a vfio variant driver.

Thanks
Kevin
