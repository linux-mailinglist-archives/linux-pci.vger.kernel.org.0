Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566442C8FF7
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 22:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388553AbgK3VZO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 16:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388485AbgK3VZN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 16:25:13 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DA4C0613D3;
        Mon, 30 Nov 2020 13:24:33 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id l1so7224817pld.5;
        Mon, 30 Nov 2020 13:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ll2JJaksjzE8Q6Nr6NYfNRZN8P9gxZMqcK/4uDsQ2cU=;
        b=WGMIzm2UNInaLcEcugm4RjJXyGX06d/YZO9WhikAIqkzYvgJ8DptfBKK9OFrK4VYDn
         E37+AMhTvPIM9E0eOb7LJURoPNsEwaNSwMDFOmLJ8FJ06N1BKP0Mrq+FyH4VAf2XCKnU
         rpdSbkQUt5DxhuK5POfeS5yf0tc1OnuY3wX+ctj431uhwdEXWyamnwHKo9c1fMg9p6YP
         Ybj+JMOy/qnDVxuNfRH/x85nkcvls/Ok7RpbJh160xUOVWRxkK26r5HSEVtbKsVs/gUB
         F8vnGIPj7k+WfhFr0Wv8OycIPWqXugd4/RxwAyKhoGyIFHoz4mfs/y8ncerUDMd5DOxD
         fGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ll2JJaksjzE8Q6Nr6NYfNRZN8P9gxZMqcK/4uDsQ2cU=;
        b=ub4JbQfWsSc+pw40JcfbjwmbXpXaq+TPBmW04WCKBzHUdSkRVXxHi2GSHGygSYmYWJ
         s7PbqyENr1+WLc8XkIfMbsRxJ1QSqttt7VUlCjhpoA2c5zrO8XjH4d6EBBVRsrGE3JAK
         zf5g86+yDij4Geehid354bxcCp/Vq6HYkl4clCKxTuuPnLwmrmvqzRBB5ESh/2lkQ+Q4
         aj6MzM0YQks22ahwXGTkXS1ET6odDwwOWbUPsCnjbJHrhoRCCTnRt/Y9/Ye88HC9Nirg
         7zN+OjGhVc3ks6MNw26RrRG14Uh5REGYrD1uxxx3YnGN1/jD5BgpX9t5uwWoO/8J1VHH
         9OXQ==
X-Gm-Message-State: AOAM532mcMJjgU0SEGF+9NGWyzQCOn6QTawjJ/fLMn42wod+0CQf42yI
        fFnX5PIcaH8UNj9nAFgNvdcO388UlFk=
X-Google-Smtp-Source: ABdhPJyisv9RK/82Z0H0ALstOMpckeodpsMq45LzVBMC1qlFaYY8lFI/ICKZqu2GrubA5MHSitairw==
X-Received: by 2002:a17:90a:7e0f:: with SMTP id i15mr835634pjl.77.1606771472700;
        Mon, 30 Nov 2020 13:24:32 -0800 (PST)
Received: from [10.230.28.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q29sm18176330pfg.146.2020.11.30.13.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 13:24:31 -0800 (PST)
Subject: Re: [PATCH v2 4/6] PCI: brcmstb: Give 7216 SOCs their own config type
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        broonie@kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201130211145.3012-1-james.quinlan@broadcom.com>
 <20201130211145.3012-5-james.quinlan@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <833b8ff3-978d-7d3f-da6b-93f86835b2ce@gmail.com>
Date:   Mon, 30 Nov 2020 13:24:29 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130211145.3012-5-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/30/2020 1:11 PM, Jim Quinlan wrote:
> This distinction is required for an imminent commit.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
