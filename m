Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1044D9C86
	for <lists+linux-pci@lfdr.de>; Tue, 15 Mar 2022 14:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbiCONm6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Mar 2022 09:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348854AbiCONm4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2022 09:42:56 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E61B532C0
        for <linux-pci@vger.kernel.org>; Tue, 15 Mar 2022 06:41:44 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id w7so22195521ioj.5
        for <linux-pci@vger.kernel.org>; Tue, 15 Mar 2022 06:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3uaD53W4zQXTyZwVHH1JB2XZ73tQmzbVHSL//h1f2ug=;
        b=7y/IZRcyoKi4gwO1g958k9ieziqGbrLKVzAHRAWXrHo0/OJcYDHqbQ9P1F9Rhcpfsf
         aEYbQSp+6mk3Y4ysyrAgeefwxXmNxgejdRZRlZQgHGG2vjY42aT7fJBHzSb7/AuMAm9+
         R5Gc0Qo8Gk27ARHeueVfHnQFdNfAgBH0ttUzSo4QaDqTxd4Ea+fBk0ZFo/Bjby5cIs+R
         xDrVCYYY3G/BqnQRCPF8qc07stoKS7IsGvXr/vLJJ7bB8a5C+JDo7SjubRwKUO4dGXRc
         sG4zB+xcb0O7AC+ght5GA3d9fXU17DaZmfGHLIZALwZsQF2UBmIcE5hX4QeMf7517PVf
         nQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3uaD53W4zQXTyZwVHH1JB2XZ73tQmzbVHSL//h1f2ug=;
        b=WSTKdzYpBRTBMb4OCXxivBOwIzaYrUaz4dzYBaUhZDJa5/vMfBDuQnFuIkH+l2PlNY
         yyKwkr3FKQryFswU53sdngFep6dkXfDMujp52RQZiLculGrUnBgZUyPTr51qWDLCElU6
         VjRUfGFZsiQfcWsza5L91mgAAXm2WSHd/tSw0YdEhrzIFmaaFzG5+hWELkWH4AX6wgFv
         qFYVNdiRNH8PaxjmsnBtxjDYqeVk0OOnCeCiiCqjiSpNEw/VA6BtkFloSFfMJqzviBlx
         ruEq89aNumMNq8YiI9YUVaeWrJtUOheqpWeCgGlrfR+r19IT0rZOwoqQ+/9J9MrReuyF
         x8gw==
X-Gm-Message-State: AOAM530QsMROiNmaKy8StBCiPtgPq7RsuioxdY9z2k/ib4u7ks7rQuON
        e+fCFmyDP9WDyPGtEilPg9/uUBUswFRG7ntdPBbetCGMIJVxRfSI
X-Google-Smtp-Source: ABdhPJxzTwGo7p/OwR+drVP9dHdKJu3Z/vyiS4EbXsb34lz1aTHyCGPZICs68xEpu1a1MgT/BHjEbO2Ud7p1knp2bPY=
X-Received: by 2002:a05:6638:41a:b0:317:b934:681b with SMTP id
 q26-20020a056638041a00b00317b934681bmr24163896jap.317.1647351703321; Tue, 15
 Mar 2022 06:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1644234441.git.baruch@tkos.co.il> <20220211160645.GA448@lpieralisi>
 <CA+HBbNEham1bukiEv5Px2=fCnqnbBKWBy3xOKe89fioQWttoGg@mail.gmail.com> <874k3zbaxc.fsf@tarshish>
In-Reply-To: <874k3zbaxc.fsf@tarshish>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 15 Mar 2022 14:41:32 +0100
Message-ID: <CA+HBbNEgQoNZ2v5Wr-KjJ3+U_NPzhW2Tz9bn7pTAUTQ-_owudw@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] PCI: IPQ6018 platform support
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        linux-pci@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 15, 2022 at 2:30 PM Baruch Siach <baruch@tkos.co.il> wrote:
>
> Hi Robert,
>
> On Tue, Mar 15 2022, Robert Marko wrote:
> > On Fri, Feb 11, 2022 at 5:06 PM Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> >>
> >> On Mon, Feb 07, 2022 at 04:51:23PM +0200, Baruch Siach wrote:
> >> > This series adds support for the single PCIe lane on IPQ6018 SoCs. The code is
> >> > ported from downstream Codeaurora v5.4 kernel. The main difference from
> >> > downstream code is the split of PCIe registers configuration from .init to
> >> > .post_init, since it requires phy_power_on().
> >> >
> >> > Tested on IPQ6010 based hardware.
> [snip]
> >> >
> >> > Baruch Siach (2):
> >> >   PCI: dwc: tegra: move GEN3_RELATED DBI register to common header
> >> >   PCI: qcom: Define slot capabilities using PCI_EXP_SLTCAP_*
> >> >
> >> > Selvam Sathappan Periakaruppan (1):
> >> >   PCI: qcom: Add IPQ60xx support
> >> >
> >> >  drivers/pci/controller/dwc/pcie-designware.h |   7 +
> >> >  drivers/pci/controller/dwc/pcie-qcom.c       | 155 ++++++++++++++++++-
> >> >  drivers/pci/controller/dwc/pcie-tegra194.c   |   6 -
> >> >  3 files changed, 160 insertions(+), 8 deletions(-)
> >>
> >> Bjorn, Andy,
> >>
> >> Can you ACK please if this series is ready to be merged ?
> >
> > This would also help the IPQ8074 which has the same controller for the
> > Gen3 port.
> >
> > I have been using this for OpenWrt for a while and it works.
>
> Thanks for your test report.
>
> It would be nice to have a formal Tested-by for the pcie-qcom.c
> patch. It might help to push the patch forward.

Hi Baruch, I am not sure whether a Tested-by would be applicable here as its
a different platform, that is why I left it out.
>
> Can you also share the device-tree part? I'll add it to this series in
> case it needs a respin.
Currently, the IPQ8074 DTS regarding QMP PCI PHY-s and PCI controllers is
incorrect, it was all based on v1 of the SoC which is not supported at all.
Gen3 QMP PHY support is currently missing for IPQ8074 and I am working on
upstreaming that and will fix up all of the PCI-related stuff in the
DTS after that.

So, I would prefer to keep those separate and let this series get
merged, especially
since the DTS part has already been merged.

Regards,
Robert
>
> Thanks,
> baruch
>
> --
>                                                      ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
