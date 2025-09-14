Return-Path: <linux-pci+bounces-36101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D90B568E0
	for <lists+linux-pci@lfdr.de>; Sun, 14 Sep 2025 14:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7765188B5F6
	for <lists+linux-pci@lfdr.de>; Sun, 14 Sep 2025 12:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF14A264A9E;
	Sun, 14 Sep 2025 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AZuVY1SE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF8A2594B7
	for <linux-pci@vger.kernel.org>; Sun, 14 Sep 2025 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757853893; cv=none; b=C+6RpuvHMyHrAa/BbBU+bb2go91L0ZpiwXMUZLUrX0ddrwGoLQBsW34wMlr2cZq7bH+qpBZdNjxAkHMj7racB1dQQU6R+EKWJWUMJddHinqNfyRwYQ1ntvt8NIzs7iYYzpyhdxux/K60WEpwnIJ4PR321C3E4QKroGTtiEJtnnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757853893; c=relaxed/simple;
	bh=TTFnu68yb+Au9LixYPUGJrBKfQnoNpwW/TLJGeCsG3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=su/f9ePcuoF8NwRK55Elqo2iAJEf1TsPHy3IpvvVCdC7BO9LqSkLqLKzwFAEGytjss2mQ1SZSqBItygETJEj+U5LTTGSpVt91aLrIcwx2MFnJV7Gin25oFXuq40/4atb5HbvRmBI5npz0Lsx9SB+0WSbX2Vw5mdF6pdKuGh3zD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AZuVY1SE; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b07883a5feeso578932966b.1
        for <linux-pci@vger.kernel.org>; Sun, 14 Sep 2025 05:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757853889; x=1758458689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3jarG5W9v/tiwJ7KYHhBO2xAhW53n/q4HgYQtmBrgqQ=;
        b=AZuVY1SEIV5zgKivCney/xKWU4cXUpWxw4sI8dUdiX16+zn2uw4LFPoGpsn0qbjvXZ
         Sb28DHfClqW/23euv/rjrBUOS1U6ZBqpqU3wqAi0BAUz0A388klJOuMkC1EePG95obMW
         GwdkDAMXtOfUQ8s/kl3pbvYUBbNOhbyGbRpAQ03fESg6TtzNHu3A75jW+1ui86jvdfi9
         wyG1Ti/l17/Tr1nmpwK+Hsp5GK6viFz4mng+jSjxDBD6HxKXVImMFd1IeRpkaHf9R287
         UERzXdGBC9uamDoyHlEH4vdJJlFEQr5Jun2/j7CietUbwyflWVcJRPQW115i//jsvy+w
         hn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757853889; x=1758458689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3jarG5W9v/tiwJ7KYHhBO2xAhW53n/q4HgYQtmBrgqQ=;
        b=dUzOGdqnQVKHa2hNZc4oWH6PW2s4946ePW2POUmLYyXC569VURCbcbT22sbdkrhhEJ
         mQHvg/hVlZ9zD0Ve76WTqysgW0YNokmFnn7OiFB4/j9VzyGYdmTcyA9F0gmbMs91vQm1
         1O8L5V0/joruEGOH4nhqeUFJiI5yFgUkTel9QhH4+ew7v9Znxyibas+f3JVzFd6geDlP
         LTETBaws4xuCxqnXXfVXhBGpg2GaC9sSDrMokXP9zDKpn2hsmr3xJi9EkXGs+mVXOSYE
         BZczM7915cXEIT9rQAPswYj7kxluY82WZP6rmhkVJw/SUHNF//0msXRqB4N/kw//7zPL
         kAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXyRbcmbuTb5l+jJDEriTRwGn0OkJyvg3fS1tzVS069rwyAAyWRagRzM4KEJwuT+CVzNDg87ba97c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8HyPDce2do7toUM1b2F4QmnsUrqL5wgfpBfLE7OLkrDlLPjr6
	s0I5yZlktJJJIt2UzX0bds5+NepUrGKsKKf/E2LhWlCMyZdfxxoj/cws1FGyryVnekFNeEV0qCQ
	EBfSLJzbG93uKYLI8eZch+iunBz2f9yHY3DeBGuJcRg==
X-Gm-Gg: ASbGncuFyt/KyQOOa92pr3WBtmmMgYS4PfrumNrEUpf2aR08fS8oTXc62iWA9DCquow
	IDrRyPQLw/uzN+hzG96CxSjIh0CSkT3+EwWJjjeuuFtHxUkdWz8yLkgblbmjYU+zf9q2GNLxu6X
	HMpSqpuYQf1itvDF9sgMiWkESs6/lbTAI4Iz36zV1x1obf+IARZEQprJFIIpX/8bNYbuGAe45Wq
	M+nFG51fPebqXA+Ucqu7ULlsbORglsP+3UKZnXwGtzAvZk=
X-Google-Smtp-Source: AGHT+IE9eAQD+G1SRpZULH79spXVrYWnoM/RUchKtYl+AmPG6QEUapYbgUztUJxf+kTU0Jaaj6Ctvzv2Epz/ufXiT+U=
X-Received: by 2002:a17:907:930b:b0:b04:4975:e648 with SMTP id
 a640c23a62f3a-b07c37fd7cemr890704666b.35.1757853888447; Sun, 14 Sep 2025
 05:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912141436.2347852-4-vincent.guittot@linaro.org> <20250912230236.GA1650055@bhelgaas>
In-Reply-To: <20250912230236.GA1650055@bhelgaas>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sun, 14 Sep 2025 14:44:36 +0200
X-Gm-Features: Ac12FXwgPDN7Jkf5BHLA_3G8vhZznN8l0SVIXAy3GO80o-BlChQL_IMcOsAzjt0
Message-ID: <CAKfTPtDzL1A0KuOdP1vNaiE03cSrzE_+Nb5iC0cLQLtCC6_GLQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] pcie: s32g: Add initial PCIe support (RC)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com, 
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Sept 2025 at 01:02, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Run "git log --oneline drivers/pci/controller/dwc" and follow the
> subject line convention.

