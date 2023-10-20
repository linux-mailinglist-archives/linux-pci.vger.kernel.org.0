Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CAF7D0D4F
	for <lists+linux-pci@lfdr.de>; Fri, 20 Oct 2023 12:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376928AbjJTKgF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Oct 2023 06:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376927AbjJTKf7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Oct 2023 06:35:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842E1170A;
        Fri, 20 Oct 2023 03:35:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eie8hEckEEs14ha4gJtlx4iKiWSxWboTJ0GzLIrBT47YmYIH2HYhBG+esVViKlu2ssHOIxQwTftgXxUah7bWEs/VUIOJqdIN/aEcHAoOme0v/VIHxToVlwYsL/s8bdBEiuItjS/hNtmJDOSEGphuzEoOBkrQZq3Z0mX8/Y6JJ3cYuc+42+8KAh6YzJEJ5UD8+OHI2VZxTio7v8TMbRw/dfhdE/9V594Zm4Gg4W20oneWHcR/YWGhCz716DESM811JgL+P3g6e+5QzhiC78aJfRUlg7fIF7pF6siqDnMcb/R+pFtVNcgTmA2xnGygd20R3JczZthcZRLVjWvwx3KW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2le8x+RMQjzghYYr9XRaIW8ILaPqXqW4/Ubwyoda9BM=;
 b=BzRvaWMlSvRKghsrmxHJvQnM1a5JS6gp0PFg9DTXxitEtD5tUOfwndWMEEw//i1uvcmNTw89oE4g31YNiPNjh+LYQ0EL0Zf8B3REIruJ9z6SJauKQaxN1IN+8i/VJuJO9D1VpIgxGViiPRqaFoYC11jX/eWztHuMkCQEem+8qkz4vqYMGZmcgiJXoxcxxM2oWakvzqmd+v+vtaD8Hw1EgykMoa78gaRb04AuPN8utTlOu6oVfJBpyg2cojUnxMwkI4B8G3KPAlml2bUS0ou/8Nrf2z8v+8P6EybysygH5J7hTkzmHh6jofW5VOeUvpl9XFk654tIA4SGpmoBycIFmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2le8x+RMQjzghYYr9XRaIW8ILaPqXqW4/Ubwyoda9BM=;
 b=sKeH60d6HPI97D8BmuMtC3z0Pvofgqd0Fg/agGW12lY/QVlxKujFUBooQAr4UI3DDC3eeIL8YslOARKKRYi0GbZPPnPsHV9DecU07z/HTFk6BwfZU0dUDmzeZJpl8m5K3pqlh5Lc5jPhfGm5HIPAkDpxSlOBVzpdUmXRm/8EINo=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by PH7PR12MB5711.namprd12.prod.outlook.com (2603:10b6:510:1e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 10:35:46 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::167:7f5a:82a1:e2b9]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::167:7f5a:82a1:e2b9%4]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 10:35:46 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "colnor+dt@kernel.org" <colnor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v5 RESEND 0/4] increase ecam size value to discover 256
 buses during
Thread-Topic: [PATCH v5 RESEND 0/4] increase ecam size value to discover 256
 buses during
