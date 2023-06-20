Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8DB73627C
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 06:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjFTEEt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 00:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjFTEEs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 00:04:48 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFCA91B4;
        Mon, 19 Jun 2023 21:04:44 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:49958.1971516777
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 06F28102981;
        Tue, 20 Jun 2023 12:04:41 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-xp9j7 with ESMTP id df9f5ca2ac8444ec9924a0b73831df1d for helgaas@kernel.org;
        Tue, 20 Jun 2023 12:04:44 CST
X-Transaction-ID: df9f5ca2ac8444ec9924a0b73831df1d
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <459cf0c7-4111-6e76-8124-da1a10666f50@189.cn>
Date:   Tue, 20 Jun 2023 12:04:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] PCI: Add dummy implement for pci_clear_master()
 function
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ben Hutchings <bhutchings@solarflare.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        kernel test robot <lkp@intel.com>, Li Yi <liyi@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        loongson-kernel@lists.loongnix.cn,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pci@vger.kernel.org
References: <ZHeL3WsalhsIMYwa@bhelgaas>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <ZHeL3WsalhsIMYwa@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Dear Bjorn


Where is the formal(unstream) PCI git branch where we could see the 
latest patch ?


On 2023/6/1 02:03, Bjorn Helgaas wrote:
> On Thu, Jun 01, 2023 at 01:44:52AM +0800, Sui Jingfeng wrote:
>> Can you receive my email?
>>
>> I reply several email to you, but Thunderbird told me that may mail is
>> returned.
>>
>> Maybe you could read the content at lore.
> I do receive your email (at least some; obviously if there are things
> I don't receive I wouldn't know).  I read most Linux email via lei [1],
> so if it shows up on lore, I should see it.
>
> Bjorn
>
> [1] https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started

Thanks for the link.

