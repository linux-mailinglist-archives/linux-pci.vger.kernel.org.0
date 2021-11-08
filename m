Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F614499B5
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 17:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbhKHQbR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 11:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbhKHQbF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Nov 2021 11:31:05 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D56C061570;
        Mon,  8 Nov 2021 08:28:21 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id c126so8079344pfb.0;
        Mon, 08 Nov 2021 08:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=W522cAUz1VNkkWpIk8aeKJnn1WX3utZOCRBlk8dVNxo=;
        b=j8QJip8KJf/J7pjefQLQ+QHjwUGyXHhZo5OosP3NxTxH4L9Tcr1neULNputik59V4U
         0/w/eHRfLo6y22q6UUEEcJe3r7HB6IJuzUJa8sXmyEfF3QghNrBLk80+X7e7C2VzJMcw
         fGfv2K1tsl3B9efOYpcZMvUA0Mtv5OEIB+RENgHndrbUSj6LTxpkABhm/P44aNQ8R0PH
         vSBeHMhELaSfUN6dsp11ANnCOz8tiFUq1D49bHtQfdnvfKgJri/nPswG2CODs59gT4ne
         5IDCrq2ARLdNV4kyErloFDELnjnRcQVC7JJofxspmMjv/RCHiEQUeRhNHn4VeokRt/yV
         jGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W522cAUz1VNkkWpIk8aeKJnn1WX3utZOCRBlk8dVNxo=;
        b=lM5O6VoKve9pWNnDgsni9IBlkMLLtkywAJQpDeZcQvvi9Zbxli8FefDColPDgsjMuS
         x5qe4ubBG97wbBaPNEfdYTljbdzC3YpjmfkUSd0Pb8kywESWN1Xuu3gVRDDr69KQ9NN2
         b7BOwYYlLm9hX0q24AC35BAGTEHYsC5lepzfxSm6kwzBQvthAvE3p6cDd8oUrB3i+7uk
         xXO8pIy6qDSF6SijXOja1fREI4DJmvinj7buXibOp4Iq7WiJ11oQNrrW8wkjl3lqtF94
         RpYVtq/BwlD+fOgfqghXCsl+DcFbZ+MnUmCH2d/N4cFUcLG5JxLvprtGuasZJqNvmNyg
         Jweg==
X-Gm-Message-State: AOAM530jZkKm/FhuqJvi2xSANR2txKSQ7Dcz24CPHmTGRUu0H3WMQWMn
        CfUNl0yrUnmKOEHk5G/Zj8Y=
X-Google-Smtp-Source: ABdhPJwYgtOPk/If8ZqeWazasT3ASjNeyFgwley+9ngPczU5N6qjaS1xCT1DRfcK8wfav40jqC8Z1g==
X-Received: by 2002:a62:6184:0:b0:480:1759:b74 with SMTP id v126-20020a626184000000b0048017590b74mr390634pfb.82.1636388900985;
        Mon, 08 Nov 2021 08:28:20 -0800 (PST)
Received: from [10.230.24.142] ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id h3sm17596989pfi.207.2021.11.08.08.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 08:28:20 -0800 (PST)
Message-ID: <4d556ac3-b936-b99c-5a50-9add8607047d@gmail.com>
Date:   Mon, 8 Nov 2021 08:28:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] PCI: brcmstb: Declare a bitmap as a bitmap, not as a
 plain 'unsigned long'
Content-Language: en-US
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     nsaenz@kernel.org, jim2101024@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <e6d9da2112aab2939d1507b90962d07bfd735b4c.1636273671.git.christophe.jaillet@wanadoo.fr>
 <YYh+ldT5wU2s0sWY@rocinante>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <YYh+ldT5wU2s0sWY@rocinante>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/7/2021 5:34 PM, Krzysztof Wilczyński wrote:
> Hi Christophe!
> 
> [...]
>> This bitmap can be BRCM_INT_PCI_MSI_LEGACY_NR or BRCM_INT_PCI_MSI_NR long.
> 
> Ahh.  OK.  Given this an option would be to: do nothing (keep current
> status quo); allocate memory dynamically passing the "msi->nr" after it
> has been set accordingly; use BRCM_INT_PCI_MSI_NR and waste a little bit
> of space.
> 
> Perhaps moving to using the DECLARE_BITMAP() would be fine in this case
> too, at least to match style of other drivers more closely.
> 
> Jim, Florian and Lorenzo - is this something that would be OK with you,
> or you would rather keep things as they were?

I would be tempted to leave the code as-is, but if we do we are probably 
bound to seeing patches like Christophe's in the future to address the 
problem, unless we place a coverity specific comment in the source tree, 
which is probably frowned upon.

The addition of the BUILD_BUG_ON() is a good addition though.
-- 
Florian
