Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D833590C8
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 02:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhDIAIz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 20:08:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232426AbhDIAIy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Apr 2021 20:08:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8571A61151;
        Fri,  9 Apr 2021 00:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617926922;
        bh=qxJRcVi62skPjVFxtDZYDCneC8H474XHfsKWRzb8vwU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ezqaxpe95teY8l4Czlv0qwVfF5wl6ptxfIohGcKCev7suE8GrpJu7LgbLaT7+fhsv
         a/d63jXo9q6O8Xvl0a65rUvoiVKRSMmW62hmos1KzKh4102tsxiLhQCnRLA3pYJzaE
         wiCfht2NUYRTabenMTHUhthwtO0izDVKY8eIFq4/M8hCgQJwBs0ejs1nECflzEsdVa
         RhbVAF/lE8bGi2i8TR5Pdeg3t4/QT9xz0h1x0CrLQl+1Axk8TDX7QwYavrriKDRaVQ
         ICdaTPkQVGL9JkLKKxE7aZ95S8oKD5j7FftEnYfR+yX1gnDnk42nUhfHoPbztfrx9e
         s99x0W9mIzVxQ==
Received: by mail-ej1-f51.google.com with SMTP id u21so5824367ejo.13;
        Thu, 08 Apr 2021 17:08:42 -0700 (PDT)
X-Gm-Message-State: AOAM530bcFV7g0DL1z9sYRtMKfEssD/OHk+v0aNH+pE915ilI3Cp3yn6
        nh2rrCDxj9yctgKmpe63yDFz/sO1pIYTzzrGfA==
X-Google-Smtp-Source: ABdhPJwx/3Iw02ud8LvHz68WTBViwFyXKW2NEYhJj3OtVPrAMJQ84oooI/2WLc3adlSB8AjsLxr2M2LEuQ9Iv/JA7Po=
X-Received: by 2002:a17:907:9614:: with SMTP id gb20mr13428605ejc.108.1617926921182;
 Thu, 08 Apr 2021 17:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210407030948.3845-1-Zhiqiang.Hou@nxp.com> <20210407030948.3845-7-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20210407030948.3845-7-Zhiqiang.Hou@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 8 Apr 2021 19:08:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJjZKMB57oa-TtkBnGLRNa_V6+_upn9Cw55YHKre+b0oQ@mail.gmail.com>
Message-ID: <CAL_JsqJjZKMB57oa-TtkBnGLRNa_V6+_upn9Cw55YHKre+b0oQ@mail.gmail.com>
Subject: Re: [PATCHv5 6/6] PCI: layerscape: Add power management support
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Yang-Leo Li <leoyang.li@nxp.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 6, 2021 at 10:04 PM Zhiqiang Hou <Zhiqiang.Hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Add PME_Turn_Off/PME_TO_Ack handshake sequence, and finally
> put the PCIe controller into D3 state after the L2/L3 ready
> state transition process completion.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V5:
>  - Fix a typo of the parameter given to function dw_pcie_setup_rc()
>
>  drivers/pci/controller/dwc/pci-layerscape.c  | 382 ++++++++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h |   1 +
>  2 files changed, 381 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
