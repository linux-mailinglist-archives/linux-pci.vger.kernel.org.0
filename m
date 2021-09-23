Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF65416009
	for <lists+linux-pci@lfdr.de>; Thu, 23 Sep 2021 15:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241460AbhIWNgu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Sep 2021 09:36:50 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:41855 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241451AbhIWNgs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Sep 2021 09:36:48 -0400
Received: by mail-ot1-f42.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso8484439ota.8;
        Thu, 23 Sep 2021 06:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZZw776AxWux9GflNAqL8Dxi/2W2AZOaGIsTCN23/JI=;
        b=zSfYErVihtWILD/QzPhxg+FT7es2tdaXKiryb8Q0A8bqZ2/BcXwcQ2RO+8LcdN+RrU
         2BEefEh1CRhCc+IjwgSCdA6PUBfDeiG2k6h57m7vpEE98VukbNJ9jMQkkx0Vao/rpcQr
         xPGRpz50zdtPiQx7ApX8qJrO36nRKOt9VzdHpXtXoET+pcH9egUqrfD71IED8QmMxUeh
         uxzU8gofJgAfkWqF0XnlEvx58Ue8HUwBiaV4ayAUg9R516qnDT5EOPODIlXhtQBlqowr
         CqkTkD+CZpYDoa/FhYgVLCREZ36Nf4h7BbbWWA5kpRTPp3X5n2g7TsmdvRGXfrs7/Juq
         AfxA==
X-Gm-Message-State: AOAM531GZH2CxhGygU/PlqV7/KWD3cDzRkSvrgJ2dqNe/W04SbagcuJx
        h9N7qNmybVTu1OpzUrzd5MQbbOu34qmBqMJ/l1jKQSy9
X-Google-Smtp-Source: ABdhPJxbep/n43sV1q9mnlvRyLJF8PEQI/TRth8de/xmRePf4Td9GNDiDEnxffMIwIJhaUPFtEk7Tf7jg65nb5BKQXw=
X-Received: by 2002:a05:6830:165a:: with SMTP id h26mr4489432otr.301.1632404116454;
 Thu, 23 Sep 2021 06:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <1800633.tdWV9SEqCh@kreacher> <8879480.rMLUfLXkoz@kreacher>
 <069444f7-d623-fae2-5cd0-83cbbc919aff@gmail.com> <CAJZ5v0gpodPPXTagy5gFFf6mp_jCAdc864CE_giaue72ke7UyQ@mail.gmail.com>
 <013e3a7b-ec67-1a67-c2b9-e1fbb11c664e@gmail.com>
In-Reply-To: <013e3a7b-ec67-1a67-c2b9-e1fbb11c664e@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Sep 2021 15:35:05 +0200
Message-ID: <CAJZ5v0h5TJVCJ+vEon8qK3LVfS_sNbne-M98tiJf2K2uBS6wmw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] PCI: ACPI: PM: Do not use pci_platform_pm_ops for ACPI
To:     Ferry Toth <fntoth@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 23, 2021 at 3:26 PM Ferry Toth <fntoth@gmail.com> wrote:
>
> Hi,
>
> Op 23-09-2021 om 13:30 schreef Rafael J. Wysocki:
>
> On Wed, Sep 22, 2021 at 11:31 PM Ferry Toth <fntoth@gmail.com> wrote:
>
> Hi,
> Op 20-09-2021 om 21:17 schreef Rafael J. Wysocki:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Using struct pci_platform_pm_ops for ACPI adds unnecessary
> indirection to the interactions between the PCI core and ACPI PM,
> which is also subject to retpolines.
>
> Moreover, it is not particularly clear from the current code that,
> as far as PCI PM is concerned, "platform" really means just ACPI
> except for the special casess when Intel MID PCI PM is used or when
> ACPI support is disabled (through the kernel config or command line,
> or because there are no usable ACPI tables on the system).
>
> To address the above, rework the PCI PM code to invoke ACPI PM
> functions directly as needed and drop the acpi_pci_platform_pm
> object that is not necessary any more.
>
> Accordingly, update some of the ACPI PM functions in question to do
> extra checks in case the ACPI support is disabled (which previously
> was taken care of by avoiding to set the pci_platform_ops pointer
> in those cases).
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v1 -> v2:
>      * Rebase on top of the new [1/7] and move dropping struct
>        pci_platform_pm_ops to a separate patch.
>
> I wanted to test this series on 5.15-rc2 but this patch 2/7 doesn't
> apply (after 1/7 applied). Should I apply this on another tree?
>
> This is on top of
> https://patchwork.kernel.org/project/linux-acpi/patch/2793105.e9J7NaK4W3@kreacher/
> which is not yet in any tree.
>
> Sorry for the confusion.
>
> No problem at all. If I can I will try to report back tonight. Else, will be delayed 2 due to a short break.

Thank you!
