Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C00C2C6163
	for <lists+linux-pci@lfdr.de>; Fri, 27 Nov 2020 10:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgK0JLq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Nov 2020 04:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgK0JLp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Nov 2020 04:11:45 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AE2C0613D1
        for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2020 01:11:45 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id m6so4771231wrg.7
        for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2020 01:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tJej98i39Thbfu0ccWujCoay9hwV1vZDQoabHYPls6Q=;
        b=EyCFKjo/1g54/l3VGkou2jJSbHCGVH8hDQNTmoBPgh8kkhRtTRBwpOTA3hm5qzXbk/
         ZVrcymnUSKiTTsR8HRaOC85uDSt5iCZ6IQU2nU7mDGwYm17JvO79Vx5pE3o4HJexAxR/
         fHIfJDRDuELdvr+m6hvjC+dGZtWFRKW3AxScEKn8lykNbpb6k+1D26EJCedmjrf6M1sg
         2WB/FwBN+zB+6tj44kqCBacR8311VgyIC98ntgI8KwKeWp6dag205QqF8WqBuaEkgGje
         i1XVy0LFiMR8ezLCUopVdMpw62w5z44lO0nmjxAhhWnSQOsp8XxBbn2va3DYW1b5bsJM
         4mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tJej98i39Thbfu0ccWujCoay9hwV1vZDQoabHYPls6Q=;
        b=bEVDGuUAqJhmrCayeA7uJNoalGCU12aRFQUNJPwgoj6x5tXsklQQNmEM8Ea1VXvSeA
         Hvk1Pj5+fMhKUzRZ2lULZFEEkwxPqF9psysp2YZqBcmm/V4rS89Lif3mxkc3AoGg0Yhc
         z3JjqhHrJ95NgiBWjYElqKSP111T+JkE66WnuH7ya+ZG7ngaGoLrucjHZg1TjMAn0rhh
         9Go4zUsaAhkXsqvq6zt+hVetlas58ZX2YZXYHWvip5RaK2JvF6VKgOs3M7yqOXaSfRrK
         Kle6ewQACYDXyifq4A+DCSREJcX/17P4oqJLgJOsuU1WaQ98odegZocJjQW5nRI7YvNl
         HxBg==
X-Gm-Message-State: AOAM530gbqO+XLpbKpLvtCFhYY9WOZcmPekbMB95Ht8TzxhouYuEpTeL
        hq09tY6TjT2F1Fwfk3kz4kU=
X-Google-Smtp-Source: ABdhPJyNfmj5Q3BSM1JtQWlCOSE+OS6dzA5uSpSmDttj8wy3vaeIVZIvUdh0HkFE8LMwVSrw2KY00A==
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr9103223wrj.328.1606468303819;
        Fri, 27 Nov 2020 01:11:43 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id c17sm14052238wro.19.2020.11.27.01.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 01:11:43 -0800 (PST)
Subject: Re: pcie-mediatek.c coverity issue #1437218
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Cc:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>
References: <20201027161911.GA182976@bjorn-Precision-5520>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <6620a6fa-0c0e-ecb5-5a2b-a50c147e9c73@gmail.com>
Date:   Fri, 27 Nov 2020 10:11:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201027161911.GA182976@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ryder,

On 27/10/2020 17:19, Bjorn Helgaas wrote:
> Hi Ryder,
> 
> Please take a look at this issue reported by Coverity:
> 
>   760 static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
>   761 {
>   762        struct mtk_pcie *pcie = port->pcie;
> 
> CID 1437218 (#1 of 1): Wrong operator used
> (CONSTANT_EXPRESSION_RESULT) operator_confusion: (port->slot << 3) & 7
> is always 0 regardless of the values of its operands. This occurs as
> an initializer.
> 
>      	Did you intend to use right-shift (>>) in port->slot << 3?
> 
>   763        u32 func = PCI_FUNC(port->slot << 3);
>   764        u32 slot = PCI_SLOT(port->slot << 3);
> 

AFAIK pcie is working. Could you have a look on this code snippet? It seems as 
if there is something fishy.

Thanks,
Matthias
