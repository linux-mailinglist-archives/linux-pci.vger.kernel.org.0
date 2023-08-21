Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5CE783022
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 20:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbjHUSRl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 21 Aug 2023 14:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237151AbjHUSRl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 14:17:41 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9223B126;
        Mon, 21 Aug 2023 11:17:32 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-570b3ebb3faso149266eaf.0;
        Mon, 21 Aug 2023 11:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692641852; x=1693246652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U915soG4Cn1Yj7ytPNls916oVCFFMGSgVOAvevB8apo=;
        b=g+X1yCroxdTfGL7bIHi9QQxRdXHe53tzWNmpBXsa1Tu+tTJ1mkzVjyY6ZxRFqIOFZt
         CZdFLrIDM2qUPV2PpVXa3rs/ccpHeAqVrQi15qogs0kDT78KdtipwWQq0IuoibIq/OSO
         OE5myJTFvaI3HdeK2BgOv4Kgkq4tadqDN3HeEzd9Y449C42NgxMuYSi6hRH3iyGer9eH
         fvCo509y9O1Fzu6QtfslSGNRbJMndO+54yVvg7b8zFN4Lvm9pMgoM2jKh+cvep0HTeKN
         dLgKf21JlsLPvNf8vJR+1xBKS14hS+d/7K1cfL12BaH1Ih+Us3+KnY8l1QMEB9LoT5QM
         y0KA==
X-Gm-Message-State: AOJu0YxxUN6E/GzmykNtPXXNs1j95Ut/DnBpROHy+MHXDnLcMxezaX21
        0IYHokfPuPGmKNzFqext5n1Isc1sUygCI4u/10I=
X-Google-Smtp-Source: AGHT+IF+9Ah1rcdUWpT8kNAKyrdk+gBugPzYZRvqtM1UtgRsr+ffGm5/ww1QsbsEzCL1ZQrSZC9tWQoVUcXipOdNqEo=
X-Received: by 2002:a4a:e741:0:b0:56e:94ed:c098 with SMTP id
 n1-20020a4ae741000000b0056e94edc098mr6975400oov.0.1692641851710; Mon, 21 Aug
 2023 11:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230818193932.27187-1-mario.limonciello@amd.com>
In-Reply-To: <20230818193932.27187-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Aug 2023 20:17:16 +0200
Message-ID: <CAJZ5v0gwFKHLtd9rqNAe5ozgp_EWi3A158VukcX0oA4LBPBfOQ@mail.gmail.com>
Subject: Re: [PATCH v14.a 1/1] PCI: Only put Intel PCIe ports >= 2015 into D3
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 18, 2023 at 9:40 PM Mario Limonciello
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
> Reviewed-by:Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
> In v14 this series has been split into 3 parts.
>  part A: Immediate fix for AMD issue.
>  part B: LPS0 export improvements
>  part C: Long term solution for all vendors
> v13->v14:
>  * Reword the comment
>  * add tag
> v12->v13:
>  * New patch
> ---
>  drivers/pci/pci.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 60230da957e0c..bfdad2eb36d13 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3037,10 +3037,15 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>                         return false;
>
>                 /*
> -                * It should be safe to put PCIe ports from 2015 or newer
> -                * to D3.
> +                * Allow Intel PCIe ports from 2015 onward to go into D3 to
> +                * achieve additional energy conservation on some platforms.
> +                *
> +                * This is only set for Intel PCIe ports as it causes problems
> +                * on both AMD Rembrandt and Phoenix platforms where USB keyboards
> +                * can not be used to wake the system from suspend.
>                  */
> -               if (dmi_get_bios_year() >= 2015)
> +               if (bridge->vendor == PCI_VENDOR_ID_INTEL &&
> +                   dmi_get_bios_year() >= 2015)
>                         return true;
>                 break;
>         }
> --
> 2.34.1
>
