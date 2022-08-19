Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B16599E48
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 17:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349184AbiHSP1I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 11:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349063AbiHSP1H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 11:27:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03837C6CE6;
        Fri, 19 Aug 2022 08:27:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55452615CE;
        Fri, 19 Aug 2022 15:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AD6C433D6;
        Fri, 19 Aug 2022 15:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660922825;
        bh=USJMgCUfTM1xHuRpc0pCe7yuIprEXFxEXKDZLcrUfI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e39q3hSjH/lh//lRLbrYuhX39KaUDyPvfsbytBSCPKO/NrGg3G3ziw6DPWHNr+49R
         oU5s1MpybusK91823TJM+94vebgknDGPwa9tZ4hgUSIVvKN0kL8b+gMCMQTnozHxz6
         1RMGXZwwk55fUPByTKBGecAcX8satXrcqzEpNl8M=
Date:   Fri, 19 Aug 2022 17:27:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kishon@ti.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mie@igel.co.jp, kw@linux.com
Subject: Re: [PATCH 1/5] misc: pci_endpoint_test: Remove unnecessary WARN_ON
Message-ID: <Yv+rxuqUc+an6R3q@kroah.com>
References: <20220819145018.35732-1-manivannan.sadhasivam@linaro.org>
 <20220819145018.35732-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819145018.35732-2-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 19, 2022 at 08:20:14PM +0530, Manivannan Sadhasivam wrote:
> If unable to map test_reg_bar, then probe will fail with a dedicated
> error message. So there is no real need of WARN_ON here.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/misc/pci_endpoint_test.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Should this go to stable kernels?

thanks,

greg k-h