Ok

>
> On Fri, Sep 12, 2025 at 04:14:35PM +0200, Vincent Guittot wrote:
> > Add initial support of the PCIe controller for S32G Soc family. Only
> > host mode is supported.
>
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -255,6 +255,18 @@ config PCIE_TEGRA194_EP
> >         in order to enable device-specific features PCIE_TEGRA194_EP must be
> >         selected. This uses the DesignWare core.
> >
> > +config PCI_S32G
> > +     bool "NXP S32G PCIe controller (host mode)"
> > +     depends on ARCH_S32 || (OF && COMPILE_TEST)
> > +     select PCIE_DW_HOST
> > +     help
> > +       Enable support for the PCIe controller in NXP S32G based boards to
> > +       work in Host mode. The controller is based on Designware IP and
> > +       can work either as RC or EP. In order to enable host-specific
> > +       features PCI_S32G must be selected and in order to enable
> > +       device-specific features PCI_S32G_EP must be selected.
>
> s/Designware/DesignWare/
>
> "enable host-specific features" is oddly specific.  You need PCI_S32G
> to make S32G PCIe work at all.
>
> Remove PCI_S32G_EP since you didn't add that.  There are several
> references to endpoint mode in the code below; you should probably
> remove those as well until you add that support.

Ok

>
> > +++ b/drivers/pci/controller/dwc/pci-s32g-regs.h
>
> Squash this into pcie-s32g.c.  No need to add a separate include file.
> Maybe if/when you add endpoint support, but no need now.

Yeah, i will get it back when adding EP support

>
> > +/* Instance PCIE_SS - CTRL register offsets (ctrl base) */
> > +#define LINK_INT_CTRL_STS                    (0x40U)
>
> Unnecessary parens.  Unnecessary "U".

Ok

>
> > +#define LINK_REQ_RST_NOT_INT_EN                      BIT(1)
> > +#define LINK_REQ_RST_NOT_CLR                 BIT(2)
> > +
> > +/* PCIe controller 0 general control 1 (PE0_GEN_CTRL_1) (ctrl base) */
> > +#define PE0_GEN_CTRL_1                               (0x50U)
> > +#define SS_DEVICE_TYPE_MASK                  GENMASK(3, 0)
> > +#define SS_DEVICE_TYPE(x)                    FIELD_PREP(SS_DEVICE_TYPE_MASK, x)
> > +
> > +enum pcie_dev_type_val {
> > +     PCIE_EP_VAL = 0x0,
> > +     PCIE_RC_VAL = 0x4
> > +};
>
> Use the existing PCI_EXP_TYPE_ENDPOINT, PCI_EXP_TYPE_ROOT_PORT.

Thanks, I haven't been able to find them

>
> > +
> > +#define SRIS_MODE_EN                         BIT(8)
> > +
> > +/* PCIe controller 0 general control 3 (PE0_GEN_CTRL_3) (ctrl base) */
> > +#define PE0_GEN_CTRL_3                               (0x58U)
> > +/* LTSSM Enable. Active high. Set it low to hold the LTSSM in Detect state. */
> > +#define LTSSM_EN                             BIT(0)
> > +
> > +/* PCIe Controller 0 Link Debug 2 (ctrl base) */
> > +#define PCIE_SS_PE0_LINK_DBG_2                       (0xB4U)
> > +#define PCIE_SS_SMLH_LTSSM_STATE_MASK                GENMASK(5, 0)
> > +#define PCIE_SS_SMLH_LINK_UP                 BIT(6)
> > +#define PCIE_SS_RDLH_LINK_UP                 BIT(7)
> > +#define LTSSM_STATE_L0                               0x11U /* L0 state */
> > +#define LTSSM_STATE_L0S                              0x12U /* L0S state */
> > +#define LTSSM_STATE_L1_IDLE                  0x14U /* L1_IDLE state */
> > +#define LTSSM_STATE_HOT_RESET                        0x1FU /* HOT_RESET state */
> > +
> > +/* PCIe Controller 0  Interrupt Status (ctrl base) */
> > +#define PE0_INT_STS                          (0xE8U)
> > +#define HP_INT_STS                           BIT(6)
> > +
> > +/* Status and Command Register. pci-regs.h */
> > +
> > +/* Instance PCIE_CAP */
> > +#define PCIE_CAP_BASE                                (0x70U)
>
> Should be able to use dw_pcie_find_capability() or similar to avoid
> hard-coding this.

Ok

>
> > +/* Device Control and Status Register. */
> > +#define CAP_DEVICE_CONTROL_DEVICE_STATUS     (PCIE_CAP_BASE + PCI_EXP_DEVCTL)
>
> Use PCI_EXP_DEVCTL and PCI_EXP_DEVSTA directly in the code so grep
> finds the uses easily.  Same for link, slot, etc. below.

Ok

>
> > +#define CAP_CORR_ERR_REPORT_EN                       BIT(0)
> > +#define CAP_NON_FATAL_ERR_REPORT_EN          BIT(1)
> > +#define CAP_FATAL_ERR_REPORT_EN                      BIT(2)
> > +#define CAP_UNSUPPORT_REQ_REP_EN             BIT(3)
> > +#define CAP_EN_REL_ORDER                     BIT(4)
> > +#define CAP_MAX_PAYLOAD_SIZE_CS_MASK         GENMASK(7, 5)
> > +#define CAP_MAX_PAYLOAD_SIZE_CS(x)           FIELD_PREP(CAP_MAX_PAYLOAD_SIZE_CS_MASK, x)
> > +#define CAP_MAX_READ_REQ_SIZE_MASK           GENMASK(14, 12)
> > +#define CAP_MAX_READ_REQ_SIZE(x)             FIELD_PREP(CAP_MAX_READ_REQ_SIZE_MASK, x)
>
> Use existing PCI_EXP_DEVCTL_CERE, PCI_EXP_DEVCTL_NFERE, etc. so grep
> finds these easily.

Ok

