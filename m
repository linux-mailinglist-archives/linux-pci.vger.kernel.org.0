Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4095F27CE56
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 15:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgI2NC0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 09:02:26 -0400
Received: from mail-vi1eur05on2089.outbound.protection.outlook.com ([40.107.21.89]:40513
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727495AbgI2NCZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 09:02:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9Ye1oQClpUYPWcO7HVTF4nFKP2Z9yBGRIlpwusAfOrU2DVHayvHQTc7FlUFJrDgHfsLneg8SE7lZaEZh8BD+TODVvAr2cB+2mXlaZ9F4f+RL7SHi8MOvpyls310syzR8Igx5MY8wIAOb0OsQZXTZXiFu9g9fRi3mJySyjCrxY9IYAyoYs1Y41Sa0Kgx58FXYYl2hHbZqqy0dvTEG79Rgpn0DG7BVTYtG1RXvKjtGo2ZIrehhxs29djeiZVxPX6TbS5Ir5gqEa8ipzObNPhp2ArtHozTergYaGTvasY9fIc7RwfRNd1eMCzfWobtM54hKvCfO4scywaOPesr7nV5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pP5zbVeCGwVbiNx3blaVYZj2HhtSPAh4L15dToe4Ivs=;
 b=TIX92wTGwmyiqYHPrUBj7Uu2Mh639vNiMUMb2yfHclZNu50sxo36E44NZDZ9a897r1Iyn6ChgVrAvFcxreWswm6ONoPtrSTaHAeo3gvMmjhZKlipy/juXS/B/jHX6n4DAXkSlyjMakhuTuhos2Kt5GYLQ4IuGtVH7Q/1Eys2TRuV4sWzjL924AHgCXat+EnJPH8g5Qn6cx4MCxFa578Hg1hzfSrx9XhZ1K0GhUmU1F4eV74Ytc3+B0889E9gP5JLGRTWAqo6u/QkSfV8Mdy/qXQ9iYYU6nbK/dAXvSUpIOPhJ0mYLFh/ajQ2hxqF130hkRY2trKEAmXEJy4R2i2Ntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pP5zbVeCGwVbiNx3blaVYZj2HhtSPAh4L15dToe4Ivs=;
 b=CRUhWNpqmGSq7EXqcW74PEtImtkk0qS1D6qN6u5gazzJuWIog01Kg6TPS32mgf6uJa3xavShSWZdJd9ZUzCuBwGabQvs3g6oIrXDXuqR5Wf/vSdfo0VJ6BVkDI77rQ+4Bw+e35/QG75nJKsK9FNGVuXe4fS4Zt+v+fwB2x2O6Z0=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR0401MB2381.eurprd04.prod.outlook.com (2603:10a6:800:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 13:02:21 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 13:02:21 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 2/4] misc: vop: do not allocate and reassign the used
 ring
Thread-Topic: [PATCH V2 2/4] misc: vop: do not allocate and reassign the used
 ring
Thread-Index: AQHWljzyKmM/fdkzH06RNY+P7PsXKql/aOeAgAAnh9A=
Date:   Tue, 29 Sep 2020 13:02:21 +0000
Message-ID: <VI1PR04MB4960404C6A13953B137AD39B92320@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20200929084425.24052-1-sherry.sun@nxp.com>
 <20200929084425.24052-3-sherry.sun@nxp.com>
 <20200929102419.GB7784@infradead.org>
In-Reply-To: <20200929102419.GB7784@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [114.219.66.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1cf41a15-fa60-47e4-3a50-08d86477e735
x-ms-traffictypediagnostic: VI1PR0401MB2381:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB23819A62C21BB4630FBC63E192320@VI1PR0401MB2381.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zNgirzrtWC8FJxydcCHg+MVUxaAcnAwMt1ctq3EE8Eo8Lc71MOHBOL/+WbM79xUsGGB2tRk0qcd5WiO3ujAIpjQUkDkSsrkX1ZdcMM9rwrpRdDzsWubpltROHYrTBrJcZ/CTkaSqi2jvB04Gh5cdbaODouWHrchzNZt7bZwVnbpJjjd7xhMbZ769LqQZLghoWawpMdzWs+2w2MAaRcQdoD1R2BUTAF7UIub1PPaYf4oWeON7T4TDTTwkY3cbtLqh3RjfinDMnaip8+ZkyPfwOLhJxZ3dNJ6Ig/SIctoRpmkrdwriTp/Mr91vRhP2Uq5IODqUsauHdiHE0LQqg4nCWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(366004)(39850400004)(376002)(316002)(44832011)(71200400001)(26005)(186003)(54906003)(83380400001)(7696005)(2906002)(6506007)(478600001)(76116006)(33656002)(55016002)(6916009)(86362001)(9686003)(4326008)(8676002)(5660300002)(8936002)(52536014)(64756008)(66556008)(66476007)(66946007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: DN9jjY4HFheI7FmbGb8aMhmsX9RRz2PX0fNeXsZLtUMH+w1YupeZpsGCvpbVh80UpPx2e5zea2lBV75B+wzRk63yhc5y/O6pSzlMK6JPyAW0v6qj8ElyMijzwHp7UOxOqLgROrkHGnWtjfjuinl+e/nMqdsymDIu4JVJWVhR6nJ9Mvdmlmlvd9xwNj1jLSdnf2F4kc1ZutucGRY4qItXnqsP3eQKsCYZ7QOPjM3+dPr6VCvPZfKp6twP/n2E5deyR8VsdqHbiMrm4hR4gRTAKfMXEHEdADn0yS+HnZAXAE0xGGPzK9LWVx+/cZI06ps4YXw77PM3AmZX1qE1Hk8o0N3ATuYPB8O0RHhNFECo6QR8Za2tJ6Y7MA4BfvMR39lB/+4jYVgQfzcfqQKXLcetOrmy0mLY5jdmzfxdjOwrAxAIn3OFxemvFn9KyexhBycImn9AjBsHsBqveaHMgMrmBQ4MsgOX7FWGzXZ+HMeBOx089p93OxCKkeO9uttOSrGuQivPDkLzqU0b6PA1XPfU0nzkW+8oo7TXx7+HCDc1bIlltj/UoHa9DtpWu/ASFQ8R9Tu8Xl6W43nsJiRwyeZSLFCAv3YND739t+E5TRwBjfeWgxQ3fLKT/RQ51jgDreVZfYP82UiKCSkapGRo9KMdcw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf41a15-fa60-47e4-3a50-08d86477e735
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 13:02:21.4576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DGAmx/cldSxS0dMuvZ+Trbc8+ss2XedkGCWtO4qV5glaJnc4PgmxKR2go9L7uzcIcrXtK9YTQ2SFwxd9wJ9y0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2381
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph,

> > diff --git a/include/uapi/linux/mic_common.h
> > b/include/uapi/linux/mic_common.h index 504e523f702c..e680fe27af69
> > 100644
> > --- a/include/uapi/linux/mic_common.h
> > +++ b/include/uapi/linux/mic_common.h
> > @@ -56,8 +56,6 @@ struct mic_device_desc {
> >   * @vdev_reset: Set to 1 by guest to indicate virtio device has been r=
eset.
> >   * @guest_ack: Set to 1 by guest to ack a command.
> >   * @host_ack: Set to 1 by host to ack a command.
> > - * @used_address_updated: Set to 1 by guest when the used address
> > should be
> > - * updated.
> >   * @c2h_vdev_db: The doorbell number to be used by guest. Set by host.
> >   * @h2c_vdev_db: The doorbell number to be used by host. Set by guest.
> >   */
> > @@ -67,7 +65,6 @@ struct mic_device_ctrl {
> >  	__u8 vdev_reset;
> >  	__u8 guest_ack;
> >  	__u8 host_ack;
> > -	__u8 used_address_updated;
> >  	__s8 c2h_vdev_db;
> >  	__s8 h2c_vdev_db;
> >  } __attribute__ ((aligned(8)));
>=20
> This is an ABI change.

Yes, it is. But I noticed that this structure is only used by the vop drive=
r.
And until now I haven't seen any user tools use it, including the user tool
mpssd which is corresponding to the vop driver.

Regards
Sherry
