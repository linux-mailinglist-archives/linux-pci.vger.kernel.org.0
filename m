Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38271F4587
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 20:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388796AbgFISQr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 14:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388795AbgFISQl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 14:16:41 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40495C03E97C;
        Tue,  9 Jun 2020 11:16:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x14so22396768wrp.2;
        Tue, 09 Jun 2020 11:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bk0cIlVSiN8EwQ03yBOWiOnhIYqHLR2FvZJ53dbCYEY=;
        b=Ov6e462ZybQzwlR8GCT7XvR7xht8paOqYNOcfEUd3i6nurHuzjZF5dvN68Z2ycnf1o
         YecHZm7wCUZqW0juz4nDAhAbBTUNt7fDQBvlo6Wkv3XDVs6gPid+oBrZUjWxlCFW3eyc
         8+adKq8vHJ2OW7MJYp8sRxqLSygbC6uPaAFWfnFW4OXJXEVrQf3YagbkQzi3FG6gCA/A
         oxHmvZ6LUFJ9ZumTFIiCLNsYfwmPqOrlM9iut3Y4YwhcpR3O08vRB/3ExymIil0gU80O
         WTmJj/025yCe2VmC5/tMYE6uHGK4V1IpgfYzwNgf0bT7cDA+cqG0YsWgvrdp78T1DFuu
         6ShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bk0cIlVSiN8EwQ03yBOWiOnhIYqHLR2FvZJ53dbCYEY=;
        b=Vjw/ZxWQicnnwpWRWNZnEuHFyku+qXmXq2cVxdrFWTlXwGMQDaqb6Qojx0qylrNS4d
         inv6dSG6/e1STu9M5S5BpqcrFYroODcReynIBRNg2o7gPSbnKaGbbmmhGwYfo2Dw9tRR
         9bJY01HJLyNb39k8c1TVfA9jnZiRIbgLwsMshYHH2neeM2QeiVObk8qOPDZ/BGgENcpL
         xAGFrjYnjSm3hO1JEIR/K8eV6Wx3KyYHroUG4zp4ra+vZEJRyvAiVcUQ4QBD81Vb+H9E
         13n9htSVt/ws8X47rLDo69GVtzXurNDpGV8yqxdrFczVmENy6njln5BVBWV9G86BN293
         NRdA==
X-Gm-Message-State: AOAM532WKcc2W+ALk8k+X4dce/xYPsFCNtW5Abk49Df4s+/CHJBH5F0Y
        S53wuE1U/RXMYbhpOu1S6Zl1W0aY
X-Google-Smtp-Source: ABdhPJzMWhpdjrKlsaolT5WA6K7H0Q+ASshsGywKRTvhAaqjih7B7gzi1oWMdU0I79tFcf60YQwBFA==
X-Received: by 2002:adf:a51a:: with SMTP id i26mr5720261wrb.406.1591726598739;
        Tue, 09 Jun 2020 11:16:38 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id u4sm3725013wmb.48.2020.06.09.11.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 11:16:37 -0700 (PDT)
Subject: Re: [PATCH v2 4/9] ARM: dts: bcm2711: Add reset controller to xHCI
 node
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com, devicetree@vger.kernel.org
References: <20200609175003.19793-1-nsaenzjulienne@suse.de>
 <20200609175003.19793-5-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d1690ac7-0c9c-6ea7-90b1-eb9a735e220f@gmail.com>
Date:   Tue, 9 Jun 2020 11:16:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200609175003.19793-5-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/9/2020 10:49 AM, Nicolas Saenz Julienne wrote:
> The chip is hardwired to the board's PCIe bus and needs to be properly
> setup trough a firmware routine after a PCI fundamental reset. Pass the
> reset controller phandle that takes care of triggering the
> initialization to the relevant PCI device.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

With the comment from patch #2 to move the reset identifiers to a shared
header that can be referenced by this file:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
