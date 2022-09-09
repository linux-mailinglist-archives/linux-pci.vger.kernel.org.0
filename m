Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED4B5B344B
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 11:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiIIJpe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 05:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIIJpd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 05:45:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E181A8001D;
        Fri,  9 Sep 2022 02:45:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EEF8B8247F;
        Fri,  9 Sep 2022 09:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E500C433C1;
        Fri,  9 Sep 2022 09:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662716729;
        bh=tUSrJsNaJCbvGoq5Sdhd5sXdULQl1WNNkXnia2/HZHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qSpu4ZG3b+aI/IRB90iMhgU5BdpqNI0Oa01XCvNCbVHKMZLViDPOirlB9FT8q7OsH
         bAjSrGdxZOaGLBJdnRw4YeCf7Ct7RvhUQsAmkNYUM+nB9fFgn8mEDlM2mWLllD47u9
         Xl/QYRYWHBk7rhitVI2pbE5p9K5kiQZso+SGDpfPW8cek32jGMrZrMRg5RswSAZuIG
         YMLG2kmASVaX/XpJ1hrC4OWd7Yhhwnhaqp4IaHF8Btn74CEaH36RN5CFuh0vH3ogJU
         y0mTlKx41aCzNziCXKe0fNtrJJKeCp/pl+8b8eBRqwkO74o8O6vcrKN79w5man+uYr
         kFqHfhcDjLRWg==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v1 1/1] PCI: dwc: Replace of_gpio_named_count() by gpiod_count()
Date:   Fri,  9 Sep 2022 11:45:22 +0200
Message-Id: <166271670239.2133988.2198384335398011229.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220830183310.48541-1-andriy.shevchenko@linux.intel.com>
References: <20220830183310.48541-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 30 Aug 2022 21:33:10 +0300, Andy Shevchenko wrote:
> As a preparation to unexport of_gpio_named_count(), convert the
> driver to use gpiod_count() instead.
> 
> 

Applied to pci/dwc, thanks!

[1/1] PCI: dwc: Replace of_gpio_named_count() by gpiod_count()
      https://git.kernel.org/lpieralisi/pci/c/2023f9c9190e

Thanks,
Lorenzo
