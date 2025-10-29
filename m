Return-Path: <linux-pci+bounces-39599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464E0C18725
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 07:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274AA3AD49D
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 06:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A77304BC8;
	Wed, 29 Oct 2025 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8sSS6go"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862A02E3B16
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 06:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761719076; cv=none; b=tUWDhQvA93nX62YGhEk8fSu5jmO+S/34i1w3T17sPqPpVFlGK9pdyRzSepk/asvDWWcs5LSQUiIq40Io90J17jb5jadWZe3wIN6eqecGAMgaCX1gTMroRep7VNebaY4UZ4wd+1Hw/hUmXkR/+TGp5RFfQTINEbfnkrUc8NmQYLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761719076; c=relaxed/simple;
	bh=saMIAuaUr2iahmAKw8KQxtdH1W9X5Rw7dMdMV2NiCQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wv5d51qxmagGsdmJdUukluxs1LnRpn2tIz7O2q+9VQPOWOCEe45ICqeri0+W7h8fxe6BRXry/AsF4IbZgnUFBwWA9o6DL9aKUjP/Qje7FX8tRS3RDZLvAsHpTe1WYO+CzAa1T8i7nyj5exSMCQLorq0iR1SX0Tq04PBKv7C6bPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8sSS6go; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b6d4e44c54aso1179049666b.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 23:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761719073; x=1762323873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=br982OtNpb98PdeBYhrJLVyrR7luvRLBafDbJi6d/xo=;
        b=I8sSS6goZ8FSycX/dcIr1kPt/Jw1JCbgXWTJBSuZcNogSkxWEmeTFTF9s9CnraKTIM
         orTHFF60zXJcSJzKbX/mMptBW0bOM2ysGfBkrVgIRn8SACzmaxf6xwyZoaW1AnLWzQ+o
         lakwHytDs/MzXrqhPC4ISTjep/sPlW328amRoyCVIado0lOskUCLY6nETcBZJ5jOsOlf
         TqqCCO/ZrATvF5qirRVyfGo8G6ABXRca/cnWGzD985lvXTwMtqJT1RKzixFbgioni/8y
         DSqZ35M1dxXwD4MXNoEx0AtvDmsz5Hu+829/gy7fElJ/wRBnPzg5S82IPbBfA5CNSlHL
         MuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761719073; x=1762323873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=br982OtNpb98PdeBYhrJLVyrR7luvRLBafDbJi6d/xo=;
        b=cgMNt3B+twuhYLS9hkaXZmW77thPdVMKdhhwLjy+A1P0xVVJ91YoeKnjfx186JBijT
         UYuogJ/8EJmKEg6pQRHcmHwfCXhQZM/+s88Q8Z/jdivtoGEtlk/LAAfcTmQiiYub0Ail
         S1CX3+cTYXC9T6d6RxDmUCXTn8DCP2/Kz5i1SY5OyMHjcqQb12PSrp9g9S3znW8EWejH
         TJypYL51xVGk/OCGhSost1lgMzSuVd59du2Ytny6d7/qOcVixo5CUJTUcJKxOR28I6kP
         BGKITQqWHUAnT3aoxlnc3DoSAMj++6o3DSSlzifS8T6SmTWuiIbK/JZYmUV5pCrTmWwf
         0VJg==
X-Forwarded-Encrypted: i=1; AJvYcCVIaU5jw1C4cSAtoDKX6oxj0WMIYtNWMbRZDVv+IhE1a1tQ3JohGfcueXXbJxU+4J5ulAWEnyr7baQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCqHixsNqCug62JIBh/pBA44Igac1Qz/gBS0NbexjgBWKdiHlL
	a6U0x01kaCNYpWxa5kbGx4qZP5imCupRstbyLFkksYrdAGgN3BeGgslvcznrxFsRVFZ1Mhdmat4
	EQCy9Ey0gCxyya+NDMSkCb0qYdpiWMm0=
X-Gm-Gg: ASbGncseJMO2OoowKvD82+Mgzximf0BQ0hxAG3QGElL0e3Skc8ms9opfoMjRjLe5MM5
	JgLbICDhL63rnc+hbVIClZ2knnvtfCgcks8GK86R3hboqUp/+4uEExSG6hrrD9KihEPZq3r36U8
	SFH/SQzjG44muZ6jAtDr7sRugVQLV/58o8INJ0nnMx5xm3ksoEgjHEF88XjEA3mDea3UW2xnlvL
	fAXw6q1PE4TjjCv5XIWoRippBsawg2Zr6b/kbeP3/85XKY1GlJ/Okp8Fks=
X-Google-Smtp-Source: AGHT+IHyfp+TmtXxz/OYls2Ipv0mWC+Ecb2/8nvbOahETXIdxr4t72mAdvqkoOAyhDhf4ehMvRZYQA65me6ij1Ptm9w=
X-Received: by 2002:a17:907:3c96:b0:b40:8954:a8bf with SMTP id
 a640c23a62f3a-b703d2ccb40mr176983466b.2.1761719072619; Tue, 28 Oct 2025
 23:24:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027145602.199154-1-linux.amoon@gmail.com>
 <20251027145602.199154-2-linux.amoon@gmail.com> <4fe0ccf9-8866-443a-8083-4a2af7035ee6@rock-chips.com>
 <CANAwSgRXcg4tO00SNu77EKdp6Ay6X7+_f-ZoHxgkv1himxdi0Q@mail.gmail.com> <3fcd5562-a367-41e9-8bff-51e5990145e2@rock-chips.com>
