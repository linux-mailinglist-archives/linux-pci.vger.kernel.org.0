Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57801B98DB
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 09:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgD0Hmr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 03:42:47 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40407 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgD0Hmp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2020 03:42:45 -0400
Received: by mail-yb1-f193.google.com with SMTP id f13so8976267ybk.7;
        Mon, 27 Apr 2020 00:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7HDE8ph93EI2vOePc5ywVTgnLdaOVxztdKRCyPN5Qdw=;
        b=IOJzamf8OgTB7SIpo/NaEc7tMItPB90nfPDnCKPs1EodhWcDBKChSF+miIlCAy/MZv
         fJ3d+JrfeSxOm0td6knQTV5XFOGn0pqC/OxFawNfnosRM4b8HW1Wn4Q+snyPW+q/yJZd
         rfBtOMvrbe0CfFB8ifB4D7fCmhaPhcadwdQhefhWcDvszF3zHA+KDI8Aql22PcmTN5G7
         EgWn0wtrcjwX6pE79D6w3UdX4rV8A36TRLJ7r4L1yjYjT8NSamw0G8cWDQVZcOMJd4AR
         Q2rUIhPLM0MtoRUN/B6efN3DUO/tnTVWUyVcSWtEcOWFw5uzHvNLZ0Qgj6bifpotmyaC
         U+Tg==
X-Gm-Message-State: AGi0PuY4Re6h2fUPpEe8bx1Oci1eQ7yq6g8HrrxAqtYKuE7sz84h7l8f
        /OnCFxAJlW8zHWDk06HlxIfziOV52yg/A6eoz9/GmBvU
X-Google-Smtp-Source: APiQypIs6NvYWnWH/ktGUdZ2rE2Z5KmJb3YhfiR/lt5cCzkoxxCqS3BQi8X2Ml1ldVHBef942mt8n8y7vFl2hwtoB3Q=
X-Received: by 2002:a25:c646:: with SMTP id k67mr11247591ybf.309.1587973363986;
 Mon, 27 Apr 2020 00:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com> <20200427060551.1372591-2-jiaxun.yang@flygoat.com>
In-Reply-To: <20200427060551.1372591-2-jiaxun.yang@flygoat.com>
From:   =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date:   Mon, 27 Apr 2020 09:42:32 +0200
Message-ID: <CAAdtpL59=bpmEUgY56=xHS3w5ddtdVGjKnnW7i++a5sTzPs+3Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] PCI: Don't disable decoding when mmio_always_on is set
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 27, 2020 at 8:08 AM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> Don't disable MEM/IO decoing when a device have both non_compliant_bars

Typo "decoing" -> "decoding"

> and mmio_always_on.
>
> That would allow us quirk devices with junk in BARs but can't disable
> their decoding.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  drivers/pci/probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 77b8a145c39b..d9c2c3301a8a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1822,7 +1822,7 @@ int pci_setup_device(struct pci_dev *dev)
>         /* Device class may be changed after fixup */
>         class = dev->class >> 8;
>
> -       if (dev->non_compliant_bars) {
> +       if (dev->non_compliant_bars && !dev->mmio_always_on) {
>                 pci_read_config_word(dev, PCI_COMMAND, &cmd);
>                 if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
>                         pci_info(dev, "device has non-compliant BARs; disabling IO/MEM decoding\n");
> --
> 2.26.0.rc2
>
