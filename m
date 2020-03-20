Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F205718D18A
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 15:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgCTOwu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 10:52:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40018 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCTOwt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 10:52:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so2578320plk.7;
        Fri, 20 Mar 2020 07:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3oEaq4RbS2pIFT8sPysCqAhlN3jcufDI+zt2Oe41Lro=;
        b=P8SvnsENfuOknSqZmMvi/roCMBcb8J8TMXjDdMh9gupZ0HPRswGikQcRGP1Ut2pX2c
         SRlVwwuQEyEC+k6m8TOwOu/QOJ9IIZaHAGnNfgwLjH7OBv3l1VVqe6XIajERY99A3yVS
         XGsDjXtQNMF5XuHLlrQS08ZIK80W+3DDWYPzPdzGNqNcCPg1ZZ3biTOHv2WUZ2mtINQD
         IIE6zey5oLtflTLcGV6205Ul/YAk1jwFhbRoooGzkCmBBp92dClvObaTrxN8O83UEcIR
         DyPErqq5ZeiubnXtSZSd+Hfyf3Fvg6qjMFOtQbmVKf4716POi1pW733WxcKLonmeUW9G
         TIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3oEaq4RbS2pIFT8sPysCqAhlN3jcufDI+zt2Oe41Lro=;
        b=cs1nDda1t+1NX6l/2v674LagnueMCrBIHd2XH/O+psh/bo891j0QPV8mi2OT9N3PZo
         s0SDwe8LXVw19GEwG6yELc1lv1gZr4SHcc9REWfSknxRxQukx2IpGj5CypzD+EKUr9pS
         cBjXvP24DkBiIm1J/KWmphXRJqxUc/0/ovUdijK6RKvAfOSu6DD6gp78G6bCefZ2gCrU
         VUqfHloIOtvoAyVdY+tqFu/omTwOGmLGYtTvKSvIaYWeqh4AqAKETrmgjFPuVWZYCIEL
         jn0Bf9Dci1guaX9wMN602gpQ7PHPQHaQB+yfFyc8LtOssLfucEaT4TnEXDGMK3YbzSR7
         dm7g==
X-Gm-Message-State: ANhLgQ0btGQYa+xxg4jc68ozVzRKAB4qFMhaKNPFbUgJI3yMhOTtHPmn
        GlkKYV86AHOsY7cQk6iNPdZQCqfCKr1neQs6Dgk=
X-Google-Smtp-Source: ADFU+vvGj6448MxKAOzD6zr1G0ngvNivZvk8WZGlcUExDmWxPozdHr1ocb6J3Vd+QOp/QajXMZTU6F7YR4TIY6QXI9g=
X-Received: by 2002:a17:902:8d92:: with SMTP id v18mr9173478plo.18.1584715967554;
 Fri, 20 Mar 2020 07:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200320131345.635023594@linutronix.de> <20200320131509.766573641@linutronix.de>
