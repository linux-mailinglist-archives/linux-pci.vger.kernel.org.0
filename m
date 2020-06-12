Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3389B1F7C88
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jun 2020 19:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgFLRho (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jun 2020 13:37:44 -0400
Received: from mail-bn8nam11on2086.outbound.protection.outlook.com ([40.107.236.86]:6076
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726272AbgFLRhn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Jun 2020 13:37:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBpXT/soVLpPDLosm1DZRqbyCcIPVV+VY5DiF/7WfWOCtnHpFfc7qQeYmZ5MgtjwqZ64Ukqq29GBiR+Fe+p/gMzNj8fddzVgaMhbxxcrLM5RW8JF8bJ5FlE9HZU7u3+1j55ynrMdEz76J31O/zQr769YSBr+df4Yx8gMJxmvNh6pG4bDflUC4qJz8OcBaLmLZbdF4YnlRihbfcGGMV6FqqLq2+MrMl8tTpQNMYSt7GKOSTdh/sKKMVkoiPJrFV5zoKywJEbXAikrUdFsanlXC4ZBKmG/E6Ch44y6xiUvUL9ss0YOkauLk2sK+cb+XFKGeXFx18Ip+k/nmOTJQ8JQ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cy0BPtFmwVxE9RI1pKAIv1QuNBZCokxccMxxaephwNA=;
 b=e0Xnhke8wzIGql+CGTEgma7yY7h3JxM3pvgAZVcHqjRf8DOnFg9mlS0QtkSeSEajKZC8uV5j+94M6HI4xKzCyPydxrsUzMs0aUvUzuITbz0+0Hk+gI+VcmD6ER96vdlzxoDBag5CQTFTtMEL1piiLGLE9WkSV6vx4qR5CpkgUPbDOa7FVNtKgNAUN2LJI2XK4GEW0MTL9UfvdNUYvfD7qouKBlaZUIvUuTIy/DL15BatWRhC9l3QTDwhJ7pYnCh8cCAvT+CsaxYzN45kkIGwfQeoaLRznz1a4vBeTOVtOLcbnN8LXguamhKfXIfLtzfDedbo9ekI1HAUDP+AXR1lfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cy0BPtFmwVxE9RI1pKAIv1QuNBZCokxccMxxaephwNA=;
 b=Z8oK33l6Nc/GjwAqiqwFrNL/xUJXedeUV5VvhIR/kSL8sadEdUHYv54X4ZMGDa0SwYNWswcX4tS0d0VdZz4YV+sxRb9R+BOrGrOwAjNFPJEgTmMZCGiga2VjnD4WUf0XlnEM9eoWrreyDXBHgMO4V4E3YnEq18kcEuO3jZqtJ9k=
Received: from BYAPR02MB5559.namprd02.prod.outlook.com (2603:10b6:a03:a1::18)
 by BYAPR02MB5829.namprd02.prod.outlook.com (2603:10b6:a03:11e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Fri, 12 Jun
 2020 17:37:40 +0000
Received: from BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::ad86:19b4:76ec:28b]) by BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::ad86:19b4:76ec:28b%7]) with mapi id 15.20.3088.025; Fri, 12 Jun 2020
 17:37:40 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: RE: [PATCH v8 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Topic: [PATCH v8 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Index: AQHWPZdq6W68nNHNZEqBlWufdyFfUqjT6lAAgAFU0zA=
Date:   Fri, 12 Jun 2020 17:37:39 +0000
Message-ID: <BYAPR02MB555986C1464705810BCBBBE8A5810@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <1591622338-22652-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20200611205616.GA1607864@bjorn-Precision-5520>
In-Reply-To: <20200611205616.GA1607864@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef7820b7-2f05-45d9-2361-08d80ef74dfc
x-ms-traffictypediagnostic: BYAPR02MB5829:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB5829949BAD47AC52880CD9C0A5810@BYAPR02MB5829.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0432A04947
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +wroNe0jlIZt5tI7tz9x3UbvHNmaSH+pSTAQb1kATm7riSGRl83x1jtvkFdt21igjzgQTnlyhIEMoj4tWHjT022SPERhRO0znb0HP9dFfebigwcXm8GfSAsLC+zBC6U6v4UtESKvhgdunaZank4jisR1V5wVhUlFWfIuy0/LnM4yYthIDaiHiIhuimJCzmohZlyiuLauWpm7bdp8fAdHWE7jaR6MEzFP1NtzYufzrKDV2zMhtVdL7DVtqYXBDxPU2cctkEIdl0msFO2KCQRIkVBb9wjp9Hkdf2zzaGHfVJ2JfWA7LeYtMSm/WGodM/4TkeERnocj18UO4T0oa2y2Sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5559.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(396003)(39860400002)(366004)(71200400001)(478600001)(64756008)(83380400001)(86362001)(66476007)(66446008)(33656002)(52536014)(7696005)(66556008)(66946007)(26005)(186003)(6506007)(76116006)(4326008)(5660300002)(8676002)(316002)(8936002)(2906002)(55016002)(54906003)(9686003)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1tQx+bcYLV+ka/9rolew+GquPbWkFBcWxkHiVMjRyGLMLQKpxZJ89+YxQtqNsIDVlY1JGL31HBQfU4iVR6nrnvWWleRDnXYptN09S+QTmhaz71stDm8ulPA1LKsw0wxii5bUGUHhib7DaNTkFEZRJV6IBg4gu4hh3mSfph+9YpnnQ/m46q1F9gvzd69je1WiKOFmApCf2BAcJEygaz51l0+tojJ8/w5fs7roOXvVVlRJJvA/LLUmtH+ZSo/gJ5XluSA/UU+JJBKkrc1YCqWFxBIPXcpU8KJspCA/aSzx8XP2avwpK+chdVQzBKUC1wQgD+ELJUuCLXsrjXOeAXh2KnjcoQPdfNthsHWP6tNZI81Hi/dl+HLQLkyah7SgpuBsMzujQDqN4g1g/N5MxMFgutkqjNkL1PvtsAju4Ntp56R4pkUTTmqwQ7vZEV82zUSk1rHtMnEPprpianIyhI1W4SgKwlDuRYZsMygGC9qAwpBFxTqhMsSrbpTT6ksF5ZNa
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7820b7-2f05-45d9-2361-08d80ef74dfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2020 17:37:39.8807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hqdib+00QWbgP88LOkwY5OZWKI1yOEwdLRsr3fXABkGBKW0PUdsp6OSsqWXkJ3pC7XcspeM0HRnGT//3BDt7xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5829
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Subject: Re: [PATCH v8 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port dri=
ver
>=20
> On Mon, Jun 08, 2020 at 06:48:58PM +0530, Bharat Kumar Gogada wrote:
> > - Add support for Versal CPM as Root Port.
> > - The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrate=
d
> >   block for CPM along with the integrated bridge can function
> >   as PCIe Root Port.
> > - Bridge error and legacy interrupts in Versal CPM are handled using
> >   Versal CPM specific interrupt line.
>=20
> > +static irqreturn_t xilinx_cpm_pcie_intr_handler(int irq, void
> > +*dev_id) {
> > +	struct xilinx_cpm_pcie_port *port =3D dev_id;
> > +	struct device *dev =3D port->dev;
> > +	struct irq_data *d;
> > +
> > +	d =3D irq_domain_get_irq_data(port->cpm_domain, irq);
> > +
> > +	switch (d->hwirq) {
> > +	case XILINX_CPM_PCIE_INTR_CORRECTABLE:
> > +	case XILINX_CPM_PCIE_INTR_NONFATAL:
> > +	case XILINX_CPM_PCIE_INTR_FATAL:
> > +		cpm_pcie_clear_err_interrupts(port);
> > +		fallthrough;
> > +
> > +	default:
> > +		if (intr_cause[d->hwirq].str)
> > +			dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);
> > +		else
> > +			dev_warn(dev, "Unknown interrupt\n");
>=20
> Maybe include d->hwirq in the "Unknown interrupt" message?
Hi Bjorn,
Yes, we can add.
>=20
> I assume if we take the default case, there's no need to clear the interr=
upt?
 It's being handled in xilinx_cpm_pcie_event_flow.
>=20
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
>=20
> > +static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie_port *port) {
> > +	struct device *dev =3D port->dev;
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	int i, irq;
> > +
> > +	port->irq =3D platform_get_irq(pdev, 0);
> > +	if (port->irq < 0) {
> > +		dev_err(dev, "Unable to find misc IRQ line\n");
>=20
> platform_get_irq() already prints an error message; you probably don't ne=
ed
> another.
>=20
> > +		return port->irq;
> > +	}
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(intr_cause); i++) {
> > +		int err;
> > +
> > +		if (!intr_cause[i].str)
> > +			continue;
> > +
> > +		irq =3D irq_create_mapping(port->cpm_domain, i);
> > +		if (WARN_ON(irq <=3D 0))
>=20
> I'm not a huge fan of WARN_ON() inside "if" statements, but ... OK.
>=20
> Why do these all need to be WARN_ON() instead of dev_warn()?
Yes, it can be replaced with dev_warn().
Will fix these.
Regards,
Bharat
>=20
> > +			return -ENXIO;
> > +
> > +		err =3D devm_request_irq(dev, irq,
> xilinx_cpm_pcie_intr_handler,
> > +				       0, intr_cause[i].sym, port);
> > +		if (WARN_ON(err))
> > +			return err;
> > +	}
> > +
> > +	port->intx_irq =3D irq_create_mapping(port->cpm_domain,
> > +					    XILINX_CPM_PCIE_INTR_INTX);
> > +	if (WARN_ON(port->intx_irq <=3D 0))
> > +		return -ENXIO;
> > +
> > +	/* Plug the INTx chained handler */
> > +	irq_set_chained_handler_and_data(port->intx_irq,
> > +					 xilinx_cpm_pcie_intx_flow, port);
