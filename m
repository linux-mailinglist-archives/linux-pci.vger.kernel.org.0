Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D08523F02
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 22:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiEKUjx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 16:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiEKUjw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 16:39:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75C1E44FF
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 13:39:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 720B261B38
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 20:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8066DC340EE;
        Wed, 11 May 2022 20:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652301590;
        bh=Bfj+GRIEh37Wj5rEiNJTmlNOMQJKdFsZCTHVDPkTCiA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qXODhR/un8G5mAMlLvu9L5bydebQclU2HSseUdC6uj7LPdQ/V/8ZXJdDLpBUtnnCA
         hNW3AbN0Tozjc5/EKciYr5cbCqeHvLF7PMK4g9B8JX3mOJdMnV+Jo7o71SkiXvTwpq
         VYOFcLOjoY7irPBm6gQjtxySgnRZLs46Ky9cRHYb6Ru7hj3stIfn4rdDhauOVlOISF
         cl4LCL2t58baRyDyt3feolqZU5+oAm0WDzZgSZwaorRQXrvh7r1CQUo1DrYRmPFU9t
         B7QnzB/BtKoT75X6jE0AtStWUjWLlpSIEz8rH9RzKkLMCxGLSc1ClB7Skubpn4zE4d
         FSLgNlxs9Rn4w==
Date:   Wed, 11 May 2022 15:39:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/4] PCI: brcmstb: Revert subdevice regulator stuff
Message-ID: <20220511203948.GA811126@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9be7d36-d670-ef6c-8877-5b38e828e97f@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 11, 2022 at 01:24:55PM -0700, Florian Fainelli wrote:
> On 5/11/22 13:18, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Cyril reported that 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup()
> > into two funcs"), which appeared in v5.17-rc1, broke booting on the
> > Raspberry Pi Compute Module 4.  Revert 830aa6f29f07 and subsequent patches
> > for now.
> 
> How about we get a chance to fix this? Where, when and how was this even
> reported?

Sorry, I forgot to cc you, that's my fault:
  https://lore.kernel.org/r/CABhMZUWjZCwK1_qT2ghTSu2dguJBzBTpiTqKohyA72OSGMsaeg@mail.gmail.com

If you come up with a fix, I'll drop the reverts, of course.

Bjorn
