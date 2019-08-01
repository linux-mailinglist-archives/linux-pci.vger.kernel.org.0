Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EED747E69E
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2019 01:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733115AbfHAXpw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Aug 2019 19:45:52 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33194 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390427AbfHAXpt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Aug 2019 19:45:49 -0400
Received: by mail-vs1-f67.google.com with SMTP id m8so50205075vsj.0;
        Thu, 01 Aug 2019 16:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EX8X4lO7aSaVB1FpMoDQxncs8FMEtYzW491XME/gSYQ=;
        b=uTv0KihHzXdFtzn+LjPKqpsUXs5DAkUGjm8wB/wmTC2piN3+7ufjR8Gkc2bMAmuhEI
         Cfx9ohunWZK6FdjhCn5oMZdAn8IvFR0ngPfc9C56hc4J/sBdN2+Z/eb/iVB3u4+FYP++
         YZ0+8RE6Yij1Ht1M96t+C0aZmGOrrttpUJXmGZy19FeYx8UbMgHxSP2DV6dJf6N+WJ7Z
         hTo0z0PRLdZon5magUgEiwBnhaqI8d/vqLa0UNKFOlQlB4A5ZG8TH25VKQLfVXYIPoh5
         n+GVUoIfKxa6cvwwL4jiGFJNjvgehcO+pqA6bGwtSZrSNeRxy99oUKMOWvARbKnRGuNl
         glQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EX8X4lO7aSaVB1FpMoDQxncs8FMEtYzW491XME/gSYQ=;
        b=eMIRxZ7qBb/WaQWXgTA8jDhbF22kAohEnMsmkGE1s6Mo2oacECpbHx3M2Jx5vKb6tQ
         pcowMEilY9JRslicvdR050Pud7tCoWFC34FzV8tTV1qMG/UJYYaHHeenL/xejSZZtEw3
         drgqVps4xs7VSs19HhNfMFf/z7F2TYsfI5z2IlwDuS3nQwN8jNDI434OaJWViGpq5VAE
         AblrRdk6pniMGtvoXNKADsxA6zryA1cOmjEWOYIIzzz8LIqd2HrAMpHyRA3w3Kt2dXni
         ADsciyHhKsoezkbwuBL9mmoqxdiZ5LtenkDZQtU3upQYJW/c/9X51P7t6Y+xpERsUKPd
         1ETA==
X-Gm-Message-State: APjAAAWOj68pHqP2oxNY8LhfT3Hi/I1fbZo1A+bvd1xLlGf4aDNrxVKS
        FDJVuhEk9wSDEgi5+tTlWqGP93UqAV4hsA+RCpg=
X-Google-Smtp-Source: APXvYqwMxagfEomHjxLC2RbiQGAR+rGQzLMmlo5MUf4VwLIYt05EApA1Z5u6c0EjAR5+WcC4BnDGCEACOcfzlLG2eVM=
X-Received: by 2002:a67:fd91:: with SMTP id k17mr84874201vsq.121.1564703147897;
 Thu, 01 Aug 2019 16:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190801220117.14952-1-lyude@redhat.com>
In-Reply-To: <20190801220117.14952-1-lyude@redhat.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Fri, 2 Aug 2019 09:45:36 +1000
Message-ID: <CACAvsv4RUe7RpRFcOqigyKMdXm-z0VaiF7RqVHL1bGmRALU3kw@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] PCI: Use pci_reset_bus() in quirk_reset_lenovo_thinkpad_50_nvgpu()
To:     Lyude Paul <lyude@redhat.com>
Cc:     ML nouveau <nouveau@lists.freedesktop.org>,
        linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Aaron Plattner <aplattner@nvidia.com>,
        Maik Freudenberg <hhfeuer@gmx.de>,
        linux-kernel@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2 Aug 2019 at 08:01, Lyude Paul <lyude@redhat.com> wrote:
>
> Since quirk_nvidia_hda() was added there's now two nvidia device
> functions on any laptops with nvidia GPUs: the HDA controller, and the
> GPU itself. Unfortunately this has the sideaffect of breaking
> quirk_reset_lenovo_thinkpad_50_nvgpu() since pci_reset_function() was
> using pci_parent_bus_reset() to reset the GPU's respective PCI bus, and
> pci_parent_bus_reset() does not work on busses which have more then a
> single device function present.
>
> So, fix this by simply calling pci_reset_bus() instead which properly
> resets the GPU bus and all device functions under it, including both the
> GPU and the HDA controller.
>
> Fixes: b516ea586d71 ("PCI: Enable NVIDIA HDA controllers")
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Daniel Drake <drake@endlessm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Aaron Plattner <aplattner@nvidia.com>
> Cc: Peter Wu <peter@lekensteyn.nl>
> Cc: Ilia Mirkin <imirkin@alum.mit.edu>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Maik Freudenberg <hhfeuer@gmx.de>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Lyude Paul <lyude@redhat.com>
Acked-by: Ben Skeggs <bskeggs@redhat.com>

> ---
>  drivers/pci/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 208aacf39329..44c4ae1abd00 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5256,7 +5256,7 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
>          */
>         if (ioread32(map + 0x2240c) & 0x2) {
>                 pci_info(pdev, FW_BUG "GPU left initialized by EFI, resetting\n");
> -               ret = pci_reset_function(pdev);
> +               ret = pci_reset_bus(pdev);
>                 if (ret < 0)
>                         pci_err(pdev, "Failed to reset GPU: %d\n", ret);
>         }
> --
> 2.21.0
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
