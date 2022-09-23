Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EA85E8509
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 23:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbiIWVhp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 17:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbiIWVhe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 17:37:34 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD7C13FB5A;
        Fri, 23 Sep 2022 14:37:19 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z97so1844986ede.8;
        Fri, 23 Sep 2022 14:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fZlHev8bQtb8kI8zTMb1N1K9qOv/Nxnh2Lwk9ON3xLg=;
        b=oahUl3PreBwQKJk1BCxx5PJ3BhZFJmB8lt6OFbuObXT5LK+9sZbrIfRgkccJkL8Rqk
         wiK+AysmejlQ9sf6Z/5gmCYadKng1Rpilq+RiHIy/DGVufdJ06v/j0fCD0p3gXgFh0OI
         rOtp+WDtSZR5F82pjQgYPeLq+TpWoNqrrpkg6Nk8yrdPq9ROnXrtl61Na44zr4p1T2kJ
         wnLtW7EiwRYg64cSkmKn8cFiu5oBr6xXcArfD+j6WQsTdMO0o+OdQyiAC4OTc04SlTJ5
         1okVtRcf973aLJf6cHu64ZrjPzmZEf/6/6hbKG2kQWbuazpPqAZpYrK9tI5JhyPqHIpN
         pf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fZlHev8bQtb8kI8zTMb1N1K9qOv/Nxnh2Lwk9ON3xLg=;
        b=mbsXkXezbfp1E+EfzoWBiWCgbWnRq7khevW/bkABfQZEVn48sCpNpMaL2jdiyxd33e
         5CY+NndnUdssWei89PcOzyqC0MqG0/XBuJ8jb1Rr/6GfSCkLrg5nf95JN5vL/jCPrmVo
         he1FdUyRCYjY3X5qfSrmQ0I8tC9K+uLSBzQ4SSNHVOxnLGwRfGYiyP2sQDqrlBlZ1Kze
         lub7oGYv3T10hPkYfnl0ZfCzCEdlbC1xPa1o2DefgQN6Nqo3bhJWVT/B7vq74mdE+F94
         8b2cnVjPjp9OAusm9n/RPJ0QSrMtQebz7WbH2mp7d+cCoFRgqGiqnCVb450SlxkeLNHm
         +GAw==
X-Gm-Message-State: ACrzQf2ifnzQ4rGqtwSnkBnG28/g4zWHYXmpYknCYcD5Hfzsmj6WnQtO
        CHhIfDh1rzZRQmkqoeF9fGOfJJ97+hr2m8pfQ9k=
X-Google-Smtp-Source: AMsMyM65f4vvbfB0MHPmb1uXReLTpzwNtTSdfOxpF/5AtKDHfv9rKLkIo/9XefevXRnbo9OVG7oUBB2budgJ+mETlHE=
X-Received: by 2002:a05:6402:3549:b0:454:414e:a7fd with SMTP id
 f9-20020a056402354900b00454414ea7fdmr10842015edd.69.1663969038413; Fri, 23
 Sep 2022 14:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220919143340.4527-1-vidyas@nvidia.com> <20220919143340.4527-2-vidyas@nvidia.com>
In-Reply-To: <20220919143340.4527-2-vidyas@nvidia.com>
From:   Han Jingoo <jingoohan1@gmail.com>
Date:   Fri, 23 Sep 2022 14:37:07 -0700
Message-ID: <CAPOBaE63bAnzEzz+xkSN-J1sGxBgv4-tnJO-AjxsxPDzZcaViA@mail.gmail.com>
Subject: Re: [PATCH V1 1/2] PCI: Add PCI_PTM_CAP_RES macro
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 19, 2022 Vidya Sagar <vidyas@nvidia.com> wrote:
>
> Add macro defining Responder capable bit in Precision Time Measurement
> capability register.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Reviewed-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
>  include/uapi/linux/pci_regs.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 57b8e2ffb1dd..1c3591c8e09e 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1058,6 +1058,7 @@
>  /* Precision Time Measurement */
>  #define PCI_PTM_CAP                    0x04        /* PTM Capability */
>  #define  PCI_PTM_CAP_REQ               0x00000001  /* Requester capable */
> +#define  PCI_PTM_CAP_RES               0x00000002  /* Responder capable */
>  #define  PCI_PTM_CAP_ROOT              0x00000004  /* Root capable */
>  #define  PCI_PTM_GRANULARITY_MASK      0x0000FF00  /* Clock granularity */
>  #define PCI_PTM_CTRL                   0x08        /* PTM Control */
> --
> 2.17.1
>
