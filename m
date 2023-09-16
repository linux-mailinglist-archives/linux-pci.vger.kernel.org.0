Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D82A7A3354
	for <lists+linux-pci@lfdr.de>; Sun, 17 Sep 2023 01:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjIPXFu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Sep 2023 19:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjIPXFr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Sep 2023 19:05:47 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11062CD1;
        Sat, 16 Sep 2023 16:05:41 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50300cb4776so1409157e87.3;
        Sat, 16 Sep 2023 16:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694905539; x=1695510339; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8qmry3f1dKS9XSay+/EcqKiwhJ290GuK83cA4dSJTow=;
        b=Z2Ah3o8j0PFJcpOXlPobPQmry97fkq6aKbnN9ZpGBrzW9LDfJAF8A7gzj4v2BnM731
         m50IDM4u//4agiSZmcft5bhZJRdGceuB3Y4CfY9rOZi5VEB1+Qo0mgIvytFnOrrh29Yp
         h7FAi4lyNwKslS4Vb0CnXjNYviM7EirOybynrpfZUK4Ix82hSAHIri1k8Hl9HLWpypd2
         8twyVWWM5+q8yQ03pOMIwdbcW1FBEAAXl21aMrMGI7DroKrK/zsIH/5r+t2AkokP7iyj
         i1RPHwcarcaOnSbZnFlxwdm0bL6Axe3DJlgAN3kLs0+nfTQ8595fOKYH+R3gqK/M/CTI
         v9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694905539; x=1695510339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qmry3f1dKS9XSay+/EcqKiwhJ290GuK83cA4dSJTow=;
        b=lv0NZyAjvtUXS7dRCS3nvX4ctXbTY1O/jLB6Abfg9UxAWNBaQRel8WG9doANodPdK5
         tRFbzbOXVzFd5PkY95/b/3vICaHUrPmtAfFHfuDXSy3zg9k4n/bjjWgZmruocOzME3Jf
         9SAaSFDIY6uKmEYLOBBaVyJRFd8R9EaT/ZX/51lfSGCz5GuzIICH/XDrRFOgrAk8xiP3
         DTTgaZeclFypVVez5qxzf9v8jER/257WcbNOEll4405MFI+EePTakmcdW7FevYUP5qV+
         ayF4wVgts80S4A9VX0sQZPRgY53XfKJhple85bL2wFIyf3maNerRxqb2iaTTnowopVg0
         IC0Q==
X-Gm-Message-State: AOJu0YyEBAc/1l1BNvte1TwuMDjO06OK2H5PlDsDgypYmSD3xHE+7dQD
        JY8o5Gc4eYCZU/TUisxJllUmihNGEFV9KiSKilE=
X-Google-Smtp-Source: AGHT+IEVVgRoyN4fUdQy321FNnju/vPTuIiGoc4HDyEWId4+9iEJEh17spLil47FB9PdGig5vTI7bQicgK2TNBUKxlE=
X-Received: by 2002:a05:6512:28c:b0:500:daf6:3898 with SMTP id
 j12-20020a056512028c00b00500daf63898mr4364733lfp.26.1694905539036; Sat, 16
 Sep 2023 16:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <88ffb216-96f9-f232-7fe5-48bf82e6aa70@gmail.com> <CANiJ1U9-2zfc5aJJUaYnTBTg+2vMjcfgsuxcFFnn+CjVQ1fCoA@mail.gmail.com>
In-Reply-To: <CANiJ1U9-2zfc5aJJUaYnTBTg+2vMjcfgsuxcFFnn+CjVQ1fCoA@mail.gmail.com>
From:   brett hassall <brett.hassall@gmail.com>
Date:   Sun, 17 Sep 2023 09:05:27 +1000
Message-ID: <CANiJ1U9renpjKDfSbFVTvt-G+P6iP3n4iN3_gzuVk_3DTWfJdg@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

The Ubuntu devs have reverted their 3 patches and replaced them with 2
new patches.

Given this happened in the last week, I'll hold off submitting a patch
for now and see what Ubuntu does

Thanks
Brett


On Tue, 5 Sept 2023 at 06:25, brett hassall <brett.hassall@gmail.com> wrote:
>
> Hi
>
> I contacted the Ubuntu developers to see if they were ok with using
> their patches.
>
> They advised the patches were outdated and further development was
> under discussion.
>
> The current patches work and would benefit Linux users until something
> better comes along.
>
> Would you like me to proceed with the formal patch still ?
>
> Thanks
> Brett
>
>
> On Wed, 30 Aug 2023 at 11:11, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >
> > Hi,
> >
> > I notice a bug report on Bugzilla [1]. Quoting from it:
> >
> > > v6.5 (and at least v5.15, v5.19 and v6.4 as well) will not go to a higher power saving level than package C3.
> > >
> > > With the inclusion of a patch that combines 3 Ubuntu commits related to VMD ASPM & LTR, package C8 is used.
> >
> > See Bugzilla for the full thread.
> >
> > FYI, the attached proposed fix is the same as Brett's another BZ report [2].
> > I include it for upstreaming.
> >
> > To Brett: Would you like to submit the proper, formal patch (see
> > Documentation/process/submitting-patches.rst for details)?
> >
> > Thanks.
> >
> > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217841
> > [2]: https://bugzilla.kernel.org/show_bug.cgi?id=217828
> >
> > --
> > An old man doll... just what I always wanted! - Clara
