Return-Path: <linux-pci+bounces-1492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF4981F7A2
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 12:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB06C1F2423C
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 11:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160B96FBB;
	Thu, 28 Dec 2023 11:25:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ECC6FB6;
	Thu, 28 Dec 2023 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 6B4D924E257;
	Thu, 28 Dec 2023 19:25:32 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 28 Dec
 2023 19:25:32 +0800
Received: from [192.168.125.85] (183.27.97.107) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 28 Dec
 2023 19:25:31 +0800
Message-ID: <abefb75a-10b7-44f6-868c-6ab9591fd1e2@starfivetech.com>
Date: Thu, 28 Dec 2023 19:25:30 +0800
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
	Kevin Xie <kevin.xie@starfivetech.com>, <tglx@linutronix.de>
References: <20231214072839.2367-1-minda.chen@starfivetech.com>
 <20231214072839.2367-16-minda.chen@starfivetech.com>
 <8c417157-8884-4e91-8912-0344e71f82c2@starfivetech.com>
 <ZYRaqYTcxWJGwWG8@lpieralisi>
 <025408dd-cc00-4744-8a41-cbd18209ed8b@starfivetech.com>
 <ZYwb4UQVoLDZw7kf@lpieralisi>
From: Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <ZYwb4UQVoLDZw7kf@lpieralisi>
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable



On 2023/12/27 20:43, Lorenzo Pieralisi wrote:
> [+Thomas]
>=20
> On Fri, Dec 22, 2023 at 07:18:48PM +0800, Minda Chen wrote:
>>=20
>>=20
>> On 2023/12/21 23:32, Lorenzo Pieralisi wrote:
>> > On Thu, Dec 21, 2023 at 06:56:22PM +0800, Minda Chen wrote:
>> >>=20
>> >>=20
>> >> On 2023/12/14 15:28, Minda Chen wrote:
>> >> > PolarFire PCIE event IRQs includes PLDA local interrupts and Pola=
rFire
>> >> > their own IRQs. PolarFire PCIe event irq_chip ops using an event_=
desc to
>> >> > unify different IRQ register addresses. On PLDA sides, PLDA irqch=
ip codes
>> >> > only require to set PLDA local interrupt register. So the PLDA ir=
qchip ops
>> >> > codes can not be extracted from PolarFire codes.
>> >> >=20
>> >> > To support PLDA its own event IRQ process, implements PLDA irqchi=
p ops and
>> >> > add event irqchip field to struct pcie_plda_rp.
>> >> >=20
>> >> > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> >> > ---
>> >> >  .../pci/controller/plda/pcie-microchip-host.c | 65 +++++++++++++=
+++++-
>> >> >  drivers/pci/controller/plda/pcie-plda.h       |  3 +
>> >> >  2 files changed, 67 insertions(+), 1 deletion(-)
>> >> >=20
>> >> Hi Conor
>> >>    Could you take time to review this patch?  For I using event irq=
 chip instead of event ops and the whole patch have been changed.  I thin=
k it's better=20
>> >>    And I added the implementation of PLDA event irqchip  and make i=
t easier to claim the necessity of the modification.
>> >>    If you approve this, I will add back the review tag. Thanks
>> >>=20
>> >> Hi Lorenzo
>> >>    Have you reviewed this patch=EF=BC=9F Does the commit message an=
d the codes are can be approved =EF=BC=9FThanks
>> >>=20
>> >=20
>> > Please wrap the lines at 75 columns in length.
>> >=20
>> OK
>> > I have not reviewed but I am still struggling to understand the
>> > commit log, I apologise, I can try to review the series and figure
>> > out what the patch is doing but I would appreciate if commits logs
>> > could be made easier to parse.
>> >=20
>> > Thanks,
>> > Lorenzo
>> >=20
>>=20
>> The commit message it is not good.
>>=20
>> I draw a graph about the PCIe global event interrupt domain
>> (related to patch 10- 16).
>> Actually all these interrupts patches are for extracting the common=20
>> PLDA codes to pcie-plda-host.c and do not change microchip's codes log=
ic.
>=20
> s/codes/code (please apply this to the the full series)
>=20
> I will have a look at the code but I can't rewrite the commit log mysel=
f
> (it does not scale I am afraid), as it stands I don't understand it and
> that's a problem, I am sorry but that's important.
>=20
> I added Thomas (you should CC him for irqchip [only] changes) if he
> has time to review these irqchip changes to make sure they are proper.
>=20
> Thanks,
> Lorenzo
>=20
The interrupt irq_chip ops includes ack/mask/unmask. These ops are for=20
writing the correct register. Microchip Implement their PCIe interrupts
and require to write their registers. So  the irq_chip ops are different.

(List below are the microchip interrupt register base and status/mask=20
register offset. In pcie-microchip-host.c:130)
 =20
