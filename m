Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2249166870D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 23:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjALWfn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 17:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239485AbjALWfl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 17:35:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6951E3A4
        for <linux-pci@vger.kernel.org>; Thu, 12 Jan 2023 14:35:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0055D621A6
        for <linux-pci@vger.kernel.org>; Thu, 12 Jan 2023 22:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2598AC433EF;
        Thu, 12 Jan 2023 22:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673562935;
        bh=tI/RNWwl9Jk/T2Nq5PvIYDr70ib6cpRLaFcdD1iENbk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=b+NKDF1dMv3cz3cUM0X1eRybklKQoQ0c4pbcF0dDwJuAr+qdD1Q4Anes5eM4v+bWP
         7hUYoT3fVW+vDyREmFdA1+MB4BNDLQ7ckcr95MOjM50Lsbux1VGf9UAOJO3/1wfYf5
         HJeAy8xJWgQtN5lNdFiB0QQJPr+PljZakS8X3UqduPrY+VskZmkqtFqoGUdWlCLzvi
         rwLfmLFPjtsylQu72TRFEZU9eltLMiX+7FbNf/3Z6iQm06dIpGCisWhZ5DtzVzf4Yu
         snyY3BIk0cbLqWYnFXApJWhhURqbDnRgrUxYR/k7mgWX55HLkLAXGWj3xqorg3RjvC
         FYzotgtiKu0uQ==
Date:   Thu, 12 Jan 2023 16:35:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>
Subject: Re: [PATCH 3/3] PCI/DPC: Await readiness of secondary bus after reset
Message-ID: <20230112223533.GA1798809@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2ff8481c3f08458dcd2b4028a838730e965c72f.1672511017.git.lukas@wunner.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 31, 2022 at 07:33:39PM +0100, Lukas Wunner wrote:
> We're calling pci_bridge_wait_for_secondary_bus() after performing a
> Secondary Bus Reset, but neglect to do the same after coming out of a
> DPC-induced Hot Reset.  As a result, we're not observing the delays
> prescribed by PCIe r6.0 sec 6.6.1 and may access devices on the
> secondary bus before they're ready.  Fix it.
> 
> Tested-by: Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>

I assume this patch is the one that makes the difference for the
Intel Ponte Vecchio HPC GPU?  Is there a URL to a problem report, or
at least a sentence or two we can include here to connect the patch
with the problem users may see?  Most people won't know how to
recognize accesses to devices on the secondary bus before they're
ready.

Bjorn
