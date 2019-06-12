Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B228A41A57
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 04:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408419AbfFLCXc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jun 2019 22:23:32 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50485 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408418AbfFLCXc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jun 2019 22:23:32 -0400
Received: by mail-it1-f195.google.com with SMTP id j194so8376521ite.0;
        Tue, 11 Jun 2019 19:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z4yiZSQ99ENhZHrlff4q5E1G1jFsIl+eTmojhdm+HwU=;
        b=V8reibrhUHw2gShqHRDeccOb27V+px/0LSyyh6pXic42k9lka9mR5WTZxN1laDtfwU
         ipiIxqbrlvzwVsaBcbsEkRLFC78otUYZpmUubFnwW+YGcNogMK9lUVIZ1ts2uleI+6s9
         4EqAQmUXst9DUl2MkB9FT0yry0GNJfH4iXwICAnGPhTNqaj3nvtU/1DOBJIN+jKsLqVf
         awye1V2XPhvMBZPEQ3ZLRHVZDjCQ07FO9Tm1ceQNaC6IMvvNG7i9BSmEZ4haEfTpL0Mk
         N1lin4CTKuO+eugkrbWTZa/W4l5mC5uteY6X6247c3ND0xr8QTz4yTJ8+Id9q1nJTsaW
         MmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z4yiZSQ99ENhZHrlff4q5E1G1jFsIl+eTmojhdm+HwU=;
        b=rjVoZULGSfLEXYwxvcFQPmCv4M6zVLOj1a9N8hXFGmVF+i9R6z2L0eG9iAyHVOcAxE
         714eh5HLN+izHugu7EeTTVwzrEkhIaAIfpxMfoDrWBwwrgxh3+GjKiC343Ds7SWke1O8
         J/mMJumSHasO83fRCfJPkj0RyrdsKwuUfyDWPoZNav4PQ+mQqwu0l3doEIZ0AliDsqjo
         iF8nZbIDyEAuJnC1eKsqD64kS2GePhazy8n3IepYIl+GNfP7DFjrO+sZ+FhlwrgWhPh0
         EBgX7f0OAmJ/kYncrtmdK32r9cAd3Yk1BxA4sJqbasXd5M63vNppzF4b4aahm1HfjiMj
         2Dkw==
X-Gm-Message-State: APjAAAVlZ82yaXpZzhP5ZOpgumMOlxSoEdCmETF/MRoR8EPbtDAU0YbT
        LJe5LNHPnsNSQ01AonoSP/Lx9Cd9ebR2hHaU3Fk=
X-Google-Smtp-Source: APXvYqyV4Sr25JrYbJwzOp4KFbOubjnYsVo20OwRqvZS2jJQa/X2VrstTy079fHHhQkT9wlQN+DhbGBbRqPWpwO7Rn0=
X-Received: by 2002:a05:660c:101:: with SMTP id w1mr3410942itj.49.1560306211305;
 Tue, 11 Jun 2019 19:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <1558678046-4052-1-git-send-email-ley.foon.tan@intel.com>
 <1558678046-4052-2-git-send-email-ley.foon.tan@intel.com> <20190530152548.GD13993@redmoon>
