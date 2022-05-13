Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131AD52636D
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 16:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiEMOHc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 10:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiEMOH2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 10:07:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F32450B0E;
        Fri, 13 May 2022 07:07:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF4DF6203F;
        Fri, 13 May 2022 14:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CE8C34100;
        Fri, 13 May 2022 14:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652450845;
        bh=JHGmg8HELW1l/NvkzMwcz7ZBqd9Xb6Lnpfs7ZKtiCY4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Zrk377rYFyGd1DKEgPcrB9U2j9iCZcIVPSjX3G4yXLEfiYpGZy5dx2KMZOtOZ0yNr
         NCoJXvvNbST2JWJjySL0hS2bH2g4g0XE7V+Gm1NKCEdd9QvmqMast/6QrQI/KEDfMi
         WorsvflMykUMERYcoyJYSOpC8+l5LMCOzs2YBBRmSJoUTzGKf0scl5FddkBQWOaIhT
         GwnqFB1VZwZplQZt3NTcK3a/KMcSRjIo0CKbfTxNhXSfdEwnYuPerD7pwFFJGJFJA3
         hyQLhJjridnveTZ/DfiPT9rpVPxjE9kNvIpfOa4uQeptvK60qVAzKlySyll0t2HMRY
         5It/PFzyhHP4Q==
Date:   Fri, 13 May 2022 09:07:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND v5 1/4] PCI: Clean up pci_scan_slot()
Message-ID: <20220513140723.GA947754@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f34130034637278c9999cf6d430be558cb0c2318.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 12, 2022 at 04:56:42PM +0200, Niklas Schnelle wrote:
> On Thu, 2022-05-05 at 10:38 +0200, Niklas Schnelle wrote:
> > While determining the next PCI function is factored out of
> > pci_scan_slot() into next_fn() the former still handles the first
> > function as a special case. This duplicates the code from the scan loop.
> > 
> > Furthermore the non ARI branch of next_fn() is generally hard to
> > understand and especially the check for multifunction devices is hidden
> > in the handling of NULL devices for non-contiguous multifunction. It
> > also signals that no further functions need to be scanned by returning
> > 0 via wraparound and this is a valid function number.
> > 
> > Improve upon this by transforming the conditions in next_fn() to be
> > easier to understand.
> > 
> > By changing next_fn() to return -ENODEV instead of 0 when there is no
> > next function we can then handle the initial function inside the loop
> > and deduplicate the shared handling. This also makes it more explicit
> > that only function 0 must exist.
> > 
> > No functional change is intended.
> > 
> > Cc: Jan Kiszka <jan.kiszka@siemens.com>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> 
> Friendly ping :-)

Thanks and sorry for the delay.  I'm off today for my daughter's
wedding reception but will get back to it next week.  Just to expose
some of my thought process (and not to request more work from you!)
I've been wondering whether b1bd58e448f2 ("PCI: Consolidate
"next-function" functions") is really causing us more trouble than
it's worth.  In some ways that makes the single next-function harder
to read.  But I guess the hypervisor special case is not exactly a
"next-function" thing -- it's a "keep scanning even if there's no fn
0" thing.

Bjorn
