Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5308546F5FB
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 22:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhLIVgV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 16:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhLIVgV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 16:36:21 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E102C061746;
        Thu,  9 Dec 2021 13:32:47 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id g16so6278426pgi.1;
        Thu, 09 Dec 2021 13:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rbpdrCsVzrOnQ9WfDUTZn6znkydDP2yee0FBUvZrun0=;
        b=imTw0PVD3rYveZKu8Vcjo0vRtTDmbYzjWNIkg6lJ2bB45GVfYfa8Vd0namYlaA8urn
         Fr9358Q8B414sJMbpzHzwpF/cpqKcy7IN+vT5Ncd6yPt5shMYh3Zk/G9iS1LXUspxOkw
         74Aon8OIiEXn/XCJWQp8VWFPG08XtQNIF3Y4mzUimjp1EKXiJlhvIStC0OmPHNhwpHYl
         s9VkFJziIitblVOwnh79WataULk8E9llil1wJ9kZk9zo9Ve7athfoK6ftvELijpbeqZe
         wPMbeTgcyC/bqdFQSY2es8uyUDVnqWBlFUkmMfUM7eVw4lhII6aQ95VGD8gpmiO9Z089
         03kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rbpdrCsVzrOnQ9WfDUTZn6znkydDP2yee0FBUvZrun0=;
        b=Krk0hZID82QheN/3/IeKJbX7+htPqd2hUwwwtUn52qQwW26PLquNp5hkmPy2gJSp3Y
         kaDygIU2ok5j5wxIRy6ghMAaDh2GThCQOSyt+jUD1sqsnlSTs7/Vkx8C7Wrpt14wJXxr
         sqP0cjfHrPsxNmEa3chP0/aEgPAeLUGijYkiDh34MWqEPtrwYjIwuZZ8ZQxKW2bO5EcC
         EPazPwb75Cp8vo4dbYqUUtYTs4hH//ywfPmn7ejvaL/R37HI38Y1e1+FUdcu9YKaG2Ky
         oWZ4QGzrr11HV/Ln4fsER311mLmhJOMTk6ZF27QvNsVzc2socwYkJU2z3vXzkE74Gs2Q
         SHFg==
X-Gm-Message-State: AOAM531UJ6ZYKc7cuNidHwc+qKUhWKRmu3YpnG8EDXtmnWY8jZnbXBNY
        zA1GLV6RchX1eoCI5semX6E=
X-Google-Smtp-Source: ABdhPJxp7Qu9leVPV+reXjsCbv+VjiFOxHfbVjrKBwABILKj4EkDytPAynX3oXxag+Ii0Dr0U4uUsg==
X-Received: by 2002:a05:6a00:188e:b0:4a4:f2fd:d7b9 with SMTP id x14-20020a056a00188e00b004a4f2fdd7b9mr13921910pfh.20.1639085566936;
        Thu, 09 Dec 2021 13:32:46 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i2sm645076pfg.90.2021.12.09.13.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 13:32:46 -0800 (PST)
Subject: Re: [PATCH v1 4/4] PCI: brcmstb: Augment driver for MIPs SOCs
To:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20211209204726.6676-1-jim2101024@gmail.com>
 <20211209204726.6676-5-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7f59e65a-085a-2aa1-e736-020ffe82743e@gmail.com>
Date:   Thu, 9 Dec 2021 13:32:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209204726.6676-5-jim2101024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/9/21 12:47 PM, Jim Quinlan wrote:
> The current brcmstb driver works for Arm and Arm64.  A few things are
> modified here for us to support MIPs as well.
> 
>   o There are four outbound range register groups and each directs a window
>     of up to 128MB.  Even though there are four 128MB DT "ranges" in the
>     bmips PCIe DT node, these ranges are contiguous and are collapsed into
>     a single range by the OF range parser.  Now the driver assumes a single
>     range -- for MIPs only -- and splits it back into 128MB sizes.
> 
>   o For bcm7425, the config space accesses must be 32-bit reads or
>     writes.  In addition, the 4k config space register array is missing
>     and not used.
> 
>   o The registers for the upper 32-bits of the outbound window address do
>     not exist.
> 
>   o Burst size must be set to 256 (this refers to an internal bus).
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
