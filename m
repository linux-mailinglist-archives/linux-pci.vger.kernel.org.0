Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C0C484648
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 17:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbiADQz2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 11:55:28 -0500
Received: from ale.deltatee.com ([204.191.154.188]:47998 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbiADQz2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jan 2022 11:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=pajr8S+kOElBatJVBGkSwTPVIEL5NUUrsdBQOsrI4Lk=; b=E6bAFvkFZxugoYVp7zb0rDa5Mv
        QEdvJ+Vo++Du+tctufAoDyfbV8/EcRpQpk08pzZUDYgpqJgdCUZAt6fv3+/XHR12Tv5wWFGyGi6dd
        3fv3JrDshD1lK15nAnHzB29pvMAwG8T8R24PhieAvNk0CFYYy46qKe9brOUrB846Jqnqz00TWS6j8
        LmvC2JndaFxLuOvaK54nNYN/GPSAzxgWxfvQXc9FWhomvoPyfIAhKz74kWU0IEY7Yz4e4i+c5/Jg0
        i6vCHsdpBEa1/Aa49IPZv6eydkgrxYs63q2ym1tKUxoJCZIpTrsx4d4GWzDB8sYt1GeXYJ/gIQDHS
        Q6PFCYKA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1n4n5m-0044lM-MC; Tue, 04 Jan 2022 09:55:23 -0700
To:     Kelvin Cao <kelvin.cao@microchip.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     kelvincao@outlook.com, Jeremy Pallotta <jmpallotta@gmail.com>
References: <20211224012334.89173-1-kelvin.cao@microchip.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <91ece4bb-5ab3-4ec9-acb0-0b054d4ec435@deltatee.com>
Date:   Tue, 4 Jan 2022 09:55:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211224012334.89173-1-kelvin.cao@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: jmpallotta@gmail.com, kelvincao@outlook.com, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, kurt.schwemmer@microsemi.com, kelvin.cao@microchip.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 0/6] Switchtec NTB Fixes and Improvements
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-12-23 6:23 p.m., Kelvin Cao wrote:
> Hi,
> 
> Please find a bunch of patches for the Switchtec NTB driver.
> 
> Patche 1, 2 and 6 fix three minor bugs. Patch 3 works around a minor
> firmware issue. Patch 4 updates the method of getting management VEP
> instance ID based on a new firmware change. Patch 5 removes code that
> disables ID protection to avoid conflict with static Switchtec config
> settings.
> 
> This patchset is based on 5.16.0-rc5.
> 
> Thanks,
> Kelvin
> 
> Jeremy Pallotta (2):
>   ntb_hw_switchtec: Fix pff ioread to read into mmio_part_cfg_all
>   ntb_hw_switchtec: AND with the part_map for a valid tpart_vec
> 
> Kelvin Cao (3):
>   ntb_hw_switchtec: Update the way of getting VEP instance ID
>   ntb_hw_switchtec: Remove code for disabling ID protection
>   ntb_hw_switchtec: Fix a minor issue in config_req_id_table()
> 
> Wesley Sheng (1):
>   ntb_hw_switchtec: Fix bug with more than 32 partitions

I've reviewed all these patches and they look good to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
