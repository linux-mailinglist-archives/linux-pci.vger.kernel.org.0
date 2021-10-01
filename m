Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D27841F85D
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 01:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhJAXyk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 19:54:40 -0400
Received: from ale.deltatee.com ([204.191.154.188]:37782 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhJAXyk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 19:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=0xMuAZxy7WjRqQL5sr6ELkPcGlP9OuCPr003kHqTfeU=; b=Rpjy0u2OvkSevH2fgSa1DstoGH
        o2wJp5w42RBq2uenVuKW4DaC0Vkux3rrZjLwJcKk3LYAeiPFlWZHaGz8Pk79HoxlUCK38iS2CegOO
        kfMJVMtJjE9IvdE/zxdXag1XWFUhSoZAc5k74Pq1wJGxFoCoDlHqdobZqKs0ztuSRj9L6J3IC/32y
        fJHuXhrReLl0k0HxGTa3OUxEkca8z7d7IPpJgcn7g0UyVVenzmY+MqtOtgfMWp1YpouHw9032z/Ab
        Es6yom90pWab8FqpEUFqG44R2zfoGFJT/pGlvov09iWN0qL/OCxi6qlnFwgzOf592mkrCZ/MMOV9U
        W/oyms+w==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1mWSKk-0002BT-El; Fri, 01 Oct 2021 17:52:55 -0600
To:     Kelvin.Cao@microchip.com, helgaas@kernel.org
Cc:     kurt.schwemmer@microsemi.com, bhelgaas@google.com,
        kelvincao@outlook.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20211001201822.GA962472@bhelgaas>
 <2f7b4e6debbf7156a4da26bad0373d9df9667e66.camel@microchip.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1dfe4c62-63d2-e2e0-c7c0-e5cd2922176a@deltatee.com>
Date:   Fri, 1 Oct 2021 17:52:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <2f7b4e6debbf7156a4da26bad0373d9df9667e66.camel@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kelvincao@outlook.com, bhelgaas@google.com, kurt.schwemmer@microsemi.com, helgaas@kernel.org, Kelvin.Cao@microchip.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org




On 2021-10-01 4:58 p.m., Kelvin.Cao@microchip.com wrote:
> On Fri, 2021-10-01 at 15:18 -0500, Bjorn Helgaas wrote:
>> Didn't notice this before, but the "check_access()" name is not very
>> helpful because it doesn't give a clue about what the return value
>> means.  Does 0 mean no error?  Does 1 mean no error?  From reading
>> the
>> implementation, I can see that 0 is actually the error case, but I
>> can't tell from the name.
> 
> Yes, will improve the naming, like change it to "has_gas_access()" in
> v2 if a v2 patchset is preferred.

I'd keep the GAS name out of the kernel. How about something along the
lines of is_firmware_running()? Maybe a comment for the function would
be good as well.

Logan
