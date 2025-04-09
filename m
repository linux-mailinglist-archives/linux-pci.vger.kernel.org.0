Return-Path: <linux-pci+bounces-25533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FE5A81D84
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 08:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201FB1B8829B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 06:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C222135CE;
	Wed,  9 Apr 2025 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vusY60yE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD97212D67
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2025 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744181726; cv=none; b=mw3DKAgu53JRGa3caLESPEV4tjz/vzxb0CfVG8L6urAfAhgm7urYi7KC9Ol+47HSywZGyRSlHNVliJinOhejeaVRaYSIg/3nukEe/1ENde50eTo5VcjOOB7ph66QPtjOngK3mdCTT3ttemkvQv2hrcAjH7vlNJE1l0V1YU9j4jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744181726; c=relaxed/simple;
	bh=QdVBI9jATxw7evkS6I10+tbNM0r/BgQjoVbuKYu53nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9dk2CHCjq4AGcsvrMqKS4zMpRcDNPGT4ln+5NpgylFC1CrHp8GoLC+3UTiVghS3JppaDMlxdhDgFbWNJSFfteeOVewCCOhj2qJGpuyIMeug+uvbs4dOkbmY43Fid5E5AGauYWfV4M00Rn3cnSNs+ZJesjXcDS5G3wOBUZQ6erM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vusY60yE; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af19b9f4c8cso4263785a12.2
        for <linux-pci@vger.kernel.org>; Tue, 08 Apr 2025 23:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744181723; x=1744786523; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BOZjLOAGYZcTUH3TOIZZnZSwMjEJaIzKoYbYDzfZTq8=;
        b=vusY60yEWq+zDVMG77LqShNfNUZaMFPMO1VNSZHH1ky1d2DTWutqJoOr/Q+cw4y79w
         1OQYckkK1vY/JmpqL4WUg9/EwQf9ElpZJNvJnkQi4B+G3agqX6Fa6vtFdq1JD05UoQ7+
         HS/jDUwKe2Gi/WQbZkKmmO0p62Abl8egmNtNip57vGkGK2bZ78MjTDCGSrfRyRSocIjr
         sLRTbxMcC9hWzG8DDMMw7HcIsZ0tCt+Rixugy7blb0S2z7IDPXj80YKtNdhlmXiEpp7W
         EcdMYACX7zxMt2StL00OfKDwenr15lDl6bnZ/bXIH6rBb4T5ZHyXSEHjSQghBAQX466a
         tyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744181723; x=1744786523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOZjLOAGYZcTUH3TOIZZnZSwMjEJaIzKoYbYDzfZTq8=;
        b=X7x4cGs+m74ZMdMQKDKE+tzEzLIRCvW1yRZ5GNKLQTnk8TtPMWqhepW6z1wVWei71q
         KYQq7Wf2c/85/WkzWTL7qhZKvkuEuQjtVEgMss8qAb1sRinqWQoVuE36s8w7/Dp9HcFl
         Gv/qXfiRO2Ek33muCtAI8nmebvndQ6EJhVDzdgYA+xCex2Abjz0GdzmmzXA8Yyk4sIMl
         CHjeikWzkp5lNtqPf4nSxdi4rRBsyvP43/G9pd5aiMFfZ0sCYHg3eblZnOf/jVxsUrfs
         Vb18lHP1PsafdmqMIu3EWBQNDCzGQoWz7HujB1S2eFwURPj4/Ehp94QHvaUilxWeIJ4Z
         jMCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrgUqp3DXfpslobFpR6nZuYZdoD/aU07DMR01+i58N+mL2zb04sGKVyK0lQSF8yPB0vkg80920UMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWMYJ0oUmZ0gS/Xrxk0B6iJ+tX72p8uhFTfmcjQIgkgnqY/0kS
	4QDRWHN2yNEs3Te0BIvxuoT0ZkDTZARCSmTn6hrXGFd85rjdjLlQjI/wBgOWlQ==
