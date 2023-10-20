Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67577D0D41
	for <lists+linux-pci@lfdr.de>; Fri, 20 Oct 2023 12:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376860AbjJTKfR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Oct 2023 06:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376884AbjJTKfN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Oct 2023 06:35:13 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03066D5D;
        Fri, 20 Oct 2023 03:35:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkWoM3EIEz5KSkzMdrDmaZmLb6gX9QQx3nvZdm2FRXtih7pJWd8axl5cXcT9INOLdIkKyrp/UkwWAw7HBlmmjVZO+g00Z0fqsKB0qzpInxpmhJ7C48fQNIoT2IMGTGOHoIyr6DuOiD4X15AluYVAAPRSSc7c6V8BJ81uKCVSrLSVE65YoDR/Jw6dSxUCU/h89JsiL3iCIBhbhZIzqnUuHICH/uaEDBhR2voCqJRVAZzV+vj1ODNjPLqTR1WnuAL43ZyM/63Ug3n9Drkrbc7P7z1m7DZDis0NTz6p2TTe0Do0mAfXQu9jGUOzF6AwOkZT3lnjsmhaDQplRyxx0H6WWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2q+rTOak9nB9PuPXJvKKiRBehxKarf5/Pig/vcwIB8=;
 b=P129OMsqNuiVvYs/hIymIIkUVByPzrAn6kEHCDKSDWDXIYQB0nDgXD4BCEQM/bwkUPC0s/fgeHF+wR4BfzmH2HnhWv2dkbskORRR9DKSxXCYo4UZA9e/RN8O6q7K4FXTiaRFjNEiSoxQVGd3w3ZxL1Ns+sbatAW9cpBTCtkGNP6msvjpx2jeEjuGBxGKm5rGDQ90Mwlwoak3ac7KidNqFPlYkkx70oyW8GtSfHbO35V5z3WI3zbLaLo7mvtFyKy6svhrhTylgkTHdyMzpAMUEK/tlMWB3CSuXdc3489BLV187RRXfXFNqH9mAO52VZt0lYgDV/y3X8zX1Wtwmy2oAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2q+rTOak9nB9PuPXJvKKiRBehxKarf5/Pig/vcwIB8=;
 b=hKf+xzmxCst6JQ0JItHtrf8S+ji3WPTLcsHvWAGgXFnQCrnDdiabl41Ri5HxhqY69RGsdeIunIuPWPbcxcb14J2DqtuKIVAuHct9rMPXpuWOJvFnWb2hrrK3pTLQhf9I3SM7GPo7S/UequgiF1i6dTs7ra7A1ntYwO/xScQc1jY=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by PH7PR12MB5711.namprd12.prod.outlook.com (2603:10b6:510:1e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 10:35:02 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::167:7f5a:82a1:e2b9]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::167:7f5a:82a1:e2b9%4]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 10:35:01 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v7 RESEND 0/3] Add support for Xilinx XDMA Soft IP as Root
 Port.
Thread-Topic: [PATCH v7 RESEND 0/3] Add support for Xilinx XDMA Soft IP as
 Root Port.
Thread-Index: AQHZ9iAav8GpnnhtikuLDTUsy/E9P7BL+v3AgAaaqrA=
Date:   Fri, 20 Oct 2023 10:35:01 +0000
Message-ID: <SN7PR12MB720130851B21EAF714B7A41B8BDBA@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20231003173453.938190-1-thippeswamy.havalige@amd.com>
 <SN7PR12MB7201035D9E8F21AB4E2B52038BD7A@SN7PR12MB7201.namprd12.prod.outlook.com>
