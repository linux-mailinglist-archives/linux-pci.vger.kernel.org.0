Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD362736B19
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 13:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjFTLhd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 07:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjFTLhc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 07:37:32 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 694E4A1;
        Tue, 20 Jun 2023 04:37:30 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.41:45814.2105340369
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id E8F2E1001DC;
        Tue, 20 Jun 2023 19:37:27 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-xwndj with ESMTP id 5498305f1b5f4862ab1283f4a352009b for helgaas@kernel.org;
        Tue, 20 Jun 2023 19:37:28 CST
X-Transaction-ID: 5498305f1b5f4862ab1283f4a352009b
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <43794f47-bb96-071a-fa18-80283e2721fe@189.cn>
Date:   Tue, 20 Jun 2023 19:37:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] PCI: Add dummy implement for pci_clear_master()
 function
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
References: <20230620110600.GA40675@bhelgaas>
Content-Language: en-US
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <20230620110600.GA40675@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2023/6/20 19:06, Bjorn Helgaas wrote:
> On Tue, Jun 20, 2023 at 12:04:40PM +0800, Sui Jingfeng wrote:
>> Where is the formal(unstream) PCI git branch where we could see the latest
>> patch ?
> Here's the "misc" branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=misc
>
> And here's the "next" branch that will be merged for v6.5, which
> includes "misc" and other things: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=next


Thanks for you kindness reply and guidance, now I know that.

