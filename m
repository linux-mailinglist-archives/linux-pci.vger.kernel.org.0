Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF78372CEE2
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jun 2023 21:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbjFLTBs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jun 2023 15:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFLTBn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2023 15:01:43 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C27EAD;
        Mon, 12 Jun 2023 12:01:41 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b1b66a8fd5so55640191fa.0;
        Mon, 12 Jun 2023 12:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686596500; x=1689188500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tPslRpjpmso2MPWsMdmL6DPNcLL5+xYYi4A+RaMyHFw=;
        b=OFjQA+J1W/PiFJbxvsBMuO3m4v+HYcWQu3J7f1mJiJsbSrwRY3LBoQDxiWYo44n5VO
         AjNI+g+Bk7GNcbBDW7OA54Un72JOyw9qSUTaF/VlWJvH8ivGvkrq5HMqMHk8EkyAoZZq
         C+rNM9XKByrOgp9aTfJPMGNhRAOTGHy6k+NfrGFT4Z3j0NQZuNROOJeMlj2LduVPXvIc
         R5mQNv/b4OjFEk2OY+j2hTovfX+tvaK7MxW8TIvMRWlKSyoZqu2ihwS1Te6HFIIADLGr
         Ywjmgazpz0XOYrz20R5/ETz2ia2vl2NIxFvcTrhF6wXA9DyNLwgsgIE/24QslqoTiFFb
         SBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686596500; x=1689188500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPslRpjpmso2MPWsMdmL6DPNcLL5+xYYi4A+RaMyHFw=;
        b=g3bgXAUQRvfl8xHnEXNxHtsDXXnG+I7YUr+1REoZDhIFaix8f+XgaNoika/m/P5euA
         h6hvAdEVL+H4l8nFYYNCuh97lptotP2VdW4LMt47yH5gHLoogSUQ3j5o4N+GONRK+Akm
         ipfj9td6B5VjDPYygCSzRbbBuLNk1KBwMK5JiLCxhlKY7rDhDdzi5NY63vyLv830iaKP
         Qp/juRXeMN6sfQ96XW/Us1Fb9agHiGMwJ4aZPKbpRlL0Hbj6bomwnURfLIu1zzlGDDfY
         l04uePzdsS24JdrKT0HK5U44NVz+7iZL6O6Hpq1n5JIMriZkDeppPLUZAzE90YKOMEfQ
         vQzw==
X-Gm-Message-State: AC+VfDy1ErLTFLnKlAi1m2shawyTMefv81pEM6bIMGekU7ehj7zEo2qw
        a6gcwG8BoBMO5ZS5zw3sB0s=
X-Google-Smtp-Source: ACHHUZ76YBcUqtOty80aUfVOuOpZXEETG9HpkQWQR/6rrihf6bQA4ouF6F8X9gV8CcPfKkQKE3kN6w==
X-Received: by 2002:a2e:9b8b:0:b0:2b1:df8a:1451 with SMTP id z11-20020a2e9b8b000000b002b1df8a1451mr3176914lji.47.1686596499245;
        Mon, 12 Jun 2023 12:01:39 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id r11-20020a2eb60b000000b002b2289d2c24sm1593034ljn.85.2023.06.12.12.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 12:01:38 -0700 (PDT)
Date:   Mon, 12 Jun 2023 22:01:31 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v7 00/11] PCI: dwc: Relatively simple fixes and
 cleanups
Message-ID: <20230612190131.otvaqvpwumncdufk@mobilestation>
References: <20230612164124.ytqn5lfeaxds6ywq@mobilestation>
 <20230612171608.GA1339616@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612171608.GA1339616@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 12, 2023 at 12:16:08PM -0500, Bjorn Helgaas wrote:
> On Mon, Jun 12, 2023 at 07:41:24PM +0300, Serge Semin wrote:
> > On Mon, Jun 12, 2023 at 10:41:27AM -0500, Bjorn Helgaas wrote:
> > > On Sun, Jun 11, 2023 at 10:19:54PM +0300, Serge Semin wrote:
> > > > It turns out the recent DW PCIe-related patchset was merged in with
> > > > several relatively trivial issues left unsettled (noted by Bjorn and
> > > > Manivannan). All of these lefovers have been fixed in this patchset.
> > > > Namely the series starts with two bug-fixes. The first one concerns the
> > > > improper link-mode initialization in case if the CDM-check is enabled. The
> > > > second unfortunate mistake I made in the IP-core version type helper. In
> > > > particular instead of testing the IP-core version type the macro function
> > > > referred to the just IP-core version which obviously wasn't what I
> > > > intended.
> > > > ...
> > 
> > > I am unable to do anything with this series.
> > > 
> > > Google's legal team is reviewing this matter under applicable laws and
> > > regulations.
> > 
> > I don't get it, how come Google gets to decide anything about what to
> > do with this patchset?
> 

> I am employed by Google, and my Linux work is part of my job
> responsibility, so Google sets some boundaries on my activities.

Are you saying that Google can just like that affect the kernel
maintaining procedure by forcing their employees to ignore some other
developers work?  Nice, well done Google in "evolving" the open-source
community.

What do you suggest for us to do then? There are PCIe host and
endpoints drivers maintainers who aren't obligated by the Google
regulations: Lorenzo, Krzysztof, Rob. They are still able to merge the
series in to the PCI (or their own) repo since you are blocked by your
Google employer, right?

-Serge(y)

> 
> Bjorn
