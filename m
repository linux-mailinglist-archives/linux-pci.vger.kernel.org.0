Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18DA5EBB71
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 09:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiI0H1W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 03:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiI0H1Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 03:27:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142525A839;
        Tue, 27 Sep 2022 00:27:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4BC661633;
        Tue, 27 Sep 2022 07:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAEAC433D6;
        Tue, 27 Sep 2022 07:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664263633;
        bh=SI3kVzyecrOMD/bcba3UfKjYRRQPvyugPiizWjjNlW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a7yA5+skaquN4y+vevefsEkQE6uigIxphkNMmk9rkL2DRmNXZJBAr6VWB+5frE/pV
         V89bwhx2dfKLSUW5ZBhl68d4D/lrRYoWG3MbKOZwVAotK+6SqLhTSmbIRLhnIeNUyW
         iqT6ETmIrMTZs2B4dGuajdB/iz8jr+eViHmhBIZw=
Date:   Tue, 27 Sep 2022 09:27:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V3 1/2] PCI: Allow drivers to request exclusive config
 regions
Message-ID: <YzKlzp2/pSdYiOUf@kroah.com>
References: <20220926215711.2893286-1-ira.weiny@intel.com>
 <20220926215711.2893286-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926215711.2893286-2-ira.weiny@intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 26, 2022 at 02:57:10PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> PCI config space access from user space has traditionally been
> unrestricted with writes being an understood risk for device operation.
> 
> Unfortunately, device breakage or odd behavior from config writes lacks
> indicators that can leave driver writers confused when evaluating
> failures.  This is especially true with the new PCIe Data Object
> Exchange (DOE) mailbox protocol where backdoor shenanigans from user
> space through things such as vendor defined protocols may affect device
> operation without complete breakage.
> 
> A prior proposal restricted read and writes completely.[1]  Greg and
> Bjorn pointed out that proposal is flawed for a couple of reasons.
> First, lspci should always be allowed and should not interfere with any
> device operation.  Second, setpci is a valuable tool that is sometimes
> necessary and it should not be completely restricted.[2]  Finally
> methods exist for full lock of device access if required.
> 
> Even though access should not be restricted it would be nice for driver
> writers to be able to flag critical parts of the config space such that
> interference from user space can be detected.
> 
> Introduce pci_request_config_region_exclusive() to mark exclusive config
> regions.  Such regions trigger a warning and kernel taint if accessed
> via user space.
> 
> Create pci_warn_once() to restrict the user from spamming the log.
> 
> [1] https://lore.kernel.org/all/161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com/
> [2] https://lore.kernel.org/all/YF8NGeGv9vYcMfTV@kroah.com/
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
