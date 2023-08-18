Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712B3780FCF
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 18:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378403AbjHRQGp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 18 Aug 2023 12:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378236AbjHRQGS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 12:06:18 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EF8E42;
        Fri, 18 Aug 2023 09:06:16 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-56cae50792fso153303eaf.1;
        Fri, 18 Aug 2023 09:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692374776; x=1692979576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Jt2ZhPuIxHkcFze1mQsYQAQR93Iny64sokh0i49zSw=;
        b=GkOOkexJLwc1yjFptML9gv7xZJjFvMPIh715VhrdIw35xQJOOZ3MXkhiCdqh8k+ihB
         v9pH/YlCmR4WLE84be5UaE51qdH/mxinISN0OXA896XW6TdxEsio27qjg8SXqPe72mLO
         0/bTzJUIdmJrKjm2dC28FVL029TEtq7a23pEbxti97ZxY752mrKZP2MlMbcSrmXGjMN2
         6hQXYz14alaSBKDi8HP2+Oulnc0dnooPEsXcq+t77LkX4Ru7Mhl7VdJIcs0H73k3MsXM
         RzG6tjhTIN0bZRxEHyUWTEZkXUIYORjdlFbFH6sntFQIVs9rnEuh49d5xkgfkQcXFi7U
         xT5w==
X-Gm-Message-State: AOJu0YwP5RJ2rcO4Br6NkHZbVReqgS9eBatTSvm3AJIpTBJmwZ2at9z0
        L9wTc60Q5ydd3bJUIo/hL9TUndi9dJZBRGKcbYo=
X-Google-Smtp-Source: AGHT+IGRXVkOfek40tkKpLfQWtAuSOTCYBMIYxziW7ig/9HfgrRzUDflKxESlYdN8kZ/2fVBZy3h+cpQFh/uSNyEDX8=
X-Received: by 2002:a05:6820:3d1:b0:56e:94ed:c098 with SMTP id
 s17-20020a05682003d100b0056e94edc098mr1792962ooj.0.1692374775591; Fri, 18 Aug
 2023 09:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230818051319.551-1-mario.limonciello@amd.com> <20230818051319.551-12-mario.limonciello@amd.com>
In-Reply-To: <20230818051319.551-12-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Aug 2023 18:06:04 +0200
Message-ID: <CAJZ5v0iowLso0Wvg7gnQfXikvn_TJcpPMAW_WPNmSW6zxHUVpQ@mail.gmail.com>
Subject: Re: [PATCH v13 11/12] PCI: ACPI: Use device constraints to opt
 devices into D3 support
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
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
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

On Fri, Aug 18, 2023 at 7:15 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> In Windows, systems that support Modern Standby specify hardware
> pre-conditions for the SoC to be able to achieve the lowest power state
> by using 'device constraints' in a SOC specific "Power Engine
> Plugin" (PEP) [1] [2].

The connection between the device power states and the "PEP
constraints" is still rather unclear after reading the above.  I would
add something like

"For each device, the constraint is the minimum (shallowest) power
state in which the device can be for the platform to be still able to
achieve significant energy conservation in a system-wide low-power
idle configuration."

> Device constraints are specified in the return value for a _DSM of
> a PNP0D80 device, and Linux enumerates the constraints during probing.
>
> In cases that the existing logic for pci_bridge_d3_possible() may not
> enable D3 support query for any constraints specified by the device.
> If the constraints specify D3 support, then use D3 for the PCI device.

The above paragraph is not particularly clear IMO.  I would say
something like this instead:

"For PCI bridges (including PCIe ports), the constraints may be
regarded as an additional source of information regarding the power
state to put the device into when it is suspended.  In particular, if
the constraint for a given PCI bridge is D3hot, the platform regards
D3hot as a valid power state for the bridge and it is reasonable to
expect that there won't be any side effects caused by putting the
bridge into that power state.

Accordingly, take the low-power S0 idle (LPS0) constraints into
account when deciding whether or not to allow a given PCI bridge to be
put into D3."

> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
> Link: https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf [2]
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
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
>  drivers/pci/pci-acpi.c | 14 ++++++++++++++
>  drivers/pci/pci.c      | 12 ++++++++++++
>  drivers/pci/pci.h      |  5 +++++
>  3 files changed, 31 insertions(+)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index b5b65cdfa3b8b..bcc76e9d399c5 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1081,6 +1081,20 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>         return false;
>  }
>
> +/**
> + * acpi_pci_check_d3_constraint - Check if device specifies a D3 platform constraint
> + * @dev: PCI device to check
> + *
> + * This function checks if the platform specifies that a given PCI device should
> + * be put into D3 to satisfy a low power platform constraint
> + *
> + * Returns: TRUE if constraint for D3hot or deeper, FALSE otherwise.
> + */
> +bool acpi_pci_check_d3_constraint(struct pci_dev *dev)
> +{
> +       return acpi_get_lps0_constraint(&dev->dev) >= ACPI_STATE_D3_HOT;
> +}
> +
>  static void acpi_pci_config_space_access(struct pci_dev *dev, bool enable)
>  {
>         int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 051e88ee64c63..0fc8d35154f97 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1082,6 +1082,14 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
>         return acpi_pci_bridge_d3(dev);
>  }
>
> +static inline bool platform_check_d3_constraint(struct pci_dev *dev)
> +{
> +       if (pci_use_mid_pm())
> +               return false;
> +
> +       return acpi_pci_check_d3_constraint(dev);
> +}

As I said elsewhere, the above looks redundant to me.  I would rather
make acpi_pci_bridge_d3() use the PEP constraints as an additional
source of information.

> +
>  /**
>   * pci_update_current_state - Read power state of given device and cache it
>   * @dev: PCI device to handle.
> @@ -3036,6 +3044,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>                 if (dmi_check_system(bridge_d3_blacklist))
>                         return false;
>
> +               /* the platform specifies in LPS0 constraints to use D3 */
> +               if (platform_check_d3_constraint(bridge))
> +                       return true;
> +
>                 /*
>                  * It is safe to put Intel PCIe ports from 2015 or newer
>                  * to D3.
