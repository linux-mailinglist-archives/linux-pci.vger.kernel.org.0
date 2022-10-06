Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E077F5F6BB7
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 18:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiJFQ1Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 12:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiJFQ1Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 12:27:24 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB40CE9BE;
        Thu,  6 Oct 2022 09:27:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id 13so5778822ejn.3;
        Thu, 06 Oct 2022 09:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1kXYRJVvVuB6/yCg+mLXa+n2OpJV2ALpI5+bxh3cOos=;
        b=CyGVdpIRf0cbkRRlaQmlIM4GbYrItWETO4moUB0zABjHGn+1Bb5HHwCCrwYBQSdG1z
         YC0Mo0XlKB75VeUZ/tJLkKEazynqHAdt2RXqbZQ7RFv78GUf5L3UQVLsOU6zdZEwiZac
         SBrkH5q2D8PZcWVlYrSSPu5iu5DNoO+XHQPihtd1TbNlapY8sRyKQqe9zKr/w/PEqZHR
         x0rPhaaRYuIGeVx/OGinB2GIMhzjl+TxEqwMsa/r4HYIyXFoF3EMA4Tvj4SsNs8OmWK5
         eD4wxZUqXbkkCQdkaKwPpGze4+jRMB4c54N9Tg/zx6n75XD1KXS/NRKR8cw9YpZv9dVv
         sDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1kXYRJVvVuB6/yCg+mLXa+n2OpJV2ALpI5+bxh3cOos=;
        b=zuiVJwCK7UnxbiwsavaEu6NbgpD9ouHRemYkLT3FJyMLSue6f19lRDIgAi0DGfKTqV
         AuKwMXP96XifSamyh39aGwnu0+ZjG1ssEBYzH0ToEPJUdzwFK5wPOyBLGQYUgZk4Gjuq
         C1RAMjwCt/HqRi5AWby9EK2fOqxSrYHTiVvoxjsaIRtYEJsKjayMpmVJSl6lvNytWOBs
         xMoVrqrf70cnFle6Z7VybGkNgQVE5GQLoa4ct4p7KcbyncIXfK1Ddp2W/s2C7JcGWQMD
         impKFTrSZ+pwi3CK+JDAVQrakCooFGgCZUtl/6pdd0WY1h71qKguLKUKFlAYFsokUjtz
         /c8A==
X-Gm-Message-State: ACrzQf18h8NT1S6uH3fplsi0l6hnX2/Rycv5x65VaGTeA6eSXixwVFbC
        GWZRpN1mqOQNI0zHhvk7lnbG/4ibRUfYNv+8ex4=
X-Google-Smtp-Source: AMsMyM6gC7LkWalsDjJCsF+lKGjCe9nrQw7x15pqRpmn46ydjr2W6YgI0uNqMQX0BN+RkIlpHUqujS6nxpuUk5qDvvg=
X-Received: by 2002:a17:907:6087:b0:78d:2d1c:c050 with SMTP id
 ht7-20020a170907608700b0078d2d1cc050mr538377ejc.481.1665073642415; Thu, 06
 Oct 2022 09:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221006153440.18049-1-jgross@suse.com>
In-Reply-To: <20221006153440.18049-1-jgross@suse.com>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Thu, 6 Oct 2022 12:27:09 -0400
Message-ID: <CAKf6xpvUat2HP_WO=LSxLC46=KN2exSmqn+DWHTN74HK6H2HLQ@mail.gmail.com>
Subject: Re: [PATCH v2] xen/pcifront: move xenstore config scanning into sub-function
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        xen-devel@lists.xenproject.org
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

On Thu, Oct 6, 2022 at 11:35 AM Juergen Gross <jgross@suse.com> wrote:
>
> pcifront_try_connect() and pcifront_attach_devices() share a large
> chunk of duplicated code for reading the config information from
> Xenstore, which only differs regarding calling pcifront_rescan_root()
> or pcifront_scan_root().
>
> Put that code into a new sub-function. It is fine to always call
> pcifront_rescan_root() from that common function, as it will fallback
> to pcifront_scan_root() if the domain/bus combination isn't known
> yet (and pcifront_scan_root() should never be called for an already
> kneon domain/bus combination anyway). In order to avoid duplicate

known

> messages for the fallback case move the check for domain/bus not knwon

known

> to the beginning of pcifront_rescan_root().
>
> While at it fix the error reporting in case the root-xx node had the
> wrong format.
>
> As the return value of pcifront_try_connect() and
> pcifront_attach_devices() are not used anywhere make those functions
> return void. As an additional bonus this removes the dubious return
> of -EFAULT in case of an unexpected driver state.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Jason Andryuk <jandryuk@gmail.com>
