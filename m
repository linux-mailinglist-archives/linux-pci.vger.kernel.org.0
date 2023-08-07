Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2ED8773116
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 23:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjHGVQu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 17:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjHGVQt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 17:16:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7630E68
        for <linux-pci@vger.kernel.org>; Mon,  7 Aug 2023 14:16:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ED006224C
        for <linux-pci@vger.kernel.org>; Mon,  7 Aug 2023 21:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6305AC433CA;
        Mon,  7 Aug 2023 21:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691443007;
        bh=UqwXkE0XQv6HlT8Ba1Bd4glLj1Q0fSgvhq7cQDQ/YFE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cBWzDFcp9kHa5qwJnh6c74nsij+xcq35CocCBcF41A/cEesyleQ3+VccLZ/BTicWu
         8PrhAMQ+J6sfA2KCSzyrEDCbzeTrDlBr8yQIjD1pR60ozpWndYUSUZ2ObLV/VKVxSX
         qb2hN5G1A19nVX0/t9RMk746545aPQAbPJSrRbGhcTwkEVLfKwfcdLEbjcQC7mX9j+
         aTm5/zqF7QvcFdzTnvtEFP5P45XTUjVilKjngBMi6xePaN+iOHLcvLdv/p4AfI5Zte
         1K19U2aacRbQtrV0+2Urd/8eqIrz9Xi9H8R+7tlFcKfDOW6W4QW4qFNUhO40Ajr6sv
         FGCsjcG+yyojA==
Date:   Mon, 7 Aug 2023 16:16:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     alyssa@rosenzweig.io, maz@kernel.org, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        mahesh@linux.ibm.com, oohall@gmail.com, lukas@wunner.de,
        linux-pci@vger.kernel.org, yangyingliang@huawei.com
Subject: Re: [PATCH 0/3] PCI: Use pci_dev_id() to simplify the code
Message-ID: <20230807211645.GA272058@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807134858.116051-1-wangxiongfeng2@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 07, 2023 at 09:48:55PM +0800, Xiongfeng Wang wrote:
> PCI core API pci_dev_id() can be used to get the BDF number for a pci
> device. We don't need to compose it mannually. Use pci_dev_id() to
> simplify the code and make the code more readable.
> 
> Xiongfeng Wang (3):
>   PCI: apple: use pci_dev_id() to simplify the code
>   PCI/AER: Use pci_dev_id() to simplify the code
>   PCI/IOV: Use pci_dev_id() to simplify the code
> 
>  drivers/pci/controller/pcie-apple.c | 4 ++--
>  drivers/pci/iov.c                   | 3 +--
>  drivers/pci/pcie/aer.c              | 4 ++--
>  3 files changed, 5 insertions(+), 6 deletions(-)

Applied to pci/misc for v6.6, thanks!

There are several similar cases outside drivers/pci/ that it would be
nice to clean up as well.

Bjorn
