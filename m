Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E21578AF6F
	for <lists+linux-pci@lfdr.de>; Mon, 28 Aug 2023 14:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjH1MC2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Aug 2023 08:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjH1MCB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2023 08:02:01 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71F8128;
        Mon, 28 Aug 2023 05:01:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoeUU9JkfV0pbnd2E2ZR5JwLe2dKE6Htt7qKXdW1EJ62aoPEAPhfkniHOif06r11z/3LWRyz9eByVbGJx4WekOvWFSodmN3Fl82v4UsjaB03N46lkUOCFJ6rJWdb+I0rAvFPGUYLrWTufftptRHIouD21Y5CDREIH6T+wCwcDJrYSdf2aDTeCUU+iMc8LKDLYyiFO7uGJGfaTrn2ZSXeUzuKfwWdAyET3XdHIkTTD+PktoK3oZ1NzEFxasfGPBItas75O0KvvcmlnfEB7zZf2HzMj2G6RTQhxOI516V4okBM3trqMXMMF5i7Zr/JF9+miw4FGSr5FUde7CMMNUKKEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WngzMr+yxbS0y/fhosPucSfRvitMtzi3E0U0AXdSgo=;
 b=PkGpzt32XNGp896uKxpNYvS5Ec/KIVLdOTIVYOw7XEte0SsxN4jhwkXHCDD4ZRU+1/b0/fZk/E9Uvu/eV9/BohebCYPc183hAd2Jb3cMw4B+33HzMMJ7LgsoInmBZvqRxHz+XU+NnLJQJaSSFDiGLwgzp7b2I5qB8muShS7kacrpPQe/+eROXpXD/0hYgzZCIZaHurm/IoUMtbMFm2KxpFKg94HlNEZHwR9iWC0kvXD3vvuwW/XtAMnB9ABi9ire2KpTwDi7Yxe4rHA/lxvTkMZaT9/Xz1l5E612WXNpt9ZruCQOACnS3s9QV5LWH1cblnaF0Vgg3uSvYvDs6f6TcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WngzMr+yxbS0y/fhosPucSfRvitMtzi3E0U0AXdSgo=;
 b=sUgxEVC4NLcRuDy1smMqLWsqhhUEvky+pmgh0xR8+mYL2S5tywzF/K58XnVpj8iTe0bkVCSHJyFjKW8BiZXnBIvHeDHiLHe+ZCR3krxRrXVdZY8O2PQ6UiNhAOTBSb5ST29s0uGr0YYcnfhwV7IMuytZwxmfH1vn36QoZNjburc=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by IA0PR12MB8645.namprd12.prod.outlook.com (2603:10b6:208:48f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Mon, 28 Aug
 2023 12:01:52 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605%6]) with mapi id 15.20.6699.027; Mon, 28 Aug 2023
 12:01:52 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v6 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Thread-Topic: [PATCH v6 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port
 driver
Thread-Index: AQHZ0bd0UZnWQ2UfsUKGgBlWnmvLwK/1NJwAgAo9UBCAABo3oA==
Date:   Mon, 28 Aug 2023 12:01:52 +0000
Message-ID: <SN7PR12MB7201459AEFB6DFF600E753928BE0A@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20230818093507.24435-4-thippeswamy.havalige@amd.com>
 <20230821201400.GA367570@bhelgaas>
 <SN7PR12MB72019898876F049A932209038BE0A@SN7PR12MB7201.namprd12.prod.outlook.com>
In-Reply-To: <SN7PR12MB72019898876F049A932209038BE0A@SN7PR12MB7201.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|IA0PR12MB8645:EE_
x-ms-office365-filtering-correlation-id: 2079f6a6-aaf0-4fa8-fd00-08dba7be914b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D/M2ZZZUac7D67EVceZGGJAjmLQLJ9d9Tw/BxtvjYS188CQKIYHZuj//FVNzoEL0m1oQH/N1rz3WIW6JaB84iy7YuWCSqyYGhvd3UmiwaRgSKWv/Q/cCG0mhYPPigUgmfU4SyQcCNHh1ZtWmP8bzxUpJ4HLQ+ZMh05ygojR7V3e7G8NYHgSl+X3JqBRzKmCn1s7nlEOZ6A7c8nCgFqMhan/N/QRTS1JbYJ+rasWeWrd9u19DEYfGXYKkqZT6yNXoSErC5+pH/w7ZGE4as+UhT7/WipTUysxZ02LTUTwaLaNp1HZlUqzjZtmQ7W4KiCkksSUXqV9hf5mypNCkpfVrfs+IbQOy28Na+Iv15r4rOkxxiLfcudl26ycYlnWS7wH8/hOCixT+TzuzYkG9rcQ+CwnVbybsI8PynWPyDCU3j6CXS/Os7LbeS/qGKOCtCzHCy5FoVxeLKERJCF2jRwELgxRuRAmgXs2TAD/l/axWce9KewDHUEC4Z+CF37oBSVDlpI3bI87S7Oc8SG8V7hYB3VbQPnA+/GssvATqFPyJaRK2/uEFP/45wSZDgjhSyaayTTQkzJfwkADIoYM6uFRXg2M8kdrj9zUZVCRgKfreDT6+xWsLJ70SHB0kwB5/tsH5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199024)(1800799009)(186009)(7696005)(6506007)(71200400001)(9686003)(33656002)(86362001)(38100700002)(38070700005)(122000001)(55016003)(2906002)(26005)(83380400001)(2940100002)(53546011)(478600001)(76116006)(52536014)(66476007)(66556008)(66946007)(41300700001)(8676002)(4326008)(8936002)(5660300002)(64756008)(7416002)(66446008)(54906003)(6916009)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JkMYUWsbhG0Z2bqanmUJb5ZQVrNDhc0Puu+W0QNpSNepmPDfH4HULjCm4vZk?=
 =?us-ascii?Q?PM1j0NkwtVRBvjKaUmHLlcCFLNspmsbhmTGVUJDry4aES84+LMqNMxZqehRD?=
 =?us-ascii?Q?2Xxq0x9bBrznyX31xUYjjzvCVUArP0XAGi0TGcCuiAm3AePpAHfwk8yYuN0S?=
 =?us-ascii?Q?+m03kBZvHJcyRu9cc6BOmAzYsHEOrlyn978rCzjFd2Sr+Ek4DfQCm5Gb0K6l?=
 =?us-ascii?Q?WZL7tkNZob3A9gISmZVl7TyztrAgnUsjZtHJuxSkpVPPyfs1h7Kycckl2exE?=
 =?us-ascii?Q?SDhDcDtPsOx+h4L2IJPZ9ExwxllpwJ9cSfDe6YZLkhcDZG+vR+9Ng3m+s73T?=
 =?us-ascii?Q?22+bp7/DHRaaNPQGCAqJH1H8q9NwRSkgyPH7vgjb4AvlADBInc1yV9UGZhEB?=
 =?us-ascii?Q?ur6MbobqqwaAzL71MiPcQhfpa4XIhJdHWUJ4io7bptAnSJZNDLUAqLuspYxE?=
 =?us-ascii?Q?BgwkyAZbzlYn0sGlZ8jiJlYuhW8GgTqpxfrqeO5Kb8qEH7eX8eO4kXx9nnH3?=
 =?us-ascii?Q?wOXAP6Ny2hj99qPY+gnTlQR7YARD2Inrgymt0o0OryXtuIMhFPPbLKMcphIs?=
 =?us-ascii?Q?rhLomCG2ZaTtHzmBivtWQcbjaqQynFvFxSTXmHaAQlagBH4c/QuwrUjEeK4M?=
 =?us-ascii?Q?BuHvHy4lKQd7A6H0jDxkUJW5YMF32enUJIuk0CWEzK5+v36jFjsqCNbWWjoV?=
 =?us-ascii?Q?9TXkqRbSY9AWvCz/f6UyAmI6YCd28PFjTZ2N2i/gi1QJnERmbUdEOOuTZ+e3?=
 =?us-ascii?Q?pjGYdZLovbCu32XfFqAImLpRp2Cis4m+CzQHfnypq6mmmB7XOcrMop30Ln79?=
 =?us-ascii?Q?PCObqqbsQSHnglMJ+Yx0f6Q6+T6G78nujKEtGP53aM5N9BMGYmdiZ8G326/c?=
 =?us-ascii?Q?3BSe2moDHCbDyzHJEeus3vD5GRpXg06dt3Dk8DkvAUbmwC4bydEw9f5pwHyO?=
 =?us-ascii?Q?cnzeG4Grjk3n8QYyIdwpxJFiLglzBWFhHlXy7nTqu2owtZfiZ8vutTTW1/pg?=
 =?us-ascii?Q?UDddGiPO8kang7Ojg7GlfqcXiepSSPEHZ1kVATx4d2XjaeadYYhgsfAptZ4g?=
 =?us-ascii?Q?5bySrQmt+X+rVRHZHEt8MXJKKt62pVvxgaHulnX5dtkn5Zvch3vTIxkBLD9f?=
 =?us-ascii?Q?kW3QiBewEmkFv2zMcp6Iv1R+sy/JpXSeqw2D/HVP+JdmpO/R34DFYS+csh8f?=
 =?us-ascii?Q?ia3hQg90XUTP/lmtXbx5l71raHgaGTlQIfW154T9066unTzYNfqxBAO1Ptnx?=
 =?us-ascii?Q?3IEl35ykLahQQxUE8HO3RvjVT6qOLiknv7r2TSBWOzmvva3sSdeUGtpnPEMo?=
 =?us-ascii?Q?g0JsRkAL+YnAJg9qHjr6RXIJP5IxtQ5X+0+AqPuCStjcmhlVPhEayuNJEYxg?=
 =?us-ascii?Q?fdR2SB8RG4hRJ/dceZS6npNkJQ3a5F39CHgP4/gRANDhxee8gqHj2LpIW2PK?=
 =?us-ascii?Q?31kOZVWgmXsk3eK5yD6g+QPL4bPBZE+FHjfpzX8myV0Q9ymwL1Fgt8pYrKi5?=
 =?us-ascii?Q?69fD2y8lWWw3bwvv03GvW9dLWncS+ukKy8mDo8uI1sffDTj0ykeXBnK5HYQd?=
 =?us-ascii?Q?0GC6iJhFBqCwtIWoRRI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2079f6a6-aaf0-4fa8-fd00-08dba7be914b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 12:01:52.5826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YyBc0pz/Smsc/Ac4v4CpKIXe0f9cUVdeEYE9ZJVtkjcc9g0OJI2OzAWYcwWOFU6hZU5h87wfsWVluiGu3Zmveg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8645
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

> -----Original Message-----
> From: Havalige, Thippeswamy
> Sent: Monday, August 28, 2023 2:39 PM
> To: Bjorn Helgaas <helgaas@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; l=
inux-
> pci@vger.kernel.org; devicetree@vger.kernel.org; bhelgaas@google.com;
> lpieralisi@kernel.org; robh@kernel.org; kw@linux.com; Simek, Michal
> <michal.simek@amd.com>; krzysztof.kozlowski+dt@linaro.org; Gogada,
> Bharat Kumar <bharat.kumar.gogada@amd.com>
> Subject: RE: [PATCH v6 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port d=
river
>=20
> Hi Bjorn,
>=20
> Thanks, ll take all your comments and update them in next patch.
>=20
> Regards,
> Thippeswamy H
>=20
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Tuesday, August 22, 2023 1:44 AM
> > To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> > Cc: linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; linux- pci@vger.kernel.org;
> > devicetree@vger.kernel.org; bhelgaas@google.com;
> > lpieralisi@kernel.org; robh@kernel.org; kw@linux.com; Simek, Michal
> > <michal.simek@amd.com>; krzysztof.kozlowski+dt@linaro.org; Gogada,
> > Bharat Kumar <bharat.kumar.gogada@amd.com>
> > Subject: Re: [PATCH v6 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root
> > Port driver
> >
> > On Fri, Aug 18, 2023 at 03:05:07PM +0530, Thippeswamy Havalige wrote:
> > > Add support for Xilinx XDMA Soft IP core as Root Port.
> > >
> > > The Zynq UltraScale+ MPSoCs devices support XDMA soft IP module in
> > > programmable logic.
> > >
> > > The integrated XDMA soft IP block has integrated bridge function
> > > that can act as PCIe Root Port.
> > >
> > > Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> > > ---
> > > changes in v6:
> > > - Replaced chained irq's with regular interrupts.
> >
> > Thanks a million for working this out!
> >
> > Trivial comments below, wait a couple days before reposting in case
> > there are other comments.
> >
> > > +static inline bool xilinx_pl_dma_pcie_link_up(struct pl_dma_pcie
> > > +*port) {
> > > +	return (pcie_read(port, XILINX_PCIE_DMA_REG_PSCR) &
> > > +		XILINX_PCIE_DMA_REG_PSCR_LNKUP) ? 1 : 0;
> >
> > This function returns bool, so I think true/false would be more
> > appropriate than 1/0.
> >
> > > +static bool xilinx_pl_dma_pcie_valid_device(struct pci_bus *bus,
> > > +					    unsigned int devfn)
> > > +{
> > > +	struct pl_dma_pcie *port =3D bus->sysdata;
> > > +
> > > +	/* Check if link is up when trying to access downstream ports */
> > > +	if (!pci_is_root_bus(bus)) {
> > > +		/*
> > > +		 * Checking whether link is up here is a last line of defence,
> > > +		 * if the link goes down after we check for link-up, we have a
> > > +		 * problem: if a PIO request is initiated while link-down, the
> > > +		 * whole controller hangs, and even after link comes up again,
> > > +		 * previous PIO requests won't work, and a reset of the whole
> > > +		 * PCIe controller is needed. Henceforth we need link-up
> > check
> > > +		 * here to avoid sending PIO request when link is down. This
> > > +		 * check is racy by definition and does not make controller
> > hang
> > > +		 * if the link goes down after this check is performed.
> >
> > This comment doesn't make sense to me.  "If PIO request initiated
> > while link- down, controller hangs ... This check is racy and does not
> > make controller hang if link goes down."  Which is it?
- Here checking link up treats device as invalid.

Please find comment that I ll update in next patch and=20
Please letme know if any changes are needed.

  /*
                 * Checking whether the link is up. Here is the last line o=
f
                 * defence. If the link goes down after we check for link-u=
p,
                 * we have a problem. If a PIO request is initiated while l=
ink
                 * is down, the whole controller hangs. Even after link com=
es up
                 * again, previous PIO requests won't work, and a reset of =
the
                 * whole PCIe controller is needed. Henceforth we need link=
-up
                 * check here to treat device as invalid and avoid sending =
PIO
                 * request when link is down and this check is inherently r=
acy
                 * by definition.
*/
> >
> > My *guess* is that this check narrows the window but doesn't close it,
> > so if
> > xilinx_pl_dma_pcie_link_up() finds the link up, but the link goes down
> > before
> > pci_generic_config_read() initiates the PIO request, the controller
> > hangs, and a reset is required.
> >
> > > +		 */
> > > +		if (!xilinx_pl_dma_pcie_link_up(port))
> > > +			return false;
> > > +	} else if (devfn > 0)
> > > +		/* Only one device down on each root port */
> > > +		return false;
> > > +
> > > +	return true;
> > > +}
> >
> > > +/* INTx error interrupts are Xilinx controller specific interrupt,
> > > +used to
> > > + * notify user about error's such as cfg timeout, slave unsupported
> > > +requests,
> >
> > s/error's/errors/
> >
> > > + * fatal and non fatal error etc.
> >
> > > +		err =3D devm_request_irq(dev, irq,
> > xilinx_pl_dma_pcie_intr_handler,
> > > +				       IRQF_SHARED | IRQF_NO_THREAD,
> > intr_cause[i].sym, port);
> >
> > Rewrap to fit in 80 columns.
> >
> > > +	/* Needed for MSI DECODE MODE */
> > > +	pcie_write(port, XILINX_PCIE_DMA_IDR_ALL_MASK,
> > XILINX_PCIE_DMA_REG_MSI_LOW_MASK);
> > > +	pcie_write(port, XILINX_PCIE_DMA_IDR_ALL_MASK,
> > > +XILINX_PCIE_DMA_REG_MSI_HI_MASK);
> >
> > Rewrap.
> >
> > Bjorn
