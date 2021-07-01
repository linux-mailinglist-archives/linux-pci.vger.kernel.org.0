Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1797D3B93F7
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 17:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbhGAPdF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 11:33:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233064AbhGAPdE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 11:33:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C4506140C;
        Thu,  1 Jul 2021 15:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625153434;
        bh=KplcsUz5EPujORenVsapc0TaiOFOj0cwWG8KLoYP5h4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KKb6nteJLe9Ab0ti6zI+eReHimNncjem6stUroePoFj6ZH7nXRcZUOZls5qTLiJ25
         8YEaB0QJueBFTq0N5RcQ4Dgqy2tj4r8WF7AENnmz5lv4OHZw5KeG7osxeHFDKDE8bM
         MqbPgdESSqTcNwsOVZEfzoAMObxYldHwetAYknLiLZptnAOqes55L7Zn+6NdXXfYum
         WmTjnpSVLWQEUHmAVFGXaImhe1LYY38Udb3LVztEr6VZwf0bgNSBNvC0Y8bjOVUQtE
         yqPhm5907r9K8oFuCxvFdNFZY4Ga7eiY73McgKyL2r3gGjkZqcySZ6lImtYvI2F5BA
         BAwgCc16iC6ig==
Received: by mail-ed1-f45.google.com with SMTP id x12so9013658eds.5;
        Thu, 01 Jul 2021 08:30:34 -0700 (PDT)
X-Gm-Message-State: AOAM533YAz7k3GW/B9cp//wLQvX9+dE9w9dibuTmwHJfXe3XeSoNBpV2
        033ormgYzcPslPFBAXKt0gPno3oEMQExPuNBWA==
X-Google-Smtp-Source: ABdhPJzIvcS3XZE1OUYeuHNDEAGCqgevyqYZlOCL0nBdsk7GZwOgyCOOawNz0q9OYmjZTjT79/uhD90cUACnd6TAa2Y=
X-Received: by 2002:a05:6402:ca2:: with SMTP id cn2mr580847edb.62.1625153432682;
 Thu, 01 Jul 2021 08:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210629234952.306578-1-nobuhiro1.iwamatsu@toshiba.co.jp> <20210629234952.306578-2-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20210629234952.306578-2-nobuhiro1.iwamatsu@toshiba.co.jp>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 1 Jul 2021 09:30:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKqM8yFLsB3kBDqv=_8HqY4Cv2JOT5CmQA3q-WebdmXpw@mail.gmail.com>
Message-ID: <CAL_JsqKqM8yFLsB3kBDqv=_8HqY4Cv2JOT5CmQA3q-WebdmXpw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: pci: Add DT binding for Toshiba
 Visconti PCIe controller
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 29, 2021 at 5:50 PM Nobuhiro Iwamatsu
<nobuhiro1.iwamatsu@toshiba.co.jp> wrote:
>
> This commit adds the Device Tree binding documentation that allows
> to describe the PCIe controller found in Toshiba Visconti SoCs.
>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .../bindings/pci/toshiba,visconti-pcie.yaml   | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml

Please resend to DT list so that automated checks run.

Rob
