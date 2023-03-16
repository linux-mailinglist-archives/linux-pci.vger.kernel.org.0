Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6ABA6BD5A2
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 17:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCPQb7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 12:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCPQb6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 12:31:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707D7A02BF
        for <linux-pci@vger.kernel.org>; Thu, 16 Mar 2023 09:31:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28C38B8227F
        for <linux-pci@vger.kernel.org>; Thu, 16 Mar 2023 16:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68442C433EF;
        Thu, 16 Mar 2023 16:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678984313;
        bh=OVAd3X7KPuAkdN9BE4ydKJMequF5nC4d/IY24NsSakM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YigcSDhG6T5tDL5VxGKbiZFZ+J+FpNKVUM8ms+tp9gBjIgHHoPrASP5+x45mnTrkr
         1ruaGMz6QZbW7pvxZpMEYDFi4lYr1ktt4f7dnnDwQqvxs/ICNZgJ3Hz4LLGB5pTZv7
         0cgy8EonFS/g7EQOCO9aebJdj/sOQzeEYbKmP9c+giLU7hF+LksNxTnJXDAxmVcr1k
         aPngxfdzvSs9zSTIjs3pZ+tE7AmKdeV9DdWzCdt01FyL+m/JJ0sicZEletxcTaKRQS
         rYL+ZPA4tIZYiULDF2jsTolOKCCSWg6oCW3q89uOqQP3w4UktL491XfAB7x+X+OLi0
         dnfNAIlLRTG7A==
Date:   Thu, 16 Mar 2023 22:01:33 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 09/16] PCI: epf-test: Improve handling of command and
 status registers
Message-ID: <20230316163133.GA123754@thinkpad>
References: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
 <20230308090313.1653-10-damien.lemoal@opensource.wdc.com>
 <20230315155119.GK98488@thinkpad>
 <d2f42b13-3d1e-4fb9-8b03-b32b7a9845a9@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2f42b13-3d1e-4fb9-8b03-b32b7a9845a9@app.fastmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 16, 2023 at 04:25:58PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 15, 2023, at 16:51, Manivannan Sadhasivam wrote:
> > On Wed, Mar 08, 2023 at 06:03:06PM +0900, Damien Le Moal wrote:
> >> +	/*
> >> +	 * Set the status before raising the IRQ to ensure that the host sees
> >> +	 * the updated value when it gets the IRQ.
> >> +	 */
> >> +	WRITE_ONCE(reg->status, status);
> >
> > For MMIO, it is not sufficient to use WRITE_ONCE() and expect that the write
> > has reached the memory (it could be stored in a write buffer). If you really
> > care about synchronization, then you should do a read back of the variable.
> 
> This is not MMIO, this is the local access to a variable that is accessed
> through MMIO from the remote host. Reading it back would not change anything
> here as far as I can tell, 
> 

Ah, sorry I got confused this with my EPF driver... Yeah for a variable
WRITE_ONCE is sufficient.

Thanks,
Mani

>       Arnd

-- 
மணிவண்ணன் சதாசிவம்
