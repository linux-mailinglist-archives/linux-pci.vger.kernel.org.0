Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0F25F698D
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 16:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJFOZP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 10:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiJFOZM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 10:25:12 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44A09B87D;
        Thu,  6 Oct 2022 07:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ah9/ZY9IdglxqR670EVZqKZxReywHiwVxPNoY8vajWOlNtZE0fE5jlFZbw6NUCxr0NgAnbEghdfpU/3VjzH09u7XBEBjEACFkmncNojcwJuOF0uPDjEaJK2dU/a0eYDJJRQweqxU3xPQJX8Yb2wwZ36qn5mGYIYPuEvpCeVqWt9hhmTGdJkS/D9/M/7CXI/mcdLrHhWhzIbpmU5IbX4cQezI5v9+dEU6LeyjPBTX4LQFFVie4GpfRBX3k39tav8UAeipTikq3Nnu/O3UTqYHjHY83OFB8Cu4Fz15y85CK27kCBUsOsCDb0Z42ZvUQ9ntwk0iYQIgjMNghwWyGnZ4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tf99DiRwRqbn2mngrhi6vekH7+yJs8QtluYildoR9lE=;
 b=LeNEVbknZkqVt55ndP2KR6EsiFJvK6mV/v6HjxXQfN7FOZ/jOqbFZw55CE3SpYMN5g2pWSrZwlqhcFWiFgjgwMZtKzZ3qYrajrSAEhMieS0O1EktupHamq4dldRSl1h+iPK0eBPCnJUjtw0exuQH5V5wFCZ8ZHB8M3PW24HbmI2NyiRrYxsV2DMm0Mfr+m4zA7RYlGI91x02JZMYsKLB1NE7nZmunLvsYuHJ7VJcpvrSbi4IjUrbeehyDIE++kS9ZQqeTnzsSNpiIK+7wKTyUwTysW32J2lNw7OoaqSyB8e2VtUswrhgEDN30PNOCXeEqlTtUTgVX7rctjgFp3wBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tf99DiRwRqbn2mngrhi6vekH7+yJs8QtluYildoR9lE=;
 b=ZBunnuG50BHBB85FDucxRh++s6S2RqXIR0IGMyLCyov6wv4tW7SotaSlgyk9gFTAhCY6pSnjvrqhW1BmNXa2R7fdYVg40pckWUM2LSWUyWg0dARo2P3bIUJdwf7h0F/B/NzLRxfJ04h1mwyLJxDN7iBe2PUX8DsMPTwXtGKwm/E=
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by PA4PR04MB7981.eurprd04.prod.outlook.com (2603:10a6:102:c0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 14:25:01 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::54da:4ebc:2916:de90]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::54da:4ebc:2916:de90%5]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 14:25:01 +0000
From:   Frank Li <frank.li@nxp.com>
To:     "maz@kernel.org" <maz@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        "lznuaa@gmail.com" <lznuaa@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
Subject: RE: [PATCH v12 5/6] PCI: endpoint: pci-epf-vntb: Clean up
Thread-Topic: [PATCH v12 5/6] PCI: endpoint: pci-epf-vntb: Clean up
Thread-Index: AQHYzp5PKV9VXb3LkkGiX0nXcRXkYq4BgNdQ
Date:   Thu, 6 Oct 2022 14:25:01 +0000
Message-ID: <AM9PR04MB879387C0B0483E55B13DC331885C9@AM9PR04MB8793.eurprd04.prod.outlook.com>
References: <20220922161246.20586-1-Frank.Li@nxp.com>
 <20220922161246.20586-6-Frank.Li@nxp.com>
