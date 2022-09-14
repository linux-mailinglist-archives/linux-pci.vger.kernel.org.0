Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB745B817F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 08:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiINGYV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 02:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiINGYU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 02:24:20 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001D97269B
        for <linux-pci@vger.kernel.org>; Tue, 13 Sep 2022 23:24:17 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id v4so13405295pgi.10
        for <linux-pci@vger.kernel.org>; Tue, 13 Sep 2022 23:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=fRKf+imVw7MttIFJnauud7q8IBR969IuIIWD8g4fCPA=;
        b=PUXE6B3aPHP+SZGAuLS15FDgWLtMLluRF4EnRnapMrcQ/7eXfJhaqd6vSwaDNGravW
         /Npbi5K0MPHIHcbnYARE1ZMDeGP2qJH6/1hfVOPuHui/wtwcCAbhbpVplIejXXxe1k67
         EWO4k2b5toBpqgzKTMSwfHH0mnfQnCVygq3Yb/IOOfdfW8TzxuMZbn9z/FAJ48z2DTww
         HwQZVPpv+XI8+8NqFX1QBcRZMRvVCGZUqvhne9x7Pqc/Lj1qRo1e9P8LzUFG8JLyvpJ1
         3wOvrvNBboWiYlfZ1teVZXOucF2L/ff/0OeZiEhiHSuzp0xK1x1ml+1813aszt2UGqxX
         iF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fRKf+imVw7MttIFJnauud7q8IBR969IuIIWD8g4fCPA=;
        b=FglYcuoSsfl/5CR9zCk/ZHuQp7aJ8IwB7tpjOq0Yyis6AQV7ehrBwdJs3JwuQK3wzn
         sZ7EkaL3FN4kB8RhuLkYmBmJS+VzkV4hYvb11Z1qtT195qrcymvNEfZmNeT9nBwJCoLe
         HQsvRMgt7Zxhf2eTkIyXcLQcmnqNCxcsJmiF7CvlFOHK4mBdC0AGj0gngMK4pROlsYOM
         rMqD20cQyCURhGkVOTeDc4633hdFoAb7vteqIRJwfEoQsvrtMpfzT4jCxcjeDyTAOpeg
         IqsxW2b0JG38cnnPed45dksGpdZBxHPCZ5pWA+u23t8EbHpADs47wHlMBWpjF1njTibL
         Fx8A==
X-Gm-Message-State: ACgBeo0KeODRogBWVaaVu1FOrO6cw+y4LvMVRNtiWEvaZrVuJg5uIY8f
        7cyUjvAbNCAHu4oq+THFTcCa
X-Google-Smtp-Source: AA6agR4ZCZsGFPvSQBEvMKNXH7CVSjTn9MVPIP4sBKbe14FuFMLRYO5giCmz/5OT/5JZb4nHlql7iQ==
X-Received: by 2002:a63:451a:0:b0:439:246e:807e with SMTP id s26-20020a63451a000000b00439246e807emr8559930pga.347.1663136657408;
        Tue, 13 Sep 2022 23:24:17 -0700 (PDT)
Received: from workstation ([117.202.184.122])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b00177fb862a87sm9888045plg.20.2022.09.13.23.24.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Sep 2022 23:24:16 -0700 (PDT)
Date:   Wed, 14 Sep 2022 11:54:11 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, treding@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Message-ID: <20220914062411.GD16459@workstation>
References: <b1c243b0-2e6e-3254-eff0-a5276020a320@nvidia.com>
 <20220913200746.GA619956@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913200746.GA619956@bhelgaas>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 13, 2022 at 03:07:46PM -0500, Bjorn Helgaas wrote:
> On Tue, Sep 13, 2022 at 06:00:30PM +0100, Jon Hunter wrote:
> > On 13/09/2022 17:51, Manivannan Sadhasivam wrote:
> > > On Tue, Sep 13, 2022 at 03:42:37PM +0530, Vidya Sagar wrote:
> > > > Some of the platforms (like Tegra194 and Tegra234) have open slots and
> > > > not having an endpoint connected to the slot is not an error.
> > > > So, changing the macro from dev_err to dev_info to log the event.
> > > 
> > > But the link up not happening is an actual error and -ETIMEDOUT is being
> > > returned. So I don't think the log severity should be changed.
> > 
> > Yes it is an error in the sense it is a timeout, but reporting an error
> > because nothing is attached to a PCI slot seems a bit noisy. Please note
> > that a similar change was made by the following commit and it also seems
> > appropriate here ...
> > 
> > commit 4b16a8227907118e011fb396022da671a52b2272
> > Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > Date:   Tue Jun 18 23:32:06 2019 +0530
> > 
> >     PCI: tegra: Change link retry log level to debug
> > 
> > 
> > BTW, we check for error messages in the dmesg output and this is a new error
> > seen as of Linux v6.0 and so this was flagged in a test. We can ignore the
> > error, but in this case it seem more appropriate to make this a info or
> > debug level print.
> 
> Can you tell whether there's a device present, e.g., via Slot Status
> Presence Detect?  If there's nothing in the slot, I don't know why we
> would print anything at all.  If a card is present but there's no
> link, that's probably worthy of dev_info() or even dev_err().
> 

I don't think all form factors allow for the PRSNT pin to be wired up,
so we cannot know if the device is actually present in the slot or not all
the time. Maybe we should do if the form factor supports it?

> I guess if you can tell the slot is empty, there's no point in even
> trying to start the link, so you could avoid both the message and the
> timeout by not even calling dw_pcie_wait_for_link().

Right. There is an overhead of waiting for ~1ms during boot.

We workaround this issue by disabling the PCIe instances in devicetree
for which there would be no devices connected.

Thanks,
Mani

> 
> Bjorn
