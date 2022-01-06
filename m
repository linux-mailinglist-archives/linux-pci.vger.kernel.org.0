Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4459C4860F0
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 08:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiAFHXG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 02:23:06 -0500
Received: from mail-vi1eur05on2088.outbound.protection.outlook.com ([40.107.21.88]:38116
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234429AbiAFHXF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Jan 2022 02:23:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4bSmiugJsiAEpbfdNhtS4QaYweA0gBbEpGOfX+Z1Rdiu0XOtgFs3KUydARNUcwm+rSc8MuwyQ44JbGtkaus0owqwoAbS9ELBw5Ddvc7v5FPK8H5kUO0n5cBgaFuBJIqDcFFZi2tgYUYL2axh7Lg1bH7Lhp84IS5xtGdGEi3pLL9g8iyeDwhtx4rfpa5GONchg5aj3q6+eJF9SKjSQDQUMZ6a8QLWPZ3xoZmHJ2RGCbvbDyefMwM4CuAhM1I3EUSymC2IcBR5T5PyA6g5e9b5zTQMjOkN1DE0esSyIBLlEvmwAA5VBdZ05PW0NLxfWTW1ycKjH3GDCGF4yetbKcG0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOq8rT9CyYwqZ4LZRdsuP+RzVPsrByGqE7zmIQTo8B8=;
 b=DVzvUPA35v0qQXRw1n1hWdwShgT/Ufe+2S6OhHAXLbUIk38oP27ipfh83Rl8dBgMNEXL01py4E6FWgtq6+82g52c69FbtslbdnWOeoNnK0GHQ5J3QoLZerR6qDkz1vAhpUlLgi4eO1iEdIljKP+c0X0kEcrWS5pOWzv6NleIEaapgC11TO0RgLRD6uGQKFZZkle9p24H1dysGO1Hr9wL7tpoKUEAAq7EAkw2Gxl1yFCMSYoRG1F7CJquJvgcSc2qonyDaP4lH8KnD+LHj7dfwMsBFc8onE/0cvX7JH7rqak9q3G6zFfOHngphESTCuHr0GZvUELDJfszUatOw1CcaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOq8rT9CyYwqZ4LZRdsuP+RzVPsrByGqE7zmIQTo8B8=;
 b=jrT37Ha/0sdGZdArJ1OTdXsaSBrcpiNhI93y1vn4XyfO2F9ges9wMOVsEY0b2dpIEaXs7khl+ciWQjqmbsvT3bQKyfhWGcYH1+lbPOorAKuD71b6YcoIIggw73cUT6blN9zzz3EjmoZDyngruy/Co33IQWT0i0M843gBpPzD7/E=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS1PR04MB9285.eurprd04.prod.outlook.com (2603:10a6:20b:4df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 07:23:02 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::949e:59fd:6098:6508]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::949e:59fd:6098:6508%4]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 07:23:02 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Jisheng Zhang <jszhang@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: DEMO VERSION! [PATCH] PCI: dwc: Fix integrated MSI Receiver mask
 reg setting during resume
Thread-Topic: DEMO VERSION! [PATCH] PCI: dwc: Fix integrated MSI Receiver mask
 reg setting during resume
