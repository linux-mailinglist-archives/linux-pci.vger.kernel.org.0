Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AB427CE55
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 15:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgI2NCU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 09:02:20 -0400
Received: from mail-db8eur05on2077.outbound.protection.outlook.com ([40.107.20.77]:39777
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727495AbgI2NCU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 09:02:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STiaiaXDpH+Z+gk1TrQfA9d9jZkWzbn5znaFdA2lS9QYF7ahvAi13oA6/+Do5OYpGE8UtvZw/klctn7yBsDgDoJJhGoBNz5cTf+CDqPQT2MvXC8PMPtCyS9qhndUdr+FP//i7OFFBXWdBN9N1x5fCXGdVWFLgrNc+3cOjE58/oEbX6ebGU/a2jTvXVw4+J3ovgBLgqoASW2BOY1Cqp+IqYZmRfZm/cRHvd60MCgHdZbPEWyqeKN7z84gVeX4cBQbG9zzp+k5THqDDXQHx4vK99/1E3JpidlIL1RD4PUIAO771SSarg5PLb8OPR5dUHAR5vXzuDJWh96gPP5lbytlHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI57TuLhnQ8QWFruBYaK5dSs+LfKPVROgZH1Q2ExHS8=;
 b=oJg2uDvsWpjiuGWDA37d+GLbRpB5LJF7CxfBrOhoiMe+ysFRUvKAUqhvrwk3LPdOYXGkqEGp/nHmOV6UnIhYag6pq5P5fIBITBWQiPYfeIUBF+ezBzHsTUdQCvjugLwNpJTWogP7QPrhD1qBfu37M6aKSpKvEx2ed7HK2Rkb1vmW6ztnsFnUmyVRRrYWC2sjr9U5uVXpgiTVKsa3pFQTtyGuXX9xHyq8OMZyDo82eNfaUb7HvzkBxMBe2IytNkJUNO5HeObVpj9IfQiZRfGpnGsbRHZF/l2ToklePbTVKo9OyM0ZPyyDPR2xiGH+hh4NlEgPKduY3bsk0wDVq57whA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI57TuLhnQ8QWFruBYaK5dSs+LfKPVROgZH1Q2ExHS8=;
 b=rTRNimmr0q7Bve4ci3OQGU3RwiLxvfTN4njBuHvCZhtasrwB3uO4Cexd1lVsirHkY3KyBWaP98CsaVYbFHHFgmLlloNPhOPhAbTZHPllkU93MaWrDes5pG61YEJ+J9rcnvqfNv/l8Pc+A51pVTVaKO/U3Laq2J19OWr5jspRc10=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR0401MB2381.eurprd04.prod.outlook.com (2603:10a6:800:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 13:02:15 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 13:02:15 +0000
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
Subject: RE: [PATCH V2 1/4] misc: vop: change the way of allocating vring
Thread-Topic: [PATCH V2 1/4] misc: vop: change the way of allocating vring
Thread-Index: AQHWljzplsyX1hz4OU+a360o7kgHHKl/aLCAgAAnNWA=
Date:   Tue, 29 Sep 2020 13:02:15 +0000
Message-ID: <VI1PR04MB4960EC71CABE17C0556EBEBC92320@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20200929084425.24052-1-sherry.sun@nxp.com>
 <20200929084425.24052-2-sherry.sun@nxp.com>
 <20200929102333.GA7784@infradead.org>
In-Reply-To: <20200929102333.GA7784@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [114.219.66.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 19252d97-71bc-4768-1dc2-08d86477e39c
x-ms-traffictypediagnostic: VI1PR0401MB2381:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB2381542B67A59D3F774951D792320@VI1PR0401MB2381.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yQFGb/kSWCgk/GuA2b9K1I4ediHWdVigLESMPU9BxeAGO4/Kni8mxXj+JGkRNTOUWW62Q6VnDcVBNKqlo2/Ktj1hrF36GNx8Z+I4mc1ppjLFtuzlVwKoYv0gQ7dTDuFCfJHrtSVZ6Q47bpCxEjuhRGQioaJC/I2/WE46uxtBo7pYWpybb4yFTdJvqSRNgQdPqpxY04vsXGL2c39omV6SPOdA+aN1il8onSLMVSPYjnoKVIRe+CG0o1bC0+teltEfTfQdZVYcpHnY7kLLepRnm7eUwUc8/pTjACE/nZ67cDX/kvUKS7GS/yfvDROF07WCFGHNOvF1VJDrWdDb5oxcdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(366004)(39850400004)(376002)(316002)(44832011)(71200400001)(26005)(186003)(54906003)(83380400001)(7696005)(2906002)(6506007)(478600001)(76116006)(33656002)(55016002)(6916009)(86362001)(558084003)(9686003)(4326008)(8676002)(5660300002)(8936002)(52536014)(64756008)(66556008)(66476007)(66946007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: X88Le7MeAhduSld4O1j2GMirTE7O1bkvoHSBZzAKxCZo66e3bxeZRkyUNmTbfnLrPD23uUQI9BaX8SwP0feUUNF1HN5IqzH4lnFklqWw4iSzKfk8Cqz0vpceDfEwMwMEpCDG2QhJe9o9sLrV20Qs+qsjgT1l9bxKFgIYbsowbr9/gGVA/q5EP7QPLeyGAyDoVy/0nm/cS9eYP20Uv4/+u2tRxjXjLbPSOkl0MKlTSGh/LNrYhRFNC0wom7BoeySLVrdZjglnags4l3YoOcGi4opU7E1AoiL5mtDY1RQ0xqRyCp6M1WrTEmcNQw495q92Qe9/zvsQL5q5qd8cSF2g9xvMcegNMj2i2k79yYADuPDNjoQZAIeuB8PopSgF/5Jh+SKvhppJi+BeLFMhHMHEL6rSfGDq8Nwnw6NUv3DOGF4j20jn59aM6AkjJ/ij7zWxTzUytC2hj+184d/KFgPyZB4luM7zhk0ve73GZVE2JMmYNrEcFjo6GfiL4r5/J7hPGCofh2xQoVoxZFrNfd8sgVo5LfaYTDeAuWCLefdF1KaJ3doTnI4ilaJgN5iFnmYYytdQngyI5G42PUuq58kinokiNWt7NJvjxIFsw1fYLRzMYsYr32mqFBhzxgYekvOrUoEL/PgQSoragUKejEDqFw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19252d97-71bc-4768-1dc2-08d86477e39c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 13:02:15.4570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RzCEGL9liEx5bS02uiJWxzbZgndWpj6q7X4z49YbnodyfzyYIqyV0lzkPU7Q0StYhdvRJzpJ4/BwtTtnpwtUpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2381
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph,

>=20
> > +		vr->va =3D dma_alloc_coherent(vop_dev(vdev), vr_size,
> &vr_addr,
> > +GFP_KERNEL);
>=20
> Please stick to 80 character lines unless you have a really good reason n=
ot to.

Okay, will change it in V3.

Regards
Sherry