In-Reply-To: <20200320131509.766573641@linutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 20 Mar 2020 16:52:40 +0200
Message-ID: <CAHp75Veb_9a7adSZ__j0viFvTi-eRzeJqMphwOL-yjvfqom3Hw@mail.gmail.com>
Subject: Re: [patch 11/22] platform/x86: Convert to new CPU match macros
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-edac@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 20, 2020 at 3:18 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The new macro set has a consistent namespace and uses C99 initializers
> instead of the grufty C89 ones.
>
> Get rid the of the local macro wrappers for consistency.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: platform-driver-x86@vger.kernel.org
> ---
>  drivers/platform/x86/intel-uncore-frequency.c                 |   14 ++---
>  drivers/platform/x86/intel_int0002_vgpio.c                    |    4 -
>  drivers/platform/x86/intel_mid_powerbtn.c                     |    4 -
>  drivers/platform/x86/intel_pmc_core.c                         |   24 +++++-----
>  drivers/platform/x86/intel_pmc_core_pltdrv.c                  |   16 +++---
>  drivers/platform/x86/intel_speed_select_if/isst_if_mbox_msr.c |    4 -
>  drivers/platform/x86/intel_telemetry_debugfs.c                |    5 --
>  drivers/platform/x86/intel_telemetry_pltdrv.c                 |    7 --
>  drivers/platform/x86/intel_turbo_max_3.c                      |    6 --
>  9 files changed, 37 insertions(+), 47 deletions(-)
>
> --- a/drivers/platform/x86/intel-uncore-frequency.c
> +++ b/drivers/platform/x86/intel-uncore-frequency.c
> @@ -358,15 +358,13 @@ static struct notifier_block uncore_pm_n
>         .notifier_call = uncore_pm_notify,
>  };
>
> -#define ICPU(model)     { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
> -
>  static const struct x86_cpu_id intel_uncore_cpu_ids[] = {
> -       ICPU(INTEL_FAM6_BROADWELL_G),
> -       ICPU(INTEL_FAM6_BROADWELL_X),
> -       ICPU(INTEL_FAM6_BROADWELL_D),
> -       ICPU(INTEL_FAM6_SKYLAKE_X),
> -       ICPU(INTEL_FAM6_ICELAKE_X),
> -       ICPU(INTEL_FAM6_ICELAKE_D),
> +       X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,   NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,   NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,   NULL),
>         {}
>  };
>
> --- a/drivers/platform/x86/intel_int0002_vgpio.c
> +++ b/drivers/platform/x86/intel_int0002_vgpio.c
> @@ -148,8 +148,8 @@ static struct irq_chip int0002_cht_irqch
>  };
>
>  static const struct x86_cpu_id int0002_cpu_ids[] = {
> -       INTEL_CPU_FAM6(ATOM_SILVERMONT, int0002_byt_irqchip),   /* Valleyview, Bay Trail  */
> -       INTEL_CPU_FAM6(ATOM_AIRMONT, int0002_cht_irqchip),      /* Braswell, Cherry Trail */
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,     &int0002_byt_irqchip),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,        &int0002_cht_irqchip),
>         {}
>  };
>
> --- a/drivers/platform/x86/intel_mid_powerbtn.c
> +++ b/drivers/platform/x86/intel_mid_powerbtn.c
> @@ -113,8 +113,8 @@ static const struct mid_pb_ddata mrfld_d
>  };
>
>  static const struct x86_cpu_id mid_pb_cpu_ids[] = {
> -       INTEL_CPU_FAM6(ATOM_SALTWELL_MID,       mfld_ddata),
> -       INTEL_CPU_FAM6(ATOM_SILVERMONT_MID,     mrfld_ddata),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL_MID,   &mfld_ddata),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, &mrfld_ddata),
>         {}
>  };
>
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -871,18 +871,18 @@ static inline void pmc_core_dbgfs_unregi
>  #endif /* CONFIG_DEBUG_FS */
>
>  static const struct x86_cpu_id intel_pmc_core_ids[] = {
> -       INTEL_CPU_FAM6(SKYLAKE_L, spt_reg_map),
> -       INTEL_CPU_FAM6(SKYLAKE, spt_reg_map),
> -       INTEL_CPU_FAM6(KABYLAKE_L, spt_reg_map),
> -       INTEL_CPU_FAM6(KABYLAKE, spt_reg_map),
> -       INTEL_CPU_FAM6(CANNONLAKE_L, cnp_reg_map),
> -       INTEL_CPU_FAM6(ICELAKE_L, icl_reg_map),
> -       INTEL_CPU_FAM6(ICELAKE_NNPI, icl_reg_map),
> -       INTEL_CPU_FAM6(COMETLAKE, cnp_reg_map),
> -       INTEL_CPU_FAM6(COMETLAKE_L, cnp_reg_map),
> -       INTEL_CPU_FAM6(TIGERLAKE_L, tgl_reg_map),
> -       INTEL_CPU_FAM6(TIGERLAKE, tgl_reg_map),
> -       INTEL_CPU_FAM6(ATOM_TREMONT, tgl_reg_map),
> +       X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,           &spt_reg_map),
> +       X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,             &spt_reg_map),
> +       X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,          &spt_reg_map),
> +       X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,            &spt_reg_map),
> +       X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,        &cnp_reg_map),
> +       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,           &icl_reg_map),
> +       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_NNPI,        &icl_reg_map),
> +       X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,           &cnp_reg_map),
> +       X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,         &cnp_reg_map),
> +       X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,         &tgl_reg_map),
> +       X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,           &tgl_reg_map),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,        &tgl_reg_map),
>         {}
>  };
>
> --- a/drivers/platform/x86/intel_pmc_core_pltdrv.c
> +++ b/drivers/platform/x86/intel_pmc_core_pltdrv.c
> @@ -38,14 +38,14 @@ static struct platform_device pmc_core_d
>   * other list may grow, but this list should not.
>   */
>  static const struct x86_cpu_id intel_pmc_core_platform_ids[] = {
> -       INTEL_CPU_FAM6(SKYLAKE_L, pmc_core_device),
> -       INTEL_CPU_FAM6(SKYLAKE, pmc_core_device),
> -       INTEL_CPU_FAM6(KABYLAKE_L, pmc_core_device),
> -       INTEL_CPU_FAM6(KABYLAKE, pmc_core_device),
> -       INTEL_CPU_FAM6(CANNONLAKE_L, pmc_core_device),
> -       INTEL_CPU_FAM6(ICELAKE_L, pmc_core_device),
> -       INTEL_CPU_FAM6(COMETLAKE, pmc_core_device),
> -       INTEL_CPU_FAM6(COMETLAKE_L, pmc_core_device),
> +       X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,           &pmc_core_device),
> +       X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,             &pmc_core_device),
> +       X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,          &pmc_core_device),
> +       X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,            &pmc_core_device),
> +       X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,        &pmc_core_device),
> +       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,           &pmc_core_device),
> +       X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,           &pmc_core_device),
> +       X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,         &pmc_core_device),
>         {}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_platform_ids);
> --- a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_msr.c
> +++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_msr.c
> @@ -160,10 +160,8 @@ static struct notifier_block isst_pm_nb
>         .notifier_call = isst_pm_notify,
>  };
>
> -#define ICPU(model)     { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
> -
>  static const struct x86_cpu_id isst_if_cpu_ids[] = {
> -       ICPU(INTEL_FAM6_SKYLAKE_X),
> +       X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X, NULL),
>         {}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, isst_if_cpu_ids);
> --- a/drivers/platform/x86/intel_telemetry_debugfs.c
> +++ b/drivers/platform/x86/intel_telemetry_debugfs.c
> @@ -308,11 +308,10 @@ static struct telemetry_debugfs_conf tel
>  };
>
>  static const struct x86_cpu_id telemetry_debugfs_cpu_ids[] = {
> -       INTEL_CPU_FAM6(ATOM_GOLDMONT, telem_apl_debugfs_conf),
> -       INTEL_CPU_FAM6(ATOM_GOLDMONT_PLUS, telem_apl_debugfs_conf),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,       &telem_apl_debugfs_conf),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,  &telem_apl_debugfs_conf),
>         {}
>  };
> -
>  MODULE_DEVICE_TABLE(x86cpu, telemetry_debugfs_cpu_ids);
>
>  static int telemetry_debugfs_check_evts(void)
> --- a/drivers/platform/x86/intel_telemetry_pltdrv.c
> +++ b/drivers/platform/x86/intel_telemetry_pltdrv.c
> @@ -67,9 +67,6 @@
>  #define TELEM_CLEAR_VERBOSITY_BITS(x)  ((x) &= ~(BIT(27) | BIT(28)))
>  #define TELEM_SET_VERBOSITY_BITS(x, y) ((x) |= ((y) << 27))
>
> -#define TELEM_CPU(model, data) \
> -       { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (unsigned long)&data }
> -
>  enum telemetry_action {
>         TELEM_UPDATE = 0,
>         TELEM_ADD,
> @@ -183,8 +180,8 @@ static struct telemetry_plt_config telem
>  };
>
>  static const struct x86_cpu_id telemetry_cpu_ids[] = {
> -       TELEM_CPU(INTEL_FAM6_ATOM_GOLDMONT, telem_apl_config),
> -       TELEM_CPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS, telem_glk_config),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,       &telem_apl_config),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,  &telem_glk_config),
>         {}
>  };
>
> --- a/drivers/platform/x86/intel_turbo_max_3.c
> +++ b/drivers/platform/x86/intel_turbo_max_3.c
> @@ -113,11 +113,9 @@ static int itmt_legacy_cpu_online(unsign
>         return 0;
>  }
>
> -#define ICPU(model)     { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
> -
>  static const struct x86_cpu_id itmt_legacy_cpu_ids[] = {
> -       ICPU(INTEL_FAM6_BROADWELL_X),
> -       ICPU(INTEL_FAM6_SKYLAKE_X),
> +       X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,   NULL),
>         {}
>  };
>
>


-- 
With Best Regards,
Andy Shevchenko
