Return-Path: <linux-pci+bounces-11335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F2994830B
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 22:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF32281A49
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 20:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8DD16BE3A;
	Mon,  5 Aug 2024 20:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlhC0TfQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE27A16BE31;
	Mon,  5 Aug 2024 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722888859; cv=none; b=WTctSLKlzP60PDtmirFNgI1DfaW8Le7b4phtcN6NoFIosQQjdx9Vrxi/hoDN9XWH/UiRPFp/bLdSjiSmN3wwRMlIN1S1Y8VIJqJbYy4F+fCKXjxCLBTxabGgFYxjCl1PJFqiUw9eX7PTdp4ZGfv78Bhpp6y6GwIwxBfUTrxr3QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722888859; c=relaxed/simple;
	bh=s3QTtugUD5bNK6uisPOgFIGSY7xh8ze4loCcgfW9MT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+4Aa2iaxcWw6SFSSvtZ1sBWfuQhTCXK4gyGQJ/41YkN+gF1ohC/E574a2eoHmEmwefyXzTwnsyk5AlQA1ZvtRGpQfBVfQlRyk2Z4q/4bzzBi66jTyfEgIAHgOLkzgjUZY5XxUStBjoX9Rlrs4/zqYb54zTfcUpvwuf5Sr7Unos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlhC0TfQ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a728f74c23dso1404691366b.1;
        Mon, 05 Aug 2024 13:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722888856; x=1723493656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WviZuQsvNVo7JWzERxl8d3Y2S70JtnzKTZ1Bu4/KEY=;
        b=HlhC0TfQ/ZUemcIAcWOl/y4pAoLYJbjS3eHOM/LH9KCvhb5puFeUrKQg9ZiqAsta+i
         TIRb6MYSWhMTPxdgienGuGMxbIdlw4Ux/qYYGKpwAw3DgZdsWFR8kU698/9lYvZ9GIKa
         kaZK+s2sGDPnufx28yrGQU+URO64re7TDG0A/K4VdFKOAwWS4IEXMsBNQcGBcVlNG0Z1
         NFPWOeBWKCaQXS7e/tUMRJXSewvo7vK7m/B3I4+p2sT2b3D0SEOnxZN0dAOP4eYPrj3U
         iHtc9vVh/gJDxXenz4KPSp9UqmdvjbMO4Zr4V/+VHjyKI09DU8HXaDlv0JjQ8FEP3RV7
         XQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722888856; x=1723493656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WviZuQsvNVo7JWzERxl8d3Y2S70JtnzKTZ1Bu4/KEY=;
        b=MJOWz8WTM4eO8eH2a6JLxVAxaVRxsB1JXt3joq3wBUPVG7xrXvjPWDTiFJXh0nBK1k
         9VmX1HT+y/O1/dpCeiTv99l3xSamqB6RF6x5s4Rdeav1HrKXn+YQzPAhkpXSRGiN/Gtk
         +tQ0XFi4+GWzegcfyM9UUCYWJs9KTBtGcSDDGxfrWGZ/FW2G67gOzFOp97imCElJ25tT
         YTlVxVc3/Y4+/4lnOT3gXlQ0hD7HuXt1QANEgEqCQ3V7XFmAZp1pgoeAzfPK7vT4DaRJ
         7PKt2EYHuTo8y7yce99iJZVnBurSPDHtYyAyXDyq1sktcuuFV6YehEkG4J0f76214vRL
         VdJw==
X-Forwarded-Encrypted: i=1; AJvYcCU8NvQYC4M1uU+xPcjgMa2lWqw4baTJ55djbD8tJJ3lYC05OnhDiqoEfwLx24E6bJuYjTUwUT73wBZRa45lw6yQ7Igd9Pb15soayY/FxBoFrBJ3x789sqoEsUmcikOpdm2e9tuqjyKHYbPOfEbLpNii9gDzCUqOnYFv71x/0pCn9nVXPqc2N8vzjibvUJHxlAHn4eITeIxw6w6a4A==
X-Gm-Message-State: AOJu0YxKm3LV+hQMpIwL11g1XeVbOqIm0QDwKCWO3jTnYmNys0caFRB7
	UipB2+JRzEu5KvSTYRk3jM2yFqqLtnbpxAUXgVpjS0ou8tocUdST8JK337Qfsw/GTQDlfn6bh0n
	gpiy3+0jyNiZLHzzn3X90WnGERm0=
