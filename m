Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C5D67A736
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jan 2023 00:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbjAXXwH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 18:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjAXXwG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 18:52:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E9F4FADB;
        Tue, 24 Jan 2023 15:51:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE693612E3;
        Tue, 24 Jan 2023 23:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E0DC433D2;
        Tue, 24 Jan 2023 23:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674604317;
        bh=yGpuxXtkevLyK+dnh+ZmmDdXBFJtlRVtTJ6LLwAz0gE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eaA0V0M2B80gjzW09l4v/15fA6x+4QjmfXoYlIfwIAdjoE+1Y5bvzF20zJV7kz/zI
         Mec5pliwqkfk/2k1N3j6k+ES5fQ1nVxsJZi156+7b49/3rb4mJLUj1fveFX3naF5Y3
         m+zdDP+TpBe6t+G2zKLV5mTbqo5eBxMrTWcOiNCJULmFgJOOaQoFFTGH6OP4XtjD7R
         86iEpjh8M6Oi6kaaRRLBwt+351eroLF2FvLSfpC1XlB+ccc6k9Cyme0nzAFBfpApDT
         yAgOhYHnLJm00LGKPEX+0hwY9T+4AR+2lEtGemHQOSdFj0ALVLje5oBlNnYtREmL4b
         SwmxKdEQtPLkA==
Date:   Tue, 24 Jan 2023 17:51:55 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 10/10] PCI/DOE: Relax restrictions on request and
 response size
Message-ID: <20230124235155.GA1114594@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124124315.00000a5c@Huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 24, 2023 at 12:43:15PM +0000, Jonathan Cameron wrote:
> On Mon, 23 Jan 2023 11:20:00 +0100
> Lukas Wunner <lukas@wunner.de> wrote:
> 
> > An upcoming user of DOE is CMA (Component Measurement and Authentication,
> > PCIe r6.0 sec 6.31).
> > 
> > It builds on SPDM (Security Protocol and Data Model):
> > https://www.dmtf.org/dsp/DSP0274
> > 
> > SPDM message sizes are not always a multiple of dwords.  To transport
> > them over DOE without using bounce buffers, allow sending requests and
> > receiving responses whose final dword is only partially populated.
> > 
> > Tested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Ah. This...
> 
> I can't immediately find the original discussion thread, but I'm fairly
> sure we had a version of the DOE code that did this (maybe we just
> discussed doing it and never had code...)
> 
> IIRC, at the time feedback was strongly in favour of making
> the handling of non dword payloads a problem for the caller (e.g. PCI/CMA)
> not the DOE core, mainly so that we could keep the layering simple.
> DOE part of PCI spec says DWORD multiples only, CMA has non dword
> entries.

I can't remember, but I might have been the voice in favor of making
it the caller's problem.  Your argument about dealing with it here
makes a lot of sense, and I'm OK with it, but I *would* like to add
some text to the commit log and comments in the code about what is
happening here.  Otherwise there's an unexplained disconnect between
the DWORD spec language and the byte-oriented code.

> Personally I'm fully in favour of making our lives easier and handling
> this at the DOE layer!  The CMA padding code is nasty as we have to deal
> with caching just the right bits of the payload for the running hashes.
> With it at this layer I'd imagine that code gets much simpler
> 
> Assuming resolution to Ira's question on endianness is resolved.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
