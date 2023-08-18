Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB8B7806EC
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 10:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358472AbjHRINC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 18 Aug 2023 04:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358463AbjHRIMg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 04:12:36 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A627E2D67;
        Fri, 18 Aug 2023 01:12:34 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-56d26137095so113118eaf.1;
        Fri, 18 Aug 2023 01:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692346354; x=1692951154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlfSrbt+jyOReyWKwiQVH9Cn4HXiM8ZuEdzWRtwyMeQ=;
        b=R0gm8lYce1FiJEmy13lLT8jweH0Xgspf+tcoKJDOCxnvDCSjINcfLk7YI+AygvGQrW
         u1xrH2VDO4XySgDSrXKb4g5ccpFXq2VzfWSTzj4/LwyRhWnitGWJ/G5fxarCKIG3noeg
         ThwOCwwXO6Nu40Lmb4zKFcmm63yzEOPc2APSAvOs0eiMcI3BXpduGFlWIdgPuUzyab7n
         7Iiyf9WEQ87iY3aL7Sog5DGIvDkbPA2ODZqhAcYUtLfeoyT/Tg6NPWsWWHG2IkA+2Hp5
         FXHuq+J8a/9OMwcA6X7H/9MCHNkImNi7G/3bEqnBRETMB++a9dysIUh7F8e8on91xawD
         uHng==
X-Gm-Message-State: AOJu0YziU5nfsb51FWbn/ytiL8mLqLMvWxqRLHlNfDspYtvgKiPDiqj2
        RDkH4vwbzpwW6B2sgZMJONO67B3A6SMp10qkYG4=
X-Google-Smtp-Source: AGHT+IG5ZbK1ZC5QP/c343120LfytPwdwJ4JmaTUFGB4KRI6C1ojCn3gTXvm3TLzGQl52gTW7XBQmcU1T0om+FUVncU=
X-Received: by 2002:a4a:d581:0:b0:56e:487f:8caa with SMTP id
 z1-20020a4ad581000000b0056e487f8caamr2023839oos.1.1692346353860; Fri, 18 Aug
 2023 01:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230818051319.551-1-mario.limonciello@amd.com> <20230818051319.551-2-mario.limonciello@amd.com>
In-Reply-To: <20230818051319.551-2-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Aug 2023 10:12:22 +0200
Message-ID: <CAJZ5v0iHvbbNBnwb-RKvcBaFR8VMGyGt--b6RmbUmwuzcBZKnQ@mail.gmail.com>
Subject: Re: [PATCH v13 01/12] PCI: Only put Intel PCIe ports >= 2015 into D3
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 18, 2023 at 7:14 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> changed pci_bridge_d3_possible() so that any vendor's PCIe ports
> from modern machines (>=2015) are allowed to be put into D3.
>
> Iain reports that USB devices can't be used to wake a Lenovo Z13
> from suspend. This is because the PCIe root port has been put
> into D3 and AMD's platform can't handle USB devices waking in this
> case.
>
> This behavior is only reported on Linux. Comparing the behavior
> on Windows and Linux, Windows doesn't put the root ports into D3.
>
> To fix the issue without regressing existing Intel systems,
> limit the >=2015 check to only apply to Intel PCIe ports.
>
> Cc: stable@vger.kernel.org
> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v12->v13:
>  * New patch
> ---
>  drivers/pci/pci.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 60230da957e0c..051e88ee64c63 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3037,10 +3037,11 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>                         return false;
>
>                 /*
> -                * It should be safe to put PCIe ports from 2015 or newer
> +                * It is safe to put Intel PCIe ports from 2015 or newer
>                  * to D3.
>                  */

I would say "Allow Intel PCIe ports from 2015 onward to go into D3 to
achieve additional energy conservation on some platforms" without the
"It is safe" part that is kind of obvious (it wouldn't be done if it
were unsafe).

And analogously in patch [12/12].

> -               if (dmi_get_bios_year() >= 2015)
> +               if (bridge->vendor == PCI_VENDOR_ID_INTEL &&
> +                   dmi_get_bios_year() >= 2015)
>                         return true;
>                 break;
>         }
> --
> 2.34.1
>