Thread-Index: AQHZ/+89QXgcS12G7EKSCK4TL1ydHbBSgl0g
Date:   Fri, 20 Oct 2023 10:35:46 +0000
Message-ID: <SN7PR12MB7201A57631FB1E0FB60A9BC08BDBA@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20231016051102.1180432-1-thippeswamy.havalige@amd.com>
In-Reply-To: <20231016051102.1180432-1-thippeswamy.havalige@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|PH7PR12MB5711:EE_
x-ms-office365-filtering-correlation-id: 2137cafc-0d2c-4b7e-9e46-08dbd158520d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gs4iATO2idUPuf24ts6nMSFBWjwIYSx9nqkGvDx9wR/geNv5oYt+HuWX1/VuHv1DzUH5BHCaNGjdW6AkbdS+9FPhzPZSU6BGXVJGSBxv/zXEC5vUmC/GtVv3wzhfocjN/2EJt0Vt3o4qF7uRurXPRZE7d/8ATQuNTFNrf0lKIXfXN92rDTYPQpGNKl9DLMXdjb0giMQHuq+/jz48AeJWJqqk20w4G7elGAwAnA6D2ryGiYcF8QntVp4eRMXoBgTev9QjZC6fz00aSLNdPkIT1eHFoV5rL8KxmEz7KDqxAwgvehb7GM0Lk+RlSpR4UE4sK17r4hACnm5Wc1DkXU1em1hhY0x0JCslMefiXLoI4IP+5OJAc3xuydTC6/B6PtCoGqsDSu+/JO/u+f2Ffogm8Q3vkUt3SwCUbLgiT3Z1CNP58Q5q+kJ/Dxb37JVp3FJCnufvlSP3YnXsX8igfobbKb4nyKfHzpN1lsxjKxwS4ftgqxBmkoHJ0HyQrhABtyWQFU5QuFsWbrWq3YLsHXz+E9KQQgl95+QE/jOAQuMr6WIcQOA4KM8HfMcbrm3VHpyNOMu4cROnGrv9gBw6Ru7PLcdhkHYNg8n+LVvmu7tJjrh1/IXNSqU5hNLq80D623XK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(33656002)(41300700001)(7416002)(55016003)(5660300002)(4326008)(8676002)(8936002)(52536014)(2906002)(86362001)(38070700009)(478600001)(9686003)(122000001)(26005)(76116006)(53546011)(83380400001)(6506007)(7696005)(71200400001)(66556008)(66476007)(66946007)(64756008)(66446008)(38100700002)(316002)(54906003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TgurxyjkJH1v4YlMrmX13F63Ga9rwdl9owytLjBXbZqXDB5UedhQTXBsqipQ?=
 =?us-ascii?Q?x7MQScePOWi1FJoLRLUxtQbcMqWlDRv28Uk5lr2U98LOiiNgNH70nq/EY7s0?=
 =?us-ascii?Q?y/Kw/nDFZRzoPtOs78KlcqnuqJdyGLEsB1laJuNe+OoTB2Qm8R35KMOFMKjM?=
 =?us-ascii?Q?MBPik+XFhIeYyVBtIKIzK8pSZujCCbjbqwlgIKRpiIog+3QPQeUtiIOVV8Pk?=
 =?us-ascii?Q?1DqRzEumesuuqBTSLGZ5yfD74APNWFXo4Pg0Fth3rO1BLfFAxeHv2hs9YOlL?=
 =?us-ascii?Q?5zxKGHPENRFab78BMF01OsfqND3Ln7m3PcOsWOWasqAbGXWgqxred3eavt8g?=
 =?us-ascii?Q?+ljl60peabg0pMn7pgZFXszb0XZYfShH/CPV7DyB8+nxHiWqBFNBNRhXjB1/?=
 =?us-ascii?Q?faN6CgdRWKIutbJ/3zri1KXbSCSMiuBIYbEMYA90ok4G/4+0t7RYNMTyB6OA?=
 =?us-ascii?Q?6Bg/2pxX7Sr58E0THE/S71WCJppI8VMopUFWJC/FMIthjabF45dKunFD754Q?=
 =?us-ascii?Q?TW21NKjDdADW/B8GhkmSkcWi+XVfW8c9GG5TLV3lyhIuyZDPuk4tKMu5MT7i?=
 =?us-ascii?Q?ieJR3Ih9ile5JXcWiaKMsbQFow3YBKTd3paC1+9/tX2V21+qXjaq3GoNlVCW?=
 =?us-ascii?Q?gTlbOfMclhwzJpsD+HsixjgZyYohEuuMUVYyEve9NY3h19rTDgDtDNjNJhBw?=
 =?us-ascii?Q?+Pj3zFi5maMgNmU8bYIr5PLYnImnXV8IJ4X9kSeeopoW1mpvl/drJQ112flU?=
 =?us-ascii?Q?8GLf/PA8z87oXfEKbe6YDupf4IO3ho9oekYNBbnvVxxBt7EdVxnJDw+LNxjT?=
 =?us-ascii?Q?krmUySFbX8I+eqkPzEpRWEbnZnLqrtRmBOCvMVgPaHhW5oiqzSBU9fShYujY?=
 =?us-ascii?Q?GYG7THU4wgXgnnwZMtHYJREeSeak4uV91hSGb1VIHGEAwQH2yrrqJ77LhPX0?=
 =?us-ascii?Q?zH4rJEGGYZeRGAAH7i5quT2WatUxdbQZ45HPNxHHUyNKeEAhhBdCk3MLmbIJ?=
 =?us-ascii?Q?OnFJmrYS0h/ELls4kWtWLOW/OFX/E6Tyc7YF2vOTNfr+Glnq4YzfG/aCvXb5?=
 =?us-ascii?Q?WiBG9NplEgb1B/nm0htAffIlVV4/lRa6ZSz7Wu3IPXHW+/5PStZR2tfxEfqR?=
 =?us-ascii?Q?97QTVZDnt+C8gT1DN0LCiEYjKHLN2H4pT8Ms6MYbnecgtsAuU+PS0GANLog8?=
 =?us-ascii?Q?EFEkolRUdHVbWAi96rz2mCRB+H7TS+Raz8I+TLiJ2qHJLvgQttLxWuUrki24?=
 =?us-ascii?Q?82ZjlJJ2CWsXJdKs+9h0Cg6qmzV+YdvBpCxW7gUQL7qi6TfpyvVlFS4iq3f6?=
 =?us-ascii?Q?k8q+QyYvimfw4y2eoUBUz9zPopeyccTVdL4aiMJQSM5V55Kmgh0HmaEBXqr9?=
 =?us-ascii?Q?e/GAGrR0q7jf3pZ6Pfvkg6fCYrmK0uH1ZR+Add5g+hssCXMhJqe6ssgYMX4n?=
 =?us-ascii?Q?0g6ohgYaYAoIZcgQGJivu6l0Fl1mPH1sSdjpgfxHod1fUf2HvaxlUzu90d2M?=
 =?us-ascii?Q?C6bkUs/5CIU+3d09buHa8mkThCa/9Fc5W8T89AxdviAyHc0IpYyCNhl8r6VM?=
 =?us-ascii?Q?q8DD9xCPgyDgmBSKNJo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2137cafc-0d2c-4b7e-9e46-08dbd158520d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 10:35:46.7009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NEKIA6ZZHm25pB5RWiuidJQZxYg9fEvAEmIYZ4xq7XoFJYsi29aPlkAPwjcb1lhNH8diISyKTMkucKeG/TCn9A==
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

Can you please provide an update on this patch series.

Regards,
Thippeswamy H

> -----Original Message-----
> From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Sent: Monday, October 16, 2023 10:41 AM
> To: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> robh@kernel.org; krzysztof.kozlowski+dt@linaro.org; colnor+dt@kernel.org;
> Havalige, Thippeswamy <thippeswamy.havalige@amd.com>; Simek, Michal
> <michal.simek@amd.com>; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>
> Subject: [PATCH v5 RESEND 0/4] increase ecam size value to discover 256
> buses during
>=20
> Current driver is supports up to 16 buses. The following code fixes to su=
pport
> up to 256 buses.
>=20
> update "NWL_ECAM_VALUE_DEFAULT " to 16  can access up to 256MB ECAM
> region to detect 256 buses.
>=20
> Update ecam size to 256MB in device tree binding example.
>=20
> Remove unwanted code.
>=20
> Thippeswamy Havalige (4):
>   PCI: xilinx-nwl: Remove unnecessary code which updates primary,
>     secondary and sub-ordinate bus numbers
>   dt-bindings: PCI: xilinx-nwl: Modify ECAM size in example
>   PCI: xilinx-nwl: Rename ECAM size default macro
>   PCI: xilinx-nwl: Increase ECAM size to accommodate 256 buses
>=20
>  .../devicetree/bindings/pci/xlnx,nwl-pcie.yaml |  2 +-
>  drivers/pci/controller/pcie-xilinx-nwl.c       | 18 +++---------------
>  2 files changed, 4 insertions(+), 16 deletions(-)
>=20
> --
> 2.25.1

