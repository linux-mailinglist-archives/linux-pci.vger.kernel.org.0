Return-Path: <linux-pci+bounces-39505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9EAC13DCA
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 10:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83071581195
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 09:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FBE21D3F8;
	Tue, 28 Oct 2025 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKOC9qVI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C873D2DEA68
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644083; cv=none; b=HhH+x87l3WZKPdJk1fot6eIBttUHe5rj9ImJq8rce+RWEL6T5fFOtCdCRM8pL9JLqhtkfMFE0gqEwPgVvdKLnr0aVPNvJEo5ceWrxsNuUmwG8IdMNUCEuG1e0L06FeP3ioy3DdRiihOl8JmjL4Iqf9IoWeC/rN3I9umvxrJj5sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644083; c=relaxed/simple;
	bh=UjusioGH/ELF8ZfnUIo9L+3qtvOzRcEwTb00EPFoV+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmFLaCdhxihh7/EKZKQZ9oSvsbBsZLPmD8VDCQKjlGGZThAplozKsIqW9yDIh1Ef3Ui2oP+7q6YUo6oPxIhHUBNHp6RjCIqgmufvkVbcdUygHEBpH3lTyxdshSdy6wErZ3pkWqb1N7sjQB94j18yacBDkNZ4N/X4colQaQk12nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKOC9qVI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so9795069a12.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761644080; x=1762248880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odW3qtXEWjV0YpOhuEaOM6Q/wDrQniW9fcSMR6G8lw0=;
        b=LKOC9qVIT3jDDcDXP86tfte8XYCjNp0UOtvVQNvOEk4E3eSSPuHrcztNIhpNYvcYHa
         H4BK6XroyjyzY9jUxrq5DVtiUQbILkcSOYI0gIySksqN9NuXvYdNoe///h6ppVusngS0
         y5CADfkTKca8QDuPh98KWKEYI/3WpsFc+baNt1WfqZbX7itG0qfZb8LpgPYOMssn8r0/
         Kqf0U9MP7T3hAasQG377qTdnSHSmS2p9dgupgQMHtmeO3bxiE23VszfHawzfv2L4o7D/
         eLGCylwmcEozvX43SJU34CKh7c5e8LsVjzXt3ApZIzNHqWtm8blMtZ/scQpqApLoLGio
         0rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761644080; x=1762248880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odW3qtXEWjV0YpOhuEaOM6Q/wDrQniW9fcSMR6G8lw0=;
        b=Qbbp46GCS3axz1aEVfx46brv9o/x3fJFltR6/uCMdW8djie7UOjhDKqHCZjcIFyjab
         x8vsI6Ap8X798LAXnYQs71MEZsq1IApwaS5/ED4iJU6KQwQkaOgGtzzTo4xg40mceKb4
         xgC6zkpQ1FK57cvN7WTQJJbA2gwr1Y2uTe6fB3eTde8nz++wI1CX3g/QNH2Z9DeS2F+N
         FTwjCrjGn1hqOhWng/oi/tmq442pETO3DvHj0cABvE/5EPExfrcJ87rMFiwgKfXBjcUv
         Cj8nL/HU75iMvAoYnw+BAGhnol5OM89aTBqah0jTf1fVP/GlGTXKLPtZBYMVPw+hbRFs
         SjJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRqu9Ok6eF2pttlQbBIcH/2DeNrt3x1VBIbG6rp75lBuDhDs7nks07h7dolu7V8OdTT5Mch2u5HVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm2V9Xs5/0bIe+DzWsICdBuPy8IFSfM4hcr+ZeA2FKqZz+PJ7T
	lG9r5E9Dwhgw9cz2KJyEG6grvJG/PlDgX0n8+corTUyhgEY6IX1GU1zLMIBDjJat+e6LBYWLgf7
	4N2ahiCW6ICcZXSJHttg9TiGMq4QO+LU=
X-Gm-Gg: ASbGnctZoIKmpyskv05Z7Nwk45oCjoxzayOhcBSoIMu3ZoIMks6NKNywSShx/WPzFJN
	BTs/ZRE0FDJS9XtQtvf/KvG7jCKJWNnIVdTMrK85GJpG6bnDAuK8hm5DZmjW+GE7U+9bSnSHD7c
	roEDOuYkSYeLGfiFu1HQNzi7FmTNitRNThwmgiEtrJLeebGQM6bgushfohLMtM4ObdO8em9CC8y
	hIEm40e8xyfVCFs1iK4DH+2eOl1JhCrwe7G+Kmq9ZXwnKg+lg8ziegd0+4=
