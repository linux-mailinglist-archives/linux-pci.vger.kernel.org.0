Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F47D79908E
	for <lists+linux-pci@lfdr.de>; Fri,  8 Sep 2023 21:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243168AbjIHTtK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 15:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbjIHTtK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 15:49:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE3F1B0;
        Fri,  8 Sep 2023 12:48:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445CDC433C9;
        Fri,  8 Sep 2023 19:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694202524;
        bh=pCdXKpya8kWRmr8zHk72mX0W5ShrGT16OOSUfkCo0Rc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=thSuf2gvi8Y7mVPdJV9b7oX5ALif1P4LRD+BiP48Tw1L+seMdPtS4SHgSzLXRyf7G
         awsaQ851mKqIReuBVUkgLf+xBXT55E53MCvy06R8TqON2e+hBJy82laySN64vf2/Ku
         22fZIT4IDivTXXYgaNaPh5TiJwU7E1QX6g89QfB6qAFpZqdm6SfbLOtyaM88g2rZXu
         K6H1BybY0afP8/UvbYSOA7l1HiBJl9Hxarpk5NPO6sp2Du5MkdmlDobv9mVhvTGpE5
         KG6n4WrU6br4edMzfYQVxgHlrPQrr+i1UNby0mhx12B+JyCtGUoQMPn/ilZHPi8IhU
         B/Kw2iTHZnTdQ==
Date:   Fri, 8 Sep 2023 14:48:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>
Cc:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] PCI: altera: add suport for Agilex Family FPGA
Message-ID: <20230908194842.GA304176@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR11MB4306D2438CF3A387403CF9E0FDEDA@BY5PR11MB4306.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 08, 2023 at 02:35:29PM +0000, D M, Sharath Kumar wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Friday, September 8, 2023 6:17 PM
> > To: D M, Sharath Kumar <sharath.kumar.d.m@intel.com>
> > Cc: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > bhelgaas@google.com; linux-pci@vger.kernel.org; dinguyen@kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2 2/2] PCI: altera: add suport for Agilex Family FPGA
> > 
> > On Fri, Sep 08, 2023 at 09:15:09AM +0000, D M, Sharath Kumar wrote:
> > > > -----Original Message-----
> > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > 
> > > > > +static u32 port_conf_off;
> > > >
> > > > port_conf_off looks like something that should be per-controller.
> > > Specific to agilex, will rename to "aglx_port_conf_off"
> > 
> > This comment was not about the *name*, it was about the fact that it's a
> > single instance that applies to *all* controllers.  It might be the case that
> > current hardware only supports a single controller, or that if you have
> > multiple controllers they all use the same port_conf_off value, but for
> > generality, values like this would normally be in the per-controller structure.
>
> This driver supports 3 controllers/family ( arria, startix, agilex )
> This variable is only for agilex
> What is ur suggestion ?
> To add in controller data structure (struct altera_pcie_data) ? 

That seems like a logical place.
