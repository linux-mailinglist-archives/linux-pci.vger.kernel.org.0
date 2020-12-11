Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76B22D78E5
	for <lists+linux-pci@lfdr.de>; Fri, 11 Dec 2020 16:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437679AbgLKPOt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Dec 2020 10:14:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406587AbgLKPO1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Dec 2020 10:14:27 -0500
X-Gm-Message-State: AOAM532va+slDvlPco9ZGiVGdShZunt4Q5t+2MAH2OcyXQ7mXzM8JG8/
        I5UrwnH/6NPHBjjoAw2EhEMfjh5YqZAH7pnyhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607697477;
        bh=jt9yLQprthmgA87SH0GTsfqD4jh9KUz8rU6Ktkbeui4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QJXWZ+bzDXcOTwOKti4SmEtfg4AxJVL2/2jhyReZMJ90AaMwyA+bZQ5aEbWxS2c6+
         bxkAMioKk0dpBQY9r/DzOs8k7AjLuhIiMbCKXEKxzuTswd4l6yhZ2Zqr4oDCmFVGHu
         aV4u5HNoQU+flpF6B1MuErZNovOCO5S9ELSMoKCbuT0WnMjud2KrqfkystGdoWDyoj
         qs7ZfTPSFCTW7Ev7oyo9Kyr/QL5+Fb/Ew5PcKhUkaLZECBG//sgR1HnvJ2fxvRtVq/
         74wg7wNwv87nGmIYcy/7v2phRzoBrjrKBX7QzXyn8dv3FDBBHEO2QaEhlhXIi4MpQ/
         +hIoELE+9IaQQ==
X-Google-Smtp-Source: ABdhPJw8iipBBbQd2e3oqGYeXVXnVO2F+gVAD0RecKiPsdLSSdONJGBhs13TPI8RiV9nb+TDmZY20hsosqFWpVGhAE8=
X-Received: by 2002:a17:906:d87:: with SMTP id m7mr11190157eji.108.1607697471952;
 Fri, 11 Dec 2020 06:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20201211121507.28166-1-daniel.thompson@linaro.org>
In-Reply-To: <20201211121507.28166-1-daniel.thompson@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 11 Dec 2020 08:37:40 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKQxFvkFtph1BZD2LKdZjboxhMTWkZe_AWS-vMD9y0pMw@mail.gmail.com>
Message-ID: <CAL_JsqKQxFvkFtph1BZD2LKdZjboxhMTWkZe_AWS-vMD9y0pMw@mail.gmail.com>
Subject: Re: [RFC HACK PATCH] PCI: dwc: layerscape: Hack around enumeration
 problems with Honeycomb LX2K
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Nettleton <jon@solid-run.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linaro Patches <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 11, 2020 at 6:15 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> I have been chasing down a problem enumerating an NVMe drive on a
> Honeycomb LX2K (NXP LX2160A). Specifically the drive can only enumerate
> successfully if the we are emitting lots of console messages via a UART.
> If the system is booted with `quiet` set then enumeration fails.

We really need to get away from work-arounds for device X on host Y. I
suspect they are not limited to that combination only...

How exactly does it fail to enumerate? There's a (racy) linkup check
on config accesses, is it reporting link down and skipping config
accesses?

> I guessed this would be due to the timing impact of printk-to-UART and
> tried to find out where a delay could be added to provoke a successful
> enumeration.
>
> This patch contains the results. The delay length (1ms) was selected by
> binary searching downwards until the delay was not effective for these
> devices (Honeycomb LX2K and a Western Digital WD Blue SN550).
>
> I have also included the workaround twice (conditionally compiled). The
> first change is the *latest* possible code path that we can deploy a
> delay whilst the second is the earliest place I could find.
>
> The summary is that the critical window were we are currently relying on
> a call to the console UART code can "mend" the driver runs from calling
> dw_pcie_setup_rc() in host init to just before we read the state in the
> link up callback.
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>
> Notes:
>     This patch is RFC (and HACK) because I don't have much clue *why* this
>     patch works... merely that this is the smallest possible change I need
>     to replicate the current accidental printk() workaround.  Perhaps one
>     could argue that RFC here stands for request-for-clue.  All my
>     observations and changes here are empirical and I don't know how best to
>     turn them into something that is not a hack!
>
>     BTW I noticed many other pcie-designware drivers take advantage
>     of a function called dw_pcie_wait_for_link() in their init paths...
>     but my naive attempts to add it to the layerscape driver results
>     in non-booting systems so I haven't embarrassed myself by including
>     that in the patch!

