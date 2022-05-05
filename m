Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E365B51C962
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 21:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385221AbiEETrt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 15:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385211AbiEETrs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 15:47:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56205E154;
        Thu,  5 May 2022 12:44:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD1DEB82E5B;
        Thu,  5 May 2022 19:44:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C09C385A4;
        Thu,  5 May 2022 19:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651779843;
        bh=CK8hGVm6HY+SD5vqpXt0g5BOWD2qa/R5HokCnm40O7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bjO1p1qtf3GE9MpxXurI5NfLU/Ey4ot5586VfiDle02PkfoFoRfl/Zq4kj+9Rvrs+
         G2bGkAptZuC2o+xMgMxO/7nSRaTT4/CiHdl4BS0+2/6sLcOBLqtw6JuOEio//JvW5v
         JRKPOQo1ejLcidoVCV1Djy3pjbtbOzCtgFXbMHrZli+J72jtfeqwJDcT5ICAqE5n0p
         p+u5Qvh1532/mgcGgoAICpb/GT0ZY3MyhFIY1/SAWKk0Mn+aME8afUGhOdoHSueggm
         MSbl0yJ3bYnEi5t+Vld6fTJslnEktAMJdHQBCf8Q2vyh6rXG7f2g0+2+6XXtJHj+Hy
         TG0hv0voiS9NA==
Date:   Thu, 5 May 2022 12:44:01 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v1 00/11] PCI/PM: Rework powering up PCI devices
Message-ID: <YnQpAT59+dnfkfjO@thelio-3990X>
References: <4738492.GXAFRqVoOG@kreacher>
 <20220505192241.GA508163@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505192241.GA508163@bhelgaas>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 05, 2022 at 02:22:41PM -0500, Bjorn Helgaas wrote:
> [+cc Krzysztof, just FYI]
> 
> On Thu, May 05, 2022 at 07:57:15PM +0200, Rafael J. Wysocki wrote:
> > Hi All,
> > 
> > This patch set replaces patches [4-9/9] from the series at
> > 
> > https://lore.kernel.org/linux-pm/4419002.LvFx2qVVIh@kreacher/T/#mf7ed30e7cf114b131e6067e4e10c28e59d661cb4
> 
> I applied this to pci/pm, thanks!
> 
> I reordered the branch so Krzysztof's "pci_restore_standard_config()
> defined but not used" fix is first, followed by your changes, Rafael.

I can confirm that at commit 0f40ac35e4ec ("PCI/PM: Replace
pci_set_power_state() in pci_pm_thaw_noirq()"), the problematic machine
boots up with no visible issues. Thanks a lot for the quick fixes!

Cheers,
Nathan
