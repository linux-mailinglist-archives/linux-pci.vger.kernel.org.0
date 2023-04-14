Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39EE6E2824
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 18:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjDNQOM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 12:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjDNQOM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 12:14:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550E5E78
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 09:14:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA7D7648F3
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 16:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E87C433EF;
        Fri, 14 Apr 2023 16:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681488850;
        bh=IEZXPmVnORT5hHwCx32ezdO7Q1Txnb+pa6N9OErLqiM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Gp+mVOJWiBspa+PBEsRHLrJMeaTsP8Efiqn+Riesd35oYSDvNoTKecd7BsotpbXpt
         JTOO6+1TTWWfdipo/51TRVeVhC8+0l9R59p2SyfLzJ+YsfXuk3Q5tftomHJmLjDAhi
         4d0CmOPv1EgAs7cWgZzd4GH/P0EE8Xh6dGOyQoNDl6t0AShNZjZOnzb0bO4m7KXCub
         24E4fFNgz8Am2lvnOZqgwIxAlywd77jhf3o3H5AVGNkC8x0LXsVe/5tkTPP/J52VsO
         iTNpZYOm93/K58DCvvreijBsfDyYNTQZSuBa61iRXn1eZLG8alcd1CxqgDhMhBOlzm
         uekyVtrcbZCSQ==
Date:   Fri, 14 Apr 2023 11:14:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 12/17] PCI: epf-test: Simplify DMA support checks
Message-ID: <20230414161408.GA198216@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330085357.2653599-13-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 05:53:52PM +0900, Damien Le Moal wrote:
> There is no need to have each read, write and copy test functions check
> for the FLAG_USE_DMA flag against the dma support status indicated by
> epf_test->dma_supported. Move this test to the command handler function
> pci_epf_test_cmd_handler() to check once for all cases.

s/dma/DMA/
