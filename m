Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FC7639F0D
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 02:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiK1Bro (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Nov 2022 20:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK1Brn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Nov 2022 20:47:43 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC0D2198;
        Sun, 27 Nov 2022 17:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669600061; x=1701136061;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/Jd2cgwrBk81M4F6/krmyrzhPmbpWkRuPMbOXthTG8Y=;
  b=Tqb8tiy+dZbh+W3HQ1t0UEs8xrUm4I7kOYHu3feo06voLcIpIWMsOMH3
   XLeEDI+JXiZxSReqNREN+SKD82uGCwHw6bkV0odSA8mIx0FC40vLKtAHn
   /5EVADIoNCo6kqGt18QeGoMFgniP3apkHsiA3Vj0/3odnnQMT1FaIqoHc
   jvpqIz4r3G2dGqpeWsYXxEi18OSy2E73HdV7yyVpJOOrVo77hlAT4g/qe
   1EiNgxk0/lS7eGkaAuBbEX59Folj6xEtolokWWkGP3UtwDbBiOYaMUWXf
   Q9fRzmQ6L5w3yEfrYt0LcYBIlh6Q7DCzbWPQWJ6RTI3pV/wacV1/aVWLu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="313424122"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="313424122"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 17:47:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="593711336"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="593711336"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 27 Nov 2022 17:47:37 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 27 Nov 2022 17:47:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 27 Nov 2022 17:47:36 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 27 Nov 2022 17:47:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiJ5HWj/Fblf3GH1Se5ZC77cNAL7O8LJN8B1W1KkzfkWtyft5aMjKxQaf9QJRw60Vf/bgvveKG9qJOZ9jNVqmW0SFPaG9BGUMpt2qP7GtB2T3x2Xhn9wXLoZbhfu5Fp2BS2V5KKLxhM0TRpnbi38YohtdgmmWeonKBC6fOotpdgPd8Uj7WSbVCbDqT8SVkz9v6QLE7Yt4Eragi3wlzeCdgr4idM3kN5IUqExbpZ66pGpQ4zyjthYlk6c9nFIGdH2B8MK0dii38QTqJH1yyeWPa3AvZ9TtLfDHoiPhY/xmesy3f6dM7s+K2lQO3tHV0aqLGkOf79YyhY1PqRyT6B0og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFVTPb8ov2fsuHwA1T9xeLPtWv3tGz6CqsZ560vD5QM=;
 b=Kbj3vR0R+2zXPqMF/078/O/DcpHdRD+zd6WCP+DC+LXdZ1FQvCO+0wR0vtCQswfJUqhajbEgYAsAhsTnpcJsibrqBPZqsxs4o02edSOAmbCHL3/trJIeU7xtrFn7RktwkL/aBUE48tVXzLM05gx5mq9X89ZzfCKNk4d5ghylIGylWpv3S5lWUxvxxhWgbuk8VtA/WAgKLJyEg1vFjgCMdUElgy4A/gk1BGuh9QNcFQVFWDN02iASRF8KgOSZA7iCwlfCc7WOit26XhrmP2/l9pGgv4TK7KCkJFxF2xIktOV379d+hPq1uJnlN1D2L480T82hgIdHA+GBHky3BZLn9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB7372.namprd11.prod.outlook.com (2603:10b6:610:145::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Mon, 28 Nov
 2022 01:47:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 01:47:33 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: RE: [patch V2 07/33] genirq/msi: Provide
 msi_create/free_device_irq_domain()
Thread-Topic: [patch V2 07/33] genirq/msi: Provide
 msi_create/free_device_irq_domain()
Thread-Index: AQHY/bblStmeh1OioEClNZ/eww2WyK5MCblggABa9gCAAN5AcIAAgUSAgAXW17A=
Date:   Mon, 28 Nov 2022 01:47:32 +0000
Message-ID: <BN9PR11MB527654DBF7C1319397FE68B68C139@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091326.879869866@linutronix.de>
 <BN9PR11MB527604DE2A881FF615B7D0748C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <8735a9gau7.ffs@tglx>
 <BN9PR11MB5276EE7F109A251141E936308C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87tu2oda0w.ffs@tglx>
In-Reply-To: <87tu2oda0w.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB7372:EE_
x-ms-office365-filtering-correlation-id: 1e922ebb-e436-4c7a-7b1a-08dad0e2847c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lHhzo2kFBQj3zR/cmJkerqUc/oj9XiKlr0OidGoVnYN2HNDLSYAxSFckrWmH5/qKKvn8jKwSZfZdO/LIN7pgsz+8xl0gvFRme8pDDeg8OvY5kV8N/E0sqldYxlhydyOsXuIVtXuAxrzS7ptzLl6Q7fxzJe5FFm8oHIx6btw4kGoe/qFSFmhJqe3H/jOW4TiOZ7GITmDkmxjrMllWfjLii7Jzla9rSz0/Yj8tXFMBdos5aI6G9mNSKsc+ZqVllMCWiALCRM8mHLJIcl8AjMFbBLnq6nxtONTiE/Glh6Y1f/+9cZlUDoGnWZUK2+sU56NAA2gi3v8DL9I/OmV/0D3O1oOx+fStrhmcLdP2TkNtqNRUwxOQWbbmLUewVvn9rbgS6/wV0AGt/NrycDPVjA8cak1lXV60Rn2N441JNRtIJ1VUt6rImZd3IRtNUPdDAzIyPS5uyMGIXE4wZGLOQlkODvrL91OB682jhxugoBxrV2i6uRnpWlooJnpnIRQOr2G4+KJU/FeAXTZmj9lox9eIXcRFQfjYWWFagc10xu5bqPbPs1yVEC5OFBbkjj5JHcuK7ew058j5qogjSKSgbKW9v4W3YkZ5EDCmiTZrnZi7IOgnz7KryX6bfxtir1AXvedhOeyYYohCRc4pBrQ+xJpbhLp2Dd86gZmRvELayjJMcUnydcEoXoIe37jD+RuI0lCVEIvpaXNPyIon/VSDqsSteA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199015)(478600001)(83380400001)(33656002)(66946007)(66556008)(66446008)(76116006)(66476007)(4326008)(64756008)(8676002)(54906003)(316002)(41300700001)(110136005)(55016003)(82960400001)(38100700002)(122000001)(38070700005)(6506007)(7696005)(71200400001)(9686003)(186003)(26005)(86362001)(2906002)(52536014)(8936002)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rLpQFmctlIb1TBA9lg17cGy5orIbbDwaIVYOpp4AjCi0Ccfvj3P96VfwtU2+?=
 =?us-ascii?Q?kUfYWbxSS3TtZ6dTkGJMJK6fsp9rdUTgcj1KhCDpiSI4fvMrEWfBtqmaLDvo?=
 =?us-ascii?Q?31zeygYgUTmDCSJLf+hihV3cxpcqlqpAA0zMtvKkqL10omS1l4ZTMmF4emKq?=
 =?us-ascii?Q?vqXb1dfR91400mQ9ITYln5D1SZWECoBudQH1b8PHprHcmgpfN0tOExYzGE8S?=
 =?us-ascii?Q?wAx0UhBm01F1GHS7Un58YBr69/o6Dnowg9NGq79pE+k5+0y884WbMLSRqb7z?=
 =?us-ascii?Q?kg0JqUGaL0QGZ5Ahy2gFvWABKEmGITMCVSqGmIWyhyuXH4/O/TYDP+3p3/Zx?=
 =?us-ascii?Q?GhYv5r2f7nC/I3gCIN5BTyA6Y9sh0VlDs91UcUVLlnlj50IhrJlwO5Ij0IVM?=
 =?us-ascii?Q?sVxrs8Zatazb+E7KTzXSChuCwAFnjDhsFvngF54cKG6Yv+VYCmaBrIGpCGsK?=
 =?us-ascii?Q?9fjj1J4Ug1k3InWh9/T8iJv/iMIuiXql5CL0xA9rbQ9/KRro7Kxnz5ZX+zvw?=
 =?us-ascii?Q?wbvf3cN65lh+RL7w7GCGomGsRD45iew4dOrjrWBulppFjNPmYnJszJFRWCvO?=
 =?us-ascii?Q?eJ+gKgsQbnBxkkUwU1xOFELm8u12BQ/86MOE8JqkpDXwqzSm1TqcS7UvzYvR?=
 =?us-ascii?Q?5Wv0J5VdcRSGXT54HSX9X+pdlgFmCENLn/pX7chMVxvaSeRISb6EQpQq/udT?=
 =?us-ascii?Q?OhVbgJMZfGIR0fEpv5Qgg7KT2DPVWY5/eqCvY8Sl+JbQ6seoITv+NeGcj7lh?=
 =?us-ascii?Q?Nyjsk0t1sKrylptORw8MmqGOSyrqNs8MBjD7wXDd6n/neGurm7aXK9n+fkm9?=
 =?us-ascii?Q?bkkIqrQ9VwO8zIhA5a2wUuYO/Rvkl+nq2bw19ykF1g4nnPXUbVmLgZtEgBWl?=
 =?us-ascii?Q?8yq4vPJfQDbL1fbABsz1Xv3KtYN9hfNsl3K31eNRgfYcTu/j7RwhqLA8+Kub?=
 =?us-ascii?Q?A2Zei56vOmDoYxn6eLB5K41+Hl19n2eEDJ7AG/Ebc/lJ8ZMm9fe0On9JIhHB?=
 =?us-ascii?Q?OVg9JNV8hWBXbbFPJwsBnkpih+pCgtBAOzrWBj9Bd6q9QSxMHBrmIpWSxnVz?=
 =?us-ascii?Q?GIDTU/wISiV2Dz0CS3JYE99B9yqs1nSBnnkzftWl6I5ty3yp7K8alZOydCjF?=
 =?us-ascii?Q?aIdWbCiW254gtEURHLS1isiY/WptGgJojFx++/cYP7zUPFY1C5u77vzLNEXL?=
 =?us-ascii?Q?RWq82OBLSBIZobAOYYpdyDEt91f5TtUtYMtDiE9K9sahJtR4cHssJ6BEJTC2?=
 =?us-ascii?Q?4hubFBJ83xVg02C10ZwSYNA4u742ngSiD/nHAIrtFOCm/SKm9T7P4ToTrGgk?=
 =?us-ascii?Q?DQXm3QF+TdTg72eTP+6onZQd9ZZ5CDxvm9M1Lfm7d399iBuNMo4wmCehn+7n?=
 =?us-ascii?Q?WKXF0MUesNM79V19ZiL5S5QikxX+gcMTxxkMZaVCMEIcwqTTnklcsR/xGaks?=
 =?us-ascii?Q?zYeaXqCCevPyGVAzym0p0tIm60dG2Cofd13AzLxMlbHoKPuk1rtU/4s3nsDB?=
 =?us-ascii?Q?jPHjR6DJnIwgDoNEBOeup88rvdaueURkTtmLSg24cl5B7wPRenalkGV/Jkzb?=
 =?us-ascii?Q?ZETemKuuaRY5IgnCmqdNFbn05l8YrXLPPsTBOtxK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e922ebb-e436-4c7a-7b1a-08dad0e2847c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 01:47:32.9658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B2Q29ZXyoic2xBcRrKBzzm6hsHRAmm5a3LE+tQ4eprg84jl2zDgLiWvkUAoJR1roXB/i1iBqaeEJ7+lDPsR5lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7372
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Thursday, November 24, 2022 4:36 PM
>=20
> On Thu, Nov 24 2022 at 01:07, Kevin Tian wrote:
> >> From: Thomas Gleixner <tglx@linutronix.de>
> > I looked at it from the outmost invocation:
> >
> > @@ -436,6 +436,9 @@ int __pci_enable_msi_range(struct pci_de
> >  	if (rc)
> >  		return rc;
> >
> > +	if (!pci_setup_msi_device_domain(dev))
> > +		return -ENODEV;
> > +
> >
> > the current style kind of converts meaningful -EINVAL/-ENOMEM/etc.
> > into -ENODEV.
>=20
> But go to the call sites of the various places in drivers which set up
> MSI or MSI-X and check whether anything evaluates those error codes in a
> meaningful way.
>=20
> Some of them print the error code, but that does not help much because
> the error code does not allow you to pin point the place which returns
> that. If you just analyze the pci_alloc_irq_vectors_affinity() call then
> you find at least 10 places, which can return -ENOMEM. So how is that
> meaningful and helpful?
>=20
> All it tells you is that some memory allocation failed. In that case the
> failure of the PCI/MSI[-X] setup is the least of the problems.
>=20
> Where error codes are mandatory are user space interfaces, but in the
> kernel a simple fail/success like we have with many interfaces which
> just return a NULL pointer on fail is sufficient.
>=20
> Just because the kernel historically propagated error codes all over the
> place does not make them useful or meaningful.
>=20

Good learning. Thanks.
