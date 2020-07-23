Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D472522B553
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jul 2020 20:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGWSBa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jul 2020 14:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgGWSBa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jul 2020 14:01:30 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25682C0619DC;
        Thu, 23 Jul 2020 11:01:30 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id p14so5392346wmg.1;
        Thu, 23 Jul 2020 11:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8yHbSVV5kzutzuIpNX/wTS1enK7udX/4bh4EfG9Sut4=;
        b=qikiG1vXxNsfhotdqn+vee940yZAFWkoaiDPuWO+dupmQ7FbHKHSEDI/OJjbJuFjrl
         xvRdRI+otw8U7Lr9Fa56KMQ303aXdNWqDxX9G0Ol366hSfcLMirSWAmnaQ1nNaRYM4nr
         JTMhGM8mhSCxReyiBEXfGRPYWiGqAb5C9EtLNoGXd5HNS+Ff9deTg3+HZ75NZq1AlVBM
         3A2zJ7MtUXep6ALlEyS8r26cD3o8DIVFcfQYAMoKvlIUkF89s3q1gOJ78HmNCGs1zgDn
         LmGGBC+bBqTbxRaIiBjzG0MyFdhv+VWHL/1pTcFcLwZEYsD5sf1yr9kgQHzAltUjeQxy
         OI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8yHbSVV5kzutzuIpNX/wTS1enK7udX/4bh4EfG9Sut4=;
        b=mtl7wPqdB3yivLgzyKpm1oKxBTbXLzmiJc/7CUydGDX6yeKq1G02WqrobrmzQdxDrc
         cC875LikYzzmAx6yDc+l/nqpKIpDjmireNfzAR/cSntf9DRhBVxlhUAqjRFeeszisfkH
         YibIDW8jmVOi+Nic1/oSdBAOJRhowhFQoPNlP4fUEWFd/MpMyuE+h4qINh3RXGUBdVNB
         9vbAJhFXFslAIK0WTovehCRkXK2qibce/81tqqJExTs5+Y+EYneVpk1w7rMjDH3y09TY
         cnx2J2203uRBCfDW2BXWaJJ6Vim82VShM+qcu11l+CHqd9J/xo2YamiRu79aI0E8Hnk9
         KuLQ==
X-Gm-Message-State: AOAM532Kx7KtAWFQbUoe21xSG2VFbfF9L4gRvmZBKzws55MZoRfJJv/H
        RjYIWE933QobW2WvJoiX7o53sRSiiAf1Wngz//A=
X-Google-Smtp-Source: ABdhPJxPhUDBb+kKOoRbI1Xtck956T2Kp37nusuQ/JA90QHmxVlFYmOr5ucUjzKjkZ/pnDUQfnt1168s6oZR2m42ppY=
X-Received: by 2002:a7b:c05a:: with SMTP id u26mr5148911wmc.73.1595527288929;
 Thu, 23 Jul 2020 11:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200723174317.2783-1-logang@deltatee.com>
In-Reply-To: <20200723174317.2783-1-logang@deltatee.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 23 Jul 2020 14:01:17 -0400
Message-ID: <CADnq5_Nqziz6TKfk7U6QvBjZtV7ibBfwwym1kTb1Q4t-cz04JQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/P2PDMA: Add AMD Zen 2 root complex to the list of
 allowed bridges
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 23, 2020 at 1:43 PM Logan Gunthorpe <logang@deltatee.com> wrote=
:
>
> The AMD Zen 2 root complex (Starship/Matisse) was tested for P2PDMA
> transactions between root ports and found to work. Therefore add it
> to the list.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Alex Deucher <alexdeucher@gmail.com>

Starting with Zen, all AMD platforms support P2P for reads and writes.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/pci/p2pdma.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index e8e444eeb1cd..3d67a1ee083e 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -284,6 +284,8 @@ static const struct pci_p2pdma_whitelist_entry {
>         {PCI_VENDOR_ID_AMD,     0x1450, 0},
>         {PCI_VENDOR_ID_AMD,     0x15d0, 0},
>         {PCI_VENDOR_ID_AMD,     0x1630, 0},
> +       /* AMD ZEN 2 */
> +       {PCI_VENDOR_ID_AMD,     0x1480, 0},
>
>         /* Intel Xeon E5/Core i7 */
>         {PCI_VENDOR_ID_INTEL,   0x3c00, REQ_SAME_HOST_BRIDGE},
>
> base-commit: ba47d845d715a010f7b51f6f89bae32845e6acb7
> --
> 2.20.1
>