In-Reply-To: <20190530152548.GD13993@redmoon>
From:   Ley Foon Tan <lftan.linux@gmail.com>
Date:   Wed, 12 Jun 2019 10:23:20 +0800
Message-ID: <CAFiDJ59Oa0_frzTYUfLdU-PfHRPGOHoYmBxRpS0ynue8e+21mg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: altera: Fix configuration type based on
 secondary number
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Ley Foon Tan <ley.foon.tan@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 30, 2019 at 11:25 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, May 24, 2019 at 02:07:25PM +0800, Ley Foon Tan wrote:
> > This fix issue when access config from PCIe switch.
> >
> > Stratix 10 PCIe controller does not support Type 1 to Type 0 conversion
> > as previous version (V1) does.
> >
> > The PCIe controller need to send Type 0 config TLP if the targeting bus
> > matches with the secondary bus number, which is when the TLP is targeting
> > the immediate device on the link.
> >
> > The PCIe controller send Type 1 config TLP if the targeting bus is
> > larger than the secondary bus, which is when the TLP is targeting the
> > device not immediate on the link.
> >
> > Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
> > ---
> >  drivers/pci/controller/pcie-altera.c | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
> > index 27222071ace7..047bcc214f9b 100644
> > --- a/drivers/pci/controller/pcie-altera.c
> > +++ b/drivers/pci/controller/pcie-altera.c
> > @@ -44,6 +44,8 @@
> >  #define S10_RP_RXCPL_STATUS          0x200C
> >  #define S10_RP_CFG_ADDR(pcie, reg)   \
> >       (((pcie)->hip_base) + (reg) + (1 << 20))
> > +#define S10_RP_SECONDARY(pcie)               \
> > +     readb(S10_RP_CFG_ADDR(pcie, PCI_SECONDARY_BUS))
> >
> >  /* TLP configuration type 0 and 1 */
> >  #define TLP_FMTTYPE_CFGRD0           0x04    /* Configuration Read Type 0 */
> > @@ -63,6 +65,14 @@
> >       ((((bus == pcie->root_bus_nr) ? pcie->pcie_data->cfgwr0         \
> >                               : pcie->pcie_data->cfgwr1) << 24) |     \
> >                               TLP_PAYLOAD_SIZE)
> > +#define S10_TLP_CFGRD_DW0(pcie, bus)                                 \
> > +     (((((bus) > S10_RP_SECONDARY(pcie)) ? pcie->pcie_data->cfgrd0   \
> > +                             : pcie->pcie_data->cfgrd1) << 24) |     \
> > +                             TLP_PAYLOAD_SIZE)
> > +#define S10_TLP_CFGWR_DW0(pcie, bus)                                 \
> > +     (((((bus) > S10_RP_SECONDARY(pcie)) ? pcie->pcie_data->cfgwr0   \
> > +                             : pcie->pcie_data->cfgwr1) << 24) |     \
> > +                             TLP_PAYLOAD_SIZE)
> >  #define TLP_CFG_DW1(pcie, tag, be)   \
> >       (((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag << 8) | (be))
> >  #define TLP_CFG_DW2(bus, devfn, offset)      \
> > @@ -327,7 +337,11 @@ static int tlp_cfg_dword_read(struct altera_pcie *pcie, u8 bus, u32 devfn,
> >  {
> >       u32 headers[TLP_HDR_SIZE];
> >
> > -     headers[0] = TLP_CFGRD_DW0(pcie, bus);
> > +     if (pcie->pcie_data->version == ALTERA_PCIE_V1)
> > +             headers[0] = TLP_CFGRD_DW0(pcie, bus);
> > +     else
> > +             headers[0] = S10_TLP_CFGRD_DW0(pcie, bus);
> > +
> >       headers[1] = TLP_CFG_DW1(pcie, TLP_READ_TAG, byte_en);
> >       headers[2] = TLP_CFG_DW2(bus, devfn, where);
> >
> > @@ -342,7 +356,11 @@ static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
> >       u32 headers[TLP_HDR_SIZE];
> >       int ret;
> >
> > -     headers[0] = TLP_CFGWR_DW0(pcie, bus);
> > +     if (pcie->pcie_data->version == ALTERA_PCIE_V1)
> > +             headers[0] = TLP_CFGWR_DW0(pcie, bus);
> > +     else
> > +             headers[0] = S10_TLP_CFGWR_DW0(pcie, bus);
> > +
>
> Why don't you rewrite all these macros as an eg:
>
> static inline u32 get_tlp_header()
> {}
>
> where you can also handle the version and everything needed to
> detect what header should be set-up ?
>
Okay, will change this.

Thanks.

Regards
Ley Foon