X-Google-Smtp-Source: AGHT+IG8L+hnxBlm6nuNrRGh8gTejr4GHsr9w05VOPVu0qqv3+yd4ladZ4MFFPo9eO+zcgGw0pzIuB6pVsbh080rWl4=
X-Received: by 2002:a17:906:794e:b0:a77:d85c:86fa with SMTP id
 a640c23a62f3a-a7dc4d8fe0emr983248366b.13.1722888855752; Mon, 05 Aug 2024
 13:14:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805101725.93947-1-herve.codina@bootlin.com> <20240805101725.93947-2-herve.codina@bootlin.com>
In-Reply-To: <20240805101725.93947-2-herve.codina@bootlin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 5 Aug 2024 22:13:38 +0200
Message-ID: <CAHp75VdtFET87R9DZbz27vEeyv4K5bn7mxDCnBVdpFVJ=j6qtg@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] misc: Add support for LAN966x PCI device
To: Herve Codina <herve.codina@bootlin.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@kernel.org>, Lee Jones <lee@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Derek Kiernan <derek.kiernan@amd.com>, 
	Dragan Cvetic <dragan.cvetic@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Andrew Lunn <andrew@lunn.ch>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 12:19=E2=80=AFPM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> Add a PCI driver that handles the LAN966x PCI device using a device-tree
> overlay. This overlay is applied to the PCI device DT node and allows to
> describe components that are present in the device.
>
> The memory from the device-tree is remapped to the BAR memory thanks to
> "ranges" properties computed at runtime by the PCI core during the PCI
> enumeration.
>
> The PCI device itself acts as an interrupt controller and is used as the
> parent of the internal LAN966x interrupt controller to route the
> interrupts to the assigned PCI INTx interrupt.

...

+ device.h

> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>

> +#include <linux/pci.h>

> +#include <linux/pci_ids.h>

AFAIU pci_ids..h is guaranteed to be included by pci.h, but having it
here explicitly doesn't make it worse, so up to you.

> +#include <linux/slab.h>

...

> +static irqreturn_t pci_dev_irq_handler(int irq, void *data)
> +{
> +       struct pci_dev_intr_ctrl *intr_ctrl =3D data;
> +       int ret;
> +
> +       ret =3D generic_handle_domain_irq(intr_ctrl->irq_domain, 0);
> +       return IRQ_RETVAL(!ret);

Hmm... I dunno if it was me who suggested IRQ_RETVAL() here, but it
usually makes sense for the cases where ret is not inverted.

Perhaps

  if (ret)
    return NONE;
  return HANDLED;

is slightly better in this case?

> +}

...

> +static struct pci_dev_intr_ctrl *pci_dev_create_intr_ctrl(struct pci_dev=
 *pdev)
> +{
> +       struct pci_dev_intr_ctrl *intr_ctrl;
> +       struct fwnode_handle *fwnode;
> +       int ret;

> +       if (!pdev->irq)
> +               return ERR_PTR(-EOPNOTSUPP);

Before even trying to get it via APIs? (see below as well)
Also, when is it possible to have 0 here?

> +       fwnode =3D dev_fwnode(&pdev->dev);
> +       if (!fwnode)
> +               return ERR_PTR(-ENODEV);
> +
> +       intr_ctrl =3D kmalloc(sizeof(*intr_ctrl), GFP_KERNEL);

Hmm... Why not use __free()?

> +       if (!intr_ctrl)
> +               return ERR_PTR(-ENOMEM);
> +
> +       intr_ctrl->pci_dev =3D pdev;
> +
> +       intr_ctrl->irq_domain =3D irq_domain_create_linear(fwnode, 1, &pc=
i_dev_irq_domain_ops,
> +                                                        intr_ctrl);
> +       if (!intr_ctrl->irq_domain) {
> +               pci_err(pdev, "Failed to create irqdomain\n");
> +               ret =3D -ENOMEM;
> +               goto err_free_intr_ctrl;
> +       }

> +       ret =3D pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_INTX);
> +       if (ret < 0) {
> +               pci_err(pdev, "Unable alloc irq vector (%d)\n", ret);
> +               goto err_remove_domain;
> +       }

