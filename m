Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788BF2821A7
	for <lists+linux-pci@lfdr.de>; Sat,  3 Oct 2020 07:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725648AbgJCFqT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Oct 2020 01:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJCFqT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Oct 2020 01:46:19 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AD2C0613D0;
        Fri,  2 Oct 2020 22:46:17 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id i26so4617804ejb.12;
        Fri, 02 Oct 2020 22:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hawXaGws1MU6sDkakK3AdQ7Q2ZSpEooEcbwe9eB+DI4=;
        b=IJqZsshUb/VtWXvu3gAVH+H/lOqFcQCbt02rZY/vQn5rQT8hOGnAOAwrVxK6X2zObs
         d5rfqYdcNlJ1fr9CmrRZym2wwYG7EhtZdKB8fO6X2s0DhWFthuSNqu2uqLYcDUxQMhXu
         IPCuHZZvXIbieYw2Zrds6+xpKrYy3QvMy53ffAZDtCb9eAyxbQyReNxiQUcrrmk585g5
         jIGSRaL+EchFyCS33FebRzWd7QRKUKnvdS+QQU+2FScmw+Xzwd7FnO+OKNO8bzLMOyXH
         BJ9nB1Xn0P4RYU5+xMuV/QbO9n6UbHVsPcKoG2dJryEnmPAwakDlNNk9NcPh1yObzBFr
         P+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hawXaGws1MU6sDkakK3AdQ7Q2ZSpEooEcbwe9eB+DI4=;
        b=TKIL3bINcc3zvQZzpcs/24Bec/w/UkRpcUda9Bk6876d0R65J045DSS2To0bezKi8N
         2CoKa9BAXJRAY4QF0trfEWovFdFHO/Ihlm8uKDAk5wikmNmG1kB9ppGxE0rRjKdNJmRs
         5KVDJl6nAFxQD/4rDwuDy3+D1MMBwn5WX/pz26rZr/bBR5F5TVgX3MrZk5RwzkVV0knV
         i9vFg1rxX66379h3jQcUZfaDQj/A9h3v4+Lr/nT7Gbx41vxtByfaLN3vdiriuIke+7Vb
         Bu6qclgaPPgzYEgrb38zu80waYOofroekSwaDEkR/aw6maWR4kbyY1+wZ+f2O0PloJAf
         3pNg==
X-Gm-Message-State: AOAM532CmCq+/HBgbeW7qQdj5JzmJ+AHrL2xcVkWwxgl43J4GDFYs2iL
        RN66kJOKiDx2ckAKE/MXRBCT89Qow0j/6ziobYE=
X-Google-Smtp-Source: ABdhPJy5Gznw4s6D4RY5w7kPpdyNu3ws7awM5vjJhfBJ4oLNKu0dObaNIfJPs7Y8ODqZr02QHnqX8ek78cTDMHzRSq8=
X-Received: by 2002:a17:906:6409:: with SMTP id d9mr5265403ejm.344.1601703976062;
 Fri, 02 Oct 2020 22:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200930070537.30982-1-haifeng.zhao@intel.com>
 <20200930070537.30982-5-haifeng.zhao@intel.com> <52e9ba48-2789-31b8-b80c-23854190c4d4@kernel.org>
In-Reply-To: <52e9ba48-2789-31b8-b80c-23854190c4d4@kernel.org>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Sat, 3 Oct 2020 13:46:04 +0800
Message-ID: <CAKF3qh1Bzj6LwBU0yzvLTxSO9RTU5GrJ7PRSwMBHdFJpbFzKEA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] PCI: only return true when dev io state is really changed
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Ethan Zhao <haifeng.zhao@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Oliver <oohall@gmail.com>,
        ruscur@russell.cc, Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ashok.raj@linux.intel.com,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sinan,

On Sat, Oct 3, 2020 at 12:08 AM Sinan Kaya <okaya@kernel.org> wrote:
>
> On 9/30/2020 3:05 AM, Ethan Zhao wrote:
> > When uncorrectable error happens, AER driver and DPC driver interrupt
> > handlers likely call
> >
> >    pcie_do_recovery()
> >    ->pci_walk_bus()
> >      ->report_frozen_detected()
> >
> > with pci_channel_io_frozen the same time.
>
> We need some more data on this. If DPC is supported by HW, errors
> should be triggered by DPC not AER.
>
> If I remember right, there is a register that tells which AER errors
> should be handled by DPC.

When uncorrectable errors happen, non-fatal severity level, AER and
DPC could be triggered at the same time.


Thanks,
Ethan

>
