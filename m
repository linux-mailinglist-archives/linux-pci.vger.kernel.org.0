Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D7876F65E
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 02:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjHDAFF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 20:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjHDAFF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 20:05:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EDB2684
        for <linux-pci@vger.kernel.org>; Thu,  3 Aug 2023 17:05:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15A2F60AF6
        for <linux-pci@vger.kernel.org>; Fri,  4 Aug 2023 00:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A697C433C8;
        Fri,  4 Aug 2023 00:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691107503;
        bh=1i/YwON6CAiqHJjjFE0KJ+tTVcACMwg4eDUcJ3eIbn8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Y7h1LWfLd0mhprNBw1Zhylc0QXGFpTdfkD0Gnx9NEOIc3y5mJVUm5ouiEhRgZMO8l
         qsD6f0ZW3naoNx9vW0uLtVn/Z4kIvoByK7XECNKq/euDGywZJYmZ0CgIofobtVZLfN
         duR6Uo+zC0Om5c/KdwP63AnC8SeoSZcWxTDmZbiA2zstsVeuM858E2V8BasaFqnO0Y
         v4WBPTmhCWytpEQhOJTrHSsDsQEus3SrLnvzgjOrr95Zw5nCoWUO3Qkvwv8SL8ysNT
         0W1dMkyFOI4buqk0keThfNteO7H81QrsYN3qxAJygwvBCqDn7TG5CR9gY8f4wHecDi
         beBu8omcYhzhA==
Message-ID: <4040ec8e-9713-6257-980a-d94a461b0342@kernel.org>
Date:   Fri, 4 Aug 2023 09:05:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/2] PCI: endpoint: Drop PCI_EPC_IRQ_XXX definitions
To:     Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20230802094036.1052472-1-dlemoal@kernel.org>
 <20230802094036.1052472-3-dlemoal@kernel.org>
 <20230803110410.GB7313@thinkpad>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230803110410.GB7313@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/3/23 20:04, Manivannan Sadhasivami wrote:
> On Wed, Aug 02, 2023 at 06:40:36PM +0900, Damien Le Moal wrote:
>> linux/pci.h defines the IRQ flags PCI_IRQ_INTX, PCI_IRQ_MSI and
>> PCI_IRQ_MSIX. Let's use these flags directly instead of the endpoint
>> definitions provided by enum pci_epc_irq_type. This removes the need
>> for defining this enum type completely.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> 
> "legacy" is still being mentioned in a lot of places (comments, function names).
> So we need one more cleanup patch later (not now).

Yes indeed. I will try to send a larger series later to address pci controller
drivers and epf drivers. Busy with debugging on fs and ata side at the moment.

-- 
Damien Le Moal
Western Digital Research

