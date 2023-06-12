Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25F572CD2D
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jun 2023 19:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbjFLRrT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jun 2023 13:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjFLRrT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2023 13:47:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF3E19D
        for <linux-pci@vger.kernel.org>; Mon, 12 Jun 2023 10:47:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F29D56178D
        for <linux-pci@vger.kernel.org>; Mon, 12 Jun 2023 17:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2384EC433D2;
        Mon, 12 Jun 2023 17:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686592034;
        bh=PpbmhUoThaVdI3OKRTudRWU5LIVt3Owibsxkw2dEWAk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GfXqWYs5FqjG1c1Vgo56lhd+rdUW5YQ6LUKL/cSAc73hqGvhui4iMKoiJhrwyjpIU
         TBm/l4tM7uY2uebxrqoj+PMssM1Rc4XVHIkDK76p9pj7xjDL/8xn8vRPg8HcVGSA3C
         WljX0wS0SPCpmQ4RKMY5XCKFwmYX+Qd1KqmTPUOpNbiJn//d24BN4HJ9PjWI/si0we
         z8/tUXtjI+3i9RG4SWQmG2gZaS9dtzChAYU6LA/fGnDmee8ra5IINhlLOmFU0GQMpk
         3r3bZDhrxWhlNQ+egeF3v6uWTEnMdZ0/llhBjFBDV0I/lU9i33v0Hc3hbWJSQAsR9/
         D0DceqGOIUDQg==
Date:   Mon, 12 Jun 2023 12:47:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>, Stefan Roese <sr@denx.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/4] PCI: AER updates
Message-ID: <20230612174712.GA1342478@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609222500.1267795-1-helgaas@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 09, 2023 at 05:24:56PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Patch 2 ("Drop recommendation to configure AER Capability") was previously
> posted at https://lore.kernel.org/r/20230214172831.GA3046378@bhelgaas and
> is unchanged here.
> 
> The others have not been posted previously.
> 
> Bjorn Helgaas (4):
>   PCI: Unexport pci_save_aer_state()
>   Documentation: PCI: Drop recommendation to configure AER Capability
>   Documentation: PCI: Update cross references to .rst files
>   Documentation: PCI: Tidy AER documentation
> 
>  Documentation/PCI/pci-error-recovery.rst |   2 +-
>  Documentation/PCI/pcieaer-howto.rst      | 183 ++++++++---------------
>  drivers/pci/pci.h                        |   4 +
>  include/linux/aer.h                      |   4 -
>  4 files changed, 70 insertions(+), 123 deletions(-)

Applied to pci/aer for v6.5, thanks to everybody who took a look.

Bjorn
