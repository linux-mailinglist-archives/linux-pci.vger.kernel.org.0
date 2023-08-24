Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EDF787A45
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 23:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243650AbjHXVUy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 17:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243721AbjHXVUt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 17:20:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2D71BCC;
        Thu, 24 Aug 2023 14:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=flp4EjyTvkxPuivXqRd46HtuvuFbAWcJi7Dh2QwaPkw=; b=co/0TVLIbTFxxX/ogcl43G2Gfj
        YeZSS1iTnvGmirbJdeSxMtk8Uc3eTwXCOHmgpi1FQ34VS+Nxg7CXmGoRCE5s5A7wuH/lwDRPszrSv
        z8fI/Lr+tK0QwvKOtRokuHMwv5KXjv+fAoqAvxal5cxVp7hhVdSNZLD0rkgivLjOgKJMNbPNjFPuA
        Er1QVCWn3vQA0xAVMvz68noGk7lI25ic6xqb47Y0nHwQJWc9o081kb9gF4Gy2d4Qm2o010cZy9K7v
        V5jgmhp+jmCcaGNiJdwpJ7g+2BNeOZlBRNxPC7xv//wdct0FOsZcECGTqHFdwBHsCud8k/d/ofDPv
        HeppmxDw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qZHl1-003p4U-2q;
        Thu, 24 Aug 2023 21:20:47 +0000
Message-ID: <c128b8aa-2cdf-e24d-75ba-39b2d1cdadd4@infradead.org>
Date:   Thu, 24 Aug 2023 14:20:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 10/12] PCI: Fix typos in docs and comments
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20230824193712.542167-1-helgaas@kernel.org>
 <20230824193712.542167-11-helgaas@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230824193712.542167-11-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/24/23 12:37, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos in docs and comments.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  Documentation/PCI/pci-error-recovery.rst      | 12 +++----
>  drivers/pci/controller/cadence/pcie-cadence.h |  2 +-
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 32 +++++++++----------
>  drivers/pci/msi/irqdomain.c                   |  4 +--
>  drivers/pci/p2pdma.c                          |  2 +-
>  drivers/pci/pci.c                             |  2 +-
>  drivers/pci/probe.c                           |  2 +-
>  drivers/pci/quirks.c                          |  8 ++---
>  drivers/pci/setup-bus.c                       |  2 +-
>  9 files changed, 33 insertions(+), 33 deletions(-)
> 

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

-- 
~Randy
