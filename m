Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7149E62D2D3
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 06:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiKQFhB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 00:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238813AbiKQFgx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 00:36:53 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBC965E66;
        Wed, 16 Nov 2022 21:36:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXrmmnL9x883vkfQvnrqiAA1cap8VNjJxLSX1RgjRNLdZ9JqR9/1cH1ILMKgT2gLnny1a/T3z65rxtQAP0OlhkBU/d9axhkWLTb6DZ+IiUppktK4w3XlnBmIuZe+QfMo22AihemdnE/eGOyT/08aD8ToJiuX4waAQyI6p87y7KoN0LlvWAtNhOUj0IqF4lBSzC7APqJPI4saTq3zOvELn7N/XqVd5heKAq6/VcyQk5xE8DJi+BBYoyap8t8t6cGhGuiFV/0D+qFew4DSRLfVyATPtK4+EgON7i3qN9u/F5snuJnYlXmDbN2zDUrxtDDBz7Zy+e4ZEOgawAwHzovt/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2rZjv1muKoQ75EPaMTvgbdRGnISIYWyxTGQrZwQmW4=;
 b=QYH8HiCVcgq/Ha9NewbMLhMlaRb5X6mxVybUI/iMJm9fooa2CRwX7tdbUthWgb6tcCThlgksBDLAjq0nAFD3CHQYAp4WFGK8+7+QUtJmny2n2P1HarM0vcMfrryOu/Bsh6ZdIS2Sa8ZG5BcSBZeJuXPXd5jFhdpcBwv2UCay7h8kED2JsBS4V/WxHfu4odn3n0aDIY4bCfjfA0C9eZ/0h0+Tk2azKuoicd3mV+ZpdIhmcXhVpvrOSPOtWK0ombPfLI/v6TepQ3Oe/tMX7hO08TG3tFlE2kR1FxCIt3QI4vI2H/AqiihgP1CCfe4n0Nz770u2g8iSmpWKrSiMBya+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2rZjv1muKoQ75EPaMTvgbdRGnISIYWyxTGQrZwQmW4=;
 b=HiW2Vh4pPv1KNdHRR/CQZXXOSPFKMjRgsXL4Eu58+BUaXCWh14J+CK04XBkRrgOX9aEojE1A0Zbfc8NRMm6xRLfNcf6IGkuDsObJmPXEOLweyf54Q3WQs3s+h9nEFHkFwyEjrhrMrUC1VrwR7ds46KqxbAIwELZ3IKSYZbQcfAA3Q9RNDnVUlZ9SttmurWQcp+jqzuXHBppfM7eqPY7jRmLjo0C6vm3dhrWKdwRpP+o8BqMHm3zM6XzSy5sAR2gCCR/CrnNBLY3tLGs2watrh+D1HgKo4pUaHoowvz97W/OVYwQ20lLQwwaaQonaLBOdOj8LlgAjsQ/OW2vRUYmtPw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 05:36:48 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e%9]) with mapi id 15.20.5813.018; Thu, 17 Nov 2022
 05:36:48 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Lukas Wunner <lukas@wunner.de>,
        "Michael S. Tsirkin" <mst@redhat.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Wei Gong <gongwei833x@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2] pci: fix device presence detection for VFs
Thread-Topic: [PATCH v2] pci: fix device presence detection for VFs
Thread-Index: AQHY+azcrod+74h/3Uu8O+dTpgCVf65ClPqQ
Date:   Thu, 17 Nov 2022 05:36:48 +0000
Message-ID: <PH0PR12MB54811F4658F068C46E071E81DC069@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20221110144700-mutt-send-email-mst@kernel.org>
 <20221111234219.GA763705@bhelgaas>
 <20221113034519-mutt-send-email-mst@kernel.org>
 <20221116111619.GA5804@wunner.de>
