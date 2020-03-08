Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2B8E17D5EA
	for <lists+linux-pci@lfdr.de>; Sun,  8 Mar 2020 20:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgCHTl7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Mar 2020 15:41:59 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:33097 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgCHTl6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Mar 2020 15:41:58 -0400
Received: by mail-il1-f193.google.com with SMTP id k29so1574522ilg.0;
        Sun, 08 Mar 2020 12:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AIXaeQ+AY9PML0IQFpQFp/vwCGtcFG3KhmwRmsZSfDY=;
        b=SJJPA1mjHygjuC/7dcvLHUdYwhwwpAvps7tE7gbvWLBSsGSD3lwJlJ2v8Vfqe7jlFd
         mbdfXz0JeELiVcR032wXc8yC+X6Fhroikazjjv6fgxg168815s+q/heSOezUqDifRP9U
         pDklUkSMD4jfA3/pge9+fcMFkNzXZ5UmMngQ1iZy3tlTmIDmN+krpNPCnAPuZ38zKAiO
         2hwqxwkLA8ftm46L3wFbKFs4lwXXXQP9b+833TK0Fs9kdckJvURK7n1FsCCFgFIqsvk5
         SNdCEuPhLejcnwA6c64aoAU1hzMvOlFdQU47p7BIAIE7brvIaSePzCvSaFGhjIJAxcG3
         e18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIXaeQ+AY9PML0IQFpQFp/vwCGtcFG3KhmwRmsZSfDY=;
        b=k6LmYc1zRUEp70r5N5eOAi2Em9gEG2FXYReqXCNRRmBED9R+IDyEw9gZxytjNgjFho
         nsRJps5gfbH1FAhNmYO9fTIX4HmsN6yCllCkNZeaf/6OZvUdOwTSKvcvIVpyJQlMPCoD
         WgW5ztTGB+9mEmNzcjYmLrFwALM4P0vtIbQHX34Fp9VIO4r/uic6KCNpNHIAEKX5h+xF
         osjF8XgeKZxGr60MEB8cVH2PdoSDTWXn9LJemM5FHIzhdXD/SF2WBJ6shc31jIZmSlFS
         K7l+Nhf4mqVGy8VPxJY1KAEO/pt5umzJsJvQeRlNHK2bRNBM8QfSMC2SxIyZMzThjL16
         3cqQ==
X-Gm-Message-State: ANhLgQ3yQk7mrv11nnRw2ogyXx9PVG6SXFdnGIwZ7sr2MHLBRC7u45A/
        iY5so6N6m8NmNyUwv2s5f3CB7//8GtsxpjO0fMA=
X-Google-Smtp-Source: ADFU+vtXxRPksN4vb2FDWXKZF5GycRipK5VQ382ecpHbM0OBWoTYy54YaNcEhW+uYNTKkDtdkufQCJJpZmaPMaMVHhQ=
X-Received: by 2002:a92:dc8a:: with SMTP id c10mr13021304iln.100.1583696517901;
 Sun, 08 Mar 2020 12:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAEdQ38EzZfUJA-8zg-DgczYTwkxqFL-AThxu0_fC2V-GkXGi2Q@mail.gmail.com>
 <20200302224732.GA175863@google.com> <20200308153004.GA17675@mail.rc.ru>
In-Reply-To: <20200308153004.GA17675@mail.rc.ru>
From:   Matt Turner <mattst88@gmail.com>
Date:   Sun, 8 Mar 2020 12:41:46 -0700
Message-ID: <CAEdQ38G1YhEoQUEpDT6k_uwodxTOs=BYigm_VQaDDdfaoXM6Wg@mail.gmail.com>
Subject: Re: Some Alphas broken by f75b99d5a77d (PCI: Enforce bus address
 limits in resource allocation)
To:     Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Jay Estabrook <jay.estabrook@gmail.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 8, 2020 at 8:30 AM Ivan Kokshaysky <ink@jurassic.park.msu.ru> wrote:
> Wholeheartedly agree. In fact, changes to generic PCI code required
> for proper root bus sizing are quite minimal now since we have
> struct pci_host_bridge. It's mostly additional checks for bus->self
> being NULL (as it normally is on the root bus) in the
> __pci_bus_size_bridges() path, plus new bridge->size_windows flag.
> See patch below (tested on UP1500). Note that on irongate we're
> only interested in calculation of non-prefetchable PCI memory aperture,
> but one can do the same for io and prefetchable memory as well.

Thanks Ivan! The patch works for me as well.
