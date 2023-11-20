Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440127F1F2C
	for <lists+linux-pci@lfdr.de>; Mon, 20 Nov 2023 22:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjKTVaN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Nov 2023 16:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjKTVaN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Nov 2023 16:30:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AC2CA
        for <linux-pci@vger.kernel.org>; Mon, 20 Nov 2023 13:30:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1204CC433C8;
        Mon, 20 Nov 2023 21:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700515809;
        bh=YKb7tDHtotLGSVztvfymxto0kpYCPw1CZYwIQNNJ6o4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gKwuzNGQZf5nE8wX3LNWOVz7xCs+AzRHGioMCvNxHQYVfEOdbb3HiHnqU8jwlW7ah
         ceY8PZXH0TA1K+vkZqJRp8sGJXdlt09zQ6DlXziE3ffkte4itcYvU6Mcc3i/4n7vkQ
         /6b+RbtgWuH7c801Np1flHEdeoStcR98AhbhziQ/53hyjtQ8Vzwo5CdJ6Cxp7zJpaS
         o1LND/o9hzXlYn0Io2NvY36jYYc9jMSvPzeDU4M8LDyvJv/4yhNeMjg8kSisckl1tF
         Xseqb1LsGBbG89En2rsNl8pJJTY6xciYD8WyA1RmxWzEWLvmCvWgnDNPjpI20jEAdz
         SXCpuPtH4I0Cg==
Date:   Mon, 20 Nov 2023 15:30:07 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Will Deacon <will@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, kernel@pengutronix.de,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: host-generic: Convert to platform remove callback
 returning void
Message-ID: <20231120213007.GA216418@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120212224.txokceaqze76zqjd@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 20, 2023 at 10:22:24PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, Oct 20, 2023 at 11:21:07AM +0200, Uwe Kleine-König wrote:
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling by
> > returning an error code.  However the value returned is (mostly) ignored
> > and this typically results in resource leaks. To improve here there is a
> > quest to make the remove callback return void. In the first step of this
> > quest all drivers are converted to .remove_new() which already returns
> > void.
> > 
> > pci_host_common_remove() returned zero unconditionally. With that
> > converted to return void instead, the generic pci host driver can be
> > switched to .remove_new trivially.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> who feels responsible to apply this patch?

If you're ready to rename .remove_new() back to .remove(), you can
include this as part of that series with my ack:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Or we can take it via the PCI tree for v6.8.

Bjorn
