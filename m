Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD45B71F67A
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 01:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjFAXUJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 19:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjFAXUH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 19:20:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF50A13E;
        Thu,  1 Jun 2023 16:20:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8436564AAE;
        Thu,  1 Jun 2023 23:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD4AC433D2;
        Thu,  1 Jun 2023 23:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685661604;
        bh=dr1AAYYCKqg8yQojS104E/BZNK4Gamg3rVsxCAYw9W0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KAseaEW5eb5pR8LxfEMohNAqoxOqdvB5A+A58WufsllmB5QtRjL9sVsVgXaxx/mWU
         P7QE/T6ZMznzx+VJpElu2AVrd0+lasdZgxNewDPs4UkRvnQ/LQJvk2Mx1ObQXWK1zv
         0qN1hISX1IIU5E+fARDCUPDXNCLGBtmaU0HsDkoPn4Q4n9RN6Zl9YsicstK5vGBKB4
         UHUt47VxzuD/a/2HRSM9gX72IciZETArwRH1u1YHkI57W0xjIy883YzHDwh41U9/s1
         /YJjDDvPOQlHBmLk35y4/yR3zGGIfsTHK3Z0wllAz6GhJMR9QzN1B78VOwCMjmMB2l
         lpUl6Hp9vfwWQ==
Message-ID: <c83651e9-5ad7-0ae1-e30f-1604b9257543@kernel.org>
Date:   Fri, 2 Jun 2023 08:20:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 5/9] PCI: endpoint: Add linkdown notifier support
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230601145718.12204-1-manivannan.sadhasivam@linaro.org>
 <20230601145718.12204-6-manivannan.sadhasivam@linaro.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230601145718.12204-6-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/1/23 23:57, Manivannan Sadhasivam wrote:
> Add support to notify the EPF device about the linkdown event from the
> EPC device.
> 
> Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

