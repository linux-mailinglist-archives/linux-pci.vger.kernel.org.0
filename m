Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9414D42DB
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 09:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbiCJIwY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 03:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiCJIwX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 03:52:23 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F33137582
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 00:51:22 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KDjTh6gGcz9sRr;
        Thu, 10 Mar 2022 09:51:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KN9tQPs5Z3VJ; Thu, 10 Mar 2022 09:51:20 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KDjTX53tRz9sS1;
        Thu, 10 Mar 2022 09:51:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9CB5C8B780;
        Thu, 10 Mar 2022 09:51:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9ky5aI1uLoWU; Thu, 10 Mar 2022 09:51:12 +0100 (CET)
Received: from [192.168.202.40] (unknown [192.168.202.40])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 15CFE8B763;
        Thu, 10 Mar 2022 09:51:12 +0100 (CET)
Message-ID: <f55dba9c-f00f-3aa9-d84d-1cda2b660dcb@csgroup.eu>
Date:   Thu, 10 Mar 2022 09:51:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] powerpc/eeh: Use pcie_reset_state_t type in function
 arguments
Content-Language: fr-FR
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Oliver O'Halloran <oohall@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
References: <20210713002525.203840-1-kw@linux.com>
 <20210713002525.203840-2-kw@linux.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20210713002525.203840-2-kw@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



Le 13/07/2021 à 02:25, Krzysztof Wilczyński a écrit :
> The pcie_reset_state_t type has been introduced in the commit
> f7bdd12d234d ("pci: New PCI-E reset API") along with the enum
> pcie_reset_state, but it has never been used for anything else
> other than to define the members of the enumeration set in the
> enum pcie_reset_state.
> 
> Thus, replace the direct use of enum pcie_reset_state in function
> arguments and replace it with pcie_reset_state_t type so that the
> argument type matches the type used in enum pcie_reset_state.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

I don't understand the purpose of this change. Does any tool like sparse 
of so reports an error here ?

My feeling is that by doing this you loose the added value of using an 
enumerate.

state is used in a switch/case, that's exactly what we expect from an enum.

By the way, I think you can't change the prototype of a weak function in 
a patch and not change it at the same time for the overloading function.

So should you still think this change is necessary, I think patch 1 and 
2 should be squashed together in one.

Christophe


> ---
>   arch/powerpc/kernel/eeh.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 3bbdcc86d01b..15485abb89ff 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -714,7 +714,7 @@ static void eeh_restore_dev_state(struct eeh_dev *edev, void *userdata)
>    * Return value:
>    * 	0 if success
>    */
> -int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
> +int pcibios_set_pcie_reset_state(struct pci_dev *dev, pcie_reset_state_t state)
>   {
>   	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
>   	struct eeh_pe *pe = eeh_dev_to_pe(edev);
