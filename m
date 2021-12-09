Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793DA46F5F2
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 22:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbhLIVeg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 16:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbhLIVea (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 16:34:30 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39065C061746;
        Thu,  9 Dec 2021 13:30:55 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b13so4889544plg.2;
        Thu, 09 Dec 2021 13:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y/ZVcjvrOjTQ0Dc8WSLSUrXRuA4o36h0bl/L74FNWlo=;
        b=Okz+++657Awg3VBLaFnhbWcL8N1LBqhKjDdV9kJXbsBo62eyhhunmpy4iq/1oh5NOr
         HAkmGEUKvsUGVzWn+uJ4V/EQh0iXq6gR9J8srbzEYjToula305stBl+36B25Ewfa31GC
         CblACqxfiXtdrQPdAfZ4QBKd5r+hwPw0P0jrlISFjtbKfwFtD9sbqVGlDp395no4fieu
         W41ce4tqopeVUKn6w9QiwFeOsyNBSQz0E5toogGx/yrgKcQ0ezvw32yu9nc6tDPl7tjt
         IXcC1qPcMenNhLUkLoId3RCx6NL6+CZwFwXDzTI9KdF+QjWDAQ9KzYrlraJDOkEUx/KO
         Yj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y/ZVcjvrOjTQ0Dc8WSLSUrXRuA4o36h0bl/L74FNWlo=;
        b=kgYoarsrHKDTeAKXi4wcDf3AFtydewvvFAHFnbLfT4mCZ4C6dQvNy4LSZNLgd5Khbj
         abFjE0lstGnwhUoM4AxxohjP5s2LGAzW4rrrhYycUh0zi9BKLT4ccRevXKafSNTfRUOc
         Qg2rceIM2mw3rJsFY5BUjue9lK9IY1uJxi3BnYGvvxSU+3BNOiH3h35nojwU4ld37s02
         wjQub3o/GaqWutwf5FB4zBtKOo8/iapDf74GMZeCPaxEzE2nstlVHRi+gzCrDbAxTDgl
         df8P96OAP2UZf+OdzLU2xAFLy8vlpyrrekGJGyqYpMyR5PzMAveQ8Sa5nmODouoMROfK
         Uv9g==
X-Gm-Message-State: AOAM532zQUz2Vs5jD3dbEpA0k4OBFXq95NFzkTdEJE1sreKvYycinpHT
        qSzPQGjhyKja8cZYpL0a+pt3xjlKTlI=
X-Google-Smtp-Source: ABdhPJxiCOxLQjpfL+R2es6NHT1t+LY88/yP151OhBS3m9NwG7bNNy0oud5fdHavKDTECrrONuZx8w==
X-Received: by 2002:a17:90b:3b8e:: with SMTP id pc14mr18303926pjb.129.1639085454410;
        Thu, 09 Dec 2021 13:30:54 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s5sm620496pfk.65.2021.12.09.13.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 13:30:53 -0800 (PST)
Subject: Re: [PATCH v1 2/4] MIPS: bmips: Add support PCIe controller device
 nodes
To:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20211209204726.6676-1-jim2101024@gmail.com>
 <20211209204726.6676-3-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <26e6eb5b-858b-4b4a-e6cb-7b86bb312379@gmail.com>
Date:   Thu, 9 Dec 2021 13:30:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209204726.6676-3-jim2101024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/9/21 12:47 PM, Jim Quinlan wrote:
> For Broadcom STB PCIe HW. The 7425 and 7435 are MIPs-based SOCs.  Not much
> difference between the two for the DT properties except that they have
> slightly different PCIe interrupt assignments.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
