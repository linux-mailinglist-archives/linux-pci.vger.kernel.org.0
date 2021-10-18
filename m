Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE0A432969
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 23:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhJRWAX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 18:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbhJRWAW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Oct 2021 18:00:22 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36843C061745
        for <linux-pci@vger.kernel.org>; Mon, 18 Oct 2021 14:58:11 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id a13so7008033qkg.11
        for <linux-pci@vger.kernel.org>; Mon, 18 Oct 2021 14:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VNpqRRdnPDIUGCc3uEFG9REMCz+uQZwgGwBrpVs1X7k=;
        b=PzH1/3QFJDCAo6+yfE9yZp3FhN5bdJblxdwmrYJXz4W0YDV5QgMDwXPS+9oDzaYsmR
         1hy1VBsrs0g+cboLAmAYffm5C4OKJ9PZknz0zqdbSlWGpa8IqJfWmggmKLf9VGSQPSoq
         bF2fHToJMjgOwuWZ6BDY28QPn+sUaZRuPFe0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNpqRRdnPDIUGCc3uEFG9REMCz+uQZwgGwBrpVs1X7k=;
        b=kbX+8RCFjFonhjfjreJxoykkKnjhVgwCJtuTQGPW32WyqnVsAmb+Ju2AUSAdFnaB7R
         wskfctJl58Eeb6KcxCT7+NwQcBcwNlisJqNeZS6pw63LMNcnQOCcLNbrjyaULVgOrnCx
         AmyFrpT7blOjB+qCkBquNq8LiZQAnpPjsXEZ5SOqpmc9UISC1oH0GzK64icXOXweS9T8
         +q58VSx6n0avM4M/O6dfwe+GH4lR+hNGLiUZQ6kVgSPumIfUHo5vZZHLHyltnoj4oG5e
         KrhmpSv2wvqV1ffEt0iNZQQE/lN23rix83d638vGjTOQfpqhWNIVcR6MThuFpUbI9pRw
         z9ZA==
X-Gm-Message-State: AOAM5301cTDS/WZkSlqxW0yvpo82tKpxS/gpmZoFhrfWVHPC/TAvY3CN
        v9Kv7NDcmQPo6tj8POVZ+F2VCPPB9eHSnw==
X-Google-Smtp-Source: ABdhPJwU3soZVWhovOcpJkO66EsCCITKH06vHcsIfeQnl4h00WhEW1p0ISfUNf39kf59GUXSlM4U5A==
X-Received: by 2002:a37:bb85:: with SMTP id l127mr24679729qkf.433.1634594290308;
        Mon, 18 Oct 2021 14:58:10 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id 125sm7077464qkf.95.2021.10.18.14.58.08
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 14:58:09 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id g6so2160345ybb.3
        for <linux-pci@vger.kernel.org>; Mon, 18 Oct 2021 14:58:08 -0700 (PDT)
X-Received: by 2002:a5b:102:: with SMTP id 2mr31008124ybx.101.1634594288583;
 Mon, 18 Oct 2021 14:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <1633628923-25047-1-git-send-email-pmaliset@codeaurora.org>
 <20211013100005.GB9901@lpieralisi> <CAE-0n52fZZkWt5KxF8gq0D55f_joq0v2sBBp81Gts8cBt6fJgg@mail.gmail.com>
In-Reply-To: <CAE-0n52fZZkWt5KxF8gq0D55f_joq0v2sBBp81Gts8cBt6fJgg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 Oct 2021 14:57:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WYvV+=uyEOYq7LjtBgpSGV6KovvoS1e88fgc1kpt_c7Q@mail.gmail.com>
Message-ID: <CAD=FV=WYvV+=uyEOYq7LjtBgpSGV6KovvoS1e88fgc1kpt_c7Q@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] Add DT bindings and DT nodes for PCIe and PHY in SC7280
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, svarbanov@mm-sol.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        sallenki@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Fri, Oct 15, 2021 at 12:43 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Lorenzo Pieralisi (2021-10-13 03:00:05)
> > On Thu, Oct 07, 2021 at 11:18:38PM +0530, Prasad Malisetty wrote:
> > > Prasad Malisetty (5):
> > >   dt-bindings: pci: qcom: Document PCIe bindings for SC7280
> > >   arm64: dts: qcom: sc7280: Add PCIe and PHY related nodes
> > >   arm64: dts: qcom: sc7280: Add PCIe nodes for IDP board
> > >   PCI: qcom: Add a flag in match data along with ops
> > >   PCI: qcom: Switch pcie_1_pipe_clk_src after PHY init in SC7280
> > >
> > >  .../devicetree/bindings/pci/qcom,pcie.txt          |  17 +++
> > >  arch/arm64/boot/dts/qcom/sc7280-idp.dts            |   8 ++
> > >  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |  50 +++++++++
> > >  arch/arm64/boot/dts/qcom/sc7280-idp2.dts           |   8 ++
> > >  arch/arm64/boot/dts/qcom/sc7280.dtsi               | 118 +++++++++++++++++++++
> > >  drivers/pci/controller/dwc/pcie-qcom.c             |  95 +++++++++++++++--
> > >  6 files changed, 285 insertions(+), 11 deletions(-)
> >
> > I applied patches [4-5] to pci/qcom for v5.16, thanks I expect other
> > patches to go via the relevant trees.
> >
>
> Lorenzo, can you pick up patch 1 too? It's the binding update for the
> compatible string used in patch 4-5.

I think that means that patches 2-3 are ready to land in the Qualcomm
tree assuming Bjorn Andersson is still accepting patches there for
5.16, right?

-Doug
