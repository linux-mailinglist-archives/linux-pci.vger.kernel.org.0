Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC5B6B3B5D
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 10:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCJJxY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 04:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCJJxX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 04:53:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4174393A;
        Fri, 10 Mar 2023 01:53:20 -0800 (PST)
Received: from [192.168.86.246] (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 27FED660305B;
        Fri, 10 Mar 2023 09:53:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678441999;
        bh=yTOKzUGzEBdFLHPokAIe0S9LUwi4oC8dcd7Rms8wGGE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=edTm25Ezw29SJrUN31+J6cyYULJUxBgIMwZ9dJFyVd4onZOYT+3tLFjuf+HPlZH7k
         luRaOP4miwxydIwZm1IdkpVWolXDNosYMBJrcoQyJTSiDM/jtxvGZ3z9ZWWPsQRpQv
         c4hSayZbLAffR0x0+IAn5GkEwdLZ52+FesOHymfKPrA+IcKvk6VD5fyQm+mNAwznXz
         TXvIv99kYtKPnpEZ6o/UNbeE6oVTgrnR97533VIgUHFVdRK3xFx6Y+TKrWtsFSeRI7
         tDRIMKUrLWJABJaCiovqsxFKn2n9Bz/v26fL7QFPN3WZwH78za3Iy6HQrxpwKD2cTe
         +2+ACL/I4EcBQ==
Message-ID: <37adba14-1add-187c-01b5-5109be38018e@collabora.com>
Date:   Fri, 10 Mar 2023 09:53:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/7] irqchip/gic-v3: Add a DMA Non-Coherent flag
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Qu Wenruo <wqu@suse.com>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, kernel@collabora.com,
        Robin Murphy <robin.murphy@arm.com>
References: <20230310080518.78054-1-lucas.tanure@collabora.com>
 <20230310080518.78054-2-lucas.tanure@collabora.com>
 <a43dee4ef0e72c393dea6ce924347f81@kernel.org>
From:   Lucas Tanure <lucas.tanure@collabora.com>
In-Reply-To: <a43dee4ef0e72c393dea6ce924347f81@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10-03-2023 08:56, Marc Zyngier wrote:
> On 2023-03-10 08:05, Lucas Tanure wrote:
>> The GIC600 integration in RK356x, used in rk3588, doesn't support
>> any of the shareability or cacheability attributes, and requires
>> both values to be set to 0b00 for all the ITS and Redistributor
>> tables.
>>
>> This is loosely based on prior work from XiaoDong Huang and
>> Peter Geis fixing this issue specifically for Rockchip 356x.
> 
> No.
> 
> If we are going to do *anything* about this thing, it is by
> describing the actual topology.
What do you mean by describe the topology?
What kind of information are you expecting?


And it has to work for both DT
> and ACPI.
> 
> Alternatively, this is an erratum.
> 
>          M.

