Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBFD7A64C2
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 15:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjISNV4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 09:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjISNVy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 09:21:54 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC384FB;
        Tue, 19 Sep 2023 06:21:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzPT97EaRmRATA7xk7t5Tjb5JRxH7kwWmzBmCuR57ahZSPtt8XOIoGh7cYw+WeGSlZPK4iqOv2PafBdPDUqgUiSuSt4O+aa3JYd4NAOJQCMVx4enwXpAXR0szTEzj01fbU8zN18ubpbBmvBDMc2GdCdsj9nS6pXJ3OQGnz3X4E66+AfqfeL3+bda8OAbCvEgtd++AOls9LGtbKd5ZtRoIGQhjHJbS027bse7sfCBAHXCyLq/CKtyzwpPZxny83irP8m9NdWaneglmotQv0ym28ygUKedMtV8BgzKzWh6AYzBytxyBH+V2qDk+FEC915fLv6fpKF5wgVIsWXA8CJ8QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGL/HUdqNqR7I43DY/ApVVkTEs775mLeYNKHuLgBa0o=;
 b=SrnaG6KDEPuUeBytPYba3Lgkn2UmqMftUJXWHvizAmOj0g6jGyrpA9L4EOsOywqNRX0Yt2QeRIVZqGBTdFXaGv5AIHg0QuaHdc+CnE/sNmM269lJ1T0LX+0dBM5lyyy2Q/oZXlZtjmR6Y7v1F9AtJKk0BhPMXzGo44TKzZLVi631MVri3dr7WNW08vWN/ngRzj3WMwSAppawV8doza0ywKGQVW4/EgQWT2noZty4fe9q0uIWCevV6HOpyMaqQUSVkK/CTBAVNx756mQLlpjdiyI3pNJVj8I7nd10jDWGzt9wO980uxPNAmf2XGmsk40O+4SzdACean86Ta+mOqUGcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGL/HUdqNqR7I43DY/ApVVkTEs775mLeYNKHuLgBa0o=;
 b=jdlIhs81wTsdK+9UCQZcrzaPu0jU05PM7DBSiIFSIUbRKFJcV4MQzt/VQbFSEIvHKLmNWESrc71vokWf/3WuHkcPlZbxtKBcnZrHTaEbEXiLMdimXzuVHJlu/0trGCfW+2wbvI2fnvK6Tl8AEBr0s0qhWqTADHGwA60TSkgWCao=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 13:21:44 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::167:7f5a:82a1:e2b9]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::167:7f5a:82a1:e2b9%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 13:21:44 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v7 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Thread-Topic: [PATCH v7 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port
 driver
Thread-Index: AQHZ2yFzmgP1DqzAKkibvVhsFiULHbAOF90AgBQp44A=
Date:   Tue, 19 Sep 2023 13:21:44 +0000
Message-ID: <SN7PR12MB720159F33F53B40453111D128BFAA@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20230830090707.278136-4-thippeswamy.havalige@amd.com>
 <20230906172500.GA231799@bhelgaas>
In-Reply-To: <20230906172500.GA231799@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|DM6PR12MB4156:EE_
x-ms-office365-filtering-correlation-id: 21672961-ea5b-4bb7-2973-08dbb9135e67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pw5utAEkIOnulOSr59JHZ4ulF04DGIkbps8QkcYMl6pBCpL4YQL1zFW4j4X7ANvE7QiBz9uiSoq7oLHnSXvD9hquR2ZWzmSjexHKILfdIBBey7FaNenieq4nHdFPBXgUxiMq9BAxoTd9kgIiVmA8ai5r94wfkK2RSsJa9n1BHSR8LTb3US89pF84dqFd0UwpTfMKV2SqHoOQOCgaZE4S8VxTBVUyuhKutqgH6D1xvjq5m3T+zeMkHRp68IoZoJIjQLK77yAgC31fuBr26SfmTmLsifHzeWLmse1erp5dCI4kKsdxcfTBNg9jdP7jNb+iGkvXExxbndm80+6/F+Ly49+D1B7jegZVxuhW5S9+wPFJ2+LrUzSrkc9pdcCT9q67UVvrad1PrxaQHRQqTVpnSYnRQEbJUMtV5R5/s2NQTKFnrgogI3i/QpfVzJVTcDXGFpzDj04zcMZfzOKiMmpWu8SMNqjVrwFOMpQJs5BnzVVKCGnVLmn8pl2heI9inA+ZcAP+iOiSNS/6q3ojs1Zs+RumIw2oJcrNKWtoK7XBRUvREmlYZtws95EMi7CqLLMPDy8BJyNwW6H5TZdSfu96M1ngjgkuaz3RJgikfjwfRgjTJvhAx1tk+Ym984R/mwl8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(396003)(376002)(1800799009)(186009)(451199024)(55016003)(83380400001)(9686003)(71200400001)(122000001)(53546011)(6506007)(7696005)(41300700001)(2906002)(66946007)(76116006)(66556008)(66476007)(66446008)(316002)(54906003)(64756008)(6916009)(5660300002)(52536014)(4326008)(8676002)(8936002)(7416002)(38100700002)(38070700005)(478600001)(33656002)(86362001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?neeA9+g5XvXV0xInR/naQPdivkl4IXB5nbZvzXt6SsuPH4TNeFDAFNQMuYeZ?=
 =?us-ascii?Q?BozeuWqoGaF4J3EnJ/mOE68N6vGvaqPPyMQhKjFUlTUjxFO1UsgqgJeGpigv?=
 =?us-ascii?Q?D9nShIX6NJpksVe2RMzGhWyKur66rUypKp4Fnzw/rB/DsmBTSEeeb5dPH5tw?=
 =?us-ascii?Q?2G+RfiEvhihWkZF+97Cc1adGeemIPuOwAI9cnUxOXga59NxYJj+zbfPk2Ina?=
 =?us-ascii?Q?/CERAgp+lbRfuBuILWGC1HaK2SwPbWXlfSz3eB+TBf6qjfavcirSAL1m3L3X?=
 =?us-ascii?Q?flgn6ky/z4Rn14Fbs2qCukA9BFjsWNwRcENlRoB9Qf6KC67WiQZxVzXt6Un3?=
 =?us-ascii?Q?wlOjqWFB5/+57MUWsu7eawO48wqDobaluff1LD7PUcfDCVgilyOyi07dmhwr?=
 =?us-ascii?Q?zyrqPjFxC1+fCIX8Wxnc+KpBH+Qbb6Jofe1Spyna9MZI02ex+gISxXtnnELP?=
 =?us-ascii?Q?JQnh2sTH/3BvtqO6Gyu3RY6tdaIqDqqgSRtzyY88EkmQ4lbswpeM0cGL2wCS?=
 =?us-ascii?Q?mXFI6NimSNKlLWes03Nc+ZPuke3KO27KrlYEB5keRAqxbfOAtpWiE3NFmbQ+?=
 =?us-ascii?Q?r1qj09tw7x8vjS7mtHwJ0kWRlmAlz5xUssMvydYiLo0twwVkiw77E12cV8sG?=
 =?us-ascii?Q?/4Xl8jpHuDBUQCN7tNOTHBVuylHFl7flWwEhrMMxG9eK9AN+/Gew4YIcVPK5?=
 =?us-ascii?Q?9SV+vsOuYG8c1BaiZsWzWFOhlHGRAGAasECmhg85SxPxF4SOvLLC5KoMzWLh?=
 =?us-ascii?Q?WrdO9ndkzlQDfRpDpK6xSUIWfpMgTzcEHHa1arhKDsghm2rE7Slcx8IOJvpy?=
 =?us-ascii?Q?k0RX2oKjO92NipWRjSyhfvgzQxfP5F2XnsHmR4041eDyCUNxa6e+ZHfim07E?=
 =?us-ascii?Q?tLG8vXFrc9C8ej5W7jVXOy8E7WfU4lyXbqukKDSl6lVdEqRbYdEqWs2amD1Z?=
 =?us-ascii?Q?RF/yT/2eNA3vJ866ZRRY0F7Ma6iVLLN+YXtUy5Rax3S2f48WH8Z5BZD12N7u?=
 =?us-ascii?Q?3SAsJKwXx0zwh5xRBTkh8T1XUg7vd1saoisEKuV+gY5TGsLF0ZmZI/P4Oqzm?=
 =?us-ascii?Q?KYBkysa7IJ169THidPBUpZsOYUmjkYKZxMRA6kHb9etHSFLtfijtiqQQK+Hj?=
 =?us-ascii?Q?Cec3FWyBgRIeSj6gTT1m6Hb0kw/L+kH6QWUv6PYAQbfmdfnZmtyg7nZ1U+bY?=
 =?us-ascii?Q?+bD24ZWa8Ir9C8KPLRCFC9lYXNcgeHvIIMq9Sy5Yx2C9zKmKGDkwbqhAH0gk?=
 =?us-ascii?Q?YTFRuCzX6iCgtivzA1+vx1eCUEeXO4KHG0CWPk7NXkWvYsJBGOharySjBWSC?=
 =?us-ascii?Q?R59PXlnNH4sGW2cXyBAS8qiT3QnTHoW0dtBebmKF7q54f7NC4YhHIqa8Vq8B?=
 =?us-ascii?Q?fPnFGIG/+qiikO9tQIOWhxWwgI3aZEo11y/b1iFaZU+sMis8Mr5I6CuvQAeA?=
 =?us-ascii?Q?xmAt+yg5EV2DT71UbOPsKedQQueiv+kMwgtOQlVhn1iL4BOgjcYQ68g3Jwy2?=
 =?us-ascii?Q?4QX1qaYw+JMnJjIOvwKnRwVDNR+CUqwwt95n9HFt4LJVCgFZJB+seWs2rD63?=
 =?us-ascii?Q?5ANZcUufQrQFELcq4IA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21672961-ea5b-4bb7-2973-08dbb9135e67
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 13:21:44.2233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aM+JaTvqMMufF+G1YCkIhPyoT2AI4BUIyHNXDcP4pdJGiNie2R3W6CN7Zi90Y5ay9UkV5xjdB52yxG5kxRD7QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn/ Lorenzo/Krzysztof,

Can you please provide any update on this patch series.

Regards,
Thippeswamy H

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, September 6, 2023 10:55 PM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> bhelgaas@google.com; krzysztof.kozlowski+dt@linaro.org;
> devicetree@vger.kernel.org; linux-pci@vger.kernel.org; lpieralisi@kernel.=
org;
> robh@kernel.org; conor+dt@kernel.org; Simek, Michal
> <michal.simek@amd.com>; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>
> Subject: Re: [PATCH v7 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port d=
river
>=20
> On Wed, Aug 30, 2023 at 02:37:07PM +0530, Thippeswamy Havalige wrote:
> > Add support for Xilinx XDMA Soft IP core as Root Port.
> >
> > The Zynq UltraScale+ MPSoCs devices support XDMA soft IP module in
> > programmable logic.
> >
> > The integrated XDMA soft IP block has integrated bridge function that
> > can act as PCIe Root Port.
>=20
> > +	if (!pci_is_root_bus(bus)) {
> > +		/* Checking whether the link is up is the last line of
> > +		 * defense, and this check is inherently racy by definition.
> > +		 * Sending a PIO request to a downstream device when the
> link is
> > +		 * down causes an unrecoverable error, and a reset of the
> entire
> > +		 * PCIe controller will be needed. We can reduce the
> likelihood
> > +		 * of that unrecoverable error by checking whether the link is
> > +		 * up, but we can't completely prevent it because the link may
> > +		 * go down between the link-up check and the PIO request.
> > +		 */
>=20
> Looks fine to me.  If Lorenzo or Krzysztof thinks this is ready to go, ma=
ybe they
> will tidy the comment above, i.e.,
>=20
>   /*
>    * Checking whether ...
