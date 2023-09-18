Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FEA7A532B
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 21:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjIRTjW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Sep 2023 15:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjIRTjV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 15:39:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC283109;
        Mon, 18 Sep 2023 12:39:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4B4C433C9;
        Mon, 18 Sep 2023 19:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695065955;
        bh=MYLjauQjUNrziNJesoyG56GkzOngzUfwuVsg4uLhDPI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ldS5Vrqt10ANiv7CRtlv8OWAbxjZAbr2jQoAK1U/2bEAltPy3Ya/7ueilB1o0ORRr
         lDrFXXPrRwSj/IIjQih8dI3OptEqKRPQXSRiIEnFdNxvkKWDMP+m5VXxgE9EKkWsAw
         vaWVhkDCG3CtDT4yHexV8pyuu5v8f9+e4XQYlrOa/ur4anhGnb6YiFvrx0NKzuz+RN
         C2G9DudfC5tNyNlgEPfuYL1bT2ydNTbJxwkHvbbKdAxgiT8gPZuf1N2yC9mPsOa4Bo
         Sj9wpjI9+604TvjWgU4k8cVt1Ae9o7Sum1jTCEeRtyBTWErpPjmE8lHq3NYwZcDXT0
         rQVNfDvE+ni3Q==
Date:   Mon, 18 Sep 2023 14:39:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Grant Grundler <grundler@chromium.org>, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mahesh@linux.ibm.com,
        oohall@gmail.com, rajat.khandelwal@linux.intel.com,
        rajatja@chromium.org
Subject: Re: [PATCHv3 pci-next 1/2] PCI/AER: correctable error message as
 KERN_INFO
Message-ID: <20230918193913.GA203601@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c3f9a2ee7f9effe7cf9d1077652e85de0eae66c.camel@xry111.site>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 18, 2023 at 07:42:30PM +0800, Xi Ruoyao wrote:
> ...

> My workstation suffers from too much correctable AER reporting as well
> (related to Intel's errata "RPL013: Incorrectly Formed PCIe Packets May
> Generate Correctable Errors" and/or the motherboard design, I guess).

We should rate-limit correctable error reporting so it's not
overwhelming.

At the same time, I'm *also* interested in the cause of these errors,
in case there's a Linux defect or a hardware erratum that we can work
around.  Do you have a bug report with any more details, e.g., a dmesg
log and "sudo lspci -vv" output?

Bjorn