In-Reply-To: <20221116111619.GA5804@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA3PR12MB7783:EE_
x-ms-office365-filtering-correlation-id: 97db25f5-bf88-4fe6-0de6-08dac85db8d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sBGGsf8pG0J2oRaYP2ibJdLngiKW0jNLWJ1bo+fk4Z8MHJ4xegVelPuMS2sVnxj9Iqy+iPrYcnHi260uYL678r0y0SEHL1xp3ZhcW3RnPC0EefTbd8rOOM6wajy7enEpFo+1AAvyHmDAVFoSGdlhiC30ZlVDZtgkrdfKutfFx8tnimmLwROPWhqV02b4sNkM2bDnz3zKI4uitgBMznWShOpMjnV3dGwAmRHrx+Wg9aOIuiSNp8x2tK6YrrMuBkt3lIVNGZGVBLUhE4ZLiVpTn8073/XfzYKKpJ9Mnbrf2sXx5buEpdbkTgNdM8355znsJwFfLo0lHRIt8qp9fSbMqt27UYc1OtFblrvv2Qo/pmzkV1SCFDax0YrzSppuHgmGx0TFBGhdKYBD4VYKQB0lPZa2nYHEA1QbNrpVcGCJsXtevPs9ahpiaItlJrh1tsqB2KTbXqAkT2mGI1LL8531p3cehyW8yx7+r5xUPcbj9hbTDD/H4+qB2uOwtclpkmKOBjyN2+/pM55EKsyE1ME73iO2FsEv8Ud9KO5CRpbzUVT7CLaHEayssuJV3apun6QvvY7RQGCU3DeAxBFEJsF/3wibPgIr/qkahYBHBzusi7eF0ip9PyoxWELmf1TRL5d5rFj8E0PKemRbNjnI1cA65Sfw2fJLKY4qXtXWf1JlcyLsOAPrraOmsSFEcUgYqdFOJMcYceULmnUwZ7LunvX/9EGc1B7DrxWOiN0XAhnXg4d9f0iBqrIBqyW3UlNzDpC9O1z4EsMZ4XN5g1ZntQVAIgduYyZ8gR8Y6PmioSXNabok28tZqxWGn/NsqlSajFNuev+NsWH/ICjO+wPDF+c/jQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199015)(66899015)(33656002)(86362001)(38070700005)(38100700002)(122000001)(186003)(110136005)(2906002)(9686003)(83380400001)(41300700001)(6506007)(8936002)(52536014)(966005)(5660300002)(478600001)(55016003)(7696005)(54906003)(76116006)(66946007)(71200400001)(66556008)(316002)(4326008)(66476007)(8676002)(64756008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CeSr1bPx1dND2qcOpr/VVOU72Wm4+YNtDyGPZQ47hdDiP5t6TceLN9O3DZ/f?=
 =?us-ascii?Q?dwsg2ARuYCO0uOEO2HBA2d9CoDcKvE04Xm5Ylq1mnOkzWesYLgbX2G4hd5tU?=
 =?us-ascii?Q?MrYchXEPpPihvE9OyhgWMygoHlJk8O8lDSilaV2cucx9obsEjaW7fngymYQ0?=
 =?us-ascii?Q?Z4MZ3RLBWL/4Y+4HcNNJxxUgG7qLstlQPYUMeKG6j0iKMZ1HP7qop7RND1jE?=
 =?us-ascii?Q?9BQj6SGqGrdvHj6u4oWCi3ojLDd0dI8gomAmQAhwZSY5JTT+bYSYECpQKzdd?=
 =?us-ascii?Q?JvRzNB5piDR56bgAy8RkzPqQBydHUjUxYCt7Ff7S4R1XMLZ9UyxUxFOOr6ul?=
 =?us-ascii?Q?hOsdQLuAlXH8BO/IwNXc+uyxS1qTnLzFJKTgfl8T73JzTzM6dKYknSHuQ6YZ?=
 =?us-ascii?Q?s+thYPBuEVk/aV+GvyzQ84CIC0N/GB9iXcSJLDiPcnEQganiYFC2bIBM9b0s?=
 =?us-ascii?Q?aFAJvMaE7S5/A/hHklr4/AL166dYv+IHbPj1fCAPg6Q9Ec3GbmLKQXVEjNyv?=
 =?us-ascii?Q?3n2xSFyYSYE4zBXiCPWilSrcRTRG/VtxrxSE9m6bJ+nXbMCykGIpSXiXZQmY?=
 =?us-ascii?Q?5RrFZR2LoQdBYuYDhK5hj91fv06soXqqcvf1bSGvrN6dBJkVvkdoB75OqT5q?=
 =?us-ascii?Q?ykpCupvsl+VtKG6Y3JhPJTKI+c4adDoyJyzHluRHOrBMaXa2TRK03f3sQI3j?=
 =?us-ascii?Q?OdfJifZR19NRGO+UlMHF/8j+k/jeDZkxJuwLxlx7ee18pngkH4Eca/IZLB1F?=
 =?us-ascii?Q?pOxIwHq6qvVGTaK1HRRWDVXN6UfbC345HXkx2AugI78sgbiQMs8KyErOC4+z?=
 =?us-ascii?Q?EMACtuQ6TpUTnn0qYD12TaUVkRkw3T6zvqIQV1VMsHfqFIUo8ssD3MYilqW6?=
 =?us-ascii?Q?NADdzJlJJhmLw7SUmvSDNwmYfxdf5Ji0SPSATlG9OYW3oC9C7b4PY+imwrWr?=
 =?us-ascii?Q?9d3lHR6o0QaRAWjpulPAytLURsJsui9lzgR/ztuPzrjk+yhaI7pRWfy9AX/T?=
 =?us-ascii?Q?cNYde50L5vKU4EIUjDP7Dh+mPJ3uvLS3Nh1HVSXF7wtS69mBtb/0FRAPsGKW?=
 =?us-ascii?Q?nUMRVJ6GrKTV4Ja/8sHfqei23X2ruGlumbS5/I/CTIEAbEZ7SNmoGmFCFMHo?=
 =?us-ascii?Q?Km6dhWhVEHFem0V3zdON6LYyt8rYlmmhVCxgU5Zz3AGnKR/2qTyFrnhkKt1A?=
 =?us-ascii?Q?zQ9tHESbWTXUQfzT0uOFpUY5aUn+IV5g42ktzCEFoGN/LrXTts7dAfntd8CK?=
 =?us-ascii?Q?wKd84Os968caVt8bbHjvI6TL4NbRy7w3BXsqExTDZ3Ld1jpUuTqYBAvTG+qV?=
 =?us-ascii?Q?m3hi+N4p2ET+VfNYm8oy9tZViQI42ulWslIXERTefYsS8JAZvt9aNdWaZ9zK?=
 =?us-ascii?Q?hTEAfglizpwFIg2krOkVKxmqMIxDrtA7SjwTWAnoVxMe3kICRqCEev/m2oiK?=
 =?us-ascii?Q?UFOKB6nBojGrOOuk/9yut7CMjvDPWtU11dLuEN4YoELyj7WLW4hPj+tD/P+k?=
 =?us-ascii?Q?5/b3xMnAsTB4Iw95uhd5vW/6A9cfwlZ7OxfwKPZw1O//ZnJxhW6cSt6DRuKz?=
 =?us-ascii?Q?AfqKQVaPoY03rRhDM8djCdq3ttwbVxZE8W13fqdxNiUfDf4wEWC7VEaIG+6c?=
 =?us-ascii?Q?VgHkh0Y7YbRfi7ZTJymyK18=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97db25f5-bf88-4fe6-0de6-08dac85db8d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 05:36:48.4714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: edkMjWAErNAXq4p3aHHY5qq/C7LrnFeiMA6X63vbF1lykp5SBtQXj8gwh0rxNLkOfP8nvuUwgn/SkOlTHNUttg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> From: Lukas Wunner <lukas@wunner.de>
> Sent: Wednesday, November 16, 2022 6:16 AM
>=20
> [cc +=3D Parav Pandit, author of 43bb40c5b926]
>=20
> On Sun, Nov 13, 2022 at 03:46:06AM -0500, Michael S. Tsirkin wrote:
> > On Fri, Nov 11, 2022 at 05:42:19PM -0600, Bjorn Helgaas wrote:
> > > On Thu, Nov 10, 2022 at 03:15:55PM -0500, Michael S. Tsirkin wrote:
> > > > On Thu, Nov 10, 2022 at 01:35:47PM -0600, Bjorn Helgaas wrote:
> > > > > Prior to this change pci_device_is_present(VF) returned "false"
> > > > > (because the VF Vendor ID is 0xffff); after the change it will
> > > > > return "true" (because it will look at the PF Vendor ID instead).
> > > > >
> > > > > Previously virtio_pci_remove() called virtio_break_device().  I
> > > > > guess that meant the virtio I/O operation will never be completed=
?
> > > > >
> > > > > But if we don't call virtio_break_device(), the virtio I/O
> > > > > operation
> > > > > *will* be completed?
> >
> > Just making sure - pci_device_is_present *is* the suggested way to
> > distinguish between graceful and surprise removal, isn't it?
>=20
> No, it's not.  Instead of !pci_device_is_present() you really want to cal=
l
> pci_dev_is_disconnected() instead.
>=20
> While the fix Bjorn applied for v6.2 may solve the issue and may make sen=
se
> on it's own, it's not the solution you're looking for.  You want to swap =
the
> call to !pci_device_is_present() with pci_dev_is_disconnected(), move
> pci_dev_is_disconnected() from drivers/pci/pci.h to include/linux/pci.h a=
nd
> add a Fixes tag referencing 43bb40c5b926.
>=20
> If you don't want to move pci_dev_is_disconnected(), you can alternativel=
y
> check for "pdev->error_state =3D=3D pci_channel_io_perm_failure" or call
> pci_channel_offline().  The latter will also return true though on transi=
ent
> inaccessibility of the device (e.g. if it's being reset).
>=20
pci_device_is_present() is calling pci_dev_is_disconnected().
pci_dev_is_disconnected() avoids reading the vendor id.
So pci_dev_is_disconnected() looks less strong check.
I see that it can return a valid value on recoverable error case.

In that case, is pci_channel_offline() a more precise way to check that cov=
ers transient and permanent error?

And if that is the right check, we need to fix all the callers, mainly wide=
ly used nvme driver [1].

[1] https://elixir.bootlin.com/linux/v6.1-rc5/source/drivers/nvme/host/pci.=
c#L3228

Also, we need to add API documentation on when to use this API in context o=
f hotplug, so that all related drivers can consistently use single API.

> The theory of operation is as follows:  The PCI layer does indeed know
> whether the device was surprise removed or gracefully removed and that
> information is passed in the "presence" flag to pciehp_unconfigure_device=
()
> (in drivers/pci/hotplug/pciehp_pci.c).  That function does the following:
>=20
> 	if (!presence)
> 		pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
>=20
> In other words, pdev->error_state is set to pci_channel_io_perm_failure o=
n
> the entire hierarchy below the hotplug port.  And pci_dev_is_disconnected=
()
> simply checks whether that's the device's error_state.
>=20
> pci_dev_is_disconnected() makes sense if you definitely know the device i=
s
> gone and want to skip certain steps or delays on device teardown.
> However be aware that the device may be hot-removed after graceful
> removal was initiated.  In such a situation, pci_dev_is_disconnected() ma=
y
> return false and you'll try to access the device as normal, even though i=
t was
> yanked from the slot after the pci_dev_is_disconnected() call was
> performed.  Ideally you should be able to cope with such scenarios as wel=
l.
>=20
> For some more background info, refer to this LWN article (scroll down to =
the
> "Surprise removal" section):
> https://lwn.net/Articles/767885/
>=20
> Thanks,
>=20
> Lukas
