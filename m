Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1640633137F
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 17:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhCHQeW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 11:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhCHQeH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 11:34:07 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904ABC06174A;
        Mon,  8 Mar 2021 08:34:06 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id t9so3318225pjl.5;
        Mon, 08 Mar 2021 08:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IML5DiqUHffn2Up5773/YfnCyGbJ41/cNu36kai1zJc=;
        b=AUZd5gWW/Qwf38+7Cc99ZPkQyyX9PBPzawi6N6skWt9u0dPJXA+cWAw+yyWsLkJrgx
         Z95PBw519DR7DldFwwCULLClaD9zPcPlYIpnT6vU8x2AqyEjajdfgFM/bHUUjFmS9gWp
         oO3yJcNJc9jrw6ln11GNp6PEbODhLhQXxH5YtZxoSGY41KTGfA0G8cKzYaL/Oweun2ZN
         z3eZT4qvNKy7UBKsBA1UsJQcrk5DbEX2JDOofcpATD/LUuU/QTG6zSOHF89lij1wUhtq
         Agh6qHK9s6o2aQlMHPE//dgOETto0NrMg3VheUx4LLE2MDm+MBvOMzt3Fd1lPdHt0psq
         kWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IML5DiqUHffn2Up5773/YfnCyGbJ41/cNu36kai1zJc=;
        b=kTg39afYOlC4s8zInPZlYdXm3/Lh5pSyNOB/zuhMQcBQw1OtTWHq54RbkCpQSFz8L+
         N9Gl/OSdrwk2c447jLljMzvie7tL+a/P7322hDvwnu3UcQ7VkNzONdfdb0CKGAXG02ck
         A8qL+hHFnZ+gg71SkJXbgkpF1mPheJmMt9RGzgLz14rbcxJsqvPiqvjIPMSGVbSZPUSg
         KbvOqWsZdK1VnPWAukXwjiJSIIes3Pi/k5l+bb3NLqPrXTgg+TPC8SlyP+gWBnFF6pi5
         eQeR+B5Y7OgU/Nx7TcVoZjRLgFGdHcHM4gOaLEh3d9e2XhB9K3vrYgBscD0ZCinHPLJ3
         QXNg==
X-Gm-Message-State: AOAM531VVQDQBzcsC8ZJ+7IB8pt4ghX8gBHNCw/zUwLM8DT7glzxYkDZ
        /bksbD1PLBADKX6oRWYppIA=
X-Google-Smtp-Source: ABdhPJxLCZF482keMb/dq1tFjFcWD/m9XmiNb0nSh9FRDCk8vh+oEkky7ZodVxGrVsB1qTXYP/kG4w==
X-Received: by 2002:a17:902:8ec9:b029:e6:c5e:cf18 with SMTP id x9-20020a1709028ec9b02900e60c5ecf18mr9934345plo.47.1615221245976;
        Mon, 08 Mar 2021 08:34:05 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6sm2177562pfv.179.2021.03.08.08.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 08:34:05 -0800 (PST)
Subject: Re: [PATCH -next] PCI: brcmstb: Fix error return code in
 brcm_pcie_probe()
To:     'Wei Yongjun <weiyongjun1@huawei.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
References: <20210308135619.19133-1-weiyongjun1@huawei.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6f4024c5-41d8-df15-c00f-c2a491705176@gmail.com>
Date:   Mon, 8 Mar 2021 08:34:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210308135619.19133-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/8/2021 5:56 AM, 'Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fix to return negative error code -ENODEV from the unsupported revision
> error handling case instead of 0, as done elsewhere in this function.
> 
> Fixes: 0cdfaceb9889 ("PCI: brcmstb: support BCM4908 with external PERST# signal controller")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
