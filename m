Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E0E587B07
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 12:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbiHBKtr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 06:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbiHBKtq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 06:49:46 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3A8C50;
        Tue,  2 Aug 2022 03:49:45 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so14899917pjf.5;
        Tue, 02 Aug 2022 03:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=W1oxJVUbD6Eo8z4KG5eAwZXphOR7ew3ZEZu8lUBJ+WY=;
        b=CviIUA8N5sozDRXYGze1xuxDs1rC4dHqmQSKVcfixLwcgIwUnkS5DiV4f+X7BFQg98
         eTnlJNjr5r4mhRlwzP/HzOKJpmXJzQC35NkvMxr6NQWqOhOR5zcSnkzcRecjy8o773aM
         RIUwCzfEwMPn+JNHSRvIb4HBaPVH7C7VDJUZF2maaDevC4Ls4mDYcuTH+WqJ2ZjT/4OO
         WmLj0C/IoeH6zay58m1o4GjPumAegsaJYT/zSd7I+x9a0aKxFWgFmhupmuHm8KkkdtDm
         xS6ctPMBRf7IeWnTW+PMVmLhnG1uQ+Firh7fAhia9jH8IETS2AxvNDyWPXtWe1ZFx3tS
         oU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=W1oxJVUbD6Eo8z4KG5eAwZXphOR7ew3ZEZu8lUBJ+WY=;
        b=gtx61m9ICcvZ2oBvJo1GkxLV/iXvTWz9Bsh4orROYriUZmvPMNYhOgVPeCVhuAFGX5
         QrPvmwPu+krkdBVAP2rLIskwX/vfGmQS7/SDPCd6Aq84nbvat2SiS4twFxh4SgVacXP0
         +Tvi9fUBtKCGa0IfSZ27DiQ3cw6f7epsQa/kGXmZ/HRFVHsGYRnHZp01xvvq6tZDYX6K
         MND5dOLBRar4i0AY+W9PrbHFudJiJ5g75m7xx02pojIVrm3fbWuhzZ1E3rlydLCyzkhH
         cxULeu5+VNwEH+GBIQXGNhriBMlA/gEy6AFl0TtN7g//lCApEkev/bw7T+Ze3gztxolm
         v5xQ==
X-Gm-Message-State: ACgBeo0tLOo96/gmS53iJXMTjRR5UyTflmCuZyHCmxTmKjfzw3FEgY5R
        eokdj5K/RgTkkdEpsmStiZPNq7lsCX1hwTg+xzM=
X-Google-Smtp-Source: AA6agR5AofqthFFU1yTaAa+1I3yxTOPzpDzlkU5YJASn1lZPNnEReWav0hxLHHtw/Ns2608daBdd9yoZX0K9+99BBlk=
X-Received: by 2002:a17:90b:4b07:b0:1f5:37d3:fb40 with SMTP id
 lx7-20020a17090b4b0700b001f537d3fb40mr258487pjb.12.1659437384953; Tue, 02 Aug
 2022 03:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <YuenvTPwQj022P13@kili> <YueoPDOseM1BGiXD@kili>
In-Reply-To: <YueoPDOseM1BGiXD@kili>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 2 Aug 2022 16:19:33 +0530
Message-ID: <CAFqt6zaLY3_DKC-=NJSrgzePrDS-q-dfUQxrN9puBf0+qVNfUg@mail.gmail.com>
Subject: Re: [PATCH 2/2] NTB: EPF: Tidy up some bounds checks
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Mason <jdmason@kudzu.us>, Frank Li <Frank.Li@nxp.com>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
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

On Mon, Aug 1, 2022 at 3:47 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> This sscanf() is reading from the filename which was set by the kernel
> so it should be trust worthy.  Although the data is likely trust worthy
> there is some bounds checking but unfortunately, it is not complete or
> consistent.  Additionally, the Smatch static checker marks everything
> that comes from sscanf() as tainted and so Smatch complains that this
> code can lead to an out of bounds issue.  Let's clean things up and make
> Smatch happy.
>
> The first problem is that there is no bounds checking in the _show()
> functions.  The _store() and _show() functions are very similar so make
> the bounds checking the same in both.
>
> The second issue is that if "win_no" is zero it leads to an array
> underflow so add an if (win_no <= 0) check for that.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index cf338f3cf348..a7fe86f43739 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -831,9 +831,16 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,            \
>  {                                                                      \
>         struct config_group *group = to_config_group(item);             \
>         struct epf_ntb *ntb = to_epf_ntb(group);                        \
> +       struct device *dev = &ntb->epf->dev;                            \
>         int win_no;                                                     \
>                                                                         \
> -       sscanf(#_name, "mw%d", &win_no);                                \
> +       if (sscanf(#_name, "mw%d", &win_no) != 1)                       \
> +               return -EINVAL;                                         \
> +                                                                       \
> +       if (win_no <= 0 || win_no > ntb->num_mws) {                     \
> +               dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
> +               return -EINVAL;                                         \
> +       }                                                               \
>                                                                         \
>         return sprintf(page, "%lld\n", ntb->mws_size[win_no - 1]);      \
>  }
> @@ -856,7 +863,7 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,    \
>         if (sscanf(#_name, "mw%d", &win_no) != 1)                       \
>                 return -EINVAL;                                         \
>                                                                         \
> -       if (ntb->num_mws < win_no) {                                    \
> +       if (win_no <= 0 || win_no > ntb->num_mws) {                     \

This might change the existing logic. will it be ?
if (win_no <= 0 || win_no >= ntb->num_mws) {


>                 dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
>                 return -EINVAL;                                         \
>         }                                                               \
> --
> 2.35.1
>
