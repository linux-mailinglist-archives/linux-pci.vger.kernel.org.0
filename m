Return-Path: <linux-pci+bounces-25907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA06A89496
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 09:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84423A80A4
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 07:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE7C27979E;
	Tue, 15 Apr 2025 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y2X4yeJy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C856275863
	for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744701248; cv=none; b=Ce2Cw7+5tndy0RvJqWt4WL2jlFhNHohtVYt5NKl0B7wwcMfIVuXmEIV8EJcfaYRAYK7AnqjOSP8F9T+BtOW7ybsXx722RXRlJTwracjK/o5fWbwnKo65uoBMicP8p3H45hbpijPlvu65ijdxB+iO1iPyyYdzaPuHKKlIy/GaTbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744701248; c=relaxed/simple;
	bh=4qULDcYJYN63NTzP6EuHjHyfr61UkhniFr2QZK19+S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyTMpdKJdZB9G7oSrB9/MoNF/ymZD8v+oROF42UOfe7iRnIpKZ41d09o7U5cMEzyScXTwZkyAy32xZeqZS12D+Lwaea1Y1ZEzCXgGaiy7HV+xHKiedK7z6EYey6+ZbpGGiVWmWTi/GKb0yoHo9sCkPnMlKfPYF2PWUeUntAK91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y2X4yeJy; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30572effb26so4675536a91.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 00:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744701245; x=1745306045; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZrUqgKeIOpNB5kmRxxYY4PtW5IBxMnJqIa12M7TQd8A=;
        b=y2X4yeJyFV9nqnrPOFiNdWCcV64p0oRej0ElBUp2g0Edbljwm4jZnhinJALBOMVBsK
         eBFzIv4ty0EmiuEaG9RACLq9aOlqOgWla4+70yvFQIkpzlTtK+V9XDw1D7kyMRzVhOTt
         pbZyNd04/st1gBFXnVBhx6ZRLfRZpvQ8QzXtCa0cFp6aLW2NMNHb/5wgpZiCJN1ZkgCR
         P43ALzH+Uxk2UDYVwkSiS+Olpk3i6YoGVgGk9P+i8LWb5Gz4skpljqh5SWte+x67vI4X
         A5sVt2MRK7Mn0iMxnoGiR9bqRPJ0epHOVR5DBum2uMC35Gpgtc2w9HpZVVTMiaXg8DtV
         459g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744701245; x=1745306045;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrUqgKeIOpNB5kmRxxYY4PtW5IBxMnJqIa12M7TQd8A=;
        b=JBx9skor6X9+S+hxy4LZWrJs2MXL6cB1LBV1eMgpjTT4RwkguJ8zwOnmM78tpU6fBK
         9+i5rhGTXuETMfh9hAqLGgdbUaB7B4uW8FDcPBLMzX50JbZzbyzjWZcKwsQeDHl9h3SR
         G70M6gJztnCQepuV+6SSp94j7WuF5qwiBB7KEZzA4TTj83jftKCsm5SpM6+kEPFI7H6q
         bBgBvZkwv9zgYtkNQ8qdgJ9IgCn5aR2ciY0y7sDowwjXlXgjlBV8QVrRnbwA6ecLS+xG
         5ll1a323fya7pmKqVX9N7q5ojzWy2ZQui2ztCPtNbU7GCzAXpJROvq8h0hkum5YB4wmr
         UuVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUemi6q1m8vteLXsxpeqO2rluQfl8zeAcLZKxmW3LK9OUpp3OCA0xgE7Z2O/rJUrSkMkJaiis0RwPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTCk3MJwUIHKc0a5D0D0D6R5a83pSSD97xupYiqoEfWdHf3H0B
	zt4ToXgWn+zISXuA6xwYrXx2Ui0JpFY6YjX5RuVhcohbW8D1/4UorEzCh9LZ4w==