>
> > +/* Link Control and Status Register. */
> > +#define PCIE_CTRL_LINK_STATUS                        (PCIE_CAP_BASE + PCI_EXP_LNKCTL)
> > +#define PCIE_CAP_RETRAIN_LINK                        BIT(5)
> > +#define PCIE_CAP_LINK_TRAINING                       BIT(27)
> > +
> > +/* Slot Control and Status Register */
> > +#define PCIE_SLOT_CONTROL_SLOT_STATUS                (PCIE_CAP_BASE + PCI_EXP_SLTCTL)
> > +#define PCIE_CAP_PRESENCE_DETECT_CHANGE_EN   BIT(3)
> > +#define PCIE_CAP_HOT_PLUG_INT_EN             BIT(5)
> > +#define PCIE_CAP_DLL_STATE_CHANGED_EN                BIT(12)
> > +
> > +/* Link Control 2 and Status 2 Register. */
> > +#define CAP_LINK_CONTROL2_LINK_STATUS2               (PCIE_CAP_BASE + PCI_EXP_LNKCTL2)
> > +#define PCIE_CAP_TARGET_LINK_SPEED_MASK              GENMASK(3, 0)
> > +#define PCIE_CAP_TARGET_LINK_SPEED(x)                FIELD_PREP(PCIE_CAP_TARGET_LINK_SPEED_MASK, x)
> > +
> > +/* Instance PCIE_PORT_LOGIC - DBI register offsets */
> > +#define PCIE_PORT_LOGIC_BASE                 (0x700U)
> > +
> > +/* Port Force Link Register. pcie-designware.h */
> > +
> > +/* Link Width and Speed Change Control Register. pcie-designware.h */
> > +
> > +/* Gen3 Control Register. pcie-designware.h */
> > +#define PCIE_EQ_PHASE_2_3                    BIT(9)
> > +
> > +/* Gen3 EQ Control Register. pcie-designware.h */
> > +
> > +/* ACE Cache Coherency Control Register 3 */
> > +#define PORT_LOGIC_COHERENCY_CONTROL_1               (PCIE_PORT_LOGIC_BASE + 0x1E0U)
> > +#define PORT_LOGIC_COHERENCY_CONTROL_2               (PCIE_PORT_LOGIC_BASE + 0x1E4U)
> > +#define PORT_LOGIC_COHERENCY_CONTROL_3               (PCIE_PORT_LOGIC_BASE + 0x1E8U)
>
> Add blank line before comment.
>
> > +/*
> > + * See definition of register "ACE Cache Coherency Control Register 1"
> > + * (COHERENCY_CONTROL_1_OFF) in the SoC RM
> > + */
> > +#define CC_1_MEMTYPE_BOUNDARY_MASK           GENMASK(31, 2)
> > +#define CC_1_MEMTYPE_BOUNDARY(x)             FIELD_PREP(CC_1_MEMTYPE_BOUNDARY_MASK, x)
> > +#define CC_1_MEMTYPE_VALUE                   BIT(0)
> > +#define CC_1_MEMTYPE_LOWER_PERIPH            0x0
> > +#define CC_1_MEMTYPE_LOWER_MEM                       0x1
> > +
> > +#endif  /* PCI_S32G_REGS_H */
> > diff --git a/drivers/pci/controller/dwc/pci-s32g.c b/drivers/pci/controller/dwc/pci-s32g.c
> > new file mode 100644
> > index 000000000000..3a7c2fc83432
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pci-s32g.c
> > @@ -0,0 +1,697 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PCIe host controller driver for NXP S32G SoCs
> > + *
> > + * Copyright 2019-2025 NXP
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_address.h>
> > +#include <linux/pci.h>
> > +#include <linux/phy.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/io.h>
> > +#include <linux/sizes.h>
>
> Alphabetize the includes above.

Ok