I am wondering if you even need this in case you want solely INTx.

> +       intr_ctrl->irq =3D pci_irq_vector(pdev, 0);

Don't remember documentation by heart for this, but the implementation
suggests that it can be called without the above for retrieving INTx.

> +       ret =3D request_irq(intr_ctrl->irq, pci_dev_irq_handler, IRQF_SHA=
RED,
> +                         dev_name(&pdev->dev), intr_ctrl);

pci_name() ? (IIRC the macro name)

> +       if (ret) {
> +               pci_err(pdev, "Unable to request irq %d (%d)\n", intr_ctr=
l->irq, ret);
> +               goto err_free_irq_vector;
> +       }
> +
> +       return intr_ctrl;
> +
> +err_free_irq_vector:
> +       pci_free_irq_vectors(pdev);
> +err_remove_domain:
> +       irq_domain_remove(intr_ctrl->irq_domain);
> +err_free_intr_ctrl:
> +       kfree(intr_ctrl);
> +       return ERR_PTR(ret);
> +}

...

> +static void devm_pci_dev_remove_intr_ctrl(void *data)
> +{

> +       struct pci_dev_intr_ctrl *intr_ctrl =3D data;

It can be eliminated

static void devm_pci_...(void *intr_ctrl)

> +       pci_dev_remove_intr_ctrl(intr_ctrl);
> +}

...

> +static int lan966x_pci_load_overlay(struct lan966x_pci *data)
> +{
> +       u32 dtbo_size =3D __dtbo_lan966x_pci_end - __dtbo_lan966x_pci_beg=
in;
> +       void *dtbo_start =3D __dtbo_lan966x_pci_begin;
> +       int ret;
> +
> +       ret =3D of_overlay_fdt_apply(dtbo_start, dtbo_size, &data->ovcs_i=
d, dev_of_node(data->dev));
> +       if (ret)
> +               return ret;
> +
> +       return 0;

return of_overlay_fdt_apply() ?

> +}

...

> +static int lan966x_pci_probe(struct pci_dev *pdev, const struct pci_devi=
ce_id *id)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct lan966x_pci *data;
> +       int ret;
> +
> +       /*
> +        * On ACPI system, fwnode can point to the ACPI node.
> +        * This driver needs an of_node to be used as the device-tree ove=
rlay
> +        * target. This of_node should be set by the PCI core if it succe=
eds in
> +        * creating it (CONFIG_PCI_DYNAMIC_OF_NODES feature).
> +        * Check here for the validity of this of_node.
> +        */
> +       if (!dev_of_node(dev)) {

> +               dev_err(dev, "Missing of_node for device\n");
> +               return -EINVAL;

return dev_err_probe() ?

> +       }
> +
> +       /* Need to be done before devm_pci_dev_create_intr_ctrl.
> +        * It allocates an IRQ and so pdev->irq is updated.
> +        */
> +       ret =3D pcim_enable_device(pdev);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D devm_pci_dev_create_intr_ctrl(pdev);
> +       if (ret)
> +               return ret;
> +
> +       data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       pci_set_drvdata(pdev, data);
> +       data->dev =3D dev;
> +
> +       ret =3D lan966x_pci_load_overlay(data);
> +       if (ret)
> +               return ret;
> +
> +       pci_set_master(pdev);
> +
> +       ret =3D of_platform_default_populate(dev_of_node(dev), NULL, dev)=
;
> +       if (ret)
> +               goto err_unload_overlay;
> +
> +       return 0;
> +
> +err_unload_overlay:
> +       lan966x_pci_unload_overlay(data);
> +       return ret;
> +}

...

> +#include <dt-bindings/clock/microchip,lan966x.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/mfd/atmel-flexcom.h>
> +#include <dt-bindings/phy/phy-lan966x-serdes.h>

> +#include <dt-bindings/gpio/gpio.h>

Alphabetical order?

--=20
With Best Regards,
Andy Shevchenko

