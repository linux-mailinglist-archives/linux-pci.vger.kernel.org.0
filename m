Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A67B6C089F
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 02:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjCTBiJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Mar 2023 21:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCTBhq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Mar 2023 21:37:46 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2357A24CA8
        for <linux-pci@vger.kernel.org>; Sun, 19 Mar 2023 18:32:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TH5DqBKtowzIDGETaXVon/u5SE3jxpPMYz27ihRhLrJzPzY0pG0Po5ub/y7ri1qZSEb+SAlQO/4O3Uzq3npjAasqUNcL8UbXiN8PWqczrwkBKXQUjjGGDFqPyauHRD5/eSlfPhofkM3xeCeIsvYNBueYd8YZS3jhP6Z4yAVjNLhUeceXARun5LpYwf/e3DMoG4QR4D1BNB3vzBMCr1GNZ4enF382SsrVqavFc3Ft2Prl63ptIXw2gh2DMVI9WAc8Ynq1C3vk5Zo0hV61gmzbUrFJi6S9eTAk9X6E7tcEM4lwI9z24DoK4n8nHJgVSvzc+CILazH9ewjTAHxr1LRYGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bbo/fIQVTyRg8FUpp/v122xJhn5QyQXTnrRO7ilv3d4=;
 b=Y1dGp1TEZzS8U2mOjyeqUe2nEjjJzdFRIwHMEtKf4JcNKjTEzXeSoAVO4ONnVwDPFX0tKZDp5ZJM66dSEd/4YfdXVW/uwZo+lH7TId/meWGBS/K8znBTK6IwBU/TW4DZzeKjFHIiDYJN7J2khUzc+kUomO1s65Ks24XJ4o34egmEeVG3ZyzSfEAiV+OZKu4+Pi+XBi7gj3nfKVTqi2MxPTKGfbodGZVuyVQmRgruW2bgDlpZz47gEkGQs+Z8VpT/uxT/6frtrNhDFg+LmIXOuVRh5b2PD2vXjScfU+2T4sBoixl/Uqm6fYqoeKXhF2wZ55wQ5uTdhw5Jcdna2j7JTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bbo/fIQVTyRg8FUpp/v122xJhn5QyQXTnrRO7ilv3d4=;
 b=JqrBkUxXR/DTpEHlZ9SjqTJoG2PP/9q+OeoLEdugjBxCgorsdNtE/NiKVelC7F0H+vcGiCfSKFS4vVZwWvAVEyHUUyjhEcKEgDw1qU8w7sARmTa2e/Vk+6MKVx0FdGisnNf4lqTyZ3w8qQjBE7ckD3ytlmZXQ5Mcf2SR88YfYF0=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 01:32:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 01:32:16 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thomas@glanzmann.de" <thomas@glanzmann.de>
Subject: RE: [PATCH] PCI: Add quirk to clear MSI-X
Thread-Topic: [PATCH] PCI: Add quirk to clear MSI-X
Thread-Index: AQHZT/y1Z53wI/N1kUuWSAR9Qbt1I67xfxoAgAAC5BCAAJEkgIAAtd8AgAACFYCAAEKLgIAAKQMAgAFkgACADltzEA==
Date:   Mon, 20 Mar 2023 01:32:16 +0000
Message-ID: <MN0PR12MB61017F7AD76AC3E3C296E6D1E2809@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <0e1bd2cd-ea0e-7f2f-3d4a-62e9dea892b8@amd.com>
 <20230310221336.GA1282150@bhelgaas>
In-Reply-To: <20230310221336.GA1282150@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-20T01:32:30Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=64d03c09-fddd-446c-95d7-feab2cb48186;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-20T01:32:30Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 0b9dd7a2-5b82-42af-90e7-4b6128f6f0c0
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|MW3PR12MB4425:EE_
x-ms-office365-filtering-correlation-id: 2a02c0be-1963-477f-3579-08db28e2f099
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: as6xVur4cRC5IqoyY4b+2eggHm0aMwvb6F1uCeziADLS1GRNKVDp0he5Rdfo9ZO+NyjLI78JaduMoQACKmYAoQS3JLr/fSZpxAdxkRoYdESdHFXHheTAUOjcvNCPwLOtvMMQUtyJxnbOzsAarXyiSn5g4B/t/txwlm9lmP6d8CMrWbIx0GCZ3hdizni5UbmzUV0qoZuDZ8ujybiCCzQwmatUxLR/nQV17CR3Nu5lYYO7bDJswy2GUdTUIxa2Nug7+uTfp6/heOzYWvG5/6jkWBkeQJ5pzs4WYLW/fugV+y/4aQT0E36g6utmk0AcUElKaa/LxqBevjq/XxbAb/RCF1+RbgYlHPjht36PirttIT/FOPUUntlHXx9SnzH9A4Ogi5lHvFvLfTog1OiEc4Uekj1J6oRPnafsUOmW0D9BHPzHuSRnJxIvlCmQg2Mmo0Wid11ja+5VwLcZYBv/KVASl/E3bkyA9OS42CTXzy7sEL/4mUFBdL5C/ppN75UVCmVjDVm+5WVcXLdahgV+asrlyMxWSoSkdUoBV4WSvquq39ntOK+/7sJSD65NcP0I98EiZrsa0aM0b7fG2NYU9yG2fJTA0RLDHCz/agLQZhO58tShCRjfzEMuZVtI+HCpSe1zHcRjGj/aVXpmq11j8gVtSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199018)(7696005)(316002)(54906003)(478600001)(71200400001)(64756008)(8676002)(66556008)(66476007)(6916009)(4326008)(66946007)(76116006)(66446008)(6506007)(41300700001)(53546011)(186003)(966005)(52536014)(9686003)(8936002)(2906002)(5660300002)(83380400001)(55016003)(122000001)(38100700002)(86362001)(38070700005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QDFf8w4pelfhqOsjd2/bKUI3SyqJX26CoWIECT6R0cz2XCag49koDtsb6dXy?=
 =?us-ascii?Q?KLdCj/mBS6O3lOXlUkjKhgIAA99ZRjaRWhSj6ca9gLOih42W+/p6JDU3tHaW?=
 =?us-ascii?Q?MThREMCNEsWdDnHrgtBs5OGEqID6Lqsoi7huwZRMgXcSYjos7T+vdSY6kIGI?=
 =?us-ascii?Q?83hotvm/VyoYxOY4xWn34dKYBSS2X/WoOVTl+m7XaGkO1zGu8euGtOmwytJR?=
 =?us-ascii?Q?RiLnfViQBS8ttFuYhpUxXRj9TfYULAuupukcAZu6vMTeJw+IrHV01KyPFLhK?=
 =?us-ascii?Q?DdjtSXhFrGKsf46Y52VkUJPtASNUKbgeDppK9e61dMn1pyAWNg8bMkwoDic6?=
 =?us-ascii?Q?g2Wch3yxjCCq9NUnlLn4vDxNeYgd1VhQOhh9SMOQdx54x0bi+qD9Z1ZL581c?=
 =?us-ascii?Q?QOQSJ4nr1oAurYCyKzHqFr1b0qfi+1oryFFzOqyH9x7qv/LLrw9fk82y0+hp?=
 =?us-ascii?Q?232bZcJ/GHYFRN81L0Kz52dX6aXRaTI36Sn3ivqFNxSihd6PTuGznri+Z7Ot?=
 =?us-ascii?Q?REW3J3GpwqTeC+t3vuRDPUnp7gopll1G0afYkEFeEALLKjVvWy2PO4vTRTDy?=
 =?us-ascii?Q?q3sCDKHIyYCaP1qVgNGz+1/y4r5SdnEJsC/63pypvAXPEFXkBDmmI236GVxw?=
 =?us-ascii?Q?YxrIvjfcik3hTt9/x0cVsnnGqKsseikueN3H9WzKFNflWfhhHEWiFuKUkWcE?=
 =?us-ascii?Q?S7aL0e5ZwrLKMwBwZ2NB4IVPt4DRdjfeKMFyxYEF4VfE3ervGRUlbSVpNGmO?=
 =?us-ascii?Q?SWJg/owP8gXSMCfqu2CFnqYac2qOQudpvvyupk+4tKEl1rYOXQhwzBOFkDl3?=
 =?us-ascii?Q?S029z2J8j+0KY/UXDP4KRZtCfDMsifMZ/pJViHIqdyP7Kg6cbQfOGW7ygJMi?=
 =?us-ascii?Q?1Y8Tnc1AISZq017mSOX1AL8UmLPXryXv9bD2xfNsNdBWmtQjx3GVbEKelaLV?=
 =?us-ascii?Q?35WsiHfGCxVSRFkc/JuviS15d+RWE//nBKoTMHr5iZw7bWzbjqnAW6JoccbP?=
 =?us-ascii?Q?HiAmv3XdKpUdI3sQuee2mqZDdul3DwErmdAiWLgVxDDpAdfHeU1PxD3TpYfs?=
 =?us-ascii?Q?+P6213sq+RaViZkMSHGECN14BdPEkK7fZvjblX9rnAz1Ahy2MCw1nyKwrP0A?=
 =?us-ascii?Q?+XpHvpCs/qgnsWQQ0VdYySu8xmrDF+NrlX+Q9eZRo1PwNKsS9B2G/FG/gRRl?=
 =?us-ascii?Q?OE+hP/lT4wdnlJ9gk/gPcdoMjwdWLp8gWgr1wi2EPqueNXWO2u5//VMbmonZ?=
 =?us-ascii?Q?N23XKTaOSPK/PontzkmlkXvb7s6ncs/Xy/iY5Uc4I9Lc8H0WGatJuDN68+bE?=
 =?us-ascii?Q?lellhSsc4jkShX6qFr+dqqzHsbNL/s6whC+vvKBih/Bz6R7f6/Ii5rhBTDs3?=
 =?us-ascii?Q?7PgsUY6RrBt5Iidbxrwh5RN8Iydy8Uw7Oe6/8C4nlVvG3fYe92u/ohtoi1bD?=
 =?us-ascii?Q?N4Y2VCJ0sn55ysOh9GK400EbH6RehCUXW0yJMljHy4nokOb1NIksYX5qI2FJ?=
 =?us-ascii?Q?BENXQM3okvVhrrB2fmq5iAJAwB7zsF9EMlElWDZUzclc+3qUZzxBWxockypC?=
 =?us-ascii?Q?gyq6Tx9MFcAAYloMEqtSo1xSNC/iEBBEbnXJ2xABXpTJJXjpzFGVG7ZZa8AU?=
 =?us-ascii?Q?2htWxohwDSlQEz9ezQWnBF8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a02c0be-1963-477f-3579-08db28e2f099
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 01:32:16.7193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M5Nw/fdXXJZt2QCNFgwCTDa79+JMwYqjBizOjgn13jz8uOJkYZm9fMi2xpHcnSUFTCQjUTrcSshaSm3kJvr4bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, March 10, 2023 16:14
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Natikar, Basavaraj <Basavaraj.Natikar@amd.com>; Natikar, Basavaraj
> <Basavaraj.Natikar@amd.com>; bhelgaas@google.com; linux-
> pci@vger.kernel.org; thomas@glanzmann.de
> Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
>=20
> On Thu, Mar 09, 2023 at 06:57:38PM -0600, Mario Limonciello wrote:
> > On 3/9/23 16:30, Bjorn Helgaas wrote:
> > > On Thu, Mar 09, 2023 at 12:32:41PM -0600, Limonciello, Mario wrote:
> > > > On 3/9/2023 12:25, Bjorn Helgaas wrote:
> > > > ...
> > >
> > > > > > > https://gitlab.freedesktop.org/agd5f/linux/-
> /commit/07494a25fc8881e122c242a46b5c53e0e4403139
> > > > >
> > > > > That nbio_v7.2.c patch and this patch don't look anything alike. =
 It
> > > > > looks like the nbio_v7.2.c patch might run once?  Could *this* be
> done
> > > > > once at enumeration-time, too?
> > > >
> > > > They don't look anything alike because they're attacking the proble=
m
> from
> > > > different angles.
> > >
> > > Why do we need different angles?
> >
> > The GPU driver approach only works if the GPU is enabled.  If the GPU
> could
> > never be disabled then it alone would be sufficient.
> >
> > > > The NBIO patch fixes the initialization value for the internal regi=
sters.
> > > > This is what the BIOS "should" have done.  When the internal regist=
ers
> are
> > > > configured properly then the behavior the kernel expects works as
> well.
> > > >
> > > > The NBIO patch will run both at amdgpu startup as well as when
> resuming from
> > > > suspend.
> > >
> > > If initializing something as BIOS should have done makes the hardware
> > > work correctly, isn't once enough?  Why does the NBIO patch need to
> > > run at resume-time?
> >
> > During suspend some internal registers are in a power domain that the
> state
> > will be lost.  These are typically restored by the BIOS to the values
> > defined in initialization tables before handing control back to the OS.
>=20
> I don't quite get this.  I thought I read that if BIOS had initialized
> the hardware correctly, a D0->D3hot->D0 transition would work without
> any issues.  Linux can do this with PMCSR writes and BIOS isn't
> involved at all.
>=20
> Bjorn

During a suspend transition not all registers are powered.  Firmware will=20
capture some during the suspend transition and restore some of them
for the resume transition, but it's up to the firmware whether this one is
included.

Furthermore most IP blocks in amdgpu typically initialize the same during b=
oth
startup and resume to ensure that firmware couldn't have mucked with
the expected golden state.
