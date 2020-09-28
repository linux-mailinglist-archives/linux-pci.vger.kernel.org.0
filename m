Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A141027A9DF
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 10:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgI1Iph (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 04:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1Iph (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 04:45:37 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E000C0613CE;
        Mon, 28 Sep 2020 01:45:37 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mn7so227625pjb.5;
        Mon, 28 Sep 2020 01:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nS1+mZH+1q3Z1ieI+xXv6fDTo0VrdNwEG9Fe9x5ehDg=;
        b=QKev1kYjofg9CeUcQo2fCgYI5XqAaZXltLyFsuFj2PxGkOygx42Bdaquz/2KUJ/uXw
         YB44tgBbMn/iys8dLegdc8+HkveO+YAwMS2yTX9vcwycmuvizEX1jMrnyXaZKpmHubnu
         z9Wp4ncdmuOSluTdNymJsCLYAt59p9+YEbNJ7yxNXAiXtmzeOtPCXbrhE3mZDvLoNjLb
         gtnYLo/Bcg8SfJgtd9lUNFE8o6c+GUI8bYIsJKU7+ODQu5ogpisixQ097Se3jH3w8Gvv
         JbKHuDtB+iRDO5JpKD5rtNy8XFaSjr10C4okZDAHQtIYJR2is/Vxmh6qGsoOlqWo0GKw
         87iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nS1+mZH+1q3Z1ieI+xXv6fDTo0VrdNwEG9Fe9x5ehDg=;
        b=SbFuRG4XG2AuebG6B4pqlwUEcXwmY/dpVYlsNJ0eY+SwdbWOmRvgWYd/mIHVKixBaw
         YDA4j9qhaQJfbF2XrX/Tavboz6k6s4mNySe4OfQr4TEfZqyCOtDdLbQU8aokDVA+UP/C
         4OL2uIretTWaMXPALtoMmm/Gd1DeX2WTrMafgZmXwQXaEFcQ6qHQmkMu2XwbU2nLVVZC
         GpkviSBlihwyaOwWTuQ1HffMijgIq68+E53FYRCb8uyhQmMLCcA0PvT9b8O9irWk90ps
         ZNwiSwR6qDkCGDQOfPejAucy1g9TKLPQS4pAUu6FTolQ0A/W8nhJO1HVZTThzjOquMy9
         bzFw==
X-Gm-Message-State: AOAM5323k9yxlsrwVpD4cX0VbJCAkZ0pKcgC+qdyhDaAOFSzHiZZODzN
        m5rFoIJBSWUeGb3XzdvAXqIMjRYFX+I/e/Zw4V0=
X-Google-Smtp-Source: ABdhPJwV0A5NAianD0pR8zZxg3Y+JvzlYy1SYYiOvjoeNNRPhGwg1Ga8aTdSloWBeWeR2x/kqywA0tt5sMkq5PXj/9s=
X-Received: by 2002:a17:90a:fd98:: with SMTP id cx24mr358002pjb.181.1601282737132;
 Mon, 28 Sep 2020 01:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200928040651.24937-1-haifeng.zhao@intel.com> <20200928040651.24937-4-haifeng.zhao@intel.com>
In-Reply-To: <20200928040651.24937-4-haifeng.zhao@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Sep 2020 11:45:18 +0300
Message-ID: <CAHp75VdzceN-aVEDJN1Vz9vyBcBoJDb4D9K_SpPrwqWfGzrXfQ@mail.gmail.com>
Subject: Re: [PATCH 3/5 V55555] PCI/ERR: get device before call device driver
 to avoid NULL pointer reference
To:     Ethan Zhao <haifeng.zhao@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Oliver <oohall@gmail.com>,
        ruscur@russell.cc, Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        pei.p.jia@intel.com, ashok.raj@linux.intel.com,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 28, 2020 at 7:13 AM Ethan Zhao <haifeng.zhao@intel.com> wrote:

Same comments as per v4.
Also you have an issue in versioning here. Use -v<n> parameter to `git
format-patch`, it will do it for you nicely.

-- 
With Best Regards,
Andy Shevchenko
