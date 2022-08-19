Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BB6599E33
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 17:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349186AbiHSP1a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 11:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349704AbiHSP12 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 11:27:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC5AFAC53;
        Fri, 19 Aug 2022 08:27:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0E12615B0;
        Fri, 19 Aug 2022 15:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA5FC433C1;
        Fri, 19 Aug 2022 15:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660922847;
        bh=TVSnyBkAa8N3fNZeD8W6C9YN5G3keWy7HS55wvxIhzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JA3/MYCi8aKQI5FCRVhTdn+ixn3NBhsnoDJTw67CciTWaHQsveUteYI5WYTGcJ1+3
         DaIEBkklvSV7vaWfbjBY9ZNFfqm/w119As80OZGIa1hqGrC5tobRCQWoVFxorplNMe
         yn18eFS/sziqUMeMsZTqdEMdinpy7pn8uc5d5SXs=
Date:   Fri, 19 Aug 2022 17:27:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kishon@ti.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mie@igel.co.jp, kw@linux.com
Subject: Re: [PATCH 3/5] tools: PCI: Fix parsing the return value of IOCTLs
Message-ID: <Yv+r3BwBel8X/8gE@kroah.com>
References: <20220819145018.35732-1-manivannan.sadhasivam@linaro.org>
 <20220819145018.35732-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819145018.35732-4-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 19, 2022 at 08:20:16PM +0530, Manivannan Sadhasivam wrote:
> "pci_endpoint_test" driver now returns 0 for success and negative error
> code for failure. So adapt to the change by reporting FAILURE if the
> return value is < 0, and SUCCESS otherwise.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Fixes: tag and cc: stable?

thanks,

greg k-h
