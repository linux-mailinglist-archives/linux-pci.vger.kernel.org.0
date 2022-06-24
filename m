Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A188A559CBD
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 17:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiFXOwR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 10:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbiFXOv4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 10:51:56 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on0626.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A1F6F7BD;
        Fri, 24 Jun 2022 07:46:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UN66ukcb1y5mmaMB4YS8o/wTm0JmsfkoicfSbr9Ep5RCB2dH2QNP7y+t4//eaYnC2LHPKrfF5SQi9V2wdjfIqFZ/3Wb3qMcZ85UIuc5LAeDl6SWEd7WJDK7coiwueBfYJZoG+wyJtc4ANDyOWIpnYf6ISNbmAQyNAcmmGR4E21ISmu3AUZh1hCawF5ADlFLBv+VLXij6vSpSJIDNDZCctvC4KYLHYRUVrUPk0z+bkCnhPBMNRL+B2Hx3S1SKnpW0oitOLYEqv2SBlqQlzXDWxx18BxzOpuhh0p/DMn85By7EC0GLG42ueI0xxXHvWQaNLXzGErnWvBQbBpb1dwJL0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QiZ3PhUg1/sq0AvKj8y/HjApkNiJc8hfYCcMCHumdA=;
 b=c2S0URYgBPsbXofHFCwJdWmLKaGwPuexVqJaFWJ2YseeKk05NIluHle2uYvDXxKTK1SxZ6HxPbDWwCkE7o/DllgYuecjNo50/jlOnqwzUQ2zLZnLDNX0u+fxksynAPXLdFz1z/7Eyqql1aAQXAvUDYJXwy8G/Gzr1JzzGyUtj9MMeYSv/rNprTgkmWgRuz4EnTRhYekk+m13jJ0S7u2/2bxK5dFibYxLRnFawXJYLi3+HJGTuTggVF2/SOZ++zCjonq1E1PLfBhePtfD5YyZMycPduqvp/nyeQxpnGsi6iji8tJC9T4KOUGY3iM2HLAhI0MQ5mtgsRCLDBhNMo2oVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QiZ3PhUg1/sq0AvKj8y/HjApkNiJc8hfYCcMCHumdA=;
 b=TtCXvvscRz2K4QylGuaEFXN7veRaS5U5qXO68KE4x7rl6N2d4PMaDXMm3p1Z3jx8uvxxHyHEQKRsbBMhI7Q7zFhBftd1D2QAkSi2PYjUa4NoBPdqErFZ12ZCP7N0Zo8ZPFiywGFW3vXfqn5/2tYp/fLw5aNioYBIM/Kmq7ZZgmU=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR04MB7167.eurprd04.prod.outlook.com (2603:10a6:800:12a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 24 Jun
 2022 14:46:09 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea%5]) with mapi id 15.20.5373.017; Fri, 24 Jun 2022
 14:46:09 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kishon@ti.com" <kishon@ti.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [PATCH -next] PCI: endpoint: pci-epf-vntb: fix error handle in
 epf_ntb_mw_bar_init()
Thread-Topic: [PATCH -next] PCI: endpoint: pci-epf-vntb: fix error handle in
 epf_ntb_mw_bar_init()
