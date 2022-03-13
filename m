Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55564D7809
	for <lists+linux-pci@lfdr.de>; Sun, 13 Mar 2022 20:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbiCMTxc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Mar 2022 15:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiCMTxb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Mar 2022 15:53:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA5C7B572;
        Sun, 13 Mar 2022 12:52:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9007260A3C;
        Sun, 13 Mar 2022 19:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64DCC340E8;
        Sun, 13 Mar 2022 19:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647201143;
        bh=3YY45948+lUQY17XqnXTmmU1Wh530X/CvV7eUsfsqhU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HMeEHZcWAimq+XX3e2Ucdlbxn9PVDQlUgPvmjoL88o74cGqdTlYISTpWqDRqMeQEl
         2b9dylkYug1cFQqnZAICO+QDW+T1aX9Yza/RFUPUH+fjwc6u40Nibfszn2cVC6gSSY
         9GyeNch1zkZoC1QSMBqL2vLsZuqhSHvIPDjoa0/RyzEmmz66ALFm8yLuixK2C3cM7y
         lbrkztEPsZx7cz0InHdHQSC0IRkbNCpIOCw4bRYD0KD8rH+TmYHfHJ2UOdrqLBg0C9
         X4LhqBPxUoi7m1oQVyOlFnN8LZ6hZqY/Nvs8KDUMAPLOelNb+4q/LHtH/MA+rGHLxS
         hGbRXB1+anYhw==
Date:   Sun, 13 Mar 2022 14:52:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Eric Badger <ebadger@purestorage.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1] PCI/AER: Handle Multi UnCorrectable/Correctable
 errors properly
Message-ID: <20220313195220.GA436941@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311025807.14664-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 11, 2022 at 02:58:07AM +0000, Kuppuswamy Sathyanarayanan wrote:
> Currently the aer_irq() handler returns IRQ_NONE for cases without bits
> PCI_ERR_ROOT_UNCOR_RCV or PCI_ERR_ROOT_COR_RCV are set. But this
> assumption is incorrect.
> 
> Consider a scenario where aer_irq() is triggered for a correctable
> error, and while we process the error and before we clear the error
> status in "Root Error Status" register, if the same kind of error
> is triggered again, since aer_irq() only clears events it saw, the
> multi-bit error is left in tact. This will cause the interrupt to fire
> again, resulting in entering aer_irq() with just the multi-bit error
> logged in the "Root Error Status" register.
> 
> Repeated AER recovery test has revealed this condition does happen
> and this prevents any new interrupt from being triggered. Allow to
> process interrupt even if only multi-correctable (BIT 1) or
> multi-uncorrectable bit (BIT 3) is set.
> 
> Reported-by: Eric Badger <ebadger@purestorage.com>

Is there a bug report with any concrete details (dmesg, lspci, etc)
that we can include here?