You need to look at what's pending for v5.11, because I reworked this
to be more unified. The ordering of init is also possibly changed. The
sequence is now like this:

        dw_pcie_setup_rc(pp);
        dw_pcie_msi_init(pp);

        if (!dw_pcie_link_up(pci) && pci->ops->start_link) {
                ret = pci->ops->start_link(pci);
                if (ret)
                        goto err_free_msi;
        }

        /* Ignore errors, the link may come up later */
        dw_pcie_wait_for_link(pci);


>  drivers/pci/controller/dwc/pci-layerscape.c | 35 +++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index f24f79a70d9a..c354904b90ef 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -22,6 +22,8 @@
>
>  #include "pcie-designware.h"
>
> +#define WORKAROUND_LATEST_POSSIBLE
> +
>  /* PEX1/2 Misc Ports Status Register */
>  #define SCFG_PEXMSCPORTSR(pex_idx)     (0x94 + (pex_idx) * 4)
>  #define LTSSM_STATE_SHIFT      20
> @@ -113,10 +115,31 @@ static int ls_pcie_link_up(struct dw_pcie *pci)
>         struct ls_pcie *pcie = to_ls_pcie(pci);
>         u32 state;
>
> +       /*
> +        * Strictly speaking *this* (before the ioread32) is the latest
> +        * point a simple delay can be effective. If we move the delay
> +        * after the ioread32 then the NVMe does not enumerate.
> +        *
> +        * However this function appears to be frequently called so an
> +        * unconditional delay here causes noticeable delay at boot
> +        * time. Hence we implement the workaround by retrying the read
> +        * after a short delay if we think we might need to return false.
> +        */
> +
>         state = (ioread32(pcie->lut + pcie->drvdata->lut_dbg) >>
>                  pcie->drvdata->ltssm_shift) &
>                  LTSSM_STATE_MASK;
>
> +#ifdef WORKAROUND_LATEST_POSSIBLE
> +       if (state < LTSSM_PCIE_L0) {
> +               /* see comment above */
> +               mdelay(1);
> +               state = (ioread32(pcie->lut + pcie->drvdata->lut_dbg) >>
> +                        pcie->drvdata->ltssm_shift) &
> +                        LTSSM_STATE_MASK;

Side note, I really wonder about the variety of ways in DWC drivers we
have to check link state. The default is a debug register... Are the
standard PCIe registers for this really broken in these cases?

> +       }
> +#endif
> +
>         if (state < LTSSM_PCIE_L0)
>                 return 0;
>
> @@ -152,6 +175,18 @@ static int ls_pcie_host_init(struct pcie_port *pp)
>
>         dw_pcie_setup_rc(pp);

Might be related to the PORT_LOGIC_SPEED_CHANGE we do in here.

> +#ifdef WORKAROUND_EARLIEST_POSSIBLE
> +       /*
> +        * This is the earliest point the delay is effective.
> +        * If we move it before dw_pcie_setup_rc() then the
> +        * NVMe does not enumerate.
> +        *
> +        * 500us is too short to reliably work around the issue
> +        * hence adopting 1000us here.
> +        */
> +       mdelay(1);
> +#endif
> +
>         return 0;
>  }
>
>
> base-commit: 0477e92881850d44910a7e94fc2c46f96faa131f
> --
> 2.29.2
>
