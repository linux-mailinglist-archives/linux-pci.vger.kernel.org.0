Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1A454F6B4
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 13:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379829AbiFQL32 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 07:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381321AbiFQL30 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 07:29:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D466CA9F;
        Fri, 17 Jun 2022 04:29:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25F7B61F17;
        Fri, 17 Jun 2022 11:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC99C3411B;
        Fri, 17 Jun 2022 11:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655465364;
        bh=9wuCQMmf4p3CO/lJPhcLoBAMVeXWYbFbN0sfWQQnDQk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=H25MPIFra+fAN55+BKYFZ4qRV0crICkaD+vebhgb34i5Z2BJMHHmOmIHEKfYxYSoD
         N+wn0p3XckwdBF+8BpdmB7Ti1dBLWJZzdeknxF8nhP0K8Fh8aZPwGhZLcn8FL8BBCi
         bkPKcAqBsv4K+9LIsNZyBy92pHwQ2NkK2nFWAykbBDJRkngnMLlX84dTZWVuNlelDW
         qTEDzpDElreRE3YcTPrh5Zq9KRWPwfVAxjBHXC/lBpyZQ2Jfn2YEniaSsOG0taJyEp
         hziypQnY7SMFgsKucBvsyasYxMrKKUwkUrkzLau1cnWDuQRzIiBZ3PYwnZgSzdy894
         IHoCfblca6xxA==
Date:   Fri, 17 Jun 2022 06:29:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/18] PCI: dwc: Various fixes and cleanups
Message-ID: <20220617112922.GA1176883@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617104143.yj2mlnj4twoxoeld@mobilestation>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 17, 2022 at 01:41:43PM +0300, Serge Semin wrote:
> On Thu, Jun 16, 2022 at 03:03:16PM -0500, Bjorn Helgaas wrote:
> > On Fri, Jun 10, 2022 at 11:25:16AM +0300, Serge Semin wrote:
> > > This patchset is a first one in the series created in the framework of
> > > my Baikal-T1 PCIe/eDMA-related work:
> > > ...

> > This doesn't apply cleanly on v5.19-rc1 (my "main" branch).  v5.19-rc1
> > was tagged June 5, but apparently v4 was rebased to v5.18 and posted
> > June 10?  That's just a non-starter because many of these files were
> > changed during the merge window between v5.18 and v5.19-rc1.
> 
> Ok. I'll rebase it on top of v5.19-rcX on the next cycle.

I merge things on topic branches based on -rc1, so there's no benefit
to rebasing to anything past that (at least for me).  Normally it
doesn't matter because very little will change between -rc1 and -rcX.

> > I'll be looking for an ack from Jingoo and/or Gustavo, maintainers of
> > pcie-designware.c and related files.
> 
> Alas this will be very unluckily to happen. They have been inactive
> for more than four months on this and the rest of the patchsets
> (that's how long the patchsets have been hanging out on review).
> The last commit authored by Gustavo was the commit ce31ff786ddf
> ("PCI: dwc: Fix 'cast truncates bits from constant value'") posted
> in Sep 22, 2020 and no review activity afterwards. Jingoo' last
> ack was in Jun 25, 2019. So two and three years of silence accordingly
> doesn't give any hope on the sooner reaction from them.

Ok, thanks for the update.  I hadn't noticed that.

Bjorn
