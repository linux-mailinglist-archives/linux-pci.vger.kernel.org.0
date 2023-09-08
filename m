Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58606799099
	for <lists+linux-pci@lfdr.de>; Fri,  8 Sep 2023 21:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjIHTxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 15:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240144AbjIHTxF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 15:53:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB8A1B0;
        Fri,  8 Sep 2023 12:52:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEE4C433C8;
        Fri,  8 Sep 2023 19:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694202765;
        bh=5rqLwj+1myPc2nWRbdfOemy33knRELmmNyhGnJHwvZo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DLXOAH7QLq3jgJx6Fi/ZAUkSK2MfgRiJ5oVsAuxVowL5jqftZgjx8dnXWti3Hai6+
         CyioWdTQJ2heEzrDQQY0d0mJVJB1y6VQWSZAnAH98xinG73Ih4yyadcH6GMyv2vSKe
         fvFaeCdK3/xO0J3qPx7ad9RjItdEkjkkWRWa5YLXWlvAwTyxh2TEyJYIIJUt4N8Hzh
         4k8OS4eRrme6jx45G7s/oUfbO5EUolUkZFgVWbMs/I8twLlWReKt/HOqTSU6KfgYAS
         7M0pHlj/YzgYXGbWRPFd0YVHW9mcoFeMfds5t2NJQwiTcYovZaxObFoG2f06T7D4w/
         Pr0pM2M/Hn0wA==
Date:   Fri, 8 Sep 2023 14:52:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>
Cc:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: altera: refactor driver for supporting new
 platform
Message-ID: <20230908195242.GA304243@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR11MB4306A066509DC8CB2ECEC164FDEDA@BY5PR11MB4306.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 08, 2023 at 01:40:13PM +0000, D M, Sharath Kumar wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > On Fri, Sep 08, 2023 at 09:09:34AM +0000, D M, Sharath Kumar wrote:
> > > > -----Original Message-----
> > > > From: Bjorn Helgaas <helgaas@kernel.org> ...
> > 
> > > > > +	int (*ep_read_cfg)(struct altera_pcie *pcie, u8 busno,
> > > > > +			unsigned int devfn, int where, int size, u32 *value);
> > > > > +	int (*ep_write_cfg)(struct altera_pcie *pcie, u8 busno,
> > > > > +			unsigned int devfn, int where, int size, u32 value);
> > > >
> > > > "ep_read_cfg" isn't the ideal name because it suggests "endpoint",
> > > > but it may be either an endpoint or a switch upstream port.  The
> > > > rockchip driver uses "other", which isn't super descriptive either but
> > might be better.
> > > >
> > > Ok will change to "nonrp_read_cfg" ?
> > 
> > I think the important point is not whether it's a Root Port or not, but whether
> > it's on the root *bus* or not.  In other words, I think the driver has to
> > determine whether to generate a Type 0 (targeting something on the root
> > bus) or a Type 1 (targeting something below a
> > bridge) config transaction (see PCI-to-PCI Bridge spec r1.2, sec 3.1.2.1).
> > 
> > There can be non-Root Ports on the root bus, so "nonrp" doesn't seem quite
> > right.  "Other" would be OK, since that's already used by other drivers.
> > Maybe "type0" and "type1" would be better and would fit well with the
> > root_bus_nr check you use to distinguish them?
> > 
> Situation is
> Root port configuration space  - memory mapped
> Non root port configuration space - indirect access/proprietary access
>     Type 0 for devices directly connected to root port
>     Type 1 for others

"mm", "ind"?
