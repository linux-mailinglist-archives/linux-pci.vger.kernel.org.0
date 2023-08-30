Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6925378E0F0
	for <lists+linux-pci@lfdr.de>; Wed, 30 Aug 2023 22:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239786AbjH3Utn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Aug 2023 16:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239566AbjH3Utl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Aug 2023 16:49:41 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3691A2;
        Wed, 30 Aug 2023 13:49:08 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-99bed101b70so5177366b.3;
        Wed, 30 Aug 2023 13:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693428419; x=1694033219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H7+RNFydbYgwU33+rMvrroV0xhFvVbyEmKI0SQQ1IPc=;
        b=HHFM+sl2xF5Cj6wCyYl68IGsUEtj+9hhhXHmkwL1xrPoWrSifRFSK6PXDgYJg9VK9q
         gLDLodN3IyTugatel3QJlA4S7qBIJiJEmu8RwAbGqicqSMLI75pnTKhy9LKltifm/ntE
         IXK4nkfhnQBwlxJMUrDX2ix9kWeLm5pksj42tZBFC+idKtmlsLVuB6IDqONjFxiRrbrV
         QDrgu2XEJn+kg8afajmDT5jgAqe9+BfXN/iPlG1ntTH1QPLtPcFn08hwoPeE0xSj2leA
         rf+QUfUu3UHOyBAo/h7Avbj/3BdsFAlZNwgE4xg1PZuudpTJnXx6yRZSsLmSD30XC+N0
         NX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693428419; x=1694033219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7+RNFydbYgwU33+rMvrroV0xhFvVbyEmKI0SQQ1IPc=;
        b=ec2eX3QfZiUgUirpshgiZi1WuiQqs7TRnGxzj29lUOJvhIAq/kDFMGL9OSWAlKf32x
         qb31cHir5i2YBtQSzTUidzzCkANzAQGjJoq+rIidTLEKbG8EIRyAkAtrPJisbcwG5qMA
         N8qfAkEHQLS45E+x+ZrUDNFQ6YQT/PYsUhAauJTCtRQJUlLtYv60hxlqUzpuUta8GkE8
         R4nJJa1tSXRNiXZpWIRwi+G4abWeDOlwc1RGlDrS2aZsV5fHGmDS83LMTvhSwM6pdDsw
         6cFO55PM7cNxC8a7B4TY2ttE/smHiZS8TA5Nh15HdnDxr45fb4QoT9Qof89H+1EYLTlx
         NjwQ==
X-Gm-Message-State: AOJu0YzBzfIpLZuTT7puJ63vT5cWkZDfNN0uRDs5nvKOpM6NQ07zvJgs
        5IxGRc9e5oSabw4bCSMULtQe31AToGe215Ftokw=
X-Google-Smtp-Source: AGHT+IHiAZl/ZfM93EO73RMw6cC+cTC9r+ll2wJ6ots2bDFoCLwXyilxaxMGTvKxEz9IOIdQkqAjbZOzoFSbbp6GvN0=
X-Received: by 2002:a17:906:cc:b0:99d:dc0b:a89a with SMTP id
 12-20020a17090600cc00b0099ddc0ba89amr2747411eji.63.1693428419039; Wed, 30 Aug
 2023 13:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <88ffb216-96f9-f232-7fe5-48bf82e6aa70@gmail.com>
In-Reply-To: <88ffb216-96f9-f232-7fe5-48bf82e6aa70@gmail.com>
From:   brett hassall <brett.hassall@gmail.com>
Date:   Thu, 31 Aug 2023 06:46:47 +1000
Message-ID: <CANiJ1U_eysXU+i+7w6O7f7t5d4kfyT+yM=NbMH82YOLpaaDmJg@mail.gmail.com>
Subject: Re: upstream linux cannot achieve package C8 power saving
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ajay Agarwal <ajayagarwal@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

Ok, I will read into working up a formal patch.

Thanks for the reply.

Brett


On Wed, 30 Aug 2023 at 11:11, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> Hi,
>
> I notice a bug report on Bugzilla [1]. Quoting from it:
>
> > v6.5 (and at least v5.15, v5.19 and v6.4 as well) will not go to a higher power saving level than package C3.
> >
> > With the inclusion of a patch that combines 3 Ubuntu commits related to VMD ASPM & LTR, package C8 is used.
>
> See Bugzilla for the full thread.
>
> FYI, the attached proposed fix is the same as Brett's another BZ report [2].
> I include it for upstreaming.
>
> To Brett: Would you like to submit the proper, formal patch (see
> Documentation/process/submitting-patches.rst for details)?
>
> Thanks.
>
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217841
> [2]: https://bugzilla.kernel.org/show_bug.cgi?id=217828
>
> --
> An old man doll... just what I always wanted! - Clara
