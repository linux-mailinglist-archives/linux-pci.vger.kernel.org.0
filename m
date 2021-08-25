Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606203F77F7
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 17:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbhHYPEv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 11:04:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231995AbhHYPEu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Aug 2021 11:04:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A202861176;
        Wed, 25 Aug 2021 15:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629903844;
        bh=SQu8ZriBWtkrMhexm27oLfTLE3woK/0rAxCFoPeJSWs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IkW0uZDXe3xbv33KgBw8Bo8H2mB81KwIUiIRJgNP9/vTaKWXH2sxZJrN4+oO1nMxQ
         YplMbJk33i1nTVfjIzni2O6dVbOMkObGGFB8oEI0wE7XVQh5r1HHJ3fzyzv43b48E/
         s/1FBAQc2gRVVUILKtSOpR+AxQGCmSfQGqbQEK7NFCKk/cCWbKFIpsBozaZn81414n
         TeMharqkFIFQKYjkkMu62pMuUgOCwjxLCo4LgmfECxfA6LUVZ4THpARepXaPGu69tA
         Q2D/PyjaRO8x68LPnYZjWzI14snOQ+Z5kT2Vhrl2izpFPfCC5xTBHPj1SfSad++V6z
         //mmZeEZTboqg==
Received: by mail-ej1-f54.google.com with SMTP id t19so2195260ejr.8;
        Wed, 25 Aug 2021 08:04:04 -0700 (PDT)
X-Gm-Message-State: AOAM533wV9aUqc9RnGjHEAwSS4inPiKQ7udVtvieOX3gg8Ddgt7efDsF
        TNaC0qGAe21GvrwDDVS0Cx7hJG7aNrEUcgAxWw==
X-Google-Smtp-Source: ABdhPJxewKcJ+3Eb7Es36Smt8z5TpesvKwiuyO4A/wqa6BX0T3ZI8RR8aZzlwJux6eaj2JM70CZMGA4Mxv1AsLONrLQ=
X-Received: by 2002:a17:906:ff41:: with SMTP id zo1mr16030386ejb.525.1629903843136;
 Wed, 25 Aug 2021 08:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620203062.git.baruch@tkos.co.il> <e17461407cf4bb79fed5925ec81196a0b84e7827.1620203062.git.baruch@tkos.co.il>
 <CAL_JsqKOGo4eXKA7FZK7AQQ24MDDbg2-ngUQF9CJK=8eH_pxHQ@mail.gmail.com>
 <87o89lahqp.fsf@tarshish> <CAL_Jsq+wkTbGjyk_i-_1Sad80xcJwAFdf5gBTGBR_TORRA-AoQ@mail.gmail.com>
 <87lf4pa9i0.fsf@tarshish>
In-Reply-To: <87lf4pa9i0.fsf@tarshish>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 25 Aug 2021 10:03:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKLijW0H-f0Ptd3EKrE5mRwtQK5StOTzs3b5UesuuVKdg@mail.gmail.com>
Message-ID: <CAL_JsqKLijW0H-f0Ptd3EKrE5mRwtQK5StOTzs3b5UesuuVKdg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] PCI: qcom: add support for IPQ60xx PCIe controller
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 25, 2021 at 9:23 AM Baruch Siach <baruch@tkos.co.il> wrote:
>
> Hi Rob,
>
> On Wed, Aug 25 2021, Rob Herring wrote:
> > On Wed, Aug 25, 2021 at 6:25 AM Baruch Siach <baruch@tkos.co.il> wrote:
> >> On Fri, Aug 06 2021, Rob Herring wrote:
> >> > On Wed, May 5, 2021 at 3:18 AM Baruch Siach <baruch@tkos.co.il> wrote:
> >> >> +       writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
> >> >> +                       PCI_EXP_DEVCTL2);
> >> >> +
> >> >> +       writel(PCIE_CAP_CURR_DEEMPHASIS | SPEED_GEN3,
> >> >> +                       pci->dbi_base + offset + PCI_EXP_DEVCTL2);
> >> >
> >> > Doesn't this overwrite the prior register write?
> >>
> >> It does. There are two mistakes here. The writel() above should set
> >> PCIE20_DEVICE_CONTROL2_STATUS2 (offset 0x98).
> >
> > No. Did you check what 'offset' is? PCIE20_DEVICE_CONTROL2_STATUS2 is
> > PCI_EXP_DEVCTL2 plus the status reg. What's wrong is it should be a
> > 16-bit write.
>
> Thanks for enlightening me. 'offset' is 0x70 here. So PCI_EXP_DEVCTL2 is
> at 0x98, and PCI_EXP_LNKCTL2 is at 0xa0. Only the second writel() is
> wrong. But since generic code handles speed, I can drop it entirely.
>
> I see that dw_pcie_link_set_max_speed() uses dw_pcie_writel_dbi() to
> write to PCI_EXP_LNKCTL2. Is that 16-bit write?

No, that may be because some platforms can only do 32-bit accesses and
dw_pcie_writew_dbi would be a RMW in that case. Or maybe there's some
reliance on clearing the status register.

> Why are pci_regs.h register offsets in decimal?

No idea...

Rob
