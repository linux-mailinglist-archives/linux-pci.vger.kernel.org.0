Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08CB71F675
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 01:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjFAXTD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 19:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFAXTD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 19:19:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6D4136;
        Thu,  1 Jun 2023 16:19:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA16864AB6;
        Thu,  1 Jun 2023 23:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503DAC433EF;
        Thu,  1 Jun 2023 23:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685661540;
        bh=l1ucpsdJie8Q+wDscNYyAkC+XvWBk1qhZVUjoE0kcaQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QBMXOFHB/rkoef+74ZA211FIUQ0gMWIuzkFG9dOocjUnjzByFKRUhaaHc86HBjxOj
         X11eUO8qWThIXA4s2X0qTzFlQaTRnNBOeTHqAb4iEhf4nm/ERFCr2d7pQmFLZOjH1v
         goII6VhAA6E674lAJt0K4LI8VZwC8ewvvrMXngPwyC2IlLcYNO6L2umeZaVhvSfwCF
         WVikhLMCf0KjrOJejxcFPgjbDOpVR+Okpvndstw3YnD2WlowaH0qV/dxycYUPn1Ywu
         tDB4yGfp8ckNhkdwA+IJP9KVBhjI9Yt3SotI+H/0DPUFIJAfBpd7Gq4I3g53FNcaI2
         Y1C6GTVkblX/g==
Message-ID: <c691d9bd-9596-373e-0abe-2e776eb0d54b@kernel.org>
Date:   Fri, 2 Jun 2023 08:18:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 4/9] PCI: endpoint: Warn and return if EPC is
 started/stopped multiple times
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230601145718.12204-1-manivannan.sadhasivam@linaro.org>
 <20230601145718.12204-5-manivannan.sadhasivam@linaro.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230601145718.12204-5-manivannan.sadhasivam@linaro.org>
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
> When the EPC is started or stopped multiple times from configfs, just emit
> a once time warning and return. There is no need to call the EPC start/stop
> functions in those cases.
> 
> Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/endpoint/pci-ep-cfs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index 4b8ac0ac84d5..62c8e09c59f4 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -178,6 +178,9 @@ static ssize_t pci_epc_start_store(struct config_item *item, const char *page,
>  	if (kstrtobool(page, &start) < 0)
>  		return -EINVAL;
>  
> +	if (WARN_ON_ONCE(start == epc_group->start))
> +		return 0;

WARN will dump a backtrace which is fairly scary for the user. This case is
simply a bad user manipulation of the device, so why not simply add a pr_err()
(optional) and return -EALREADY ?

> +
>  	if (!start) {
>  		pci_epc_stop(epc);
>  		epc_group->start = 0;

-- 
Damien Le Moal
Western Digital Research

