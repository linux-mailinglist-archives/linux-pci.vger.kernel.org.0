Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09C06DE5E8
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 22:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjDKUmz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 16:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjDKUmq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 16:42:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA78E59F6
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 13:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4222C60E97
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 20:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641C3C433AA;
        Tue, 11 Apr 2023 20:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681245751;
        bh=vwwmTawd+xCm04nj2E2NmX4T5M0jSbBzgS3F0E3K3JM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EEsRgtjZCF4nfsfHKQtNZ2PZpHJ/ho1UrkOHBdG4mtERvePVSzqbXZDyOim4osGp+
         SnP9g+ufEAQ9cjNmRAboW+kDuoTRoZYXUEItY0E2hoZMfgyZOjFRCsAm1HJJ5Ojmlt
         ObNVW6NR7UR9UG1aiYK5v9mYFO/iYVyvQGpnnyVNDKoypP2yDB7LNnmsTz8rRnzXOZ
         LV16bAGXZ+wa5wcvHELhkmNIeNmIZ3c0doiEEOnDoBBXgkJcfXxM47fC6dlVMrDQiW
         FVKA7ryg6eFKT6L/E4wXCgOum8K4rMl1J8xalow4p9W4FQWxZ+rsYDrzaU6qlk+YqI
         EERrhKFGIMDSg==
Date:   Tue, 11 Apr 2023 15:42:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [Bug 217321] New: Intel platforms can't sleep deeper than PC3
 during long idle
Message-ID: <20230411204229.GA4168208@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bug-217321-41252@https.bugzilla.kernel.org/>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 11, 2023 at 08:32:04AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=217321
> ... 
>         Regression: No
> 
> [Symptom]
> Intel cpu can't sleep deeper than pcˇ during long idle
> ~~~
> Pkg%pc2 Pkg%pc3 Pkg%pc6 Pkg%pc7 Pkg%pc8 Pkg%pc9 Pk%pc10
> 15.08   75.02   0.00    0.00    0.00    0.00    0.00
> 15.09   75.02   0.00    0.00    0.00    0.00    0.00
> ^CPkg%pc2       Pkg%pc3 Pkg%pc6 Pkg%pc7 Pkg%pc8 Pkg%pc9 Pk%pc10
> 15.38   68.97   0.00    0.00    0.00    0.00    0.00
> 15.38   68.96   0.00    0.00    0.00    0.00    0.00
> ~~~
> [How to Reproduce]
> 1. run turbostat to monitor
> 2. leave machine idle
> 3. turbostat show cpu only go into pc2~pc3.
> 
> [Misc]
> The culprit are this 
> a7152be79b62) Revert "PCI/ASPM: Save L1 PM Substates Capability for
> suspend/resume”
> 
> if revert a7152be79b62, the issue is gone

Relevant commits:

  4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates Capability for suspend/resume")
  a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM Substates Capability for suspend/resume"")

4ff116d0d5fd appeared in v6.1-rc1.  Prior to 4ff116d0d5fd, ASPM L1 PM
Substates configuration was not preserved across suspend/resume, so
the system *worked* after resume, but used more power than expected.

But 4ff116d0d5fd caused resume to fail completely on some systems, so
a7152be79b62 reverted it.  With a7152be79b62 reverted, ASPM L1 PM
Substates configuration is likely not preserved across suspend/resume.
a7152be79b62 appeared in v6.2-rc8 and was backported to the v6.1
stable series starting with v6.1.12.

KobaKo, you don't mention any suspend/resume in this bug report, but
neither patch should make any difference unless suspend/resume is
involved.  Does the platform sleep as expected *before* suspend, but
fail to sleep after resume?

Or maybe some individual device was suspended via runtime power
management, and that device lost its L1 PM Substates config?  I don't
know if there's a way to disable runtime PM easily.

The lspci output attached to the bugzilla was not collected as root,
so it lacks the ASPM-related information.  Can you do this again with
"sudo lspci -vv"?
