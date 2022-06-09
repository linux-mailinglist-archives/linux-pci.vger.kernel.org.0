Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1715452FF
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 19:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbiFIRcH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 13:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239149AbiFIRcH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 13:32:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD072D89A7;
        Thu,  9 Jun 2022 10:32:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 250D9B82F33;
        Thu,  9 Jun 2022 17:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BF4C34114;
        Thu,  9 Jun 2022 17:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654795922;
        bh=bscKGXyefxC9Ra/Mw3rYDH+nu51bXnKerrvlQ1z3MbU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nnag0fuKmP9yYi85Af9oiZQ6T0uD0PS8sJ3lzYCGu2MjbbmZStkz3QvTuxBGMHDXT
         eeScwn/JYyLRJw0Y5s/4dFkaCj/E9Cpn3Mpx4isAHH+CKxtZSDpQtLc/+hE0af1+BT
         JWhawjyN+2O+CZvBehKfK0zJKyc1e91tyFwHvJbFX4mlT7xmzN1a2+faK2GzRjssp3
         +lctDuYILJCAfZW8IOLAiWAmHzs2V/8YlK9ytpIimHo5s6aZvrV4BujDO+BsO9gVaj
         cv/aVbrK2BD6Su8/B2wqFZi4k+OfhE2WEAjY3rXSnJh3fnBYllEC4ZfOQDhFGcuOer
         g6sYqItYP/60A==
Date:   Thu, 9 Jun 2022 12:32:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, robh@kernel.org
Subject: Re: [PATCH v4 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port
Message-ID: <20220609173201.GA519962@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a403b92d-00f1-885f-7d1b-0fce82b50993@xilinx.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 09, 2022 at 09:59:08AM +0200, Michal Simek wrote:
> On 6/8/22 21:14, Bjorn Helgaas wrote:
> > On Wed, Jun 08, 2022 at 10:10:46PM +0530, Bharat Kumar Gogada wrote:
> > > Xilinx Versal Premium series has CPM5 block which supports Root Port
> > > functioning at Gen5 speed.
> > > 
> > > Xilinx Versal CPM5 has few changes with existing CPM block.
> > > - CPM5 has dedicated register space for control and status registers.
> > > - CPM5 legacy interrupt handling needs additional register bit
> > >    to enable and handle legacy interrupts.
> > > 
> > > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > > ---
> > >   drivers/pci/controller/pcie-xilinx-cpm.c | 33 +++++++++++++++++++++++-
> > >   1 file changed, 32 insertions(+), 1 deletion(-)
> > 
> > Per MAINTAINERS, xilinx-cpm lacks a maintainer.  Can we get one?
> 
> Bharat should become maintainer for this driver.
> 
> My fragment should cover xilinx things in general in case Bharat is
> not available.

Great!  Can one of you post a patch to show exactly what you have in
mind?

Thanks,
  Bjorn
