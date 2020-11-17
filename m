Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D566B2B685C
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 16:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbgKQPLX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 10:11:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730209AbgKQPLX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Nov 2020 10:11:23 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1DFA2466D;
        Tue, 17 Nov 2020 15:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605625882;
        bh=C4yS4FgGZ20hDfC8vb6+iWWOh9UGXCtT+oSCVv0lIc4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pMmlPRXqfc4CNOJBE61Lq46N8AufvzV0juXIToPXF9eSdyh+5jf+xJwAuxBifBWRn
         6xKCPPS9lE6kx/zKjAtyEzngPlkHYG0JMLJEq4ZfJ1VDicVVXbhkveW3gzSbRKzNf0
         wO5JS4ODDm/If1lwxEtd6+2d4bHy7AmDOsh/yK9s=
Received: by mail-ot1-f48.google.com with SMTP id j14so19727971ots.1;
        Tue, 17 Nov 2020 07:11:22 -0800 (PST)
X-Gm-Message-State: AOAM5326iwHhqA8Lc02HqF3qRljUSkBAWL3tN4Q99hfmMWygNxA+FWty
        ZCCRvwWJmPOGkXlhi20xU6I2cMszPEnUuANPvwg=
X-Google-Smtp-Source: ABdhPJzPDDDU77Y0ooUlA2nKsjWglmGXsBwnC46xjWewyrbSPbTP1FKa46jAA1eQXgiQ5xjfh5Pjb9fXC8wikOToY/s=
X-Received: by 2002:a05:6830:22d2:: with SMTP id q18mr3025922otc.305.1605625881933;
 Tue, 17 Nov 2020 07:11:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605306931.git.gustavo.pimentel@synopsys.com>
 <CAK8P3a3TpnQmcWFkBJyi7CxdzgyyzxXzA3mokYvcem6yEh7Bdg@mail.gmail.com> <DM5PR12MB18352E62E07B9FBDDB89F1A9DAE20@DM5PR12MB1835.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB18352E62E07B9FBDDB89F1A9DAE20@DM5PR12MB1835.namprd12.prod.outlook.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 17 Nov 2020 16:11:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2Tmr6XsmPbO4JT_kcogk8C7m6wyPwv+t1a2_4oaysy-A@mail.gmail.com>
Message-ID: <CAK8P3a2Tmr6XsmPbO4JT_kcogk8C7m6wyPwv+t1a2_4oaysy-A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] misc: Add Add Synopsys DesignWare xData IP driver
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 17, 2020 at 3:53 PM Gustavo Pimentel
<Gustavo.Pimentel@synopsys.com> wrote:
> On Tue, Nov 17, 2020 at 14:4:49, Arnd Bergmann <arnd@kernel.org> wrote:
> > On Fri, Nov 13, 2020 at 11:37 PM Gustavo Pimentel <Gustavo.Pimentel@synopsys.com> wrote:
> > >
> > > This patch series adds a new driver called xData-pcie for the Synopsys
> > > DesignWare PCIe prototype.
> > >
> > > The driver configures and enables the Synopsys DesignWare PCIe traffic
> > > generator IP inside of prototype Endpoint which will generate upstream
> > > and downstream PCIe traffic. This allows to quickly test the PCIe link
> > > throughput speed and check is the prototype solution has some limitation
> > > or not.
> >
> > I don't quite understand what this hardware is, based on your description.
> > Is this a specific piece of hardware that only serves as a traffic generator,
> > or a particular hardware feature of the DesignWare endpoint, or is it
> > software running on a SoC in endpoint mode while plugged into a Linux
> > system running this driver on the host?
>
> Firstly you have to have in mind that we are talking about an HW
> prototype based on FPGA. This PCIe Endpoint HW prototype from Synopsys
> might have multiple HW blocks inside (depends on the HW design), in this
> particular prototype case, it has an HW block is called xData (available
> internally to Synopsys only) which is a PCIe traffic generator, this
> block has no practical usage, unless for HW validation and testing new
> designs that push forward new PCIe speeds.

Ok, got it. Thanks for the explanation.

> > My feeling is that this should be located more closely to drivers/pci/,
> > but that depends on what it actually does.
>
> I thought to put on /misc because the purpose is very limited and doesn't
> fit in a normal case.

Makes sense. I usually try to ensure we don't add anything to drivers/misc
that could reasonably be grouped with related code elsewhere, but
I agree there isn't much that fits into this category today, so let's leave
it there unless someone comes up with a better idea.

The only alternative I could see would be drivers/pci/testing/

      Arnd
