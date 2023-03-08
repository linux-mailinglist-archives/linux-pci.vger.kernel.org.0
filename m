Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BD06B161D
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 00:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCHXFf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 18:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCHXFD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 18:05:03 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74AE888AC
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 15:04:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzbBKqv2sgfNA1STlJ8lcpSW8lYeZxh4cuJbP6rDM86VcoCzV0T5Ga+QEZ1JChZJf1KyuZ7n4oaaUHjUkSOLyCDRLG7dnCpqTu0LqjL3mp4uR9bGor86KBtRh8igorofw0s+8aYenhgdmR8tITMYfqnRD5l+2CKy+DMGEGqeM7T4oVYCx/6XA6MGK2XvSgTl84Uzcl8tHzG67ULEu8LWkflMqGl8kwU3OTm/8U5lsl9BLY/EC8E3wy3fMi8TfVOqwJ90UOz6kIgNFUUubfIu6P4ydvknNYc+6VP9J5tF7UtfEYccywb4n0+6fJAfYLTmO8b3wt8yriEegslO7XYfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4E93Da/9nWv2PaEZcgge31ozBRK8naWHZ309JbhP0E=;
 b=gme0GLn+Q7WTjWLz8KxMc819vIzrx5gmeUX3xugkBlxcEWDi+0r1mmogA769/oeFon6FkbMyDpPdoQoK1javyAye3XIJ/bpRKpPtDyy8QVFBhGiUNHErMwCCR+up0qRmTPEw+7tm74kqFxTCvN8gxxH4fQKZP5Au4iY0Ojfqe5j7GlwQb2EjFsaDr2P9DUaKnN4Se10i2+jxzk10h3dNroNZII1YuDLIHyZ0rDqwkGgB06JHAJztrYSfANWizNVOAgG/LX2qytQ4i6GiO0VxP8m1Ongwd7L6VF0REytY8yj5MsbteI4lyRc1fDlhtBHDYyEjl9UaqmYrh3OasFOF4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4E93Da/9nWv2PaEZcgge31ozBRK8naWHZ309JbhP0E=;
 b=IZlwe3vUDgLFefgWKDEWGepTi8QfS9P6527L7cH2pdGpavjzV76q7KTdUx72A6+e/ORdpmDoCRTwsd8VcyFSxg+vj6l+3gQhaPuO/c29Sy1+RgQYLgSY8JxsfEAOjhykggZdBOdlBewuicv2Gv/pmqyBIBb0rqg9RdVm6Ygumi0=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7756.namprd12.prod.outlook.com (2603:10b6:930:85::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 23:04:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%9]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 23:04:19 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thomas@glanzmann.de" <thomas@glanzmann.de>
Subject: RE: [PATCH] PCI: Add quirk to clear MSI-X
Thread-Topic: [PATCH] PCI: Add quirk to clear MSI-X
Thread-Index: AQHZT/y1Z53wI/N1kUuWSAR9Qbt1I67xfxoAgAAC5BA=
Date:   Wed, 8 Mar 2023 23:04:19 +0000
Message-ID: <MN0PR12MB61011CD561076CA23B17B813E2B49@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230306072340.172306-1-Basavaraj.Natikar@amd.com>
 <20230308224428.GA1050977@bhelgaas>
