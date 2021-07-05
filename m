Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52253BC3E7
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 00:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhGEWee (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 18:34:34 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:40865 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhGEWee (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 18:34:34 -0400
Received: by mail-lf1-f48.google.com with SMTP id q18so34793491lfc.7;
        Mon, 05 Jul 2021 15:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XxIYzc2a0GDS3UgyyLc6UOgUpTaRimvmHueOqUiNlAo=;
        b=GGzFZa1ON7XO8JxzZ/b9/mnrym6z2i0TllvAf60WWEzPT1TFFrgnO/mEkst5xmyR02
         0MRtTUzFGiRhGlJahrmBO/wfjdQg0Son14YojLohjzidmJSZfJoPY0pkjMTkjPKDqtbM
         NyHjAtABE3r3m3XaALiZMqKKZHTchA9Pxd3qRfiq61JVeLf/Sfa96jtGnNFO1wEl1LGw
         RX8kc0Nh2l/4BINKwkWJ3npqWwnlJNMW9o974z0O4/ypMLuvAYgtwtHroCpieZlbxSd5
         MtmvfZ1dZ059NGlk8xjyDfZdppDAReZkNGpfMtUN6MoLeLkTq2Ep8KL3ujoNslbhOp/c
         3bSA==
X-Gm-Message-State: AOAM532e1H9Lp6QeWtry4xFdTSZ4n+KPZwnYXbBDkTzi6Qpd1EUWVbKO
        5R3Kioo6hQXZJq0kyZCsPKE=
X-Google-Smtp-Source: ABdhPJwhTaMDcZK4oJs5vCYFU941vuJCjaKeS/t/gMmUoiDsOK+EDfsIeiiIvmNjg4Dj0eA7GWSjrA==
X-Received: by 2002:a19:6e46:: with SMTP id q6mr8610756lfk.165.1625524314396;
        Mon, 05 Jul 2021 15:31:54 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j17sm365773lja.38.2021.07.05.15.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 15:31:53 -0700 (PDT)
Date:   Tue, 6 Jul 2021 00:31:52 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     thierry.reding@gmail.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: tegra: make const array err_msg static
Message-ID: <20210705223152.GA142312@rocinante>
References: <55b11e9a7fa2987fbc0869d68ae59888954d65e2.1620148539.git.christophe.jaillet@wanadoo.fr>
 <5f3f35296b944b94546cc7d1e9cc6186484620d8.1620148539.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f3f35296b944b94546cc7d1e9cc6186484620d8.1620148539.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christophe,

Thank you for sending the patches over and taking care about these!

I was wondering whether you will be willing to send a v2 of this series
that would include fixes to everything the checkpatch.pl script reports
against this driver?  There aren't a lot of things to fix, thus the idea
to squash everything at once.  These warnings would be as follows
(excluding the ones you taken care of in this series):

  drivers/pci/controller/pci-tegra.c:1661: WARNING: please, no space before tabs
  drivers/pci/controller/pci-tegra.c:1890: WARNING: quoted string split across lines
  drivers/pci/controller/pci-tegra.c:1891: WARNING: quoted string split across lines
  drivers/pci/controller/pci-tegra.c:2619: WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.

These should be trivial to fix.  The two pertaining to "quoted string
split across lines" would be something that we might or might not decide
to do anything about this - technically, as per the Linux kernel coding
style [1], we ought to fix this... but, this particular case is not
a terrible example, so I will leave this at your discretion.

What do you think?

Also, don't worry if you don't have the time or otherwise, as these are
trivial things and it would only be a bonus to take care of them.

1. https://www.kernel.org/doc/html/v4.10/process/coding-style.html#breaking-long-lines-and-strings

	Krzysztof
