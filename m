Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152C8624C5C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 22:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiKJVDa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 16:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiKJVD2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 16:03:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7001CF3;
        Thu, 10 Nov 2022 13:03:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D63461E5C;
        Thu, 10 Nov 2022 21:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3307C433C1;
        Thu, 10 Nov 2022 21:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668114206;
        bh=B66wDw3TMm/OICWkD7UMsp1sGtYl2dBLLmA0cJWXS+0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RU2W4Lerv28EOMYH/8guZCh2kUMJJlxayGJarPeUuI40cwiZ0noiXN9KqVw+6j+Uf
         W14nwI0wBQiOYgKP285aZdJrASIVvNWVtdbxUpE+4E8odAHROtsZ+3jT0zsB7jiHVl
         U7Qsu0vI1zie0R7J4RKoWSy1RTzUah6MIaco6QJ+gqP1o0KQ1bdOl8+3Ls5401DQn3
         gQoU+eeARZZ6NzBfT5uug9sxGzzM/Kc6bRS/jiefjIm8AtgDUDlFPfQ/ZiFpGBmYsQ
         pyFVHPRRvzgWJHCQ+E5yrt9Srk1lb1LCqyUM3Kaw4VPDTax2u8adOCJZWDJZ2nuVCq
         MqNucgPVEN9TQ==
Date:   Thu, 10 Nov 2022 15:03:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] PCI: Drop controller CONFIG_OF dependencies
Message-ID: <20221110210324.GA671663@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025191339.667614-1-helgaas@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 25, 2022 at 02:13:37PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Drop controller CONFIG_OF dependencies so we can compile-test drivers even
> without CONFIG_OF being enabled.  OF provides stub functions when CONFIG_OF
> is not set.
> 
> Bjorn Helgaas (2):
>   PCI: Drop of_match_ptr() to avoid unused variables
>   PCI: Drop controller CONFIG_OF dependencies
> 
>  drivers/pci/controller/Kconfig          | 15 ++-------------
>  drivers/pci/controller/cadence/Kconfig  |  6 ------
>  drivers/pci/controller/dwc/Kconfig      | 25 ++++++++++++-------------
>  drivers/pci/controller/mobiveil/Kconfig |  1 -
>  drivers/pci/controller/pci-ftpci100.c   |  2 +-
>  drivers/pci/controller/pci-v3-semi.c    |  2 +-
>  6 files changed, 16 insertions(+), 35 deletions(-)

I put these on my pci/kbuild branch and propose to merge them at the
end.  Lorenzo, let me know if you prefer something else.
