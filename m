Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1276E2833
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 18:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDNQSt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 12:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDNQSr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 12:18:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CA559C0
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 09:18:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F49664901
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 16:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27053C433D2;
        Fri, 14 Apr 2023 16:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681489125;
        bh=VieoGdYzg868kVuDopM+hDQNDHv7vj1HCLSO7MmoRSk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CY9VPNghsTiKEL4KnNYAw78OijRV6pxSkoV/x3+yxbgD9gmb0/z/KKvvQ05nxmwaG
         KLhH3ia3KWJ9Tn6ambA3r44JrlfYYVAFKZQr3S6waCXqwmUvYcfuJlRklSzdtcPIQf
         jnaJi+9UUPHg1TvXYVEGlpwkvZ9JsGXZMLnzm/uLtH3WGGzqqmQEtD15ay279OTpI2
         rJgY0yWfDqIkH8w5a+eRb2vzHClhJxIw6QSALU39sPdnGI5g/WFkEVm0lJP5etZUXr
         tCqcE1eYKeDrYGIU4D5vqSgrSlEVG5lrTWoh2QNuINHrQkajC1/C+Mcuvl9MAO4BQg
         fanwkoBItwZnw==
Date:   Fri, 14 Apr 2023 11:18:43 -0500
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
Subject: Re: [PATCH v4 16/17] misc: pci_endpoint_test: Do not write status in
 IRQ handler
Message-ID: <20230414161843.GA198740@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330085357.2653599-17-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 05:53:56PM +0900, Damien Le Moal wrote:
> pci_endpoint_test_irqhandler() always rewrites the status register when
> an IRQ is raised, either as-is if STATUS_IRQ_RAISED is not set, or with
> STATUS_IRQ_RAISED cleared if that flag is set. The first case creates a
> race window with the endpoint side, meaning that the host side test
> driver may end up reading what it just wrote, thus loosing the real
> status as set by the endpoint side before raising the next interrupt.
> This can prevent detecting that the STATUS_IRQ_RAISED flag was set by
> the endpoint.

s/loosing/losing/
