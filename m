Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A68C39C2C8
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 23:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhFDVqg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 17:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhFDVqf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jun 2021 17:46:35 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3016C061768
        for <linux-pci@vger.kernel.org>; Fri,  4 Jun 2021 14:44:33 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id x22-20020a4a62160000b0290245cf6b7feeso2575725ooc.13
        for <linux-pci@vger.kernel.org>; Fri, 04 Jun 2021 14:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=JC25WRkZBCsb3Y5fTmPTp2hPTJRZh/K4xt7YQY7D4O4=;
        b=JEuNpd7gylFZbn17vVqmqdfMkxy98APrgbMp+o9mS3siWPpRSQ5uuQC27Gq+IxH3f/
         Uw+n45L9SrKQgTZzpmwBj276JTiqal+9MsRFOLtEithQ8VpG70/P3q64NpP/EmQW/sol
         OxiBdWTz0xPY6SHodkTBiCS7Ga0O9GDcAtfUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=JC25WRkZBCsb3Y5fTmPTp2hPTJRZh/K4xt7YQY7D4O4=;
        b=o9sY4LBAuHMJqCX88q9xDQDfBFGwybeWeTX2K4ndXcL4TIEgfJ3fFWVZqwwz02rr8Z
         ctiAL7riJMwedFU5YhlgbIO/BvlUGzLbTM2urqyrnSBU10gyqAm0jnA4yVostctmO6st
         AUc0a5Y90P+Xj0JjibbmgwFLUK2y0uyuR8Ow8PmlVmsZiuAag1TeqJ2xMGnq79Z6Y1P1
         reWRadfc3d1m0mcGvSGB1XMF9P8f5VdiBasNzgvMZCAk7703EF1K8BYuKfUOTkXbN3J2
         g4JMscpgt7w6OPAYBOIStM4e3Gz7b6zgwcdPX8njoePf1qTmBNfD3GwNltAqpO7C42x4
         0kfQ==
X-Gm-Message-State: AOAM533xRabbvOmrDKkIiIg6Bsy3NPBa+ZrkduF7Ou6YxJ9l1ezVAH5Z
        0EwLoZ9xcUA/PjICN81h7OpTX6idyOm616YmC4SObg==
X-Google-Smtp-Source: ABdhPJy6w6LzfZQraXTUpEoGT0ueZEnZUPP6hi0L9uLghxBapXi3lqND0wjFan+pdkwveTfBuC+LSOhCIDuLCnteMIM=
X-Received: by 2002:a05:6820:1048:: with SMTP id x8mr5240459oot.16.1622843073335;
 Fri, 04 Jun 2021 14:44:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Jun 2021 21:44:33 +0000
MIME-Version: 1.0
In-Reply-To: <cb2a6cd35df42314c5e5230bcac752be@codeaurora.org>
References: <1620382648-17395-1-git-send-email-pmaliset@codeaurora.org>
 <1620382648-17395-2-git-send-email-pmaliset@codeaurora.org>
 <CAE-0n53KTeF9NOrb+x7P1AG53FENRBGtCEcSxronBpJoww3jew@mail.gmail.com> <cb2a6cd35df42314c5e5230bcac752be@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 4 Jun 2021 21:44:32 +0000
Message-ID: <CAE-0n52y3yuyOrexC+EsnsX6ULDwKDz1PczGwHB211hKu=uj1g@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: pci: qcom: Document PCIe bindings for SC720
To:     Prasad Malisetty <pmaliset@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mgautam@codeaurora.org, dianders@chromium.org, mka@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Prasad Malisetty (2021-06-04 04:26:57)
> On 2021-05-08 01:29, Stephen Boyd wrote:
> > Quoting Prasad Malisetty (2021-05-07 03:17:26)
> >> Document the PCIe DT bindings for SC7280 SoC.The PCIe IP is similar
> >> to the one used on SM8250. Add the compatible for SC7280.
> >>
> >> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> >> ---
> >>  Documentation/devicetree/bindings/pci/qcom,pcie.txt | 17
> >> +++++++++++++++++
> >>  1 file changed, 17 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> >> b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> >> index 0da458a..e5245ed 100644
> >> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> >> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> >> @@ -12,6 +12,7 @@
> >>                         - "qcom,pcie-ipq4019" for ipq4019
> >>                         - "qcom,pcie-ipq8074" for ipq8074
> >>                         - "qcom,pcie-qcs404" for qcs404
> >> +                       - "qcom,pcie-sc7280" for sc7280
> >>                         - "qcom,pcie-sdm845" for sdm845
> >>                         - "qcom,pcie-sm8250" for sm8250
> >>
> >> @@ -133,6 +134,22 @@
> >>                         - "slave_bus"   AXI Slave clock
> >>
> >>  - clock-names:
> >> +       Usage: required for sc7280
> >> +       Value type: <stringlist>
> >> +       Definition: Should contain the following entries
> >> +                       - "aux"         Auxiliary clock
> >> +                       - "cfg"         Configuration clock
> >> +                       - "bus_master"  Master AXI clock
> >> +                       - "bus_slave"   Slave AXI clock
> >> +                       - "slave_q2a"   Slave Q2A clock
> >> +                       - "tbu"         PCIe TBU clock
> >> +                       - "ddrss_sf_tbu" PCIe SF TBU clock
> >> +                       - "pipe"        PIPE clock
> >> +                       - "pipe_src"    PIPE MUX
> >
> > Is pipe_src necessary? Is it the parent of the pipe clk? If so, please
> > remove it and do whatever is necessary on the pipe clk instead of the
> > parent of the clk.
>
> Here pipe_src is MUX. Newer targets require changing pipe-clk mux to
> switch between pipe_clk and XO for GDSC enable.
> After PHY init, need to configure MUX.

Ok. I see, so we have to change the parent of the parent of the pipe
clk?