In-Reply-To: <SN7PR12MB7201035D9E8F21AB4E2B52038BD7A@SN7PR12MB7201.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|PH7PR12MB5711:EE_
x-ms-office365-filtering-correlation-id: e7848678-1398-431c-959d-08dbd1583725
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fWNNYopC15u65ryg2f3x9GhLh8Z6z/XnOFlI2mNmd5YqlUf5cWXdaCP4+/2ZQGRxUutgRV2tdPvI/cQyTs6yu7MxExloRK5/ROMVI2XXopeozWOVqQK1Zkqdrk6zCrp4LCTkvXYRymk3JFTy2s0LNOg2DpaufyppvwT75JMj/cZsx/bDYSYObGDKFZERMd4v9rG3kmgUGM9G6E4pH+qx2obKTbM2xAkogqL9wknVHuVVRNvMJFPwKF/0U3iUb21PGTNATfIX/nLP/HSh7vtJ6hl/B/5Cy84z2wj2dgTlPJyDLHwHRLyMEL09bhtKFpj8/f4EBi+GU/wmjDZLnOV8QmESGRLRSa/Tf6oe+6BXPG/QdPPpk9ccOvMJMO5Q782rWao4v6ZphjVvZknOQjewgomqjjklST66HEulWQa7XYKwRm0kJpeAxLYM3kfkG/3mETh9Chnou7NJXFmhiuffABHGnqYXIuwyTNb5U2bgByDYK0mWfG3uI3ezhQfVHsbT8zUYEt8kfs2z7iLflKwjiZCHFI2jaSJJPMHijkij9jCxIFPukh21n5RCYkZbeSPuN2yLY2hq8V50ZBTPmM55Oega7DML9qdQZ9ofHDEMiz1rwrU38MFtxSUvgfdvysXV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(33656002)(41300700001)(7416002)(55016003)(5660300002)(4326008)(8676002)(8936002)(52536014)(2906002)(86362001)(38070700009)(478600001)(9686003)(122000001)(26005)(76116006)(53546011)(83380400001)(6506007)(7696005)(71200400001)(66556008)(66476007)(66946007)(64756008)(66446008)(38100700002)(316002)(54906003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sqba3u/pSBPGX1cNUDgSpAtft90U0orqHEVhvwQ6Sn0sbhEPhBOyArO2BZfV?=
 =?us-ascii?Q?P0UkmSUd9DKV4A6NEcU+XuvuH5idFzP4UlSDjedtuj4rPGvM43ezSrL3Jlw/?=
 =?us-ascii?Q?NvNlW3o3D5F0CRqIDcYLC0XKPektiPftAplSDdaXcN6rvm9EuVWEbbfCemuM?=
 =?us-ascii?Q?bQY1XOru9RzYmsyDlDdFmy8P2+ggTUkfqN2eyHZU0gx6a05RpwhPFDnbJAxR?=
 =?us-ascii?Q?nGEWBMnnhu4uw4eHSoq3Mh4qfmgY7GiPf2J7ZYcBXzOFwFVBEACG1HoQZg+T?=
 =?us-ascii?Q?F8YIB7uPJGBaCjSzK+ien0AjW7X4Po8+4dKzSTB89H7MBslVwYKNlfzxDGEV?=
 =?us-ascii?Q?OLzsWRQsj8WLzBHQhIiOZbB3tpOvmca7HYsAAf6OMG1SHmhBODt2DEgJrf/n?=
 =?us-ascii?Q?Cvl1u7Bh068oV7NIURVPN+bWtN/K65JzifCd/nHgrUSE2+Ph9wMxDpExvvIq?=
 =?us-ascii?Q?1aHkQMkhw3aR85wdwGMy9Bt2u74WyJwProffbnW4fYXWdKW3M4T1rJcoeykZ?=
 =?us-ascii?Q?U5AkdbpoE/sKE47BW/NamS01J8QwLI78d+zsO6LMCtgV/g4aVnpKj4cAz4MD?=
 =?us-ascii?Q?lNO+ndse+HaeArONrzJ+Kr/8GW9o0aJACTASYdwOe0xzzwMkDmfqdkJCrL8J?=
 =?us-ascii?Q?ovqn82VwKBFu3qtS3nneHESy+Fjj6phnW54S+W9HtvsZev4kaVRX6YdmRvWX?=
 =?us-ascii?Q?bHC0cqc/n5X+3mhLmXgcIwHvRrbpx4pKeL6ey0LU6Ld5SEMW6BHHOlQr/93f?=
 =?us-ascii?Q?nL/gYlqBy4AgT5LFfF47H+A6UwDj7Pbmtp8EfzGy67AiDXzdkTJEJYperFH4?=
 =?us-ascii?Q?kxaTU62n0+vunTwgX4f1JHZYz2N/+BwU7kVvCvw4AeBgbsoNsVfQ4LH4EH67?=
 =?us-ascii?Q?LFFqI3UOp/yM6YqYnsFrIbvvjcRjnakIAV/WkfWzFb2730Xqc0xq3M0OBXfH?=
 =?us-ascii?Q?C0FgBoI1DvYHu1HG11di4ZfwEN6+pRVPJTgkoR5NIJcEFoaefsdYE6phMfbF?=
 =?us-ascii?Q?EWrDTck+ERI9PwtJfsxo6p9hthtZYjXP1K71W7jPnupEhdXkFss3eo3yOHxr?=
 =?us-ascii?Q?aNaJbwd5X7dmgKj+061BZhDvAl6c4GS5NWvFfVL6+4oiNAM6cGhEXAghQqX7?=
 =?us-ascii?Q?zk1SJOVpdVsK5+ioHXJPbQ3ZNVdUN5nZ+qzGrCgJv8R05tdgJ6DQHKHp9ldn?=
 =?us-ascii?Q?foXyfC/eA3cacXjuBWYGofytDHd3WHUzYFIo/J0jIZ9ohKn7jEEzsHh3qW8e?=
 =?us-ascii?Q?SB0BPb3ODIMKm5wXWGEJkMRYs77bDkq3g4F5v5DljN/HeBIt3eOvQ4lnaJKD?=
 =?us-ascii?Q?FJ3OtFex0tkna5WsopGcobf6f1lXUhRc66pzml6DasYAujii+ICwozsPhCJq?=
 =?us-ascii?Q?Jyb1gDN2UI5rGpT33jhYZrgFbs7u4SLV72O8S6z9wySS73qCetMhQXkoZ26/?=
 =?us-ascii?Q?UyqLDo4f2CZMUARSNcJHLpGpquSbv7mkOpUyXs4rRtaC0cBYGLw1INHTI5IN?=
 =?us-ascii?Q?e2onSri9IGKEcGgPOYKj0l0mIikD9sXhR01xD+kyATMU6SLKF5bhSue/LhlN?=
 =?us-ascii?Q?LJ8rc6iyF4LwnjB7HCY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7848678-1398-431c-959d-08dbd1583725
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 10:35:01.5178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1CptQol6RbEiUqPNOC02x7jwUbo/usTchu9DE5el99xN7O34u2+a5joKlhoWE6fZV05n2heXIeTA5lgPgbjwGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5711
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Please can you provide an update on this patch series.

Regards,
Thippeswamy H

> -----Original Message-----
> From: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Sent: Monday, October 16, 2023 11:14 AM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>; linux-
> pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> robh@kernel.org; krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> Simek, Michal <michal.simek@amd.com>; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>
> Subject: RE: [PATCH v7 RESEND 0/3] Add support for Xilinx XDMA Soft IP as
> Root Port.
>=20
> Hi Bjorn/Lorenzo/ Krzysztof
>=20
> Can you please provide update on this series.
>=20
> Regards,
> Thippeswamy H
>=20
> > -----Original Message-----
> > From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > Sent: Tuesday, October 3, 2023 11:05 PM
> > To: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> > robh@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > conor+dt@kernel.org; Havalige, Thippeswamy
> > <thippeswamy.havalige@amd.com>; Simek, Michal
> <michal.simek@amd.com>;
> > Gogada, Bharat Kumar <bharat.kumar.gogada@amd.com>
> > Subject: [PATCH v7 RESEND 0/3] Add support for Xilinx XDMA Soft IP as
> > Root Port.
> >
> > This series of patch add support for Xilinx XDMA Soft IP as Root Port.
> >
> > The Xilinx XDMA Soft IP support's 32 bit and 64bit BAR's.
> > As Root Port it supports MSI and legacy interrupts.
> >
> > For code reusability existing CPM4 error interrupt bits are moved to
> > common header.
> >
> > Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> > ---
> > Thippeswamy Havalige (3):
> >   PCI: xilinx-cpm: Move interrupt bit definitions to common header
> >   dt-bindings: PCI: xilinx-xdma: Add YAML schemas for Xilinx XDMA PCIe
> >     Root Port Bridge
> >   PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
> >
> >  .../bindings/pci/xlnx,xdma-host.yaml          | 114 +++
> >  drivers/pci/controller/Kconfig                |  11 +
> >  drivers/pci/controller/Makefile               |   1 +
> >  drivers/pci/controller/pcie-xilinx-common.h   |  31 +
> >  drivers/pci/controller/pcie-xilinx-cpm.c      |  38 +-
> >  drivers/pci/controller/pcie-xilinx-dma-pl.c   | 803 ++++++++++++++++++
> >  6 files changed, 967 insertions(+), 31 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> >  create mode 100644 drivers/pci/controller/pcie-xilinx-common.h
> >  create mode 100644 drivers/pci/controller/pcie-xilinx-dma-pl.c
> >
> > --
> > 2.25.1

