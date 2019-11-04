Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25648EDC93
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2019 11:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfKDKbw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Nov 2019 05:31:52 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44278 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfKDKbw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Nov 2019 05:31:52 -0500
Received: by mail-oi1-f195.google.com with SMTP id s71so13612273oih.11;
        Mon, 04 Nov 2019 02:31:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0z80bMxV2KEcGvJQN9GJhV4fRO/ESVM96BjdoNCBKqQ=;
        b=FN72IOOwTl69GuAwrzC7AujNFUaGaE32NN/0Sd/kgkFZJK3NsOvlSzgWOz9th5uD4x
         QqMdGqjDiDYMkJYIX5md4DmJxrkj66ITCsnDI8DKnTbrPosylacbppMhgmGsC4XCbhYX
         EUAnPZNh/Wlmek2uCxAAaXiTD1sXa3Gb/0S37dr1/AwbZ5FpJnWj+nldn6fzeZMi88Yg
         XnamvCkVxSrLnf1ikfX4ZtM917BzEz6mhLQHe3clz0KsCZgO46iar/QNCR/VoCVNC8hZ
         hfM9OMMgkuESlUb3v+ZyCjX3rxvS1/UvoabBMPCaG22r4Eue6xZ3Xh6qynMomlGSpIMS
         ng0A==
X-Gm-Message-State: APjAAAVHjh4ozYRKpD3+hF3wTrku/PMDOftyt86SecZcFiiUTUeVyYCb
        kyYw73n+DqSo3KzAgBrB/X+alW2/4UHInx52J+U=
X-Google-Smtp-Source: APXvYqyjg3trtwliYoqmHqKU+L2v5XHXEPtaPnf0sii6ZTpQ2GbZrIMdyLmKfLIZDUyZNnYcstrFezEABIXFHsbe6qo=
X-Received: by 2002:a05:6808:913:: with SMTP id w19mr328014oih.110.1572863511238;
 Mon, 04 Nov 2019 02:31:51 -0800 (PST)
MIME-Version: 1.0
References: <20191101204558.210235-1-helgaas@kernel.org> <20191101204558.210235-4-helgaas@kernel.org>
In-Reply-To: <20191101204558.210235-4-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Nov 2019 11:31:40 +0100
Message-ID: <CAJZ5v0jWBcUUDxNTLmYP071noSXB4q0UP0CD46sk_uS4HNgeqA@mail.gmail.com>
Subject: Re: [PATCH 3/6] PCI/PM: Simplify pci_set_power_state()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 1, 2019 at 9:46 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Check for the PCI_DEV_FLAGS_NO_D3 quirk early, before calling
> __pci_start_power_transition().  This way all the cases where we don't need
> to do anything at all are checked up front.
>
> This doesn't fix anything because if the caller requested D3hot or D3cold,
> __pci_start_power_transition() is a no-op.  But calling it is pointless and
> makes the code harder to analyze.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a9d3653ef960..281bc8fc51b3 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1130,8 +1130,6 @@ int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>         if (dev->current_state == state)
>                 return 0;
>
> -       __pci_start_power_transition(dev, state);
> -
>         /*
>          * This device is quirked not to be put into D3, so don't put it in
>          * D3
> @@ -1139,6 +1137,8 @@ int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>         if (state >= PCI_D3hot && (dev->dev_flags & PCI_DEV_FLAGS_NO_D3))
>                 return 0;
>
> +       __pci_start_power_transition(dev, state);
> +
>         /*
>          * To put device in D3cold, we put device into D3hot in native
>          * way, then put device into D3cold with platform ops
> --
> 2.24.0.rc1.363.gb1bccd3e3d-goog
>
