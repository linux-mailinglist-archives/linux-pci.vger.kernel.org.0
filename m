Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3575C79874E
	for <lists+linux-pci@lfdr.de>; Fri,  8 Sep 2023 14:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjIHMrZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 08:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjIHMrZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 08:47:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FAE2103;
        Fri,  8 Sep 2023 05:47:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11090C433CA;
        Fri,  8 Sep 2023 12:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694177222;
        bh=g7czZWYDqWFLGt4QrJ4Ljz81qe7dj5HTXxH0LEVTW8o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PPS6kqUaBBtq1s7LUydPYmrnA2mtLvIg04RZnYDxkFvAZIWOK4TsNX26JfLVWJZyh
         8NE16wT2f417ruD1n4CvM1ejK27u72YLdXFYr1xL6QG2sbwuQieFpsVpcpqFwgcGcz
         GHkq0X7J/X6bZs9Z9zquWi7puRWoGstW1ARMc+SnWg1m8hpUpG9vCxeJw0M4bKa0h6
         NwbxIKqsv5UB8RPznMu/NySxOiCGnuLwaO3JuUuSoy2ejP9xXjuE4VSyF91jvQbAK1
         BpW+6KYtAGqgqHWtyEvt58Pmzh4ehpvFRQatoUyPda8mbbepUvL23oMJM7Yo9L5DE3
         WjUqduMBEdMdw==
Date:   Fri, 8 Sep 2023 07:47:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>
Cc:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] PCI: altera: add suport for Agilex Family FPGA
Message-ID: <20230908124700.GA292601@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR11MB43060919B690263A0B1EA291FDEDA@BY5PR11MB4306.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 08, 2023 at 09:15:09AM +0000, D M, Sharath Kumar wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>

> > > +static u32 port_conf_off;
> > 
> > port_conf_off looks like something that should be per-controller.
> Specific to agilex, will rename to "aglx_port_conf_off"

This comment was not about the *name*, it was about the fact that it's
a single instance that applies to *all* controllers.  It might be the
case that current hardware only supports a single controller, or that
if you have multiple controllers they all use the same port_conf_off
value, but for generality, values like this would normally be in the
per-controller structure.

Bjorn
