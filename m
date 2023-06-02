Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105FC720149
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 14:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbjFBMPI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 08:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbjFBMPG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 08:15:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C38ED3;
        Fri,  2 Jun 2023 05:15:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 095F764F9C;
        Fri,  2 Jun 2023 12:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379E4C433EF;
        Fri,  2 Jun 2023 12:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685708104;
        bh=sUlshAJhQCcqOt1PfsF19A1Z1D9SDqXKl/QQ7rI7ru4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vRbOfMn4U6HV+NZ3e95QJTg4A828UH8LzEi+m1LxZh4GUY81aicRc+DDMcttF0OL5
         fAodWDybMmCbv20vJjuECJa8MJ+dv7XfiGcWdykqWfCFpf45QehL1x/5x41Jrik5/t
         fKoG3ngbWAqiJAwosETuC2b1VN+5qK46K4FJv1mFxDkE5NdV9TB/G/ldJzNrWpAW1J
         V+U568kVSK25xuf234spYraLI6PsXvo4e6RMG08zTYNgEGxcr+z4b5MhV54gUpUd+3
         Kwr8w+Gi25juh2DJO6DEzLlOM9XPd7Pmrv259FHto/9e8FECHx9aDcCyaYPoWExhWG
         lQjn2KelWBoUw==
Message-ID: <bcd8ea86-3f16-5feb-68b2-75cd978df6b3@kernel.org>
Date:   Fri, 2 Jun 2023 21:15:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 9/9] MAINTAINERS: Add PCI MHI endpoint function driver
 under MHI bus
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
 <20230602114756.36586-10-manivannan.sadhasivam@linaro.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230602114756.36586-10-manivannan.sadhasivam@linaro.org>
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

On 6/2/23 20:47, Manivannan Sadhasivam wrote:
> Add PCI endpoint driver for MHI bus under the MHI bus entry in MAINTAINERS
> file.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

