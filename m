Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B094E4DBA
	for <lists+linux-pci@lfdr.de>; Wed, 23 Mar 2022 09:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242401AbiCWIFp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Mar 2022 04:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiCWIFp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2022 04:05:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB7B70F78;
        Wed, 23 Mar 2022 01:04:16 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bi12so1204842ejb.3;
        Wed, 23 Mar 2022 01:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oNMVyc/j83Ecy4cv3OC0iNO8ILErqvD2g6W5CyTq9YM=;
        b=Jm/YB+FO7nUYcqHPWrxgd7j2+1gT2mX8y52Dm2suYxlLEFFoExFfUKJW6LO9p2JjTu
         TMoYyPmiohkYGrIKIaRrbzbjuvPNFxs+bZvnUtqDHworqhd4tOIUlGRpkU3Agxw8gJZ2
         1O6srV/XGOl5VhiOOR5xtGi5Lf6PJIYYPpk/djhqe4LirE/hkaMKV2YLwTSXW54EcSDK
         Y/KTJwY/7vdDIh+iKy6hkEvgGIF4hhFPnE3ketYo5Mc1M38QD7n5nut6NzNHZI4U09zr
         I2NljQls0K6joLTi4Q7j9J6tUex6uHSwdqcfAD5T5TVIcrnq/8G4Q5TtUU16NUh3LJrr
         5Pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oNMVyc/j83Ecy4cv3OC0iNO8ILErqvD2g6W5CyTq9YM=;
        b=ZCJBtG7wXUzFf5U9cOk+prJld0vaxPJT8NLPK4N9N2Wjzp7ZkFXepoMrw41+Ajy3f7
         y8YDV4Onshg0EJY0m0WlavcNPii8+/EEAIFtgL4hVLnAzvhEwKs60urITCrkK0LVT26I
         FGI39PisgPCUVEZxVhsYCaPxP2K/n74pq1qm+tQ95BuycOvxT93NJIAfYXk1gkdkPcdr
         3V5/W87EgyKlCwCJe/u7mRkKVs6v92j1SvGBCzhKQUs7gpCzRwKL3YnDV0RUWaFpsxJr
         vrfHlcfWdDFAE8/iOECg6xsysJ7BdhG67HLUZKSACnRFxDS+6da7xd0ZCPS8HJJmsabr
         DZZQ==
X-Gm-Message-State: AOAM531lvMAkD8eNyYyOQGUfRVrfc0xSgFU7HqXRPODOGw/XNnhiNGba
        fSIPaqtPmOjhf6btB6mOpXwUwoXrxcbseIsLgDg=
X-Google-Smtp-Source: ABdhPJzzGbjOXUeBkq9zpKAWT/MCjB4wYcea3KJDMCCPLzfGY8i5/1+dy3ASew7xPHJw2QglcLN2XVoyI1rxtLt9oWo=
X-Received: by 2002:a17:907:7289:b0:6df:9746:e7c4 with SMTP id
 dt9-20020a170907728900b006df9746e7c4mr28874304ejc.497.1648022654472; Wed, 23
 Mar 2022 01:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220321183446.1108325-1-helgaas@kernel.org> <20220323022648.GA1243295@bhelgaas>
In-Reply-To: <20220323022648.GA1243295@bhelgaas>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 23 Mar 2022 10:03:38 +0200
Message-ID: <CAHp75VfdoAbSTkO7eaor94pkmN0ttLXstc1DS_Sa7i45Dt5GAA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Avoid broken MSI on SB600 USB devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mick Lorain <micklorain@protonmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 23, 2022 at 4:26 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Mar 21, 2022 at 01:34:46PM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Some ATI SB600 USB adapters advertise MSI, but if INTx is disabled by
> > setting PCI_COMMAND_INTX_DISABLE,

> > MSI doesn't work either.

I think this is not correct.

> >  The PCI/PCIe
> > specs do not require software to set PCI_COMMAND_INTX_DISABLE when enabling
> > MSI, but Linux has done that for many years.
> >
> > Mick reported that 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI
> > devices") broke these devices.  Prior to 306c54d0edb6, they used INTx.
> > Starting with 306c54d0edb6, they use MSI, and and the fact that Linux sets
> > PCI_COMMAND_INTX_DISABLE means both INTx and MSI are disabled on these
> > devices.

> > Avoid this SB600 defect by disabling MSI so we use INTx as before.

And this is kinda too conservative approach.

> > Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=215690
> > Link: https://lore.kernel.org/all/PxIByDyBRcsbpcmVhGSNDFAoUcMmb78ctXCkw6fbpx25TGlCHvA6SJjjFkNr1FfQZMntYPTNyvEnblxzAZ8a6jP9ddLpKeCN6Chi_2FuexU=@protonmail.com/
> > BugLink: https://lore.kernel.org/all/20200702143045.23429-1-andriy.shevchenko@linux.intel.com/
> > Link: https://lore.kernel.org/r/20220314101448.90074-1-andriy.shevchenko@linux.intel.com
> > Reported-by: Mick Lorain <micklorain@protonmail.com>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

And it hasn't been tested by the reporter.

> Unless there's objection, I plan to include this in the v5.18 pull
> request in the next few days.

You are the maintainer here and it's your choice. I'm not going to stop you.

-- 
With Best Regards,
Andy Shevchenko
