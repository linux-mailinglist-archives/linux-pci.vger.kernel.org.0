Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3575559F21
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 19:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiFXRGr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 13:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiFXRGq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 13:06:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A35F496A8;
        Fri, 24 Jun 2022 10:06:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0390F622F7;
        Fri, 24 Jun 2022 17:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271E9C34114;
        Fri, 24 Jun 2022 17:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656090403;
        bh=N4WSyEMI5vpuUB02LlrmdLPWkI6rXPO4XWxrvOb5Ngk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a6rDfDtCK8rdjbb1Rck43BvXKshuDU4y7cmceTwMAVMuuXnQ4J2U+qwveyT3DpEb8
         ybkqG0+ykbbs39rnOi/Ut/INYTDOg8t0qkWtM0TaEnR3XSqlHCM68v5to48zn8KuTc
         x0PUtw4LyCPCFdDWLuYnCgORJLRMDwJ3gi9jZqItfUyK1qRJkTUtp18QSqFr5oGDKW
         7Nw4+kqt3v2CRWBzvPfdEHeGkwJQKapnhClW5SoDSg3+gcNFnGzePa0d4zzsImSalU
         Gd9ONy0zQFuAhMKjKP38Ag3v9L5Wzp0/ZOyoRir05zavqxE8xnqx6a5T4dY1oGKzwY
         uXhkOE173Pycw==
Date:   Fri, 24 Jun 2022 12:06:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lpieralisi@kernel.org, Rob Herring <robh@kernel.org>, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>, p.zabel@pengutronix.de,
        jingoohan1@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        johan+linaro@kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v3 2/2] PCI: qcom: move register accesses to .post_init
Message-ID: <20220624170641.GA1541953@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOX2RU4zbG8J59k0L22fbUK2fKFOKvW1O2hTTdW1bEpNv7=vjA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 12:46:55PM +0200, Robert Marko wrote:
> On Fri, 24 Jun 2022 at 12:36, Robert Marko <robimarko@gmail.com> wrote:
> > On Thu, 23 Jun 2022 at 23:55, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Thu, Jun 23, 2022 at 05:50:04PM +0200, Robert Marko wrote:
> > > > Move register accesses from .init to .post_init callbacks to maintain
> > > > consinstency for all IP since IPQ8074 specifically requires PHY-s to be
> > > > powered on before register access and its accesses have been moved to
> > > > .post_init.
> > >
> > > This doesn't do the corresponding move for qcom_pcie_init_2_7_0().  Is
> > > that intentional or an oversight?
> >
> > Hi,
> >
> > It was an oversight on my part, will fixup it now, sorry for the mistake.
> >
> > Regards,
> > Robert
> 
> Bjorn,
> 
> I updated the title and description based on your fixups in your branch,
> hope that is ok.

It's great, thanks for noticing and paying attention to the little
details!

Bjorn
