Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B6652FE98
	for <lists+linux-pci@lfdr.de>; Sat, 21 May 2022 19:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348035AbiEURiG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 21 May 2022 13:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbiEURiF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 21 May 2022 13:38:05 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF32A5D181;
        Sat, 21 May 2022 10:38:01 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id a38so7402021pgl.9;
        Sat, 21 May 2022 10:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4EbTUlhTEpoUgQqWiI/dseKqBh8sQfu3BdkMvRGGeSQ=;
        b=gMxtn02BzmVK2fLgjDLTx3m0VlYVJFnXZwArUzwsiQLnp+C34BAbgoyxSI2ytRUJYF
         1q2RfsV++yqeO4bLRenKF5eQXVrlhCcWh8aORpbzTKEYcOeD+1UbIlt11k7k4im7QGHJ
         25SOwzcv9Po8qVkUrne1iVHdfKS9RJQUQgxjORkQft9TRAk4YSVevGSvxN0BZSw0df9P
         CJ71Z+/m4cZR5oG93tcmJjkfy6wvjEuUtYPXM2DQnMsrbCG9IZZ0oX/q4cznO+V9tOjN
         COZxKZvv+9+NUGPoxq8FBo/39XICXa86QQUszB+vofYbQEYgjum4bgzAUFE0DOi+aTIL
         vrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4EbTUlhTEpoUgQqWiI/dseKqBh8sQfu3BdkMvRGGeSQ=;
        b=oGxyPOjYbopf3grRwaAP4TVpWIN7gMcBap/x5meZ+33/I6/UslRg7dhJ8XnDwrR2fJ
         90czuPCzg2To1t0wHcxKrFK8PBH0pQN7/k+vKkHcaelbjgaPvGDyJqk+srq0hedaJmJ0
         dzUPD0+AMLQsBqDMHDaED+wL1oPtrFy0W53q88ksRGQIhDYpE+99SXaGdgmgkuQCJunZ
         8JuGLblUH9mC6l2IFgDuQd448cCi4qEN1CnKKdXAWmd5XRlnjQDJX2Y8jT0c6+VkTFrr
         uaEBRGMi7SP/78jGrdR7f8kFjlGI8nKKA0/HqaMm1XrT0L2dQ75ALB+6qSZMuGoe4hFW
         bitA==
X-Gm-Message-State: AOAM532+oN6smvDi8woPp1jQSwLhMZko81uxzlQshq2JdS3Ne2H2Jq6c
        DGUsmZx5gQm4NxyRIAiBNPhPR0YCb9arL34n71LnUBjAEQU=
X-Google-Smtp-Source: ABdhPJzYQeVFwn0ZWuM9sm8UuKQynw5mtvsUTuEIgXR6kr5lI32ADsDs3R0xUlWigqGM85RL2tm8Jq6ZLYqLHEghlno=
X-Received: by 2002:a05:6a00:1501:b0:510:7ab8:71c8 with SMTP id
 q1-20020a056a00150100b005107ab871c8mr15648138pfu.63.1653154681477; Sat, 21
 May 2022 10:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220516165740.6256af51.alex.williamson@redhat.com>
 <20220518115432.76183-1-windy.bi.enflame@gmail.com> <20220520064148.GA20418@wunner.de>
 <CAGdb+H2_pX4TzG=sJ8XE6KiyWW9niJQawCbcDN2byxDfybukiA@mail.gmail.com> <20220521124910.GA13556@wunner.de>
In-Reply-To: <20220521124910.GA13556@wunner.de>
From:   Sheng Bi <windy.bi.enflame@gmail.com>
Date:   Sun, 22 May 2022 01:37:50 +0800
Message-ID: <CAGdb+H19bfbXM1cPJvhh6gixJbF7Sk=v53d9VpvWY8HEs0mSKg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Fix no-op wait after secondary bus reset
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 21, 2022 at 8:49 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Sat, May 21, 2022 at 04:36:10PM +0800, Sheng Bi wrote:
> > If so, I also want to align the polling things mentioned in the
> > question from Alex, since pci_dev_wait() is also used for reset
> > functions other than SBR. To Bjorn, Alex, Lucas, how do you think if
> > we need to change the polling in pci_dev_wait() to 20ms intervals, or
> > keep binary exponential back-off with probable unexpected extra
> > timeout delay.
>
> The exponential backoff should probably be capped at some point
> to avoid excessive wait delays.  I guess the rationale for
> exponential backoff is to not poll too frequently.
> Capping at 20 msec or 100 msec may be reasonable, i.e.:
>
> -               delay *= 2;
> +               delay = min(delay * 2, 100);
>
> Thanks,
>
> Lukas

Capping at 20 or 100 msec seems reasonable to me. Btw, since 20 msec
is not a long time in these scenarios, how about changing to a fixed
20 msec interval? Thanks,

windy
