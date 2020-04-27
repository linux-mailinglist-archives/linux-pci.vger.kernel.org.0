Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E11F1B9837
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 09:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgD0HTX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 27 Apr 2020 03:19:23 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44314 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgD0HTX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2020 03:19:23 -0400
Received: by mail-ot1-f67.google.com with SMTP id j4so24550699otr.11;
        Mon, 27 Apr 2020 00:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tYh90QCx3bEamRC7LtyHw5B+SMhTg1Z1mR2i+dogp/4=;
        b=AIYdtJ/mX3jEhvIeqqrtREXqmOCtCk7yfgfb8y2S7/r1wkvOyHLt0qkO7vC7HzENND
         NoE4GvipEpAm6iEOsNVXfCIRL/F0xEvZ4g9xgxGHmbeuUn+xAeUEZs0FXbeHo2zAfq7I
         Wzg45yTicITat9nzpchJQadip0YClrErn0fWynsBTuqkDW4h/0YHfErn6xlqqm3ruuQv
         1fv15Z3qspB1UyqWz90oCzP20LmeEsVJWKyfyzv/z7k0Mq1oWjFGKAlvG4s03TZNzkKD
         +xoxcyC7JCm0TYOnoG6QQv1Ao4eUBjHex4pXKXYc2k+2dbIrsTi8naFpfMZWsUpZ5MSF
         Lvdg==
X-Gm-Message-State: AGi0PuZ8o5YAAwqno9k2uoHHJ4RHvHNm5KNJjwOR57fqVq4T0uF2Yzyj
        wBq517fcxMjbk/2V7WfgrxE6OgnfkurBVYYmKxDcWQ==
X-Google-Smtp-Source: APiQypJ5AWLI8Kj6Y0BLeuT0kUr1iCEItGAU5GPtqxZCAXqTxYWmJig8j69WicUC4g/GhXK/3R6xLfKOxyvbMe+wGEg=
X-Received: by 2002:a9d:7d85:: with SMTP id j5mr16329107otn.107.1587971962698;
 Mon, 27 Apr 2020 00:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200426123115.55995-1-marek.vasut@gmail.com>
In-Reply-To: <20200426123115.55995-1-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Apr 2020 09:19:11 +0200
Message-ID: <CAMuHMdXC58F8X0aMgyCZJ1L5d9L9hSJRLrO1mmeX2KZUXUac0Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: pcie-rcar: Mark rcar_pcie_resume() with __maybe_unused
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 26, 2020 at 2:31 PM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> If CONFIG_PM_SLEEP is not set, SET_SYSTEM_SLEEP_PM_OPS() is expanded to
> empty macro and there is no reference to rcar_pcie_resume(), hence the
> following warning is generated:
>
> drivers/pci/controller/pcie-rcar.c:1253:12: warning: ‘rcar_pcie_resume’ defined but not used [-Wunused-function]
>  1253 | static int rcar_pcie_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~
>
> Fix this by marking this function as __maybe_unused , just like in
> commit 226e6b866d74 ("gpio: pch: Convert to dev_pm_ops")
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Reported-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
