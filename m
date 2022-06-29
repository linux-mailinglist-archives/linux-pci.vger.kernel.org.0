Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA5C5609C6
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 20:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiF2Sve (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 14:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiF2Svb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 14:51:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD6E1C939;
        Wed, 29 Jun 2022 11:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=SQbCDug6YtBQhXuY1RjXAElJtdb8hCK+VaT6mCPo/no=; b=v7yL2mxNkLU/Gt4cBbL2jufr1v
        yWpq+SQgz2xlqUNcmjucMWcrKHDBcWBNVPhRkIzXQ7AJEunx+lr26EbYdblJq58upDEJ4jqQKkBrw
        NGP+vhdjXfTc7fP77eHC7PUHjIUrOpCQNA4q5S/yyu9wt96AbtixdCw93jAUQhAULJXP/iY92cEAz
        oq5yx63WW2HmtfKZJKQ/ncPryVaENkBwQzr+FIU36I/b/vOhg2qZtOnsB6Xi4ncA7lOx34yTuZj7e
        o1ROLtc0bx+2OtR58VnsF5wkZ22TvaeJRo3sKlw7IWRGxjyn6EKxlVtEzgdoeft6kxXswo6gqgR6t
        OjVIWGsw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o6cmW-00DdkC-Ga; Wed, 29 Jun 2022 18:51:20 +0000
Message-ID: <687deec4-b799-0abc-5cf1-c65021c36ebd@infradead.org>
Date:   Wed, 29 Jun 2022 11:51:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH -next] PCI: endpoint: Fix Kconfig dependency
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Jon Mason <jdmason@kudzu.us>
Cc:     kishon@ti.com, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, Frank.Li@nxp.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220627202528.GA1775049@bhelgaas>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220627202528.GA1775049@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/27/22 13:25, Bjorn Helgaas wrote:
> On Mon, Jun 27, 2022 at 03:07:50PM -0500, Bjorn Helgaas wrote:
>> On Mon, Jun 27, 2022 at 02:57:14PM -0500, Bjorn Helgaas wrote:
>>> On Fri, Jun 24, 2022 at 09:19:11AM +0800, Ren Zhijie wrote:
>>>> If CONFIG_NTB is not set and CONFIG_PCI_EPF_VNTB is y.
>>>>
>>>> make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-, will be failed, like this:
>>>>
>>>> drivers/pci/endpoint/functions/pci-epf-vntb.o: In function `epf_ntb_cmd_handler':
>>>> pci-epf-vntb.c:(.text+0x95e): undefined reference to `ntb_db_event'
>>>> pci-epf-vntb.c:(.text+0xa1f): undefined reference to `ntb_link_event'
>>>> pci-epf-vntb.c:(.text+0xa42): undefined reference to `ntb_link_event'
>>>> drivers/pci/endpoint/functions/pci-epf-vntb.o: In function `pci_vntb_probe':
>>>> pci-epf-vntb.c:(.text+0x1250): undefined reference to `ntb_register_device'
>>>>
>>>> The functions ntb_*() are defined in drivers/ntb/core.c, which need CONFIG_NTB setting y to be build-in.
>>>> To fix this build error, add depends on NTB.
>>>>
>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>> Fixes: ff32fac00d97("NTB: EPF: support NTB transfer between PCI RC and EP connection")
>>>> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
>>>> Acked-by: Frank Li <frank.li@nxp.com>
>>>
>>> Am I missing something? 
>>>
>>>   02:54:01 ~/linux (next)$ git checkout -b wip/ren-endpoint-ntb v5.19-rc1
>>>   Switched to a new branch 'wip/ren-endpoint-ntb'
>>>   02:54:23 ~/linux (wip/ren-endpoint-ntb)$ b4 am -om/ https://lore.kernel.org/r/20220624011911.164146-1-renzhijie2@huawei.com
>>>   02:54:47 ~/linux (wip/ren-endpoint-ntb)$ git am m/20220624_renzhijie2_pci_endpoint_fix_kconfig_dependency.mbx
>>>   Applying: PCI: endpoint: Fix Kconfig dependency
>>>   error: patch failed: drivers/pci/endpoint/functions/Kconfig:29
>>>
>>> Obviously I could fix this manually, but if there's something wrong
>>> with your patch posting process, we should fix it.
>>
>> Oh, I see the problem.  This patch depends on some other VNTB patch
>> that hasn't been merged yet.  That means this fix should be squashed
>> into the VNTB patch that adds "config PCI_EPF_VNTB".
> 
> Well, I saw *part* of the problem.  This fixes something that is in
> -next, added by ff32fac00d97 ("NTB: EPF: support NTB transfer between
> PCI RC and EP connection") [1], which was merged by Jon.
> 
> So I guess Jon will squash and update his branch or merge the
> fixup(s).
> 
> (Jon, if you squash, note there are several typos in the commit log:
> s/Virtual NTB/virtual NTB/, s/include/includes/, s/3 part/3 parts/,
> s/virutal/virtual, s/pci/PCI/, s/BUS/Bus/)
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ff32fac00d97
> 
>>>> ---
>>>> v2: Fix some commit message errors
>>>> ---
>>>>  drivers/pci/endpoint/functions/Kconfig | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
>>>> index 362555b024e8..9beee4f0f4ee 100644
>>>> --- a/drivers/pci/endpoint/functions/Kconfig
>>>> +++ b/drivers/pci/endpoint/functions/Kconfig
>>>> @@ -29,6 +29,7 @@ config PCI_EPF_NTB
>>>>  config PCI_EPF_VNTB
>>>>          tristate "PCI Endpoint NTB driver"
>>>>          depends on PCI_ENDPOINT
>>>> +        depends on NTB
>>>>          select CONFIGFS_FS
>>>>          help
>>>>            Select this configuration option to enable the Non-Transparent
>>>> -- 

Works for me. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

maybe even
Reported-by: Randy Dunlap <rdunlap@infradead.org>
(see https://lore.kernel.org/linux-next/835b844b-9d9d-615c-af11-44154c2a8102@infradead.org/)

-- 
~Randy
