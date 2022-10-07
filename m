Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5855F7DD2
	for <lists+linux-pci@lfdr.de>; Fri,  7 Oct 2022 21:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJGTSE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Oct 2022 15:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJGTSC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Oct 2022 15:18:02 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50F863DE;
        Fri,  7 Oct 2022 12:17:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2dZB7kGeIqteadJsGaF2f0s5lxTxzjmrB3pXoNxLZcJ9DjFdzdDgWCCgKMhFwbJqMlbnrcKeWi82zP2FrmAKh00EsfbyffHztb0BGXM4DmuTsT9fyvXLNHvU7ifky4CYvoi1nLHPnlrCsr5YGNFrwZ7X6jF/zYapa7uoyATccba9xJCONFSPHgmCExPj92M6zu9ifKWGNWLDTTnogIibnwRh1yhx5lteEZLmFOfHWnLLXkBSblkut1+MTVrvM/73eoIeQLyDhrFSgzzxwml6XkXn+6xTJ1MrQCPzXYTZuUWm0wFMx8gV6tWWSLj/Hrio/AUZLPIRu41vVOVNAgKxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Pb4jS16K27CMQvApiZjQeyLc1UCLcTTK1F3YEjkk9w=;
 b=Z7A9FEbLOh10OH8eCISkWGaHmQUcgShxPdr6+ltNVO+89mH8wi71aPbFn+MivusAdrFHLq1XzMIIrxQVgym5roHtLX5tmIQPVEgdbetesY1qzFf3Yj+4Pggt04/aYijJ8sSPsqeeEgoZ8o3RHvMHzsjqFMf/veZ255eqnM84e4ukDAsNbWSkD8GLvUCZkxZJHnElg2TrobqNJDjWJ0IbJd6AmEglB3IbDrT69ponLKPxJXOmmZNkjByxeXaJgVa0syo5Hgy/EMHnY83HLTUKhhLq967PSCVh2tZgacpJRfGAnwajOWRcPtcjpi3WaAcmrkL9y+xl/HTtdfYc7lqv+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Pb4jS16K27CMQvApiZjQeyLc1UCLcTTK1F3YEjkk9w=;
 b=EPrAad+5hgPgZchYlgO3OomSy2pURKt5Y9gphkbDs9bMd1khcjPYa/h1S5z9tSL7n5obTO7xhOAIEhsytQY3yQXxVB57W6S38H5+TQuEoUYndGkrIvyhw7iTPPIwmk4mJTcG7VzuK1WIxtKsm13sV21AZtc1A6O6kyDv2VKlc50=
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by DB9PR04MB8282.eurprd04.prod.outlook.com (2603:10a6:10:24a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 7 Oct
 2022 19:17:56 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::54da:4ebc:2916:de90]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::54da:4ebc:2916:de90%5]) with mapi id 15.20.5676.038; Fri, 7 Oct 2022
 19:17:56 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Frank Li <frank.li@nxp.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:NTB DRIVER CORE" <ntb@lists.linux.dev>,
        "open list:PCI ENDPOINT SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH v12 5/6] PCI: endpoint: pci-epf-vntb: Clean up
