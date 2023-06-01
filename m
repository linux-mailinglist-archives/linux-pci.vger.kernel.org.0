Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F8E71F666
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 01:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjFAXMN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 19:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjFAXMM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 19:12:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E961113E;
        Thu,  1 Jun 2023 16:12:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07F0764A9D;
        Thu,  1 Jun 2023 23:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84799C433EF;
        Thu,  1 Jun 2023 23:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685661126;
        bh=4I2XX3D8El+lt+ER26Q2EW58g+AOstzpVwI+h3F2lvc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LdBOkWe+XlW73pkWpU/zC0DwkN7/Ic05Hs0eW5ua1d1xuCbrKhBJxm9QR1SgQRnSN
         m+WYHl37ZIrfKDwqOy5iJI+FzdVEE6sL/C+PWu+aDk5fwqILE8SRbS8K9Hd1VFxFEd
         WlBo6ITgaCX4LY3OWex1du8ew0voWgS/RaWap1L27EI3ZMaQrc3/DbtRXrdAoHEgk3
         KUgjeligawpCwekWD1ejhl9JRdsu9fngAEY5j1/S/41XBapOG8aKaC/s6hqT8gOgzi
         zS6Evps17E6qi0PM2LTFKnV8Dfi8kbTtgdGKCva3IXbkTZOYV2Gj2gb5xCx48o/4Jv
         t6ZhDH0mSKyuw==
Message-ID: <027026e0-9388-c5c6-1076-3c683e7b782c@kernel.org>
Date:   Fri, 2 Jun 2023 08:12:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 2/9] PCI: endpoint: Add missing documentation about the
 MSI/MSI-X range
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230601145718.12204-1-manivannan.sadhasivam@linaro.org>
 <20230601145718.12204-3-manivannan.sadhasivam@linaro.org>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230601145718.12204-3-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/1/23 23:57, Manivannan Sadhasivam wrote:
> Both pci_epc_raise_irq() and pci_epc_map_msi_irq() APIs expects the
> MSI/MSI-X vectors to start from 1 but it is not documented. Add the
> range info to the kdoc of the APIs to make it clear.
> 
> Fixes: 5e8cb4033807 ("PCI: endpoint: Add EP core layer to enable EP controller and EP functions")
> Fixes: 87d5972e476f ("PCI: endpoint: Add pci_epc_ops to map MSI IRQ")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

