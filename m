Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F63F783065
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 20:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjHUSo7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 21 Aug 2023 14:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHUSo6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 14:44:58 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138566C90;
        Mon, 21 Aug 2023 11:44:56 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-570d3039f1cso152033eaf.0;
        Mon, 21 Aug 2023 11:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692643142; x=1693247942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqPPUrt9KeYhVa9fnzE/uDwtP7K+EETKPssBOXtMCik=;
        b=C+yB8VPsL8V8TiIE/BzCZqpZkla+OS5QcZ0ocGxpuKhNarlPCukNz1w/mebt4ggo2Y
         PltamID+OTCkibN5kosfmV6EHhj8VkyroKpqivW4pcUrPTfjCbXb31BOUSilltUWnStw
         nWeokGkOugGnVlcVVZUQjVBnZVM0oUUcaHCb/+zOcQJsdwiAIXX21gUyNncJ+97mNAL7
         gnKwkQZxlInM7ITCviw5bOgnkZbhb/uRUrtAeMOXRBwSEY5xzCCEEd0twbIpTvGc6RP1
         iqxiGxLG4ntnm8+J2Qo9chN/TcVseIjNvcqZWt/wTKOGqiWz54/zePpCWyL90tp5yiIl
         /qKw==
X-Gm-Message-State: AOJu0Yyzu8nATwDLIxWMprxd8e+g5JSJNDaQPIvYs0EhOp2HMywit2+c
        H+AB8/ZS7yrrwmg+8GVg8qDmq+z7UnMazXD2h/tnimAW
X-Google-Smtp-Source: AGHT+IE7P/LVq3p+kL8FThy2tHNGf3afWoWZDF12dtGlKOlEuP3D2AwHgxbH4+duc/4bAVIoH52dt0IyJXXthCD5gcQ=
X-Received: by 2002:a4a:c3c8:0:b0:56e:487f:8caa with SMTP id
 e8-20020a4ac3c8000000b0056e487f8caamr6796294ooq.1.1692643142475; Mon, 21 Aug
 2023 11:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230818194027.27559-1-mario.limonciello@amd.com> <20230818194027.27559-4-mario.limonciello@amd.com>
In-Reply-To: <20230818194027.27559-4-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Aug 2023 20:38:51 +0200
Message-ID: <CAJZ5v0gGi8s3o5e0AJXPMwAwFAwEg=Mbtu6iQ2-6rhACmCBQ+w@mail.gmail.com>
Subject: Re: [PATCH v14.c 3/4] PCI: ACPI: Use device constraints to opt
 devices into D3 support
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 18, 2023 at 9:40 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> In Windows, systems that support Modern Standby specify hardware
> pre-conditions for the SoC to be able to achieve the lowest power state
> by using 'device constraints' in a SOC specific "Power Engine
> Plugin" (PEP) [1] [2].
>
> For each device, the constraint is the minimum (shallowest) power
> state in which the device can be for the platform to be still able to
> achieve significant energy conservation in a system-wide low-power
> idle configuration.
>
> Device constraints are specified in the return value for a _DSM of
> a PNP0D80 device, and Linux enumerates the constraints during probing.
>
> For PCI bridges (including PCIe ports), the constraints may be
> regarded as an additional source of information regarding the power
> state to put the device into when it is suspended.  In particular, if
> the constraint for a given PCI bridge is D3hot, the platform regards
> D3hot as a valid power state for the bridge and it is reasonable to
> expect that there won't be any side effects caused by putting the
> bridge into that power state.
>
> Accordingly, take the low-power S0 idle (LPS0) constraints into
> account when deciding whether or not to allow a given PCI bridge to be
> put into D3.
>
> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
> Link: https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf [2]
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

All feedback addressed AFAICS, so

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
> v13->v14:
>  * Move code as another way to satisfy acpi_pci_bridge_d3() instead
>  * Update commit with Rafael's suggestions
> v12->v13:
>  * Move back to PCI code
>  * Trim commit message
> v11->v12:
>  * Adjust for dropped patch 8/9 from v11.
>  * Update comment
> v10->v11:
>  * Fix kernel kernel build robot errors and various sparse warnings
>    related to new handling of pci_power_t.
>  * Use the new helpers introduced in previous patches
> ---
>  drivers/pci/pci-acpi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 64e6ada024235..8331aea22d327 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1022,6 +1022,15 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>
>         adev = ACPI_COMPANION(&dev->dev);
>         if (adev) {
> +               int acpi_state;
> +
> +               /* Check if the platform specifies an LPS0 constraint of D3. */
> +               acpi_state = acpi_get_lps0_constraint(adev);
> +               pci_dbg(dev, "LPS0 constraint: %d\n", acpi_state);
> +               if (acpi_state != ACPI_STATE_UNKNOWN &&
> +                   acpi_state >= ACPI_STATE_D3_HOT)
> +                       return true;
> +
>                 /*
>                  * If the bridge has _S0W, whether or not it can go into D3
>                  * depends on what is returned by that object.  In particular,
> --
> 2.34.1
>
