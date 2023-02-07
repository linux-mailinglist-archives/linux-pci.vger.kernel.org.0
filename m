Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A329868DA6C
	for <lists+linux-pci@lfdr.de>; Tue,  7 Feb 2023 15:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjBGOUT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Feb 2023 09:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbjBGOUR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2023 09:20:17 -0500
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C117392AA;
        Tue,  7 Feb 2023 06:20:10 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id m1so1021331ejx.7;
        Tue, 07 Feb 2023 06:20:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvnqVj7q+a5osJEmog2V+AtjIDObMd5GeBfEqLFzts8=;
        b=u6So000PNI22YEcrRr/ThcArY8SmPJ74mSGtVBX6l1QjtKuydsj6j4czL1l/Ku6udW
         Y8Fl08yQoQfE8oy9U4Q+bR1s82hhH5I382r1SUa49dkrF02WTIPaemynb7C2KcHlJsiY
         dOHVYsLrX3up71nNIPrJDTqZBC7i3ZA9MXMZ30YICWCrXJmpgMpDehxuenvwVfbZgA8h
         dpP2Xk/yhoxYsu/jGu9nUi8DyPSI+dpqwUtFSc/lYBcfLBEG2z1U0XmqX9ZnXKQLDL+j
         aWsFQbSj+90WNi6q5tiK5HIZ1faAFx1NiN0gozK6Qqdfvkhpt2ZVQpnURVXioWJR43Ae
         3Xmg==
X-Gm-Message-State: AO0yUKUJapRl86ZgnC0c12e4qdi3+6IhOHwmFZlilqtTL/nYIpP6AKqQ
        mPsdQYT/5hwfBZL2AwmJXyxBFRl5k+GMTVDOL0g=
X-Google-Smtp-Source: AK7set/Mbm0aCB1c31qI6RJS4QVnyQvNE+EXCzo6+78pQdWrpHVTJGE0489RkL4fRrn0VemSUpi5AQxIYcQMdoCTA6M=
X-Received: by 2002:a17:906:ce2e:b0:87f:575a:9b67 with SMTP id
 sd14-20020a170906ce2e00b0087f575a9b67mr937430ejb.274.1675779608674; Tue, 07
 Feb 2023 06:20:08 -0800 (PST)
MIME-Version: 1.0
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
 <167571657859.587790.12435839081602248140.stgit@djiang5-mobl3.local>
In-Reply-To: <167571657859.587790.12435839081602248140.stgit@djiang5-mobl3.local>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Feb 2023 15:19:57 +0100
Message-ID: <CAJZ5v0hO-FthRSRD5LPL1Onz7DaRG8zBo=GBDBR+k1_upYHVBQ@mail.gmail.com>
Subject: Re: [PATCH 02/18] ACPICA: Export acpi_ut_verify_cdat_checksum()
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, bhelgaas@google.com,
        robert.moore@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 6, 2023 at 9:49 PM Dave Jiang <dave.jiang@intel.com> wrote:
>
> Export the CDAT checksum verify function so CXL driver can use it to verify
> CDAT coming from the CXL devices.
>
> Given that this function isn't actually being used by ACPI internals,
> removing the define check of APCI_CHECKSUM_ABORT so the function would
> return failure on checksum fail since the driver will need to know.

If you want to make ACPICA changes, please first submit a pull request
to the upstream ACPICA project on GitHub.

Having done that, please resubmit the corresponding Linux patch with a
Link tag pointing to the upstream PR.

Thanks!

> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/acpica/utcksum.c |    4 +---
>  include/linux/acpi.h          |    7 +++++++
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpica/utcksum.c b/drivers/acpi/acpica/utcksum.c
> index c166e4c05ab6..c0f98c8f9a0b 100644
> --- a/drivers/acpi/acpica/utcksum.c
> +++ b/drivers/acpi/acpica/utcksum.c
> @@ -102,15 +102,13 @@ acpi_ut_verify_cdat_checksum(struct acpi_table_cdat *cdat_table, u32 length)
>                                    "should be 0x%2.2X",
>                                    acpi_gbl_CDAT, cdat_table->checksum,
>                                    checksum));
> -
> -#if (ACPI_CHECKSUM_ABORT)
>                 return (AE_BAD_CHECKSUM);
> -#endif
>         }
>
>         cdat_table->checksum = checksum;
>         return (AE_OK);
>  }
> +EXPORT_SYMBOL_GPL(acpi_ut_verify_cdat_checksum);
>
>  /*******************************************************************************
>   *
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 5e6a876e17ba..09b44afef7df 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1504,9 +1504,16 @@ static inline void acpi_init_ffh(void) { }
>  #ifdef CONFIG_ACPI
>  extern void acpi_device_notify(struct device *dev);
>  extern void acpi_device_notify_remove(struct device *dev);
> +extern acpi_status
> +acpi_ut_verify_cdat_checksum(struct acpi_table_cdat *cdat_table, u32 length);
>  #else
>  static inline void acpi_device_notify(struct device *dev) { }
>  static inline void acpi_device_notify_remove(struct device *dev) { }
> +static inline acpi_status
> +acpi_ut_verify_cdat_checksum(struct acpi_table_cdat *cdat_table, u32 length)
> +{
> +       return (AE_NOT_CONFIGURED);
> +}
>  #endif
>
>  #endif /*_LINUX_ACPI_H*/
>
>
