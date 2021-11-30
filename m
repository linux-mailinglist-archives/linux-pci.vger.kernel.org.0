Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C304633B6
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 12:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhK3MDC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 07:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhK3MDB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 07:03:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D9BC061574;
        Tue, 30 Nov 2021 03:59:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E0E24CE18FE;
        Tue, 30 Nov 2021 11:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C9BC53FC7;
        Tue, 30 Nov 2021 11:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638273579;
        bh=nGzxpZJWSCKzpRqYJRSIk5w5ewqGleaL9kREzEMMTm0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bXXy+uZDSzifTQFRwczjKuHFmOV+jMJldtLzV1t6J6WNjbxOfzERZc3bPWPhWm3Yj
         7XMOZm0vyo2HweT9tuMLIQrblKkMc5tidTavCs+XdZSbkO3OFo2O/Y3t/CThmhN1TU
         hlQV6h1k027CfmFAIadoxL0ZC+dV4m8bTXSUCQrGniW5ZtakRKHAFqengoDZsT0/fk
         3/xvWVIACugeQUfuZoXvg6+rKLmGaF66ubQydNcolGZnCPk5xmHYpsZWQGmIT7SulB
         PqbEgocg+Lr/qQifPvUohu+4TAQQhWL0V1ONSp//M+Tkw6EnguQEsI/swkF2IbJjmf
         8RftIB1IOm90A==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ms1nI-008rZE-MQ; Tue, 30 Nov 2021 11:59:34 +0000
MIME-Version: 1.0
Date:   Tue, 30 Nov 2021 11:59:32 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Luca Ceresoli <luca@lucaceresoli.net>, kernel-team@android.com
Subject: Re: [PATCH v3 0/3] PCI: apple: Assorted #PERST fixes
In-Reply-To: <20211130115632.GA3355@lpieralisi>
References: <20211123180636.80558-1-maz@kernel.org>
 <20211130115632.GA3355@lpieralisi>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <b2a06abf476b3e89504a227b3d1bea7c@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lorenzo.pieralisi@arm.com, bhelgaas@google.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, pali@kernel.org, alyssa@rosenzweig.io, mark.kettenis@xs4all.nl, luca@lucaceresoli.net, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo, Bjorn,

On 2021-11-30 11:56, Lorenzo Pieralisi wrote:
> On Tue, Nov 23, 2021 at 06:06:33PM +0000, Marc Zyngier wrote:
>> Apologies for the rapid fire (I tend to be much more conservative when
>> resending series), but given that this series has a direct impact on
>> other projects (such as u-boot), I'm trying to converge as quickly as
>> possible.
>> 
>> This series aims at fixing a number of issues for the recently merged
>> Apple PCIe driver, all revolving around the mishandling of #PERST:
>> 
>> - we didn't properly drive #PERST, and we didn't follow the specified
>>   timings
>> 
>> - the DT had the wrong polarity, which has impacts on the driver
>>   itself
>> 
>> Hopefully, this should address all the issues reported so far.
>> 
>> * From v2:
>>   - Fixed DT
>>   - Fixed #PERST polarity in the driver
>>   - Collected Pali's ack on patch #1
>> 
>> [1] https://lore.kernel.org/r/20211122104156.518063-1-maz@kernel.org
>> 
>> Marc Zyngier (3):
>>   PCI: apple: Follow the PCIe specifications when resetting the port
>>   arm64: dts: apple: t8103: Fix PCIe #PERST polarity
>>   PCI: apple: Fix #PERST polarity
>> 
>>  arch/arm64/boot/dts/apple/t8103.dtsi |  7 ++++---
>>  drivers/pci/controller/pcie-apple.c  | 12 +++++++++++-
>>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> Hi Bjorn,
> 
> this series is v5.16-rcX material for PCI fixes, can you pick patches 
> 1,3
> up please ?

Do you mind picking patch #2 as well? Or shall I route it somewhere 
else?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
