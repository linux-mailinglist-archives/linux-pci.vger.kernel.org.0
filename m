Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BB0453CEF
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 00:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhKPX5X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 18:57:23 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:34729 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhKPX5W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Nov 2021 18:57:22 -0500
Received: by mail-qk1-f181.google.com with SMTP id t6so723109qkg.1;
        Tue, 16 Nov 2021 15:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XaM4c4Woo9gfrvREvQLOCh29FfhU00zvUd3aOtJYfOg=;
        b=sCaecqAR3GZolgoGmPyiT/2WqP8iyosDyP/P5bkCJqZ139cQhPb3uF39kG6IkaRar7
         veHlF9gwaAoHyEua+6hjGLZuIgr4nTDiP1tqRKbVgx8yUpZNdr5xHZPSucdXG3myffIe
         0cBbHtCLO8R+0w+HqfNy8twz2wOL+fJUENdA5IXYISC2eHv4hjCDqaWGVe4ToHbBrV8s
         1pthJzRc2f8XjEHh9duwQ6XerWpc15y6KvGeb1q5lrxdmtC3j2UBotBdxcd081IFXd7P
         z8oIHfQ3kM7CijjXThmeeS9d5lplv5a7aO/9RCHpNgF7cK4NjPeiK6/CMx2sxdsO9QuJ
         Iraw==
X-Gm-Message-State: AOAM533NRy+heJxccqKiz8dha2sOzPNnk68109uG5XF6b37aRHbcjx/s
        RpWW8MuyZe9dhcFIQPKz2kA=
X-Google-Smtp-Source: ABdhPJyNqHXlIdR1dddmf41eQfSmAWQwVpkLgbiNIPnG2pGIX2g9DxuYaO6+j+cW4wjASefJ+dshlg==
X-Received: by 2002:a05:620a:5d:: with SMTP id t29mr9627108qkt.220.1637106864801;
        Tue, 16 Nov 2021 15:54:24 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id u9sm6822849qta.17.2021.11.16.15.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 15:54:24 -0800 (PST)
Date:   Wed, 17 Nov 2021 00:54:19 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Yuji Nakao <contact@yujinakao.com>, linux-kernel@vger.kernel.org,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        ". Bjorn Helgaas" <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <sashal@kernel.org>,
        Jeremy Soller <jeremy@system76.com>
Subject: Re: Kernel 5.15 doesn't detect SATA drive on boot
Message-ID: <YZREq6jQOhyKIHk0@rocinante>
References: <87h7ccw9qc.fsf@yujinakao.com>
 <8951152e-12d7-0ebe-6f61-7d3de7ef28cb@opensource.wdc.com>
 <YZQ+GhRR+CPbQ5dX@rocinante>
 <26826c5d-2fa6-9719-be2a-5a22d1e9abc0@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26826c5d-2fa6-9719-be2a-5a22d1e9abc0@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+CC Adding Jeremy for visibility]

Hi Damien,

[...]
> > The error in the dmesg output (see [2] where the log file is attached)
> > looks similar to the problem reported a week or so ago, as per:
> > 
> >   https://lore.kernel.org/linux-pci/ee3884db-da17-39e3-4010-bcc8f878e2f6@xenosoft.de/
> 
> Thanks. I searched this thread but could not find it in the archive.
> Early morning, need more coffee :)

No worries!  Got you covered!

     )))
    (((
  +-----+
  |     |]
  `-----'

Enjoy!

> 
> > 
> > The problematic commits where reverted by Bjorn and the Pull Request that
> > did it was accepted, as per:
> > 
> >   https://lore.kernel.org/linux-pci/20211111195040.GA1345641@bhelgaas/
> > 
> > Thus, this would made its way into 5.16-rc1, I suppose.  We might have to
> > back-port this to the stable and long-term kernels.
> 
> Yes, I think the fix needs to go in 5.15, which is latest stable and LTS.

On the plus side, not everyone is on 5.15 yet, but those who are using it would
have some issues.  Albeit, with it being an LTS release, the adoption might
increase rapidly.

For instance, I believe that Pop!_OS already ships kernels that are very close
to the upstream, which would hit their current user base.

	Krzysztof
