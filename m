Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F004D52EF
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 21:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiCJUOK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 15:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiCJUOJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 15:14:09 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873FAB45B6;
        Thu, 10 Mar 2022 12:13:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbgLjYhYoA2V5Qz7aC3tX6DrEq1G0z19eqQ28K66ghqRvlWpQb11x8Xvfpjqat+5032/3yA5raspRKqTqGYeyi7hdCCf2Z5GzuYv5JdMLxSm+311aqXEM/aplnvaRGOuXhqcuO21/oPlSLteXBYt/czBgtWPXpgm8VvWQz9jsVAMGFF3wmPPguYjRQMJnBbNkRSSW441pja49+xbYw3igEEuQ2ZJ8fD9ru9RiShqqLpYZ8GwG/YuI4FYKWi2sjimlc2W9nD66tgkfPLG1RZoXKQLBEPNX5ZB32DLtyKQvMzCNYicWwrEvC0dwqCxh3K5FW2aE0QPOYH2+2KmV5GCCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0PYdyZwuGilmd/StTBU97KIQWCQEicjvb8mcqYwiGI=;
 b=n4wHvD4n7/qWaLjL4uGGxXU/MTeiMkxZNeF5wCcuepM5IS4hFPqn7lfGuycbYr7X/MkiB0ER//UEJclTas6snKWO0mHFdjeGQT4z4N2sHnC5DcxMgTkj44V70lFOi/c2PPgkW2QWCGLpAxEsTDvdgY+DlWmF/XVKwCC97nFvswBtXdY0KGiQbCKq4ohdrII3c/gYAhoYy5bWYuHkhh9JKRPNB5AXubqrZ8Bey5BMV7spp6NHxHo6yTlLutO1cLxk2AsR2GnO4n8mYuTU0vZxG2+v4PPdD6zeh+YF6e3Sv6pCV3V0xFurM7UjMFu8YkzH8hODXma55v1/crDK25XNOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0PYdyZwuGilmd/StTBU97KIQWCQEicjvb8mcqYwiGI=;
 b=WbmT1NAhvEz8r0+5lIfADGt6KDOLf+90MGtOTrrei5KsUrekIN5YrOdvU2bhWW0BbT69mLOznWSDlV59Ihv5mwoNcyoNUBsSzDF5klG6OhtmAkeQXlmOJXHI54sOASyOPke6u7iS+u/i0XdLYxDRJx/neOvvaICiGhOY3rfHDG0=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by CY4PR12MB1158.namprd12.prod.outlook.com (2603:10b6:903:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Thu, 10 Mar
 2022 20:12:59 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 20:12:59 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: RE: [PATCH v2] PCI: ACPI: Don't blindly trust `HotPlugSupportInD3`
Thread-Topic: [PATCH v2] PCI: ACPI: Don't blindly trust `HotPlugSupportInD3`
Thread-Index: AQHYNKh49Nrq3KLvIkmIQ/Zq06/S2qy47wCAgAAaI9A=
Date:   Thu, 10 Mar 2022 20:12:59 +0000
Message-ID: <BL1PR12MB5157D9FDDD0FC829CDD8CFB2E20B9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220310175832.1259-1-mario.limonciello@amd.com>
 <CAJZ5v0gjPwEcq2dEE+wRr3D+w7=MTEKJoQ+x9muh_R4W-DawVw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gjPwEcq2dEE+wRr3D+w7=MTEKJoQ+x9muh_R4W-DawVw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-10T20:12:54Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1535c05a-89b6-48f5-8db5-4d82463123c9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-10T20:12:55Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: dafc8699-3cfc-4f6a-a674-63693428b129
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9357cef-1d10-450b-82d1-08da02d25f6c
x-ms-traffictypediagnostic: CY4PR12MB1158:EE_
x-microsoft-antispam-prvs: <CY4PR12MB11583DC0829875702E4942EDE20B9@CY4PR12MB1158.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7oqIZMGJn6aJ6k0wrJ42etai5U8swOqq+ctco3ni/J2G1em7sg/efQc/nDKG1VJ+IdQZcSYD3gyPnGT4SeO3uSpykCVs5nJvKXfHVuqjoVPte3JlNBsGejrwdrrNkvSphKMpZVGQPyEF+QgHIbmhHPYo/2zb6jkinw2dLX9r8Ow/iM8mZBu7XfKWHDecRZMbImuuYOWnp4KFrChwnn26ejw1zjS90d4Rq8eLpJl+eushXXR8bE57/dv6XSKFDw3F+rIFnJBCDcKY7jiHrrAkeswWbu9jxVk8zMvuFXrd1aukrEDb6sfp7FPmioS2BgbMSxm/Ik+Md80eMmI2hrZprhkXMWZnBNH4vaycb3S7qroj9u3fSw5BE0eYKbBCyb92r+lvch+YxmK+tpbAZizJCineN/jl/K2gik4Dp/NaPymrUVxljvCS22EPsEOGRsTSeKtKdhDd577w8SdjfqaVJofiGFtPnNCM0M0LjOVFKfRC+MZQNdzxqy89SwlkYTEJm7DGFmeDiIFqXRtVEDaptBYD4jys7tGDgEFMJ6Oc0tuscWwgOC8RldYKc937E9vJcB5RzcjVBu+OmMgy1AE1sNR1FWQDQA95AzT/hkoYPi32GyNrlMK01tYn0jgCMcnI0iFjuHR94GiXBlyR8MgDDXAIRbz7fdJ5k/2eRDDdncPa3ca/eQ2G5EVSnrpWZeViDi1z4ezqGj7G3P0vxqitChmoDZkHrGJxKg1z2WBqTXg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(6029001)(4636009)(366004)(19627235002)(33656002)(8936002)(8676002)(4326008)(55016003)(2906002)(52536014)(71200400001)(38100700002)(6506007)(66476007)(66446008)(508600001)(38070700005)(64756008)(66946007)(7696005)(9686003)(66556008)(83380400001)(5660300002)(122000001)(76116006)(186003)(316002)(6916009)(54906003)(86362001)(81973001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bBWcgnzIJHkIu8h8Jctp333XuKNRKkUzOOtdxh/MmTEwC3OhhHYMyw1LFyM8?=
 =?us-ascii?Q?+Q2DQfT13PNS2mOjaVODeGSTiceiZ5dCi3pfrkvlAdTJpyAMEOp9jYufAhBh?=
 =?us-ascii?Q?7zDIacqdsd41eWRhqEJHAA9X1GgARBSntdp7xaCCS++UBx9WmDXpMqz8kOau?=
 =?us-ascii?Q?zLdhZsKOd0waJbtnmNfz93uFr5ouQ6rC+QrJTIqNHYwmpi08p0pyEwTvKXqb?=
 =?us-ascii?Q?/xwCKhowjKqjgqzvfi1s3v6RZtYELzJ2VxcLdPXynqJgC2E2/dtZR8NqLZzm?=
 =?us-ascii?Q?/fy6p0El6UfJO+n7SqG+QRI5xx5Ta9g1GTm0+Q9qpO+cgNNPbVgeJ1CmalHf?=
 =?us-ascii?Q?fRMvRb9bRe76RENPDjk6zZBkWFj6WAYIB3ykZa35zfRNGodu03p9Yz7fCEI6?=
 =?us-ascii?Q?hIFFvVAvSUyLcxw+Nkdku2C4lo7Ta+GDIZzn4IVzX8wNcdiK1oeMIAcj/C+j?=
 =?us-ascii?Q?n/C0oYN7kfOQ9QRmvpf1FLQ2XAga5q6RvEj5riPInx2t/CMXcIQNGneNXFzw?=
 =?us-ascii?Q?kP3Q12wbF5Gbeb9MEQewaL1sL+2kPD2HQRIOmtgC3ZwgmzUiXdW5JOeCDYio?=
 =?us-ascii?Q?jYI6Ju8iE+ldVTqNgEnVYvlvSUw32DjqRwQGAdP/+5TBcOz14AWFNFvZ370L?=
 =?us-ascii?Q?mW/MxSwcRA3Jy16cOKv6oJ0YuxLP17l44IenyLyrepvrvAvI/iNxRGitCWCB?=
 =?us-ascii?Q?akNa0WD+j2//Jq2oIcg/+QYwV8CZEf6+CX+JuhpBGAEO/QX+IVdBSD6Bo2Fz?=
 =?us-ascii?Q?xx0+i1PuzrmN1hByoWDjQHxAmhNkvtUpJjJtQNII4iu9fUJW47DwGDEovNwN?=
 =?us-ascii?Q?dSSFdSF65ILoN9fdNm+Mr34q9LWXxY1584IShh9O0MIin8g0pVLuFl58fiH8?=
 =?us-ascii?Q?AZMqpsSuWjgehEpyJNBVmzACJgX/8m4MJsf8ChYHkTb7ZCIm0hE9TyYUfkyz?=
 =?us-ascii?Q?EbCI77E95aOTGzNE1qhZKp0LxPKaxp0239cKfTxCtPprWYJmKQMhRtLTeAD0?=
 =?us-ascii?Q?bSjKn24v4/9HaYc5X92+ezPtVA126lGZpD2wT71Hr9vTDA0iB5Pawv1bql43?=
 =?us-ascii?Q?x8KiyL8wxCWG4MUv0PF01Qglp0U2vhqKk9fsIUDRJZ2A1TL9LHoXJZ20M5hp?=
 =?us-ascii?Q?H8ALQeRV0kMB/bWt1KvUn9zUNQgunFyIAVDaTbLHHC/o3BAd852YqNoVFQu8?=
 =?us-ascii?Q?bmlHMmtmnmSvibAXcfpYoTdmwm1y6w4vorpIyMKV6tIc59lKcI/qX2V/g5Oi?=
 =?us-ascii?Q?05Jt0A8GFeffhxskY7QIIKf0DcftCnpv0tKVOoAw7EP08wHjWiBVe1rwZ+TD?=
 =?us-ascii?Q?fmvKoLho2P+23L8VSjvzz819uo9fBkbzfbrSBaWpe2WAS1t9oewHqyJTAJSw?=
 =?us-ascii?Q?ZoimnxUOOlKdoXXzksplsqZ9S8ELEMcLBP+DSC3uZLvIHdnB7dlRRe7ssCqM?=
 =?us-ascii?Q?VeDkC2gHtHhC3tLc9UoX6UuVcYbXgDMQsqcClIsG5IPotIrKEAiykPFYAay6?=
 =?us-ascii?Q?+OzIn8bks9sj47UXDrVNlXLDlxLoN5OMsnCXcBhfpph0nbI/uedGTToOAO6r?=
 =?us-ascii?Q?eWi0z/2qz4wchT5fCUAFZo3u5yAb4d7ygEGqOvk9cRbU+gDRtg+5/J1Ty4Dy?=
 =?us-ascii?Q?txunCSyX6pNLg+q11/DWokqqdIEj4yIo/wRPIpRDRHJ2UeOaBLMlU1vqnlQ1?=
 =?us-ascii?Q?C9NE90Tactc4uW//ef+rIcQC/lM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9357cef-1d10-450b-82d1-08da02d25f6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 20:12:59.2587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZsyM1puuv7vfw7LNRLmZ7jOW0uElIHOLuIpOkQ8D9Mudt4/JJ7iWKSrJXnz89bazrbkwRRSfcfPyYshLrCmPiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1158
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Public]

> > To fix these situations explicitly check that the ACPI device has a GPE
> > allowing the device to generate wakeup signals handled by the platform
> > in `acpi_pci_bridge_d3`.
>=20
> Which may be orthogonal to the _S0W return value mentioned above.
>=20
> Also, I'm not quite sure why acpi_pci_bridge_d3() should require the
> root port to have a wake GPE associated with it as an indication that
> the hierarchy below it can be put into D3cold.

The reason that brought me down the path in this patch was actually
acpi_dev_pm_get_state.  _S0W isn't actually evaluated unless
adev->wakeup.flags.valid is set.

>=20
> >
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index a42dbf448860..9f8f55ed09d9 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -999,6 +999,9 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
> >         if (!adev)
> >                 return false;
> >
> > +       if (!adev->wakeup.flags.valid)
> > +               return false;
>=20
> Minor nit: the two checks above could be combined.

OK if we stick to this approach I'll do that.

>=20
> Also I would add a comment explaining why exactly wakeup.flags.valid
> is checked here, because I can imagine a case in which the wakeup
> signaling capability is irrelevant for whether or not the given port
> can handle D3cold.

Specifically a case that it's a hotplug bridge that has HotPlugSupportInD3
though?  In practice I've only seen that in use on USB4 and Thunderbolt
bridges "so far".

I haven't tried yet but I would think directly evaluating _S0W at this time
seems it should also work and would match closer to my original intent
of the patch.  Would you prefer that?

>=20
> > +
> >         if (acpi_dev_get_property(adev, "HotPlugSupportInD3",
> >                                    ACPI_TYPE_INTEGER, &obj) < 0)
> >                 return false;
> > --