X-Google-Smtp-Source: AGHT+IGsPCbe8r5dH8aant/YcEWw31jcAKY6dud6j8gJef9y0b9mBgF4kNxJ/GBJ3EJ/6/I5pBM64WHstQkAUKfPv+w=
X-Received: by 2002:a05:6402:84a:b0:63c:533f:4b18 with SMTP id
 4fb4d7f45d1cf-63ed8279e25mr2443085a12.36.1761644079781; Tue, 28 Oct 2025
 02:34:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027145602.199154-1-linux.amoon@gmail.com>
 <20251027145602.199154-2-linux.amoon@gmail.com> <4fe0ccf9-8866-443a-8083-4a2af7035ee6@rock-chips.com>
In-Reply-To: <4fe0ccf9-8866-443a-8083-4a2af7035ee6@rock-chips.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 28 Oct 2025 15:04:22 +0530
X-Gm-Features: AWmQ_bmPsHqocSX1aRGHrBmzWUPGfL89N89yzNkDBUrKAG5QnhtWURPNx9mXmf8
Message-ID: <CANAwSgRXcg4tO00SNu77EKdp6Ay6X7+_f-ZoHxgkv1himxdi0Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] PCI: dw-rockchip: Add remove callback for resource cleanup
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>, Hans Zhang <18255117159@163.com>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

Thanks for your review comments.

On Tue, 28 Oct 2025 at 05:56, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> =E5=9C=A8 2025/10/27 =E6=98=9F=E6=9C=9F=E4=B8=80 22:55, Anand Moon =E5=86=
=99=E9=81=93:
> > Introduce a .remove() callback to the Rockchip DesignWare PCIe
> > controller driver to ensure proper resource deinitialization during
> > device removal. This includes disabling clocks and deinitializing the
> > PCIe PHY.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pc=
i/controller/dwc/pcie-dw-rockchip.c
> > index 87dd2dd188b4..b878ae8e2b3e 100644
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > @@ -717,6 +717,16 @@ static int rockchip_pcie_probe(struct platform_dev=
ice *pdev)
> >       return ret;
> >   }
> >
> > +static void rockchip_pcie_remove(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct rockchip_pcie *rockchip =3D dev_get_drvdata(dev);
> > +
> > +     /* Perform other cleanups as necessary */
> > +     clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> > +     rockchip_pcie_phy_deinit(rockchip);
> > +}
>
> Thanks for the patch.
>
> Dou you need to call dw_pcie_host_deinit()?
I feel the rockchip_pcie_phy_deinit will power off the phy
> And I think you should also try to mask PCIE_CLIENT_INTR_MASK_MISC and
> remove the irq domain as well.
>
> if (rockchip->irq_domain) {
>         int virq, j;
>         for (j =3D 0; j < PCI_NUM_INTX; j++) {
>                 virq =3D irq_find_mapping(rockchip->irq_domain, j);
>                 if (virq > 0)
>                         irq_dispose_mapping(virq);
>          }
>         irq_set_chained_handler_and_data(rockchip->irq, NULL, NULL);
>         irq_domain_remove(rockchip->irq_domain);
> }
>
I have implemented resource cleanup in rockchip_pcie_remove,
which is invoked when the system is shutting down.
Your feedback on the updated code is welcome.

static void rockchip_pcie_remove(struct platform_device *pdev)
{
        struct device *dev =3D &pdev->dev;
        struct rockchip_pcie *rockchip =3D dev_get_drvdata(dev);
        int irq;

        irq =3D of_irq_get_byname(dev->of_node, "legacy");
        if (irq < 0)
                return;

        /* Perform other cleanups as necessary */
        /* clear up INTR staatus register */
        rockchip_pcie_writel_apb(rockchip, 0xffffffff,
                                 PCIE_CLIENT_INTR_STATUS_MISC);
        if (rockchip->irq_domain) {
                int virq, j;
                for (j =3D 0; j < PCI_NUM_INTX; j++) {
                        virq =3D irq_find_mapping(rockchip->irq_domain, j);
                        if (virq > 0)
                                irq_dispose_mapping(virq);
                }
                irq_set_chained_handler_and_data(irq, NULL, NULL);
                irq_domain_remove(rockchip->irq_domain);
        }

        clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
        /* poweroff the phy */
        rockchip_pcie_phy_deinit(rockchip);
        /* release the reset */
        reset_control_assert(rockchip->rst);
        pm_runtime_put_sync(dev);
        pm_runtime_disable(dev);
        pm_runtime_no_callbacks(dev);
}

> Another thin I noticed is should we call pm_runtime_* here for hope that
> genpd could be powered donw once removed?
>
I could not find 'genpd' (power domain) used in the PCIe driver
If we have an example to use genpd I will update this.

I am also looking into adding NOIRQ_SYSTEM_SLEEP_PM_OPS

Thanks
-Anand

