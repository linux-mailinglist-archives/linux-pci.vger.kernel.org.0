Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE6360D6E8
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 00:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiJYWSB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 18:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiJYWSB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 18:18:01 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F21FC58;
        Tue, 25 Oct 2022 15:18:00 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id o8so9907523qvw.5;
        Tue, 25 Oct 2022 15:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sBctOic5Jlqwv7dQ/OcbsCcYwMhW7gNKqj7DG4uh3kk=;
        b=a+L0eQQmLecyw0nknTLcGw/I7RrVyowZfcF3d2y+BIMofaBOYJ4McrsCEwcTEFSYZn
         NfY/oYnV48cHs+3vHUz4V4HRO6IkWdET4AqUgU5X5zETq4MsZGMdWmxaf5kaAWAIebgA
         bG1eqDVPEq34MjLvdkr/Z/33gCuG+t+yd/lGVsNphjS8Muzez6O+5RG4geeg8GXQ91Wv
         981Ug1LrzbF+aPqzZAHo4+z+csuOF90G6c9/HcojFmO/XCq1MkC8MziiJgdWIWsM3Bc+
         iMJkp+HJgDHG2WbkPg5NMRv2Fy3+HrfMJJNx2T9GuczkWqDRCHtnbHZyY9wdw8K++6by
         664g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBctOic5Jlqwv7dQ/OcbsCcYwMhW7gNKqj7DG4uh3kk=;
        b=nBe1graJ7PBVTmTb/tunKZsz+OiKlQehhGFuIvbGzY3tf3tbj8c+yLSKgI7pn/VaBC
         6gqn7BBNb38yE+SrpwFS7Pr/gz4WPvnYMaYZr50CFeE37WDyWeE8pLv7GryXHA9n1M2J
         5OEEEVX03/eIcHFmgMygFhwhKE8bp6eeavd9BrUyUgo7CkHGQmpja0RINwbvqxcStGZA
         5K8B8+ZM1dAUZ/IDEFp9KMM8pf0RXIqnx8bMvfIg43dFdoqbbUOwATnph/jh7gAr0ktl
         GmotcNHvpS9pB0M+mJNjEZpPPpp81smPdqW9jxcn5W4p4PxrzH5dwYMlmwZiESCbJdP8
         QyQA==
X-Gm-Message-State: ACrzQf1ShPVrfx7LhLsiYL4n1pzlL5FeXi06S/uVlQfisz9xyM5h0HEu
        NthJowMFiVtDZ6/nbF8HeWZchHgLsFUPuKrI6bE=
X-Google-Smtp-Source: AMsMyM7bwRfU/9iNaQbyljheW233pohShNkzDsvX5eCeD0iJDN+6nYrObBDYS85GAmjuVNxoNOwdcyLqfGLtXD+JT/0=
X-Received: by 2002:a05:6214:e86:b0:4bb:7e1a:9dee with SMTP id
 hf6-20020a0562140e8600b004bb7e1a9deemr8414735qvb.96.1666736279438; Tue, 25
 Oct 2022 15:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221025203852.681822-1-helgaas@kernel.org>
In-Reply-To: <20221025203852.681822-1-helgaas@kernel.org>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 26 Oct 2022 08:17:47 +1000
Message-ID: <CAPM=9twkfjHh4SR2aQdB9WTRYEhTdWZG4A-f0n8oB8yw=dZgyw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] agp: Convert to generic power management
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Airlie <airlied@redhat.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 26 Oct 2022 at 06:39, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Vaibhav converted several AGP drivers from legacy PCI power management to
> generic power management [1].  This series converts the rest of them.

Do you want to merge through the PCI tree?

Acked-by: Dave Airlie <airlied@redhat.com>

Dave.
>
> v1 posted at [2].
>
> Changes from v1 to v2:
>   - Convert from SIMPLE_DEV_PM_OPS() (which is deprecated) to
>     DEFINE_SIMPLE_DEV_PM_OPS() and remove __maybe_unused annotations.
>
> [1] https://lore.kernel.org/all/20210112080924.1038907-1-vaibhavgupta40@gmail.com/#t
> [2] https://lore.kernel.org/all/20220607034340.307318-1-helgaas@kernel.org/
>
> Bjorn Helgaas (8):
>   agp/efficeon: Convert to generic power management
>   agp/intel: Convert to generic power management
>   agp/amd-k7: Convert to generic power management
>   agp/ati: Convert to generic power management
>   agp/nvidia: Convert to generic power management
>   agp/amd64: Update to DEFINE_SIMPLE_DEV_PM_OPS()
>   agp/sis: Update to DEFINE_SIMPLE_DEV_PM_OPS()
>   agp/via: Update to DEFINE_SIMPLE_DEV_PM_OPS()
>
>  drivers/char/agp/amd-k7-agp.c   | 24 ++++--------------------
>  drivers/char/agp/amd64-agp.c    |  6 ++----
>  drivers/char/agp/ati-agp.c      | 22 ++++------------------
>  drivers/char/agp/efficeon-agp.c | 16 ++++------------
>  drivers/char/agp/intel-agp.c    | 11 +++++------
>  drivers/char/agp/nvidia-agp.c   | 24 ++++--------------------
>  drivers/char/agp/sis-agp.c      |  7 ++-----
>  drivers/char/agp/via-agp.c      |  6 ++----
>  8 files changed, 27 insertions(+), 89 deletions(-)
>
> --
> 2.25.1
>