Thread-Topic: [EXT] [PATCH v12 5/6] PCI: endpoint: pci-epf-vntb: Clean up
Thread-Index: AQHY2oD1Vn58vUyfEEKLywkrxPFjj64DTf4A
Date:   Fri, 7 Oct 2022 19:17:56 +0000
Message-ID: <AM9PR04MB87932F658E089B3D83A65793885F9@AM9PR04MB8793.eurprd04.prod.outlook.com>
References: <20221007191326.193079-1-Frank.Li@nxp.com>
In-Reply-To: <20221007191326.193079-1-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8793:EE_|DB9PR04MB8282:EE_
x-ms-office365-filtering-correlation-id: 9b44f30d-3c24-4738-4ee2-08daa898a405
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6vBEwF+Zs+sV0lUZ8yy8KOCmogR+il6WO8r+ua4btcEFi9vpsIEMmHTIQlSw12/kqGw+cNueIE6rq6xxT/B0ONfyMrwwmOFPXpOove9Bdtqk8yKncfSmszbNW/pU/5om0wmV5tDkeYBAHqAFYtLVIG5pBYX6Ad2Hm7ZBhhdfRyZFcgfArqyMv7QBUzp4GD9H1/T7k/e57G3mmG687ZYYOVSmypXyQ16DfOSXZBlNdeXBMJV1VwNG121frJOR7rRpDL+jbtQBw63CGqpTPtBb5SXRpEVh6HeQw8ycTke5NZGb05DuV7FB+eVjs9GnBEwDUfRFuj0s+NcxxtnZCOgY1JxuFSC+F5DHNH6VxyM/hebdCRr/CS4Dwq2KZ5gAcntQx5QIZ0xV2P9jfWqt6HchAngONtSiBj3yQAPgbfOSjU7/UQ+DmRjJpJUKTAoU+fL3C7Re8gWW4r6prTQvY0oYLa9iBaM+sR3wCc1XQUFI7b+0nV8IEvW093WQB/z9qBpessGARx5w9QfVOh1qBHmuX8Q9QgXERW/YmjfaZyac253NL81oPbvbNEBqGG9R3qgjG+zujqiGY6MaJ8b+PuCZI6yLnYgu2lzlqrLSVOtdejy+MjodqIcgpuS2xfg8+Xrtn5norpHcavjkRhYP5qzRqAiMdB+JASKl9wEVTb7wgH9iTWgPU2O1KQiz/QmPutPgilOWBsDHCtU88ovG6t5HaRnu3Q97+QHY5EQnNc7RWTZYWyH78kF6MtbGvzmeo5vYPEZAM5Te3UUamY60uoivmMBBWHhz7VX5k5RMch8p4tU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199015)(921005)(66946007)(66556008)(66446008)(316002)(110136005)(86362001)(66476007)(64756008)(76116006)(66574015)(44832011)(30864003)(5660300002)(7416002)(2906002)(8936002)(52536014)(33656002)(41300700001)(186003)(38100700002)(83380400001)(478600001)(38070700005)(55236004)(8676002)(71200400001)(122000001)(55016003)(53546011)(7696005)(9686003)(6506007)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?E0wRIIyaJmphTnsLbyU20xK5XlNp/VCTspkEXLC2S5DYnMVVrGNSQj5WIv?=
 =?iso-8859-2?Q?YR+s9HeGCR8vHfuRvKKL6rkUO0HX4Yk5maULLNpzXMwjykBU442Rtndqx+?=
 =?iso-8859-2?Q?jPNrffvTN76Twk0WnfGbqJLsbo2C2o6YC7PI40KKosOjS/lVo7VpLAKnlG?=
 =?iso-8859-2?Q?k4Flnp40hWMkzT1FqYt5H8onagHxO1PAFsONa4mOW0wA2lpG0JrmVtBTmW?=
 =?iso-8859-2?Q?wCKn+ejoJyEc0tl4Hh8RKSf70aaiwv4pxpUa8JqW2uBX6rXNQ3FF7C0oMg?=
 =?iso-8859-2?Q?885n+psS8PRgSkcQbxeXTzmLDTxt+FMZ5gG+YgQuTyzCxkJhIrchCn5pvX?=
 =?iso-8859-2?Q?0pyGvAlc2EqVyULe55K1VrYduOJG2BcL6tdJA9USiwdxtJrQZSdO4/m6Fh?=
 =?iso-8859-2?Q?j0enULP1xlSpD7t6hj9Egy2Yy8qCn+aGYNAb32vLuN7wPGVMaAmxyPlgnR?=
 =?iso-8859-2?Q?/4e4MBV09fee+6cBR+EG7iVspH9mdGmWOOdCdIsZYOml6JynMuv0mPaLNs?=
 =?iso-8859-2?Q?/wC7LYy6rKrJRdO9PnbEmEraNXYX3eW5JWIMBRspB6EIsgv4/VFfKRa3am?=
 =?iso-8859-2?Q?fioh2UDc+DHuu8nUCFQ62pGn7Vr7wnEgkCx/pnhk+xUGNkv1ts9tTdbTdW?=
 =?iso-8859-2?Q?tMVcPZoTuGXVSMoHNYlOgtLKKFACemkEMIjnHsL2xIwKxpVWTAR5/Tz9XL?=
 =?iso-8859-2?Q?WJ2rpd+NTYHapycM1p4TgYzjrqvYDQBmaC1s9iajAd9tygoDT/iic7Tnc1?=
 =?iso-8859-2?Q?kq+IhPI5qlhi4zokGItQrRt2HZJKYdieK78aMZsLQaiC4Zq/RIQ6ITTLHj?=
 =?iso-8859-2?Q?SMr5gOUbMfe8Mrq1Y4fUYCVZzBCJi8dydhNRMun7FwHD7f6Qqlvc3Zuo1r?=
 =?iso-8859-2?Q?zMCFwquE6+Waz/IdygsbXdt0HHS/QlcUdl6sqPy+i/e5RSqrfiYWQC4jUW?=
 =?iso-8859-2?Q?YLkxPVq33Q798hI8u7m/wOZa6zNZGAALBCfVtiLQ7yhJ6D/XI8Bk62cxgx?=
 =?iso-8859-2?Q?UNg6ESvp52excNVHUgysfFGM4tzTzGiqt+c01Cg/McHqdGnnjzeEJmbiNV?=
 =?iso-8859-2?Q?ydeSOrT5s/QDlmto+iWSVjT7s6ys6JOhs+YyfBwJyRw5WwCZsK7iVq3Wyw?=
 =?iso-8859-2?Q?YdV4O0/WjMDE/qxNGDzY5x1wKDPupob+f4sm6OFesYYEs+CGcgPuQ9GaXf?=
 =?iso-8859-2?Q?tZHxQlRir33mPBhM9Ei5yGj4G9NSPfesvHnHwsf0Bd6Fn4ZqpLbjfNwFPC?=
 =?iso-8859-2?Q?AFkYlU8RUM7L7ROsx66rjNzu4D8vFeG2vSCcJiA0IfJBI9WSjO5/1ZnNNK?=
 =?iso-8859-2?Q?DGQCHLhQXlUpCpxzU9NF+aBSv2m0kc5SWrNXgG1FNhicIdU2Xut+dWS9d0?=
 =?iso-8859-2?Q?XVnHcns6U3k/gbvG/LwLU82nUqjeY19ZEeGWAcXc/mDsvlV4io53n+rA4p?=
 =?iso-8859-2?Q?jzXgE0OEzxe0HmZHYsaPGDMWJaGXc9+GuqW2MtUtCISStwUI6uaJvqxKVK?=
 =?iso-8859-2?Q?yTJoilqqq7wC5cTPDyAPhWqTETxzUudp4POnIHb3Dw4lOU2Zyq0VckIda5?=
 =?iso-8859-2?Q?41GWVfGnjEckblLGQGQJCGsw7qmh1KnSn+IkDLCbfnyjCPykbOo94xXiOY?=
 =?iso-8859-2?Q?S3he/JhiJDaB+TtAnJ9+ZvmdtduIKjbdcU?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b44f30d-3c24-4738-4ee2-08daa898a405
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 19:17:56.6028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q5uwBwsBfgIJoxzUez34vGHXMMWlebJJhAIUg19vgEnfl3Z0BQ+BNIuFxmXGPuvXn5Kj1NLJOHrdkx4pocSv9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8282
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
> From: Frank Li <Frank.Li@nxp.com>
> Sent: Friday, October 7, 2022 2:13 PM
> To: imx@lists.linux.dev; Jon Mason <jdmason@kudzu.us>; Dave Jiang
> <dave.jiang@intel.com>; Allen Hubbe <allenbh@gmail.com>; Kishon Vijay
> Abraham I <kishon@ti.com>; Lorenzo Pieralisi <lpieralisi@kernel.org>;
> Krzysztof Wilczy=F1ski <kw@linux.com>; Manivannan Sadhasivam
> <mani@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>; open list:NTB
> DRIVER CORE <ntb@lists.linux.dev>; open list:PCI ENDPOINT SUBSYSTEM
> <linux-pci@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> Subject: [EXT] [PATCH v12 5/6] PCI: endpoint: pci-epf-vntb: Clean up