In-Reply-To: <20220922161246.20586-6-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: helgaas@kernel.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8793:EE_|PA4PR04MB7981:EE_
x-ms-office365-filtering-correlation-id: 0815aefb-eb0c-43bd-fa06-08daa7a68e12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JvlByC6RjC0OgQTMl2dTI4NsvKxX++lrom1ZBuE9fNe2qo73agS0l0/9L32NHT1/ErrjVFkbUb53cBU4C4iw9CmRa6bUu0kAhuJPaJNkOIXPqMk+EfSUOXl6NNoUVbM+yoajS8+5qzjeb+3KvZ4mKQBkqLuYNEIpp3/b0ugyG5jndKMKx9/+GC5OQXBjbNze85QR6dk/629zrb//pjhWC+YsmdKcCwCNissQFpmOfwRWv+OPLp3P/7lJcpy9/+zWrdmLqMZiR1FM61XrW1BhYvbmhTocIeXg/gOaTU2Pwue7auqvMXTuW7KaqL5rNwFx6BsSfrFuHyhXHuxCTV5DVvMjRYh+Bm2aTm/aLQeiZHGjRsbDfsIF73+837C09y423CfHPwm7Kds67xcqHmlSd0KsyZgBOVJxHFjXyUEgGcvsEXqV15YznBKWCBSKW5b5NuuyombrSSRDiB1oAyFjjmGo27MiqUR415Jb9Fx16y2GppihxKVE7RWsgW3GJx9G79BLX/AOkocU6OPs6MRWEpFpi7DFibdYZIaBc8ZmX3ZdI5ox158U4WjAqH/NEslTZDqRPmTaRhzRqVDMEYG4fJifILiG7YGGlsjqJ3fKV1OA7CC0Qje6BouslQyLzUl0EE7vSzUqXSxqi4UJXBGFVVTS+ltRm+nqi6Mnz0opvLg+CWtDdVnRIcAs8XJTVTbCJu1NhHgiMGX/U12XjHxTvClByAeDQjIECNrUkbcEbyOZfI9VjA7KKM9LdMu928F5sCwF76KcFzalLSNWbw7EEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199015)(66446008)(8936002)(64756008)(66556008)(71200400001)(66946007)(4326008)(8676002)(76116006)(316002)(54906003)(110136005)(41300700001)(478600001)(86362001)(55016003)(52536014)(66476007)(5660300002)(2906002)(30864003)(7416002)(44832011)(186003)(33656002)(38100700002)(122000001)(83380400001)(55236004)(6506007)(53546011)(7696005)(38070700005)(26005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YhPlI94hAKiIZfR7SsePpcdTUQ6JO3NQX8UCerwm0SlrlNtekmNfaFFbjcBO?=
 =?us-ascii?Q?dUM9XsdyGa5gv+1cf7U5hmtJxVU8Maf1y/oSPWc75X9qv2BesXncXSp+IOUD?=
 =?us-ascii?Q?YBeaccXCM/I9U4yUFuWulAmZEBA75ALQzyAnrIcIdSjaTreM6hZ2Ca1pKi0C?=
 =?us-ascii?Q?BG+xSFHeh4rtpSB17MQis/4uXst3FZsP5eMey4uyXNO2JAwPf/+8VhhZB0t4?=
 =?us-ascii?Q?231vkWmSHFRed7jExvgfaWPJT4oKQfTQQ0t9e18nqS+0oqp+BzbVgr9VqAjm?=
 =?us-ascii?Q?nf0zkzIxbPNne+2TLZjUQq2HLIVpZZJ5XjjiwlNJm49mNkzioOizY4cRc8go?=
 =?us-ascii?Q?IUcbmS6Zlaf5I/Ozl5NP2EomVWTJt5FZhQVwZMnGIgkCRxyjHSGVu/iam0Q7?=
 =?us-ascii?Q?jCoqa59q2GeMxmvYFrW837a+7U7VJgFn9YDZHQUtWqO5pnUeFvQWt+pZxRIV?=
 =?us-ascii?Q?TdZ+i0n4Bndv6LoaPJ+WZ3Ohi1XrQTghG3rNkMIBkRt3fEmqJtBb3z5yPHv9?=
 =?us-ascii?Q?Bz/740Cu7iaK8LGYVxLp+TlyVEdDbyBQk7d5diaLgHYYNrUCIytHkSZqanPg?=
 =?us-ascii?Q?yiZlymnEMenH+uTtICjyomzSCV6s6HUGDVs1E6og8gpjmqU/ElIzm3mkZJ+V?=
 =?us-ascii?Q?J0xi3LYXpoZpCc/1Z5MTY6/xiTY+7MolCYQJHJI7D+JIs2eOlfWA6D+OrOSN?=
 =?us-ascii?Q?mGjHOLiZXSefp+WahbkPqaEm7hm2nrMeZLL4/MIkuJKU4NeXaDH3cpk1Mp1h?=
 =?us-ascii?Q?c3aZJ4HfIEtJrM3mmh7M+JRfAoh+++e/zrY2tZ89SzkAa0VjHHzJooMmbTUA?=
 =?us-ascii?Q?aFYktNvDr52i3CpB6zWJs7JoAwMrvvsgztMpvxuPK4wHzwfD0SSRjvJ/XXRo?=
 =?us-ascii?Q?Y2fFwwz6rsX6BVBdG/FeaLwqUaq4IPe9HC594TLGDcAZBgR4Tdfv4r4BGcUj?=
 =?us-ascii?Q?76YoXAxUEw3DBnkTvbeTuH5+2bjmpUV9MM8Lrbl427A0P4dcQNkFGNwL8GMo?=
 =?us-ascii?Q?3ap+avwCIoCrcgWxcbYA7W0UoD+Z5Ai3CkNiQkOUNpcBPWp+FABABokBtUNV?=
 =?us-ascii?Q?y+9l4pVH9osu7PZpxPm5vtPbxKczCBR7F5ImHWBQ6Y8zMShrM3xKZFh1kLc8?=
 =?us-ascii?Q?3RDZBFkUfvwG5ydKdKd2nZZpr4+CINIKkPaVlUIVHWD6nV9wGaSN2bHW92Oj?=
 =?us-ascii?Q?2vevnd6cB/fS1fm2XDcfXZOHO9On0cuY2r75yH72fa1+hG4KWYNOURHEqgll?=
 =?us-ascii?Q?ECy84jbYZ32VpkE8fOXu76ykngTK0TJVu+911LqjuWHWP7tEPs2reg/fdi98?=
 =?us-ascii?Q?SaPeA5mI5weTpw87Tw7BU2iBal+67WO/5rPjBWeuvR1kcFid7BvhvW51o2A3?=
 =?us-ascii?Q?6WkuCWQg32H7hPVzdX6iJLqerIp9qfQSccgn6eAgSNz4H3tQv866QID5pYu2?=
 =?us-ascii?Q?H+LUViIXwDoaon6O1Ek1d2yB0H4dKJGKSMI0QY9thFjBzVTj/fkbDfu3Rp4N?=
 =?us-ascii?Q?P5TdAJyFtNA7TaFZoa6X+TvGUbY/Lsft7dNKZZA/LF35F2hrfc6H0aWSqjSA?=
 =?us-ascii?Q?xUuS0xVMkYkQPA7ai00=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0815aefb-eb0c-43bd-fa06-08daa7a68e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 14:25:01.6208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Va54+id8m4uvkBQzIh834hbzaogLb+oP7t+3v2XT6wIsaKGisd9ov2dVx7bjUTPu0gwz+q1VDXtq9xVBNKdsRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7981
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Frank Li
> Sent: Thursday, September 22, 2022 11:14 AM
> To: maz@kernel.org; tglx@linutronix.de; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kw@linux.com; bhelgaas@google.com
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-pci@vger.kernel.org; Peng Fan
> <peng.fan@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> jdmason@kudzu.us; kernel@pengutronix.de; festevam@gmail.com; dl-linux-
> imx <linux-imx@nxp.com>; kishon@ti.com; lorenzo.pieralisi@arm.com;
> ntb@lists.linux.dev; lznuaa@gmail.com; imx@lists.linux.dev;
> manivannan.sadhasivam@linaro.org
> Subject: [PATCH v12 5/6] PCI: endpoint: pci-epf-vntb: Clean up
>=20

