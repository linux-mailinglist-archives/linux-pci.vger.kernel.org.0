Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB896F0E7D
	for <lists+linux-pci@lfdr.de>; Fri, 28 Apr 2023 00:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344318AbjD0Wr7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 18:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjD0Wr6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 18:47:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C962129;
        Thu, 27 Apr 2023 15:47:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C43D060BC3;
        Thu, 27 Apr 2023 22:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045E6C433EF;
        Thu, 27 Apr 2023 22:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682635676;
        bh=mLAin49LaTO2Gar1reim/HnDERem55oO+zK/UnUJmBg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Aib+68hsFlhLiRszyim/9Rwg4H2zMowHE9EZihIlEicNMyjyk0ol6oYchAz008x+1
         Er3xT2x4r5LyMzIdDD7Kn/KSQ9it+2nn66iQJH+Gwcmc6z5yaETJGbpkK3DVRcN33j
         ZOMi/u7hQtC1zTFU+gEWxGXB4ECGN+ekX9cncUd4ZrPJVbs/268DuO4GXsd9whH/18
         bYW64sGurSqDXsWp4Mj9Bq3V5+3AVi7ayoeP0YkR9/B0qE1t9jIMEo2cNp4OfsaHcZ
         g1+OTbBAQ5dKT1Uf/vsBIPkxEr400tmKlMof1UUL57eFpj4f0mD7IdU4YXGDAO/SXs
         UfEQnpqXBAlDQ==
Date:   Thu, 27 Apr 2023 17:47:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Cc:     rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com,
        ying.huang@intel.com, rdunlap@infradead.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        CobeChen@zhaoxin.com, TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com,
        leoliu@zhaoxin.com
Subject: Re: [PATCH v2 3/5] ACPI/PCI: Add AER bits #defines for PCIe to
 PCI/PCI-X Bridge
Message-ID: <20230427224754.GA298752@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd3e967a-1f1a-9d3e-1058-a5e7951b1dbd@zhaoxin.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 10:38:58AM +0800, LeoLiuoc wrote:
> 在 2023/4/13 0:10, Bjorn Helgaas 写道:
> > On Wed, Apr 12, 2023 at 05:49:55PM +0800, LeoLiuoc wrote:

> > > >     ...
> > > >     #define PCI_ERR_ROOT_ERR_SRC    0x34    /* Error Source Identification */
> > > >     #define PCI_ERR_UNCOR_MASK2     0x30    /* PCIe to PCI/PCI-X bridge */
> > > >     #define PCI_ERR_UNCOR_SEVER2    0x34    /* PCIe to PCI/PCI-X bridge */
> > > >     #define PCI_ERR_CAP2            0x38    /* PCIe to PCI/PCI-X bridge */
> > > 
> > > I don't seem to understand what you mean. PCI_ERR_UNCOR_MASK2,
> > > PCI_ERR_UNCOR_SEVER2, and PCI_ERR_CAP2 represent the control and handling of
> > > individual errors that occur on traditional PCI or PCI-x secondary bus
> > > interfaces, these registers are valid only for Bridge. Although
> > > PCI_ERR_ROOT_ERR_SRC and PCI_ERR_UNCOR_SEVER2 have the same value, they
> > > represent register definitions for different device types.
> > 
> > Right.  I just don't want the blank line in the middle because it
> > might be mistaken for items in a different capability.  All the other
> > AER capability registers are defined together in a block, with no
> > blank lines in the middle, so I think these new ones should be part of
> > that block.
> 
> Ok，I see your point. Do you think this line of comment is still necessary?
> /* PCIe advanced error reporting extended capabilities for PCIe to PCI/PCI-X
> Bridge */

I suggested a trailing comment ("PCIe to PCI/PCI-X bridge").  If we
use that, I don't think the other is necessary.

Bjorn
