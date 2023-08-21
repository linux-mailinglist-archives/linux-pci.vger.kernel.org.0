Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13C2783055
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 20:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjHUSh2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 21 Aug 2023 14:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjHUSh1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 14:37:27 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FC955046;
        Mon, 21 Aug 2023 11:37:23 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6b9cd6876bbso1000366a34.1;
        Mon, 21 Aug 2023 11:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692643012; x=1693247812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLN5fVke3UiE4d8PldnT9vbamakvgY2iEAu+8/GhTRs=;
        b=bP3Sq7oOV+lN+c8Lh6RZYnDyhiPzXk6tByu4T5LdRPU1XFmiCZLd7DsnJQMB/SANkA
         rt01ilUsBSfYO2w+ueLkMdk/NdteLZHqbbkDDIfQyaK/gc3W3X/5wqLiqxBkEc//c0/j
         EnRwON1XqGLXpxA5UfPpt6Zpnpdk6H46xqj7B7bY3KwRnLvtuZkhsaNeh16ya6sGcA4n
         occMlrkV+H+MNZEY2y6daPUztpXgkOAayBHrEyLQbnm+32zssMb4AP5HPjmHjFW37d8d
         QDE0n3YZ7YA9Ug4FMVtZiAXxl3+qGlmiWOh0sVAB/DGZ+AX7Z8sNlDryT2FPmTHzlH7J
         jC5Q==
X-Gm-Message-State: AOJu0Yxl8TeI4m5h8GR4/pTAkvDbhsgG1faj2J3tPmfXrNjtiOactjJ4
        wbFYqVjGEvjTXsCwuP2Cv1Sy/VDEZ5G/lmpBb6o/d2Q/
X-Google-Smtp-Source: AGHT+IHFSj6NlHd3WUqvMhgYOEr0g69zmYhq8Xxe/pVdYKuLur2tvJrWNoPWpi1JVIqOn5JLCaCczdhuZRAbjZGcVVk=
X-Received: by 2002:a4a:da10:0:b0:56e:6532:467a with SMTP id
 e16-20020a4ada10000000b0056e6532467amr6560066oou.1.1692643011815; Mon, 21 Aug
 2023 11:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230818194027.27559-1-mario.limonciello@amd.com> <20230818194027.27559-3-mario.limonciello@amd.com>
In-Reply-To: <20230818194027.27559-3-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Aug 2023 20:36:40 +0200
Message-ID: <CAJZ5v0jvaT1XR0_BDAvg70CHhNjZ+KHEe7pgewaSBaaqROGpOQ@mail.gmail.com>
Subject: Re: [PATCH v14.c 2/4] PCI: ACPI: Consider non-hotplug bridges for D3
 in acpi_pci_bridge_d3()
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
> acpi_pci_bridge_d3() only runs on hotplug bridges. Two checks are made
> for _S0W and for whether a device is power manageable contingent upon
> an ACPI companion being present.
>
> These checks also make sense for non-hotplug bridges, so move the
> check for hotplug bridge after the acpi companion checks.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Looks reasonable to me.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/pci/pci-acpi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index b5b65cdfa3b8b..64e6ada024235 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1017,7 +1017,7 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>         struct acpi_device *adev, *rpadev;
>         const union acpi_object *obj;
>
> -       if (acpi_pci_disabled || !dev->is_hotplug_bridge)
> +       if (acpi_pci_disabled)
>                 return false;
>
>         adev = ACPI_COMPANION(&dev->dev);
> @@ -1039,6 +1039,9 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>                         return true;
>         }
>
> +       if (!dev->is_hotplug_bridge)
> +               return false;
> +
>         rpdev = pcie_find_root_port(dev);
>         if (!rpdev)
>                 return false;
> --