X-Gm-Gg: ASbGnctyhr1wpPpc2vQ21LzI2zCha+LUfrby1E2NV/Nno3wipbAcG1i3tgcEyNtmoXn
	Bhe4Tqpi+zsz6JDXzmPQvzGSeVBikKBPXxGdf/WBQG8WLxPvwkhAkwnvGmZ9oGMYUf2BD9YOL57
	Uv39JS9uN1wgXV75Q62neXDaN4FzuKw5pYWuj2dYwnWtGetodOF6co8+SkPevLAGcLWG6cqQh4O
	tBVycVrgzFwxUD+qpDSrIcKAcgX2HRQvANGrpOc56DD77vBGMcxhKVCJxJbhFSHwmtAG36FlZot
	2WnRSV5Gh6aRO5WLCBJqaqM7/LKmEO2MFsj4JTFTd7AGukxvQnGFetYUuUE23w==
X-Google-Smtp-Source: AGHT+IFEKpvJ/peYbL5UF/N3MPHp1NNbjrOs3QVXN8gAKbEYxPJH808F/Kuid1w2H5MEKJ7Cx9vuPA==
X-Received: by 2002:a05:6a20:438c:b0:1f5:769a:a4bf with SMTP id adf61e73a8af0-201592e0c38mr3268658637.36.1744181722822;
        Tue, 08 Apr 2025 23:55:22 -0700 (PDT)
