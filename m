Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1247806DE
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 10:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358425AbjHRIGf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 18 Aug 2023 04:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358481AbjHRIGZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 04:06:25 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAFF12C;
        Fri, 18 Aug 2023 01:06:24 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1c530d5468bso40442fac.0;
        Fri, 18 Aug 2023 01:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692345984; x=1692950784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H992Z9mf9CvnzKqXQlpQk9nwjNJ5gBcmvI8y0hRGNQs=;
        b=dx5q8LOOioNBHLDAXxbvCL5Mcca8OjcmNPRcfhmZQdFTLdKAUl9iuoHQmXrgDeD5Me
         wMdGXFqdPHMmIufdy25Bv12eIodWclM5kvnH2gvdL6jVobo8d8WDEJv/MHZo2wCQZJIN
         /NneWbwhMT47ZKnO+ZX0IBEEnG9Q1Hl7tZx0MhPuv/r3M0pZ9AtMuHr+9cliiczHcVP1
         Tnm+r3Ovvd0dU2mxCWPbcaJX3NIai+EaQjOvih3VPMXKzXTULKtfPSXcJ0cZMzGI6vkM
         cTNQCZS3ZgR1wLjAgnbh402FNoAFJY4Rq81wJ7P/Iw5JxW3qVenb21Cvj2wynde5sXBE
         e5uA==
X-Gm-Message-State: AOJu0YwL40Wrz2bRF1Gj31y/rJjUwq3v4wAjDG3xvMzVBXxrG9ghdbgV
        F0kdsN4OtIttYE9PaKoXw8eyv0oBD+1rkUy9zLA=
X-Google-Smtp-Source: AGHT+IFgpETq89yxTzwMZYwgeftUAFi/MN9gdShXeh4jFuUfNXZZfmUJSbjtv9TV9IymuW3/VzBvLjP//SYBo0LrvUw=
X-Received: by 2002:a05:6870:e390:b0:1b3:8cfd:fecf with SMTP id
 x16-20020a056870e39000b001b38cfdfecfmr1863369oad.0.1692345984090; Fri, 18 Aug
 2023 01:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230818051319.551-1-mario.limonciello@amd.com>
In-Reply-To: <20230818051319.551-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Aug 2023 10:06:12 +0200
Message-ID: <CAJZ5v0jbhq0Wnnk7qg0--bLLNY+YEWDahiJX4yuBzE=5Q2i0NA@mail.gmail.com>
Subject: Re: [PATCH v13 00/12] Fix wakeup problems on some AMD platforms
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 18, 2023 at 7:14 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Problems have been reported on AMD laptops with suspend/resume
> where particular root ports are put into D3 and then the system is unable
> to resume properly.
>
> This is caused by the policy used by the Linux kernel to put PCIe root ports
> into D3. This series adjusts the policy to be more conservative and only
> put root ports into D3 if the platform has indicated that it is necessary
> to do so.
>
> Andy Shevchenko (1):
>   ACPI: x86: s2idle: Add for_each_lpi_constraint() helper
>
> Mario Limonciello (11):
>   PCI: Only put Intel PCIe ports >= 2015 into D3
>   ACPI: Add comments to clarify some #ifdef statements
>   ACPI: Adjust #ifdef for *_lps0_dev use
>   ACPI: x86: s2idle: Post-increment variables when getting constraints
>   ACPI: x86: s2idle: Catch multiple ACPI_TYPE_PACKAGE objects
>   ACPI: x86: s2idle: Fix a logic error parsing AMD constraints table
>   ACPI: x86: s2idle: Add more debugging for AMD constraints parsing
>   ACPI: x86: s2idle: Add a function to get constraints for a device
>   PCI: ACPI: Add helper functions for converting ACPI <->PCI states
>   PCI: ACPI: Use device constraints to opt devices into D3 support
>   PCI: ACPI: Limit the Intel specific opt-in to D3 to 2024

I think that patches [02-08/11] can be applied before the rest of the series.

In fact, I'd like to do that and expose a forward-only branch containing them.

Then, patches [1,09-11/11] will become a separate PCI/ACPI specific
series that should be somewhat easier to grasp.

What do you think?
