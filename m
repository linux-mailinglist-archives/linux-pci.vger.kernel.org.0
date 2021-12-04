Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F354685F5
	for <lists+linux-pci@lfdr.de>; Sat,  4 Dec 2021 16:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345086AbhLDPib (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Dec 2021 10:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345013AbhLDPia (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Dec 2021 10:38:30 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5833C061751
        for <linux-pci@vger.kernel.org>; Sat,  4 Dec 2021 07:35:04 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id l25so23970886eda.11
        for <linux-pci@vger.kernel.org>; Sat, 04 Dec 2021 07:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6AuYezFSMC8D0/TN4qK1thEOV1ychy0j4VLFtk6zUI=;
        b=Q07P8A3Tg9dZW3j8u1P01db2KsIKyi3oX1AWc6C/8eLDHDtyzxMjyEdHlWbIs0lREW
         rYAgSkCO5jx/Vj3EuoWQD8kEL45PYjEWIn3O8HIzPwUOF6oSfabk9b6k9Fy0Pd0+kWFG
         PZKOuiY6Sx4v2GOh0m4mCn+da5KR14TfzF1gwfVaByn/utltXnoQ1C/701NkDTtZtBPZ
         +hXA/qw/QCnpXplsP2Dr660QvpygUEbs1Lp06NkWoXlSsqU3mZN8Jyq5E0LNf+io+uaj
         p2pJc+eiaGwElVU/DKPkKjxbDQD+648irVizV981L7SU6/6uOgceJN1vXC4RIMbWnyCA
         WqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6AuYezFSMC8D0/TN4qK1thEOV1ychy0j4VLFtk6zUI=;
        b=fIjXy5I3npW/eHcz0/k69Gs2SZZUy7EUxIRk7FVYCu16besQuwhjB0tAdT3TwIoBqu
         8rkfjs6+PR7dw+i8lrKqZ290lMz2isZrZs29CGaAs4eSDebGlZ8g0Zyqu2G+wxxFsvhv
         7S08QVKMTvZ+JC78552hfhN3ROVk5ZQ/7xrsemH7s9+rdEGZyY+S6vvGMLVMjT6p/shg
         +1Pd8YGOBsBLyXHjsGseG7maKXRVdXxkFKS4CLM8CS5a/3NN3OCKVscM4/N6x3+INEaL
         wBIRlIgYyAYk7qIYGgHdeXtqMG9SeNwfJf+R3lhg64cPKNNrrGSmyZecmpd+ChtlreZw
         aVEA==
X-Gm-Message-State: AOAM531+9JIGdykYxLWrv0Vvl00MWt+YBpBg9cIjwXqUDdkGqqZEVyA2
        wgk8DdFDnQdE6YG2/1gkIHuR6bZFQiMS70BQJ58=
X-Google-Smtp-Source: ABdhPJx000MhmCHSCPXJIpibnW2Nls4PHO+7YL8+LtuEE/hdBWVyV9XXKnzyuqxEjL1I0gjNRSM/G3F/AtTigfwK/TM=
X-Received: by 2002:a17:907:a42c:: with SMTP id sg44mr31730056ejc.335.1638632102916;
 Sat, 04 Dec 2021 07:35:02 -0800 (PST)
MIME-Version: 1.0
References: <20211104000202.4028036-1-festevam@gmail.com> <AS8PR04MB8676C527C11B6E0BCB455E1B8C8D9@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8676C527C11B6E0BCB455E1B8C8D9@AS8PR04MB8676.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 4 Dec 2021 12:34:51 -0300
Message-ID: <CAOMZO5BcinSC=h+uTGiYJqhE7qHeQa7NwYZsSiKgC_Zkm5XROA@mail.gmail.com>
Subject: Re: [PATCH] PCI: imx6: Allow to probe when dw_pcie_wait_for_link() fails
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Richard,

On Wed, Nov 3, 2021 at 9:58 PM Hongxing Zhu <hongxing.zhu@nxp.com> wrote:

> [Richard Zhu] Hi Fabio:
> First of all, thanks for your help to care this bug.
> This dump is planned to be fixed in the #5 patch of
>  '[v4,0/6] PCI: imx6: refine codes and add compliance tests mode support'
> "https://patchwork.kernel.org/project/linux-arm-kernel/cover/1635747478-25562-1-git-send-email-hongxing.zhu@nxp.com/"

Any progress with this?

Since this problem affects the stable kernels, would your series be
applied to the stable tree too?

Could you please resend your series so we can get this issue resolved?
