Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B315C4AC481
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 16:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385275AbiBGPy3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 10:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379106AbiBGPt5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 10:49:57 -0500
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 07:49:57 PST
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 464AAC0401C1
        for <linux-pci@vger.kernel.org>; Mon,  7 Feb 2022 07:49:57 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1644248997; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=2yxEWoGWybWm+EWzW1VAE3C5MPy0zhkD2Pst4w6ox5s=;
 b=uUBsj8Buc5knfyRS1SUWucuno9OzjOHhkT43b7hgfbcXc5EvKlzs7hLEIjv76qF4WS0+AcWL
 nxhEp+Kk91EKjV0CtmNTosKI8w9GKQDhLxNppuK/qyNJ+uBJ3UQGdR3AXI/JVrmDSZXFhFHR
 JPFJxQDk6cBg270Me2kmo8dueUs=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 62013e7519d16b66a9ea982f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 07 Feb 2022 15:44:53
 GMT
Sender: nitirawa=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9918DC43150; Mon,  7 Feb 2022 15:44:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: nitirawa)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E43E8C43639;
        Mon,  7 Feb 2022 15:44:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 07 Feb 2022 21:14:49 +0530
From:   nitirawa@codeaurora.org
To:     Vidya Sagar <vidyas@nvidia.com>, Keith Busch <kbusch@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>, rafael.j.wysocki@intel.com,
        hch@lst.de, bhelgaas@google.com, mmaddireddy@nvidia.com,
        kthota@nvidia.com, sagar.tv@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Query related to shutting down NVMe during system suspend
In-Reply-To: <cc0b6768-5722-2277-6e51-75baf3311dc5@nvidia.com>
References: <65b836cd-8d5d-b9c2-eb8f-2ee3ef46112b@nvidia.com>
 <20220201163054.GA2838889@dhcp-10-100-145-180.wdc.com>
 <0bd9fdc1-99d4-1c59-7343-3708b331b2b5@nvidia.com>
 <24710253b2e34dfdd81ebe1f46b84652@codeaurora.org>
 <cc0b6768-5722-2277-6e51-75baf3311dc5@nvidia.com>
Message-ID: <c2255367927729ee00c42ae4148c1301@codeaurora.org>
X-Sender: nitirawa@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-02-07 17:41, Vidya Sagar wrote:
> On 2/7/2022 4:27 PM, nitirawa@codeaurora.org wrote:
>> External email: Use caution opening links or attachments
>> 
>> 
>> On 2022-02-01 22:28, Vidya Sagar wrote:
>>> Thanks for the super quick reply and I couldn't agree more.
>>> 
>>> On 2/1/2022 10:00 PM, Keith Busch wrote:
>>>> External email: Use caution opening links or attachments
>>>> 
>>>> 
>>>> On Tue, Feb 01, 2022 at 09:52:28PM +0530, Vidya Sagar wrote:
>>>>> Hi Rafael & Christoph,
>>>>> My query is regarding the comment and the code that follows after 
>>>>> it
>>>>> at
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/pci.c?h=v5.17-rc2#n3243 
>>>>> What I understood from it is that, there is an underlying 
>>>>> assumption
>>>>> that the power to the devices is not removed during the suspend 
>>>>> call.
>>>>> In the case of device-tree based platforms like Tegra194, power is
>>>>> indeed removed to the devices during suspend-resume process. Hence,
>>>>> the
>>>>> NVMe devices need to be taken through the shutdown path 
>>>>> irrespective
>>>>> of
>>>>> whether the ASPM states are enabled or not.
>>>>> I would like to hear from you the best method to follow to achieve
>>>>> this.
>>>> 
>>>> Since platform makers can't converge on how to let a driver know 
>>>> what
>>>> it's supposed to do, I suggest we default to the simple shutdown
>>>> suspend
>>>> all the time. We can add a module parameter to let a user request 
>>>> nvme
>>>> power management if they really want it. No matter what we do here,
>>>> someone is going to complain, but at least simple shutdown is 
>>>> safe...
>>>> 
>> 
>> Hi Vidya,
>> 
>> Are you planning to add module parameter based on above discussion. I
>> see similar behaviour even with  qualcomm platform.
>> 
>> [  119.994092] nvme nvme0: I/O 9 QID 0 timeout, reset controller
>> [  120.006612] PM: dpm_run_callback(): pci_pm_resume+0x0/0xe4 returns
>> -16
>> [  120.013502] nvme 0001:01:00.0: PM: pci_pm_resume+0x0/0xe4 returned
>> -16 after 60059958 usecs
>> [  120.022239] nvme 0001:01:00.0: PM: failed to resume async: error 
>> -16
> Not really.
> Keith Busch has already pushed a patch to fix it in a different way
> and issue is resolved (on Tegra platforms) with that patch.
> https://lore.kernel.org/all/20220201165006.3074615-1-kbusch@kernel.org/
> is that patch.
> 
> Thanks & Regards,
> Vidya Sagar
>> 
>> Regards,
>> Nitin
>> 
>> 

Thanks Vidya for pointing out the patch . This patch worked for us as 
well.
@keith - Please can we get this merged .

Regards,
Nitin
