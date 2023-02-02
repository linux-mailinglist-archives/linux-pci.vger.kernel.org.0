Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A17468888E
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 21:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbjBBUuF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 15:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjBBUts (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 15:49:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29C34489;
        Thu,  2 Feb 2023 12:49:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A70A2B80B93;
        Thu,  2 Feb 2023 20:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AF1C433D2;
        Thu,  2 Feb 2023 20:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675370985;
        bh=4ARmO+DxLD2wiF43Jd2gLCJeTtipo1nJ/kh5ROlV/7w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sA1GGgDgoRFj3qYy+0+Dh6+3ASF2Cl3WmvppCdupP7mLJPuldN1oUoxmByzGIRPeR
         KYZCpH8RFqWx1M9Uqs3sN5hVQ5mW6IAEhL3vQXe8crD4CL1gR/Ekt1QpEBi3oyPM0o
         ldG7SEJ0FQvCv3chauWCt1JshV2NiYJlWpiR9waVoSSi0JyjiSNfzozYzcxav5p2FH
         iR6ZUL2WKgY8Icv/r7L/ZUPNE4mVOHfSkO3JzBHVlBDpnALV4QuvF0D1jBRHh24iZ+
         UM3h/XTaTncSVCreBQZ4jeamoViWgy6yk3tfC9uQkTIYkzDeHKSvx0Le7Icym2th/N
         eSahDM79tX57A==
Date:   Thu, 2 Feb 2023 14:49:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Witt <thomas@witt.link>
Cc:     Vidya Sagar <vidyas@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [Bug 216877] New: Regression in PCI powermanagement breaks
 resume after suspend
Message-ID: <20230202204942.GA1966855@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b3c035f-74be-ed64-8edb-c83106fd11ad@witt.link>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 26, 2023 at 08:24:23PM +0100, Thomas Witt wrote:
> On 04/01/2023 16:37, Thomas Witt wrote:
> > On 04/01/2023 16:02, Bjorn Helgaas wrote:
> > > Thanks for testing it.  Maybe Vidya will have more ideas.  The patch
> > > below (based on v6.2-rc1) would revert 5e85eba6f50d and 4ff116d0d5fd.
> > > If 5e85eba6f50d is the culprit, it should fix the regression.  It
> > > would also potentially break L1 substates after resume, so we'd like
> > > to avoid reverting it if possible.
> > > 
> > > But the "Unable to change power state from D3hot to D0, device
> > > inaccessible" symptom suggests that the device is still in D3, which
> > > would be more like a wakeup issue than an ASPM issue.
> > > 
> > > Your bisect log said 3e347969a577 ("PCI/PM: Reduce D3hot delay with
> > > usleep_range()") was "good", but it would be worth double-checking,
> > > e.g., see if reverting it from v6.2-rc1 makes any difference.
> > > 
> > > Bjorn
> > > 
> > > commit 61de2691d549 ("Revert "PCI/ASPM: Refactor L1 PM Substates
> > > Control Register programming"")
> > > parent 1b929c02afd3
> > > Author: Bjorn Helgaas <bhelgaas@google.com>
> > > Date:   Wed Jan 4 08:38:53 2023 -0600
> > > 
> > >      Revert "PCI/ASPM: Refactor L1 PM Substates Control Register
> > > programming"
> > 
> > With this patch on top of 6.2-rc1 suspend/resume works and my PCI
> > devices come back online.
> 
> do you have an Idea what went wrong in that commit to cause my PCI devices
> to not return from D3?

I do not have any ideas yet.

I suspect maybe we should plan to revert 5e85eba6f50d ("PCI/ASPM:
Refactor L1 PM Substates Control Register programming") and
4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates Capability for
suspend/resume") for now.

It's odd that they both appeared in v6.1, and we haven't seen a flood
of reports about this, so maybe there's something unusual about your
machine, Thomas.

I'll post a revert, and we can do that for v6.2 if we don't come up
with any other ideas.

Bjorn