>
> > +#include "pcie-designware.h"
> > +#include "pci-s32g-regs.h"
> > +#include "pci-s32g.h"
> > +
> > +static void s32g_pcie_writel_ctrl(struct s32g_pcie *pci, u32 reg, u32 val)
> > +{
> > +     if (dw_pcie_write(pci->ctrl_base + reg, 0x4, val))
> > +             dev_err(pci->pcie.dev, "Write ctrl address failed\n");
> > +}
> > +
> > +static u32 s32g_pcie_readl_ctrl(struct s32g_pcie *pci, u32 reg)
> > +{
> > +     u32 val = 0;
> > +
> > +     if (dw_pcie_read(pci->ctrl_base + reg, 0x4, &val))
> > +             dev_err(pci->pcie.dev, "Read ctrl address failed\n");
> > +
> > +     return val;
> > +}
> > +
> > +static void s32g_pcie_enable_ltssm(struct s32g_pcie *pci)
> > +{
> > +     u32 reg;
> > +
> > +     reg = s32g_pcie_readl_ctrl(pci, PE0_GEN_CTRL_3);
> > +     reg |= LTSSM_EN;
> > +     s32g_pcie_writel_ctrl(pci, PE0_GEN_CTRL_3, reg);
> > +}
> > +
> > +static void s32g_pcie_disable_ltssm(struct s32g_pcie *pci)
> > +{
> > +     u32 reg;
> > +
> > +     reg = s32g_pcie_readl_ctrl(pci, PE0_GEN_CTRL_3);
> > +     reg &= ~LTSSM_EN;
> > +     s32g_pcie_writel_ctrl(pci, PE0_GEN_CTRL_3, reg);
> > +}
> > +
> > +static bool is_s32g_pcie_ltssm_enabled(struct s32g_pcie *pci)
> > +{
> > +     return (s32g_pcie_readl_ctrl(pci, PE0_GEN_CTRL_3) & LTSSM_EN);
> > +}
> > +
> > +#define PCIE_LINKUP  (PCIE_SS_SMLH_LINK_UP | PCIE_SS_RDLH_LINK_UP)
> > +
> > +static bool has_data_phy_link(struct s32g_pcie *s32g_pp)
> > +{
> > +     u32 val = s32g_pcie_readl_ctrl(s32g_pp, PCIE_SS_PE0_LINK_DBG_2);
> > +
> > +     if ((val & PCIE_LINKUP) == PCIE_LINKUP) {
> > +             switch (val & PCIE_SS_SMLH_LTSSM_STATE_MASK) {
> > +             case LTSSM_STATE_L0:
> > +             case LTSSM_STATE_L0S:
> > +             case LTSSM_STATE_L1_IDLE:
> > +                     return true;
> > +             default:
> > +                     return false;
> > +             }
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +static struct pci_bus *s32g_get_child_downstream_bus(struct pci_bus *bus)
> > +{
> > +     struct pci_bus *child, *root_bus = NULL;
> > +
> > +     list_for_each_entry(child, &bus->children, node) {
> > +             if (child->parent == bus) {
> > +                     root_bus = child;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     if (!root_bus)
> > +             return ERR_PTR(-ENODEV);
> > +
> > +     return root_bus;
> > +}
> > +
> > +static bool s32g_pcie_link_is_up(struct dw_pcie *pcie)
>
> Use names similar to other drivers, "s32g_pcie_link_up" in this case.

Ok

>
> > +{
> > +     struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pcie);
> > +
> > +     if (!is_s32g_pcie_ltssm_enabled(s32g_pp))
> > +             return 0;
> > +
> > +     return has_data_phy_link(s32g_pp);
> > +}
> > +
> > +/* Use 200ms for PHY link timeout (slightly larger than 100ms, which PCIe standard requests
> > + * to wait "before sending a Configuration Request to the device")
>
> Use same comment style as other drivers, e.g.,

It's a mistake, will fix it

>
>   /*
>    * Use 200ms ...
>    */
>
> > + */
> > +#define PCIE_LINK_TIMEOUT_US         (200 * USEC_PER_MSEC)
> > +#define PCIE_LINK_WAIT_US            1000
>
> Instead of defining your own, use #defines from drivers/pci/pci.h for
> values from the PCIe spec.

Ok

>
> > +static int s32g_pcie_start_link(struct dw_pcie *pcie)
> > +{
> > +     struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pcie);
> > +     u32 reg, tmp;
> > +     int ret;
> > +
> > +     /* Don't do anything if not Root Complex */
> > +     if (!is_s32g_pcie_rc(s32g_pp->mode))
> > +             return 0;
> > +
> > +     if (pcie->max_link_speed >= 1 && pcie->max_link_speed < 3) {
> > +             /* Limit max link speed */
> > +             reg = dw_pcie_readl_dbi(pcie, CAP_LINK_CONTROL2_LINK_STATUS2);
> > +             reg &= ~(PCIE_CAP_TARGET_LINK_SPEED_MASK);
> > +             reg |= PCIE_CAP_TARGET_LINK_SPEED(pcie->max_link_speed);
> > +             dw_pcie_writel_dbi(pcie, CAP_LINK_CONTROL2_LINK_STATUS2, reg);
> > +
> > +             if (is_s32g_pcie_ltssm_enabled(s32g_pp)) {
> > +                     ret = read_poll_timeout(dw_pcie_readl_dbi, tmp,
> > +                                             !(tmp & PCIE_CAP_LINK_TRAINING),
> > +                                             PCIE_LINK_WAIT_US, PCIE_LINK_TIMEOUT_US, 0,
> > +                                             pcie, PCIE_CTRL_LINK_STATUS);
> > +                     if (ret)
> > +                             dev_warn(s32g_pp->pcie.dev,
> > +                                      "Failed to finalize link training\n");
> > +
> > +                     reg = dw_pcie_readl_dbi(pcie, PCIE_CTRL_LINK_STATUS);
> > +                     reg |= PCIE_CAP_RETRAIN_LINK;
> > +                     dw_pcie_writel_dbi(pcie, PCIE_CTRL_LINK_STATUS, reg);
> > +             }
> > +     }
> > +
> > +     /* Start LTSSM. */
> > +     s32g_pcie_enable_ltssm(s32g_pp);
> > +
> > +     return 0;
> > +}
> > +
> > +static void s32g_pcie_stop_link(struct dw_pcie *pcie)
> > +{
> > +     struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pcie);
> > +
> > +     s32g_pcie_disable_ltssm(s32g_pp);
> > +}
> > +
> > +struct dw_pcie_ops s32g_pcie_ops = {
> > +     .link_up = s32g_pcie_link_is_up,
> > +     .start_link = s32g_pcie_start_link,
> > +     .stop_link = s32g_pcie_stop_link,
> > +};
> > +
> > +static struct dw_pcie_host_ops s32g_pcie_host_ops;
>
> Probably should be const.  I guess you don't need anything filled in?

Yes, we don't need anything.
Will make it const

> That would be unusual, but there are a couple drivers like that
> (amd_mdb_pcie_host_ops, dw_plat_pcie_host_ops, keembay_pcie_host_ops).
>
> > +static void s32g_pcie_set_phy_mode(struct s32g_pcie *s32g_pp)
> > +{
> > +     struct dw_pcie *pcie = &s32g_pp->pcie;
> > +     struct device *dev = pcie->dev;
> > +     struct device_node *np = dev->of_node;
> > +     const char *pcie_phy_mode = NULL;
> > +     int ret;
> > +
> > +     ret = of_property_read_string(np, "nxp,phy-mode", &pcie_phy_mode);
> > +     if (ret || !pcie_phy_mode) {
> > +             dev_info(dev, "Missing 'nxp,phy-mode' property, using default CRNS\n");
> > +             s32g_pp->phy_mode = CRNS;
> > +     } else if (!strcmp(pcie_phy_mode, "crns")) {
> > +             s32g_pp->phy_mode = CRNS;
> > +     } else if (!strcmp(pcie_phy_mode, "crss")) {
> > +             s32g_pp->phy_mode = CRSS;
> > +     } else if (!strcmp(pcie_phy_mode, "srns")) {
> > +             s32g_pp->phy_mode = SRNS;
> > +     } else if (!strcmp(pcie_phy_mode, "sris")) {
> > +             s32g_pp->phy_mode = SRIS;
> > +     } else {
> > +             dev_warn(dev, "Unsupported 'nxp,phy-mode' specified, using default CRNS\n");
> > +             s32g_pp->phy_mode = CRNS;
> > +     }
> > +}
> > +
> > +static void disable_equalization(struct dw_pcie *pcie)
> > +{
> > +     u32 val;
> > +
> > +     val = dw_pcie_readl_dbi(pcie, GEN3_EQ_CONTROL_OFF);
> > +     val &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
> > +              GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
> > +     val |= FIELD_PREP(GEN3_EQ_CONTROL_OFF_FB_MODE, 1) |
> > +            FIELD_PREP(GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC, 0x84);
> > +     dw_pcie_dbi_ro_wr_en(pcie);
> > +     dw_pcie_writel_dbi(pcie, GEN3_EQ_CONTROL_OFF, val);
> > +     dw_pcie_dbi_ro_wr_dis(pcie);
> > +}
> > +
> > +static void s32g_pcie_reset_mstr_ace(struct dw_pcie *pcie, u64 ddr_base_addr)
> > +{
> > +     u32 ddr_base_low = lower_32_bits(ddr_base_addr);
> > +     u32 ddr_base_high = upper_32_bits(ddr_base_addr);
> > +
> > +     dw_pcie_dbi_ro_wr_en(pcie);
> > +     dw_pcie_writel_dbi(pcie, PORT_LOGIC_COHERENCY_CONTROL_3, 0x0);
>
> Add blank line here before comment and use conventional comment style
> (first line is "/*" only).

It's a mistake, i will fix it

>
> > +     /* Transactions to peripheral targets should be non-coherent,
> > +      * or Ncore might drop them. Define the start of DDR as seen by Linux
> > +      * as the boundary between "memory" and "peripherals", with peripherals
> > +      * being below this boundary, and memory addresses being above it.
> > +      * One example where this is needed are PCIe MSIs, which use NoSnoop=0
> > +      * and might end up routed to Ncore.
> > +      */
> > +     dw_pcie_writel_dbi(pcie, PORT_LOGIC_COHERENCY_CONTROL_1,
> > +                        (ddr_base_low & CC_1_MEMTYPE_BOUNDARY_MASK) |
> > +                        (CC_1_MEMTYPE_LOWER_PERIPH & CC_1_MEMTYPE_VALUE));
> > +     dw_pcie_writel_dbi(pcie, PORT_LOGIC_COHERENCY_CONTROL_2, ddr_base_high);
> > +     dw_pcie_dbi_ro_wr_dis(pcie);
> > +}
> > +
> > +static int init_pcie(struct s32g_pcie *s32g_pp)
> > +{
> > +     struct dw_pcie *pcie = &s32g_pp->pcie;
> > +     u32 val;
> > +
> > +     val = s32g_pcie_readl_ctrl(s32g_pp, PE0_GEN_CTRL_1);
> > +     val &= ~SS_DEVICE_TYPE_MASK;
> > +
> > +     if (is_s32g_pcie_rc(s32g_pp->mode))
> > +             val |= SS_DEVICE_TYPE(PCIE_RC_VAL);
> > +     else
> > +             val |= SS_DEVICE_TYPE(PCIE_EP_VAL);
> > +
> > +     if (s32g_pp->phy_mode == SRIS)
> > +             val |= SRIS_MODE_EN;
> > +     else
> > +             val &= ~SRIS_MODE_EN;
> > +
> > +     s32g_pcie_writel_ctrl(s32g_pp, PE0_GEN_CTRL_1, val);
> > +
> > +     /* Disable phase 2,3 equalization */
> > +     disable_equalization(pcie);
> > +
> > +     /* Make sure DBI registers are R/W - see dw_pcie_setup_rc */
> > +     dw_pcie_dbi_ro_wr_en(pcie);
> > +     dw_pcie_setup(pcie);
> > +     dw_pcie_dbi_ro_wr_dis(pcie);
> > +
> > +     /* Make sure we use the coherency defaults (just in case the settings
> > +      * have been changed from their reset values
> > +      */
> > +     s32g_pcie_reset_mstr_ace(pcie, s32g_pp->coherency_base);
> > +
> > +     val = dw_pcie_readl_dbi(pcie, PCIE_PORT_FORCE);
> > +     val |= PORT_FORCE_DO_DESKEW_FOR_SRIS;
> > +     dw_pcie_dbi_ro_wr_en(pcie);
> > +     dw_pcie_writel_dbi(pcie, PCIE_PORT_FORCE, val);
> > +
> > +     if (is_s32g_pcie_rc(s32g_pp->mode)) {
> > +             /* Set max payload supported, 256 bytes and
> > +              * relaxed ordering.
> > +              */
> > +             val = dw_pcie_readl_dbi(pcie, CAP_DEVICE_CONTROL_DEVICE_STATUS);
> > +             val &= ~(CAP_EN_REL_ORDER |
> > +                      CAP_MAX_PAYLOAD_SIZE_CS_MASK |
> > +                      CAP_MAX_READ_REQ_SIZE_MASK);
> > +             val |= CAP_EN_REL_ORDER |
> > +                    CAP_MAX_PAYLOAD_SIZE_CS(1) |
> > +                    CAP_MAX_READ_REQ_SIZE(1);
> > +             dw_pcie_writel_dbi(pcie, CAP_DEVICE_CONTROL_DEVICE_STATUS, val);
> > +
> > +             /* Enable the IO space, Memory space, Bus master,
> > +              * Parity error, Serr and disable INTx generation
> > +              */
> > +             dw_pcie_writel_dbi(pcie, PCI_COMMAND,
> > +                                PCI_COMMAND_SERR | PCI_COMMAND_PARITY |
> > +                                PCI_COMMAND_INTX_DISABLE | PCI_COMMAND_IO |
> > +                                PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
> > +
> > +             /* Enable errors */
> > +             val = dw_pcie_readl_dbi(pcie, CAP_DEVICE_CONTROL_DEVICE_STATUS);
> > +             val |= CAP_CORR_ERR_REPORT_EN |
> > +                    CAP_NON_FATAL_ERR_REPORT_EN |
> > +                    CAP_FATAL_ERR_REPORT_EN |
> > +                    CAP_UNSUPPORT_REQ_REP_EN;
> > +             dw_pcie_writel_dbi(pcie, CAP_DEVICE_CONTROL_DEVICE_STATUS, val);
> > +     }
> > +
> > +     val = dw_pcie_readl_dbi(pcie, GEN3_RELATED_OFF);
> > +     val |= PCIE_EQ_PHASE_2_3;
> > +     dw_pcie_writel_dbi(pcie, GEN3_RELATED_OFF, val);
> > +
> > +     /* Disable writing dbi registers */
> > +     dw_pcie_dbi_ro_wr_dis(pcie);
> > +
> > +     s32g_pcie_enable_ltssm(s32g_pp);
> > +
> > +     return 0;
> > +}
> > +
> > +static int init_pcie_phy(struct s32g_pcie *s32g_pp)
> > +{
> > +     struct dw_pcie *pcie = &s32g_pp->pcie;
> > +     struct device *dev = pcie->dev;
> > +     int ret;
> > +
> > +     ret = phy_init(s32g_pp->phy);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to init serdes PHY\n");
> > +             return ret;
> > +     }
> > +
> > +     ret = phy_set_mode_ext(s32g_pp->phy, PHY_MODE_PCIE,
> > +                            s32g_pp->phy_mode);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to set mode on serdes PHY\n");
> > +             goto err_phy_exit;
> > +     }
> > +
> > +     ret = phy_power_on(s32g_pp->phy);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to power on serdes PHY\n");
> > +             goto err_phy_exit;
> > +     }
> > +
> > +     return 0;
> > +
> > +err_phy_exit:
> > +     phy_exit(s32g_pp->phy);
> > +     return ret;
> > +}
> > +
> > +static int deinit_pcie_phy(struct s32g_pcie *s32g_pp)
> > +{
> > +     struct dw_pcie *pcie = &s32g_pp->pcie;
> > +     struct device *dev = pcie->dev;
> > +     int ret;
> > +
> > +     if (s32g_pp->phy) {
> > +             ret = phy_power_off(s32g_pp->phy);
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to power off serdes PHY\n");
> > +                     return ret;
> > +             }
> > +
> > +             ret = phy_exit(s32g_pp->phy);
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to exit serdes PHY\n");
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int wait_phy_data_link(struct s32g_pcie *s32g_pp)
> > +{
> > +     bool has_link;
> > +     int ret;
> > +
> > +     ret = read_poll_timeout(has_data_phy_link, has_link, has_link,
> > +                             PCIE_LINK_WAIT_US, PCIE_LINK_TIMEOUT_US, 0, s32g_pp);
> > +     if (ret)
> > +             dev_info(s32g_pp->pcie.dev, "Failed to stabilize PHY link\n");
> > +
> > +     return ret;
> > +}
> > +
> > +static void s32g_pcie_downstream_dev_to_D0(struct s32g_pcie *s32g_pp)
> > +{
> > +     struct dw_pcie *pcie = &s32g_pp->pcie;
> > +     struct dw_pcie_rp *pp = &pcie->pp;
> > +     struct pci_bus *root_bus = NULL;
> > +     struct pci_dev *pdev;
> > +
> > +     /* Check if we did manage to initialize the host */
> > +     if (!pp->bridge || !pp->bridge->bus)
> > +             return;
> > +
> > +     /*
> > +      * link doesn't go into L2 state with some of the EndPoints
> > +      * if they are not in D0 state. So, we need to make sure that immediate
> > +      * downstream devices are in D0 state before sending PME_TurnOff to put
> > +      * link into L2 state.
>
> s/EndPoint/Endpoint/ to match PCIe spec usage.  More cases below.
>
> Wrap comments to fill 78 columns.

Ok

>
> I'm doubtful about the need for this function since most drivers don't
> do this.

I will double check

>
> > +      */
> > +
> > +     root_bus = s32g_get_child_downstream_bus(pp->bridge->bus);
> > +     if (IS_ERR(root_bus)) {
> > +             dev_err(pcie->dev, "Failed to find downstream devices\n");
> > +             return;
> > +     }
> > +
> > +     list_for_each_entry(pdev, &root_bus->devices, bus_list) {
> > +             if (PCI_SLOT(pdev->devfn) == 0) {
> > +                     if (pci_set_power_state(pdev, PCI_D0))
> > +                             dev_err(pcie->dev,
> > +                                     "Failed to transition %s to D0 state\n",
> > +                                     dev_name(&pdev->dev));
> > +             }
> > +     }
> > +}
> > +
> > +static u64 s32g_get_coherency_boundary(struct device *dev)
> > +{
> > +     struct device_node *np;
> > +     struct resource res;
> > +
> > +     np = of_find_node_by_type(NULL, "memory");
> > +
> > +     if (of_address_to_resource(np, 0, &res)) {
> > +             dev_warn(dev, "Fail to get coherency boundary\n");
> > +             return 0;
> > +     }
> > +
> > +     return res.start;
> > +}
> > +
> > +static int s32g_pcie_init_common(struct platform_device *pdev,
> > +                              struct s32g_pcie *s32g_pp,
> > +                              const struct s32g_pcie_data *data)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct dw_pcie *pcie = &s32g_pp->pcie;
> > +     struct phy *phy;
> > +
> > +     pcie->dev = dev;
> > +     pcie->ops = &s32g_pcie_ops;
> > +
> > +     s32g_pp->mode = data->mode;
> > +
> > +     platform_set_drvdata(pdev, s32g_pp);
> > +
> > +     phy = devm_phy_get(dev, NULL);
> > +     if (IS_ERR(phy))
> > +             return dev_err_probe(dev, PTR_ERR(phy),
> > +                             "Failed to get serdes PHY\n");
> > +     s32g_pp->phy = phy;
> > +
> > +     s32g_pcie_set_phy_mode(s32g_pp);
> > +
> > +     pcie->dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");
> > +     if (IS_ERR(pcie->dbi_base))
> > +             return PTR_ERR(pcie->dbi_base);
> > +
> > +     pcie->dbi_base2 = devm_platform_ioremap_resource_byname(pdev, "dbi2");
> > +     if (IS_ERR(pcie->dbi_base2))
> > +             return PTR_ERR(pcie->dbi_base2);
> > +
> > +     pcie->atu_base = devm_platform_ioremap_resource_byname(pdev, "atu");
> > +     if (IS_ERR(pcie->atu_base))
> > +             return PTR_ERR(pcie->atu_base);
> > +
> > +     s32g_pp->ctrl_base = devm_platform_ioremap_resource_byname(pdev, "ctrl");
> > +     if (IS_ERR(s32g_pp->ctrl_base))
> > +             return PTR_ERR(s32g_pp->ctrl_base);
> > +
> > +     s32g_pp->coherency_base = s32g_get_coherency_boundary(dev);
> > +
> > +     return 0;
> > +}
> > +
> > +static int s32g_pcie_init_host(struct platform_device *pdev,
> > +                            struct s32g_pcie *s32g_pp)
> > +{
> > +     struct dw_pcie *pcie = &s32g_pp->pcie;
> > +     struct dw_pcie_rp *pp = &pcie->pp;
> > +
> > +     /* Set dw host ops */
> > +     pp->ops = &s32g_pcie_host_ops;
>
> Seems overkill to make this a separate function.  Most do it in
> *_add_pcie_port() or *_pcie_probe():

The function will be filled with additional features later but I agree
it's overkill for now

>
>   git grep -p "pp->ops =" drivers/pci/controller/
>
> Follow the structure and function names of other drivers whenever
> possible.

I will have a look

>
> > +     return 0;
> > +}
> > +
> > +static int s32g_pcie_config_common(struct device *dev,
> > +                                struct s32g_pcie *s32g_pp)
> > +{
> > +     int ret = 0;
>
> Unnecessary init.

yes
>
> > +     s32g_pcie_disable_ltssm(s32g_pp);
> > +
> > +     ret = init_pcie_phy(s32g_pp);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = init_pcie(s32g_pp);
> > +     if (ret)
> > +             goto err_deinit_phy;
> > +
> > +     return 0;
> > +
> > +err_deinit_phy:
> > +     deinit_pcie_phy(s32g_pp);
> > +     return ret;
> > +}
> > +
> > +static void s32g_pcie_deconfig_common(struct s32g_pcie *s32g_pp)
> > +{
> > +     s32g_pcie_disable_ltssm(s32g_pp);
> > +     deinit_pcie_phy(s32g_pp);
> > +}
> > +
> > +static int s32g_pcie_config_host(struct device *dev,
> > +                              struct s32g_pcie *s32g_pp)
> > +{
> > +     struct dw_pcie *pcie = &s32g_pp->pcie;
>
> Typical struct dw_pcie * variable name is "pci".
>
> > +     struct dw_pcie_rp *pp = &pcie->pp;
> > +     int ret = 0;
>
> Pointless init.

yes

>
> > +     ret = wait_phy_data_link(s32g_pp);
> > +     if ((ret) && (!phy_validate(s32g_pp->phy, PHY_MODE_PCIE, 0, NULL))) {
> > +             dev_err(pcie->dev, "Failed to get link up with EP connected\n");
> > +             goto err_host_deinit;
> > +     }
> > +
> > +     ret = dw_pcie_host_init(pp);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to initialize host\n");
> > +             goto err_host_deinit;
> > +     }
> > +
> > +     return 0;
> > +
> > +err_host_deinit:
> > +     dw_pcie_host_deinit(pp);
> > +     return ret;
> > +}
> > +
> > +static int s32g_pcie_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct s32g_pcie *s32g_pp;
>
> Typical driver struct pointers are named "pcie".

