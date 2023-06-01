Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBA671F686
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 01:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjFAXWk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 19:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbjFAXWj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 19:22:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2C41A2;
        Thu,  1 Jun 2023 16:22:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79A8364ACC;
        Thu,  1 Jun 2023 23:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016B2C433D2;
        Thu,  1 Jun 2023 23:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685661756;
        bh=9e0iYZkuy2NCf8lU659KBVORM2Sarkv9Mn3bijIL9lY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dfqbb/l4wBxR4k37x3P1yXbWQcIO1yaaB1oATATWqI+fvPlB3DpfC5zFmqKZQILXg
         lC47xr4UQ3zzzD0bYZnMwRmhYQo2HJr3z1SHi7Cbh2UHeLOX0/uaLrhM6X4bNebRzp
         /cOj5Mz8teeE8qGu3wX2kyFL/pUmUTBWrF838av/O5y3+cyIyorsi/DqLqVG+KlvmR
         1POnuBWxq8d0nKr/ppKpAew0SHSvnfb9ZrvLzwa+51n3ZEVGsgn58/mCWh+Qz2Iydb
         DRNixO4RTHF9aeUSgELrqxVBWLfna/wPi3excdJ7kvdPytw3F1mWU7mEXnADhLtMuj
         kKGCvK2KYrEFA==
Message-ID: <79300861-2294-e82e-e6bb-5bcbd245ea25@kernel.org>
Date:   Fri, 2 Jun 2023 08:22:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 8/9] PCI: qcom-ep: Add support for BME notification
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230601145718.12204-1-manivannan.sadhasivam@linaro.org>
 <20230601145718.12204-9-manivannan.sadhasivam@linaro.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230601145718.12204-9-manivannan.sadhasivam@linaro.org>
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
> Add support to pass BME (Bus Master Enable) notification to Endpoint
> function driver so that the BME event can be processed by the function.
> 
> Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

