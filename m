Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4689045736A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 17:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbhKSQwp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 11:52:45 -0500
Received: from ale.deltatee.com ([204.191.154.188]:34892 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhKSQwo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 11:52:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=j8F+VN+Ak51Mv+10Ri36XJi9T0mvaMt3o2cpiS6nRq8=; b=A0P4McfBDINZAcnoeLBxzc4BE+
        Re2Ot7Uikg7t/3O+mCMh2vgTEg8iYROfMCjLJuu5cwlK2+XMGk7UTDDLNRj9nTkGaMndH0D4Bg8PT
        B/pj18YJxttcqVgvtTKiEAmNPd5OO+lk31vKnDpGhCVr9E4ijnz/TYbXOJJiMp/Wq6ZzTXpdsWsQP
        zbV6lg/I6tn3kuucSNdg3AB/GF7FAe8l62/1Jicnb2rAcbdAygxTwRV7kfL/pzhey1wxLUJMIwSVr
        iQMNjjPDWNLn6JLcUTVUl8jCdEwqrmBEIKhLbCHcQBPYVI86NuoObD9JPm6lxS7bl7avwmERRCY1p
        AndXa5Vg==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1mo752-002CkS-KD; Fri, 19 Nov 2021 09:49:41 -0700
To:     Kelvin Cao <kelvin.cao@microchip.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kelvincao@outlook.com
References: <20211119003803.2333-1-kelvin.cao@microchip.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <cf1bc79c-718c-ce23-fae8-178d0f545901@deltatee.com>
Date:   Fri, 19 Nov 2021 09:49:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211119003803.2333-1-kelvin.cao@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: kelvincao@outlook.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, kw@linux.com, bhelgaas@google.com, kurt.schwemmer@microsemi.com, kelvin.cao@microchip.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 0/2] Add Switchtec Gen4 automotive device IDs and a tweak
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-11-18 5:38 p.m., Kelvin Cao wrote:
> Hi,
> 
> This patchset introduces device IDs for the Switchtec Gen4 automotive
> variants and a minor tweak for the MRPC execution.
> 
> The first patch adds the device IDs. Patch 2 makes the tweak to improve
> the MRPC execution efficiency [1].
> 
> This patchset is based on v5.16-rc1.
> 
> [1] https://lore.kernel.org/r/20211014141859.11444-1-kelvin.cao@microchip.com/
> 
> Thanks,
> Kelvin
> 
> Kelvin Cao (2):
>   Add device IDs for the Gen4 automotive variants
>   Declare local array state_names as static
> 
>  drivers/pci/quirks.c           |  9 +++++++++
>  drivers/pci/switch/switchtec.c | 11 ++++++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)

Looks fine to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan
