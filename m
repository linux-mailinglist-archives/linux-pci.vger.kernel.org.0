Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4516C1DD1
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 18:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjCTR0J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 13:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjCTRZv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 13:25:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2148A63
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 10:21:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RowDG6FayCGpi8pbaDJKmVuG77i1KnxI46AgbWEeOxKAdOU1CKr9CnuMtv3AMFagKPHiccCtXgX0wsQkbxahUrIJphXEy7cQGVKhwlS8+KkuUWi2YTmRQVcGBtaFG/5095I3DtAzuV+LzPAsIQKqjD+pXl5ZegF6veieHkGC/oigfOApM5xmIvSJeCN/q4xm0flHbA8TL8sg4jtYALWLEq4KSVhDd1qlyPCyRbdMGpI8+lGsWWCfjVsVCh+a03PAfBCp6QIErYDSFYFLm8yrcoXQwiFvMIYcgmlzns+8hfquGIJC2D/qtfQxQbHqWM0fWBagB9oOdmKCow90fJwKSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IanJ5kGCDBml8nn+eQRHM1Oi9tD0hc8ghEIAISfo/nM=;
 b=Iu7COUq5UxVwslUGQM2zEQh1+E4Zq+xU5T+X2HLxDqzzhJj9bol9lEnxtjZ2DmmN55RP4sGH6+1RrxUyk8F/s/XvXaDqXgIyA5ACNDidI4daEvUaRmTrtvHDVHAw28vFF/FDRZpSWbi84EaYoqIsuTVHe4nxnNq4ftMnJCYZMebPTtDhffYF3ZfdSmhkZvRXyLRJmgCbdsXfyqn7NYhlJRjzFH0hTpFczXYSgNNzbxrh2IQZUPh6KxPta+ZrFN07GHSggQ1i6aA1e9HGLoIjC2zygZ/GWJbxm4ODlvn7mv9h0KaIFn+sUQT4cpwHTZqLw2dhD6zmIPFzKXXvTGGtVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IanJ5kGCDBml8nn+eQRHM1Oi9tD0hc8ghEIAISfo/nM=;
 b=ECWV5jeYF5PaJeKPtxvhjbLFjMQyux4shFUyE7KVlupvZ9nG3MXS2zyZTcGyneJ/pkVeBFO19IGR5WW5jv+1kUNWvNs2irq15dSwiffhB0WSkbmfPzU+7sjffvNn+MuP/W2uYTU87tPvv0PqkVORgA6FbaSlGprQ3CjyifZ6/uc=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 17:20:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 17:20:55 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thomas@glanzmann.de" <thomas@glanzmann.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: RE: [PATCH] PCI: Add quirk to clear MSI-X
Thread-Topic: [PATCH] PCI: Add quirk to clear MSI-X
Thread-Index: AQHZT/y1Z53wI/N1kUuWSAR9Qbt1I67xfxoAgAAC5BCAAJEkgIAAtd8AgAACFYCAAEKLgIAAKQMAgAFkgACADltzEIABCGGAgAAAwGA=
Date:   Mon, 20 Mar 2023 17:20:55 +0000
Message-ID: <MN0PR12MB61016417794D1AF00963AEC3E2809@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <MN0PR12MB61017F7AD76AC3E3C296E6D1E2809@MN0PR12MB6101.namprd12.prod.outlook.com>
 <20230320171447.GA2293285@bhelgaas>
