Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5AA68AC4E
	for <lists+linux-pci@lfdr.de>; Sat,  4 Feb 2023 21:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjBDUsM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Feb 2023 15:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjBDUsK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Feb 2023 15:48:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE6172B3;
        Sat,  4 Feb 2023 12:48:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 868E8B80ABF;
        Sat,  4 Feb 2023 20:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DB4C433EF;
        Sat,  4 Feb 2023 20:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675543682;
        bh=El5/Gl+PNJ2pEBV9C94LbgCLnnlSUAERLctWknHJrBQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DDkoHMyTaTlSPLAgMsT0ONhPbUzTUT2zFShC4X0JDcdkv1JsIHYQyI9VHjxpp4DG1
         CmqIOHjNc6hGjj0EQAnb5Sm2gy8Nxyw+S3Ql/4KdafXwixqAGjGefh/yzb9olj1APY
         a9/1KoHLcCDbZyNSCpaTHqr6E79u1JgWAxYxv/brW9KHDWc5gcdHikLV7A+mkbG7hj
         eM6UAiQjq80L0qoO73Ld7Ayl/OwHc6ifwXA8yzjmfW03VSxbqvnYJGGmeL+CvVVCKj
         wktxueM0D2Rt2duEtWHmF6OfEOzMTyUY4wxA/WEBOIuBYgMfkyiO1/SPm5K1tgP9o4
         lGoyLVKcIy4ZA==
Date:   Sat, 4 Feb 2023 14:48:00 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, Thomas Witt <kernel@witt.link>,
        Vidya Sagar <vidyas@nvidia.com>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] Revert "PCI/ASPM: Refactor L1 PM Substates Control
 Register programming"
Message-ID: <20230204204800.GA2107870@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230204174525.GA917@wunner.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 04, 2023 at 06:45:25PM +0100, Lukas Wunner wrote:
> On Fri, Feb 03, 2023 at 04:48:20PM -0600, Bjorn Helgaas wrote:
> > Thomas Witt reported that 5e85eba6f50d ("PCI/ASPM: Refactor L1 PM Substates
> > Control Register programming") broke suspend/resume on a Tuxedo
> > Infinitybook S 14 v5, which seems to use a Clevo L140CU Mainboard.
> > 
> > The main symptom is:
> > 
> >   iwlwifi 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible
> >   nvme 0000:03:00.0: Unable to change power state from D3hot to D0, device inaccessible
> > 
> > and the machine is only partially usable after resume.  It can't run dmesg
> > and can't do a clean reboot.  This happens on every suspend/resume cycle.
> > 
> > Revert 5e85eba6f50d until we can figure out the root cause.
> > 
> > Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=216877
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216877
> Fixes: 5e85eba6f50d ("PCI/ASPM: Refactor L1 PM Substates Control Register programming")
> Cc: stable@vger.kernel.org # v6.1+

It's a pattern ;)  Thanks again!
