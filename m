Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A397A2D6B
	for <lists+linux-pci@lfdr.de>; Sat, 16 Sep 2023 04:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbjIPCWa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 22:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238659AbjIPCWN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 22:22:13 -0400
Received: from sphereful.davidgow.net (sphereful.davidgow.net [IPv6:2404:9400:4:0:216:3eff:fee2:5328])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB20E6;
        Fri, 15 Sep 2023 19:22:05 -0700 (PDT)
Received: by sphereful.davidgow.net (Postfix, from userid 119)
        id 6B6011D5837; Sat, 16 Sep 2023 10:22:00 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
        s=201606; t=1694830920;
        bh=Hjtk5BbVsm8eL9+VXeOx9qTRndZHLmAyy1xJeOlFiBs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bt0sq8rpKmyJtSfTvpTeQHNuYIr4PwCfKXLf/gJU/KfUHfxeyR+snNUYyHDv7vLKR
         eT1N5OpmQ1dIV7LzG8VuLa/CdzNemLPNKk4SYVZ2O4q6arqU9a7iuhqNsbQ0xeWPUu
         v/imFF9FKEJjPUHYUPYnKI4/QEKdRhloEroYtydKfPq1grdBClolt6fwgXPNMv5ERh
         byeVX5WXPUBFg/684XOXgtuL3rvDvNkCyL6w16BxMQOaOjO47WRckgLaRaDjGPrbzB
         EXSQFfo+b45VS6HiXs1FX39QXH159OyAqwVF/oHhRamBu641xgkBackzQOg3mO3Qx0
         ho36lWsCvtQhQxpe/PgZs9OvyaW9CMTtN5S8o4D2J6SKCXPEa563oOq4SUJIYPFapo
         znPZVdSMEPqvA5AJeQYBDUeFnGjVzwP7N2Q7Z14d2mzeWF1YMatp2OlrXXk3K+k2Xp
         r+FSBJ4gyTp1T2hc+ZcCAFENCicevBXL0FEjEZ1m9AooSvT0LEXZOUwE14ooPeMEiD
         t9kZ065fVa0RxzQqJpDxwl71dxi7fAyya7a2n2nWFIVYIQbucilZaBgcRTHz9ToHOd
         McrQP3Cqg4k7KUOole9pLVKbxSFavmT6oaIhRHSqMkYOKq9BlLrpLt8UIzBZ9ejrqu
         HmUEjHU24QKwxkBCVwPZUWkE=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Received: from [IPV6:2001:8003:8824:9e00::bec] (unknown [IPv6:2001:8003:8824:9e00::bec])
        by sphereful.davidgow.net (Postfix) with ESMTPSA id C55A21D580B;
        Sat, 16 Sep 2023 10:21:57 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
        s=201606; t=1694830917;
        bh=Hjtk5BbVsm8eL9+VXeOx9qTRndZHLmAyy1xJeOlFiBs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d3c1T6dDVieNLo1yeoJaClHy8gD1NTEsUphxaHWqXVNgPzKoEsTeDWecTQ0zSy8B5
         ZLjYFhBEJdf9zNGTjrbzaw4uCg8iAycQuFgIrk21wl1Lvk1QMCezUTVp/B91OGfrfK
         Usew6qzj+mXdiwYKyhl75Kf7yGcbXbTBk8C9YnfF+CmyBS6qRYeNIiQ6Kv5epbPWbt
         Sqb9+tYsnuAAv2h4toCYBoawXbuwHleAtETHixVO5Txk56VcwunisJmg5DdaO8mm7q
         1GWEUeXYRqqGY9yL6uOuRvPlupQaOQI7qCrZJBVTj1OKZSyeESd03jp2tIZ95AldVp
         laxrLuNmlOca8z6lVJ54h2R7vEvCAhm7C/SeWSwWraNM4CcW2051ssb+Yku/xhsi3S
         uPOvHU8WzS9gCvj7tuv1e/y1yVuThPu28x0hlo4+pu0iHpnH3x7XLE7nx+me0zmOK6
         2PFxoKomldV4lMj7Z/J/6NS41RLW6xBJ2uwqOiqi38TrUePzmLcWTnHh1lkb6Rk8zX
         LAQMKmXcoROhzrtKC2bXfPGmURsrthCoSLq3cijcyN1m+uzvJd0W7xmQAcF8mFMHug
         7+JC17Z7LGiXAAY9y6IVMh1CbazdYk4C8P3SFzn0crdk2pJzvQtWX4Q3KWkBP22kIv
         kaNho1Sa5AbfVCLvrtQ9zA68=
