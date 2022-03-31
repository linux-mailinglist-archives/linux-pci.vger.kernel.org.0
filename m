Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EA14EDBB9
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 16:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbiCaOdF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 10:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237694AbiCaOc7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 10:32:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FE01DE6F4;
        Thu, 31 Mar 2022 07:31:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 708ACB8213B;
        Thu, 31 Mar 2022 14:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F523C340ED;
        Thu, 31 Mar 2022 14:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648737063;
        bh=SNXLMin1yPeR9fXtTHf11aJlFW1shy9T5oOySNUqpRo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a0bOq58j3m4sHXGsLJmOPypzaAgKs84C42qg4qA36vdMaWONZibKL1en9U1/x9KlD
         iMK05xfh1Z23snWcdLcA2CE5Ovh2dJuRkdUOZjRoQryGbkrJqgid/mjAXbn9nb++TM
         n5f1OXbK41b+d1FrJbPuMjoU9O2fjvJkQihkQaQ6WEwPWjyZ3fk4hV9dFcUICEoED7
         yR/R5heDVsInICR6Acx9IfZJONGWhv06Zvy3PSXIBEhVGmxideMm20oW7nhFdL3oHN
         FlwjltplWRc35ISFSoK/zcTq6oPyTSoZasgyxBzu01u4w2h2Vk72YkVMb/ALzfGiPX
         ONuN3aumuqDoA==
Date:   Thu, 31 Mar 2022 09:31:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shlomo Pongratz <shlomopongratz@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew.maier@eideticom.com, logang@deltatee.com,
        bhelgaas@google.com, jgg@nvidia.com,
        Shlomo Pongratz <shlomop@pliops.com>
Subject: Re: [PATCH V5 1/1] Intel Sky Lake-E host root ports check.
Message-ID: <20220331143101.GA4846@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331073539.14499-2-shlomop@pliops.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 31, 2022 at 10:35:39AM +0300, Shlomo Pongratz wrote:
> In commit 7b94b53db34f ("PCI/P2PDMA: Add Intel Sky Lake-E Root Ports B, C, D to
> the whitelist")
> Andrew Maier added the Sky Lake-E additional devices
> 2031, 2032 and 2033 root ports to the already existing 2030 device.
> 
> The Intel devices 2030, 2031, 2032 and 2033 which are root ports A, B, C and D,
> respectively and if all exist they will occupy slots 0 till 3 in that order.

Please make this a sentence.

> The original code handled only the case where the devices in the whitelist are
> host bridges and assumed that they will be found on slot 0.
> 
> This assumption doesn't hold for root ports so an explicit test was added to
> cover this case.

Please update the subject line to match the style of previous ones.

Please wrap the commit log to fit in 80 columns (including the 4
spaces added by "git log") like previous commits.

Please figure out whether you want "Sky Lake-E" or "SkyLake-E" and use
it consistently in commit log and code comments.  It seems to be
"Skylake" on intel.com, so I suggest using that.

Please use imperative mood, e.g., instead of "an explicit test was
added ...," write "add a test to cover this case."  Do the same in
code comments.

Bjorn
