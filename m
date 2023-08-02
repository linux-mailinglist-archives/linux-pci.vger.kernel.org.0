Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7429D76C8FD
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 11:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjHBJIk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 05:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbjHBJIi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 05:08:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A01272A
        for <linux-pci@vger.kernel.org>; Wed,  2 Aug 2023 02:08:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A33CE618A6
        for <linux-pci@vger.kernel.org>; Wed,  2 Aug 2023 09:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34806C433C7;
        Wed,  2 Aug 2023 09:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690967315;
        bh=5VPFlWmvc+x87l5IRrAbeKq5BBhHkFEhZIKiEuDijGE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Uh2nL+8VHk8C50cyx2Yu7hRlNADcHWdGha0rhfBvgjXugM72IMPLQzld9jtRrKHwO
         Wfs2guuvGSneJWLKTe57iJDLQW3A4UOpFWuqLhtXRDaUmWjlIOLtzyh3cqpERTdVGB
         Gb04IzCrKNIJT2gnoFlVR/GNM8A/ujz2RZGZtJnJPBvrVqs+PjawM+882v8xV1YjPx
         BI3pLV0OqpUROhRObW3uLmp1NjcqtV3QpJxNVKTmtHNjUTUbJAzVvkeDKC6/nG5+3w
         EiCp6qibApI1hf5P2qcMFzlKnPsya77lrpRH39SwTxTEmNEtw9vVN8T0QO0Sw/y5i1
         z4z9oTgHlGJLQ==
Message-ID: <960a2cf6-40e8-be30-2131-b6ed16b9dd02@kernel.org>
Date:   Wed, 2 Aug 2023 18:08:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] PCI: endpoint: Drop PCI_EPC_IRQ_XXX definitions
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20230802075944.937619-1-dlemoal@kernel.org>
 <20230802075944.937619-3-dlemoal@kernel.org>
 <glzuz4e633icvodshovwwvepb3vmn4g64kqqfe6ex4jnmw7yql@3qf6fk45nhd6>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <glzuz4e633icvodshovwwvepb3vmn4g64kqqfe6ex4jnmw7yql@3qf6fk45nhd6>
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

On 8/2/23 18:04, Serge Semin wrote:
>> -	case PCI_EPC_IRQ_LEGACY:
>> +	case PCI_IRQ_LEGACY:
> 
> This shifty kiddy slipped in past your catchy eyes.
> 

Arg ! And I did check the patch several times :)
Thanks for catching. Sending v3.


-- 
Damien Le Moal
Western Digital Research

