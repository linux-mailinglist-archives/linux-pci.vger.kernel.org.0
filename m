Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1BA444D12
	for <lists+linux-pci@lfdr.de>; Thu,  4 Nov 2021 02:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhKDBrq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 21:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhKDBrp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Nov 2021 21:47:45 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30479C061714
        for <linux-pci@vger.kernel.org>; Wed,  3 Nov 2021 18:45:08 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id e5so7973410uam.11
        for <linux-pci@vger.kernel.org>; Wed, 03 Nov 2021 18:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qd9RkpAvuJEmvESuc16y2AWdHxBlfYYGMPp36jcOAe0=;
        b=pD5VFKHMD8YwECukG2MDwDgrHIRRf+CJhx70G4N0Tcsnu/DlcsI1zHYuOs5HQ24KTy
         3PUuNZ/t/kqgNwY1sAmFLHtmaiEfDTDFOF5WHRjBshhFiH9GQyFfvNn3gEiqWGbLH15U
         gYZgVf7yyj0TdqI6TAwBGQtlsHC5rznH9tkCmMwWMcZiJaDtVA+z+FkY2QHhxNTINmjd
         1C+3/M6qGAvNaMwf8fU4kJMIretwr9QchvKut0FsJ0bl3djw4AeEoSHX9eyCb+DJCIoH
         HWiwjjWgS7pchu5wLo9SjmP1qeFJxEsw2ek1RLruYpcXZjdQsHUrfHC+2Nu+I/PgXozS
         CjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qd9RkpAvuJEmvESuc16y2AWdHxBlfYYGMPp36jcOAe0=;
        b=Vt9cVgb2C8L66ahLoBelOFEfFFFXZ3qTFe57HqVloYa1xw3KwBO2aI8CiplQ/0m4bT
         nRbCrqzwvpMNe8qt8dzfgTyvsvVeXGQPqnlv1BJjKV2EOSyh3dPAAiIBnkLy+nbzTvB/
         ScsHOHqgOFskbEMTBu8NoH2KO9gxn8nYwFg+HO0KQmS2dtwG2nayed1W3ZDzX5SBAC7M
         AqgA52KXZsxBZq9x4ZVdtjreBr/QBcJ+UhrMw61wRIofb02LerQmPqwz/Fdu80kO+vli
         gEaizCydgM18JL8ZQkZwW2P4JKK2U2LgJZkLMRl6ktQFau5TwCsUgEddAQk6TtkQ/bCT
         Ja3w==
X-Gm-Message-State: AOAM530FOeln5SHzj5+jeX3vQe5gHHzn4Tu8EjEZHNMJVkXrOm5KkbAx
        y7ewz1pPpeVK5EVurNFZiX+V4frlPf4r+WMDqjg=
X-Google-Smtp-Source: ABdhPJwIpg8ZQsKIJ/tBVM2jv1YZCRiXxLdNmQEsatRHoNWfidWW7ktWogRPgLfGGAI2IWnHGtLS5O/hObu+QtOZDAA=
X-Received: by 2002:a05:6102:38cb:: with SMTP id k11mr2864275vst.3.1635990306972;
 Wed, 03 Nov 2021 18:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211104000202.4028036-1-festevam@gmail.com> <AS8PR04MB8676C527C11B6E0BCB455E1B8C8D9@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8676C527C11B6E0BCB455E1B8C8D9@AS8PR04MB8676.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 3 Nov 2021 22:44:56 -0300
Message-ID: <CAOMZO5CHOS9sczwa1ts4e0jaSjxa9CyGG8yCEJUjEj4BUf7Z2w@mail.gmail.com>
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

Ok, great. Since this patch 5/6 is a bug fix, could you re-order this
series so that the bug fix is the first one in the series?

This makes it easier for the backport to stable.

Patch 1/6 is just a cleanup and could go further.

Thanks