In-Reply-To: <20230320171447.GA2293285@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-20T17:20:53Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=578779f3-5119-421f-9f8d-c3d4f0834c75;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-03-20T17:20:53Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: b68b9d94-66fd-4857-b9c5-5124ce957811
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8111:EE_
x-ms-office365-filtering-correlation-id: 43fe12fd-8c8d-4d4a-e600-08db2967769b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xRjGBSuMEgSnDWVvYs4d+cke4MXV+A6w/Bd7SX90CFIaeFr6MEHRuGfDA37i9W6v2Wew9LD8dlejRqSGr1XJ3kFT2gTFR8SL96rjkg3+aNQyN+In2UgV/BaoMOr53sgvHGg+Gn8P/1fhi30E2BEMVFnS4im3Xt3HTkOj6Wi715xV5l718oFhFJlH8GVFSaMQm4nlehpXfVYBavqNPldJfatDsPveX5d8gEXCOhSD308oJc89sMj7ScS6RdgCoEWYxLpDMop1EY5p5nXnnHdDO10dXQ0hSA2AeVth6Mf0TgguiMRvqEPSOnuuM0RN6xFVnU8LOYVxMYVK8FqdGXr2Ry/jdNMAWtz9uGVSL+YM+AOFrb1I1OgC+Iom8V/dTGUGdK1tSR04r2R8Rgjs82t27XoopI98RyY6JkyfDnxWY5djg2MW3LpyMlTrUmC0XshuNn8TtmZiKXZQXou4mLmNrI7DeUWYmWvLOvJTb3sfjGz4WqWhl6lWbh0z+hOXf6jzsjAuzWVWYQNfUg37wL1bbwyG/JDkFqaKGeQjcuJWigXqsY2oRAQomPWjYILnKH3wU+QuOiOhyW1S+9J5TDJlCK4Bat+l9/9ENq3qNZOKE6Gore5OQWmByPg94x4PoFHDG2GYnaKgzYSWxYjXS1P1y6Ps7d2zLveSnTW6ECJ7oaQtFu7CvC5L4Q+5VeXN+trG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199018)(83380400001)(86362001)(38100700002)(38070700005)(122000001)(26005)(55016003)(41300700001)(5660300002)(4326008)(76116006)(8676002)(6916009)(2906002)(66476007)(66446008)(52536014)(64756008)(66946007)(66556008)(8936002)(9686003)(6506007)(33656002)(71200400001)(54906003)(7696005)(966005)(186003)(316002)(478600001)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AcvCMHDcnLbHect8J9oD2lHc+nBn7r/0BjQDEv0ercHwUVBJOKPZaGX75hOb?=
 =?us-ascii?Q?23zRszVJz1r8EhxvJu2aSK/HQZnOHG0vFFkBFRYWYVUBq8RvNXZ/CXs5ZCHQ?=
 =?us-ascii?Q?IvwvxJFZoOdgaRat9N7hN7TIFqDm3L6G+eZGcRNPA7EexTz2vovLdLrfS0CZ?=
 =?us-ascii?Q?W3wCEh+pPWkA8TQPz3z5Hi6TNrgyV/1ZQnO3/egYxfsZqYoW8pa0F0BfcztW?=
 =?us-ascii?Q?hmD3+nbvflQTAnEK+wEKV0+08QeWleyCmHxr5cAlfbnOzKRKDou4G4m1LC0b?=
 =?us-ascii?Q?5Vj4a+aH4vnMBS2l5BhCXNjr0xiaXcJHSJIC8DEoW/QPYMc7rJL1CbuPU8QA?=
 =?us-ascii?Q?rWvcIWcJ1mj5v6nsnF+UjV7/5DF6lHrqOVoa3VWNUXchMAPtN9oAy4S2RclF?=
 =?us-ascii?Q?DyrzLr3rfCLYBIQVPXOELm3do70a8Vk/zj+0fmGYZ6H5mVt/nosVvaBYzY+m?=
 =?us-ascii?Q?q6ot3VvStBFmRSRXx4vNPyLiNWOx7rPHtcEqnjKMUGri3FCd+RJQSAoeSJ6J?=
 =?us-ascii?Q?VRTVas72eIhGx3xYC2l5uRYRbQ6r2vni3DfZ+rjrg9076GpLiS+sOaTDck9s?=
 =?us-ascii?Q?pZ22MI4pFvCTI/RNsYU/a3RFHZMHjZfW87g5gX7hTSbt998WK6hETnXPBNkr?=
 =?us-ascii?Q?JxwAspVVMv9c37VFNaWfWkMo07JstIkx/9gV7Yw7++Da2l7YOLJCkgfC1vDX?=
 =?us-ascii?Q?oeJ+RWfb7WAJgne8k1hbaFv1htg9w51Z0NxFH/XycmmbZS9kaxnAUvzoH04M?=
 =?us-ascii?Q?dm55bRIJPLJ/m/2Q08NBHuoEtiOqr+hI8p3jef2hyzcLdyWAzEpRvUwDASAr?=
 =?us-ascii?Q?GeiGb09/9abAPm/3T8xVEqkeEgwObuU4xjJ8h4GC7j4IvRldxN4xt5eg4X1w?=
 =?us-ascii?Q?oqadflgKwcM00GpAi9MVsxGd21tv1wNEv6BY+OhdlLa/8DpOKpvIezGYcA3b?=
 =?us-ascii?Q?LJE5A27vlqGwa2NBeHbYFQjuIPrc6QBmm45P3jjnhDIc8g0Ju8fBAOOLjCTC?=
 =?us-ascii?Q?Q3rqGHK3EvGnJVvw6vsx8X2tuXA0kCLDouJxLYHcbYtGuxIgk0rJD3MsM0pl?=
 =?us-ascii?Q?P7Szyjbk9HyuuddY86q/V7ZJ8n5xZcMMZA71I17vl2uy203k8thmsWEs8son?=
 =?us-ascii?Q?1ffn7JqvOLKDZ0DLpx1MQHLLJWvntLA5N02CpbpDagaYLZloIFwJoMVb+1lH?=
 =?us-ascii?Q?AZ1g9W/7hcyOpMd+t0YrLaImAwnpCiz1Zc9WRDaCeV/irebWffFAWXt0Ufm9?=
 =?us-ascii?Q?XAyKpw9awQNwyjTqhpr2GF0jSuKxrJeVN3bS81/MqHp3HIiXiZ7PTOyIoivO?=
 =?us-ascii?Q?/3/QqwDjSAqbiJUqG2jHu68nNysXvfm22nAES4u4IjH/HMk6qtc1Q3q5KrKT?=
 =?us-ascii?Q?EkiygNkH2f8g2FLsJvE9VhWcmscRIR5b6Kvyt6QZOr2y5h+nUTjy8Rk3J5vk?=
 =?us-ascii?Q?VIAwn5/UyK7tU+LFAt9p025w0CXO1zaO5UnWfia2jRQi+enna3LYVK2YJgsi?=
 =?us-ascii?Q?e5SgN+j2k3Ay+qbxsJ6E8q+bOaHMj+hTGTKr3HztUn8BCqCGGVhdhsbssLzQ?=
 =?us-ascii?Q?KV/ITm+Ow028Wxf3n4U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fe12fd-8c8d-4d4a-e600-08db2967769b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 17:20:55.0731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERQjRZAzeVMNJk/Mpd5bQ/2PEiE2EeR/NZ4YGxkKWWd0Uvbwu2R8fiafs4INRggTMlKloSAGPYBwowtckNQ17w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Public]



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Monday, March 20, 2023 12:15
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Natikar, Basavaraj <Basavaraj.Natikar@amd.com>;
> bhelgaas@google.com; linux-pci@vger.kernel.org; thomas@glanzmann.de;
> Rafael J. Wysocki <rjw@rjwysocki.net>
> Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
>=20
> [+cc Rafael for RESUME_EARLY quirk question]
>=20
> On Mon, Mar 20, 2023 at 01:32:16AM +0000, Limonciello, Mario wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: Friday, March 10, 2023 16:14
> > > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > Cc: Natikar, Basavaraj <Basavaraj.Natikar@amd.com>; Natikar, Basavara=
j
> > > <Basavaraj.Natikar@amd.com>; bhelgaas@google.com; linux-
> > > pci@vger.kernel.org; thomas@glanzmann.de
> > > Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
> > >
> > > On Thu, Mar 09, 2023 at 06:57:38PM -0600, Mario Limonciello wrote:
> > > > On 3/9/23 16:30, Bjorn Helgaas wrote:
> > > > > On Thu, Mar 09, 2023 at 12:32:41PM -0600, Limonciello, Mario wrot=
e:
> > > > > > On 3/9/2023 12:25, Bjorn Helgaas wrote:
> > > > > > ...
> > > > >
> > > > > > > > > https://gitlab.freedesktop.org/agd5f/linux/-
> > > /commit/07494a25fc8881e122c242a46b5c53e0e4403139
> > > > > > >
> > > > > > > That nbio_v7.2.c patch and this patch don't look anything
> > > > > > > alike.  It looks like the nbio_v7.2.c patch might run
> > > > > > > once?  Could *this* be done once at enumeration-time, too?
> > > > > >
> > > > > > They don't look anything alike because they're attacking the
> > > > > > problem from different angles.
> > > > >
> > > > > Why do we need different angles?
> > > >
> > > > The GPU driver approach only works if the GPU is enabled.  If
> > > > the GPU could never be disabled then it alone would be
> > > > sufficient.
> > > >
> > > > > > The NBIO patch fixes the initialization value for the
> > > > > > internal registers.  This is what the BIOS "should" have
> > > > > > done.  When the internal registers are configured properly
> > > > > > then the behavior the kernel expects works as well.
> > > > > >
> > > > > > The NBIO patch will run both at amdgpu startup as well as
> > > > > > when resuming from suspend.
> > > > >
> > > > > If initializing something as BIOS should have done makes the
> > > > > hardware work correctly, isn't once enough?  Why does the NBIO
> > > > > patch need to run at resume-time?
> > > >
> > > > During suspend some internal registers are in a power domain
> > > > that the state will be lost.  These are typically restored by
> > > > the BIOS to the values defined in initialization tables before
> > > > handing control back to the OS.
> > >
> > > I don't quite get this.  I thought I read that if BIOS had
> > > initialized the hardware correctly, a D0->D3hot->D0 transition
> > > would work without any issues.  Linux can do this with PMCSR
> > > writes and BIOS isn't involved at all.
> >
> > During a suspend transition not all registers are powered.  Firmware
> > will capture some during the suspend transition and restore some of
> > them for the resume transition, but it's up to the firmware whether
> > this one is included.
> >
> > Furthermore most IP blocks in amdgpu typically initialize the same
> > during both startup and resume to ensure that firmware couldn't have
> > mucked with the expected golden state.
>=20
> We're spending way more time on this than makes sense, but I do think

