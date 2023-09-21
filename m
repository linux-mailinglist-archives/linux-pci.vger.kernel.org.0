Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6C27AA226
	for <lists+linux-pci@lfdr.de>; Thu, 21 Sep 2023 23:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjIUVNN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 17:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjIUVMu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 17:12:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E572A9ED;
        Thu, 21 Sep 2023 10:07:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E79EC4E689;
        Thu, 21 Sep 2023 12:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695298861;
        bh=KjzToofit3Y0FeaIc14Emfkd61E5wMUffmNSlgfWlws=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QYPRqg52qxooQYcthEAw6iPy3gYDm21MYLktLHDAFDD++GvQsqO3Pbl8kWx66N/k4
         Ph1CAC1jiL8JbHCS47VNxUhcpRQYmEs1O/swIpxSAf2AIBRdwLCD/mCVMbTGWgQ/Mh
         MnaAOkLhXGjOvwo584s9DUETmNucy7IQJPhqjP88A6fiibMY48yT58OyvlVMnxwOKQ
         xpRwmKPmoncBvidVZz1wY5nHgntHNAdLpGnqyN0MTnCnOy5Y/+uHtfxuS02/m9zc+S
         Y4e+hK97eCLA1c/pqsmEHfoHXoIMVj4vNPnxhgF4MR8n1V7KpY2ZRJ2HsOBzTW3MjB
         mUCvSxGbx7mgg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2bfea381255so14450931fa.3;
        Thu, 21 Sep 2023 05:21:01 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxg6EfmUwUYQqqAT2nePFV5hcTFEIXnYMNzdwebgE1Qs8WlHyi6
        SHBl0SS8JU5Oaru30ch/ShQY7CZeFQUdSihLww==
X-Google-Smtp-Source: AGHT+IEoXQqtt9tbYjAQ7FzV0NWQLqTY9v9t3vyNONu7fH6AtTwCNEpI851pYP7RujJ8URZmSKpMv4HJsMK8Dv1j3xQ=
X-Received: by 2002:a2e:9952:0:b0:2b9:3684:165 with SMTP id
 r18-20020a2e9952000000b002b936840165mr4739244ljj.8.1695298859522; Thu, 21 Sep
 2023 05:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com>
 <ZP96feVs2ev7098Y@smile.fi.intel.com> <CAL_JsqKfQJFrd8MOdjW55cYdEb8yyPyR+P3ran9+X3dCwUgdyA@mail.gmail.com>
 <ZQGaSr+G5qu/8nJZ@smile.fi.intel.com> <20230915193008.6d87b8a0@bootlin.com> <ZQf5huX2AMuf9kHC@smile.fi.intel.com>
In-Reply-To: <ZQf5huX2AMuf9kHC@smile.fi.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 21 Sep 2023 07:20:46 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKNC1Qv+fucobnzoXmxUYNockWR=BbGhds2tNAYZWqgOA@mail.gmail.com>
Message-ID: <CAL_JsqKNC1Qv+fucobnzoXmxUYNockWR=BbGhds2tNAYZWqgOA@mail.gmail.com>
Subject: Re: [PATCH V13 0/5] Generate device tree node for pci devices
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Lizhi Hou <lizhi.hou@amd.com>, Andrew Lunn <andrew@lunn.ch>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, stefano.stabellini@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 18, 2023 at 2:17=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Fri, Sep 15, 2023 at 07:30:08PM +0200, Herve Codina wrote:
> > On Wed, 13 Sep 2023 14:17:30 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > On Tue, Sep 12, 2023 at 02:12:04PM -0500, Rob Herring wrote:
> > > > On Mon, Sep 11, 2023 at 3:37=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@intel.com> wrote:
> > > > > On Tue, Aug 15, 2023 at 10:19:55AM -0700, Lizhi Hou wrote:
>
> ...
>
> > > > > Can you point out to the ACPI excerpt(s) of the description of an=
ything related
> > > > > to the device(s) in question?
> > > >
> > > > I don't understand what you are asking for.
> > >
> > > Through the email thread it was mentioned that this series was tested=
 on the
> > > ACPI enabled platform, Jonathan (IIRC) asked why do we need to have a=
 shadow
> > > DT for the something that ACPI already describes. That's why I'm tryi=
ng to
> > > understand if it's the case. and if so, how can we improve the approa=
ch.
> >
> > Patches from Frank Rowand series [1] are needed to create an of_root_no=
de if a DT
> > was not provided by the firmware, bootloader, etc that run the kernel.
> >
> > [1]: https://lore.kernel.org/lkml/20220624034327.2542112-1-frowand.list=
@gmail.com/
> >
> > Current Lizhi's series creates nodes from the PCI host node during the =
PCI
> > enumeration. It creates PCI-PCI bridge and PCI device nodes.
> >
> > I use these series on an ACPI system.
> >
> > I need one more missing component: the node related to the PCI host bri=
dge
> > This was the purpose of Clement's work. This work was not sent upstream=
 yet and I
> > am working on it in order to have a full tree from the of_root to the P=
CI device
> > ie:
> >  of_root                  <-- Frank Rowand series
> >    + of_host_pci_bridge   <-- Clement's work
> >        + pci_bridge       <-- Current Lizhi series
> >            + pci_bridge   <-- Current Lizhi series
> >             ...
> >              + pci_dev    <-- Current Lizhi series
> >
> > Hope that this status helped.
>
> Thanks for the explanation! I suppose it's better to have three series co=
mbined
> into one and being sent with a better cover letter to explain all this.

You can go back (years now) and see that. I asked for this to be split
up into manageable chunks and not solve multiple problems at once. No
point in trying to do DT on top of ACPI if DT on top of DT doesn't
work first.

Rob
