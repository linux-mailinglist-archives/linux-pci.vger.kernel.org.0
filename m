Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6279C134EF1
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 22:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgAHVex (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 16:34:53 -0500
Received: from ale.deltatee.com ([207.54.116.67]:49842 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgAHVex (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jan 2020 16:34:53 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ipIyY-0000pM-BM; Wed, 08 Jan 2020 14:34:51 -0700
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>
References: <20200108212347.GA207738@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <02513858-4832-b971-138e-8ecc1c7730b8@deltatee.com>
Date:   Wed, 8 Jan 2020 14:34:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200108212347.GA207738@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: dmeyer@gigaio.com, epilmore@gigaio.com, Kelvin.Cao@microchip.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 09/12] PCI/switchtec: Add gen4 support in struct
 flash_info_regs
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-01-08 2:23 p.m., Bjorn Helgaas wrote:
> On Mon, Jan 06, 2020 at 12:03:34PM -0700, Logan Gunthorpe wrote:
>> From: Kelvin Cao <kelvin.cao@microchip.com>
>>
>> Add a union with gen3 and gen4 flash_info structs.
> 
> This does a lot more than add a union :)
> 
> I think this looks reasonable, but I would like it even better if this
> and related patches could be split up a little bit differently:
> 
>   - Rename SWITCHTEC_CFG0_RUNNING to SWITCHTEC_GEN3_CFG0_RUNNING, etc
>     (purely mechanical change, so trivial and obvious).
> 
>   - Add switchtec_gen and the tests where it's needed, but with only
>     SWITCHTEC_GEN3 cases for now.
> 
>   - Refactor ioctl_flash_part_info() (still only supports GEN3).
>     Maybe adds struct flash_info_regs and union, but only with gen3.
> 
>   - Add GEN4 support (patch basically contains only GEN4-related
>     things and doesn't touch GEN3 things at all).  Maybe it would
>     still make sense to split the GEN4 support into multiple patches
>     (as in this series), or maybe they could be squashed into a single
>     GEN4 patch?
> 
>   - It seems like at least the aliasing quirk and the driver device ID
>     update could/should be squashed since they contain the same
>     constants.

Thanks for the review. Yes, I should be able to clean this up and submit
a v2 in the next week or two.

Logan

