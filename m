Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF1D59D1DB
	for <lists+linux-pci@lfdr.de>; Tue, 23 Aug 2022 09:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240269AbiHWHTM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Aug 2022 03:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239169AbiHWHTM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Aug 2022 03:19:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699CC61B17;
        Tue, 23 Aug 2022 00:19:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14E9CB81BDE;
        Tue, 23 Aug 2022 07:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F621C433C1;
        Tue, 23 Aug 2022 07:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661239148;
        bh=V375TAzPRg9BeBuHWxGCgFy2erOrU34+A80dlNEX2V0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UAR0Nn3W/bDHu9dpc9KR+5zJFUo2BGq5g0PcfGzu8DbbKLbioUkUmUBuRr4kHGySG
         IqCRJCv9sQFPMPCI88DSginXtYNFI/sjKj4w6id1Q9YKexd4r1JDRnpcGBxQohsovx
         /Bas05hvt7cmPWCoBZxwmTqm75hYI8VMV27l7m3c=
Date:   Tue, 23 Aug 2022 09:19:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Allow drivers to request exclusive config
 regions
Message-ID: <YwR/apnh4bnBAnM2@kroah.com>
References: <20220822005237.540039-1-ira.weiny@intel.com>
 <20220822005237.540039-2-ira.weiny@intel.com>
 <YwMktMqN0oFgCeZn@kroah.com>
 <6303dcb63e3e1_1b32294d9@dwillia2-xfh.jf.intel.com.notmuch>
 <YwPpLWgG37ObTMAP@iweiny-desk3>
 <6303f298ef92c_1b322944c@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6303f298ef92c_1b322944c@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 22, 2022 at 02:18:17PM -0700, Dan Williams wrote:
> Ira Weiny wrote:
> > > Similar to CONFIG_IO_STRICT_DEVMEM, just turn this warning off if you
> > > are a distribution kernel vendor who does not care about DOE vendor
> > > tools affecting system state, and turn on CONFIG_LOCK_DOWN_KERNEL if you
> > > are on the other end of the spectrum and want protection from such
> > > things. The warn is middle-road option that I expect most distros would
> > > use.
> > 
> > FWIW I did not add any Kconfig for the feature.  Should I?
> 
> I think so, especially as it is a distro configuration policy about what
> user-mode PCI tooling it wants to support / warn about.

No, no need for that, distros are forced to just "enable everything" as
they don't want to make any policy decision like that.  So just make it
always present, no one will turn it off.

thanks,

greg k-h
