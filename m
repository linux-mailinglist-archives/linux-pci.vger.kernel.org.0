Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC7B3090B4
	for <lists+linux-pci@lfdr.de>; Sat, 30 Jan 2021 00:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhA2XkO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jan 2021 18:40:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231296AbhA2XkM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jan 2021 18:40:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC77A64DFB;
        Fri, 29 Jan 2021 23:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611963571;
        bh=ERrJYHFh8Jj6TX3rWZ8jzW16SHBX6admnR8+Rc0W3iA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IhHNVERl3GvC0h6SOMOD/atc+1VsIPS/6gySIr4qlDWRXNI2Gtx91MT0UeXUFVN8i
         pbAS+FIPkCzaTpf3vZyuMROZgTOaUpu3Vc73G5EYk0jurTdZyX5dsXHba34rvgogvp
         d7m6bHm/nB4stDF1g8dO3WzoJisodcVOpZQ2+u1oYTaaRK1/N/BuosOjOktII6JBTB
         tedI5aoh5Hz2EGCwzyEvqwNMFbhSu++SKG46dGiLk4xL/FiYULXGe4a8SwbyXinXem
         Y2d7UEvSKHFBYOGs4yMdiGvxHHaOUx2GQub5hDTrne9+dXEn3yIKLVaUXv+Kz8Hi//
         iMNIRbCvPXODQ==
Received: by mail-ed1-f51.google.com with SMTP id s11so12526061edd.5;
        Fri, 29 Jan 2021 15:39:30 -0800 (PST)
X-Gm-Message-State: AOAM530Cpz1KAMEel8DPJcyIdevJ3QxbZf4woGUlZHftxvOtfnKl3H4O
        3lnpy08menNckY5NodI5WarIB97iDmSsjZPbBA==
X-Google-Smtp-Source: ABdhPJwj8wUk4PoqlM3tcYKPzYCPGNO0F0zImcCS2wvT5z3jofsqBR0sdYUgKNDBI+L9oGNn3ZsyveDUbiuFp1F4y+o=
X-Received: by 2002:aa7:d987:: with SMTP id u7mr7891493eds.62.1611963569366;
 Fri, 29 Jan 2021 15:39:29 -0800 (PST)
MIME-Version: 1.0
References: <20210128175225.3102958-1-dmitry.baryshkov@linaro.org>
 <20210128175225.3102958-4-dmitry.baryshkov@linaro.org> <CAL_JsqLRn40h0K-Fze5m1LS2+raLp94LariMkUh7XtekTBT5+Q@mail.gmail.com>
 <da0ac373-4edb-0230-b264-49697fa3d86a@linaro.org>
In-Reply-To: <da0ac373-4edb-0230-b264-49697fa3d86a@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 29 Jan 2021 17:39:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJcBDfa6s7sG0Zho41T7zbVg15GH2WDh+inKNtTs+CcZw@mail.gmail.com>
Message-ID: <CAL_JsqJcBDfa6s7sG0Zho41T7zbVg15GH2WDh+inKNtTs+CcZw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] pcie-qcom: provide a way to power up qca6390 chip
 on RB5 platform
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 28, 2021 at 9:45 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 28/01/2021 22:26, Rob Herring wrote:
> > On Thu, Jan 28, 2021 at 11:52 AM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> >>
> >> Some Qualcomm platforms require to power up an external device before
> >> probing the PCI bus. E.g. on RB5 platform the QCA6390 WiFi/BT chip needs
> >> to be powered up before PCIe0 bus is probed. Add a quirk to the
> >> respective PCIe root bridge to attach to the power domain if one is
> >> required, so that the QCA chip is started before scanning the PCIe bus.
> >
> > This is solving a generic problem in a specific driver. It needs to be
> > solved for any PCI host and any device.
>
> Ack. I see your point here.
>
> As this would require porting code from powerpc/spark of-pci code and
> changing pcie port driver to apply power supply before bus probing
> happens, I'd also ask for the comments from PCI maintainers. Will that
> solution be acceptable to you?

Oh good, something exists. :)

FYI, there's another similar case needing this that just popped up[1].

Rob

[1] https://lore.kernel.org/linux-pci/20210129173057.30288c9d@coco.lan/