X-Gm-Gg: ASbGncvrM3iy/DUTuOJfbOP5j0Rk28GYgJZJhiJS92gqTS53XefmO+V+3tFT7kx+zDQ
	D+vP9B7a8TlDvA7oxl0XPgySpaSGlSllPndpSeMIEZLeYFGIhp/GPzBl3x1O1solVB1pjX36ba+
	WxOGuv4qhSrd5oYci1LqisNK5FeiXAryDZdF1ioonefUZQLn9TN00+uS5Pq/iI+31uePv8ViSjz
	ytCEjU+HXOy6hfzuFNb87DxmixUCVzmlc7edz/rkZlsnC//ZxV/FNeXJMnp5sT+NpQsDGfCYJmn
	Pb16JIfx6pH9dMCPOgmWq8FNjLVHUKqwqENODe5gXD03BkmIng==
X-Google-Smtp-Source: AGHT+IFRDS+RcqsxMbfhj3hjSYW44sXPX4N2LXrzae1Sn6v6afr2r1HMlHArD/JzawKgIloq6ITbaw==
X-Received: by 2002:a17:90b:524f:b0:305:5f32:d9f0 with SMTP id 98e67ed59e1d1-3082367e7b4mr21298534a91.19.1744701245492;
        Tue, 15 Apr 2025 00:14:05 -0700 (PDT)
