Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E207769FE0
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 19:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjGaR72 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 13:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjGaR71 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 13:59:27 -0400
X-Greylist: delayed 80324 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Jul 2023 10:59:15 PDT
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AA21712;
        Mon, 31 Jul 2023 10:59:14 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id E483D100FBF66;
        Mon, 31 Jul 2023 19:59:12 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 82F56260B28; Mon, 31 Jul 2023 19:59:12 +0200 (CEST)
Date:   Mon, 31 Jul 2023 19:59:12 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] PCI/DOE: Expose the DOE protocols via sysfs
Message-ID: <20230731175912.GB19517@wunner.de>
References: <20230725035755.2621507-1-alistair.francis@wdc.com>
 <20230725163046.GA23990@wunner.de>
 <20230727093857.000017aa@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727093857.000017aa@Huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 27, 2023 at 09:38:57AM +0100, Jonathan Cameron wrote:
> On Tue, 25 Jul 2023 18:30:46 +0200 Lukas Wunner <lukas@wunner.de> wrote:
> > Do have plans for
> > either of that or what's the motivation to use sysfs?
[...]
> I can see it would also be useful for things that will poke from
> userspace because they aren't expected to run in production (and hence
> hopefully don't care about potential races etc). CXL compliance
> comes to mind - I don't think we ever want to carry kernel code for that.

FWIW, USB4/Thunderbolt does have kernel code for DMA testing with a
special dongle (drivers/thunderbolt/dma_test.c) as well as code for
lane margining, so there *is* some precedent for that... :)

  config USB4_DEBUGFS_MARGINING
	bool "Expose receiver lane margining operations under USB4 ports (DANGEROUS)"
	depends on DEBUG_FS
	depends on USB4_DEBUGFS_WRITE
	help
	  Enables hardware and software based receiver lane margining support
	  under each USB4 port. Used for electrical quality and robustness
	  validation during manufacturing. Should not be enabled by distro
	  kernels.

Thanks,

Lukas
