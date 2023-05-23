Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B5570DBD0
	for <lists+linux-pci@lfdr.de>; Tue, 23 May 2023 13:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbjEWLyQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 May 2023 07:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjEWLyQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2023 07:54:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C56FE;
        Tue, 23 May 2023 04:54:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B2A061C27;
        Tue, 23 May 2023 11:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2176AC433EF;
        Tue, 23 May 2023 11:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684842854;
        bh=G0q0DuUEd9M+RCt8Keswen7g2UfqXiTIz3sk7wKsPkA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=U2s94GIv7u0xRWw5NxpvDVflR2jeFhXl/3wr8MoYbVyN165cYKTB7rhwEW7c9wD3S
         RaO7yDxGSyXrzdosD3R7P+CL6pJy6jcm37R82Mi7BdGUCtAf1yg/AflRvfafk7KIY7
         jur497SwnLHyDE02XjmSc/+0e56s6CipHe4mRE29CDnIyzzMYl3RYP+lbTVcZflejE
         Cz0p8qqMTMz8IOKpUMPmPPjuZBMbk6X5esf62ki49R2SIgWclF2K/7Sk6v6mHeLI+W
         kOO+u5qMdL6VWMi0vrsQt7+mKtVM7BFxMAzNVYOGaZJA8R06sWiA3uDz//ZWTziJX+
         ks/eJMlnV7pJQ==
Date:   Tue, 23 May 2023 06:54:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v5 2/4] PCI: move Alibaba Vendor ID linux/pci_ids.h
Message-ID: <ZGypZNq0JlczqJjI@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcf8c683-24e3-5e26-514c-58bf56fa784d@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 23, 2023 at 11:22:08AM +0800, Shuai Xue wrote:

> The Alibaba Vendor ID (0x1ded) is now only used by Alibaba elasticRDMA
> adapter driver. Move the Vendor ID to linux/pci_ids.h so that it can shared
> by several drivers later.

Well, not exactly.  We don't want to merge changes that might be used
by unspecified drivers later.  We only want to merge things that are
needed *now*, i.e., when this complete series is merged.

In this case, I think it will be used by another driver that is part
of this series ("dwc_pcie_pmu"), so the commit log should mention both
Alibaba elasticRDMA ("erdma"?) and "dwc_pcie_pmu".

Bjorn