Received: from thinkpad ([120.60.71.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df401ac8sm12235026a91.45.2025.04.15.00.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:14:04 -0700 (PDT)
Date: Tue, 15 Apr 2025 12:43:59 +0530
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
Message-ID: <vtz5abgqdcv4os7vr4li7yv2yaqj4mjhlbvia7uv65kfyamvxb@4j4wk36xxs7i>
References: <20250326022811.3090688-1-sai.krishna.musham@amd.com>
 <20250326022811.3090688-3-sai.krishna.musham@amd.com>
 <cjrb3idrj3x7vo4fujl6nakj3foyu64gtxwovmxd4qvovvhwqq@26bpt5b4zjao>
 <DM4PR12MB6158EFFB5F245FAA5CB022A8CDA92@DM4PR12MB6158.namprd12.prod.outlook.com>
 <kjfnox7hefk7ribdhkzj4kbkwyeg7lf62oep7duw6vfarmx5hl@eg5nzkbusm4n>
 <DM4PR12MB6158FAECAA9D3FEFFFCCC95ECDB02@DM4PR12MB6158.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM4PR12MB6158FAECAA9D3FEFFFCCC95ECDB02@DM4PR12MB6158.namprd12.prod.outlook.com>

On Sun, Apr 13, 2025 at 04:28:55AM +0000, Musham, Sai Krishna wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Manivannan,
> 
> Thanks for the review.
> 
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: Wednesday, April 9, 2025 12:25 PM
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
> > On Fri, Apr 04, 2025 at 06:59:23AM +0000, Musham, Sai Krishna wrote:
> > > [AMD Official Use Only - AMD Internal Distribution Only]
> > >
> > > Hi Manivannan,
> > >
> > > Thanks for the review.
> > >
> > > > -----Original Message-----
> > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > Sent: Thursday, March 27, 2025 10:56 PM
> > > > To: Musham, Sai Krishna <sai.krishna.musham@amd.com>
> > > > Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> > > > robh@kernel.org;
> > > > krzk+dt@kernel.org; conor+dt@kernel.org; cassel@kernel.org; linux-
> > > > pci@vger.kernel.org; devicetree@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>;
> > > > Gogada, Bharat Kumar <bharat.kumar.gogada@amd.com>; Havalige,
> > > > Thippeswamy <thippeswamy.havalige@amd.com>
> > > > Subject: Re: [PATCH v6 2/2] PCI: xilinx-cpm: Add support for PCIe RP
> > > > PERST# signal
> > > >
> > > > Caution: This message originated from an External Source. Use proper
> > > > caution when opening attachments, clicking links, or responding.
> > > >
> > > >
> > > > On Wed, Mar 26, 2025 at 07:58:11AM +0530, Sai Krishna Musham wrote:
> > > > > Add PCIe IP reset along with GPIO-based control for the PCIe Root
> > > > > Port PERST# signal. Synchronizing the PCIe IP reset with the
> > > > > PERST# signal's assertion and deassertion avoids Link Training failures.
> > > > >
> > > > > Adapt to use GPIO framework and make reset optional to maintain
> > > > > backward compatibility with existing DTBs.
> > > > >
> > > > > Add clear firewall after Link reset for CPM5NC.
> > > > >
> > > > > Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> > > > > ---
> > > > > Changes for v6:
> > > > > - Correct version check condition of CPM5NC_HOST.
> > > > >
> > > > > Changes for v5:
> > > > > - Handle probe defer for reset_gpio.
> > > > > - Resolve ABI break.
> > > > >
> > > > > Changes for v4:
> > > > > - Add PCIe PERST# support for CPM5NC.
> > > > > - Add PCIe IP reset along with PERST# to avoid Link Training Errors.
> > > > > - Remove PCIE_T_PVPERL_MS define and PCIE_T_RRS_READY_MS after
> > > > >   PERST# deassert.
> > > > > - Move PCIe PERST# assert and deassert logic to
> > > > >   xilinx_cpm_pcie_init_port() before cpm_pcie_link_up(), since
> > > > >   Interrupts enable and PCIe RP bridge enable should be done after
> > > > >   Link up.
> > > > > - Update commit message.
> > > > >
> > > > > Changes for v3:
> > > > > - Use PCIE_T_PVPERL_MS define.
> > > > >
> > > > > Changes for v2:
> > > > > - Make the request GPIO optional.
> > > > > - Correct the reset sequence as per PERST#
> > > > > - Update commit message
> > > > > ---
> > > > >  drivers/pci/controller/pcie-xilinx-cpm.c | 86
> > > > > ++++++++++++++++++++++--
> > > > >  1 file changed, 82 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c
> > > > > b/drivers/pci/controller/pcie-xilinx-
> > > > cpm.c
> > > > > index d0ab187d917f..b10c0752a94f 100644
> > > > > --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> > > > > +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> > > > > @@ -6,6 +6,8 @@
> > > > >   */
> > > > >
> > > > >  #include <linux/bitfield.h>
> > > > > +#include <linux/delay.h>
> > > > > +#include <linux/gpio/consumer.h>
> > > > >  #include <linux/interrupt.h>
> > > > >  #include <linux/irq.h>
> > > > >  #include <linux/irqchip.h>
> > > > > @@ -21,6 +23,13 @@
> > > > >  #include "pcie-xilinx-common.h"
> > > > >
> > > > >  /* Register definitions */
> > > > > +#define XILINX_CPM_PCIE0_RST         0x00000308
> > > > > +#define XILINX_CPM5_PCIE0_RST                0x00000318
> > > > > +#define XILINX_CPM5_PCIE1_RST                0x0000031C
> > > > > +#define XILINX_CPM5NC_PCIE0_RST              0x00000324
> > > > > +
> > > > > +#define XILINX_CPM5NC_PCIE0_FRWALL   0x00001140
> > > > > +
> > > > >  #define XILINX_CPM_PCIE_REG_IDR              0x00000E10
> > > > >  #define XILINX_CPM_PCIE_REG_IMR              0x00000E14
> > > > >  #define XILINX_CPM_PCIE_REG_PSCR     0x00000E1C
> > > > > @@ -99,6 +108,7 @@ struct xilinx_cpm_variant {
> > > > >       u32 ir_status;
> > > > >       u32 ir_enable;
> > > > >       u32 ir_misc_value;
> > > > > +     u32 cpm_pcie_rst;
> > > > >  };
> > > > >
> > > > >  /**
> > > > > @@ -106,6 +116,8 @@ struct xilinx_cpm_variant {
> > > > >   * @dev: Device pointer
> > > > >   * @reg_base: Bridge Register Base
> > > > >   * @cpm_base: CPM System Level Control and Status Register(SLCR)
> > > > > Base
> > > > > + * @crx_base: CPM Clock and Reset Control Registers Base
> > > > > + * @cpm5nc_attr_base: CPM5NC Control and Status Registers Base
> > > > >   * @intx_domain: Legacy IRQ domain pointer
> > > > >   * @cpm_domain: CPM IRQ domain pointer
> > > > >   * @cfg: Holds mappings of config space window @@ -118,6 +130,8
> > > > > @@ struct xilinx_cpm_pcie {
> > > > >       struct device                   *dev;
> > > > >       void __iomem                    *reg_base;
> > > > >       void __iomem                    *cpm_base;
> > > > > +     void __iomem                    *crx_base;
> > > > > +     void __iomem                    *cpm5nc_attr_base;
> > > > >       struct irq_domain               *intx_domain;
> > > > >       struct irq_domain               *cpm_domain;
> > > > >       struct pci_config_window        *cfg;
> > > > > @@ -475,12 +489,45 @@ static int xilinx_cpm_setup_irq(struct
> > > > > xilinx_cpm_pcie
> > > > *port)
> > > > >   * xilinx_cpm_pcie_init_port - Initialize hardware
> > > > >   * @port: PCIe port information
> > > > >   */
> > > > > -static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie
> > > > > *port)
> > > > > +static int xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie
> > > > > +*port)
> > > > >  {
> > > > >       const struct xilinx_cpm_variant *variant = port->variant;
> > > > > +     struct device *dev = port->dev;
> > > > > +     struct gpio_desc *reset_gpio;
> > > > > +
> > > > > +     /* Request the GPIO for PCIe reset signal */
> > > > > +     reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > > > > +     if (IS_ERR(reset_gpio)) {
> > > > > +             if (PTR_ERR(reset_gpio) != -EPROBE_DEFER)
> > > > > +                     dev_err(dev, "Failed to request reset GPIO\n");
> > > > > +             return PTR_ERR(reset_gpio);
> > > > > +     }
> > > > >
> > > > > -     if (variant->version == CPM5NC_HOST)
> > > > > -             return;
> > > > > +     if (reset_gpio && port->crx_base) {
> > > > > +             /* Assert the PCIe IP reset */
> > > > > +             writel_relaxed(0x1, port->crx_base +
> > > > > + variant->cpm_pcie_rst);
> > > > > +
> > > > > +             /* Controller specific delay */
> > > > > +             udelay(50);
> > > > > +
> > > >
> > > > There should be atleast 100ms delay before PERST# deassert as per
> > > > the spec. So use PCIE_T_PVPERL_MS. I know that you had it before,
> > > > but removed in v4. I don't see a valid reason for that.
> > >
> > > For CPM/CPM5/CPM5NC, the "Power Up" sequence mentioned in section
> > > 2.2.1 of PCIe Electromechanical Spec is handled in the design. The
> > > PERST# we are using here is applied after the Power Up sequence and
> > > will be used for warm reset, where power of the system is already stable.
> > >
> >
> > I don't quite understand what you mean by 'warm reset' here. Even if the power was
> > already stable, what is the guarantee that the 100ms time is elapsed before
> > deasserting the PERST#? Does the hardware logic ensure 100ms time is elapsed
> > before the driver is probed?
> >
> 
> The Initial Power Up sequence is handled in hardware logic, and 100ms
> (T_PVPERL) delay is provided after the power becomes stable. Yes, this part
> is handled before the driver is probed.
> 

Ok, in that case, please mention it in comments before deasserting PERST#.
Otherwise, no one except you will know.

> By "warm reset" here, I'm referring to a reset that does not involve power
> cycling the device, as per PCIe spec section 6.6.1. The power rails remain
> stable, and only PERST# is toggled through the driver.
> 
> As per the PCIe Spec replaced 50us with 100us (T_PERST) before PERST#
> deassert in driver, will send it in next patch.
> 

You mean T_PERST-CLK? I don't think you need to wait for this. IIUC, this delay
is already part of in T_PVPERL. This requirement is to make sure that the refclk
becomes active atleast T_PERST-CLK time before deasserting PERST#. I don't think
you can guarantee that in software by introducing a delay without controlling
refclk.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