In-Reply-To: <3fcd5562-a367-41e9-8bff-51e5990145e2@rock-chips.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 29 Oct 2025 11:54:16 +0530
X-Gm-Features: AWmQ_bkHYm5QH-5Y_pmEaKy-mXRgDSlraZJjP-ybL_6P_hostigu_T7ZdM_pHso
Message-ID: <CANAwSgQ4HH=16Gn45XP3+jr+V+PrDhh8fC1Ek0jzrbMnhXo9fw@mail.gmail.com>
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

On Wed, 29 Oct 2025 at 05:58, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
>
> =E5=9C=A8 2025/10/28 =E6=98=9F=E6=9C=9F=E4=BA=8C 17:34, Anand Moon =E5=86=
=99=E9=81=93:
> > Hi Shawn,
> >
> > Thanks for your review comments.
> >
> > On Tue, 28 Oct 2025 at 05:56, Shawn Lin <shawn.lin@rock-chips.com> wrot=
e:
> >>
> >> =E5=9C=A8 2025/10/27 =E6=98=9F=E6=9C=9F=E4=B8=80 22:55, Anand Moon =E5=
=86=99=E9=81=93:
> >>> Introduce a .remove() callback to the Rockchip DesignWare PCIe
> >>> controller driver to ensure proper resource deinitialization during
> >>> device removal. This includes disabling clocks and deinitializing the
> >>> PCIe PHY.
> >>>
> >>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >>> ---
> >>>    drivers/pci/controller/dwc/pcie-dw-rockchip.c | 11 +++++++++++
> >>>    1 file changed, 11 insertions(+)
> >>>
> >>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/=
pci/controller/dwc/pcie-dw-rockchip.c
> >>> index 87dd2dd188b4..b878ae8e2b3e 100644
> >>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> >>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> >>> @@ -717,6 +717,16 @@ static int rockchip_pcie_probe(struct platform_d=
evice *pdev)
> >>>        return ret;
> >>>    }
> >>>
> >>> +static void rockchip_pcie_remove(struct platform_device *pdev)
> >>> +{
> >>> +     struct device *dev =3D &pdev->dev;
> >>> +     struct rockchip_pcie *rockchip =3D dev_get_drvdata(dev);
> >>> +
> >>> +     /* Perform other cleanups as necessary */
> >>> +     clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> >>> +     rockchip_pcie_phy_deinit(rockchip);
> >>> +}
> >>
> >> Thanks for the patch.
> >>
> >> Dou you need to call dw_pcie_host_deinit()?
> > I feel the rockchip_pcie_phy_deinit will power off the phy
> >> And I think you should also try to mask PCIE_CLIENT_INTR_MASK_MISC and
> >> remove the irq domain as well.
> >>
> >> if (rockchip->irq_domain) {
> >>          int virq, j;
> >>          for (j =3D 0; j < PCI_NUM_INTX; j++) {
> >>                  virq =3D irq_find_mapping(rockchip->irq_domain, j);
> >>                  if (virq > 0)
> >>                          irq_dispose_mapping(virq);
> >>           }
> >>          irq_set_chained_handler_and_data(rockchip->irq, NULL, NULL);
> >>          irq_domain_remove(rockchip->irq_domain);
> >> }
> >>
> > I have implemented resource cleanup in rockchip_pcie_remove,
> > which is invoked when the system is shutting down.
> > Your feedback on the updated code is welcome.
> >
> > static void rockchip_pcie_remove(struct platform_device *pdev)
> > {
> >          struct device *dev =3D &pdev->dev;
> >          struct rockchip_pcie *rockchip =3D dev_get_drvdata(dev);
> >          int irq;
> >
> >          irq =3D of_irq_get_byname(dev->of_node, "legacy");
> >          if (irq < 0)
> >                  return;
> >
> >          /* Perform other cleanups as necessary */
> >          /* clear up INTR staatus register */
> >          rockchip_pcie_writel_apb(rockchip, 0xffffffff,
> >                                   PCIE_CLIENT_INTR_STATUS_MISC);
> >          if (rockchip->irq_domain) {
> >                  int virq, j;
> >                  for (j =3D 0; j < PCI_NUM_INTX; j++) {
> >                          virq =3D irq_find_mapping(rockchip->irq_domain=
, j);
> >                          if (virq > 0)
> >                                  irq_dispose_mapping(virq);
> >                  }
> >                  irq_set_chained_handler_and_data(irq, NULL, NULL);
> >                  irq_domain_remove(rockchip->irq_domain);
> >          }
> >
> >          clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> >          /* poweroff the phy */
> >          rockchip_pcie_phy_deinit(rockchip);
> >          /* release the reset */
>
> release? Or "reset the controller"?
>
Ok, I will fix this.
> >          reset_control_assert(rockchip->rst);
> >          pm_runtime_put_sync(dev);
> >          pm_runtime_disable(dev);
> >          pm_runtime_no_callbacks(dev);
> > }
> >
> >> Another thin I noticed is should we call pm_runtime_* here for hope th=
at
> >> genpd could be powered donw once removed?
> >>
> > I could not find 'genpd' (power domain) used in the PCIe driver
> > If we have an example to use genpd I will update this.
>  > > I am also looking into adding NOIRQ_SYSTEM_SLEEP_PM_OPS
>
> That sounds good, you can pick up my patch[1] if you'd like to continue
> addressing the comments that I haven't had time to think more.
>
> [1] https://www.spinics.net/lists/linux-pci/msg171846.html
>
Ok, thanks. I will carefully study and address the comments.

Thanks
-Anand

