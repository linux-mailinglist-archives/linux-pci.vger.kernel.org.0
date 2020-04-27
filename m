Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861361B9839
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 09:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgD0HT4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 03:19:56 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38524 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgD0HT4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2020 03:19:56 -0400
Received: by mail-ot1-f65.google.com with SMTP id g19so24510303otk.5;
        Mon, 27 Apr 2020 00:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MLOsCXY5CJYqvVWVe6aOT0DVdT2ij4VE8Z+SPJO/YZg=;
        b=qHzTIG3CMpMmk7uqCdXz9aoLO4cQfXLWo02wjALzk7DaNtv9bjKsABWfd90hSpmrpk
         jOI2l/0UgRXKivpXyXTFUgWzLdOaNPSPT9SCdP2bUTCGrcoDugW/aK4AnfGHxpqGjc5l
         ne8jBZj3FtkG226CK6xloWkSuiIl81NGdDV/1I9NFGOoIggf64LfZr3UeKmGXGD/rmun
         jqZGfRWpxUWZIvyyXfkwgaBoAdMb+kqHLlvdcgP/sP9+j19QFZeC4F7TkEXKvxfohDC2
         hyPvJFT5/o+knGgjGCWs3qrcFx/oBJzrdXjBUHi5dEwcBXb5nn1wNQA9IUsA7OFAVu4L
         LYyQ==
X-Gm-Message-State: AGi0Pub/yJxVULfaf05UNC+Qs/YOUdhhhoB2Vg018fSFSWncwXsDOoMG
        usXh2Qk1DJn6AUbABBFz4MuSpddLHitHZbPiN7w=
X-Google-Smtp-Source: APiQypLUWaxFh0/MS1q8NoWLnzWkpWyzj00AqJlpeCTuWSk5j2TuRqmUrMkxg/hB2+VV8abA6c3BE5pk/d4HbgDqaWE=
X-Received: by 2002:a9d:7990:: with SMTP id h16mr11320789otm.145.1587971995512;
 Mon, 27 Apr 2020 00:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200426123148.56051-1-marek.vasut@gmail.com>
In-Reply-To: <20200426123148.56051-1-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Apr 2020 09:19:43 +0200
Message-ID: <CAMuHMdX-TAe-mrJAb+1E4BhMZe_xeSk5ySpbgqHJ0R+=HXemtA@mail.gmail.com>
Subject: Re: [PATCH] PCI: pcie-rcar: Cache PHY init function pointer
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 26, 2020 at 2:31 PM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> The PHY initialization function pointer does not change during the
> lifetime of the driver instance, it is therefore sufficient to get
> the pointer in .probe(), cache it in driver private data, and just
> call the function through the cached pointer in .resume().
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
