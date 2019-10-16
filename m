Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55681D951D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 17:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbfJPPKI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 11:10:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54303 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfJPPKH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 11:10:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so3320906wmp.4;
        Wed, 16 Oct 2019 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+uLqrMiJnBI08wE3El/UZHsyq4gEGt0L0SOTQspKZEY=;
        b=mMg91sD0QkZb7oarcG7gIoQcH5z7Aj6I1m6xtq3M+cFCx10lEMAmB+5SvqJ1qFNjM2
         oV8qR3ww5dPkc9gedYmvi9RA6xxS1pD2gIxt6oV37rQZ+vgNd3GuiTQwWKWlh3idLJeP
         tFnYvLOpXWMMoPNIMrAcuSHqV0YSaQQTg04cR8+TH8/iK47bKAJz84QMs2nLrYeNzwT7
         50hhbsyPXMRw2wOYvV7cZMQDyv7rCGiLjuDDbC7snYQxtqjDTqzFcRlFNRFDrDoHnurD
         MJ3lAoH6pOj+UthUiyCTCDu18/TYbBXYCPbnZTXbKGKpeiwhlUGb055MZfscT7JIugq1
         c16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+uLqrMiJnBI08wE3El/UZHsyq4gEGt0L0SOTQspKZEY=;
        b=qriG199YMzjowp8F2MxwCqIQyFy/vg25qRlL6kzz30vy3SotRZYDsS7zpz2VQOIPg3
         TP/Vaz3Zwr9wwfJ00HCeCnXCfDbBokwcnpZ9LES5RUguMS7/0xq4WSZqY7i5rOIUa5SH
         cKyyPrNpU/W0NxX8nNbSO0rzb8XuVlls7KBjLNzdjjCM0ygPIVU2F4A9F+SNW94p4l/H
         +w5oX/GzqVyae0SgUaq5ev/v2+ELGbQ2OqT6Y+9I6af4swcHlU+hdkLE9N9/FPGUbhQ5
         222D7IcbVYG71olYO0ZivyizwmQiF+0YQi68eQcuc9PMu1R+zpmj9SUCF9tJgJh8ExfE
         vADQ==
X-Gm-Message-State: APjAAAVAAEZsC8z/0EWcfBtQgcjnFYBJj+HXo2p1k+n6Adi13cNPdJG8
        3p323z8G9yM9f+GrNP5aF3RDEsJP
X-Google-Smtp-Source: APXvYqxqwaDEt+x8JJqoxFCS272sk2h+7Mg+zi+6FjnTjLJjoecy/7R19XVob7PBbOuC24KdETzinQ==
X-Received: by 2002:a1c:1a4c:: with SMTP id a73mr3835923wma.124.1571238604997;
        Wed, 16 Oct 2019 08:10:04 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id n1sm31572256wrg.67.2019.10.16.08.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 08:10:04 -0700 (PDT)
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20190809175741.7066-1-marek.vasut@gmail.com>
 <20190809175741.7066-2-marek.vasut@gmail.com>
 <20191016150001.GA7457@e121166-lin.cambridge.arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <c4353d63-6f78-92b3-91c9-acc9327e1d80@gmail.com>
Date:   Wed, 16 Oct 2019 17:10:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016150001.GA7457@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/16/19 5:00 PM, Lorenzo Pieralisi wrote:
> On Fri, Aug 09, 2019 at 07:57:40PM +0200, Marek Vasut wrote:
>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>
>> In case the "dma-ranges" DT property contains either too many ranges
>> or the range start address is unaligned in such a way that populating
>> the range into the controller requires multiple entries, a situation
>> may occur where all ranges cannot be loaded into the controller.
>>
>> Currently, the driver refuses to probe in such a situation. Relax this
>> behavior, load as many ranges as possible and warn if some ranges do
>> not fit anymore.
> 
> Patches (1) and (3) are fine but I do not think this one is.
> 
> Firmware (DT) should provide dma-ranges according to what HW can handle,
> more so given that other subsystems (eg IOMMU) rely on the dma-ranges
> value to set-up eg DMA - if there is a mismatch between PCI host inbound
> regions and software structures describing DMA'able ranges all bets are
> off.

The firmware provides all the ranges which are available and usable,
that's the hardware description and that should be in the DT. The
firmware cannot decide the policy for the next stage (Linux in this
case) on which ranges are better to use for Linux and which are less
good. Linux can then decide which ranges are best suited for it and
ignore the other ones.

-- 
Best regards,
Marek Vasut
