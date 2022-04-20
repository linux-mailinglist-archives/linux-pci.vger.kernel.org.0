Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FAA508D34
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 18:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355737AbiDTQ2I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 12:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355207AbiDTQ2G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 12:28:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCD213EA6;
        Wed, 20 Apr 2022 09:25:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7E8DB81EB2;
        Wed, 20 Apr 2022 16:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A5FC385A1;
        Wed, 20 Apr 2022 16:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650471917;
        bh=KRSXZmE7hCvpkyvfMj0ubOPyiELhK6uWuOp6vCc4fXs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pQTbSjplIUSJia1MVZnBiEVHxSrwdkaCx+zw9Rsr2MZnmGNZgoc1xTKQ2dnQPsANd
         QcNVx1hfNw5tqF1p1FA1DDajLrvtYrMMgXa8qyznqG8BG53rfDD+30SmjOa5EPvbAX
         1gIV7AaPhFKhJs7gYbzApeLCiKEpuSS3DpKq6MxnK+VAmXRJb6M1UHFUppk+eRl4lb
         tVZc3qUs9LlTL9mUdwG6arH3TZ1OfBu8rjrVxzxQ+QJ1gCaGU9UMHw1si4LLgn6sc0
         50toeWv9jX+XkslhvtqifYU+tbYtbpfstjQxNOl/Ono/gEuxVSCWDDXHUgQ53hx2qw
         rw+VeoXKUuxfQ==
Date:   Wed, 20 Apr 2022 11:25:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 0/9] PCI/PM: Improvements related to device
 transitions into D0
Message-ID: <20220420162514.GA1301392@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5838942.lOV4Wx5bFT@kreacher>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 14, 2022 at 03:00:23PM +0200, Rafael J. Wysocki wrote:
> On Monday, April 11, 2022 4:17:41 PM CEST Rafael J. Wysocki wrote:
> > Hi All,
> > 
> > On Saturday, April 9, 2022 3:03:14 PM CEST Rafael J. Wysocki wrote:
> > > Hi All,
> > > 
> > > This series supersedes the one at
> > > 
> > > https://lore.kernel.org/linux-pm/4198163.ejJDZkT8p0@kreacher
> > > 
> > > It addresses some potential issues related to PCI device transitions from
> > > low-power states into D0 and makes the related code more straightforward
> > > and so easier to follow.
> > > 
> > > Please refer to the patch changelogs for details.
> > 
> > Here's a v2 of this patch series which is being sent, because I realized that
> > one of the checks in pci_power_up() added by patch [4/7] in v1 was redundant
> > and can be dropped, but that affected the last 3 patches in the series and
> > then I noticed that more improvements were possible and hence the new patches
> > [2/9].
> 
> Here's a v3 of this series with some minor review comments addressed and R-by
> tags from Mika added.

Applied to pci/pm for v5.19, thanks, Rafael!