Ok

>
> > +     const struct s32g_pcie_data *data;
> > +     int ret = 0;
>
> Pointless init.
>
> > +     data = of_device_get_match_data(dev);
> > +     if (!data)
> > +             return -EINVAL;
> > +
> > +     s32g_pp = devm_kzalloc(dev, sizeof(*s32g_pp), GFP_KERNEL);
> > +     if (!s32g_pp)
> > +             return -ENOMEM;
> > +
> > +     ret = s32g_pcie_init_common(pdev, s32g_pp, data);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = s32g_pcie_init_host(pdev, s32g_pp);
> > +     if (ret)
> > +             return ret;
> > +
> > +     pm_runtime_enable(dev);
> > +     ret = pm_runtime_get_sync(dev);
> > +     if (ret < 0)
> > +             goto err_pm_runtime_put;
> > +
> > +     ret = s32g_pcie_config_common(dev, s32g_pp);
> > +     if (ret)
> > +             goto err_pm_runtime_put;
> > +
> > +     ret = s32g_pcie_config_host(dev, s32g_pp);
> > +     if (ret)
> > +             goto err_deinit_controller;
> > +
> > +     return 0;
> > +
> > +err_deinit_controller:
> > +     s32g_pcie_deconfig_common(s32g_pp);
> > +err_pm_runtime_put:
> > +     pm_runtime_put(dev);
> > +     pm_runtime_disable(dev);
> > +
> > +     return ret;
> > +}
> > +
> > +static void s32g_pcie_shutdown(struct platform_device *pdev)
> > +{
> > +     pm_runtime_put(&pdev->dev);
> > +     pm_runtime_disable(&pdev->dev);
> > +}
> > +
> > +static int s32g_pcie_suspend(struct device *dev)
> > +{
> > +     struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
> > +     struct dw_pcie *pcie = &s32g_pp->pcie;
> > +     struct dw_pcie_rp *pp = &pcie->pp;
> > +     struct pci_bus *bus, *root_bus;
> > +
> > +     /* Save MSI interrupt vector */
> > +     s32g_pp->msi_ctrl_int = dw_pcie_readl_dbi(pcie,
> > +                                               PCIE_MSI_INTR0_ENABLE);
> > +
> > +     if (is_s32g_pcie_rc(s32g_pp->mode)) {
> > +             s32g_pcie_downstream_dev_to_D0(s32g_pp);
> > +
> > +             bus = pp->bridge->bus;
> > +             root_bus = s32g_get_child_downstream_bus(bus);
> > +             if (!IS_ERR(root_bus))
> > +                     pci_walk_bus(root_bus, pci_dev_set_disconnected, NULL);
> > +
> > +             pci_stop_root_bus(bus);
> > +             pci_remove_root_bus(bus);
> > +     }
> > +
> > +     s32g_pcie_deconfig_common(s32g_pp);
> > +
> > +     return 0;
> > +}
> > +
> > +static int s32g_pcie_resume(struct device *dev)
> > +{
> > +     struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
> > +     struct dw_pcie *pcie = &s32g_pp->pcie;
> > +     struct dw_pcie_rp *pp = &pcie->pp;
> > +     int ret = 0;
> > +
> > +     ret = s32g_pcie_config_common(dev, s32g_pp);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (is_s32g_pcie_rc(s32g_pp->mode)) {
> > +             ret = dw_pcie_setup_rc(pp);
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to resume DW RC: %d\n", ret);
> > +                     goto fail_host_init;
> > +             }
> > +
> > +             ret = dw_pcie_start_link(pcie);
> > +             if (ret) {
> > +                     /* We do not exit with error if link up was unsuccessful
> > +                      * EndPoint may not be connected.
> > +                      */
> > +                     if (dw_pcie_wait_for_link(pcie))
> > +                             dev_warn(pcie->dev,
> > +                                      "Link Up failed, EndPoint may not be connected\n");
> > +
> > +                     if (!phy_validate(s32g_pp->phy, PHY_MODE_PCIE, 0, NULL)) {
> > +                             dev_err(dev, "Failed to get link up with EP connected\n");
> > +                             goto fail_host_init;
> > +                     }
> > +             }
> > +
> > +             ret = pci_host_probe(pp->bridge);
> > +             if (ret)
> > +                     goto fail_host_init;
> > +     }
> > +
> > +     /* Restore MSI interrupt vector */
> > +     dw_pcie_writel_dbi(pcie, PCIE_MSI_INTR0_ENABLE,
> > +                        s32g_pp->msi_ctrl_int);
> > +
> > +     return 0;
> > +
> > +fail_host_init:
> > +     s32g_pcie_deconfig_common(s32g_pp);
> > +     return ret;
> > +}
> > +
> > +static const struct dev_pm_ops s32g_pcie_pm_ops = {
> > +     SYSTEM_SLEEP_PM_OPS(s32g_pcie_suspend,
> > +                         s32g_pcie_resume)
> > +};
> > +
> > +static const struct s32g_pcie_data rc_of_data = {
> > +     .mode = DW_PCIE_RC_TYPE,
> > +};
>
> Looks like you don't need this yet, since you only support RC mode.
> Don't add data structures or code that isn't exercised yet.

