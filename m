Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458C33B1C41
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 16:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhFWOVl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 10:21:41 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:44731 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhFWOVk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jun 2021 10:21:40 -0400
Received: by mail-wm1-f41.google.com with SMTP id h21-20020a1ccc150000b02901d4d33c5ca0so1469018wmb.3;
        Wed, 23 Jun 2021 07:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dYxNZdPZGzKRsKvBtkHi7tanxkrUxAuHSiGuuQ7Bh7g=;
        b=Ni0zn3n7Ff/W5iZusy6mM6kngW9zaFFPVhJMQSR8C8pncJ99LakAzpqgNrCzCSruOR
         2gZVqT5iGAmcbItBOOkVf0Au5ft9hG7pYC7jOy3DvwtvHL5iWv3XBZYl0WBdtwnFUZhY
         lr8IHaCj7mM+LmQz6Jzij7c+JdU+XVJNwFTEHRXmgZzhAvkWtaX0WryKV1jNv7/qJmDV
         tHLtzAO30ex5ihgtFoDG/VyYaCUF4i64tbEkXBdCqwizgeQ9tgqi2iRcsWStjvnhO7ey
         F560TleOOZ/31qiequuqGb4Ijn9dTX0MTGKITulE32rpIMKyIdNauVwn3rfW8Ya+gF5s
         KtHA==
X-Gm-Message-State: AOAM531Gnx/1guJHc0ZWwEPxHKd93mu9/SkYBHsusX8S4vubaHjO9J5G
        7u2IxgW4GzKiv0QUKh6112w=
X-Google-Smtp-Source: ABdhPJwS9dSxcRr/RNB5UyxpC078lYD/bhF+LUFS64ViQXBH5uQeoNM09+6CnF+g4GPlPH4lqJ3U9A==
X-Received: by 2002:a1c:6485:: with SMTP id y127mr11217952wmb.110.1624457962133;
        Wed, 23 Jun 2021 07:19:22 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id 22sm117032wmi.4.2021.06.23.07.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 07:19:21 -0700 (PDT)
Date:   Wed, 23 Jun 2021 16:19:20 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        bharat.kumar.gogada@xilinx.com, Hyun Kwon <hyun.kwon@xilinx.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Ravi Kiran Gummaluri <rgummal@xilinx.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: xilinx-nwl: Enable the clock through CCF
Message-ID: <20210623141920.GB54420@rocinante>
References: <cover.1624454607.git.michal.simek@xilinx.com>
 <be603822953d0a815034a952b9c71bac642f22ae.1624454607.git.michal.simek@xilinx.com>
 <20210623135326.GA54420@rocinante>
 <f15a9fca-0fb0-5f7a-e1c7-6c52df617a2e@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f15a9fca-0fb0-5f7a-e1c7-6c52df617a2e@xilinx.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Michal,

[...]
> > Does it make sense for this change to be back-ported to stable and
> > long-term kernels?
> > 
> > I am asking to make sure we do the right thing here, as I can imagine
> > that older kernels (primarily because some folks could use, for example,
> > Ubuntu LTS releases for development) might often be used by people who
> > work with the Xilinx FPGAs and such.
> 
> I think that make sense to do so. I haven't had a time to take look at
> it closely but I think on Xilinx ZynqMP zcu102 board this missing patch
> is causing hang when standard debian 5.10 is used.

OK.  This definitely would be a good candidate for back-port then - it
might help quite a few folks to get their device going without this
troublesome hang you mentioned.

There are a few options as per:
  https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

You can send v3 adding the appropriate tag (see above link or the
comment below) or once this series (or mainly this patch) reaches Linus'
tree, then send a message to the stable maintainers mailing list to let
them know what any why to back-port.

At this point, I believe that adding the "Cc:" tag which includes the
"stable@vger.kernel.org" might be the best option as it would involve
the least amount of work to for Sasha et al.

What do you think?  Which option would you like to go for?

	Krzysztof