[Frank Li] sorry! Please forget this patch, which below old series.=20
Please check v13's patches.
=20
>=20
> Caution: EXT Email
>=20
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
> -       u32     command;
> -       u32     argument;
> -       u16     command_status;
> -       u16     link_status;
> -       u32     topology;
> -       u64     addr;
> -       u64     size;
> -       u32     num_mws;
> -       u32     reserved;
> -       u32     spad_offset;
> -       u32     spad_count;
> -       u32     db_entry_size;
> -       u32     db_data[MAX_DB_COUNT];
> -       u32     db_offset[MAX_DB_COUNT];
> +       u32 command;
> +       u32 argument;
> +       u16 command_status;
> +       u16 link_status;
> +       u32 topology;
> +       u64 addr;
> +       u64 size;
> +       u32 num_mws;
> +       u32 reserved;
> +       u32 spad_offset;
> +       u32 spad_count;
> +       u32 db_entry_size;
> +       u32 db_data[MAX_DB_COUNT];
> +       u32 db_offset[MAX_DB_COUNT];
>  } __packed;
>=20
>  struct epf_ntb {
> @@ -136,8 +136,7 @@ struct epf_ntb {
>=20
>         struct epf_ntb_ctrl *reg;
>=20
> -       phys_addr_t epf_db_phy;
> -       void __iomem *epf_db;
> +       u32 *epf_db;
>=20
>         phys_addr_t vpci_mw_phy[MAX_MW];
>         void __iomem *vpci_mw_addr[MAX_MW];
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
>         ntb =3D container_of(work, struct epf_ntb, cmd_handler.work);
>=20
>         for (i =3D 1; i < ntb->db_count; i++) {
> -               if (readl(ntb->epf_db + i * 4)) {
> -                       if (readl(ntb->epf_db + i * 4))
> -                               ntb->db |=3D 1 << (i - 1);
> -
> +               if (ntb->epf_db[i]) {
>                         ntb_db_event(&ntb->ntb, i);
> -                       writel(0, ntb->epf_db + i * 4);
> +                       ntb->epf_db[i] =3D 0;
>                 }
>         }
>=20
> @@ -321,8 +321,8 @@ static void epf_ntb_cmd_handler(struct work_struct
> *work)
>=20
>  /**
>   * epf_ntb_config_sspad_bar_clear() - Clear Config + Self scratchpad BAR
> - * @ntb_epc: EPC associated with one of the HOST which holds peer's
> outbound
> - *          address.
> + * @ntb: EPC associated with one of the HOST which holds peer's outbound
> + *      address.
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
>         spad_count =3D ntb->spad_count;
>=20
>         ctrl_size =3D sizeof(struct epf_ntb_ctrl);
> -       spad_size =3D 2 * spad_count * 4;
> +       spad_size =3D 2 * spad_count * sizeof(u32);
>=20
>         if (!align) {
>                 ctrl_size =3D roundup_pow_of_two(ctrl_size);
> @@ -454,7 +460,7 @@ static int epf_ntb_config_spad_bar_alloc(struct
> epf_ntb *ntb)
>         ctrl->num_mws =3D ntb->num_mws;
>         ntb->spad_size =3D spad_size;
>=20
> -       ctrl->db_entry_size =3D 4;
> +       ctrl->db_entry_size =3D sizeof(u32);
>=20
>         for (i =3D 0; i < ntb->db_count; i++) {
>                 ntb->reg->db_data[i] =3D 1 + i;
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
>         const struct pci_epc_features *epc_features;
> -       u32 align;
>         struct device *dev =3D &ntb->epf->dev;
> -       int ret;
>         struct pci_epf_bar *epf_bar;
> -       void __iomem *mw_addr;
>         enum pci_barno barno;
> -       size_t size =3D 4 * ntb->db_count;
> +       void *mw_addr;
> +       size_t size;
> +       u32 align;
> +       int ret;
> +
> +       size =3D sizeof(u32) * ntb->db_count;
>=20
>         epc_features =3D pci_epc_get_features(ntb->epf->epc,
>                                             ntb->epf->func_no,
> @@ -557,14 +569,14 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>         return ret;
>=20
>  err_alloc_peer_mem:
> -       pci_epc_mem_free_addr(ntb->epf->epc, epf_bar->phys_addr, mw_addr,
> epf_bar->size);
> +       pci_epf_free_space(ntb->epf, mw_addr, barno, 0);
>         return -1;
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
>                                             struct config_group *group)
> @@ -1084,11 +1103,11 @@ static int vntb_epf_link_enable(struct ntb_dev
> *ntb,
>  static u32 vntb_epf_spad_read(struct ntb_dev *ndev, int idx)
>  {
>         struct epf_ntb *ntb =3D ntb_ndev(ndev);
> -       int off =3D ntb->reg->spad_offset, ct =3D ntb->reg->spad_count * =
4;
> +       int off =3D ntb->reg->spad_offset, ct =3D ntb->reg->spad_count * =
sizeof(u32);
>         u32 val;
> -       void __iomem *base =3D ntb->reg;
> +       void __iomem *base =3D (void __iomem *)ntb->reg;
>=20
> -       val =3D readl(base + off + ct + idx * 4);
> +       val =3D readl(base + off + ct + idx * sizeof(u32));
>         return val;
>  }
>=20
> @@ -1096,10 +1115,10 @@ static int vntb_epf_spad_write(struct ntb_dev
> *ndev, int idx, u32 val)
>  {
>         struct epf_ntb *ntb =3D ntb_ndev(ndev);
>         struct epf_ntb_ctrl *ctrl =3D ntb->reg;
> -       int off =3D ctrl->spad_offset, ct =3D ctrl->spad_count * 4;
> -       void __iomem *base =3D ntb->reg;
> +       int off =3D ctrl->spad_offset, ct =3D ctrl->spad_count * sizeof(u=
32);
> +       void __iomem *base =3D (void __iomem *)ntb->reg;
>=20
> -       writel(val, base + off + ct + idx * 4);
> +       writel(val, base + off + ct + idx * sizeof(u32));
>         return 0;
>  }
>=20
> @@ -1108,10 +1127,10 @@ static u32 vntb_epf_peer_spad_read(struct
> ntb_dev *ndev, int pidx, int idx)
>         struct epf_ntb *ntb =3D ntb_ndev(ndev);
>         struct epf_ntb_ctrl *ctrl =3D ntb->reg;
>         int off =3D ctrl->spad_offset;
> -       void __iomem *base =3D ntb->reg;
> +       void __iomem *base =3D (void __iomem *)ntb->reg;
>         u32 val;
>=20
> -       val =3D readl(base + off + idx * 4);
> +       val =3D readl(base + off + idx * sizeof(u32));
>         return val;
>  }
>=20
> @@ -1120,9 +1139,9 @@ static int vntb_epf_peer_spad_write(struct
> ntb_dev *ndev, int pidx, int idx, u32
>         struct epf_ntb *ntb =3D ntb_ndev(ndev);
>         struct epf_ntb_ctrl *ctrl =3D ntb->reg;
>         int off =3D ctrl->spad_offset;
> -       void __iomem *base =3D ntb->reg;
> +       void __iomem *base =3D (void __iomem *)ntb->reg;
>=20
> -       writel(val, base + off + idx * 4);
> +       writel(val, base + off + idx * sizeof(u32));
>         return 0;
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

