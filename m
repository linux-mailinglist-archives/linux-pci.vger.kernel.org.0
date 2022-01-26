Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BA749BFD2
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jan 2022 01:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbiAZAE5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jan 2022 19:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiAZAE5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jan 2022 19:04:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECB6C06161C;
        Tue, 25 Jan 2022 16:04:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80A3361408;
        Wed, 26 Jan 2022 00:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35D4C340E0;
        Wed, 26 Jan 2022 00:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643155495;
        bh=ONKxHIna6x1c4GG3NGBELWyQ/RRfJ0L7jkAgGIOMdJE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=F7RJO/4awgh6eAQ3bnqqXsNHuH8qd11iBV02S9ldj/L3XZlexHK/s3dYrdI+8dBQ1
         EI22V8yTAp7PcBEJ9BA17yoZ9tQDVR05qCXKvkUPojexcpEfDP+uZTNh0Zj3V/P6Qu
         D8E+BbXEimmOSk+lqfvwsO46aoIgamY1zSXW/KHcpzm0lSPVN6GovNFYJyWSA2288i
         9v67lO+2Fvw7paffVED9LPo6GZzxA21y0oIfME2HpwAFUcQ2xtKBIBrrd58PkUN2l4
         2Q8hLv0b/jFfpwM7W5UDRV95Aar93OJDelA2wclMzeNh9OoF5nJ7nHthmVMsdS4lNe
         kmYkSsxUh5bpg==
Date:   Tue, 25 Jan 2022 18:04:54 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: mt7621: address some kernel test robot reported
 warnings
Message-ID: <20220126000454.GA1651403@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124113003.406224-1-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 24, 2022 at 12:30:01PM +0100, Sergio Paracuellos wrote:
> Kernel test robot complains about two things here[0]:
> - pcie_rmw() [-Wunused-function]
> - 'mt7621_pcie_ids' [-Wunused-const-variable]
> 
> Address this two warnings in this small two patches.
> 
> Best regards,
>     Sergio Paracuellos
> 
> [0]: https://lkml.org/lkml/2022/1/24/264
> 
> Sergio Paracuellos (2):
>   PCI: mt7621: drop 'of_match_ptr' to fix -Wunused-const-variable
>   PCI: mt7621: remove unused function pcie_rmw()
> 
>  drivers/pci/controller/pcie-mt7621.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)

Both applied to for-linus for v5.17, thank you!
