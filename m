Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C0C4B0D9F
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 13:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241565AbiBJMhB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 07:37:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbiBJMhA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 07:37:00 -0500
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id D828025EE
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 04:37:01 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1644496621; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=VUibi0hgCckN5je/t/ZeyQ477IBxddkvL5uVTzlBSck=;
 b=mnV0PjBsM3ZOUtNy7kZrjOam1FueC6tOjaW5nU5QqPJyzCb1w4jjEktycCDvsbl2EHwwYr9U
 yPj4CZSA29rk6PBV5RG6KCxEtDOdFO9PrAL9C9PxIb778ECk3q4f2difFeOPwQShhPkabGma
 yjN4wW+XeouP21zWzGTBnbT3wvE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 620506ec19d16b66a95b50fc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 10 Feb 2022 12:37:00
 GMT
Sender: nitirawa=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 74726C4360D; Thu, 10 Feb 2022 12:37:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: nitirawa)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EDC77C4338F;
        Thu, 10 Feb 2022 12:36:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Feb 2022 18:06:59 +0530
From:   nitirawa@codeaurora.org
To:     Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>, Keith Busch <kbusch@kernel.org>,
        robh+dt@kernel.org, rafael.j.wysocki@intel.com, hch@lst.de,
        bhelgaas@google.com, mmaddireddy@nvidia.com, kthota@nvidia.com,
        sagar.tv@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Query related to shutting down NVMe during system suspend
In-Reply-To: <20220210054019.GA929@wunner.de>
References: <65b836cd-8d5d-b9c2-eb8f-2ee3ef46112b@nvidia.com>
 <20220209202639.GB1616420@dhcp-10-100-145-180.wdc.com>
 <0801d0ee-1c39-4413-7865-6c1c61e4706e@nvidia.com>
 <20220210054019.GA929@wunner.de>
Message-ID: <65a50f83e87d4cf8b1ac1b740b4fa35b@codeaurora.org>
X-Sender: nitirawa@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-02-10 11:10, Lukas Wunner wrote:
> On Thu, Feb 10, 2022 at 09:41:04AM +0530, Vidya Sagar wrote:
>> On 2/10/2022 1:56 AM, Keith Busch wrote:
>> > Christoph prefers to append quirks for platforms that need full device
>> > shutdown on s2idle instead of changing the driver default.
>> >
>> > We use dmi matching for our current platform quirk list. I do not know
>> > what the equivalent is for device-tree based platforms. Do you know?
>> 
>> I'm afraid I don't.
> 
> of_machine_is_compatible()

Thanks Lukas and keith . Yes it worked using of_machine_is_compatible as 
it checks root node of device tree for a given compatible value.
@keith - I have posted the change using above API to enable nvme quick 
suspend quirks for sc7280 platform. Please can you review it.
