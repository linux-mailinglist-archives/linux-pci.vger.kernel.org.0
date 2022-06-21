Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174DC553DA0
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 23:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356250AbiFUVYo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 17:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356266AbiFUVYW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 17:24:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFA13335F;
        Tue, 21 Jun 2022 14:16:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93D9AB817F3;
        Tue, 21 Jun 2022 21:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DEFC3411C;
        Tue, 21 Jun 2022 21:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655846166;
        bh=uxyToZbWIGGW5FOK4A4PzHLsSHFLbJnwMxvPmTsgLfM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Zz1jDoAXuMUMYOtpnPZ70gkon3l2BKsmAl7BkI0xy0TZ4JAOKVKWrcDioplrJBtHZ
         30zXxnvwvcr+r4R/T++MrzBk0UHrfmtx27WlCKsnV2lSsuNXRIvP0t0SF1Lk9pGp+D
         1VET9V9pUoPy7BuxtoFm3m8vMBwwFUZeOgubDE3oUdGBXg7YLhOwKRPgAqaJTKvEGS
         GRRyGcHcG3/zrKRC6bogLoyfT6w80VgsdthBJ33Te+eeQgMynyVmQw5rhpLpb4VmmL
         8g155SbpShYgGUxgNIU/Kz2SasLrinrDv4xpDh17PapgxixUpyN25Pc7uDP0ZW5/db
         9MRuijoR3Ue7A==
Date:   Tue, 21 Jun 2022 16:16:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>, svarbanov@mm-sol.com,
        agross@kernel.org, bjorn.andersson@linaro.org,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, p.zabel@pengutronix.de, jingoohan1@gmail.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org
Subject: Re: [PATCH v2] PCI: qcom: fix IPQ8074 Gen2 support
Message-ID: <20220621211604.GA1334281@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprMYiTAfKjT-GeWOt_Fk0EjR2tBRe-jAwb-2A+-zO6Gkw@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 21, 2022 at 11:45:12PM +0300, Dmitry Baryshkov wrote:
> On Tue, 21 Jun 2022 at 23:32, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jun 21, 2022 at 01:23:30PM +0200, Robert Marko wrote:
> > > IPQ8074 has one Gen2 and one Gen3 port, currently the Gen2 port will
> > > cause the system to hang as its using DBI registers in the .init
> > > and those are only accesible after phy_power_on().
> >
> > Is the fact that IPQ8074 has both a Gen2 and a Gen3 port relevant to
> > this patch?  I don't see the connection.
> >
> > I see that qcom_pcie_host_init() does:
> >
> >   qcom_pcie_host_init
> >     pcie->cfg->ops->init(pcie)
> >     phy_power_on(pcie->phy)
> >     pcie->cfg->ops->post_init(pcie)
> >
> > and that you're moving DBI register accesses from
> > qcom_pcie_init_2_3_3() to qcom_pcie_post_init_2_3_3().
> >
> > But I also see DBI register accesses in other .init() functions:
> >
> >   qcom_pcie_init_2_1_0
> >   qcom_pcie_init_1_0_0      (oddly out of order)
> >   qcom_pcie_init_2_3_2
> >   qcom_pcie_init_2_4_0
> >
> > Why do these accesses not need to be moved?  I assume it's because
> > pcie->phy is an optional PHY and phy_power_on() does nothing on those
> > controllers?
> >
> > Whatever the reason, I think the DBI accesses should be done
> > consistently in .post_init().  I see that Dmitry's previous patches
> > removed all those .post_init() functions, but I think the consistency
> > is worth having.
> >
> > Perhaps we could reorder the patches so this patch comes first, moves
> > the DBI accesses into .post_init(), then Dmitry's patches could be
> > rebased on top to drop the clock handling?
> 
> I don't think there is a need to reorder patches. My patches do not
> remove support for post_init(), they drop the callbacks code. Thus one
> can reinstate necessary code back.

There's not a *need* to reorder them, but I think it would make the
patches smaller and more readable because we wouldn't be removing and
then re-adding the functions.
