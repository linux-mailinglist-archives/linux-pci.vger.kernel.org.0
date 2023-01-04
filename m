Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B61C65D691
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jan 2023 15:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbjADOuh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 09:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbjADOuf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 09:50:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C408D15FF3;
        Wed,  4 Jan 2023 06:50:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F0D66176C;
        Wed,  4 Jan 2023 14:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94910C43392;
        Wed,  4 Jan 2023 14:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672843833;
        bh=KJAN/cjZa/oRtHLG1wkUIzfNI68wvr0PbA81SJphtC8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=R0XDFYZB+t6W09IrepVidTRhlkuHdUtjWg7agpX2Dut/oJ9AEOeUXjDJX5HfAxbSi
         H9q+Hyk5M+iBLxEXRaapGqJ0lGZFT4I9O1bORlshpdtvQ9qaXCpDYIfB6CXt0Oqq62
         aovde42u9PwZmjFht7TXFzFyzGk34YyGlBlI0snhXr8p+WReEbIu2yjhTfqSisQERJ
         8wcjw1O7PhN2aG6bTMJo16SDwFWunbnekYeOH2G/Kt9R74O8oYtjxFOE6ZCF5e/Wtz
         j1x0jHpAlq/qXDlANv6JPaxXq1EpXzCKdf6VpPQEAPNBBN4uFdQ5M84x3Ra8QILWHm
         AorgDpXnfJqFg==
Date:   Wed, 4 Jan 2023 08:50:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     bhelgaas@google.com, hdegoede@redhat.com, kernelorg@undead.fr,
        kjhambrick@gmail.com, 2lprbe78@duck.com,
        nicholas.johnson-opensource@outlook.com.au, benoitg@coeus.ca,
        mika.westerberg@linux.intel.com, wse@tuxedocomputers.com,
        mumblingdrunkard@protonmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, david.e.box@intel.com,
        yunying.sun@intel.com
Subject: Re: Bug report: the extended PCI config space is missed with 6.2-rc2
Message-ID: <20230104145032.GA1069244@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac2693d8-8ba3-72e0-5b66-b3ae008d539d@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 04, 2023 at 09:39:56AM -0500, Liang, Kan wrote:
> Hi Bjorn,
> 
> Happy new year!
> 
> We found some PCI issues with the latest 6.2-rc2.
> 
> - Using the lspci -xxxx, the extended PCI config space of all PCI
> devices are missed with the latest 6.2-rc2. The system we used had 932
> PCI devices, at least 800 which have extended space as seen when booted
> into a 5.15 kernel. But none of them appeared in 6.2-rc2.
> - The drivers which rely on the information in the extended PCI config
> space don't work anymore. We have confirmed that the perf uncore driver
> (uncore performance monitoring) and Intel VSEC driver (telemetry) don't
> work in 6.2-rc2. There could be more drivers which are impacted.
> 
> After a bisect, we found the regression is caused by the below commit
> 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map").
> After reverting the commit, the issues are gone.
> 
> Could you please take a look at the issues?

Certainly.  Can you capture the complete dmesg log, please?

Bjorn