Yeah..

> it's important that the commit log is accurate and makes sense even to
> people who don't know the internals of the device.
>=20
> It *sounds* like what's happening is:
>=20
>   - OS writes PMCSR to put device in D3hot
>   - BIOS traps D0->D3hot transition via something like SMI and
>     captures MSI-X state
>   - Device enters D3hot
>   - Device internal MSI-X state is lost
>   - BIOS traps D3hot->D0 transition via SMI
>   - Device enters D0
>   - BIOS restores MSI-X state
>   - OS resumes use of device
>=20
> If that's what's happening, the fact that the device loses the
> internal state in D3hot sounds like a *hardware* defect -- if you put
> the device in a system without a BIOS, the D0->D3hot->D0 transitions
> would not work as required by the PCIe spec.

Actually it's a controller integrated into the APU.

So any system you put this APU into has a BIOS.  Because it's a socketed
APU people can very easily move it from one motherboard to another and one
vendor may have the BIOS properly configuring but another might not.

>=20
> We can call the fact that BIOS lacks the MSI-X save/restore a BIOS
> defect, but the only reason BIOS would *need* that save/restore is
> because of the underlying *hardware* defect.
>=20
> If that's the case, I would expect a commit log something like this:
>=20
>   The AMD [1022:15b8] USB controller loses some internal functional
>   MSI-X context when transitioning from D0 to D3hot.  BIOS normally
>   traps D0->D3hot and D3hot->D0 transitions so it can save and restore
>   that internal context, but some firmware in the field lacks this
>   workaround.

I wouldn't call it a workaround.  The hardware is doing exactly as it's
intended for how the firmware programmed.

>=20
>   If MSI-X is enabled, toggle the PCI_MSIX_FLAGS_ENABLE bit when
>   resuming to D0, which resynchronizes the internal state that was
>   lost in D3hot.

Otherwise the commit message sounds good to me.

>=20
> Rafael, do we run the DECLARE_PCI_FIXUP_RESUME_EARLY quirks for *all*
> D3hot->D0 transitions?
>=20
> I'm concerned about places like pci_pm_reset(), where we do
> D0->D3hot->D0 to do the reset.  Or vfio_pm_config_write(), where it
> looks like a guest could do that without running the quirk.
>=20
> Current proposed patch is:
> https://lore.kernel.org/r/ddbbfb50-24b6-202f-7452-c8959901c739@amd.com
>=20
> Bjorn