In-Reply-To: <20230308224428.GA1050977@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-08T23:04:17Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=395d2a72-ccae-4fb7-99c2-3a987017712c;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-03-08T23:04:17Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 7b80ade1-8f1f-4b9a-812a-f8fa516b0d50
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CY8PR12MB7756:EE_
x-ms-office365-filtering-correlation-id: a1f24d34-8710-4b7f-43df-08db20297292
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PaC/crKYf9asq4IQ5+TDq+QaGeBc12azNEz24bLHs/rClzdhECmz1RXDCdAwc1vmR92LUFR4xvhRPv5duf/umKYS9lOu6eQ3MR5Otjzn3LlRpLARYfKNehcb69fRlowXCP2qkQuP273hfzlmt7vWZ/lS12ipw7fDlTgT3A3ANt6dCBmsos2OTLoyRaZ8dht0DUKAHC66/oLqJ7/amHUdshmcQiDvuhTplIrijYxRqcDzGKYzIwIGMm0DYZh58OgvzfeX0LE/Oboeh4FKY6I9809/YfQavIZibe0yWj6/W9zsTNaG2MrbWVHs24CgeCTBLQh+r9lMreQvXLqMokVwz+AJrUlLWOvxf2tXryC9WD70iWOfRPLIamxVDyR5zXWpzanu8LSxbOZXUNWifyl4pFlNaNpR5CTqTpuZb96EIInwNmdJAasC12ah3NttzhEa3D6/6nA9r3oIspB3k31b4CFWPWGMiCn9LxdMOAdbc7Mm6g4VN7kntGhDI+GNirgo5yJhn77ZseCSQvli0qDZtFAPvh7L5ZQ0dS4qU9FpGi7mCW4JQTHqmuyMK8TdFZcHF0jvNoJUWD5nb6m5RArXVcJMDCwoB73bP6Cy8a+6KSM+yo8wy+GeIsS/pILADm2rxpAnisOLSqKDmTtXkCQLsBRR+K7m/HyhAWcGViWBXKO74dj5J0nq6LZchu+g42/F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199018)(4326008)(33656002)(76116006)(66946007)(8936002)(2906002)(41300700001)(64756008)(66476007)(6636002)(55016003)(66556008)(86362001)(5660300002)(38100700002)(38070700005)(122000001)(66446008)(7696005)(8676002)(316002)(966005)(478600001)(54906003)(110136005)(71200400001)(52536014)(83380400001)(53546011)(186003)(9686003)(6506007)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U9OmHYGn3I1IwSRAe0CGwJgZCV+cFTf1yWMF+nsYssjgFCt5PT0XTBBJ+gyw?=
 =?us-ascii?Q?Hn0RdQGE//niVoJkR5lqJt9+N5IuM0oaACffzDbBnz4yvZecJr3TJ+nggA3G?=
 =?us-ascii?Q?nYfUSWcM4dcIQ/1hMo0LSXef7OcBBy0FmHn+zswyXDqlOb931sB0JevD8wlZ?=
 =?us-ascii?Q?QNySRgyOttviyy55/VG69Ctrob6ReQrK7PTEPQYzqEbvKZzxAbYCtOqDK+zS?=
 =?us-ascii?Q?PC+SiFAPiUT0N3tdaZqiiFccn1B4ctbuctOS9aLFF0N/wuFxEIcCmoVA395r?=
 =?us-ascii?Q?aKxZDCRFYyX8+AYBszUZGTmcB00+T7JNEA/UjPk9l5v1WNTEpu6C4HdCLzXp?=
 =?us-ascii?Q?f4tZsdjMMtSrNs8pWN0UOGdvHocY2nvStN2AyarrEZGGCvEl3/1+VtdVLPtv?=
 =?us-ascii?Q?J22y0ENR3ndzRYfzLuHdxbqcvwRHQh6YR6tNz36SL0x/EuuWt6Q7Q+iX7vEc?=
 =?us-ascii?Q?l9jGHscLc9uU8pFaI2diyTT2LeT/I/dDOXBNTbYqDjK/Va+SZZfTPfnsMoMn?=
 =?us-ascii?Q?JhTrHIm64Bp6G+kaEihEZn1o1wrcR8vP4YrFAse/lkdukDEdyBd33Btiv+xt?=
 =?us-ascii?Q?sqZbIXAjGh8AZN/uY5PxzQPvFFUL1NalpK/VtHcquigd9BkrnGZjanutNR4D?=
 =?us-ascii?Q?ym0Fj1y6tich1lVqw3DNK/AetZLdvB1+q5SAxy/nsOULm9cArIo0kXYNaaRu?=
 =?us-ascii?Q?9DQUK6yCI5PZ6SLY/oGiKltshjIu3LC0NGpVcMXQyNPS49iCWNd0Qx7zqNrw?=
 =?us-ascii?Q?jfTZ52ghakYvh7cm0aebTpv0QibQwCLjjUx7MoJmMunFAw0rg9ELJ1UqhUDp?=
 =?us-ascii?Q?nVmIJw/83DaNQvfgbH81D2WbuFFp+LFBdki9GXn+p0jMKR4L6rADejnKX77T?=
 =?us-ascii?Q?y3O3Rzh59tLHKbTAqGyMfj+lVg5kxOlYOBwQUOx+meGRpiHTJk/mMivx6RUq?=
 =?us-ascii?Q?PZmLJnDEUv+OzMrIOj3hsa4b1Ec48SSHjkYdE58Kd0OQV8IH3cGTzcU2i6kn?=
 =?us-ascii?Q?iEQfJxv3h0irEBj1GciIKnvWhDMfAr8t0Zimv1c5LP20E64QtT5PtcHdc2jN?=
 =?us-ascii?Q?4Q3611roQA1sn3G24mn1qx7csaGq2m1AU3PZ9OHIHPZnMAfxCVD6TYqdron8?=
 =?us-ascii?Q?sTHrKci5Jb3lEwP8No2u6OkQNMgKZsoNDvFPHeIdUUQf/ThIkRvhIkFGuM+s?=
 =?us-ascii?Q?P3IO+Tr/qj3Wrc7GaOt5K7jQvayPXa55ypnd1mNZwG7PR8OMJR8GjYUnCrkH?=
 =?us-ascii?Q?84VNFHh9PFHgBuj3i5FMFb3VhCzEtE/2D2Nu8yHLYroCKjz9vHrEVxFl/UvE?=
 =?us-ascii?Q?EsjyJ/TLQ+JiH4CX/096bWY9sc4Y3jY4/kadZIy3iknhlWeZ00+8qnqufVOv?=
 =?us-ascii?Q?jxQwNDYmxN7FPJuQWdDRFwou/xa5IOPAoVeilRpcWDyqbzTtOMRX2QwitArA?=
 =?us-ascii?Q?oBI1dm20Dzhw5lFP7NsUvmrGYBbkSHYULTzdz9Xw9UyEtS4N2OQmttVcI5+s?=
 =?us-ascii?Q?fpVC69IkOoUgDYpugRou87uFI7R/IzUSc9oIQyGLa2vX0PuVYwqsaH4ROBfV?=
 =?us-ascii?Q?wujNc6yo3FJ4rt3CF3U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f24d34-8710-4b7f-43df-08db20297292
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 23:04:19.0680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T96gP92Hpa586pDFruByMtZVH7Io5wS4ru3jNIAIsYuXKUD7wiM3JfKEWItCHj9lQGr3rsZWDJPmrmZqbDWV/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7756
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Public]



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, March 8, 2023 16:44
> To: Natikar, Basavaraj <Basavaraj.Natikar@amd.com>
> Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; Limonciello, Mario
> <Mario.Limonciello@amd.com>; thomas@glanzmann.de
> Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
>=20
> Let's mention the vendor and device name in the subject to make the
> log more useful.
>=20
> On Mon, Mar 06, 2023 at 12:53:40PM +0530, Basavaraj Natikar wrote:
> > One of the AMD USB controllers fails to maintain internal functional
> > context when transitioning from D3 to D0, desynchronizing MSI-X bits.
> > As a result, add a quirk to this controller to clear the MSI-X bits
> > on suspend.
>=20
> Is this a documented erratum?  Please include a citation if so.
>=20
> Are there any other AMD USB devices with the same defect?