Ok, will add it with EP support


>
> > +static const struct of_device_id s32g_pcie_of_match[] = {
> > +     { .compatible = "nxp,s32g2-pcie", .data = &rc_of_data },
> > +     { /* sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, s32g_pcie_of_match);
> > +
> > +static struct platform_driver s32g_pcie_driver = {
> > +     .driver = {
> > +             .name   = "s32g-pcie",
> > +             .owner  = THIS_MODULE,
> > +             .of_match_table = s32g_pcie_of_match,
> > +             .pm = pm_sleep_ptr(&s32g_pcie_pm_ops),
> > +     },
> > +     .probe = s32g_pcie_probe,
> > +     .shutdown = s32g_pcie_shutdown,
> > +};
> > +
> > +module_platform_driver(s32g_pcie_driver);
> > +
> > +MODULE_AUTHOR("Ionut Vicovan <Ionut.Vicovan@nxp.com>");
> > +MODULE_DESCRIPTION("NXP S32G PCIe Host controller driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/pci/controller/dwc/pci-s32g.h b/drivers/pci/controller/dwc/pci-s32g.h
> > new file mode 100644
> > index 000000000000..cdd0c635cc72
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pci-s32g.h
> > @@ -0,0 +1,45 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * PCIe host controller driver for NXP S32G SoCs
> > + *
> > + * Copyright 2019-2025 NXP
> > + */
> > +
> > +#ifndef PCIE_S32G_H
> > +#define PCIE_S32G_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/pcie/nxp-s32g-pcie-phy-submode.h>
> > +
> > +#define to_s32g_from_dw_pcie(x) \
> > +     container_of(x, struct s32g_pcie, pcie)
> > +
> > +struct s32g_pcie_data {
> > +     enum dw_pcie_device_mode mode;
> > +};
> > +
> > +struct s32g_pcie {
> > +     struct dw_pcie  pcie;
> > +
> > +     u32 msi_ctrl_int;
> > +
> > +     /* we have cfg in struct dw_pcie_rp and
> > +      * dbi in struct dw_pcie, so define only ctrl here
> > +      */
> > +     void __iomem *ctrl_base;
> > +     u64 coherency_base;
> > +
> > +     enum dw_pcie_device_mode mode;
> > +
> > +     enum pcie_phy_mode phy_mode;
> > +
> > +     struct phy *phy;
> > +};
> > +
> > +static inline
> > +bool is_s32g_pcie_rc(enum dw_pcie_device_mode mode)
> > +{
> > +     return mode == DW_PCIE_RC_TYPE;
> > +}
> > +
> > +#endif       /*      PCIE_S32G_H     */
> > --
> > 2.43.0
> >

