Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E2F619303
	for <lists+linux-pci@lfdr.de>; Fri,  4 Nov 2022 09:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiKDI4m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Nov 2022 04:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKDI4l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Nov 2022 04:56:41 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on20623.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCA827911;
        Fri,  4 Nov 2022 01:56:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtwzRCVwwpdOUtPLmEtlQJwCFPi27MUlZ1AfK98N/usloHtsHVKmgDit7eu53rQdphAteceVq3DHpf7bDTeFemBrB6kJ7dDrKbZrdvjFfvtJToawW8Q/rxGbxbxi1lomRG3a0YVk+xqray7jMKbhmH9pPjcZelbf3copzYNYgttZWxOQId3JTljw+lAAjzNvNAGuBRwKVCShLeetcdC1hQMlGJp2MoelLOwiKphNQ0sgzxgs1nog57+zXs8nCYJykfw/sAUtWNulUsrP6cWO5CL9v3u99BquvTAcPHkSUQeCXRR7ZCx8geuzmf/2P3XD/DyfdT8noacNkgpiQy2U5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/dQwwBkKbMF3v+8quGd7AAtizxgs7tBzGI0cmyGEfI=;
 b=BYH/5UBK5/ofaxKe1Qs6yuEpbgSR9QW0Trn4DaIiO9bQPQviXArOxlM3VOjluHYOCj1jYUgOGt4WriNUo6NzZuPi+ncNchd11kQlFQVCAZA2QayY+GCQE+QjKbQUa0NGmHnA9qTSLCHCvka8VutNrJ0i7i4vNFmp2hfRNNvYNJbyDn/Zzqqsgw8SRrJZRCeOyaQjNqQUQUn+f4XNm+d5HofyjIxNSIOj6RmMsobYj0l8cehTC0Ep407Hz4w8Fvx7IDGvu8ortnJWlX5DYwqXGQTTCKzRQyMzTPH8WsAPJwivMLED72fhWfsoeYyXJF4rBwEqaNM3kmVK9WXxV49tYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/dQwwBkKbMF3v+8quGd7AAtizxgs7tBzGI0cmyGEfI=;
 b=xVOSxibnwW1tMUUQdj/OcN57PTxa2GrCc9SlnEGWaQ8yEoVkW+3Rcy5ooCZTzhDhaTLHAw1wyuXYSALe8q84jvcArInMfOsbvCvygNfarjYAjClgLEnXjd+D4RKA308N28nkywN81ltpXa8kcD7KzXrSHmKn+VRQJlJ0POvlHY8=
Received: from CY4PR1201MB0135.namprd12.prod.outlook.com (2603:10b6:910:17::8)
 by DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Fri, 4 Nov
 2022 08:56:37 +0000
Received: from CY4PR1201MB0135.namprd12.prod.outlook.com
 ([fe80::4b4:ce67:45a5:8578]) by CY4PR1201MB0135.namprd12.prod.outlook.com
 ([fe80::4b4:ce67:45a5:8578%12]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 08:56:36 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "michals@xilinx.com" <michals@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH 00/13] Remove unused microblaze PCIe bus architecture
Thread-Topic: [PATCH 00/13] Remove unused microblaze PCIe bus architecture
Thread-Index: AQHY6D5oC3eE/p73a0+tHEBmmYl2uq4etySAgANKboCADIRf8A==
Date:   Fri, 4 Nov 2022 08:56:35 +0000
Message-ID: <CY4PR1201MB01354FAF64130CA17A0724D68B3B9@CY4PR1201MB0135.namprd12.prod.outlook.com>
References: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
 <06718d29-f3e1-db07-d537-b78290213b10@amd.com> <Y1pTh5fiN+/mKPrR@lpieralisi>
