Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFE9791E32
	for <lists+linux-pci@lfdr.de>; Mon,  4 Sep 2023 22:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbjIDU0N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Sep 2023 16:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjIDU0M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Sep 2023 16:26:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFA2180;
        Mon,  4 Sep 2023 13:26:08 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52c88a03f99so2244889a12.2;
        Mon, 04 Sep 2023 13:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693859167; x=1694463967; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lXnvIlMPp5u/cZPb67xk/RAZDHLqGyudVRdveB/ZbLY=;
        b=Jigp5HdRo5+dvn+3nrGbwpV9iJemIs+qY9eznh8FztFQUQRCBWOkhguUSUVKyeLzpq
         zlTV1SgTLi7vHpn+mVHvm/AUPCIf2YGJrl5522epfg9noakMNR/IlRP+KF0IYiscv/FG
         sZ6U0UENtgfvnrFyD3ggg7WK3dll1+KYeDSJhEsr/yelWv4UUItmzyC0pmckrwKDT2VE
         Yomq/dEGL4q6dFo+leG1tqSysRgoVS/SP9mUHP0ZzyO3GduhPUX6U429tAVLOH0osFS0
         IuB7ElyV7t7DGMUbf45nFUWtMYSYUXLzy5bnTWHyNXbF6f2QwApbic8yW5EkLbAmcQYL
         CZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693859167; x=1694463967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXnvIlMPp5u/cZPb67xk/RAZDHLqGyudVRdveB/ZbLY=;
        b=KW2KKc/ADath6/N2qZZRwrFM2PLiJGJR0kKZHAqIHAfnhb7Mz73NrnwaUJvUStXHmc
         6/HehYDhjGtk+DIrdnkBoXsPnYb77AZfs05wn5EwfqDj9/mKEvwXHo1iyxCeXSnEkeNs
         ySSFADlqhDF5XHYSe4Zj0jw1Tua32wSFnsT+kS9H+0nuZlc7BM//0s2PXs5aW+jQuKA5
         RGLy4fUpUVg+cTxlqh/WoQrcHfOVxtnedLEPOd6/ffQRdIrsLs9h13PNHBJ8j6L3Pbto
         W9iaEo5bQNHzcEYyJVRmTeCrDtfEQvuTuUh+NKF0jfGaJXDLOrWi63AtQYjMghUJ58ZP
         fNEw==
X-Gm-Message-State: AOJu0Yxjd6sjHK951X448HgdkPAi0SMw22Bonj3Bu+0DpbixsIgjrLIm
        POf0Qjm1j9J1AmbkTAwcwgoX931E29JvjWzK8TTQZEEtZEY=
X-Google-Smtp-Source: AGHT+IG24dlXnnwhnhpbMLq5+johSI+3gKyPXR6QUWW8K2AHBtDt2PqcyJvBc46enRBKemtJkuc0SY2C/ykw4EP+1YE=
X-Received: by 2002:a05:6402:5159:b0:52a:943:9ab5 with SMTP id
 n25-20020a056402515900b0052a09439ab5mr8010894edd.31.1693859166815; Mon, 04
 Sep 2023 13:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <88ffb216-96f9-f232-7fe5-48bf82e6aa70@gmail.com>
In-Reply-To: <88ffb216-96f9-f232-7fe5-48bf82e6aa70@gmail.com>
From:   brett hassall <brett.hassall@gmail.com>
Date:   Tue, 5 Sep 2023 06:25:55 +1000
Message-ID: <CANiJ1U9-2zfc5aJJUaYnTBTg+2vMjcfgsuxcFFnn+CjVQ1fCoA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

I contacted the Ubuntu developers to see if they were ok with using
their patches.

They advised the patches were outdated and further development was
under discussion.

The current patches work and would benefit Linux users until something
better comes along.

Would you like me to proceed with the formal patch still ?

Thanks
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
