Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F46D758511
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 20:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjGRSuk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 14:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGRSuk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 14:50:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85425B6;
        Tue, 18 Jul 2023 11:50:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21B3A61557;
        Tue, 18 Jul 2023 18:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5C3C433C7;
        Tue, 18 Jul 2023 18:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689706238;
        bh=+Ztf5XNR4bTtwwMVzSPNnXQ0BLNTXZTZ2cnwAqRAI+Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lwH6/dG2em/bQ6KJ/zJMGFesTMnfKzSyeHFEJmLpMlzEHUziz3PjXbhQngfk7f3i7
         91sNQ+VPrfbnv2CQb2X2DlFvgNfpFqnO6Fr6o2tUdkdWP2kXNGK8zhfjGJJ27o2j/c
         wlCG5HeBZ1YZuRkxxjjbNQWp3cb4sA0soaiqvvBLfcaZN0MJqebi60m7hTareH0ZgH
         Yeh0TjaOchrhhgsq8hzugHRfMktA9MT/R2D04ASQWn17+hoVumm9v3iNQi63bxxl19
         ttVgwZ1t4NUNwl9NqvsmVM4PGB4Ji8TqMyJ1i9PJgf1DKJL0ewjzdik7J1pZRblvw/
         javDydkrWoeFg==
Date:   Tue, 18 Jul 2023 13:50:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] serial: 8250_pci: add support for ASIX AX99100
Message-ID: <20230718185036.GA489221@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718174200.2862849-4-jiaqing.zhao@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 18, 2023 at 05:41:59PM +0000, Jiaqing Zhao wrote:
> All 4 PCI functions on ASIX AX99100 PCIe to Multi I/O Controller can be

Maybe clearer to say "Each of the four PCI functions ... can be
configured as a serial port controller"?

> configured as a single-port serial port controller. The subvendor id is
> 0x1000 when configured as serial port and MSI interrupts are supported.