#define PCIE_EVENT(x) \
        .base =3D MC_PCIE_CTRL_ADDR, \
        .offset =3D PCIE_EVENT_INT, \
        .mask_offset =3D PCIE_EVENT_INT, \
        .mask_high =3D 1, \
        .mask =3D PCIE_EVENT_INT_ ## x ## _INT, \
        .enb_mask =3D PCIE_EVENT_INT_ENB_MASK

#define SEC_EVENT(x) \
        .base =3D MC_PCIE_CTRL_ADDR, \
        .offset =3D SEC_ERROR_INT, \
        .mask_offset =3D SEC_ERROR_INT_MASK, \
        .mask =3D SEC_ERROR_INT_ ## x ## _INT, \
        .mask_high =3D 1, \
        .enb_mask =3D 0

#define DED_EVENT(x) \
        .base =3D MC_PCIE_CTRL_ADDR, \
        .offset =3D DED_ERROR_INT, \
        .mask_offset =3D DED_ERROR_INT_MASK, \
        .mask_high =3D 1, \
        .mask =3D DED_ERROR_INT_ ## x ## _INT, \
        .enb_mask =3D 0


>>             +---------------------------------------------------------=
-+
>>             |    microchip  Global event interrupt domain             =
 |
>>             +-----------------------------------+-----------+---------=
-+
>>             |                                   | microchip | PLDA    =
 |
>>             |                                   | event num |(StarFive=
)|
>>             |                                   |           |event num=
 |
>>             +-----------------------------------+-----------+---------=
-+
>>             |                                   | 0         |         =
 |
>>             |                                   |           |         =
 |
>> (mc pcie    |microchip platform event interrupt |           |         =
 |
>> int line)   |                                   |           |         =
 |
>> ------------|                                   |           |         =
 |
>>             |                                   |10         |         =
 |
>>             +-----------------------------------+-----------+---------=
-+
>>             | PLDA host DMA interrupt           |11         |         =
 |
>>             | (int number is not fixed, defined |           |         =
 |
>>             |  by vendor)                       |14         |         =
 |
>>          +--+-----------------------------------+---------- +---------=
-+-+
>>          |  |  PLDA event interrupt             |15         |0        =
 | |
>>          |  |  (int number is fixed)            |           |         =
 | |
>> ---------|--|                                   |           |         =
 | |
>> (Starfive|  |                                   |           |         =
 | |
>> pcie int |  |   +------------------+            |           |         =
 | |
>> line)    |  |   |INTx event domain |            |           |         =
 | |
>>          |  |   +------------------+            |           |         =
 | |
>>          |  |                                   |           |         =
 | |
>>          |  |   +------------------+            |           |         =
 | |
>>          |  |   |MSI event domain  |            |           |         =
 | |
>>          |  |   +------------------+            |           |         =
 | |
>>          |  |                                   |27         |12       =
 | |
>>          |  +---------------------------------+-+-----------+---------=
-+ |
>>          | extract PLDA event part to common PLDA file.               =
   |
