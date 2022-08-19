Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B077D599E15
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 17:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349247AbiHSPUq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 11:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349114AbiHSPUp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 11:20:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6D4FBA5F;
        Fri, 19 Aug 2022 08:20:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9761761561;
        Fri, 19 Aug 2022 15:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB37C433C1;
        Fri, 19 Aug 2022 15:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660922444;
        bh=3VXGVkwVpb5uH0BuMCBi085zpfqwbRcHzkpRASwQVZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tiI69kZjlnaOsVQZbVGa4wA/AVj9ysSobKwU2fEANcON5aPTGYtsSgIMHnahY6laS
         n0CiuEwaaCFCPRAA5LxLELrRWIY0gwdXYEksGi9q1Gegpbq3/qVM+RZKgWLJPfXEOQ
         7Bi2487uOUiBnfD6hBgrl+hBCEerkVtDjZ2FRtik=
Date:   Fri, 19 Aug 2022 17:20:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kishon@ti.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mie@igel.co.jp, kw@linux.com
Subject: Re: [PATCH 2/5] misc: pci_endpoint_test: Fix the return value of
 IOCTL
Message-ID: <Yv+qSDUEs+6T8b9+@kroah.com>
References: <20220819145018.35732-1-manivannan.sadhasivam@linaro.org>
 <20220819145018.35732-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819145018.35732-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 19, 2022 at 08:20:15PM +0530, Manivannan Sadhasivam wrote:
> IOCTLs are supposed to return 0 for success and negative error codes for
> failure. Currently, this driver is returning 0 for failure and 1 for
> success, that's not correct. Hence, fix it!
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

This needs to come first in the series, along with a Fixes: tag, and a
 cc: stable tag so that it can be properly backported and fixed up
everywhere.

thanks,

greg k-h
