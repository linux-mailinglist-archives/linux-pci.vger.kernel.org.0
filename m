Return-Path: <linux-pci+bounces-26641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E4DA99F13
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 04:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2261946BCC
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 02:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C121A76AE;
	Thu, 24 Apr 2025 02:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeE1RD9C"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A591A5BB1;
	Thu, 24 Apr 2025 02:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745463553; cv=none; b=kKfg0BlJ7d/7OAObFIMVUijaCjdi9grz+1ad6K9jNP5uoiURyEqHZ5uzKtGik0zho+GSIhU5/5kW4iRj79lzP/zcv23BpOvWvenWJZr/5PzqO7tnhd2Jux4xOLYvrsYPfh0Xaq8UsqqVYnGyJVA45OSXk5r07FQudyaucM5Oaa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745463553; c=relaxed/simple;
	bh=fxMOSTeWF4gTTvTARekkkBNlyM3mNYmCqO9haMVO4TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5zWq3VO3oBIB2AUBBIARzr2FSGFctdlxNCWKNNxzlRXWDoFN5bOwnITH55+pfrwdFCUbHt/Cu8qmVyz8DMYv6+wts8TQLzjWRdGCpgfJOFbBqMYFeYh2+oomGITF/gqdhYFf+nZ0HuLZe0r+NzgVA0aC2ryB0eh6uRNo6F4pGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeE1RD9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B65C4CEE2;
	Thu, 24 Apr 2025 02:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745463552;
	bh=fxMOSTeWF4gTTvTARekkkBNlyM3mNYmCqO9haMVO4TU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WeE1RD9CkVv3hjxChKHjUI52b7t2/VjNao2QczXAHYtqNPyz0y41jqdj/2hRJxs9i
	 G+Dv7y7rIHXQnzZMy3IJcaCsfaWTSd6K2MC6ZtmBfNdb+Q+CVDGyE0lh72NXbZxJjt
	 5T/JQpowLTcFkpHF1/F7QVFBNilx+hkHh3u7E90frtiQtmrt/d/Nh+AZyO1mR1QOWO
	 6ak/pjtLVTuzTP8WU8InXPHJyVdE1S1vkp7FDNTbZavxxlzA7sCglIFJGDu4KOENCh
	 sbm4xU62M687iKrzPUi+kNqEqclXaptRls2nOLBeUmZYQfhl8wMiWNO/ImQSAI3GDC
	 h+hhG27kTiGZA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e677f59438so686677a12.2;
        Wed, 23 Apr 2025 19:59:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcFzRI5eVj4VkBNKvQjU5zYbTApRufnfY3Bbs7X2HzxKKSGIBHECj5xt6C8l+keZkTYDpGcLTQwdnd@vger.kernel.org, AJvYcCUx6bz+VGFRZS5noc7iO0p0N6gR9yisfsB7hNiHUq1G4L4mLd900ao+g5ems3qWZcYZiqKvOqRRjFGsKmAe@vger.kernel.org, AJvYcCXFSRcN2r41VKu1pxcNglgOS7NhJtY5/dS7iJyZwnE1RDQ9dDemFB82BsF9jGGLybs9m4/tbAS0RF35@vger.kernel.org
X-Gm-Message-State: AOJu0YwAStMgAvnoj7YzMdYauSwXfaMyPYD+D8ktjTyfPHiHS1ZYjQ9x
	MG+KSupguN8yPf6hSRNlnYrklhL1qCd4SrNBgIPBvvDbmsaIG9EL2okM8F9M0TPEeoKcMJm0uMt
	P55hwZJcraqT1vZDfjqDNaugJiQ==
X-Google-Smtp-Source: AGHT+IFv4KhcMp5wwuGxhIkPJA2U3LF3Shm+u2l+eIKkq6EP5MBdSy6E4xX6A6kwzo0gpdONN/LaKrKAcZalBTwkD4k=
X-Received: by 2002:a05:6402:4407:b0:5ee:497:67d6 with SMTP id
 4fb4d7f45d1cf-5f6df53e6dfmr1066009a12.33.1745463550895; Wed, 23 Apr 2025
 19:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411103656.2740517-1-hans.zhang@cixtech.com>
 <20250411103656.2740517-6-hans.zhang@cixtech.com> <20250411202420.GA3793660-robh@kernel.org>
 <CH2PPF4D26F8E1C8ABE8B2902E5775F594FA2B32@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