>>          +------------------------------------------------------------=
---+
>>=20
>>=20
>> >> > diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/=
drivers/pci/controller/plda/pcie-microchip-host.c
>> >> > index fd0d92c3d03f..ff40c1622173 100644
>> >> > --- a/drivers/pci/controller/plda/pcie-microchip-host.c
>> >> > +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
>> >> > @@ -771,6 +771,63 @@ static struct irq_chip mc_event_irq_chip =3D=
 {
>> >> >  	.irq_unmask =3D mc_unmask_event_irq,
>> >> >  };
>> >> > > +static u32 plda_hwirq_to_mask(int hwirq)
>> >> > +{
>> >> > +	u32 mask;
>> >> > +
>> >> > +	if (hwirq < EVENT_PM_MSI_INT_INTX)
>> >> > +		mask =3D BIT(hwirq + A_ATR_EVT_POST_ERR_SHIFT);
>> >> > +	else if (hwirq =3D=3D EVENT_PM_MSI_INT_INTX)
>> >> > +		mask =3D PM_MSI_INT_INTX_MASK;
>> >> > +	else
>> >> > +		mask =3D BIT(hwirq + PM_MSI_TO_MASK_OFFSET);
>> >> > +
>> >> > +	return mask;
>> >> > +}
>> >> > +
>> >> > +static void plda_ack_event_irq(struct irq_data *data)
>> >> > +{
>> >> > +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
>> >> > +
>> >> > +	writel_relaxed(plda_hwirq_to_mask(data->hwirq),
>> >> > +		       port->bridge_addr + ISTATUS_LOCAL);
>> >> > +}
>> >> > +
>> >> > +static void plda_mask_event_irq(struct irq_data *data)
>> >> > +{
>> >> > +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
>> >> > +	u32 mask, val;
>> >> > +
>> >> > +	mask =3D plda_hwirq_to_mask(data->hwirq);
>> >> > +
>> >> > +	raw_spin_lock(&port->lock);
>> >> > +	val =3D readl_relaxed(port->bridge_addr + IMASK_LOCAL);
>> >> > +	val &=3D ~mask;
>> >> > +	writel_relaxed(val, port->bridge_addr + IMASK_LOCAL);
>> >> > +	raw_spin_unlock(&port->lock);
>> >> > +}
>> >> > +
>> >> > +static void plda_unmask_event_irq(struct irq_data *data)
>> >> > +{
>> >> > +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
>> >> > +	u32 mask, val;
>> >> > +
>> >> > +	mask =3D plda_hwirq_to_mask(data->hwirq);
>> >> > +
>> >> > +	raw_spin_lock(&port->lock);
>> >> > +	val =3D readl_relaxed(port->bridge_addr + IMASK_LOCAL);
>> >> > +	val |=3D mask;
>> >> > +	writel_relaxed(val, port->bridge_addr + IMASK_LOCAL);
>> >> > +	raw_spin_unlock(&port->lock);
>> >> > +}
>> >> > +
>> >> > +static struct irq_chip plda_event_irq_chip =3D {
>> >> > +	.name =3D "PLDA PCIe EVENT",
>> >> > +	.irq_ack =3D plda_ack_event_irq,
>> >> > +	.irq_mask =3D plda_mask_event_irq,
>> >> > +	.irq_unmask =3D plda_unmask_event_irq,
>> >> > +};
>> >> > +
>> >> >  static const struct plda_event_ops plda_event_ops =3D {
>> >> >  	.get_events =3D plda_get_events,
>> >> >  };
>> >> > @@ -778,7 +835,9 @@ static const struct plda_event_ops plda_event=
_ops =3D {
>> >> >  static int plda_pcie_event_map(struct irq_domain *domain, unsign=
ed int irq,
>> >> >  			       irq_hw_number_t hwirq)
>> >> >  {
>> >> > -	irq_set_chip_and_handler(irq, &mc_event_irq_chip, handle_level_=
irq);
>> >> > +	struct plda_pcie_rp *port =3D (void *)domain->host_data;
>> >> > +
>> >> > +	irq_set_chip_and_handler(irq, port->event_irq_chip, handle_leve=
l_irq);
>> >> >  	irq_set_chip_data(irq, domain->host_data);
>> >> > =20
>> >> >  	return 0;
>> >> > @@ -963,6 +1022,9 @@ static int plda_init_interrupts(struct platf=
orm_device *pdev,
>> >> >  	if (!port->event_ops)
>> >> >  		port->event_ops =3D &plda_event_ops;
>> >> > =20
>> >> > +	if (!port->event_irq_chip)
>> >> > +		port->event_irq_chip =3D &plda_event_irq_chip;
>> >> > +
>> >> >  	ret =3D plda_pcie_init_irq_domains(port);
>> >> >  	if (ret) {
>> >> >  		dev_err(dev, "failed creating IRQ domains\n");
>> >> > @@ -1040,6 +1102,7 @@ static int mc_platform_init(struct pci_conf=
ig_window *cfg)
>> >> >  		return ret;
>> >> > =20
>> >> >  	port->plda.event_ops =3D &mc_event_ops;
>> >> > +	port->plda.event_irq_chip =3D &mc_event_irq_chip;
>> >> > =20
>> >> >  	/* Address translation is up; safe to enable interrupts */
>> >> >  	ret =3D plda_init_interrupts(pdev, &port->plda, &mc_event);
>> >> > diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pc=
i/controller/plda/pcie-plda.h
>> >> > index dd8bc2750bfc..24ac50c458dc 100644
>> >> > --- a/drivers/pci/controller/plda/pcie-plda.h
>> >> > +++ b/drivers/pci/controller/plda/pcie-plda.h
>> >> > @@ -128,6 +128,8 @@
>> >> >   * DMA end : reserved for vendor implement
>> >> >   */
>> >> > =20
>> >> > +#define PM_MSI_TO_MASK_OFFSET			19
>> >> > +
>> >> >  struct plda_pcie_rp;
>> >> > =20
>> >> >  struct plda_event_ops {
>> >> > @@ -150,6 +152,7 @@ struct plda_pcie_rp {
>> >> >  	raw_spinlock_t lock;
>> >> >  	struct plda_msi msi;
>> >> >  	const struct plda_event_ops *event_ops;
>> >> > +	const struct irq_chip *event_irq_chip;
>> >> >  	void __iomem *bridge_addr;
>> >> >  	int num_events;
>> >> >  };

