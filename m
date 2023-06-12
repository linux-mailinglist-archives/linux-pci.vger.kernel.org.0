Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB31572CA73
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jun 2023 17:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbjFLPlb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jun 2023 11:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237509AbjFLPlb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2023 11:41:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998C310CE;
        Mon, 12 Jun 2023 08:41:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3494B62AC4;
        Mon, 12 Jun 2023 15:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2CCC433D2;
        Mon, 12 Jun 2023 15:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686584489;
        bh=9Qi4c1lGYTVMPrraUDnsp/LLn9Kth1gYnUJrruGCAmQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MIPa32SJ43PjhrHK/No8+VaO0YCCSyFwd0v4BSWSTmrsvbSgeLqI4X75ZLqM+QNR/
         40bnptgk0Y9mLOwarhLt4N5vmZT4f/UX9bAR9ammdr71f37yUdMYAzmK2BVXTWGqEp
         3lDfERt11fZXOe63V4BpQK7CZi3TZF2mi5dJln/Ki4UWbCih3kIIgojhSUxyI8U2NM
         UG8rKARY4oOWA9yMH0qOov7WaxSZ9MTZWC+j1bxNCZA1u+rdCaTI4E6ZGDiki57ZI+
         DD4b9e9HM7Xz5wKYLLw/0kvZ68v7j5dS3Ohyb7CFIgviLqAIgu7LKcov+Xdg1oscR8
         dsBbrkzV8vskQ==
Date:   Mon, 12 Jun 2023 10:41:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v7 00/11] PCI: dwc: Relatively simple fixes and
 cleanups
Message-ID: <20230612154127.GA1335023@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230611192005.25636-1-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 11, 2023 at 10:19:54PM +0300, Serge Semin wrote:
> It turns out the recent DW PCIe-related patchset was merged in with
> several relatively trivial issues left unsettled (noted by Bjorn and
> Manivannan). All of these lefovers have been fixed in this patchset.
> Namely the series starts with two bug-fixes. The first one concerns the
> improper link-mode initialization in case if the CDM-check is enabled. The
> second unfortunate mistake I made in the IP-core version type helper. In
> particular instead of testing the IP-core version type the macro function
> referred to the just IP-core version which obviously wasn't what I
> intended.
> ...

I am unable to do anything with this series.

Google's legal team is reviewing this matter under applicable laws and
regulations.

Bjorn