Thread-Index: AQHYh63jnkgyJ8o6FUODAWw8C6hSSa1eoSvg
Date:   Fri, 24 Jun 2022 14:46:09 +0000
Message-ID: <PAXPR04MB9186907C398EC709B7ADF95888B49@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220624094604.2159713-1-yangyingliang@huawei.com>
In-Reply-To: <20220624094604.2159713-1-yangyingliang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd2261b3-7116-4005-ebf4-08da55f046ab
x-ms-traffictypediagnostic: VI1PR04MB7167:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SC3DoNrpZCb4c/79UAN9Pj6f/1vxExg8utivAWMmmsay039nmQ68zUky4RSjwH5804K17+RhJZbZY5Of041fUDJ3uYJNI7EhuCW7RLq/ZLxu/C+u+vENS5ILUdyQ6nbo7qieIsIju/8HcFJB6TmvWQVUv0Zf3sYzq8MEo/syEtFmZ21Jj5XduoZoWhnlK3Tvhh4geDS/2297QKiJrJy5/4sAohSEH0SFAanS/zYTyYrP4eMwr/1SgAuB/r1Wo9d0tqAM6XqzgIBAAnWh2LhgOFMZI+5Lk6l5hX4Q3bJyaCOINrMD7tS2PJ+TGn2Sm2J+RIs/+JWBd9KXnVjLB1RjA08PDdyXQPKqgynKBjFkUCYKV6N2sWsw8mlVTqnifa5sj3GYYMfaPTsxVIzGFvGv3WQXO9OP/NBGimxagaz3zNeM/kQetxQTrlw1DD/uzpkwbP/RPJ2UDbvPOiFzAbOQnkMoFmdCkFbiWLrUiPYS0/bBZwjReUsZ9TSH8dwi7KDmWAcECjZuf8BFo/DffrNu6LK8dSHgX7w/mazhXpsjeadJprty0Rm28pgn5Y1WUyHssbkIT3jO66A5n6oL8dFP95PZ2hNtfmiVAf7EHyQ/yJpW4pQzCGazcfoP3sGEoCQHNDD4XPDhg+P9AQYrcW8j3PEatRHjXwZeBdB8OnHfMsxGF02xTCLCkj7C6Bx/uAXTomFdQiPS/tN55eyjdRVRy68uDFFj9Mmz85OJE5yFbRuiI+P8xQb79JnkJ97/nj3h3oO90FpItqLirh8oJK8Msg6otJTVIzbB3vKpADG5jaI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(8676002)(64756008)(66556008)(66476007)(52536014)(54906003)(71200400001)(4326008)(66446008)(76116006)(66946007)(44832011)(55016003)(38070700005)(110136005)(7696005)(86362001)(122000001)(186003)(8936002)(6506007)(83380400001)(53546011)(38100700002)(55236004)(5660300002)(9686003)(41300700001)(26005)(33656002)(316002)(2906002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?crnBl5gmMBJhIq9p1+Yk0qebiTYqapSVCqQg+1TsUpjjGK/cIWxwDZhCTfp/?=
 =?us-ascii?Q?qzu9aSrJDjazP9HI+UDLrzBR85sK17VzviG4rooplRtScKPaV3TXNecKzfIr?=
 =?us-ascii?Q?rqZ7FHTtbNe8XxZRVnGo0OgyVe3+6C4TsfyZhx4ql/09aK0gcsLO9HjB0dcU?=
 =?us-ascii?Q?4aOnqhbdwYQKHuHJpBhv8YlCB+vMdFOGlDADwShj82BDKRK6/hZKg+RT9JIA?=
 =?us-ascii?Q?zkEyS7dyVlJbpc8+8WQwc/sKN1xAl8GvTNEDSW4pVVde2wmGeTe5Xk6FjWpa?=
 =?us-ascii?Q?Q76gr/BIlKLprbde15Jt+RGtH5o7AJDiyaG/F+RIXgn4YWUPYxd2jutmPrJH?=
 =?us-ascii?Q?yrcJ462BfSqq2S70PXYn0LurhpdTi8F2hGbIbxdYgnQIME+DG4pujsxMTPrr?=
 =?us-ascii?Q?0OWsCZtw8eJm1wP4Ed6/oMIhBR1AlZjEtLn2N+H8VqHXIjKafjjtkQztUh5g?=
 =?us-ascii?Q?RgXJz2Z7Bpfn9Pweq+sAh5QpP8WYayGBWOXGe/QTlc1gxVI1syvY5YG4Efnc?=
 =?us-ascii?Q?6x1r3tAUrIcO/WY5uLW8yX5t/6QsWvwPvGb7QlnzaZMPyfdxf4IMSrMkBaHy?=
 =?us-ascii?Q?3uhR0JRpl/u6OiIdhol1hDaZ25AQGFDN7CySGeHJH6UGQkFfzMimnGQNjDUe?=
 =?us-ascii?Q?lKT0nnU4K0EGkIfCmsYrxBVXQN42VXu0iRfPbpWt+dPGxkse7p7EsWRIWIcs?=
 =?us-ascii?Q?Y+Tho/4/ojxzPaSBulC5/3Y3YUq0Op5wD5uHw3BlvdsFzdUbNUqqz+cRfyyZ?=
 =?us-ascii?Q?d7jEqlIc5ZUZ5+7DPofuWTcOkppV7cTKz9dz6PtMKdv0PWZnyVyyG+d2/uyL?=
 =?us-ascii?Q?ha8M2VsbhWqKZgJUy8xbuO28N1UErgbugmJO8uIw+CAJ2u+hOGHvfVM8OuOT?=
 =?us-ascii?Q?BrV43iQoqIzUQt6GRkVCClH8ln5vU/hNkXSgltbYjajNGimNL+NNbPjlk1Wy?=
 =?us-ascii?Q?dB4axlpB2PpyauwFnbM+Xh3e5CAAvur9q4FkyslJGvb/rXKnVuwBvYcU/945?=
 =?us-ascii?Q?jpbCQ5rawX3sY3KzRj5UaciqSdCYFDduJ/KfJ8DJjP74upeUGMpetArQWdao?=
 =?us-ascii?Q?zwDb2E1zyEsqLlwo7Ni3nW+JuaiVHN/ET3cdRhvs9aVWo0UY2un5NFf5xu7I?=
 =?us-ascii?Q?xIFdDsszp+JFqlZAW3TtoL6iUb/LDfzf55rZmAnGxYBW4IyzBJX41S8bxPq7?=
 =?us-ascii?Q?064bGAFovlCDXrouDo9AFcExJ1s+oX5pkry1AsemVXdEwIXxvhXzf3qL96c9?=
 =?us-ascii?Q?zdcEB+SO9oVAQKaeTBUcEImmtV3aCub6GBgevbGSVhiehYsSlBjC/ZRTMpbk?=
 =?us-ascii?Q?e2llyng0opXG1shFGwoOqc4A4C5mhWg3qHskAnm/moG6CDAQAFwh1ddo+G0i?=
 =?us-ascii?Q?dRhNeqVxLW2IYoW8brKNkmxVBRh/CS5d9FB1lHUywWwQK2vFhDTNIk7Nolmi?=
 =?us-ascii?Q?yCZXf6pkxLcQkSGSC3kF4nYBcQ9X1LtxS6mC+G7refZ38PKzoRRbZTOM5/72?=
 =?us-ascii?Q?jZmK4GrbcgtipSAKQu6NdQ7jN7QB5BqhJim83b1pUar0CaG9Fxnqk5PruLx/?=
 =?us-ascii?Q?b0CkKjfrKIUm8C4PoOc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2261b3-7116-4005-ebf4-08da55f046ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 14:46:09.1909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3OsOVrpV16swJn1BYGKYDV9iUZG7nykizD2GiuvaAIxa+UtvnE+He29MJUFfNdeAWc6OBQ9ur9Qm4+s/Op8fKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7167
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Yang Yingliang <yangyingliang@huawei.com>
> Sent: Friday, June 24, 2022 4:46 AM
> To: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org
> Cc: Frank Li <frank.li@nxp.com>; jdmason@kudzu.us; kishon@ti.com;
> lpieralisi@kernel.org; kw@linux.com; bhelgaas@google.com
> Subject: [PATCH -next] PCI: endpoint: pci-epf-vntb: fix error handle in
> epf_ntb_mw_bar_init()
>=20
> In error case of epf_ntb_mw_bar_init(), memory window BARs should be
> cleared, so add 'num_mws' parameter in epf_ntb_mw_bar_clear() and
> calling it in error path to clear the BARs. Also add missing error
> code when pci_epc_mem_alloc_addr() fails.
>=20
> Fixes: ff32fac00d97 ("NTB: EPF: support NTB transfer between PCI RC and E=
P
> connection")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index ebf7e243eefa..d8ed640c16c4 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -567,6 +567,8 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>  	return -1;
>  }
>=20
> +static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws);
> +
>  /**
>   * epf_ntb_db_bar_clear() - Clear doorbell BAR and free memory
>   *   allocated in peers outbound address space
> @@ -625,6 +627,11 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  							      &ntb-
> >vpci_mw_phy[i],
>  							      size);
>  		if (!ntb->vpci_mw_addr[i]) {
> +			pci_epc_clear_bar(ntb->epf->epc,
> +					  ntb->epf->func_no,
> +					  ntb->epf->vfunc_no,
> +					  &ntb->epf->bar[barno]);
> +			ret =3D -ENOMEM;

This function move to goto and keep consistent of error handle.=20
=20
Suggest:=20
	Goto err_set_bar

	....
Error_set_bar:
	Pci_epc_clear_bar();

>  			dev_err(dev, "Failed to allocate source address\n");
>  			goto err_alloc_mem;
>  		}
> @@ -632,6 +639,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>=20
>  	return ret;
>  err_alloc_mem:
> +	epf_ntb_mw_bar_clear(ntb, i);
>  	return ret;
>  }
>=20
> @@ -640,12 +648,12 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>   * @ntb: NTB device that facilitates communication between HOST and
> vHOST
>   *
>   */
> -static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb)
> +static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
>  {
>  	enum pci_barno barno;
>  	int i;
>=20
> -	for (i =3D 0; i < ntb->num_mws; i++) {
> +	for (i =3D 0; i < num_mws; i++) {
>  		barno =3D ntb->epf_ntb_bar[BAR_MW0 + i];
>  		pci_epc_clear_bar(ntb->epf->epc,
>  				  ntb->epf->func_no,
> @@ -774,7 +782,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
>  	return 0;
>=20
>  err_write_header:
> -	epf_ntb_mw_bar_clear(ntb);
> +	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
>  err_mw_bar_init:
>  	epf_ntb_db_bar_clear(ntb);
>  err_db_bar_init:
> @@ -794,7 +802,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
>  static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
>  {
>  	epf_ntb_db_bar_clear(ntb);
> -	epf_ntb_mw_bar_clear(ntb);
> +	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
>  }
>=20
>  #define EPF_NTB_R(_name)						\
> --
> 2.25.1

