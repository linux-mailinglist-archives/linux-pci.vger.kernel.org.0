Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAA74DDCC3
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 16:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbiCRP0e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Mar 2022 11:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237831AbiCRP0e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2022 11:26:34 -0400
Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk [78.40.148.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBE9A5E91;
        Fri, 18 Mar 2022 08:25:15 -0700 (PDT)
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=[192.168.0.21])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1nVETX-0001qa-OJ; Fri, 18 Mar 2022 15:25:11 +0000
Message-ID: <82efacaf-9dcb-f07a-dc2b-06668b1a745b@codethink.co.uk>
Date:   Fri, 18 Mar 2022 15:25:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] PCI: fu740: Drop to 2.5GT/s to fix initial device probing
 on some boards
Content-Language: en-GB
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <20220318152105.525824-1-ben.dooks@codethink.co.uk>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20220318152105.525824-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18/03/2022 15:21, Ben Dooks wrote:
> The fu740 PCIe core does not probe any devices on the SiFive Unmatched
> board without this fix (or having U-Boot explicitly start the PCIe via
> either boot-script or user command). The fix is to start the link at
> 2.5GT/s speeds and once the link is up then change the maximum speed back
> to the default.
> 
> The U-Boot driver claims to set the link-speed to 2.5GT/s to get the probe
> to work (and U-Boot does print link up at 2.5GT/s) in the following code:
> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pci/pcie_dw_sifive.c?id=v2022.01#L271
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> --
> Note, this patch has had significant re-work since the previous 4
> sets, including trying to fix style, message, reliance on the U-Boot
> fix and the comments about usage of LINK_CAP and reserved fields.

Apologies, it seems I forgot to do "git commit --amend" on the last
file save. I've now sent a "V3"


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
