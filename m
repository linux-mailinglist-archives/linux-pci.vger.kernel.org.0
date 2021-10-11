Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E307E428D0B
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 14:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbhJKMdt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 08:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbhJKMds (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 08:33:48 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E359C061570;
        Mon, 11 Oct 2021 05:31:48 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z20so67014995edc.13;
        Mon, 11 Oct 2021 05:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c2eTRNvAGOUCjeqJDNL2ksEpYYsNkxxTJa86680pxtA=;
        b=oJBU9I8B87kw3u2pSyqP3EO9Eo4TyDScNfSk39tYnZgPMgf0m7PACnzfcEGVxCC2os
         T/g50DDk/tRzWUcWOuYgA5Qa9tcchI/8FEgIDnyXYqf4k6sB13yakKezIfK6KawCCEqd
         N1wMcW2+Grx5OpIikw2CVUcTkUXn1VgvO2s3WtTAetQ2MviOFPmTXKm6RVA92HKYtsbe
         PDaiH9gHch65jgi4G3lNoN8ZTnHg3Eczi/2aGF7HBA//4pOAQNOHp/NY1eA64BAuowQU
         VQ0F9XDbTFeNS2JlYCKrEi7dvxkQLcYVqGQ9jTTL7v76kZi/jwFhVb33y4lh9TVrZkSy
         Cl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2eTRNvAGOUCjeqJDNL2ksEpYYsNkxxTJa86680pxtA=;
        b=Mg7iFl31JkMBjXu7J5gjFNCIt1biR3k72QpnFj/PuSyyqVchlVWOr/MxaIxa8OaCph
         7mu4GoiWXxap8uAUix1/JPfFBlDzgEKlgCqhhai9D+MgV0wSpugl+EI1grgm7VoNXUTw
         SLp295Xh4IzkahE+YNdcIT2oYXUNRWcaXYP5iCCo4d8WxplXx52bwnNsVeVaSOYucgYs
         Rd5CvQCloA4YsS2U6TYtgRKRsxQV94D0hgkdv61lfLFNPN2Ng93stULTf2rTGRc3CEjp
         /xCeCYZjmXkdV+4Hq5alSBEzfe5i0CQs40YfYZZLsgaBjMYzIwpSGat/ymNRrEZQ9PqC
         ZwVg==
X-Gm-Message-State: AOAM533DXeA9jA7Pd0Gdo7faHVcVLVd1UcE0Hou5iQdSHkQaiW6eto76
        UQxBA4wzaDkBovNmXFJmI55S6iNkaZFbsIHAIcQNs0/H
X-Google-Smtp-Source: ABdhPJzyJmztrugduFjx8yXJEK/cUavb61qDiNhKArKQp0oEgoVfgcj0/byTEOFJiWwoBuzOJHOBvnMRrL04aQ8YhTs=
X-Received: by 2002:a17:907:785a:: with SMTP id lb26mr25156333ejc.77.1633955506928;
 Mon, 11 Oct 2021 05:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210723204958.7186-1-tharvey@gateworks.com> <36070609-9f1f-00c8-ccf5-8ed7877b29da@pengutronix.de>
 <VI1PR04MB58533AF76EA4DFD8AD6CDA158CEC9@VI1PR04MB5853.eurprd04.prod.outlook.com>
 <CAJ+vNU1tgVsQWtxa0E8SArO=hA2K8OkqiSPrRSpx0Q5XS4gUWA@mail.gmail.com>
 <CAHCN7xLC1ob_nxRsZezgYQ9p-me7hNd+1MNFQt2wtcRqU+z9Sw@mail.gmail.com> <2eee557db84087acca4665603ba3d2716199f842.camel@pengutronix.de>
In-Reply-To: <2eee557db84087acca4665603ba3d2716199f842.camel@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 11 Oct 2021 07:31:35 -0500
Message-ID: <CAHCN7xJ-bmEtFFw749m+r5Nr4kNwF2SvFGfTKjRPULqshuA89Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add IMX8M Mini PCI support
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 11, 2021 at 7:30 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi Adam,
>
> Am Montag, dem 11.10.2021 um 07:25 -0500 schrieb Adam Ford:
> > On Mon, Aug 16, 2021 at 10:45 AM Tim Harvey <tharvey@gateworks.com> wrote:
> > >
> > > On Thu, Jul 29, 2021 at 6:28 PM Richard Zhu <hongxing.zhu@nxp.com> wrote:
> > > >
> > > > Hi Tim:
> > > > Just as Ahmad mentioned, Lucas had issue one patch-set to support i.MX8MM PCIe.
> > > > Some comments in the review cycle.
> > > > - One separate PHY driver should be used for i.MX8MM PCIe driver.
> > > > - Schema file should be used I think, otherwise the .txt file in the dt-binding.
> > > >
> > > > I'm preparing one patch-set, but it's relied on the yaml file exchanges and power-domain changes(block control and so on).
> > > > Up to now, I only walking on the first step, trying to exchange the dt-binding files to schema yaml file.
> > > >
> > > > Best Regards
> > > > Richard Zhu
> > >
> > > Richard / Ahmad,
> > >
> > > Thanks for your response - I did not see the series from Lucas. I will
> > > drop this and wait for him to complete his work.
> > >
> >
> > Tim,
> >
> > It appears that the power domain changes have been applied to Shawn's
> > for-next branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/log/?h=for-next
> >
> > Is there any chance you could rebase and resend this series?
>
> This wasn't about the power domain series. I also tried to get i.MX8M
> PCIe upstream, but the feedback was that we need to split out the PHY
> functionality, Richard is currently working on this. There is no point
> in resending this series.

Sorry.  I missed that part.

adam
>
> Regards,
> Lucas
>
