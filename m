Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257985F682D
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 15:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiJFNbx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 09:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiJFNbu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 09:31:50 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24BDAA374;
        Thu,  6 Oct 2022 06:31:26 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id u21so2802061edi.9;
        Thu, 06 Oct 2022 06:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6ZdDTmo4+335EbBvlEmQjT8GDpny2W8EHJfskLeQgYU=;
        b=OM8dnY2tg5vevPKL7Mnvbt5ETiaM4d58uhREXqFxxKt0/V8KauGHkWTvb7x2Oqt0IQ
         aEejxhNdge0oFvaJY8CAdxgnWAgK4wSbysP8CQBrYZU3tVc/HUG18oqON1Qc4k0HyvmX
         xlO3nuv08QPmrsaC57vOL93rMqf5EgWpd8LoA0wI1km1qOGq2FaqvoFLcrHX61sGkweU
         UCD0Mp5xzvsFNg18sdEOvnJG0+cBg12+ROqA3DOYIVWuyz7cndaSK170EIJX7lh9BErx
         EWob7RD84FlsXzau9HMYQ7oaLWlnBSdFxt77whBg73BDOMcQkml0e3x8yR7IJXGg4cVc
         iYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6ZdDTmo4+335EbBvlEmQjT8GDpny2W8EHJfskLeQgYU=;
        b=n6kqmsHs5KkljSLHqndvoQYvwFSU+DqTroM42HQkNdIZS9bBSOSh5u1XsxEVwaIyN4
         NTgnulLX2dGKARqO6nQUTZ3u0kJe+3YmkQ2sg7hzhBMRB7kHfxGFSz11kKJzj0nGrTXF
         6oZ08R4Z5MY1fuQEGiGs2DhNymWRycZ95gkLxWbki856Ayw4JMAXmhk7WsatGXCStCr5
         Kh28wYdvgm8ZyYEq9hgfMxXbrZg8h9Xjkl2G+xbzvMXah1h9AQ/lRlzz3rCKn4I+kHod
         GZTr9uQMh7J1LlwSS2607mm31XoH0KUeDp0BYTJ3lvFnyD2bfx9TprsDbmZVOACp24FR
         u1Tg==
X-Gm-Message-State: ACrzQf2oS/ppGn/uLo9iSdCDlyLi4LciBWCc7rWiDgN92+7d1EHFmrMu
        Bl+3QaVOSvRqpIwwJezF+TT+4DewXXMxX1Vty2Y=
X-Google-Smtp-Source: AMsMyM5EPdeLuWOWDgXAOEFMd2VbWS3fbiofJOic5lMpfbYcw1O+Uxlkjte/6Xq5LeSybtdVQY6hogt1NJyXHeeymfo=
X-Received: by 2002:a05:6402:524d:b0:459:3619:9cfa with SMTP id
 t13-20020a056402524d00b0045936199cfamr4749148edd.227.1665062993966; Thu, 06
 Oct 2022 06:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221006092929.30041-1-jgross@suse.com>
In-Reply-To: <20221006092929.30041-1-jgross@suse.com>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Thu, 6 Oct 2022 09:29:41 -0400
Message-ID: <CAKf6xpvS20J0oz6vn+g47OBbKxEhAC8f2gyQ9otj+rOn+L9FOw@mail.gmail.com>
Subject: Re: [PATCH] xen/pcifront: move xenstore config scanning into sub-function
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

On Thu, Oct 6, 2022 at 5:29 AM Juergen Gross <jgross@suse.com> wrote:
>
> pcifront_try_connect() and pcifront_attach_devices() share a large
> chunk of duplicated code for reading the config information from
> Xenstore, which only differs regarding a function call.
>
> Put that code into a new sub-function. While at it fix the error
> reporting in case the root-xx node had the wrong format.
>
> As the return value of pcifront_try_connect() and
> pcifront_attach_devices() are not used anywhere make those functions
> return void. As an additional bonus this removes the dubious return
> of -EFAULT in case of an unexpected driver state.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  drivers/pci/xen-pcifront.c | 133 +++++++++++--------------------------
>  1 file changed, 40 insertions(+), 93 deletions(-)
>
> diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
> index 689271c4245c..a68e47dcdd7e 100644
> --- a/drivers/pci/xen-pcifront.c
> +++ b/drivers/pci/xen-pcifront.c
> @@ -819,76 +819,79 @@ static int pcifront_publish_info(struct pcifront_device *pdev)

>         err = xenbus_scanf(XBT_NIL, pdev->xdev->otherend,
>                            "root_num", "%d", &num_roots);
>         if (err == -ENOENT) {
>                 xenbus_dev_error(pdev->xdev, err,
>                                  "No PCI Roots found, trying 0000:00");
> -               err = pcifront_scan_root(pdev, 0, 0);
> +               if (rescan)
> +                       err = pcifront_rescan_root(pdev, 0, 0);
> +               else
> +                       err = pcifront_scan_root(pdev, 0, 0);

Early in pcifront_rescan_root(), we have:

        b = pci_find_bus(domain, bus);
        if (!b)
                /* If the bus is unknown, create it. */
                return pcifront_scan_root(pdev, domain, bus);

pcifront_scan_root() does some allocation, but the later scanning
matches that of pcifront_rescan_root().  So I think we can just always
call pcifront_rescan_root() and it should do the right thing.  That
drops the need for the rescan boolean.

Regardless of the above idea:

Reviewed-by: Jason Andryuk <jandryuk@gmail.com>

Regards,
Jason
