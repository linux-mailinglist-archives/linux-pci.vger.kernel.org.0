Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC7D71F67E
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 01:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjFAXVT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 19:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjFAXVQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 19:21:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E8999;
        Thu,  1 Jun 2023 16:21:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46CA3647BA;
        Thu,  1 Jun 2023 23:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EDEC433D2;
        Thu,  1 Jun 2023 23:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685661674;
        bh=l02ZVtU/2fgVSa70cp6ync8h1XVc2Ei/Lt1cVmip4MI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AB8H/TqknRUyTy/bl1nZZHFReLeluf7NqVnYrjSlgTXVGNISPapMd87H2ga8D4pky
         9njbBvTToJDY+plyiJSeeNqVRSQJEjE7qQdzF1FCvwQ777hdVDeaIZWDq4UT9kteJN
         Dtr+XTP+hJVoM0hHBrVzkGPk3ltNJJIQslUS4MhgannojVTzqc7Wayu56N9s3JOwB0
         mRN26rS6Os24e2g3UPsCLIyEabZYUrHM8ZgKMc4KYtnEE7xzrsvYA6cbTHTwlI8WLO
         8r2jKMuzr7V3k5mO0hu6qnjNIJBoJJWq7Ryd5rPcnJtcCujgKaLSrj1y9LRDealQU6
         MjC4DtZP+W+uA==
Message-ID: <63e31b61-5810-9771-0505-084b5889cc04@kernel.org>
Date:   Fri, 2 Jun 2023 08:21:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 6/9] PCI: endpoint: Add BME notifier support
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230601145718.12204-1-manivannan.sadhasivam@linaro.org>
 <20230601145718.12204-7-manivannan.sadhasivam@linaro.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230601145718.12204-7-manivannan.sadhasivam@linaro.org>
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
> Add support to notify the EPF device about the Bus Master Enable (BME)
> event received by the EPC device from the Root complex.
> 
> Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