Thread-Index: AdgCzS9+v83JFPuhSyeUERkkeO1ynwAAD08g
Date:   Thu, 6 Jan 2022 07:23:02 +0000
Message-ID: <AS8PR04MB867645954BE452781458B80F8C4C9@AS8PR04MB8676.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66d896e3-f3aa-4348-20b2-08d9d0e56020
x-ms-traffictypediagnostic: AS1PR04MB9285:EE_
x-microsoft-antispam-prvs: <AS1PR04MB9285DE2ED701107B807941988C4C9@AS1PR04MB9285.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wUnAUEa8+mgEY7XTJZD47a8eHuW/8UWuMeoZJ6gdGHz08GqGnZ4jHHR9EKFkKIAsD/Nejo5nfYAY3/dgfM17BNHNW7YTX8dBabV16/8qlfKG7ijNl7sbyQE4pXGdIbDCPhy2tCFQSrJb7RleAwhVVI8WphZSNTHMo/eO302TI+ZryWC9rPAX1HLtsWcP/I5GLvmnPd99Fsph6lvggrIh7q1uJlVRfF2QzpKiKul+nnlPjeMZjodXiMCfdx9Uks2cF3tvu9/yDTX0S15rNv6SnOh/IstSCpI02SjDRrPOI3elTAEn38zB8pp/IxO8p5+0iehEHnatOca7jHwjAUo55FZalQ8ZrUFgestwMJcZObXtab/onxZM9b0rr5pxcszAQUpGzn7AxSFoYJj2PooKckhbhw3lOS5TYr5U3cIyP5QAheIWknWOc7ZVBYA5kfLWiVmgrgdqerYaubtx+KCOSY0cJ29t0yCO7H+h4kfehws1tmO67FkszarkehrNq55ykK09kmdUF3WkOALrzI2GauwrkCI2TRXONFDRyMJFdqWNmnPDqi2DJADNIUcFOUDZw/fRFZzrTE0+GVRla2I/Opd9BIWOXt9RCq0AJvhEXSPdXFV/RWYtBb2Ki36xRn2GwwaBkaZxuv9zokgDdngSf6KMewrD2Y/sbGlxsO+RdQfn3982+Lbif9D9h7W1uv98VNtzKwc3lKK8TUMpLe/0mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(64756008)(54906003)(86362001)(52536014)(8936002)(110136005)(66446008)(66574015)(55016003)(8676002)(33656002)(508600001)(66556008)(53546011)(6506007)(76116006)(71200400001)(44832011)(4326008)(5660300002)(7696005)(186003)(26005)(122000001)(316002)(66476007)(66946007)(9686003)(38100700002)(38070700005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?HX2GQeJG8h4sgj8M6QsGyCwCyzE5cKwFQ9dWm7/WelbCvSBuq4KtDFbq9e?=
 =?iso-8859-2?Q?EnI09I2F1CMrPdXmMfnNMXue17eySuzjqb3nfpHlyDrGFaHArz9fzJbSPn?=
 =?iso-8859-2?Q?Qm04H2rhfI2gZt+DIftHw+e3CF6+LDaYldb+UBI2zWTwL07sg3lrv72OvJ?=
 =?iso-8859-2?Q?b5vl2/h/kyLuxkM6KD6DdOFeAAbiwP7LfJpfuaiOz7NzB9+Yk6Fiz8OqN9?=
 =?iso-8859-2?Q?CGHWFpjGYvPD1ZbVlvct2kj8M4PUGV+MMQyaRiOi0pxFTRYqk4aDSErHdT?=
 =?iso-8859-2?Q?xzpWGQIIM754+c83xBFn5qDK/Miq4QAjPoDgf1YFtQLff3OCHB5AysRKHC?=
 =?iso-8859-2?Q?N8GGsWnmYYGjk9SMaNmZPzm4dy27CaFp5hcEKe/yJLBwBx0M5v69zq7WXx?=
 =?iso-8859-2?Q?yXAy6pyLNQiJjMJDfhvB1huz/gXBUCDRRb6jBaiwp0faoxLwK6pvQNpMEG?=
 =?iso-8859-2?Q?ve1zsVMw+dnZf6tgaUcuAqy9ze8pgCWHAZykj89jCJ6L+TED2r3IpgUn27?=
 =?iso-8859-2?Q?5sf+/W/hkeznbEGTZLaxdSvPkCqGGZDib/hYa2YVNlS2Moyuf/l2nsjkSK?=
 =?iso-8859-2?Q?BG2LJF9vZPcqqtELVN6dROSXVsXQtxW49NLQ9QzRqkZCdUII/gUFRbsDdN?=
 =?iso-8859-2?Q?eCijBE8eqUnhvmlbPi5nxz9bSAxisBLu6uh/0PWDE3KFZ77+PFtIc88znl?=
 =?iso-8859-2?Q?nUFiVSV//ZI0dsyi3Fnak6rERL5Pm7+FJ453TAE2apgxZlHA0GTkr9bspH?=
 =?iso-8859-2?Q?hG7cU+SOKXpbcdOuPIBxJv9mSQD9xVKfunrrrGfx4Dmzo043rm4YpaGZxM?=
 =?iso-8859-2?Q?WzhBMlMBtGdR/GXCW0abY4KKH+jFQHWTDUqRcEmeIY8+pOLLjY+31+7y1v?=
 =?iso-8859-2?Q?WUZ2PXiRK8QQSpjlbjnTG1fsKw2AMiw+gly2N4Be2eRl/g5P+oTv7i4Pps?=
 =?iso-8859-2?Q?ia84GSpsz2U0QHic4A+Ji9VEvl7hKIhnz5KYcfk4QfRpJ51XKNxc/zCenY?=
 =?iso-8859-2?Q?4wL62sGslYSttD5w6msPHFxyhguzgF+7u51aBVMo5HLyXTFGB9ixMsh6SK?=
 =?iso-8859-2?Q?CjGMQMeUhaob0exivaxD3pQevUlcBpn39M5ftT/YF1vdY+HcUMwxGdkuGk?=
 =?iso-8859-2?Q?X8HzANZ+j4JZ5gnoHvf4W951JpSRacOUGocL6bh2RMqfS2nr9YxoExXg1W?=
 =?iso-8859-2?Q?87TkAnIK/Dw56jbG6fa1g24jJST1KfCM/rfe+kpvzpLbglkR2x00gBRpNZ?=
 =?iso-8859-2?Q?S9bSUY99RTtRc3+y5550Hrh2D17WKh1OZCuEQt6weWqlrSeAEiikVX7ez3?=
 =?iso-8859-2?Q?rEG6r73h/eQtiPBcjGfjaqknBW68JIYE+Q60zgc6FKcVXj6cGie/SOfIN8?=
 =?iso-8859-2?Q?rVwuv0FqWBeUtORtZ0k9HEwc4CwSB0nR/1P0i/RDNoMjwzzzrFmGzmWnQ8?=
 =?iso-8859-2?Q?HfCx7k/RCKCWVG+CRLD68lqLEfWiF9Hi3TTrSa6dQ6jcIUAAfCcGyfNZAQ?=
 =?iso-8859-2?Q?f54U5cskpwG1C0eE7oU/jEheZnMcntuml4rzB2hQ55W2lrXz8XKwQirFPc?=
 =?iso-8859-2?Q?xJk0SLdMd3dzZtj1dv2v546OI6vJG3hzmguBX4zUlZlngNcACVVyL+UjH6?=
 =?iso-8859-2?Q?QtG7Jg90jM9rjo1uRbgWr7B5xtpkSrRo8Ki6WLFY5p1AILMKDCazYZBQ?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d896e3-f3aa-4348-20b2-08d9d0e56020
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 07:23:02.7973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8/BwJuyihGNHVvFfOni0kmpaKvYVBsksCJpcH3zkujOYqdRde8bp45g0937y038TtVvi2ag+tSOoxLT0xTJ38Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9285
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Jisheng Zhang <jszhang@kernel.org>
> Sent: Sunday, December 26, 2021 3:40 PM
> To: Jingoo Han <jingoohan1@gmail.com>; Gustavo Pimentel
> <gustavo.pimentel@synopsys.com>; Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com>; Rob Herring <robh@kernel.org>; Krzysztof
> Wilczy=F1ski <kw@linux.com>; Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] PCI: dwc: Fix integrated MSI Receiver
> mask reg setting during resume
>=20
> If the host which makes use of the IP's integrated MSI Receiver losts
> power during suspend, we call dw_pcie_setup_rc() to reinit the RC. But
> dw_pcie_setup_rc() always set the pp->irq_mask[ctrl] as ~0, so the mask
> register is always set as 0xffffffff incorrectly, thus the MSI can't work=
 after
