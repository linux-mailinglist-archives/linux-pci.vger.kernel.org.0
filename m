Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCF554EDA4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 19:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbfFURNr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 13:13:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44058 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfFURNr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2019 13:13:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16so7279454wrl.11
        for <linux-pci@vger.kernel.org>; Fri, 21 Jun 2019 10:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxEeJzLHY0AeUcloFKyhFKP9J1yDvwDSvarBW0sLpWk=;
        b=p5YERf40iErVwSZIGOYNWLyxjEuRXNvD/C2U5Y+E51jvy3Rq/RKLLwPOdqeoC2lL6B
         tVbknWqPGSwqGmNBSCWCUa8F7rKWJbV1a7DPqZHvI8boVpM+e7aFH/S7NoKXpTHxUCZJ
         wNekLDjNPqeAZEmYlsvzdXVAozPX/u9XiQnp7EUSdNG38yquIJMQMcKZMaOXeqaNa5F1
         0yEQ9T5nVIQa43R+17s5rBS9JgXCTWJAbXEpuPzUK8ewJrtKe1vMCxAnVT02hs2z0DU4
         /jv8AY43RGiCYPlt0ozbf+kq01jnXv3cNkg9piIzxT217H0mYYA9YkTrZ9sG0dJqbHN1
         GWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxEeJzLHY0AeUcloFKyhFKP9J1yDvwDSvarBW0sLpWk=;
        b=ox/UPuEki01Zs4/sZWqQ+zwqH2eJ7kZGeqRwuN6eCMJxrGTI+XLUb9mdy9X/6nxHUu
         ZGf9VAJfF9LVz9E2LlI6bC1HiWfqElsrfxAcli30e9PvpXL+Vgi9Bfo7QNSJSae3AGQP
         W6VXSDkvXC7QlKOPjyCPPxgiRyZy59YR2QLj8VGGOnFoJ1ob7F+g49MamWO0PKGwZlO0
         dwbrBRkLWaUqgzhf6s0PzdBVyk4LUKD6TjAPEGOSmMlvdcEMYFsJxLPMBCH+jD8LL4mQ
         UCdYKU+tWymO6VZpBLd+AJYvEfbYQZ2ZJ/FClzZM6RFjLUu6hFDF3wLMq6qm7eb84qc2
         aMgA==
X-Gm-Message-State: APjAAAUwkKHTk0EQyuAsEoso8DRI2KiQx1R8GQF+KXpW+rf91P+FdXxf
        Wpau/xpLUe4yv1HmAR0fe2yf8WbX66b+D/WlkPoS
X-Google-Smtp-Source: APXvYqwAeQ+zEBR2/g5pAVKTpbJ9LVgSg5JtBVMrUMNnV3DXee1zuaDai4mk8y32FoPD80tF0FRkNZK7YSifRRNDIaU=
X-Received: by 2002:a5d:5702:: with SMTP id a2mr55706240wrv.89.1561137226363;
 Fri, 21 Jun 2019 10:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190621163921.26188-1-puranjay12@gmail.com> <20190621163921.26188-4-puranjay12@gmail.com>
In-Reply-To: <20190621163921.26188-4-puranjay12@gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 21 Jun 2019 12:13:34 -0500
Message-ID: <CAErSpo4BBczS7hdwmXF=07LqUtT1-3e1Q1Z2r0+J6N=rVhXb7g@mail.gmail.com>
Subject: Re: [PATCH 3/3] net: ethernet: atheros: atlx: Remove unused and
 private PCI definitions
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 21, 2019 at 11:40 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> Remove unused private PCI definitions from skfbi.h because generic PCI
> symbols are already included from pci_regs.h.
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  drivers/net/ethernet/atheros/atlx/atl2.h | 2 --
>  drivers/net/ethernet/atheros/atlx/atlx.h | 1 -
>  2 files changed, 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/atheros/atlx/atl2.h b/drivers/net/ethernet/atheros/atlx/atl2.h
> index c53b810a831d..1b25d6d747de 100644
> --- a/drivers/net/ethernet/atheros/atlx/atl2.h
> +++ b/drivers/net/ethernet/atheros/atlx/atl2.h
> @@ -32,7 +32,6 @@
>  int ethtool_ioctl(struct ifreq *ifr);
>  #endif
>
> -#define PCI_COMMAND_REGISTER   PCI_COMMAND
>  #define CMD_MEM_WRT_INVALIDATE PCI_COMMAND_INVALIDATE
>
>  #define ATL2_WRITE_REG(a, reg, value) (iowrite32((value), \
> @@ -202,7 +201,6 @@ static void atl2_force_ps(struct atl2_hw *hw);
>  #define MII_DBG_DATA   0x1E
>
>  /* PCI Command Register Bit Definitions */
> -#define PCI_COMMAND            0x04
>  #define CMD_IO_SPACE           0x0001
>  #define CMD_MEMORY_SPACE       0x0002
>  #define CMD_BUS_MASTER         0x0004

These bit definitions (CMD_IO_SPACE, CMD_MEMORY_SPACE, etc) are also
generic PCI things that should be replaced with PCI_COMMAND_IO,
PCI_COMMAND_MEMORY, etc.  I haven't looked at the file, but there are
likely more.