In-Reply-To: <CH2PPF4D26F8E1C8ABE8B2902E5775F594FA2B32@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 23 Apr 2025 21:58:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLNteS0m_32HuCjY8Mk9Wf+z6=HBpM7Wv=zLVqNs-7Y1Q@mail.gmail.com>
X-Gm-Features: ATxdqUFu9CpzyR3MpZWb8PUFUdjFEzWRxSIpaUljVIXKyFhbcTtKtiOOHQCd9vg
Message-ID: <CAL_JsqLNteS0m_32HuCjY8Mk9Wf+z6=HBpM7Wv=zLVqNs-7Y1Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] PCI: cadence: Add callback functions for RP and EP controller
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>
Cc: "hans.zhang@cixtech.com" <hans.zhang@cixtech.com>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, 
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 13, 2025 at 10:52=E2=80=AFPM Manikandan Karunakaran Pillai
<mpillai@cadence.com> wrote:
>
> >> +void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int
> >devfn,
> >> +                               int where)
> >> +{
> >> +    struct pci_host_bridge *bridge =3D pci_find_host_bridge(bus);
> >> +    struct cdns_pcie_rc *rc =3D pci_host_bridge_priv(bridge);
> >> +    struct cdns_pcie *pcie =3D &rc->pcie;
> >> +    unsigned int busn =3D bus->number;
> >> +    u32 addr0, desc0, desc1, ctrl0;
> >> +    u32 regval;
> >> +
> >> +    if (pci_is_root_bus(bus)) {
> >> +            /*
> >> +             * Only the root port (devfn =3D=3D 0) is connected to th=
is bus.
> >> +             * All other PCI devices are behind some bridge hence on
> >another
> >> +             * bus.
> >> +             */
> >> +            if (devfn)
> >> +                    return NULL;
> >> +
> >> +            return pcie->reg_base + (where & 0xfff);
> >> +    }
> >> +
> >> +    /*
> >> +     * Clear AXI link-down status
> >> +     */
> >
> >That is an odd thing to do in map_bus. Also, it is completely racy
> >because...
> >
> >> +    regval =3D cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE,
> >CDNS_PCIE_HPA_AT_LINKDOWN);
> >> +    cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> >CDNS_PCIE_HPA_AT_LINKDOWN,
> >> +                         (regval & GENMASK(0, 0)));
> >> +
> >
> >What if the link goes down again here.
> >
> >> +    desc1 =3D 0;
> >> +    ctrl0 =3D 0;
> >> +
> >> +    /*
> >> +     * Update Output registers for AXI region 0.
> >> +     */
> >> +    addr0 =3D CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
> >> +            CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) |
> >> +            CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(busn);
> >> +    cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> >> +                         CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(0),
> >addr0);
> >> +
> >> +    desc1 =3D cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE,
> >> +
> >CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0));
> >> +    desc1 &=3D ~CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK;
> >> +    desc1 |=3D CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
> >> +    ctrl0 =3D CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
> >> +            CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
> >> +
> >> +    if (busn =3D=3D bridge->busnr + 1)
> >> +            desc0 |=3D
> >CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0;
> >> +    else
> >> +            desc0 |=3D
> >CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1;
> >> +
> >> +    cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> >> +                         CDNS_PCIE_HPA_AT_OB_REGION_DESC0(0), desc0);
> >> +    cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> >> +                         CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0), desc1);
> >> +    cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> >> +                         CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(0), ctrl0);
> >
> >This is also racy with the read and write functions. Don't worry, lots
> >of other broken h/w like this...
> >
> >Surely this new h/w supports ECAM style config accesses? If so, use
> >and support that mode instead.
> >
>
> As an IP related driver, the  ECAM address in the SoC is not available. F=
or SoC, the
> Vendor can override this function in their code with the ECAM address.