> resume.
>=20
> Fix this issue by moving pp->irq_mask[ctrl] initialization to
> dw_pcie_host_init(), so we can correctly set the mask reg during both
> boot and resume.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
[Richard Zhu] Hi Jisheng:
Based on i.MX8MQ and Marvell WIFI module, the MSI works fine after resume.
Thanks for your patch.
Tested-by: Richard Zhu <hongxing.zhu@nxp.com>

Best Regards
Richard Zhu

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> b/drivers/pci/controller/dwc/pcie-designware-host.c
> index f4755f3a03be..2fa86f32d964 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -362,6 +362,12 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  			if (ret < 0)
>  				return ret;
>  		} else if (pp->has_msi_ctrl) {
> +			u32 ctrl, num_ctrls;
> +
> +			num_ctrls =3D pp->num_vectors /
> MAX_MSI_IRQS_PER_CTRL;
> +			for (ctrl =3D 0; ctrl < num_ctrls; ctrl++)
> +				pp->irq_mask[ctrl] =3D ~0;
> +
>  			if (!pp->msi_irq) {
>  				pp->msi_irq =3D
> platform_get_irq_byname_optional(pdev, "msi");
>  				if (pp->msi_irq < 0) {
> @@ -541,7 +547,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>=20
>  		/* Initialize IRQ Status array */
>  		for (ctrl =3D 0; ctrl < num_ctrls; ctrl++) {
> -			pp->irq_mask[ctrl] =3D ~0;
>  			dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK +
>  					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
>  					    pp->irq_mask[ctrl]);
> --
> 2.34.1
