Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E533783127
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 21:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjHUTYr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 21 Aug 2023 15:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjHUTYq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 15:24:46 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3772F11D;
        Mon, 21 Aug 2023 12:24:45 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-570b3ebb3faso157016eaf.0;
        Mon, 21 Aug 2023 12:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692645884; x=1693250684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/Oag4Z7Z5QXMnbgTamk1Dv4MZuDjKDPwDHH2S9rxXc=;
        b=Vinu1K0ZRI46NByaQxxKsmNBVIf+euTq3GJ/0+Stlh4kQfba1nY78Sv7Cg2YehYCoX
         svHxY9oi5byWTd5hBIKSxQlYna07ze8H0stCwDJycv5HEKCVuMCUKPbk3NLfPa+mz914
         qZnitAvMd8CNdNGHyjpbwtjAtX+s/3frZ4ipaglrpuip3zdRGgoYQs1YTv4qWOqqApGe
         vDDy9X2J5pAPerNsrPxevXSl76UFPKr2/3v6YghNJaqtdLMiGCzpx7R5w31gfq5rDleB
         jyFem6g3NAufnWHP3HWtIJV4RNscP3EiFAYsTGl+VNw3i9JdHM/d5zQ4Lz+QWE1kiNp0
         7N+A==
X-Gm-Message-State: AOJu0YyXfW3EQ6vQIRcSSb76XnmjcE5sCNnUJRF8rwUeFWjrKdAl7grz
        6reec+b4xYRoDx5Qavd+KieSM+N2KyNIfPVnvxY4Eoij
X-Google-Smtp-Source: AGHT+IF7CL9uUoXHdaya8+tzstnnnipw/wznUqwMJiBQnqRlthb15+sVRhW7Vt0VPHM7TMkV3Uw1NB2Mk+dftqo//FI=
X-Received: by 2002:a4a:e741:0:b0:56e:94ed:c098 with SMTP id
 n1-20020a4ae741000000b0056e94edc098mr7121268oov.0.1692645884454; Mon, 21 Aug
 2023 12:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230818194027.27559-1-mario.limonciello@amd.com>
 <20230818194027.27559-5-mario.limonciello@amd.com> <CAJZ5v0j_tmW1uWZF7ShK=fwnVGjjy8CSf7DJErJdSaD_dgW8WQ@mail.gmail.com>
 <2bec7ee5-2ead-4c46-b6eb-f4d7a2249293@amd.com>
In-Reply-To: <2bec7ee5-2ead-4c46-b6eb-f4d7a2249293@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Aug 2023 21:24:33 +0200
Message-ID: <CAJZ5v0jpWJC_9VEkXckZAPwcJESDvwncx3WzbLZn8a42U-zU1Q@mail.gmail.com>
Subject: Re: [PATCH v14.c 4/4] PCI: ACPI: Limit the Intel specific opt-in to
 D3 to 2024
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
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

On Mon, Aug 21, 2023 at 9:18 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
>
>
> On 8/21/2023 1:46 PM, Rafael J. Wysocki wrote:
> > On Fri, Aug 18, 2023 at 9:40 PM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> Intel systems that need to have PCIe ports in D3 for low power idle
> >> specify this by constraints on the ACPI PNP0D80 device. As this information
> >> is queried by acpi_pci_bridge_d3(), limit the DMI BIOS year check to stop
> >> at 2024. This will allow future systems to rely on the constraints check
> >> and ACPI checks to set up policy like non-Intel systems do.
> >
> > So I'm not sure about the value of this change.
> >
> > The behavior is made Intel-specific in [14a 1/1] and it will be that
> > way at least for some time.  This change only sets the date after
> > which it won't be Intel-specific any more, but for what reason
> > exactly?
> >
> > And why is 2024 the cut-off year (and not 2025, for example)?
>
> No particular reason other than it's a few kernel cycles to get this
> tested and working or revert it if it's a bad idea after all.
>
> >
> > If Intel platforms continue to be OK with putting all PCIe ports into
> > D3hot beyond 2024, why restrict the kernel from doing so on them?
>
> OK let me try to explain my thought process.
>
> The reason that root ports were put into D3 on Intel systems was that
> it's required for the system to get into the deepest state.
>
> At the time that it was introduced there wasn't a way for the firmware
> to express this desire for root ports that were not power manageable by
> ACPI.
>
> Constraints are a good way to express it, so by limiting the Intel
> hardcode to a number of years gets everyone onto the same codepaths.

Assuming that the will be used in future systems, but that is beyond
the control of anyone involved here I think.

> But that being said - if you would rather keep Intel as hardcode forever
> this patch can be dropped from the series.

This change can be made at any time and I don't see a particular
reason for making it right now.
