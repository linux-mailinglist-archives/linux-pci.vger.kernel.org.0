Return-Path: <linux-pci+bounces-1292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 351A981C8FE
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 12:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A311C240F0
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 11:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1541A15AD7;
	Fri, 22 Dec 2023 11:19:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D51217745;
	Fri, 22 Dec 2023 11:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 2B40024E2E2;
	Fri, 22 Dec 2023 19:18:50 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 22 Dec
 2023 19:18:49 +0800
Received: from [192.168.125.85] (113.72.145.47) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 22 Dec
 2023 19:18:48 +0800
Message-ID: <025408dd-cc00-4744-8a41-cbd18209ed8b@starfivetech.com>
Date: Fri, 22 Dec 2023 19:18:48 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 15/21] PCI: microchip: Add event irqchip field to host
 port and add PLDA irqchip
Content-Language: en-US
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: Conor Dooley <conor@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>, Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Daire McNamara <daire.mcnamara@microchip.com>, "Emil
 Renner Berthing" <emil.renner.berthing@canonical.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	"Palmer Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	"Philipp Zabel" <p.zabel@pengutronix.de>, Mason Huo
	<mason.huo@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
References: <20231214072839.2367-1-minda.chen@starfivetech.com>
 <20231214072839.2367-16-minda.chen@starfivetech.com>
 <8c417157-8884-4e91-8912-0344e71f82c2@starfivetech.com>
 <ZYRaqYTcxWJGwWG8@lpieralisi>
From: Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <ZYRaqYTcxWJGwWG8@lpieralisi>
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: EXCAS063.cuchost.com (172.16.6.23) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable



On 2023/12/21 23:32, Lorenzo Pieralisi wrote:
> On Thu, Dec 21, 2023 at 06:56:22PM +0800, Minda Chen wrote:
>>=20
>>=20
>> On 2023/12/14 15:28, Minda Chen wrote:
>> > PolarFire PCIE event IRQs includes PLDA local interrupts and PolarFi=
re
>> > their own IRQs. PolarFire PCIe event irq_chip ops using an event_des=
c to
>> > unify different IRQ register addresses. On PLDA sides, PLDA irqchip =
codes
>> > only require to set PLDA local interrupt register. So the PLDA irqch=
ip ops
>> > codes can not be extracted from PolarFire codes.
>> >=20
>> > To support PLDA its own event IRQ process, implements PLDA irqchip o=
ps and
>> > add event irqchip field to struct pcie_plda_rp.
>> >=20
>> > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> > ---
>> >  .../pci/controller/plda/pcie-microchip-host.c | 65 ++++++++++++++++=
++-
>> >  drivers/pci/controller/plda/pcie-plda.h       |  3 +
>> >  2 files changed, 67 insertions(+), 1 deletion(-)
>> >=20
>> Hi Conor
>>    Could you take time to review this patch?  For I using event irq ch=
ip instead of event ops and the whole patch have been changed.  I think i=
t's better=20
>>    And I added the implementation of PLDA event irqchip  and make it e=
asier to claim the necessity of the modification.
>>    If you approve this, I will add back the review tag. Thanks
>>=20
>> Hi Lorenzo
>>    Have you reviewed this patch=EF=BC=9F Does the commit message and t=
he codes are can be approved =EF=BC=9FThanks
>>=20
>=20
> Please wrap the lines at 75 columns in length.
>=20
OK
> I have not reviewed but I am still struggling to understand the
> commit log, I apologise, I can try to review the series and figure
> out what the patch is doing but I would appreciate if commits logs
> could be made easier to parse.
>=20
> Thanks,
> Lorenzo
>=20

The commit message it is not good.

I draw a graph about the PCIe global event interrupt domain
(related to patch 10- 16).
Actually all these interrupts patches are for extracting the common=20
PLDA codes to pcie-plda-host.c and do not change microchip's codes logic.
 =20
            +----------------------------------------------------------+
            |    microchip  Global event interrupt domain              |
            +-----------------------------------+-----------+----------+
            |                                   | microchip | PLDA     |
            |                                   | event num |(StarFive)|
            |                                   |           |event num |
            +-----------------------------------+-----------+----------+
            |                                   | 0         |          |
            |                                   |           |          |
(mc pcie    |microchip platform event interrupt |           |          |
int line)   |                                   |           |          |
------------|                                   |           |          |
            |                                   |10         |          |
            +-----------------------------------+-----------+----------+
            | PLDA host DMA interrupt           |11         |          |
            | (int number is not fixed, defined |           |          |
            |  by vendor)                       |14         |          |
         +--+-----------------------------------+---------- +----------+-=
+
         |  |  PLDA event interrupt             |15         |0         | =
|
         |  |  (int number is fixed)            |           |          | =
|
---------|--|                                   |           |          | =
|
(Starfive|  |                                   |           |          | =
|
pcie int |  |   +------------------+            |           |          | =
|
line)    |  |   |INTx event domain |            |           |          | =
|
         |  |   +------------------+            |           |          | =
|
         |  |                                   |           |          | =
|
         |  |   +------------------+            |           |          | =
|
         |  |   |MSI event domain  |            |           |          | =
|
         |  |   +------------------+            |           |          | =
|
         |  |                                   |27         |12        | =
|
         |  +---------------------------------+-+-----------+----------+ =
|
         | extract PLDA event part to common PLDA file.                  =
|
         +---------------------------------------------------------------=
+


>> > diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/dri=
vers/pci/controller/plda/pcie-microchip-host.c
>> > index fd0d92c3d03f..ff40c1622173 100644
>> > --- a/drivers/pci/controller/plda/pcie-microchip-host.c
>> > +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
>> > @@ -771,6 +771,63 @@ static struct irq_chip mc_event_irq_chip =3D {
>> >  	.irq_unmask =3D mc_unmask_event_irq,
>> >  };
>> > > +static u32 plda_hwirq_to_mask(int hwirq)
>> > +{
>> > +	u32 mask;
>> > +
>> > +	if (hwirq < EVENT_PM_MSI_INT_INTX)
>> > +		mask =3D BIT(hwirq + A_ATR_EVT_POST_ERR_SHIFT);
>> > +	else if (hwirq =3D=3D EVENT_PM_MSI_INT_INTX)
>> > +		mask =3D PM_MSI_INT_INTX_MASK;
>> > +	else
>> > +		mask =3D BIT(hwirq + PM_MSI_TO_MASK_OFFSET);
>> > +
>> > +	return mask;
>> > +}
>> > +
>> > +static void plda_ack_event_irq(struct irq_data *data)
>> > +{
>> > +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
>> > +
>> > +	writel_relaxed(plda_hwirq_to_mask(data->hwirq),
>> > +		       port->bridge_addr + ISTATUS_LOCAL);
>> > +}
>> > +
>> > +static void plda_mask_event_irq(struct irq_data *data)
>> > +{
>> > +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
>> > +	u32 mask, val;
>> > +
>> > +	mask =3D plda_hwirq_to_mask(data->hwirq);
>> > +
>> > +	raw_spin_lock(&port->lock);
>> > +	val =3D readl_relaxed(port->bridge_addr + IMASK_LOCAL);
>> > +	val &=3D ~mask;
>> > +	writel_relaxed(val, port->bridge_addr + IMASK_LOCAL);
>> > +	raw_spin_unlock(&port->lock);
>> > +}
>> > +
>> > +static void plda_unmask_event_irq(struct irq_data *data)
>> > +{
>> > +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
>> > +	u32 mask, val;
>> > +
>> > +	mask =3D plda_hwirq_to_mask(data->hwirq);
>> > +
>> > +	raw_spin_lock(&port->lock);
>> > +	val =3D readl_relaxed(port->bridge_addr + IMASK_LOCAL);
>> > +	val |=3D mask;
>> > +	writel_relaxed(val, port->bridge_addr + IMASK_LOCAL);
>> > +	raw_spin_unlock(&port->lock);
>> > +}
>> > +
>> > +static struct irq_chip plda_event_irq_chip =3D {
>> > +	.name =3D "PLDA PCIe EVENT",
>> > +	.irq_ack =3D plda_ack_event_irq,
>> > +	.irq_mask =3D plda_mask_event_irq,
>> > +	.irq_unmask =3D plda_unmask_event_irq,
>> > +};
>> > +
>> >  static const struct plda_event_ops plda_event_ops =3D {
>> >  	.get_events =3D plda_get_events,
>> >  };
>> > @@ -778,7 +835,9 @@ static const struct plda_event_ops plda_event_op=
s =3D {
>> >  static int plda_pcie_event_map(struct irq_domain *domain, unsigned =
int irq,
>> >  			       irq_hw_number_t hwirq)
>> >  {
>> > -	irq_set_chip_and_handler(irq, &mc_event_irq_chip, handle_level_irq=
);
>> > +	struct plda_pcie_rp *port =3D (void *)domain->host_data;
>> > +
>> > +	irq_set_chip_and_handler(irq, port->event_irq_chip, handle_level_i=
rq);
>> >  	irq_set_chip_data(irq, domain->host_data);
>> > =20
>> >  	return 0;
>> > @@ -963,6 +1022,9 @@ static int plda_init_interrupts(struct platform=
_device *pdev,
>> >  	if (!port->event_ops)
>> >  		port->event_ops =3D &plda_event_ops;
>> > =20
>> > +	if (!port->event_irq_chip)
>> > +		port->event_irq_chip =3D &plda_event_irq_chip;
>> > +
>> >  	ret =3D plda_pcie_init_irq_domains(port);
>> >  	if (ret) {
>> >  		dev_err(dev, "failed creating IRQ domains\n");
>> > @@ -1040,6 +1102,7 @@ static int mc_platform_init(struct pci_config_=
window *cfg)
>> >  		return ret;
>> > =20
>> >  	port->plda.event_ops =3D &mc_event_ops;
>> > +	port->plda.event_irq_chip =3D &mc_event_irq_chip;
>> > =20
>> >  	/* Address translation is up; safe to enable interrupts */
>> >  	ret =3D plda_init_interrupts(pdev, &port->plda, &mc_event);
>> > diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/c=
ontroller/plda/pcie-plda.h
>> > index dd8bc2750bfc..24ac50c458dc 100644
>> > --- a/drivers/pci/controller/plda/pcie-plda.h
>> > +++ b/drivers/pci/controller/plda/pcie-plda.h
>> > @@ -128,6 +128,8 @@
>> >   * DMA end : reserved for vendor implement
>> >   */
>> > =20
>> > +#define PM_MSI_TO_MASK_OFFSET			19
>> > +
>> >  struct plda_pcie_rp;
>> > =20
>> >  struct plda_event_ops {
>> > @@ -150,6 +152,7 @@ struct plda_pcie_rp {
>> >  	raw_spinlock_t lock;
>> >  	struct plda_msi msi;
>> >  	const struct plda_event_ops *event_ops;
>> > +	const struct irq_chip *event_irq_chip;
>> >  	void __iomem *bridge_addr;
>> >  	int num_events;
>> >  };

