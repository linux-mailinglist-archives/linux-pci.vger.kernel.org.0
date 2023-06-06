Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5632724F7D
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 00:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjFFWRh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 18:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjFFWRg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 18:17:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223621715;
        Tue,  6 Jun 2023 15:17:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA8AF63749;
        Tue,  6 Jun 2023 22:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7EBC433D2;
        Tue,  6 Jun 2023 22:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686089854;
        bh=NuluLW0Z8Uox62temRqgzqFizopPV7Rgsw4tKzmRe/o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Dxhpa4TCapdsojok5K2lh2mmAZ5amdr9Iw9/9YrZ1aujcqs6miHWhlgzOSFTPMzaj
         L7tgZ3KnlN3a3xpqbAUgPmdHiqbnATN00LZsUGT7aXr4yyP53arpNALJZ/s5Cz0C0F
         t83RtTAS/oPAj/KxPYlTpOunzHMEHhrehpVQrwDVlRhRDRyZf4ZcmCf4LkLSh7hHJ0
         CtxeZpQWf0Uvvj75Cz6cMqQeknznk12Y1rEODIksjc6wIdb8AJRf9LO39CAhpoX3/m
         1JI9ME0v/Ky/zovLGAOWhOLzck8i5DcPc+F6wmgYYEmHEj/61mndN4C3AByiWm8HHx
         2qsVmx3uRng3Q==
Date:   Tue, 6 Jun 2023 17:17:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rob Herring <robh@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 1/1] PCI: of: Propagate firmware node by calling
 device_set_node()
Message-ID: <20230606221732.GA1147146@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH3thu1rk3H3BmVd@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 05, 2023 at 05:13:26PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 21, 2023 at 01:09:39PM +0300, Andy Shevchenko wrote:
> > Insulate pci_set_of_node() and pci_set_bus_of_node() from possible
> > changes to fwnode_handle implementation by using device_set_node()
> > instead of open-coding dev->dev.fwnode assignments.
> 
> Any news on this change? Should I do anything?

Thanks for the reminder, I applied this to pci/enumeration for v6.5.

Bjorn
