Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C352249F2
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jul 2020 10:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgGRIoc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Jul 2020 04:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgGRIob (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Jul 2020 04:44:31 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510DDC0619D4
        for <linux-pci@vger.kernel.org>; Sat, 18 Jul 2020 01:44:31 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b25so15260492ljp.6
        for <linux-pci@vger.kernel.org>; Sat, 18 Jul 2020 01:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bjE+dCvxgE0tlMMZLFwfonoavKmjK5fkX5+I71udzRw=;
        b=Lw3x1xub/THf0lSfQiJLlYPDEeLqTRfWGY1OSES/r9EWhLdZ/OwMUm17mmqb9cXSAj
         a0Q7tFEG6di06ImL47HCTr8cC1xh7u5JdmmLgQQEGUOaq1PL/e+0MpLgvqO8+yQ4so6p
         V7wYvcSXVkXtZFW004PAwBCJlrHTe0Wb42SUR7GkZINg/22/eCy/11e0gWLdwfFsZcQx
         3mxtU4Me1jb2j+W0r0BKZnqWwTT/XFyhZGTz8Ze0E52XTH8w4biUSIAbi5skzZCqtzW+
         t6/tCcKUad/PMx/fE64be9uvxnDRZbj9q8QeHSvLvlWOQqXcva+e2R12H4AUAIo/ZxEO
         aURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bjE+dCvxgE0tlMMZLFwfonoavKmjK5fkX5+I71udzRw=;
        b=HPGwgUfuhIc26gecAfjKbPuVoOubTxdK5avKKF065NcHGVdc82f4yja+/MIhWCs1Ls
         chLvrUaEvWHVW0b9vsgnLRtNo2GLsYp3ToNrS/8Hq+hTL6CfiVdo4giY73hHPKE1oTjQ
         uaBPZBN2lH/NOM8uQ+S1y0CBW1+gYsQlrPQ6dClRzMHkSsVQQnj4g41FlIqp/U3GrNyV
         xQSr5ZvOPsHppPmNmxBb7DbmeO9rQ50ndoSeCyz3BPltNmliXMA5KOrs/KzUg0hy29th
         im4y+yUmHTzr9J8TOzGkaIha8Cwf0d/X+GIqCkhgMMbtVyENeZV2WaIFkt8pTWhY0kdP
         P4Tw==
X-Gm-Message-State: AOAM530j/pEO1mWtJYGR+VTVP4tssAlUTylgkEHbsBggCncr1j25Ql/9
        4y4HCWGBzZ6pXyDGx1gIuCLffg==
X-Google-Smtp-Source: ABdhPJwONy7CQ3+lzmfZHBf4GOW7ycRwqd8UaqFKCa7tofUgz7n4M6q65+GFFCWQpyC9xM0RpLPW+Q==
X-Received: by 2002:a2e:b16c:: with SMTP id a12mr6041241ljm.146.1595061869662;
        Sat, 18 Jul 2020 01:44:29 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:42e3:6011:c93:75dd:e99a:5259? ([2a00:1fa0:42e3:6011:c93:75dd:e99a:5259])
        by smtp.gmail.com with ESMTPSA id h18sm2087863ljk.7.2020.07.18.01.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jul 2020 01:44:28 -0700 (PDT)
Subject: Re: [PATCH v4] PCI: loongson: Use DECLARE_PCI_FIXUP_EARLY for
 bridge_class_quirk()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
References: <1595061424-27701-1-git-send-email-yangtiezhu@loongson.cn>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <5a173967-098a-9e40-1373-5502506488f4@cogentembedded.com>
Date:   Sat, 18 Jul 2020 11:44:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595061424-27701-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18.07.2020 11:37, Tiezhu Yang wrote:

> According to the datasheet of Loongson LS7A bridge chip, the old version
> of Loongson LS7A PCIE port has a wrong value about PCI class which is
> 0x060000, the correct value should be 0x060400, this bug can be fixed by
> "dev->class = PCI_CLASS_BRIDGE_PCI << 8;" at the software level. As far
> as I know, the latest version of LS7A has already fixed the value at the
> hardware level.
> 
> In order to maintain downward compatibility, use DECLARE_PCI_FIXUP_EARLY
> instead of DECLARE_PCI_FIXUP_HEADER for bridge_class_quirk() to fix it as
> early as possible.
> 
> Otherwise, in the function pci_setup_device(), the related code about
> "dev->class" such as "class = dev->class >> 8;" and "dev->transparent
> = ((dev->class & 0xff) == 1);" maybe get wrong value due to without

    "Due to" not needed there.

> EARLY fixup.
> 
> Fixes: 1f58cca5cf2b ("PCI: Add Loongson PCI Controller support")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
[...]

MBR, Sergei
