Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05310504642
	for <lists+linux-pci@lfdr.de>; Sun, 17 Apr 2022 06:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbiDQETe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Apr 2022 00:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiDQETd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Apr 2022 00:19:33 -0400
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9489E186ED;
        Sat, 16 Apr 2022 21:16:59 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id b21so19758727lfb.5;
        Sat, 16 Apr 2022 21:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CW3A/aitUHfF5G3ViJWNE+t6LZ1tgXv7FWh03lEBllU=;
        b=EQXcsvxXAG4iJs6iTM60JTinlujWtHTw+eqvF4hVZrtz4Z62YMPkVoNOfuHy7YjJIq
         f00emz4csdwohzpEeEnQIQHmNHrauE1GkIgZh90dNf/EnCLgEbkMuevM+vNOVnatGoOD
         9dDLnOia36yWrc1UzFEZDelO2gocfp1NXrxD2QYEfeErLkURsMljYAtlTN5buKsDNEUa
         adbFk8vZxaT4MdxZE8DZ90U7YdDQK98Vd6F/eXxcT07ZTagPgpm1HEfEsXyvEGQz19Jb
         Mygf1UJFDO3d+3v8mo/jhEsnXsYZIw2RrAnec6yZI36LMeXOHxsXsQZeYWaJqejynm2v
         QAgA==
X-Gm-Message-State: AOAM530rt40W6grZnCnCwLsL9GB2k2Q2CL5PTj2+nNtVT7Aew5089wdl
        Q4nqc/yb+4ES4ptW/WDZmMJ6WCsI51dZO2ZG25iHiRJr
X-Google-Smtp-Source: ABdhPJyH2jlIt83huHMF+Z98TjJC15Gu6bL8/bkTHT7SCzAXDfJaeQOrjInn07SGUs+kqL2FLxp1LYJZRAG72OFw214=
X-Received: by 2002:a05:6512:1688:b0:464:f53f:850f with SMTP id
 bu8-20020a056512168800b00464f53f850fmr4121402lfb.637.1650169017848; Sat, 16
 Apr 2022 21:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190701134255.25959-1-stephend@silicom-usa.com>
In-Reply-To: <20190701134255.25959-1-stephend@silicom-usa.com>
From:   Len Brown <lenb@kernel.org>
Date:   Sun, 17 Apr 2022 00:16:46 -0400
Message-ID: <CAJvTdKn9MEQ9rTXyqxV-t-3FzY-YbL7RL+s1wvc9uyKbg3f5FA@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: prevent SKX boot failure when C6 & SERIRQ enabled
To:     Stephen Douthit <stephend@silicom-usa.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Stephen,

I noticed this patch languishing in patchwork.
I don't see any discussion on it, and it never went upstream.

Was this problem addressed in another way?

If no, and somebody is using this patch, I'm curious if it is really
CC6 that you want to disable, or perhaps disabling PC6 is sufficient?

thanks,
-Len

On Mon, Jul 1, 2019 at 9:43 AM Stephen Douthit <stephend@silicom-usa.com> wrote:
>
> Interrupts are getting misrouted and/or dropped on SKLYLAKE_X based D-2100s
> when C6 and SERIRQ are enabled.  I've only seen this issue on systems
> using SERIRQs (in my case for a LPC based UART providing the serial
> console for a headless server).
>
> One failure mode is "do_IRQ: 8.33 No irq handler for vector" getting
> printed in the kernel logs. The core getting the unhandled irq is typically
> the one handling the UART SERIRQ.  I've seen it on other cores, but I
> haven't confirmed if that's because the UART irq handler was moved to
> another core at some point.  The vector varies from 33-36, but it's most
> often 33.
>
> The other failure mode is the system hanging.  Sometimes forcing some non
> SERIRQ interrupt to fire (by plugging/unplugging a network/USB cable) can
> get the system out of this state.  Generating more SERIRQs via the UART
> will not unstick the system.
>
> Both failures seemed to occur when transition to a low load state, which
> is why I started playing around with power management options and found
> that booting with "intel_idle.max_cstate=2" fixed the issue.
>
> This patch only disables C6 if it's able to determine that SERIRQs are
> enabled by checking the enable bit in the LPC controllers PCI config space.
>
> Signed-off-by: Stephen Douthit <stephend@silicom-usa.com>
> ---
>  drivers/idle/intel_idle.c | 35 ++++++++++++++++++++++++++++++++++-
>  include/linux/pci_ids.h   |  1 +
>  2 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index b8647b5c3d4d..353f6a9b1818 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -61,12 +61,13 @@
>  #include <linux/notifier.h>
>  #include <linux/cpu.h>
>  #include <linux/moduleparam.h>
> +#include <linux/pci.h>
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>  #include <asm/mwait.h>
>  #include <asm/msr.h>
>
> -#define INTEL_IDLE_VERSION "0.4.1"
> +#define INTEL_IDLE_VERSION "0.4.2"
>
>  static struct cpuidle_driver intel_idle_driver = {
>         .name = "intel_idle",
> @@ -1306,6 +1307,35 @@ static void sklh_idle_state_table_update(void)
>         skl_cstates[5].disabled = 1;    /* C8-SKL */
>         skl_cstates[6].disabled = 1;    /* C9-SKL */
>  }
> +/*
> + * skx_idle_state_table_update()
> + *
> + * On SKX (model 0x55) SoCs disable C6 if SERIRQ is enabled
> + */
> +static void skx_idle_state_table_update(void)
> +{
> +#define SCNT_OFF 0x64
> +#define SCNT_EN (1 << 7)
> +       struct pci_dev *pdev = pci_get_device(PCI_VENDOR_ID_INTEL,
> +                                             PCI_DEVICE_ID_INTEL_SKX_LPC,
> +                                             NULL);
> +       u8 reg;
> +
> +       /*
> +        * Check bit 7 of the Serial IRQ Control (SCNT) register (0x64) in the
> +        * LPC controller.  If it's set serial IRQs are enabled, and we need to
> +        * disable C6 to prevent hangs.
> +        */
> +       if (!pdev)
> +               return;
> +       if (pci_read_config_byte(pdev, SCNT_OFF, &reg))
> +               return;
> +       if (!(reg & SCNT_EN))
> +               return;
> +
> +       pr_debug("SERIRQ enabled on SKX, disabling C6 to avoid hangs\n");
> +       skx_cstates[2].disabled = 1;    /* C6-SKX */
> +}
>  /*
>   * intel_idle_state_table_update()
>   *
> @@ -1326,6 +1356,9 @@ static void intel_idle_state_table_update(void)
>         case INTEL_FAM6_SKYLAKE_DESKTOP:
>                 sklh_idle_state_table_update();
>                 break;
> +       case INTEL_FAM6_SKYLAKE_X:
> +               skx_idle_state_table_update();
> +               break;
>         }
>  }
>
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 70e86148cb1e..02bac8de03fd 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2997,6 +2997,7 @@
>  #define PCI_DEVICE_ID_INTEL_84460GX    0x84ea
>  #define PCI_DEVICE_ID_INTEL_IXP4XX     0x8500
>  #define PCI_DEVICE_ID_INTEL_IXP2800    0x9004
> +#define PCI_DEVICE_ID_INTEL_SKX_LPC    0xa1c8
>  #define PCI_DEVICE_ID_INTEL_S21152BB   0xb152
>
>  #define PCI_VENDOR_ID_SCALEMP          0x8686
> --
> 2.21.0
>


-- 
Len Brown, Intel Open Source Technology Center
