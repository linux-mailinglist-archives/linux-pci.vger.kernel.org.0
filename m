Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220EA63E39C
	for <lists+linux-pci@lfdr.de>; Wed, 30 Nov 2022 23:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiK3WrT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Nov 2022 17:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiK3WrR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2022 17:47:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E378DFD4;
        Wed, 30 Nov 2022 14:47:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD11061E20;
        Wed, 30 Nov 2022 22:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40DBC433D7;
        Wed, 30 Nov 2022 22:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669848436;
        bh=mAkSKAkl3pqwPCxuYClHuIm/JfezdYIIMrJZPoMrQfY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lSFDR/KcQk9871XTj8kdDcGgl1mCWVSKGDFDQbo2nde2VbrwZ7Wc5CyETg/vm0GSV
         Lkwa9510Uc7j/R9sqwFG4Fkt6R4HmLRDQ2q/dqs2vXyOCSNnMj/3HrGO+s0u+65ykx
         eiW8fRkZhXPqY78Prb2cpLpWtWIDgk9BKuSP9pNhgQ2DWNElf2Htk0IGPsTcpBst01
         nCfkF30Lwwt2XRnw33nT8jeiemi96PHzqcTUbC/m15Em06vocAJzH4yBzyDz4vcJWD
         sUdv974EfBmzFWIjFvhY8d+PDblH+zT6BQnLFJO0ghsF1t/Nnlx+9TGEwWLpfgILkS
         /jEIgJC8iCiBQ==
Date:   Wed, 30 Nov 2022 16:47:14 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, bhelgaas@google.com
Subject: Re: [v5 11/11 PATCH] cxl/pci: Add callback to log AER correctable
 error
Message-ID: <20221130224714.GA846634@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166984638949.2804499.1293428014191809830.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 30, 2022 at 03:13:45PM -0700, Dave Jiang wrote:
> Add AER error handler callback to read the correctable error status
> register for the CXL device. Log the error as a trace event and clear the
> error. For CXL devices, the driver also needs to write back to the AER CE
> status register to clear the unmasked CEs.

"AER CE status register" points in the wrong direction.

> See CXL spec rev3.0 8.2.4.16 for Correctable Error Status Register.

>  static const struct pci_error_handlers cxl_error_handlers = {
>  	.error_detected	= cxl_error_detected,
>  	.slot_reset	= cxl_slot_reset,
>  	.resume		= cxl_error_resume,
> +	.cor_error_detected	= cxl_correctable_error_logging,

It makes grep/cscope a little more useful when the function name
includes the struct member name, e.g., "cxl_cor_error_detected".

Bjorn
