Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687365A6844
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 18:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiH3QWQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 12:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiH3QVz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 12:21:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3931037D0;
        Tue, 30 Aug 2022 09:21:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4749B8168D;
        Tue, 30 Aug 2022 16:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802ECC433C1;
        Tue, 30 Aug 2022 16:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661876457;
        bh=k9h6tnmcoRayevbYWoC/2+lCcp4bU+a356Iu+VIdT3U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VjA6eHDv4UYBFcvi5IrpT8RO2Z7WsxBGJMQf2Feon5k/I0L1POv0clnczwTwJcfj+
         QQFy8ECmUi4az+Kst/85l6wNSZdVhyGUpd5n3Jd2h6nAA7oWHykIdqlc1LyUlO7+ku
         DZRn8w1F6Zk4/Fm8PGkTSkiOWvl+qnkWaZuMzXjkhGwTBLY0CFswGeBDFhMCNvKUfz
         nKz5Odo1x8DdJjx9cy/ITwMO+yXFzifnwcdYuGvyF+42+MPhekidIpapPOp73rampq
         iIWT7iHIMI+PCGhg8UTa0Rz8thBuJxJ3/lRS5iihZ0jUYjleXQRwTImF2hAjsfjDi+
         yWxJmz1Q2Aj4Q==
Date:   Tue, 30 Aug 2022 11:20:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        David Box <david.e.box@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [RESEND PATCH v3 1/2] PCI/PM: refactor pci_pm_suspend_noirq()
Message-ID: <20220830162056.GA106242@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830161741.GA105724@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 30, 2022 at 11:17:43AM -0500, Bjorn Helgaas wrote:
> On Tue, Aug 30, 2022 at 01:44:43PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Aug 30, 2022 at 12:49 PM Rajvi Jingar

> > >  v1->v2: no change
> > >  v2->v3: no change
> 
> Why are we bumping the version numbers if there's truly no change?

Sorry, ignore this question; I see that patch 2/2 is changing.
