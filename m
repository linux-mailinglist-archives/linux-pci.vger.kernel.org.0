Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5448F625891
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 11:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiKKKnc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 05:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiKKKnb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 05:43:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA932DAD;
        Fri, 11 Nov 2022 02:43:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3B3BB8256D;
        Fri, 11 Nov 2022 10:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08A6C433D6;
        Fri, 11 Nov 2022 10:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668163406;
        bh=qSf10Q0RCz9prfBSGp/ERyuz24K/NWgcXcVDUlam2as=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=El0c4Zi2xN1hi6NsMggMAR2lye8V9aBiQ8ZHugADh+TELK7VpsmgNKmAmUtq770y6
         hy9PWrb9+oa3LP3fh7iCHsmVGVr5AzWUq14eYnMZlXuJaK08z9g1/xiv8HCI+8dSL2
         1GcSMCDHtZoI6eVwvZSfNSwhPtr5xEoRgWdE8hgswIqD71JSLE85fa81NshJm4dKjp
         z6czJbY05TcYc/CDfjR7gLdppqJgSjM/2zPIpGGcNfDHzDoEcpFHGmgjw61jARGjGC
         WQOCqEjg5HOVWQpwqhV2CGMXKZudOKPrrMSEF85NHyJlcCzygkaSKrexJKQLScVjT0
         M45hFvkJs6l4g==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Cyril Brulebois <kibi@debian.org>,
        Jim Quinlan <jim2101024@gmail.com>, james.quinlan@broadcom.com
Cc:     open list <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/5] PCI: brcmstb: Add Multi-MSI and some improvements
Date:   Fri, 11 Nov 2022 11:43:19 +0100
Message-Id: <166816337015.202749.4605725952437837970.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011184211.18128-1-jim2101024@gmail.com>
References: <20221011184211.18128-1-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 11 Oct 2022 14:42:05 -0400, Jim Quinlan wrote:
> v2 -- Commit "PCI: brcmstb: Set RCB_{MPS,64B}_MODE bits"
>       - s/read compeletion boudnary/Read Completion Boundary/ (Bjorn)
> 
> v1 -- original
> 
> Jim Quinlan (5):
>   PCI: brcmstb: Enable Multi-MSI
>   PCI: brcmstb: Wait for 100ms following PERST# deassert
>   PCI: brcmstb: Replace status loops with read_poll_timeout_atomic()
>   PCI: brcmstb: Functions needlessly specified as "inline"
>   PCI: brcmstb: Set RCB_{MPS,64B}_MODE bits
> 
> [...]

Applied to pci/brcmstb, thanks!

[1/5] PCI: brcmstb: Enable Multi-MSI
      https://git.kernel.org/lpieralisi/pci/c/198acab1772f
[2/5] PCI: brcmstb: Wait for 100ms following PERST# deassert
      https://git.kernel.org/lpieralisi/pci/c/3ae140ad827b
[3/5] PCI: brcmstb: Replace status loops with read_poll_timeout_atomic()
      https://git.kernel.org/lpieralisi/pci/c/ca5dcc76314d
[4/5] PCI: brcmstb: Functions needlessly specified as "inline"
      https://git.kernel.org/lpieralisi/pci/c/137b57413f56
[5/5] PCI: brcmstb: Set RCB_{MPS,64B}_MODE bits
      https://git.kernel.org/lpieralisi/pci/c/602fb860945f

Thanks,
Lorenzo
