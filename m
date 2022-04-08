Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA45E4F99D7
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 17:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237783AbiDHPts (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 11:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiDHPts (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 11:49:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B861D10F8
        for <linux-pci@vger.kernel.org>; Fri,  8 Apr 2022 08:47:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2491C113E;
        Fri,  8 Apr 2022 08:47:43 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.11.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 272B83F73B;
        Fri,  8 Apr 2022 08:47:39 -0700 (PDT)
Date:   Fri, 8 Apr 2022 16:47:42 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Wangseok Lee <wangseok.lee@samsung.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>
Subject: Re: [PATCH] PCI: dwc: Modify the check about MSI DMA mask 32-bit
Message-ID: <YlBZHj29zCRlITpR@lpieralisi>
References: <Yk/CxUxR/iRb9j8l@infradead.org>
 <20220331053422epcms2p7baddf4e5c80b6ebbd5e6aa9447fa221f@epcms2p7>
 <YkR7G/V8E+NKBA2h@infradead.org>
 <20220328143228.1902883-1-alexandr.lobakin@intel.com>
 <20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c@epcms2p3>
 <20220330035203epcms2p8fb560f4f953c5a2c8fff020432adc9bd@epcms2p8>
 <20220330093526.2728238-1-alexandr.lobakin@intel.com>
 <20220408023401epcms2p41024174e7e09d475e0186fbdb954ec7c@epcms2p4>
 <CGME20220328143454epcas2p27a340d09e9f4e74af1eaa44559e372a5@epcms2p7>
 <20220408053246epcms2p73d79512797c778a320394fe12e07edc6@epcms2p7>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220408053246epcms2p73d79512797c778a320394fe12e07edc6@epcms2p7>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 08, 2022 at 02:32:46PM +0900, Wangseok Lee wrote:
> > --------- Original Message ---------
> > Sender : Christoph Hellwig <hch@infradead.org>
> > Date : 2022-04-08 14:06 (GMT+9)
> > Title : Re: [PATCH] PCI: dwc: Modify the check about MSI DMA mask 32-bit
> > 
> > On Fri, Apr 08, 2022 at 11:34:01AM +0900, Wangseok Lee wrote:
> >> Hi,
> >> 
> >> Could you please review this patch in the context of the following patch?
> >> 
> >> https://protect2.fireeye.com/v1/url?k=dff16c49-806a5556-dff0e706-000babdfecba-c817c3fb701d2897&q=1&e=5862d6bb-abdb-4e80-b515-8bc024accd0c&u=https%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Flinux-pci%2Fpatch%2F20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c%40epcms2p
> > 
> > Isn't that the same (broken) patch?
> 
> yes, The same patch that was reviewing.
> I would like to continue reviewing the pcie-designware-host.c patch below.
> https://lore.kernel.org/all/20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c@epcms2p3/

Would you please instead provide call stack (full) details of the
problem you are trying to fix ? You received feedback already on the
information you provided - to understand where the problem is I would
ask you please the full call stack leading to the failure (inclusive of
kernel version, platform, firmware and whether you are using a vanilla
kernel or out of tree patches on top - in which case we can't really
help), it is impossible to comment further otherwise.

Thanks,
Lorenzo
