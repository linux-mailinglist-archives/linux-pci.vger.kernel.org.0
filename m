Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA135F7E13
	for <lists+linux-pci@lfdr.de>; Fri,  7 Oct 2022 21:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJGTgg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Oct 2022 15:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJGTge (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Oct 2022 15:36:34 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519D8100BD9;
        Fri,  7 Oct 2022 12:36:33 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id mx8so3695221qvb.8;
        Fri, 07 Oct 2022 12:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zT+O0QTiUdGcu5fC+oP0NDvqRtFHHQvCkGaAkhwWHIM=;
        b=QZzbJAVg4gJHSRBIeJsh9srTdDG/mC6KUiT1/ZODb+OB/axESaJz/5W+hhGEOM619E
         PZvvttamZyoatc4n1BXHEUvD1Um/W5UK9fRarf4dq9QVhCWp+D2KOLQXvr/z/WDIomsb
         16Cw+4p6GzHe3EDRETnJ0eq03WJWtwa/jA0g2pPhUmAHbUXubqqDSnaGhrHERAbuxLqW
         cVzSFGL/by+v8rD8zLzlWC7Y23JODljwnjXne83NJGnMj9Yg9KPYCXdsBgrsSvDeNEzG
         4Voi2zIt4f2HPtG6+xTDgF+BzZk4AvQtSzeFaq5qUk6yvcCDIQYBXTZnHa8614qUWoQh
         O6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zT+O0QTiUdGcu5fC+oP0NDvqRtFHHQvCkGaAkhwWHIM=;
        b=8SQAVQRPLFrl7EeqdIuC5P2WLJGDGYE/24VfE2tTzHMujcmg/ed0RJDJmCNND06oGQ
         01jcJieZSqgDa9Gwku8L4lzISy8e7GA55ILgBZrsZn6e7THDJnO35/t+bWNy3AKM4qkH
         Ggq/FByk6LRnSEhlL9tClVY88PQqly2SvlGszA8+LzPR6ZT7yvO4WO8RaMjewy5R7noq
         5I6hSfy4Q2Kcqi0KgYB2UbdaxZHP3QVAyKMNu1F+ZjsQALtKQsqTvuL+doqWQzRYLTBy
         xCQhhqfsxB0RZRJ8n9WrVMi24V/VRnZGjsf3xfoaMDM9wN6UW1IZLMX9TopTljp+DsyQ
         L1hg==
X-Gm-Message-State: ACrzQf1pvckkfRk1Rg7vHE3HGg/WtiH7WTahP8z0yQoGpP/1Jxxft/82
        lczq+IT/fKkLColBKaRw3dA=
X-Google-Smtp-Source: AMsMyM7fbhFjefNeCTZ2HYs/Zh0cApdxSjziQfBuB7lYZLPDLzvnuIgzMW+UGKNYSLZm2xvMNkr9aQ==
X-Received: by 2002:a05:6214:dc2:b0:4b1:7f96:50dd with SMTP id 2-20020a0562140dc200b004b17f9650ddmr5629094qvt.34.1665171392449;
        Fri, 07 Oct 2022 12:36:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c20-20020ac86614000000b003447c4f5aa5sm2715018qtp.24.2022.10.07.12.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 12:36:31 -0700 (PDT)
Message-ID: <26ccc8e3-c40b-e77a-134c-4175694c587d@gmail.com>
Date:   Fri, 7 Oct 2022 12:36:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/5] PCI: brcmstb: Enable Multi-MSI
Content-Language: en-US
To:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221006220322.33000-1-jim2101024@gmail.com>
 <20221006220322.33000-2-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221006220322.33000-2-jim2101024@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/6/22 15:03, Jim Quinlan wrote:
> We always wanted to enable Multi-MSI but didn't have a test device until
> recently.  In addition, there are some devices out there that will ask for
> multiple MSI but refuse to work if they are only granted one.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