In-Reply-To: <Y1pTh5fiN+/mKPrR@lpieralisi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR1201MB0135:EE_|DM4PR12MB6254:EE_
x-ms-office365-filtering-correlation-id: 77710111-0cf5-497e-61fc-08dabe427aab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XKeOpS4imbBNCQOIv4f8Uk0fLTyUvaBKK7hi0/BohDORwlw2yNaH2mhva46McGAM1lTVfswseR9xPzLiiy9EP8Lu0JWQKc2Q4qi9TqLUPweugdVBvHdAk+On0JkjSnS69CUdqYogA7Fm8FNE7TaDSsG+02okZS+X7EtbixTx4GRwnAyXOl/RrTy3isPe3hfEUH77sWx2rDYp3FZdS4IsaRLnaxTwEtNxtHAR+hy8olqKxV3A+WH3dV8V1qXc+bkKP9jgf6Msdum56/a/wsQTcRJPpTKph7tqiD/Pr0wQYSH+TsP1jTdpFQXiQY5FgSH9O4ejs1uC+IPvu1ZI7dYCCxDtDk4LprqvTz5X9SLMQ8Oj0EScDzq0w2ktPqJ1QJsUr6OH4OAvbzRfpxYg57Th5iOclSTyFvjpbMa99nWDAEEM6VUkkf7ptLO0aFn9Pxu/9rayVknhwb/4gSY156dGZUxEb9glbLHZhyAk0Kw/5xG2lK+NI1U5ZwyHX0QVDxspkWJ6jwGtqBdPErEJHxO5KUwXFlpCCgmYr4BbekMJyq+tbxuu48T0HgO2sBMusqUxHzMptpRnsIXoESRW+DA8U7g5YgMdfUEO3EFmMM5MKCa966AEQVXpt5VIMifn96beuElwET3o/l0DmS7pV73pnvpJZznAui6u903fcAvoPzgzHjl457Vh8Jc2E7Qol1CDX0xqXDQJeDLtheGyNGFZ4OLLb4ZK5im93N4pFQr7ezge6B1yYMEBR8pC8XolweWV68noZmgIYn1Oz82iHvVJ+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0135.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199015)(8936002)(6636002)(66476007)(110136005)(66556008)(52536014)(64756008)(54906003)(41300700001)(316002)(66446008)(76116006)(4326008)(8676002)(66946007)(5660300002)(38100700002)(478600001)(71200400001)(122000001)(38070700005)(26005)(7696005)(9686003)(53546011)(6506007)(2906002)(83380400001)(33656002)(55016003)(86362001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nxYytwZJxTJdget1YGqwzlidr7XbMG9tMROmdkN/lagNqBeobfDDzbMqgIgD?=
 =?us-ascii?Q?fjFhkswFUl0vq1Up6hndi8wKsopjFmIBxH14NKNkkwGBxYrEiNSZnSB/K/s3?=
 =?us-ascii?Q?0CooH3Gyp9zaXB9L9IrRWYQGf69viCV05zq7Gpk/Kbkcq+tYYSu21wngaURZ?=
 =?us-ascii?Q?JUPwtoXFrHiF8qh4ERyLxKeF8NwCDjym5HbSuLBkPombBm8TkzVisFlz2iDq?=
 =?us-ascii?Q?vgE4+P2reXc0ysPg04gV0ySEG1mwKHZNTw4YIxFUYxPrfPZLl1vVRxkDrI6Q?=
 =?us-ascii?Q?moefHD3Y01+FVpRjO9Ftr4uyP2u2b2Sk9jLJVr0L/iqchNpTauPYWeDG0LjM?=
 =?us-ascii?Q?UYWJX03nqvEBQQxoOiWON0pHRB4vfJ7lly838CEFXjHAofIB1k7Y85CH8WhY?=
 =?us-ascii?Q?VvMYGAOGibb83e9IgLtE3BnJn431SQwKEe0+Yc8oOjFsQY7QJeMnr9SnxOu5?=
 =?us-ascii?Q?Bk6ewhxZBhbyia/51iA04mwu8VDmTEfKhPe2rOhm0ApZFo/izRyr9SfSWBA8?=
 =?us-ascii?Q?nnDv4P1OSO9FKqfCXHoMf82HPx6TgvYxwfPwA45YGq3Fbt7Z04WWPaxSw1U9?=
 =?us-ascii?Q?ymnD4e3EDf0YkxMLc2exb8/GrG1AQaxA2YKuVoRbDc9Hi+PCHZfNfqAh8fcF?=
 =?us-ascii?Q?pxQPYEX9Jwj0s99xZ62CVkrj/aFuxC1+CbSdaBirqG07ZeJ8fgBLWqZTABVa?=
 =?us-ascii?Q?cFQLoN6VdbfNkquUVqg4MDAU9i4P+xBUf33NUDzm5JF59ajKgCXUXDA8ElRD?=
 =?us-ascii?Q?j6CN2bfcpOGhJ9D0ygnm+JvvR773jVG4DNo/fQKmu4Q7dA+mDqfUzrxBxiSw?=
 =?us-ascii?Q?4aEsjQfD423qCw1aiwRrNg7EPnYhWmILW1ntB3BNSGsLc6yxJJhUmvj/1kyL?=
 =?us-ascii?Q?Vtpxmneomol5HTDYDgn9ecO1UcYDSDBRBsWMBUcsAcAnFsZjC/SdCfGQswwf?=
 =?us-ascii?Q?0rsOz8oUSs1PazannVwMmqx444XmRwSbw8Cr6mOj3RXy9MVV33RUKfXS9cpJ?=
 =?us-ascii?Q?WTz7BDYyLt/LxF8zZkoqFEPzO/2r3SR793azgd2CuQGFg8yRdTeVT8ec3OFj?=
 =?us-ascii?Q?SoWN3stcmKcmcm9s9GMJ5zRvrGkxx8VJ2WE6tmqsgWEc5yoIqm2v1YDQu9Eb?=
 =?us-ascii?Q?7YNzCX6TqkTU7h86WQNN4x91AFWXa94o4r7VSoIrONfDr6fwwjvPQJTdav+L?=
 =?us-ascii?Q?YTlqMBJ2S1+NGwDiDtaKHmczLQJi2i/QD4Dy0yZCEuMSmXJSebL66xkj8RgI?=
 =?us-ascii?Q?G9+WZd0snvjfWgdZ+FFyC9zMuojlTNtWUxMgbvWY1Qbr8cVf+D5LwIocvQp5?=
 =?us-ascii?Q?8Z3BPuznAauSE6bq+lK2ERiDAUtLcH9GfpVJkBH96B2LLA4ow4DQqCkssEqP?=
 =?us-ascii?Q?tLBrHtMY5Boc8swlyZEWDuB5ZwSnvorUFRHkhGGciTt7AmBOBos9kY/ZWI1r?=
 =?us-ascii?Q?bsjCU4u7a71b09gmN1/GlYBJgiyU5SyKroRXgIO6o5cGmaHY2PA/0qcVHA2l?=
 =?us-ascii?Q?s083jnNS5M7ZgzL/3V6P4j2Bt4k+weA9KFcYxTENp0he7AQNJM6kYBdju7CX?=
 =?us-ascii?Q?cLN0RfYnNZn7RIwhbcA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0135.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77710111-0cf5-497e-61fc-08dabe427aab
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 08:56:36.1205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rPrSh9DK5smESsUrIj6mVj1Oc2wjWv8/Crj5ezilHbK0tOHnVw83s4orn0I/5B1lhTbyctCShngG8rbNjPuFQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Michal,

Can you review/check on this series of patches.

Regards,
Thippeswamy H

> -----Original Message-----
> From: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Sent: Thursday, October 27, 2022 3:17 PM
> To: Simek, Michal <michal.simek@amd.com>
> Cc: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; krzysztof.kozlowski@linaro.org;
> bhelgaas@google.com; michals@xilinx.com; robh+dt@kernel.org;
> lorenzo.pieralisi@arm.com; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>
> Subject: Re: [PATCH 00/13] Remove unused microblaze PCIe bus architecture
>=20
> On Tue, Oct 25, 2022 at 09:31:37AM +0200, Michal Simek wrote:
> > Hi,
> >
> > On 10/25/22 08:52, Thippeswamy Havalige wrote:
> > > The current Xilinx AXI PCIe Host Bridge driver uses generic PCIe
> > > subsystem framework. This driver works on both Microblaze and Zynq
> > > architecture based platforms.
> > >
> > > The microblaze architecture specific code has unused PCIe host
> > > bridge supported API's which are no longer needed.
> > >
> > > This series of patch removes unused architecture specific microblaze
> > > PCIe code.
> > >
> > > Thippeswamy Havalige (13):
> > >    microblaze/PCI: Remove unused early_read_config_byte() et al
> > >      declarations
> > >    microblaze/PCI: Remove Null PCI config access unused functions
> > >    microblaze/PCI: Remove unused PCI bus scan if configured as a host
> > >    microblaze/PCI: Remove unused PCI legacy IO's access on a bus
> > >    microblaze/PCI: Remove unused device tree parsing for a host bridg=
e
> > >      resources
> > >    microblaze/PCI: Remove unused allocation & free of PCI host bridge
> > >      structure
> > >    microblaze/PCI: Remove unused PCI BIOS resource allocation
> > >    microblaze/PCI: Remove unused PCI Indirect ops
> > >    microblaze/PCI: Remove unused pci_address_to_pio() conversion of
> CPU
> > >      address to I/O port
> > >    microblaze/PCI: Remove unused sys_pciconfig_iobase() and et al
> > >      declaration
> > >    microblaze/PCI: Remove unused pci_iobar_pfn() and et al declaratio=
ns
> > >    microblaze/PCI: Remove support for Xilinx PCI host bridge
> > >    microblaze/PCI: Moving PCI iounmap and dependent code
> > >
> > >   arch/microblaze/Kconfig                  |    8 -
> > >   arch/microblaze/include/asm/pci-bridge.h |   92 ---
> > >   arch/microblaze/include/asm/pci.h        |   29 -
> > >   arch/microblaze/pci/Makefile             |    3 +-
> > >   arch/microblaze/pci/indirect_pci.c       |  158 -----
> > >   arch/microblaze/pci/iomap.c              |   36 +
> > >   arch/microblaze/pci/pci-common.c         | 1067 -------------------=
-----------
> > >   arch/microblaze/pci/xilinx_pci.c         |  170 -----
> > >   8 files changed, 37 insertions(+), 1526 deletions(-)
> > >   delete mode 100644 arch/microblaze/pci/indirect_pci.c
> > >   delete mode 100644 arch/microblaze/pci/pci-common.c
> > >   delete mode 100644 arch/microblaze/pci/xilinx_pci.c
> > >
> >
> > Why are you sending it again?
>=20
> Michal,
>=20
> it looks like you don't need anything from me or Bjorn on this series so =
I shall
> drop it from the PCI queue and let you handle it.
>=20
> If you need any help please let me know.
>=20
> Thanks,
> Lorenzo