FYI - it's not a hardware defect, it's a BIOS defect.

>=20
> The quick clears the Function Mask bit, so the MSI-X vectors may be
> *unmasked* depending on the state of each vectors Mask bit.  I assume
> the potential unmasking is safe because you also clear the MSI-X
> Enable bit, so the function can't use MSI-X at all.
>=20
> All state is lost in D3cold, so I guess this problem must occur during
> a D3hot to D0 transition, right?  I assume this device sets
> No_Soft_Reset, so the function is supposed to return to D0active with
> all internal state intact.  But this device returns to D0active with
> the MSI-X internal state corrupted?
>=20
> I assume this relies on pci_restore_state() to restore the MSI-X
> state.  Seems like that might be enough to restore the internal state
> even without this quirk, but I guess it must not be.

The important part is the register value changing to make
the internal hardware move.  Because it restores identically it doesn't cha=
nge
the internal hardware.

>=20
> > Note: This quirk works in all scenarios, regardless of whether the
> > integrated GPU is disabled in the BIOS.
>=20
> I don't know how the integrated GPU is related to this USB controller,
> but I assume this fact is important somehow?

This bug is due to a BIOS bug with the initialization.  We also posted in
parallel a different workaround that fixes the initialization to match what
the BIOS should have set via the GPU driver. =20

It should be going in for 6.3-rc2.
https://gitlab.freedesktop.org/agd5f/linux/-/commit/07494a25fc8881e122c242a=
46b5c53e0e4403139

But because these are desktop processors, users can decide in BIOS setup
whether the integrated GPU should be enabled or disabled and that
workaround won't work if it's disabled.

>=20
> > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > Reported-by: Thomas Glanzmann <thomas@glanzmann.de>
> > Link: https://lore.kernel.org/linux-
> usb/Y%2Fz9GdHjPyF2rNG3@glanzmann.de/T/#u
>=20
> Apparently the symptom is one of these:
>=20
>   xhci_hcd 0000:0c:00.0: Error while assigning device slot ID: Command
> Aborted
>   xhci_hcd 0000:0c:00.0: Max number of devices this xHCI host supports is=
 64.
>   usb usb1-port1: couldn't allocate usb_device
>   xhci_hcd 0000:0c:00.0: WARN: xHC save state timeout
>   xhci_hcd 0000:0c:00.0: PM: suspend_common():
> xhci_pci_suspend+0x0/0x150 [xhci_pci] returns -110
>   xhci_hcd 0000:0c:00.0: can't suspend (hcd_pci_runtime_suspend [usbcore]
> returned -110)
>=20
> We should include the critical line or two in the commit log to help
> users find the fix.
>=20
> I see this must be xhci_suspend() returning -ETIMEDOUT after
> xhci_save_registers(), but I don't see the connection from there to a
> PCI_FIXUP_SUSPEND.  Can you connect the dots for me?
>=20
> > Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> > ---
> >  drivers/pci/quirks.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 44cab813bf95..ddf7100227d3 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -6023,3 +6023,13 @@
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d,
> dpc_log_size);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f,
> dpc_log_size);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31,
> dpc_log_size);
> >  #endif
> > +
> > +static void quirk_clear_msix(struct pci_dev *dev)
> > +{
> > +	u16 ctrl;
> > +
> > +	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS,
> &ctrl);
> > +	ctrl &=3D ~(PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE);
> > +	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS,
> ctrl);
> > +}
> > +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x15b8,
> quirk_clear_msix);
> > --
> > 2.25.1
> >