Received: from thinkpad ([120.56.198.53])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a11d2654sm508981a12.35.2025.04.08.23.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 23:55:22 -0700 (PDT)
Date: Wed, 9 Apr 2025 12:25:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cassel@kernel.org" <cassel@kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>, 
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
Subject: Re: [PATCH v6 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST#
 signal
Message-ID: <kjfnox7hefk7ribdhkzj4kbkwyeg7lf62oep7duw6vfarmx5hl@eg5nzkbusm4n>
References: <20250326022811.3090688-1-sai.krishna.musham@amd.com>
 <20250326022811.3090688-3-sai.krishna.musham@amd.com>
 <cjrb3idrj3x7vo4fujl6nakj3foyu64gtxwovmxd4qvovvhwqq@26bpt5b4zjao>
 <DM4PR12MB6158EFFB5F245FAA5CB022A8CDA92@DM4PR12MB6158.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM4PR12MB6158EFFB5F245FAA5CB022A8CDA92@DM4PR12MB6158.namprd12.prod.outlook.com>

On Fri, Apr 04, 2025 at 06:59:23AM +0000, Musham, Sai Krishna wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Manivannan,
> 
> Thanks for the review.
> 
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: Thursday, March 27, 2025 10:56 PM
> > To: Musham, Sai Krishna <sai.krishna.musham@amd.com>
> > Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > krzk+dt@kernel.org; conor+dt@kernel.org; cassel@kernel.org; linux-
> > pci@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > Simek, Michal <michal.simek@amd.com>; Gogada, Bharat Kumar
> > <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
> > <thippeswamy.havalige@amd.com>
> > Subject: Re: [PATCH v6 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST#
> > signal
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > On Wed, Mar 26, 2025 at 07:58:11AM +0530, Sai Krishna Musham wrote:
> > > Add PCIe IP reset along with GPIO-based control for the PCIe Root
> > > Port PERST# signal. Synchronizing the PCIe IP reset with the PERST#
> > > signal's assertion and deassertion avoids Link Training failures.
> > >
> > > Adapt to use GPIO framework and make reset optional to maintain
> > > backward compatibility with existing DTBs.
> > >
> > > Add clear firewall after Link reset for CPM5NC.
> > >
> > > Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> > > ---
> > > Changes for v6:
> > > - Correct version check condition of CPM5NC_HOST.
> > >
> > > Changes for v5:
> > > - Handle probe defer for reset_gpio.
> > > - Resolve ABI break.
> > >
> > > Changes for v4:
> > > - Add PCIe PERST# support for CPM5NC.
> > > - Add PCIe IP reset along with PERST# to avoid Link Training Errors.
> > > - Remove PCIE_T_PVPERL_MS define and PCIE_T_RRS_READY_MS after
> > >   PERST# deassert.
> > > - Move PCIe PERST# assert and deassert logic to
> > >   xilinx_cpm_pcie_init_port() before cpm_pcie_link_up(), since
> > >   Interrupts enable and PCIe RP bridge enable should be done after
> > >   Link up.
> > > - Update commit message.
> > >
> > > Changes for v3:
> > > - Use PCIE_T_PVPERL_MS define.
> > >
> > > Changes for v2:
> > > - Make the request GPIO optional.
> > > - Correct the reset sequence as per PERST#
> > > - Update commit message
> > > ---
> > >  drivers/pci/controller/pcie-xilinx-cpm.c | 86 ++++++++++++++++++++++--
> > >  1 file changed, 82 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-
> > cpm.c
> > > index d0ab187d917f..b10c0752a94f 100644
> > > --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> > > +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> > > @@ -6,6 +6,8 @@
> > >   */
> > >
> > >  #include <linux/bitfield.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/gpio/consumer.h>
> > >  #include <linux/interrupt.h>
> > >  #include <linux/irq.h>
> > >  #include <linux/irqchip.h>
> > > @@ -21,6 +23,13 @@
> > >  #include "pcie-xilinx-common.h"
> > >
> > >  /* Register definitions */
> > > +#define XILINX_CPM_PCIE0_RST         0x00000308
> > > +#define XILINX_CPM5_PCIE0_RST                0x00000318
> > > +#define XILINX_CPM5_PCIE1_RST                0x0000031C
> > > +#define XILINX_CPM5NC_PCIE0_RST              0x00000324
> > > +
> > > +#define XILINX_CPM5NC_PCIE0_FRWALL   0x00001140
> > > +
> > >  #define XILINX_CPM_PCIE_REG_IDR              0x00000E10
> > >  #define XILINX_CPM_PCIE_REG_IMR              0x00000E14
> > >  #define XILINX_CPM_PCIE_REG_PSCR     0x00000E1C
> > > @@ -99,6 +108,7 @@ struct xilinx_cpm_variant {
> > >       u32 ir_status;
> > >       u32 ir_enable;
> > >       u32 ir_misc_value;
> > > +     u32 cpm_pcie_rst;
> > >  };
> > >
> > >  /**
> > > @@ -106,6 +116,8 @@ struct xilinx_cpm_variant {
> > >   * @dev: Device pointer
> > >   * @reg_base: Bridge Register Base
> > >   * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
> > > + * @crx_base: CPM Clock and Reset Control Registers Base
> > > + * @cpm5nc_attr_base: CPM5NC Control and Status Registers Base
> > >   * @intx_domain: Legacy IRQ domain pointer
> > >   * @cpm_domain: CPM IRQ domain pointer
> > >   * @cfg: Holds mappings of config space window
> > > @@ -118,6 +130,8 @@ struct xilinx_cpm_pcie {
> > >       struct device                   *dev;
> > >       void __iomem                    *reg_base;
> > >       void __iomem                    *cpm_base;
> > > +     void __iomem                    *crx_base;
> > > +     void __iomem                    *cpm5nc_attr_base;
> > >       struct irq_domain               *intx_domain;
> > >       struct irq_domain               *cpm_domain;
> > >       struct pci_config_window        *cfg;
> > > @@ -475,12 +489,45 @@ static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie
> > *port)
> > >   * xilinx_cpm_pcie_init_port - Initialize hardware
> > >   * @port: PCIe port information
> > >   */
> > > -static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
> > > +static int xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
> > >  {
> > >       const struct xilinx_cpm_variant *variant = port->variant;
> > > +     struct device *dev = port->dev;
> > > +     struct gpio_desc *reset_gpio;
> > > +
> > > +     /* Request the GPIO for PCIe reset signal */
> > > +     reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > > +     if (IS_ERR(reset_gpio)) {
> > > +             if (PTR_ERR(reset_gpio) != -EPROBE_DEFER)
> > > +                     dev_err(dev, "Failed to request reset GPIO\n");
> > > +             return PTR_ERR(reset_gpio);
> > > +     }
> > >
> > > -     if (variant->version == CPM5NC_HOST)
> > > -             return;
> > > +     if (reset_gpio && port->crx_base) {
> > > +             /* Assert the PCIe IP reset */
> > > +             writel_relaxed(0x1, port->crx_base + variant->cpm_pcie_rst);
> > > +
> > > +             /* Controller specific delay */
> > > +             udelay(50);
> > > +
> >
> > There should be atleast 100ms delay before PERST# deassert as per the spec. So
> > use PCIE_T_PVPERL_MS. I know that you had it before, but removed in v4. I don't
> > see a valid reason for that.
> 
> For CPM/CPM5/CPM5NC, the "Power Up" sequence mentioned in section 2.2.1
> of PCIe Electromechanical Spec is handled in the design. The PERST# we are
> using here is applied after the Power Up sequence and will be used for warm reset,
> where power of the system is already stable.
> 

I don't quite understand what you mean by 'warm reset' here. Even if the power
was already stable, what is the guarantee that the 100ms time is elapsed before
deasserting the PERST#? Does the hardware logic ensure 100ms time is elapsed
before the driver is probed?

> So, we changed the delay after PERST# and IP reset assertion to 50us controller
> specific delay, similar to TPERST(PERST# active time 100us) delay in "Power
> sequencing and Reset Signal Timings" of PCIe Electromechanical Spec. After
> deassertion of PERST# signal and IP reset, a delay of PCIE_T_RRS_READY_MS
> is required before checking the Link. Please let me know if you have further queries.
> 

This part is fine.

> Thanks, I will update this information in commit message.
> >
> > > +             /* Deassert the PCIe IP reset */
> > > +             writel_relaxed(0x0, port->crx_base + variant->cpm_pcie_rst);
> > > +
> > > +             /* Deassert the reset signal */
> > > +             gpiod_set_value(reset_gpio, 0);
> > > +             mdelay(PCIE_T_RRS_READY_MS);
> > > +
> > > +             if (variant->version == CPM5NC_HOST && port->cpm5nc_attr_base) {
> > > +                     /* Clear Firewall */
> > > +                     writel_relaxed(0x00, port->cpm5nc_attr_base +
> > > +                                     XILINX_CPM5NC_PCIE0_FRWALL);
> > > +                     writel_relaxed(0x01, port->cpm5nc_attr_base +
> > > +                                     XILINX_CPM5NC_PCIE0_FRWALL);
> > > +                     writel_relaxed(0x00, port->cpm5nc_attr_base +
> > > +                                     XILINX_CPM5NC_PCIE0_FRWALL);
> > > +                     return 0;
> > > +             }
> > > +     }
> > >
> > >       if (cpm_pcie_link_up(port))
> > >               dev_info(port->dev, "PCIe Link is UP\n");
> > > @@ -512,6 +559,8 @@ static void xilinx_cpm_pcie_init_port(struct
> > xilinx_cpm_pcie *port)
> > >       pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
> > >                  XILINX_CPM_PCIE_REG_RPSC_BEN,
> > >                  XILINX_CPM_PCIE_REG_RPSC);
> > > +
> > > +     return 0;
> > >  }
> > >
> > >  /**
> > > @@ -551,6 +600,27 @@ static int xilinx_cpm_pcie_parse_dt(struct
> > xilinx_cpm_pcie *port,
> > >               port->reg_base = port->cfg->win;
> > >       }
> > >
> > > +     port->crx_base = devm_platform_ioremap_resource_byname(pdev,
> > > +                                                            "cpm_crx");
> > > +     if (IS_ERR(port->crx_base)) {
> > > +             if (PTR_ERR(port->crx_base) == -EINVAL)
> > > +                     port->crx_base = NULL;
> > > +             else
> > > +                     return PTR_ERR(port->crx_base);
> > > +     }
> > > +
> > > +     if (port->variant->version == CPM5NC_HOST) {
> > > +             port->cpm5nc_attr_base =
> > > +                     devm_platform_ioremap_resource_byname(pdev,
> > > +                                                           "cpm5nc_attr");
> >
> > Where is this resource defined in the binding?
> 
> This patch is tested for mentioned CPM versions, I apologize that
> I missed adding the cpm5nc_attr resource in DT binding. I will not
> repeat this again. I will add the resource in the next patch.
> Thanks for your understanding.
> >
> > > +             if (IS_ERR(port->cpm5nc_attr_base)) {
> > > +                     if (PTR_ERR(port->cpm5nc_attr_base) == -EINVAL)
> >
> > Why?
> 
> This condition check is added to make cpm5nc_attr_base optional,
> once I add missing resource in DT this condition will be applicable.

Why are you checking for -EINVAL? What does it correspond to?

If your intention is to make the resource_get optional, you should use
platform_get_resource_byname() first. If it returns NULL, then it means the
resource is not defined in DT.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

