Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285284AB9D7
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 12:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbiBGLJK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 06:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbiBGLDc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 06:03:32 -0500
X-Greylist: delayed 343 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 03:03:31 PST
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id D8591C043188
        for <linux-pci@vger.kernel.org>; Mon,  7 Feb 2022 03:03:31 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1644231811; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=0xBNTcGBAXWcoRI0B3peXkvckCYdilz2Av3IPGdz/44=;
 b=BxANQuNqiyPn5kLr1Tcrv6IlsW8q3jV3zrwl+Ay6+5/WV12fYRjnoD76mjwA4/j+G6oP0zVK
 40PGuMIH61zaOAUIfDQZMz0/PML+MsAKAga+fCe0cCr2pt/IXrhjOIPxJ4bxsbOZ9eQ1oNNh
 WKkBqJ6bIGsIx0RrvY6B23fUNqg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6200fb2ae5522b2a16f46960 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 07 Feb 2022 10:57:46
 GMT
Sender: nitirawa=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D0836C4361A; Mon,  7 Feb 2022 10:57:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: nitirawa)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E3C35C43616;
        Mon,  7 Feb 2022 10:57:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 07 Feb 2022 16:27:44 +0530
From:   nitirawa@codeaurora.org
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Keith Busch <kbusch@kernel.org>, rafael.j.wysocki@intel.com,
        hch@lst.de, bhelgaas@google.com, mmaddireddy@nvidia.com,
        kthota@nvidia.com, sagar.tv@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Query related to shutting down NVMe during system suspend
In-Reply-To: <0bd9fdc1-99d4-1c59-7343-3708b331b2b5@nvidia.com>
References: <65b836cd-8d5d-b9c2-eb8f-2ee3ef46112b@nvidia.com>
 <20220201163054.GA2838889@dhcp-10-100-145-180.wdc.com>
 <0bd9fdc1-99d4-1c59-7343-3708b331b2b5@nvidia.com>
Message-ID: <24710253b2e34dfdd81ebe1f46b84652@codeaurora.org>
X-Sender: nitirawa@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-02-01 22:28, Vidya Sagar wrote:
> Thanks for the super quick reply and I couldn't agree more.
> 
> On 2/1/2022 10:00 PM, Keith Busch wrote:
>> External email: Use caution opening links or attachments
>> 
>> 
>> On Tue, Feb 01, 2022 at 09:52:28PM +0530, Vidya Sagar wrote:
>>> Hi Rafael & Christoph,
>>> My query is regarding the comment and the code that follows after it 
>>> at
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/pci.c?h=v5.17-rc2#n3243
>>> What I understood from it is that, there is an underlying assumption
>>> that the power to the devices is not removed during the suspend call.
>>> In the case of device-tree based platforms like Tegra194, power is
>>> indeed removed to the devices during suspend-resume process. Hence, 
>>> the
>>> NVMe devices need to be taken through the shutdown path irrespective 
>>> of
>>> whether the ASPM states are enabled or not.
>>> I would like to hear from you the best method to follow to achieve 
>>> this.
>> 
>> Since platform makers can't converge on how to let a driver know what
>> it's supposed to do, I suggest we default to the simple shutdown 
>> suspend
>> all the time. We can add a module parameter to let a user request nvme
>> power management if they really want it. No matter what we do here,
>> someone is going to complain, but at least simple shutdown is safe...
>> 

Hi Vidya,

Are you planning to add module parameter based on above discussion. I 
see similar behaviour even with  qualcomm platform.

[  119.994092] nvme nvme0: I/O 9 QID 0 timeout, reset controller
[  120.006612] PM: dpm_run_callback(): pci_pm_resume+0x0/0xe4 returns 
-16
[  120.013502] nvme 0001:01:00.0: PM: pci_pm_resume+0x0/0xe4 returned 
-16 after 60059958 usecs
[  120.022239] nvme 0001:01:00.0: PM: failed to resume async: error -16

Regards,
Nitin


