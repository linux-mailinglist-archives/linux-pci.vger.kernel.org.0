Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB41DB004
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 16:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfJQO0G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 10:26:06 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39199 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfJQO0G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2019 10:26:06 -0400
Received: by mail-oi1-f195.google.com with SMTP id w144so2308717oia.6;
        Thu, 17 Oct 2019 07:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sQj/zBJhKuYRwFrLjvxrReZ/y/Qrf1kIMamU374hlqc=;
        b=TgBvVrtwgt8A2GIPPBS7e3PhVv83wU1UM7mkt3BVq0OUzBtFPVYg/0ZMR55HXcTShs
         2kFPumqY3Es7qz6FGS2OK0pR+UJEaZ/K3RUNKh4Ppf3HPr3iMb2oG7I0MVGsMqJuFnWc
         OoOu0nN9JbJT8SKdS5CCCq0e9ovGd43qP2iRcwFaRR4ovPhX0T9i7wgPXmuORjTL4dIy
         NugM3aUF9xan5uw6zoj5gAk4IOQZVAOCyB7h+iTjJcjY2DIEwXcQzg0vRj1fpvYgdoTt
         nagyCldx1zHrEsiWXsKYtKKm60h1vaao8hj7mE2RyDwQon5L8iDrUcesgTw0WssDCsel
         gvuQ==
X-Gm-Message-State: APjAAAW3iMPyalQ9R9mNCCumzUAhCESNdvB5FcA2UXhsWQ0FJZe6lzEa
        jCRDKag1UNbAOIOKM9+lEMNax3cVv6GX47aTkAQ=
X-Google-Smtp-Source: APXvYqyHqI57//nv0LBbPo/BFK5Uwcsm94CifotPrIepSBfB4ttX0otcR0MrYfziN5z+uOK2DyWqugjfMV6c8EtnZ0E=
X-Received: by 2002:a05:6808:917:: with SMTP id w23mr3333732oih.68.1571322364933;
 Thu, 17 Oct 2019 07:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191016194450.68959-1-helgaas@kernel.org>
In-Reply-To: <20191016194450.68959-1-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Oct 2019 16:25:52 +0200
Message-ID: <CAJZ5v0gKShBYor_80qfP8F_4oCKKxDefjbqRzr5GrqHOV6-Yog@mail.gmail.com>
Subject: Re: [PATCH] PCI/PM: Note that PME can be generated from D0
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 16, 2019 at 9:44 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Per PCIe r5.0 sec 7.5.2.1, PME may be generated from D0, so update
> Documentation/power/pci.rst to reflect that.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Good catch:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  Documentation/power/pci.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
> index db41a770a2f5..a90e82c70a3b 100644
> --- a/Documentation/power/pci.rst
> +++ b/Documentation/power/pci.rst
> @@ -130,8 +130,8 @@ a full power-on reset sequence and the power-on defaults are restored to the
>  device by hardware just as at initial power up.
>
>  PCI devices supporting the PCI PM Spec can be programmed to generate PMEs
> -while in a low-power state (D1-D3), but they are not required to be capable
> -of generating PMEs from all supported low-power states.  In particular, the
> +while in any power state (D0-D3), but they are not required to be capable
> +of generating PMEs from all supported power states.  In particular, the
>  capability of generating PMEs from D3cold is optional and depends on the
>  presence of additional voltage (3.3Vaux) allowing the device to remain
>  sufficiently active to generate a wakeup signal.
> --
> 2.23.0.700.g56cf767bdb-goog
>
