Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9C35B7BFE
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 22:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiIMUHu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 16:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiIMUHt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 16:07:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD07A61734;
        Tue, 13 Sep 2022 13:07:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 617B66157F;
        Tue, 13 Sep 2022 20:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8026DC433C1;
        Tue, 13 Sep 2022 20:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663099667;
        bh=G7Kj4Lg7b02kkVZ4u+0wkU9az0+7xB4DQEPp/0r+LDQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OY7+U86MXLmloWdiPJD1Acy0SWjH20Ow6X7t++XTDUUK+MTFo63KqhfMDgvoliSxp
         P58W2G+eftA9ly4Z0gZgTGUCv+N7RxpbFbZG4HJDGsdY3K8rgPFecDnhfzuOgIoi0Z
         TKZxy22ETxBNdqXB/XnTcZbhcOVOAO+IPpn2Vk1PN0dDhLCwcCgwMmd/IplKi5LRCe
         QnMEa1Ocs+Nz2c0FsQFYpmoS3hoVjW3AJBpzWzWvCRfppmHChiHXCzgp2+gtf5qfZ6
         PZNhDYPT+SvPXPWPErY6lfIsoH5jNTaQsW9N3uIn2Hv4aiPTtMjnlmzAWrnEZnuqfA
         CdrJN0+mASWKA==
Date:   Tue, 13 Sep 2022 15:07:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vidya Sagar <vidyas@nvidia.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        treding@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Message-ID: <20220913200746.GA619956@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1c243b0-2e6e-3254-eff0-a5276020a320@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 13, 2022 at 06:00:30PM +0100, Jon Hunter wrote:
> On 13/09/2022 17:51, Manivannan Sadhasivam wrote:
> > On Tue, Sep 13, 2022 at 03:42:37PM +0530, Vidya Sagar wrote:
> > > Some of the platforms (like Tegra194 and Tegra234) have open slots and
> > > not having an endpoint connected to the slot is not an error.
> > > So, changing the macro from dev_err to dev_info to log the event.
> > 
> > But the link up not happening is an actual error and -ETIMEDOUT is being
> > returned. So I don't think the log severity should be changed.
> 
> Yes it is an error in the sense it is a timeout, but reporting an error
> because nothing is attached to a PCI slot seems a bit noisy. Please note
> that a similar change was made by the following commit and it also seems
> appropriate here ...
> 
> commit 4b16a8227907118e011fb396022da671a52b2272
> Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Date:   Tue Jun 18 23:32:06 2019 +0530
> 
>     PCI: tegra: Change link retry log level to debug
> 
> 
> BTW, we check for error messages in the dmesg output and this is a new error
> seen as of Linux v6.0 and so this was flagged in a test. We can ignore the
> error, but in this case it seem more appropriate to make this a info or
> debug level print.

Can you tell whether there's a device present, e.g., via Slot Status
Presence Detect?  If there's nothing in the slot, I don't know why we
would print anything at all.  If a card is present but there's no
link, that's probably worthy of dev_info() or even dev_err().

I guess if you can tell the slot is empty, there's no point in even
trying to start the link, so you could avoid both the message and the
timeout by not even calling dw_pcie_wait_for_link().

Bjorn
