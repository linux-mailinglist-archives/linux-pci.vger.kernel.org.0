Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE337279EC
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 10:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbjFHI14 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 04:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbjFHI1z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 04:27:55 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2136.outbound.protection.outlook.com [40.107.113.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3302717;
        Thu,  8 Jun 2023 01:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNFVTLpXBKOBRzyOqgnFo5Ak4Y56rjBvuAsXN1v2L51U0gHBbhX1sXtCn5qbeQbFN4kkbQ9MmkwlnV3SIXAWalBcwAHO4nY0fn/CR+tJnBJFNjAXI3WuzFSGfce2IRAvprEE7EayApSib+Eu544fL7YkfbgNvDpIyHEERTt5rhdKq1z3TkS4lR5kNYHWLULYRsZuLJoBXvl3xbvHyPvPGZMustuM8/aapkbYKZ7JNLDgJvL5xpvCNJifLaJvDFBAf8P5lj2/wxEQHpNFK7dZlND74B21bZahnixPnPXlpS2NVibiuLrROS/ly8UUm/Zj3IhrHCg7aGx87RNyx+u88Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VY+JD7hlHoa/9EEwI6WhwY0Nez8GUB03v0pWVza0T8=;
 b=bKSJMxWYxRo4tUQ0XDcSWDjJ8L4ZJE6LGtsHJ5l/KTyr/KpkYzacGWROtYCp7HeFh/84FaUV193tLsbNs0CMpbiu2kc/BXRFa2pJP/edvdgcM1qDhm5XR2N/+QRlC8hbZ8rAEXPht8cFvLufrsgp3pBWmQ1CDXSPf7000nE6ns6suOFA3IlUqCPdunjUtWj+kEcW/3zzu/og7e4DrjP8nCO3ujUx//VbIhhUuhzduIKzN5HDc1O24s1i0sG49sEoOoj+0wMD0yvayt55namhKv0ct8yMpJgPmDbsaKXzCqcK0NwJigvmoYh52j1olq/hBQ11joojA7u9g54JlBt2fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VY+JD7hlHoa/9EEwI6WhwY0Nez8GUB03v0pWVza0T8=;
 b=MGQS9CYVZApjKF3ysaTxniAEeC2dJPXR+JAVuLPpr92r4Z2vFNlGXQkTeYgmdNPsVENDs2PxW4juWE9wOyTN1PoFmE5BWP/hJwubmJb5GaxuOvcB+JlM6fzzMgG8FX6cXxSxlNbuc2nKn7hbiDa7kDHS9rtAFjA4KK9VJBtWclQ=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB11982.jpnprd01.prod.outlook.com
 (2603:1096:400:403::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Thu, 8 Jun
 2023 08:27:46 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1%3]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 08:27:47 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
CC:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: rcar: use proper naming for R-Car
Thread-Topic: [PATCH v2] PCI: rcar: use proper naming for R-Car
Thread-Index: AQHZmYFZauDlkpFUiEOSfmcVHio43a+Akv9A
Date:   Thu, 8 Jun 2023 08:27:47 +0000
Message-ID: <TYBPR01MB5341D861839D81522C64C980D850A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230607204750.27837-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230607204750.27837-1-wsa+renesas@sang-engineering.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB11982:EE_
x-ms-office365-filtering-correlation-id: 9b9d65a1-062e-4f03-2d7c-08db67fa3d52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xrqMAcVQbw+GvJK0rjlhlawlpaSYoNO0+DXMslH5RqTs20MLhQG3NMbNr0nzixMj+FxpJnMde+9/YFZ/54yb36jnr7ku+pt3Pvd8Z1JbPT9DyiaxblKxUzxDlB5KEawRcmS7X+1/PTCQPPkdPi8EK2HlcuFRQdT5EJo+B1E1yvAZSBVf14D4xEQODg2V3uBvyRxUGesoPyKC+hZiUrKqvq9D4u0w2UmTeRWahVzL6qkrkPr372F6VQbjEaxL8f5EBNoAQ0yEGFt7IQZySZJAXeS/hGGT1KvnjaDUVzCYBGHyDw/4erLYN28qkB2wVA/VjkhHX8jg5ZMK9PJqdYkofKTvm3HM4CwwQE3ST+Wp6kIoX6ADa5psTN4oRfmfuvOdwwwu1IToMogkHlh9eS7kfm/1zwxpWC8CXQg527BEsaPuk9EXSbsSNMNzwm3ZRLMpkILkO3h3mS+qGNjSMbCMNUhBDHt8mOkbsLTlecRRiewWu9xDijZNLPqITfLqneBX0NefzZF2WVEwM6frRmUIUxDfCEP/v9WHEsbAxJixHhlj7Oz8FowCbAbG63ZK2ftRhO5DjxH5aI8AbFQJWdISp/ZGiV5Row3NSbrWAxjKtxUfNCMtOHckhm0OJDCotSKx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(186003)(38070700005)(2906002)(86362001)(66476007)(76116006)(64756008)(66446008)(66556008)(66946007)(71200400001)(4326008)(122000001)(110136005)(83380400001)(9686003)(6506007)(52536014)(8936002)(8676002)(33656002)(5660300002)(41300700001)(7696005)(55016003)(38100700002)(316002)(478600001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?baqtI8vuomraaRMczcR0GnIgRA4eow0NrX3FgA6kF+48VbjYEWLcZBPtNm?=
 =?iso-8859-2?Q?hjxHp2dRvJtGESNc4c5EZec1FUOL9bDLHwywasc+8D3Xr2XXnj0abtNfSv?=
 =?iso-8859-2?Q?2nKz+dIhufzeXi53R/jXIyHqBsh+rNb3at2DRx+zhjRzZMaOJn+H4T2Ysk?=
 =?iso-8859-2?Q?8T3hO1VcV+gH1+VF77zYqvpON134bAAmzLzeEcuOZy6PNhByAqcucbu6Wz?=
 =?iso-8859-2?Q?p26V+UhCZdQTesLFJPfuVvv1eSlyHmmYlSVLtvcS3f/FQHijnfSQhUXiwn?=
 =?iso-8859-2?Q?7Lpbqg6m4xLtu4msyx+4MMUNlFX9hoQyRj2M/siHxC1J6Xg3Hdgco733Dq?=
 =?iso-8859-2?Q?vHvtHqKS58h4KNEtBBqBIwnin3/CMvqOmRxAlHd4ilrO+dVcHJEA+GahAn?=
 =?iso-8859-2?Q?Tb4aQa/Yz0KrPv8JBpfTDv0vDLntjLKubIqygvOOhlbqP0MaTsYqPLKEa4?=
 =?iso-8859-2?Q?3wRJmrP8Q+RlZwX5o/l0dkjrpyE2NbBgBJf+Rofm7SF16A2ohOQml5dJVQ?=
 =?iso-8859-2?Q?E3ZuhQXtWPzXaWPQVnDt71BIs5up4qvNc+CKhLi1yIc3brGZ/7ua4M65jk?=
 =?iso-8859-2?Q?jZAr1wuJnzrc7ht2T6uTyMEyuOSmlA+q1YYBItQt+2NR0/xzaEMUO8ZWai?=
 =?iso-8859-2?Q?JnFtnf8rcZosih1QmHAqag89EY91+ntYm1mG9ZGservLKG2ut29gjRHAuB?=
 =?iso-8859-2?Q?7jbrLl16GBAzU3BOH+zuLAZxu0+HU4PDTZJP3ss7ia8SzLxjvTd/yCe0/Z?=
 =?iso-8859-2?Q?sdRVX/nH+dy5MmXnFCNHqlKR2edWFquQCaICmDuVUjK35kcqhqFmJFzrB+?=
 =?iso-8859-2?Q?BVtfpKs5M5sLD+a2Nc5fa4R0IeOWqsTuJT0BmLQh5x3460TXOOdmWU2wrX?=
 =?iso-8859-2?Q?nSRAglWvp6plJ/k0yXiDEABQSZN6VHliNmUzuVW8rYoLNY/ltM+Yi5HuQn?=
 =?iso-8859-2?Q?zhWlBrEVkyi1wMNRpjXM3BKVijvMT9bjbzV/4bLukFm419nbaT75/xrSsf?=
 =?iso-8859-2?Q?pVnLgCCMbS0Y4lQ32nYdUCTLGoApAFIgxwnD4uGtULj/q+Xlvc6yy9UDAp?=
 =?iso-8859-2?Q?B4VVlUSsdLMCgsNvKipt9ii2s0GMv1VapuT7tKkYDycTNVKEb0FJqtaLmg?=
 =?iso-8859-2?Q?NBIt4sDdru+IZrxlJk+GVVxX3RWdx4nBgZZAKbonz7FRgvxCut00Gns3Ym?=
 =?iso-8859-2?Q?JoprG+5MkOGfj5u47x7u1fjrJQX0R4U/gwQDECv/O/tQMc2Ijze0Lc61O4?=
 =?iso-8859-2?Q?obW8DmxJjCiy6gp/mTe6mKj3uMrGdzXJx2RDiqRRSgjdp2rfEnHI9WWhAE?=
 =?iso-8859-2?Q?WpIg9I+pbbOjfHDVb5VN12Jj2omCPuDBo7F41khl68GUIk31zbN+7Lba37?=
 =?iso-8859-2?Q?KdjACb/9p4wdazReASglDb259wwOS7aERsxUnLGFXyg8TRfK9eU6fzhTtq?=
 =?iso-8859-2?Q?G6TI0Xhe/FecbJMcrb9XHmzEWjG4naKZqoys5RlLSxewVwYnyqrxomb6y2?=
 =?iso-8859-2?Q?a42YyX52EgVoeAJEoZRXDigHVAEzK4B5w71HwBeXfYCv7IEcNNRNv5hc0C?=
 =?iso-8859-2?Q?hRyG1EpFif4RRPkX7NP4ZlI1oQzRP8VUTfy3jCxelW0KgpAq0nuxGGc8LV?=
 =?iso-8859-2?Q?A2YzJuTMKFY6M3L3N16WZWyGKqR+UFFtufsVmRywZGhlLYit/bWt7Aw3AR?=
 =?iso-8859-2?Q?Pcmuf3zvn2t/HsKSXuKHwPHZA9em+b22mEs4IOn837S7PT85kFT6drgKSn?=
 =?iso-8859-2?Q?rmvQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9d65a1-062e-4f03-2d7c-08db67fa3d52
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 08:27:47.1318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3xtU2zIZhFm6LaAUKYtR+Gug5vImubF7X77dqs4/ncU1rDofyuYiRzMb9JDA2yUOVv+cwG+Ron1KFtG6rRjivKLofKawbNpnARFzsXgS5Sv7RxFYxChlfCa0gkLUeC6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11982
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Wolfram-san,

> From: Wolfram Sang, Sent: Thursday, June 8, 2023 5:48 AM
>=20
> Neither RCar, nor Rcar, but R-Car.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

> ---
>=20
> Change since V1:
> * fix typo in $subject (Thanks, Biju!)
>=20
>  drivers/pci/controller/pcie-rcar-host.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/contro=
ller/pcie-rcar-host.c
> index e80e56b2a842..f4dac8ff97cb 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -684,7 +684,7 @@ static void rcar_compose_msi_msg(struct irq_data *dat=
a, struct msi_msg *msg)
>  }
>=20
>  static struct irq_chip rcar_msi_bottom_chip =3D {
> -	.name			=3D "Rcar MSI",
> +	.name			=3D "R-Car MSI",
>  	.irq_ack		=3D rcar_msi_irq_ack,
>  	.irq_mask		=3D rcar_msi_irq_mask,
>  	.irq_unmask		=3D rcar_msi_irq_unmask,
> @@ -813,7 +813,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host=
 *host)
>=20
>  	/*
>  	 * Setup MSI data target using RC base address address, which
> -	 * is guaranteed to be in the low 32bit range on any RCar HW.
> +	 * is guaranteed to be in the low 32bit range on any R-Car HW.
>  	 */
>  	rcar_pci_write_reg(pcie, lower_32_bits(res.start) | MSIFE, PCIEMSIALR);
>  	rcar_pci_write_reg(pcie, upper_32_bits(res.start), PCIEMSIAUR);
> --
> 2.35.1

