Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336062FD423
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 16:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbhATPWv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jan 2021 10:22:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391005AbhATPVF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Jan 2021 10:21:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82BC6233A2;
        Wed, 20 Jan 2021 15:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611156023;
        bh=r0M1Ka3u8aAoDgdxe4IPOf2mDljJGtGVJIj19ojD0O0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IEV6/G7g4viv0Q8HAPyCI5d7SyPurUG8zU26qpS1QoLPKM4mlgstAjiGh6srwDgc3
         OtqNVZnQKvJv8zNcaQ+m9+pCm5pYU2HgtERGL9OZ5eU1ChhQfa88T9H0TsBThLSkI/
         IVzaYWdEpunUf0Eb9tmvDjPYw6cvTwtdNoSaDY95d8b/ltqTkZVJzwOpNBc2uWloke
         r9AwYynXKcmRY+q6bitd+ZJyoFdSMwOW1MggN/jY6V4cR40iylWBOAeHOd7qhlSMgp
         58KOue6NvVd4f9HGWI+G9CjSQfVzdb3E+g7ef5RTSmwOwJ+QPyPq3BTQSjZ2LwljHP
         T/cVX0FtxzEWw==
Received: by mail-ej1-f44.google.com with SMTP id ox12so9743593ejb.2;
        Wed, 20 Jan 2021 07:20:23 -0800 (PST)
X-Gm-Message-State: AOAM532m5mUW+BH5TfQP8RboKrnzmMEstVi0BwycGigYRSN1w7CX7Dfj
        IAx6P46+LSs1BO1uQiiNMeLaD8LCtLMCPYdk/g==
X-Google-Smtp-Source: ABdhPJzPuIeZMu4dsdixTpdMNXFQeosEa6xL58lXpxjrnZTQGKm80JrftOygLaCUqNokYLxaaaYHwMhJYFzZjJOReOI=
X-Received: by 2002:a17:906:ce49:: with SMTP id se9mr6530993ejb.341.1611156021968;
 Wed, 20 Jan 2021 07:20:21 -0800 (PST)
MIME-Version: 1.0
References: <1611011439-29881-1-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1611011439-29881-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 20 Jan 2021 09:20:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLtcXFktBWWqpbYf3B5BR2eUyBsQQ3Q5S3Ma8hn5T5Z0Q@mail.gmail.com>
Message-ID: <CAL_JsqLtcXFktBWWqpbYf3B5BR2eUyBsQQ3Q5S3Ma8hn5T5Z0Q@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: designware-ep: Fix the reference to
 pci->num_{ib,ob}_windows before setting
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 18, 2021 at 5:10 PM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> The commit 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows") gets
> the values of pci->num_ib_windows and pci->num_ob_windows from iATU
> registers instead of DT properties in dw_pcie_iatu_detect_regions*() or its
> unroll version.
>
> However, before the values are set, the allocations in dw_pcie_ep_init()
> refer them to determine the sizes of window_map. As a result, null pointer
> dereference exception will occur when linking the EP function and the
> controller.
>
>   # ln -s functions/pci_epf_test/test controllers/66000000.pcie-ep/
>   Unable to handle kernel NULL pointer dereference at virtual address
>   0000000000000010
>
> The call trace is as follows:
>
>   Call trace:
>    _find_next_bit.constprop.1+0xc/0x88
>    dw_pcie_ep_set_bar+0x78/0x1f8
>    pci_epc_set_bar+0x9c/0xe8
>    pci_epf_test_core_init+0xe8/0x220
>    pci_epf_test_bind+0x1e0/0x378
>    pci_epf_bind+0x54/0xb0
>    pci_epc_epf_link+0x58/0x80
>    configfs_symlink+0x1c0/0x570
>    vfs_symlink+0xdc/0x198
>    do_symlinkat+0xa0/0x110
>    __arm64_sys_symlinkat+0x28/0x38
>    el0_svc_common+0x84/0x1a0
>    do_el0_svc+0x38/0x88
>    el0_svc+0x1c/0x28
>    el0_sync_handler+0x88/0xb0
>    el0_sync+0x140/0x180
>
> The pci->num_{ib,ob}_windows should be referenced after they are set by
> dw_pcie_iatu_detect_regions*() called from dw_pcie_setup().
>
> Cc: Rob Herring <robh@kernel.org>
> Fixes: 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 41 ++++++++++++-------------
>  1 file changed, 20 insertions(+), 21 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
