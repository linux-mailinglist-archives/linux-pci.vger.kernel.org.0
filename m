Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984C525EDBE
	for <lists+linux-pci@lfdr.de>; Sun,  6 Sep 2020 14:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgIFMUk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Sep 2020 08:20:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728692AbgIFMT6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 Sep 2020 08:19:58 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4CC221473;
        Sun,  6 Sep 2020 12:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599394797;
        bh=5xaQtgEEunxFpWtPQFx1XI1o7Fy2z6eCD7GptBgqF50=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xMhmkk2X4elrWy0fOJOtdYnKbgJN/smaIaC4RalV+1J8HOMZvzAScGVjfw7LTZsRi
         LEnxY8+5Shd6CqobnrF/+xhoheBxHKiEuAF0eqZTrDOdywWD77CF23mYfqbACesMkS
         GhgQ86hz2PsT/SYo+eiAVK8Vm/cqsOICoa3HbmhI=
Received: by mail-ed1-f53.google.com with SMTP id ay8so10021558edb.8;
        Sun, 06 Sep 2020 05:19:57 -0700 (PDT)
X-Gm-Message-State: AOAM531KmN8Fegumyn0+BtyP9biFuph1MWuYcWF4CAyxUNF+e3p4yDWc
        PZu/m98/ZfLpH+xY+2R+rLqxmaV1aQE7AR4pxz8=
X-Google-Smtp-Source: ABdhPJzhE4/GdY6BaMfAPnBjEdqyt0ywFD/ZbYQ6CquCBoV7lSB+t44y0FR4eIb5g8MemGWEaTPnAwx/ja7wgiV1m3c=
X-Received: by 2002:a05:6402:180a:: with SMTP id g10mr16867999edy.18.1599394796310;
 Sun, 06 Sep 2020 05:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200904185609.171636-1-alex.dewar90@gmail.com>
In-Reply-To: <20200904185609.171636-1-alex.dewar90@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sun, 6 Sep 2020 14:19:44 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdjev5gMFBX8q6Q7ZZ1s3aBiGKOqfmrCQKTMGeXDeAoTA@mail.gmail.com>
Message-ID: <CAJKOXPdjev5gMFBX8q6Q7ZZ1s3aBiGKOqfmrCQKTMGeXDeAoTA@mail.gmail.com>
Subject: Re: [PATCH] PCI: keystone: Enable compile-testing on !ARM
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Vidya Sagar <vidyas@nvidia.com>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        linux-pci@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 4 Sep 2020 at 20:56, Alex Dewar <alex.dewar90@gmail.com> wrote:
>
> Currently the Keystone driver can only be compile-tested on ARM, but
> this restriction seems unnecessary. Get rid of it to increase test
> coverage.
>
> Build-tested on x86 with allyesconfig.

You should at least build it on x86_64, powerpc and MIPS. These are
widely available (e.g. in most of distros, or here:
https://mirrors.edge.kernel.org/pub/tools/crosstool/). Useful is also
riscv and sh (specially sh lacks certain headers/features).

Best regards,
Krzysztof