[Frank Li] @Bjorn Helgaas, ping
Patches[1-4] was already picked  by irqchip.=20
I think patch[5-6] should go through pci subsystem.=20
Any additional comments?


> Remove unused field: epf_db_phy.
> Remove __iomem before epf_db.
> Change epf_db to u32* from void *
> Remove duplicate check if (readl(ntb->epf_db + i * 4)).
> Using sizeof(u32) instead of number 4 at all place.
>=20
> Clean up sparse build warning:
>   Using  epf_db[i] instead of readl() because epf_db is located in local
>   memory and allocated by dma_alloc_coherent(). Sparse build warning
> when
>   there are not __iomem at readl().
>   Added __iomem force type convert in vntb_epf_peer_spad_read\write()
> and
>   vntb_epf_spad_read\write(). This require strong order at read and write=
.
>=20
> Replace pci_epc_mem_free_addr() with pci_epf_free_space() at error handle
> path to match pci_epf_alloc_space().
>=20
> Cleanup warning found by scripts/kernel-doc
> Fix indentation of the struct epf_ntb_ctrl
> Consolidate term
>   host, host1 to HOST
>   vhost, vHost, Vhost, VHOST2 to VHOST
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 157 ++++++++++--------
>  1 file changed, 90 insertions(+), 67 deletions(-)
>=20
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 1466dd1904175..acea753af29ed 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -11,7 +11,7 @@
>   * Author: Kishon Vijay Abraham I <kishon@ti.com>
>   */
>=20
> -/**
> +/*
>   * +------------+         +---------------------------------------+
>   * |            |         |                                       |
>   * +------------+         |                        +--------------+
> @@ -99,20 +99,20 @@ enum epf_ntb_bar {
>   *       NTB Driver               NTB Driver
>   */
>  struct epf_ntb_ctrl {
> -	u32     command;
> -	u32     argument;
> -	u16     command_status;
> -	u16     link_status;
> -	u32     topology;
> -	u64     addr;
> -	u64     size;
> -	u32     num_mws;
> -	u32	reserved;
> -	u32     spad_offset;
> -	u32     spad_count;
> -	u32	db_entry_size;
> -	u32     db_data[MAX_DB_COUNT];
> -	u32     db_offset[MAX_DB_COUNT];
> +	u32 command;
> +	u32 argument;
> +	u16 command_status;
> +	u16 link_status;
> +	u32 topology;
> +	u64 addr;
> +	u64 size;
> +	u32 num_mws;
> +	u32 reserved;
> +	u32 spad_offset;
> +	u32 spad_count;
> +	u32 db_entry_size;
> +	u32 db_data[MAX_DB_COUNT];
> +	u32 db_offset[MAX_DB_COUNT];
>  } __packed;
>=20
>  struct epf_ntb {
> @@ -136,8 +136,7 @@ struct epf_ntb {
>=20
>  	struct epf_ntb_ctrl *reg;
>=20
> -	phys_addr_t epf_db_phy;
> -	void __iomem *epf_db;
> +	u32 *epf_db;
>=20
>  	phys_addr_t vpci_mw_phy[MAX_MW];
>  	void __iomem *vpci_mw_addr[MAX_MW];
> @@ -156,12 +155,14 @@ static struct pci_epf_header epf_ntb_header =3D {
>  };
>=20
>  /**
> - * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host
> + * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host (VHOST)
>   * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   * @link_up: true or false indicating Link is UP or Down
>   *
>   * Once NTB function in HOST invoke ntb_link_enable(),
> - * this NTB function driver will trigger a link event to vhost.
> + * this NTB function driver will trigger a link event to VHOST.
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
>  {
> @@ -175,9 +176,9 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool
> link_up)
>  }
>=20
>  /**
> - * epf_ntb_configure_mw() - Configure the Outbound Address Space for
> vhost
> - *   to access the memory window of host
> - * @ntb: NTB device that facilitates communication between host and vhos=
t
> + * epf_ntb_configure_mw() - Configure the Outbound Address Space for
> VHOST
> + *   to access the memory window of HOST
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   * @mw: Index of the memory window (either 0, 1, 2 or 3)
>   *
>   *                          EP Outbound Window
> @@ -194,7 +195,9 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool
> link_up)
>   * |        |              |           |
>   * |        |              |           |
>   * +--------+              +-----------+
> - *  VHost                   PCI EP
> + *  VHOST                   PCI EP
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_configure_mw(struct epf_ntb *ntb, u32 mw)
>  {
> @@ -219,7 +222,7 @@ static int epf_ntb_configure_mw(struct epf_ntb *ntb,
> u32 mw)
>=20
>  /**
>   * epf_ntb_teardown_mw() - Teardown the configured OB ATU
> - * @ntb: NTB device that facilitates communication between HOST and
> vHOST
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   * @mw: Index of the memory window (either 0, 1, 2 or 3)
>   *
>   * Teardown the configured OB ATU configured in epf_ntb_configure_mw()
> using
> @@ -234,12 +237,12 @@ static void epf_ntb_teardown_mw(struct epf_ntb
> *ntb, u32 mw)
>  }
>=20
>  /**
> - * epf_ntb_cmd_handler() - Handle commands provided by the NTB Host
> + * epf_ntb_cmd_handler() - Handle commands provided by the NTB HOST
>   * @work: work_struct for the epf_ntb_epc
>   *
>   * Workqueue function that gets invoked for the two epf_ntb_epc
>   * periodically (once every 5ms) to see if it has received any commands
> - * from NTB host. The host can send commands to configure doorbell or
> + * from NTB HOST. The HOST can send commands to configure doorbell or
>   * configure memory window or to update link status.
>   */
>  static void epf_ntb_cmd_handler(struct work_struct *work)
> @@ -254,12 +257,9 @@ static void epf_ntb_cmd_handler(struct work_struct
> *work)
>  	ntb =3D container_of(work, struct epf_ntb, cmd_handler.work);
>=20
>  	for (i =3D 1; i < ntb->db_count; i++) {
> -		if (readl(ntb->epf_db + i * 4)) {
> -			if (readl(ntb->epf_db + i * 4))
> -				ntb->db |=3D 1 << (i - 1);
> -
> +		if (ntb->epf_db[i]) {
>  			ntb_db_event(&ntb->ntb, i);
> -			writel(0, ntb->epf_db + i * 4);
> +			ntb->epf_db[i] =3D 0;
>  		}
>  	}
>=20
> @@ -321,8 +321,8 @@ static void epf_ntb_cmd_handler(struct work_struct
> *work)
>=20
>  /**
>   * epf_ntb_config_sspad_bar_clear() - Clear Config + Self scratchpad BAR
> - * @ntb_epc: EPC associated with one of the HOST which holds peer's
> outbound
> - *	     address.
> + * @ntb: EPC associated with one of the HOST which holds peer's outbound
> + *	 address.
>   *
>   * Clear BAR0 of EP CONTROLLER 1 which contains the HOST1's config and
>   * self scratchpad region (removes inbound ATU configuration). While BAR=
0
> is
> @@ -331,8 +331,10 @@ static void epf_ntb_cmd_handler(struct work_struct
> *work)
>   * used for self scratchpad from epf_ntb_bar[BAR_CONFIG].
>   *
>   * Please note the self scratchpad region and config region is combined =
to
> - * a single region and mapped using the same BAR. Also note HOST2's peer
> - * scratchpad is HOST1's self scratchpad.
> + * a single region and mapped using the same BAR. Also note VHOST's peer
> + * scratchpad is HOST's self scratchpad.
> + *
> + * Returns: void
>   */
>  static void epf_ntb_config_sspad_bar_clear(struct epf_ntb *ntb)
>  {
> @@ -347,13 +349,15 @@ static void epf_ntb_config_sspad_bar_clear(struct
> epf_ntb *ntb)
>=20
>  /**
>   * epf_ntb_config_sspad_bar_set() - Set Config + Self scratchpad BAR
> - * @ntb: NTB device that facilitates communication between HOST and
> vHOST
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   *
> - * Map BAR0 of EP CONTROLLER 1 which contains the HOST1's config and
> + * Map BAR0 of EP CONTROLLER which contains the VHOST's config and
>   * self scratchpad region.
>   *
>   * Please note the self scratchpad region and config region is combined =
to
>   * a single region and mapped using the same BAR.
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_config_sspad_bar_set(struct epf_ntb *ntb)
>  {
> @@ -380,7 +384,7 @@ static int epf_ntb_config_sspad_bar_set(struct
> epf_ntb *ntb)
>  /**
>   * epf_ntb_config_spad_bar_free() - Free the physical memory associated
> with
>   *   config + scratchpad region
> - * @ntb: NTB device that facilitates communication between HOST and
> vHOST
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   */
>  static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
>  {
> @@ -393,11 +397,13 @@ static void epf_ntb_config_spad_bar_free(struct
> epf_ntb *ntb)
>  /**
>   * epf_ntb_config_spad_bar_alloc() - Allocate memory for config +
> scratchpad
>   *   region
> - * @ntb: NTB device that facilitates communication between HOST1 and
> HOST2
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   *
>   * Allocate the Local Memory mentioned in the above diagram. The size of
>   * CONFIG REGION is sizeof(struct epf_ntb_ctrl) and size of SCRATCHPAD
> REGION
>   * is obtained from "spad-count" configfs entry.
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  {
> @@ -424,7 +430,7 @@ static int epf_ntb_config_spad_bar_alloc(struct
> epf_ntb *ntb)
>  	spad_count =3D ntb->spad_count;
>=20
>  	ctrl_size =3D sizeof(struct epf_ntb_ctrl);
> -	spad_size =3D 2 * spad_count * 4;
> +	spad_size =3D 2 * spad_count * sizeof(u32);
>=20
>  	if (!align) {
>  		ctrl_size =3D roundup_pow_of_two(ctrl_size);
> @@ -454,7 +460,7 @@ static int epf_ntb_config_spad_bar_alloc(struct
> epf_ntb *ntb)
>  	ctrl->num_mws =3D ntb->num_mws;
>  	ntb->spad_size =3D spad_size;
>=20
> -	ctrl->db_entry_size =3D 4;
> +	ctrl->db_entry_size =3D sizeof(u32);
>=20
>  	for (i =3D 0; i < ntb->db_count; i++) {
>  		ntb->reg->db_data[i] =3D 1 + i;
> @@ -465,11 +471,13 @@ static int epf_ntb_config_spad_bar_alloc(struct
> epf_ntb *ntb)
>  }
>=20
>  /**
> - * epf_ntb_configure_interrupt() - Configure MSI/MSI-X capaiblity
> - * @ntb: NTB device that facilitates communication between HOST and
> vHOST
> + * epf_ntb_configure_interrupt() - Configure MSI/MSI-X capability
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   *
>   * Configure MSI/MSI-X capability for each interface with number of
>   * interrupts equal to "db_count" configfs entry.
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  {
> @@ -511,18 +519,22 @@ static int epf_ntb_configure_interrupt(struct
> epf_ntb *ntb)
>=20
>  /**
>   * epf_ntb_db_bar_init() - Configure Doorbell window BARs
> - * @ntb: NTB device that facilitates communication between HOST and
> vHOST
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>  {
>  	const struct pci_epc_features *epc_features;
> -	u32 align;
>  	struct device *dev =3D &ntb->epf->dev;
> -	int ret;
>  	struct pci_epf_bar *epf_bar;
> -	void __iomem *mw_addr;
>  	enum pci_barno barno;
> -	size_t size =3D 4 * ntb->db_count;
> +	void *mw_addr;
> +	size_t size;
> +	u32 align;
> +	int ret;
> +
> +	size =3D sizeof(u32) * ntb->db_count;
>=20
>  	epc_features =3D pci_epc_get_features(ntb->epf->epc,
>  					    ntb->epf->func_no,
> @@ -557,14 +569,14 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>  	return ret;
>=20
>  err_alloc_peer_mem:
> -	pci_epc_mem_free_addr(ntb->epf->epc, epf_bar->phys_addr,
> mw_addr, epf_bar->size);
> +	pci_epf_free_space(ntb->epf, mw_addr, barno, 0);
>  	return -1;
>  }
>=20
>  /**
>   * epf_ntb_db_bar_clear() - Clear doorbell BAR and free memory
>   *   allocated in peer's outbound address space
> - * @ntb: NTB device that facilitates communication between HOST and
> vHOST
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   */
>  static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
>  {
> @@ -580,8 +592,9 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
>=20
>  /**
>   * epf_ntb_mw_bar_init() - Configure Memory window BARs
> - * @ntb: NTB device that facilitates communication between HOST and
> vHOST
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  {
> @@ -629,7 +642,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>=20
>  /**
>   * epf_ntb_mw_bar_clear() - Clear Memory window BARs
> - * @ntb: NTB device that facilitates communication between HOST and
> vHOST
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   */
>  static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb)
>  {
> @@ -652,7 +665,7 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb
> *ntb)
>=20
>  /**
>   * epf_ntb_epc_destroy() - Cleanup NTB EPC interface
> - * @ntb: NTB device that facilitates communication between HOST and
> vHOST
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   *
>   * Wrapper for epf_ntb_epc_destroy_interface() to cleanup all the NTB
> interfaces
>   */
> @@ -665,7 +678,9 @@ static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
>  /**
>   * epf_ntb_init_epc_bar() - Identify BARs to be used for each of the NTB
>   * constructs (scratchpad region, doorbell, memorywindow)
> - * @ntb: NTB device that facilitates communication between HOST and
> vHOST
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
>  {
> @@ -706,11 +721,13 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb=
)
>=20
>  /**
>   * epf_ntb_epc_init() - Initialize NTB interface
> - * @ntb: NTB device that facilitates communication between HOST and
> vHOST2
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   *
>   * Wrapper to initialize a particular EPC interface and start the workqu=
eue
> - * to check for commands from host. This function will write to the
> + * to check for commands from HOST. This function will write to the
>   * EP controller HW for configuring it.
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_epc_init(struct epf_ntb *ntb)
>  {
> @@ -777,7 +794,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
>=20
>  /**
>   * epf_ntb_epc_cleanup() - Cleanup all NTB interfaces
> - * @ntb: NTB device that facilitates communication between HOST1 and
> HOST2
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   *
>   * Wrapper to cleanup all NTB interfaces.
>   */
> @@ -934,6 +951,8 @@ static const struct config_item_type ntb_group_type
> =3D {
>   *
>   * Add configfs directory specific to NTB. This directory will hold
>   * NTB specific properties like db_count, spad_count, num_mws etc.,
> + *
> + * Returns: Pointer to config_group
>   */
>  static struct config_group *epf_ntb_add_cfs(struct pci_epf *epf,
>  					    struct config_group *group)
> @@ -1084,11 +1103,11 @@ static int vntb_epf_link_enable(struct ntb_dev
> *ntb,
>  static u32 vntb_epf_spad_read(struct ntb_dev *ndev, int idx)
>  {
>  	struct epf_ntb *ntb =3D ntb_ndev(ndev);
> -	int off =3D ntb->reg->spad_offset, ct =3D ntb->reg->spad_count * 4;
> +	int off =3D ntb->reg->spad_offset, ct =3D ntb->reg->spad_count *
> sizeof(u32);
>  	u32 val;
> -	void __iomem *base =3D ntb->reg;
> +	void __iomem *base =3D (void __iomem *)ntb->reg;
>=20
> -	val =3D readl(base + off + ct + idx * 4);
> +	val =3D readl(base + off + ct + idx * sizeof(u32));
>  	return val;
>  }
>=20
> @@ -1096,10 +1115,10 @@ static int vntb_epf_spad_write(struct ntb_dev
> *ndev, int idx, u32 val)
>  {
>  	struct epf_ntb *ntb =3D ntb_ndev(ndev);
>  	struct epf_ntb_ctrl *ctrl =3D ntb->reg;
> -	int off =3D ctrl->spad_offset, ct =3D ctrl->spad_count * 4;
> -	void __iomem *base =3D ntb->reg;
> +	int off =3D ctrl->spad_offset, ct =3D ctrl->spad_count * sizeof(u32);
> +	void __iomem *base =3D (void __iomem *)ntb->reg;
>=20
> -	writel(val, base + off + ct + idx * 4);
> +	writel(val, base + off + ct + idx * sizeof(u32));
>  	return 0;
>  }
>=20
> @@ -1108,10 +1127,10 @@ static u32 vntb_epf_peer_spad_read(struct
> ntb_dev *ndev, int pidx, int idx)
>  	struct epf_ntb *ntb =3D ntb_ndev(ndev);
>  	struct epf_ntb_ctrl *ctrl =3D ntb->reg;
>  	int off =3D ctrl->spad_offset;
> -	void __iomem *base =3D ntb->reg;
> +	void __iomem *base =3D (void __iomem *)ntb->reg;
>  	u32 val;
>=20
> -	val =3D readl(base + off + idx * 4);
> +	val =3D readl(base + off + idx * sizeof(u32));
>  	return val;
>  }
>=20
> @@ -1120,9 +1139,9 @@ static int vntb_epf_peer_spad_write(struct
> ntb_dev *ndev, int pidx, int idx, u32
>  	struct epf_ntb *ntb =3D ntb_ndev(ndev);
>  	struct epf_ntb_ctrl *ctrl =3D ntb->reg;
>  	int off =3D ctrl->spad_offset;
> -	void __iomem *base =3D ntb->reg;
> +	void __iomem *base =3D (void __iomem *)ntb->reg;
>=20
> -	writel(val, base + off + idx * 4);
> +	writel(val, base + off + idx * sizeof(u32));
>  	return 0;
>  }
>=20
> @@ -1275,6 +1294,8 @@ static struct pci_driver vntb_pci_driver =3D {
>   * Invoked when a primary interface or secondary interface is bound to E=
PC
>   * device. This function will succeed only when EPC is bound to both the
>   * interfaces.
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_bind(struct pci_epf *epf)
>  {
> @@ -1359,6 +1380,8 @@ static struct pci_epf_ops epf_ntb_ops =3D {
>   *
>   * Probe NTB function driver when endpoint function bus detects a NTB
>   * endpoint function.
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_probe(struct pci_epf *epf)
>  {
> --
> 2.35.1

