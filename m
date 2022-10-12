Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C835FC160
	for <lists+linux-pci@lfdr.de>; Wed, 12 Oct 2022 09:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJLHpq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Oct 2022 03:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJLHpp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Oct 2022 03:45:45 -0400
X-Greylist: delayed 505 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Oct 2022 00:45:31 PDT
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F74D2FFF7
        for <linux-pci@vger.kernel.org>; Wed, 12 Oct 2022 00:45:30 -0700 (PDT)
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id 9827428472F; Wed, 12 Oct 2022 09:37:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1665560222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vQSJ27+ELmc6rsx1z5Hnlg97GPKy30S6V0GY+bIbZ3E=;
        b=RzdMzyG7IEfEk3ttS3sU+Q5KkgxAmd+5zeBQo343M/cCOJbN/XMmX+WRVv4fDB2tdiXtRh
        fXNAScZZK/e5hMicvV3k3ASzYKF1JBuZ+yghbT74oOfrLQaC9Qxw8Lscwy32erb+RvjxHa
        I8ThbnwUNPhYJCeSVtRBrIH9J6fytnU=
Date:   Wed, 12 Oct 2022 09:37:02 +0200
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     linux-pci@vger.kernel.org, helgaas@kernel.org
Subject: Re: [PATCH pciutils v2] pciutils: add new readpci utility
Message-ID: <mj+md-20221012.073053.62265.nikam@ucw.cz>
References: <20221012021325.50085-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221012021325.50085-1-jesse.brandeburg@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

> Add the new utility 'readpci' in order to allow users to read and write the
> register address space located in the BAR designator + offset.
> 
> The reason that this app is better than what is generally available on the
> internet (there are several) is that this app integrates with the libpci
> and further benefits from pciutils-like arguments and device
> specifications.

I do not think we need a separate utility for that – let's extend setpci
instead.

The register syntax already supports directly addressed configuration space,
capabilities and extended capabilities, so let us add memory-mapped regions.
All the rest (specifying offset and access width) is already there.

Also, what do we do on non-Linux systems? mmap of memory-mapped regions
is certainly not available everywhere. So the proper way is to add an API
for that to libpci, even if it will be implemented only on Linux at first.

Are there some architectures where MMIO in user space requires some kind
of magic to avoid cache coherency issues?

					Martin
