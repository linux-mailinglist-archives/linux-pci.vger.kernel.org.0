Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07D258724F
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 22:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiHAU13 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 16:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiHAU12 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 16:27:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40B62A415;
        Mon,  1 Aug 2022 13:27:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BCFF60FFF;
        Mon,  1 Aug 2022 20:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24B5C433C1;
        Mon,  1 Aug 2022 20:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659385646;
        bh=z80kg64xPITISs6PDw5Rf/ii1v3KJpLzca2pJ8vefG0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jnMitWJP3fSNWbDAXcoZNB5KC+lLcugiMeMYWlVLgofoB+Ko+8UanE+W7wf5B5XzP
         4oPHdTqW9lyuErPgJNn/sHyevhSUFzs1LxpHyfstyVWFQPH64YTjqllCeEZJyUphFx
         iTQJ2LSFR9fCmfeFuzWo2+sXUrUI14kskPoLIBSyRLLM4GZmvza3911LrBeiXJ1r/s
         gg24hHa1x80+csI0npXIo3bxDt0G8Ph869PB6WKFwCKaTzJxkpScCgCAH0tSNTKjQj
         yYt5AXO5ETqWjc6rhoD1V61YYYnGoqkSj15CCiefZdLWhT2KJgyawI7tlMg6kZjJHt
         il/SEQCl790Sg==
Received: by mail-vk1-f177.google.com with SMTP id x184so3285315vka.11;
        Mon, 01 Aug 2022 13:27:26 -0700 (PDT)
X-Gm-Message-State: ACgBeo3cQ098bNZZYoX3KQnr50XE/2BlO7EE4OhhcZzpR6jhy25jwElV
        MX+vKwYvGm9woGrux9G/rCgaFcx+rYXu0ZwfcQ==
X-Google-Smtp-Source: AA6agR6kFlMxvigGp5XCV/xNaDufu2f5XIb6CsG2MvP24QEctdtur3W3xKjM6RUCNeiHUd4BvACXFQrxiOI37zpEGtM=
X-Received: by 2002:a1f:ecc4:0:b0:377:8f7c:8873 with SMTP id
 k187-20020a1fecc4000000b003778f7c8873mr1585564vkh.14.1659385645513; Mon, 01
 Aug 2022 13:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <051a3baf-b4dd-7764-2e61-03584cefb4d3@nvidia.com>
 <20220729224404.GA478920@bhelgaas> <20220730145025.GA4005@thinkpad>
In-Reply-To: <20220730145025.GA4005@thinkpad>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 1 Aug 2022 14:27:14 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+tnLMcKGxzTJODQjCUTXU1yoMS2yF3WxEEfMmfgRt5uQ@mail.gmail.com>
Message-ID: <CAL_Jsq+tnLMcKGxzTJODQjCUTXU1yoMS2yF3WxEEfMmfgRt5uQ@mail.gmail.com>
Subject: Re: [PATCH V1] PCI: designware-ep: Fix DBI access before core init
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        sagar.tv@gmail.com, Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 30, 2022 at 8:50 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Fri, Jul 29, 2022 at 05:44:04PM -0500, Bjorn Helgaas wrote:
> > [+cc Xiaowei (author of 6bfc9c3a2c70), Hou (author of 8bcca2658558)]
> >
> > On Thu, Jul 28, 2022 at 05:56:28PM +0530, Vidya Sagar wrote:
> > > On 7/28/2022 3:44 AM, Bjorn Helgaas wrote:
> > > > On Wed, Jun 22, 2022 at 09:31:33AM +0530, Vidya Sagar wrote:
> > > > > Platforms that cannot support their core initialization without the
> > > > > reference clock from the host, implement the feature 'core_init_notifier'
> > > > > to indicate the DesignWare sub-system about when their core is getting
> > > > > initialized. Any accesses to the core (Ex:- DBI) would result in system
> > > > > hang in such systems (Ex:- tegra194). This patch moves any access to the
> > > > > core to dw_pcie_ep_init_complete() API which is effectively called only
> > > > > after the core initialization.

> >   6) What's going on with the CORE_INIT and LINK_UP notifiers?
> >      dw_pcie_ep_init_notify() is only called by qcom and tegra.
> >      dw_pcie_ep_linkup() is only called by dra7xx, qcom, and tegra.
> >      As far as I can tell, nobody at all registers to handle those
> >      events except a test.  I think it's pointless to have that code
> >      if nobody uses it.
> >
>
> I have submitted an actual driver that makes use of these notifiers:
> https://lore.kernel.org/lkml/20220502060611.58987-9-manivannan.sadhasivam@linaro.org/

Notifiers aren't the best interface in the kernel. I think they are
best used if there's no real linkage between the sender and receiver.
For an EPC and EPF that's a fixed interface, so define a proper
interface.

Rob
