Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2B4617161
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 00:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKBXDI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 19:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKBXDH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 19:03:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3967ED105;
        Wed,  2 Nov 2022 16:03:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECFFDB82528;
        Wed,  2 Nov 2022 23:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64ECCC433D6;
        Wed,  2 Nov 2022 23:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667430183;
        bh=bFi5GLyHkJTTp2mySqmcb6bpgXQEzy01l8XhyjLqLwc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IsiVrEYIQTvhRrDuo/Y+YcBBa26GjLjC5soSFr8/j8SbVhaO3dq0v0lkVx5jqjIjM
         DpNuE1GnSE3i3VipHqD4BakhZRtRNBUj6QICP+4yYy/fLbJGBZPNjz/Ew4XFfbexDy
         z2KMyI6WNZoBfkjZT5DDoEi+FCVWMVht7yf+fDiw3EwLGJ5IEs6R8rrBw1fpxB58oo
         vk3gUp9PYW8ED7tooVNE1V2xzfJdjp6t4tzpTlk7B2TtA0+JXzprZJ0hzy+ksP5KPt
         iHtgSTBDRjpqPQSAGvkgLPQG60/Ywylf9+6V61ooHgvnrObd3xSKItzW51dl0diyhD
         OOLh3HRhxufrQ==
Date:   Wed, 2 Nov 2022 18:03:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     mani@kernel.org, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, imx@lists.linux.dev, jdmason@kudzu.us,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        ntb@lists.linux.dev
Subject: Re: [PATCH v16 0/7]  pci-epf-vntb clean up
Message-ID: <20221102230302.GA6394@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102141014.1025893-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 02, 2022 at 10:10:07AM -0400, Frank Li wrote:
> continue patch series https://www.spinics.net/lists/linux-pci/msg130372.html
> https://www.spinics.net/lists/linux-pci/msg130924.html
> 
> Lorenzo suggest create new series. Version number continue from old one
> Change from v15 to v16
>   consistent subject
>   Add () after pci_epc_mem_free_addr

Don't forget these comments on your v15:
https://lore.kernel.org/r/20221101172006.GA1264778@bhelgaas
