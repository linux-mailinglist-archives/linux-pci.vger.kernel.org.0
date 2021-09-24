Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0037B417808
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 17:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhIXPzD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 11:55:03 -0400
Received: from ale.deltatee.com ([204.191.154.188]:53020 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbhIXPzD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Sep 2021 11:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=tAgQKd+z6vxXxFs5ulgzOt5cmHdcRxTc9c4Q2BUTN1Y=; b=tlOK9L0rG+fTlPqVqnwykYitCN
        dY9kNPdfoSudMSZQ8hUgbAIN0UHkaoAHTJRFYKDrnXk0iV6BHGDmlBrXijq1U11dgI0z762tlItbG
        FcgGRDM4jbiUb8emw1Tn9GTEXZNJPQgEusc7vif2WsPZBsCPObLlQPG/izr8/z7u6p2uvt27/3qVB
        wItHDZmyeJw6NQTjgSUir6CoLo5dnIfej7JOCtFNzbcLMe7qyLxwnzc+2nBng9DN3sjNdHZCsTTSI
        p03YwaZCZ2BTKP8Poj5PdrEo5B2NUH+yP7iO7LRL6LNu/cGlWIPXu/e6jlMlZjcsu23Fepx1f5/H/
        ic8N/Iig==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1mTnVw-0003GP-DX; Fri, 24 Sep 2021 09:53:29 -0600
To:     kelvin.cao@microchip.com, kurt.schwemmer@microsemi.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kelvincao@outlook.com
References: <20210924110842.6323-1-kelvin.cao@microchip.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b4908c93-fb43-001b-b3eb-d3da0bb377c9@deltatee.com>
Date:   Fri, 24 Sep 2021 09:53:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210924110842.6323-1-kelvin.cao@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: kelvincao@outlook.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, kurt.schwemmer@microsemi.com, kelvin.cao@microchip.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 0/5] Switchtec Fixes and Improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-09-24 5:08 a.m., kelvin.cao@microchip.com wrote:
> From: Kelvin Cao <kelvin.cao@microchip.com>
> 
> Hi,
> 
> Please find a bunch of patches for the switchtec driver collected over the
> last few months.
> 
> The first 2 patches fix two minor bugs. Patch 3 updates the method of
> getting management VEP instance ID based on a new firmware change. Patch
> 4 replaces ENOTSUPP with EOPNOTSUPP to follow the preference of kernel.
> And the last patch adds check of event support to align with new firmware
> implementation.
> 
> This patchset is based on v5.15-rc2.
> 
> Thanks,
> Kelvin
> 
> Kelvin Cao (4):
>   PCI/switchtec: Error out MRPC execution when no GAS access
>   PCI/switchtec: Fix a MRPC error status handling issue
>   PCI/switchtec: Update the way of getting management VEP instance ID
>   PCI/switchtec: Replace ENOTSUPP with EOPNOTSUPP
> 
> Logan Gunthorpe (1):
>   PCI/switchtec: Add check of event support
> 
>  drivers/pci/switch/switchtec.c | 87 +++++++++++++++++++++++++++-------
>  include/linux/switchtec.h      |  1 +
>  2 files changed, 71 insertions(+), 17 deletions(-)

Thanks Kelvin! This all looks good to me.

For the entire series (except the last patch which I wrote):

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan
