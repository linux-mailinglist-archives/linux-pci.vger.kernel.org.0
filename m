Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1464C449F3A
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 00:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241046AbhKHX6Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 18:58:24 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:45044 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238960AbhKHX6Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Nov 2021 18:58:24 -0500
Received: by mail-lf1-f44.google.com with SMTP id y26so40004890lfa.11;
        Mon, 08 Nov 2021 15:55:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4CObGnDxrsjK7sTGFat7Zks+uHyi7ssYo0SjQ3zRggg=;
        b=gzsMerwGaPJDiyUAqTqq5Xn/NDL+5DGNMCe4sKO7hL4qYVmJLLcEv0KbrYXT5L/fir
         6aBOOEtp0ixS+gWqbq87MAFoEizenSZYlgbpZvgg21p1PqtB+5tS92IDW+jmNOgrQs8u
         2NI7rwxauQK+J05mct39W0k3vR2tYRyZB5SBI671g4dng8wQk7TCMLAUZ7uNRtQonIil
         SsegP22JmTuI4/L0nn7sp0mkyI4uwqf3lvAUTxY0chmJMkwomGBzqli27n1vPY992H1V
         khNvKf5gdVqjzSKeOv6SUhYXkVXQsf0OeTXogbsPTCceSuoKrWlgeJljwqpqgJzFh66W
         IHow==
X-Gm-Message-State: AOAM530DS3MsrhGNXFBBFER1rDE69h3ljLkq129lrLStlVSqScjM++0W
        q4UGtSvVFziRXf+WZwIgr3o=
X-Google-Smtp-Source: ABdhPJyBWbQ4bYNqx4D5Qjh1mgT+vdR6DFZ0Qz3rPz0NaYb7fGBGV/aU2B/9sLpgP791scUISjxZ5w==
X-Received: by 2002:a05:6512:4012:: with SMTP id br18mr2989138lfb.674.1636415737667;
        Mon, 08 Nov 2021 15:55:37 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id l10sm288823lfg.125.2021.11.08.15.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 15:55:37 -0800 (PST)
Date:   Tue, 9 Nov 2021 00:55:36 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        nsaenz@kernel.org, jim2101024@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: brcmstb: Declare a bitmap as a bitmap, not as a
 plain 'unsigned long'
Message-ID: <YYm4+AEffI96KN1l@rocinante>
References: <e6d9da2112aab2939d1507b90962d07bfd735b4c.1636273671.git.christophe.jaillet@wanadoo.fr>
 <YYh+ldT5wU2s0sWY@rocinante>
 <4d556ac3-b936-b99c-5a50-9add8607047d@gmail.com>
 <4997ef3c-5867-7ce0-73a2-f4381cf0879b@wanadoo.fr>
 <YYmzDSjLgmx9bQQs@rocinante>
 <fd853199-6400-000f-1472-3bd6de0662c4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fd853199-6400-000f-1472-3bd6de0662c4@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Florian,

[...]
> >>>> Jim, Florian and Lorenzo - is this something that would be OK with you,
> >>>> or you would rather keep things as they were?
> >>>
> >>> I would be tempted to leave the code as-is, but if we do we are probably
> >>> bound to seeing patches like Christophe's in the future to address the
> >>
> >> Even if I don't find this report in the Coverity database, it should from
> >> around April 2018.
> >> So, if you have not already received several patches for that, I doubt that
> >> you will receive many in the future.
> >>
> >>
> >> My own feeling is that using a long (and not a long *) as a bitmap, and
> >> accessing it with &long may look spurious to a reader.
> >> That said, it works.
> >>
> >> So, I let you decide if the patch is of any use. Should I need to tweak or
> >> resend it, let me know.
> > 
> > I would be pro taking it, not only to addresses the Coverity complaint, but
> > also to align the code with other drivers a little bit more.  Only if
> > the driver maintainers have no objection, that is.
> 
> Driver consistency is a strong argument, fine with me then.

Thank you!

	Krzysztof
