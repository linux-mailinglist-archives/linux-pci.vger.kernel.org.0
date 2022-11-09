Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AE1622B6B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Nov 2022 13:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiKIMWT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 07:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiKIMWS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 07:22:18 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E6A250;
        Wed,  9 Nov 2022 04:22:17 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id l2so10197183qtq.11;
        Wed, 09 Nov 2022 04:22:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XvBiFkolKGUNT/T8gjXpcXzeHtarJfPAvEGuDLN1G0E=;
        b=s99MiDBO7eAhnWAxeDGGJrdHdVOtxlXxWPC30w1PgFXr+XY1nxBUuhLPQ5k5yuMZgG
         o7RtW/JkcS92aszpKWr7KK5GGz7Vcn+c+897dgp9LLUlxK9YGCfsGuYNh1JQPQGm/Lvw
         ziqJQ6UmtPQ2XoDEx0/1N+i0DcwjGe9K3gSew7HNnAmxEDw5tUtayrjkTR4r8ZKtrDAH
         QEE0AqC3gH64ZqO9lwmKwKt0P28Szt+9XCdH7g9gEEoQi93rIqVshoUKGiRae8k9wp2i
         iwCcqEXJlpdANWflmo95Cd/uV+M1sU8DoMOlDW2HHylRXJ4cmpFL8EO8Nrc3wZ+n7Vka
         sclw==
X-Gm-Message-State: ACrzQf0/LR6gDuCyTHN5wxPfpNy5Uy4YhWMzRkJ94UFhQu4dqo5QBeFT
        gY6vsJF0B4TlLOUaCgsYSFQCP6AkX7gs0DrJKBc=
X-Google-Smtp-Source: AMsMyM4poJGku7VUKnTRBml+VyWLtEWGUgmc0O+LQC5DfNjZ/VebWumF69asi53wkVrHRzyK/tfGHFQwOBzNriOpPS8=
X-Received: by 2002:ac8:7d15:0:b0:3a5:449:87c3 with SMTP id
 g21-20020ac87d15000000b003a5044987c3mr47257311qtb.357.1667996536769; Wed, 09
 Nov 2022 04:22:16 -0800 (PST)
MIME-Version: 1.0
References: <20221109104059.766720-1-rrichter@amd.com> <20221109104059.766720-10-rrichter@amd.com>
In-Reply-To: <20221109104059.766720-10-rrichter@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Nov 2022 13:22:05 +0100
Message-ID: <CAJZ5v0i-RcsjMhoZymcTTR8P-WteHpxYgZ+aLEeQSpWVQRXF0g@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] cxl/acpi: Set ACPI's CXL _OSC to indicate CXL1.1 support
To:     Robert Richter <rrichter@amd.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Terry Bowman <terry.bowman@amd.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
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

On Wed, Nov 9, 2022 at 11:41 AM Robert Richter <rrichter@amd.com> wrote:
>
> From: Terry Bowman <terry.bowman@amd.com>
>
> ACPI includes a CXL _OSC support procedure to communicate the available
> CXL support to FW. The CXL support _OSC includes a field to indicate
> CXL1.1 RCH RCD support. The OS sets this bit to 1 if it supports access
> to RCD and RCH Port registers.[1] FW can potentially change it's operation
> depending on the _OSC support setting reported by the OS.
>
> The ACPI driver does not currently set the ACPI _OSC support to indicate
> CXL1.1 RCD RCH support. Change the capability reported to include CXL1.1.
>
> [1] CXL3.0 Table 9-26 'Interpretation of CXL _OSC Support Field'
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/pci_root.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index c8385ef54c37..094a59b216ae 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -492,6 +492,7 @@ static u32 calculate_cxl_support(void)
>         u32 support;
>
>         support = OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT;
> +       support |= OSC_CXL_1_1_PORT_REG_ACCESS_SUPPORT;
>         if (pci_aer_available())
>                 support |= OSC_CXL_PROTOCOL_ERR_REPORTING_SUPPORT;
>         if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> --
> 2.30.2
>
