Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ED276C8E1
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 11:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjHBJAB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 05:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjHBJAB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 05:00:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0280E42
        for <linux-pci@vger.kernel.org>; Wed,  2 Aug 2023 01:59:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 864C7618A9
        for <linux-pci@vger.kernel.org>; Wed,  2 Aug 2023 08:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BE7C433C8;
        Wed,  2 Aug 2023 08:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690966798;
        bh=mFVQbQ0j75lY+QTTJsrOtkl21Nr6O5rN5yMlruufTf0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=u6QrCIXsLcwVnJbB9Fc6gTZ5x3Xq8a8ZpCwbvwZAnzT2dLzbl6BiclfGyqgKPb+Ls
         ma4ZwVDHkzHsXhnww5694E5Dcae3l+VjFBEm9QSKiHw7bTYoQc2lFhbUxekwazC7kh
         VqabBtOqy8eU33V/NoqSWIjbg/Jd8j0gm51ZFEjgPGFb3wGhutjwj/k+Rj3iMbWhbS
         Ti6KdVqpWKiHgyIAtRsWQlxRMd+tSFhoGI/QH6G9n8XQl0vzr1xtqOqxwUjYGhM/Z6
         xvi5YbyMfVqmzgMTo4DlhkYfmO9ulSCIvr9Tca4AqWxw1GcD4/XJQMoMPI6yE2CF69
         gxOA2Eh8KM0Pg==
Message-ID: <96150a2a-4036-f443-352f-8a3f15c3c8f1@kernel.org>
Date:   Wed, 2 Aug 2023 17:59:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] PCI: Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20230802075944.937619-1-dlemoal@kernel.org>
 <20230802075944.937619-2-dlemoal@kernel.org>
 <fsfsdc2m6vf4tukmlzgedygowaji2nuntsy2ahnw3sghokydhu@hr3b2s6fnxtm>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <fsfsdc2m6vf4tukmlzgedygowaji2nuntsy2ahnw3sghokydhu@hr3b2s6fnxtm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/2/23 17:57, Serge Semin wrote:
> On Wed, Aug 02, 2023 at 04:59:43PM +0900, Damien Le Moal wrote:
>> From: Bjorn Helgaas <bhelgaas@google.com>
>>
>> Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX to be more explicit about the type
>> of IRQ being referenced as well as to match the PCI specifications
>> terms. Redefine PCI_IRQ_LEGACY as an alias to PCI_IRQ_INTX to avoid the
>> need for doing the renaming tree-wide. New drivers and new code should
>> now prefer using PCI_IRQ_INTX instead of PCI_IRQ_LEGACY.
>>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> ---
>>  include/linux/pci.h | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 0ff7500772e6..7692d73719e0 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1048,11 +1048,13 @@ enum {
>>  	PCI_SCAN_ALL_PCIE_DEVS	= 0x00000040,	/* Scan all, not just dev 0 */
>>  };
>>  
>> -#define PCI_IRQ_LEGACY		(1 << 0) /* Allow legacy interrupts */
>> +#define PCI_IRQ_INTX		(1 << 0) /* Allow INTx interrupts */
>>  #define PCI_IRQ_MSI		(1 << 1) /* Allow MSI interrupts */
>>  #define PCI_IRQ_MSIX		(1 << 2) /* Allow MSI-X interrupts */
>>  #define PCI_IRQ_AFFINITY	(1 << 3) /* Auto-assign affinity */
>>  
> 
>> +#define PCI_IRQ_LEGACY		PCI_IRQ_INTX	/* prefer PCI_IRQ_INTX */
>> +
> 
> I would have been more strict about using this macro and explicitly
> stated that the macro is deprecated:
> 
> +#define PCI_IRQ_LEGACY		PCI_IRQ_INTX /* Deprecated! Use PCI_IRQ_INTX */
> +

Works for me.

Bjorn, Krzysztof,

Do you want me to resend a v3 or can fix that up when applying ?

> 
> In anyway:
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> 
> -Serge(y)
> 
>>  /* These external functions are only available when PCI support is enabled */
>>  #ifdef CONFIG_PCI
>>  
>> -- 
>> 2.41.0
>>

-- 
Damien Le Moal
Western Digital Research

