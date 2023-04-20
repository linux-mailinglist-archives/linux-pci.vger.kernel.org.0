Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2709F6E9E86
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 00:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjDTWET (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 18:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjDTWET (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 18:04:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAB6270C;
        Thu, 20 Apr 2023 15:04:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7948364C33;
        Thu, 20 Apr 2023 22:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0AAC433EF;
        Thu, 20 Apr 2023 22:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682028256;
        bh=rD9VMfKEJUFC4BYnTD9baNPUr4s7JyEl0ztF0Di7OKw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EPQM4RDE1vMmsg7wiEkmGqzvCIyrImc5T/Bq/lqdOuEdICx6O4ap+Ub/FsyWPaHl7
         nXwQO/Qdxv8dnF4h8A2ap5SSbWNe7H8hOm0z32DRkhmePr7VeEB2LaSoWHvv1nWXRl
         hI2P+e3jctlTnnOx/kH02gPjWp7wHKr4a5OoCBTrAJM8GEawx2cK86+cd0uAA+4gCF
         Mcg7cPFrfnSVSxCuS97zKToBgg2ZtXbqevEgc7mxdOxgLyGvBQxl0QkB+z9WdZhfE9
         3v2CeZ7jEXj5t3DH5eBmA7wA6cblDyn0kjKoPN9RjOHd5GWSbCf0RsJ6Ezrq+yfbou
         tY8F5n76uF5zQ==
Message-ID: <6b7c1f22-2d97-bda9-affd-2e3a7a1d42ed@kernel.org>
Date:   Fri, 21 Apr 2023 07:04:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] PCI: Add ASPEED vendor ID
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR AST SERVER GRAPHICS CHIPS" 
        <dri-devel@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dave Airlie <airlied@redhat.com>,
        Patrick McLean <chutzpah@gentoo.org>, linux-ide@vger.kernel.org
References: <20230420191036.GA315493@bhelgaas>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230420191036.GA315493@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/21/23 04:10, Bjorn Helgaas wrote:
> [+cc Damien, linux-ide]
> 
> On Thu, Apr 20, 2023 at 09:08:48AM +0200, Thomas Zimmermann wrote:
>> Am 19.04.23 um 20:37 schrieb Bjorn Helgaas:
>>> On Wed, Apr 19, 2023 at 09:00:15AM +0200, Thomas Zimmermann wrote:
>>>> Am 19.04.23 um 00:57 schrieb Patrick McLean:
>>>>> Currently the ASPEED PCI vendor ID is defined in
>>>>> drivers/gpu/drm/ast/ast_drv.c, move that to include/linux/pci_ids.h
>>>>> with all the rest of the PCI vendor ID definitions. Rename the definition
>>>>> to follow the format that the other definitions follow.
>>>>
>>>> Thanks a lot. Can you please also move and rename the PCI device ids? [1]
>>>
>>> Generally we move things to pci_ids.h only when they are shared
>>> between multiple drivers.  This is mostly to make backports easier.
>>>
>>> PCI_VENDOR_ID_ASPEED is (or will be) used in both ast_drv.c and
>>> libata-core.c, so it qualifies.
>>>
>>> It doesn't look like PCI_CHIP_AST2000 and PCI_CHIP_AST2100 would
>>> qualify since they're only used in ast_drv.c and ast_main.c, which are
>>> part of the same driver.
>>
>> Ok, I see. Can I take the patch into DRM trees?
> 
> The first time around I got two patches [2].  This time I only got
> this patch, but IIUC there are still two patches in play here:
> 
>   - This one, which moves PCI_VENDOR_ID_ASPEED to pci_ids.h, and
>   - The libata-core one that adds a use in ata_dev_config_ncq()
> 
> Those should go together via the same tree.  I supplied my ack to
> indicate that I'm not going to merge anything myself, and I expect
> whoever merges the libata patch to also merge this one.
> 
> If for some reason the libata-core patch doesn't happen, then this
> patch shouldn't happen either, because there would no longer be any
> sharing between drivers that would justify a pci_ids.h addition.

I can take both patches through the libata tree but there were comments on the
second patch for libata and I have not seen these addressed yet (I did not get a
v2). And in the meantime, it seems that the PCI ID patch was reworked as a
single patch... Not sure what's happening here.


