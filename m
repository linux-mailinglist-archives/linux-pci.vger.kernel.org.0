Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D168E4AFF1C
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 22:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiBIVRr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 16:17:47 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiBIVRr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 16:17:47 -0500
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id B4452C014F32
        for <linux-pci@vger.kernel.org>; Wed,  9 Feb 2022 13:17:49 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1644441469; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=l9IB4Qa+LqQHeEdS9Xvem4BknbivZ/qkp2XXwLsm5wQ=;
 b=sg8sl8dB8ru4OuY428fsvNKoEkwCxjROqMq+LJ2/8bJGeWinf8uHU+KGI/d+ntpft4V/kQM3
 IGbPpeKKCgKWD2SKDHLeBATomznOrt6RNe+uV3FEsFLvxUw2oxm/SDT5J53Xt5LG/YykqBcF
 5JFDEpyuFqCoNHLt/ezDRTjOX1s=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 62042f7c19d16b66a9d67c6f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 09 Feb 2022 21:17:48
 GMT
Sender: nitirawa=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DD1FBC4360C; Wed,  9 Feb 2022 21:17:47 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F84CC4338F;
        Wed,  9 Feb 2022 21:17:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Feb 2022 02:47:47 +0530
From:   nitirawa@codeaurora.org
To:     Keith Busch <kbusch@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>, rafael.j.wysocki@intel.com,
        keith.busch@intel.com, hch@lst.de, bhelgaas@google.com,
        mmaddireddy@nvidia.com, kthota@nvidia.com, sagar.tv@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Query related to shutting down NVMe during system suspend
In-Reply-To: <20220209202639.GB1616420@dhcp-10-100-145-180.wdc.com>
References: <65b836cd-8d5d-b9c2-eb8f-2ee3ef46112b@nvidia.com>
 <20220209202639.GB1616420@dhcp-10-100-145-180.wdc.com>
Message-ID: <bc80ec7d1ca2c56feded1a6848c285ef@codeaurora.org>
X-Sender: nitirawa@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-02-10 01:56, Keith Busch wrote:
> On Tue, Feb 01, 2022 at 09:52:28PM +0530, Vidya Sagar wrote:
>> Hi Rafael & Christoph,
>> My query is regarding the comment and the code that follows after it 
>> at
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/pci.c?h=v5.17-rc2#n3243
>> What I understood from it is that, there is an underlying assumption
>> that the power to the devices is not removed during the suspend call.
>> In the case of device-tree based platforms like Tegra194, power is
>> indeed removed to the devices during suspend-resume process. Hence, 
>> the
>> NVMe devices need to be taken through the shutdown path irrespective 
>> of
>> whether the ASPM states are enabled or not.
>> I would like to hear from you the best method to follow to achieve 
>> this.
> 
> Christoph prefers to append quirks for platforms that need full device
> shutdown on s2idle instead of changing the driver default.
> 
> We use dmi matching for our current platform quirk list. I do not know
> what the equivalent is for device-tree based platforms. Do you know?

Hi Keith,

IMO, the NVME driver is not associated with any device tree, Instead PCI 
driver is associated with device tree.
So unlike ACPI based platform where we have platform specific DMI 
matching, we don't have equivalent check for DT based platform.

Do we see any concern if we introduce a module param with default not 
set to quick suspend.
For platform that need full shutdown durring resume , they can set it to 
quick suspend.