>
> >> +
> >> +    return rc->cfg_base + (where & 0xfff);
> >> +}
> >> +
> >>  static struct pci_ops cdns_pcie_host_ops =3D {
> >>      .map_bus        =3D cdns_pci_map_bus,
> >>      .read           =3D pci_generic_config_read,
> >>      .write          =3D pci_generic_config_write,
> >>  };
> >>
> >> +static struct pci_ops cdns_pcie_hpa_host_ops =3D {
> >> +    .map_bus        =3D cdns_pci_hpa_map_bus,
> >> +    .read           =3D pci_generic_config_read,
> >> +    .write          =3D pci_generic_config_write,
> >> +};
> >> +
> >>  static int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
> >>  {
> >>      u32 pcie_cap_off =3D CDNS_PCIE_RP_CAP_OFFSET;
> >> @@ -154,8 +220,14 @@ static void
> >cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
> >>  {
> >>      u32 val;
> >>
> >> -    val =3D cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
> >> -    cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val |
> >CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
> >> +    if (!pcie->is_hpa) {
> >> +            val =3D cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
> >> +            cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val |
> >CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
> >> +    } else {
> >> +            val =3D cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG,
> >CDNS_PCIE_HPA_LM_PTM_CTRL);
> >> +            cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG,
> >CDNS_PCIE_HPA_LM_PTM_CTRL,
> >> +                                 val |
> >CDNS_PCIE_HPA_LM_TPM_CTRL_PTMRSEN);
> >> +    }
> >>  }
> >>
> >>  static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
> >> @@ -340,8 +412,8 @@ static int cdns_pcie_host_bar_config(struct
> >cdns_pcie_rc *rc,
> >>               */
> >>              bar =3D cdns_pcie_host_find_min_bar(rc, size);
> >>              if (bar !=3D RP_BAR_UNDEFINED) {
> >> -                    ret =3D cdns_pcie_host_bar_ib_config(rc, bar, cpu=
_addr,
> >> -                                                       size, flags);
> >> +                    ret =3D pcie->ops->host_bar_ib_config(rc, bar, cp=
u_addr,
> >> +                                                        size, flags);
> >>                      if (ret)
> >>                              dev_err(dev, "IB BAR: %d config failed\n"=
, bar);
> >>                      return ret;
> >> @@ -366,8 +438,7 @@ static int cdns_pcie_host_bar_config(struct
> >cdns_pcie_rc *rc,
> >>              }
> >>
> >>              winsize =3D bar_max_size[bar];
> >> -            ret =3D cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr, w=
insize,
> >> -                                               flags);
> >> +            ret =3D pcie->ops->host_bar_ib_config(rc, bar, cpu_addr, =
winsize,
> >flags);
> >>              if (ret) {
> >>                      dev_err(dev, "IB BAR: %d config failed\n", bar);
> >>                      return ret;
> >> @@ -408,8 +479,8 @@ static int cdns_pcie_host_map_dma_ranges(struct
> >cdns_pcie_rc *rc)
> >>      if (list_empty(&bridge->dma_ranges)) {
> >>              of_property_read_u32(np, "cdns,no-bar-match-nbits",
> >>                                   &no_bar_nbits);
> >> -            err =3D cdns_pcie_host_bar_ib_config(rc, RP_NO_BAR, 0x0,
> >> -                                               (u64)1 << no_bar_nbits=
, 0);
> >> +            err =3D pcie->ops->host_bar_ib_config(rc, RP_NO_BAR, 0x0,
> >> +                                                (u64)1 << no_bar_nbit=
s, 0);
> >>              if (err)
> >>                      dev_err(dev, "IB BAR: %d config failed\n",
> >RP_NO_BAR);
> >>              return err;
> >> @@ -467,17 +538,159 @@ int
> >cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
> >>              u64 pci_addr =3D res->start - entry->offset;
> >>
> >>              if (resource_type(res) =3D=3D IORESOURCE_IO)
> >> -                    cdns_pcie_set_outbound_region(pcie, busnr, 0, r,
> >> -                                                  true,
> >> -                                                  pci_pio_to_address(=
res-
> >>start),
> >> -                                                  pci_addr,
> >> -                                                  resource_size(res))=
;
> >> +                    pcie->ops->set_outbound_region(pcie, busnr, 0, r,
> >> +                                                   true,
> >> +                                                   pci_pio_to_address=
(res-
> >>start),
> >> +                                                   pci_addr,
> >> +                                                   resource_size(res)=
);
> >> +            else
> >> +                    pcie->ops->set_outbound_region(pcie, busnr, 0, r,
> >> +                                                   false,
> >> +                                                   res->start,
> >> +                                                   pci_addr,
> >> +                                                   resource_size(res)=
);
> >> +
> >> +            r++;
> >> +    }
> >> +
> >> +    return cdns_pcie_host_map_dma_ranges(rc);
> >> +}
> >> +
> >> +int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc)
> >> +{
> >> +    struct cdns_pcie *pcie =3D &rc->pcie;
> >> +    u32 value, ctrl;
> >> +
> >> +    /*
> >> +     * Set the root complex BAR configuration register:
> >> +     * - disable both BAR0 and BAR1.
> >> +     * - enable Prefetchable Memory Base and Limit registers in type =
1
> >> +     *   config space (64 bits).
> >> +     * - enable IO Base and Limit registers in type 1 config
> >> +     *   space (32 bits).
> >> +     */
> >> +
> >> +    ctrl =3D CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED;
> >> +    value =3D CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL(ctrl) |
> >> +            CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL(ctrl) |
> >> +            CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE
> >|
> >> +            CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS |
> >> +            CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_ENABLE |
> >> +            CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_32BITS;
> >> +    cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG,
> >> +                         CDNS_PCIE_HPA_LM_RC_BAR_CFG, value);
> >> +
> >> +    if (rc->vendor_id !=3D 0xffff)
> >> +            cdns_pcie_rp_writew(pcie, PCI_VENDOR_ID, rc->vendor_id);
> >> +
> >> +    if (rc->device_id !=3D 0xffff)
> >> +            cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);
> >> +
> >> +    cdns_pcie_rp_writeb(pcie, PCI_CLASS_REVISION, 0);
> >> +    cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
> >> +    cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE,
> >PCI_CLASS_BRIDGE_PCI);
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +int cdns_pcie_hpa_host_bar_ib_config(struct cdns_pcie_rc *rc,
> >> +                                 enum cdns_pcie_rp_bar bar,
> >> +                                 u64 cpu_addr, u64 size,
> >> +                                 unsigned long flags)
> >> +{
> >> +    struct cdns_pcie *pcie =3D &rc->pcie;
> >> +    u32 addr0, addr1, aperture, value;
> >> +
> >> +    if (!rc->avail_ib_bar[bar])
> >> +            return -EBUSY;
> >> +
> >> +    rc->avail_ib_bar[bar] =3D false;
> >> +
> >> +    aperture =3D ilog2(size);
> >> +    addr0 =3D CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS(aperture) |
> >> +            (lower_32_bits(cpu_addr) & GENMASK(31, 8));
> >> +    addr1 =3D upper_32_bits(cpu_addr);
> >> +    cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER,
> >> +                         CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0(bar),
> >addr0);
> >> +    cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER,
> >> +                         CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR1(bar),
> >addr1);
> >> +
> >> +    if (bar =3D=3D RP_NO_BAR)
> >> +            return 0;
> >> +
> >> +    value =3D cdns_pcie_hpa_readl(pcie, REG_BANK_IP_CFG_CTRL_REG,
> >CDNS_PCIE_HPA_LM_RC_BAR_CFG);
> >> +    value &=3D ~(HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar) |
> >> +               HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) |
> >> +               HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar) |
> >> +               HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) |
> >> +               HPA_LM_RC_BAR_CFG_APERTURE(bar,
> >bar_aperture_mask[bar] + 2));
> >> +    if (size + cpu_addr >=3D SZ_4G) {
> >> +            if (!(flags & IORESOURCE_PREFETCH))
> >> +                    value |=3D
> >HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar);
> >> +            value |=3D
> >HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar);
> >> +    } else {
> >> +            if (!(flags & IORESOURCE_PREFETCH))
> >> +                    value |=3D
> >HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar);
> >> +            value |=3D
> >HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar);
> >> +    }
> >> +
> >> +    value |=3D HPA_LM_RC_BAR_CFG_APERTURE(bar, aperture);
> >> +    cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG,
> >CDNS_PCIE_HPA_LM_RC_BAR_CFG, value);
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc *=
rc)
> >> +{
> >> +    struct cdns_pcie *pcie =3D &rc->pcie;
> >> +    struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(rc);
> >> +    struct resource *cfg_res =3D rc->cfg_res;
> >> +    struct resource_entry *entry;
> >> +    u64 cpu_addr =3D cfg_res->start;
> >> +    u32 addr0, addr1, desc1;
> >> +    int r, busnr =3D 0;
> >> +
> >> +    entry =3D resource_list_first_type(&bridge->windows,
> >IORESOURCE_BUS);
> >> +    if (entry)
> >> +            busnr =3D entry->res->start;
> >> +
> >> +    /*
> >> +     * Reserve region 0 for PCI configure space accesses:
> >> +     * OB_REGION_PCI_ADDR0 and OB_REGION_DESC0 are updated
> >dynamically by
> >> +     * cdns_pci_map_bus(), other region registers are set here once f=
or all.
> >> +     */
> >> +    addr1 =3D 0;
> >> +    desc1 =3D CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(busnr);
> >> +    cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> >> +                         CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(0),
> >addr1);
> >> +    cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> >> +                         CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0), desc1);
> >> +
> >> +    addr0 =3D CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
> >> +            (lower_32_bits(cpu_addr) & GENMASK(31, 8));
> >> +    addr1 =3D upper_32_bits(cpu_addr);
> >> +    cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> >> +                         CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(0),
> >addr0);
> >> +    cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> >> +                         CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(0),
> >addr1);
> >> +
> >> +    r =3D 1;
> >> +    resource_list_for_each_entry(entry, &bridge->windows) {
> >> +            struct resource *res =3D entry->res;
> >> +            u64 pci_addr =3D res->start - entry->offset;
> >> +
> >> +            if (resource_type(res) =3D=3D IORESOURCE_IO)
> >> +                    pcie->ops->set_outbound_region(pcie, busnr, 0, r,
> >> +                                                   true,
> >> +                                                   pci_pio_to_address=
(res-
> >>start),
> >> +                                                   pci_addr,
> >> +                                                   resource_size(res)=
);
> >>              else
> >> -                    cdns_pcie_set_outbound_region(pcie, busnr, 0, r,
> >> -                                                  false,
> >> -                                                  res->start,
> >> -                                                  pci_addr,
> >> -                                                  resource_size(res))=
;
> >> +                    pcie->ops->set_outbound_region(pcie, busnr, 0, r,
> >> +                                                   false,
> >> +                                                   res->start,
> >> +                                                   pci_addr,
> >> +                                                   resource_size(res)=
);
> >>
> >>              r++;
> >>      }
> >> @@ -489,11 +702,11 @@ int cdns_pcie_host_init(struct cdns_pcie_rc *rc)
> >>  {
> >>      int err;
> >>
> >> -    err =3D cdns_pcie_host_init_root_port(rc);
> >> +    err =3D rc->pcie.ops->host_init_root_port(rc);
> >>      if (err)
> >>              return err;
> >>
> >> -    return cdns_pcie_host_init_address_translation(rc);
> >> +    return rc->pcie.ops->host_init_address_translation(rc);
> >>  }
> >>
> >>  int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
> >> @@ -503,7 +716,7 @@ int cdns_pcie_host_link_setup(struct cdns_pcie_rc
> >*rc)
> >>      int ret;
> >>
> >>      if (rc->quirk_detect_quiet_flag)
> >> -            cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
> >> +            pcie->ops->detect_quiet_min_delay_set(&rc->pcie);
> >>
> >>      cdns_pcie_host_enable_ptm_response(pcie);
> >>
> >> @@ -566,8 +779,12 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
> >>      if (ret)
> >>              return ret;
> >>
> >> -    if (!bridge->ops)
> >> -            bridge->ops =3D &cdns_pcie_host_ops;
> >> +    if (!bridge->ops) {
> >> +            if (pcie->is_hpa)
> >> +                    bridge->ops =3D &cdns_pcie_hpa_host_ops;
> >> +            else
> >> +                    bridge->ops =3D &cdns_pcie_host_ops;
> >> +    }
> >>
> >>      ret =3D pci_host_probe(bridge);
> >>      if (ret < 0)
> >> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> >b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> >> index b24176d4df1f..8d5fbaef0a3c 100644
> >> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> >> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> >> @@ -43,7 +43,30 @@ static u64 cdns_plat_cpu_addr_fixup(struct cdns_pci=
e
> >*pcie, u64 cpu_addr)
> >>  }
> >>
> >>  static const struct cdns_pcie_ops cdns_plat_ops =3D {
> >> +    .link_up =3D cdns_pcie_linkup,
> >>      .cpu_addr_fixup =3D cdns_plat_cpu_addr_fixup,
> >> +    .host_init_root_port =3D cdns_pcie_host_init_root_port,
> >> +    .host_bar_ib_config =3D cdns_pcie_host_bar_ib_config,
> >> +    .host_init_address_translation =3D
> >cdns_pcie_host_init_address_translation,
> >> +    .detect_quiet_min_delay_set =3D
> >cdns_pcie_detect_quiet_min_delay_set,
> >> +    .set_outbound_region =3D cdns_pcie_set_outbound_region,
> >> +    .set_outbound_region_for_normal_msg =3D
> >> +
> >cdns_pcie_set_outbound_region_for_normal_msg,
> >> +    .reset_outbound_region =3D cdns_pcie_reset_outbound_region,
> >> +};
> >> +
> >> +static const struct cdns_pcie_ops cdns_hpa_plat_ops =3D {
> >> +    .start_link =3D cdns_pcie_hpa_startlink,
> >> +    .stop_link =3D cdns_pcie_hpa_stop_link,
> >> +    .link_up =3D cdns_pcie_hpa_linkup,
> >> +    .host_init_root_port =3D cdns_pcie_hpa_host_init_root_port,
> >> +    .host_bar_ib_config =3D cdns_pcie_hpa_host_bar_ib_config,
> >> +    .host_init_address_translation =3D
> >cdns_pcie_hpa_host_init_address_translation,
> >> +    .detect_quiet_min_delay_set =3D
> >cdns_pcie_hpa_detect_quiet_min_delay_set,
> >> +    .set_outbound_region =3D cdns_pcie_hpa_set_outbound_region,
> >> +    .set_outbound_region_for_normal_msg =3D
> >> +
> >cdns_pcie_hpa_set_outbound_region_for_normal_msg,
> >> +    .reset_outbound_region =3D cdns_pcie_hpa_reset_outbound_region,
> >
> >What exactly is shared between these 2 implementations. Link handling,
> >config space accesses, address translation, and host init are all
> >different. What's left to share? MSIs (if not passed thru) and
> >interrupts? I think it's questionable that this be the same driver.
> >
> The address of both these have changed as the controller architecture has
> changed. In the event these driver have to be same driver, there will lot=
 of
> sprinkled "if(is_hpa)" and that was already rejected in earlier version o=
f code.

I'm saying they should *not* be the same driver because you don't
share hardly anything. Again, what is really common here?

> Hence it was done similar to other drivers by architecture specific "ops"=
.

Yes, and IMO driver private/custom ops is the wrong direction to go.
Read my prior reply below again.

> The "if(is_hpa)" is now very limited where a specific ops functions does =
not make
> any sense.

But you still have them. In a separate driver, you would have 0.

> >A bunch of driver specific 'ops' is not the right direction despite
> >other drivers (DWC) having that. If there are common parts, then make
> >them library functions multiple drivers can call.