Message-ID: <bbe4ae16-86b3-4629-b5e0-c704881fe5cb@davidgow.net>
Date:   Sat, 16 Sep 2023 10:21:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Kernel 6.5.2 Causes Marvell Technology Group 88SE9128 PCIe
 SATA to Constantly Reset
Content-Language: fr
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        patenteng <dimitar@daskalov.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux IDE and libata <linux-ide@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
References: <dacb34e4-ce58-bc0e-8206-672d743a3e34@gmail.com>
 <ZQHRQHAPQdG+Nu1o@x1-carbon>
 <59f6ff78-6b45-465a-bd41-28c7a5d10931@davidgow.net>
 <10f65dfe-5e8a-10ab-4d89-efe693c07caa@kernel.org>
 <658b9285-e030-4987-86a7-57cdb6c7f161@davidgow.net>
 <ZQQa0QRhm1BuI5IT@x1-carbon>
 <49d92af6-4968-4066-b33c-0fd06f8fdf28@davidgow.net>
 <ZQSEXl0GB3iKoqjZ@x1-carbon>
From:   David Gow <david@davidgow.net>
In-Reply-To: <ZQSEXl0GB3iKoqjZ@x1-carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le 2023/09/16 à 0:20, Niklas Cassel a écrit :
> On Fri, Sep 15, 2023 at 08:26:58PM +0800, David Gow wrote:
>> In any case, the bisect is done:
>>
>> 624885209f31eb9985bf51abe204ecbffe2fdeea is the first bad commit
>> commit 624885209f31eb9985bf51abe204ecbffe2fdeea
>> Author: Damien Le Moal <dlemoal@kernel.org>
>> Date:   Thu May 11 03:13:41 2023 +0200
>>
>>      scsi: core: Detect support for command duration limits
>>
>>      Introduce the function scsi_cdl_check() to detect if a device supports
>>      command duration limits (CDL). Support for the READ 16, WRITE 16, READ
>> 32
>>      and WRITE 32 commands are checked using the function
>> scsi_report_opcode()
>>      to probe the rwcdlp and cdlp bits as they indicate the mode page
>> defining
>>      the command duration limits descriptors that apply to the command being
>>      tested.
>>
>>      If any of these commands support CDL, the field cdl_supported of struct
>>      scsi_device is set to 1 to indicate that the device supports CDL.
>>
>>      Support for CDL for a device is advertizes through sysfs using the new
>>      cdl_supported device attribute. This attribute value is 1 for a device
>>      supporting CDL and 0 otherwise.
>>
>>      Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>      Reviewed-by: Hannes Reinecke <hare@suse.de>
>>      Co-developed-by: Niklas Cassel <niklas.cassel@wdc.com>
>>      Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>>      Link: https://lore.kernel.org/r/20230511011356.227789-9-nks@flawful.org
>>      Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
>>
>>   Documentation/ABI/testing/sysfs-block-device |  9 ++++
>>   drivers/scsi/scsi.c                          | 81
>> ++++++++++++++++++++++++++++
>>   drivers/scsi/scsi_scan.c                     |  3 ++
>>   drivers/scsi/scsi_sysfs.c                    |  2 +
>>   include/scsi/scsi_device.h                   |  3 ++
>>   5 files changed, 98 insertions(+)
>>
>>
>> This seems to match what was found on the Arch Linux forums, too:
>> https://bbs.archlinux.org/viewtopic.php?id=288723&p=3
>>
>> I haven't tried it yet, but according to that forum thread, removing the
>> calls to scsi_cdl_check() seems to resolve the issue. This is all well
>> beyond my SCSI knowledge, but maybe a quirk to disable these CDL checks for
>> these older marvell controllers is required? Though it seems odd that the
>> device would be rescanned and/or scsi_add_lun called multiple times a second
>> -- is that normal?
>>
>> In any case, this seems to be the cause.
> 
> Hello David,
> 
> Thank you very much for your effort of bisecting this.
> 
> Could you please try this patch and see if it improves things for you:
> https://lore.kernel.org/linux-scsi/20230915022034.678121-1-dlemoal@kernel.org/
> 

Thanks very much: this seems to fix it here (on top of torvalds/master).

Cheers,
-- David

