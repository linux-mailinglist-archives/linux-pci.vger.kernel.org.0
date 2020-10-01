Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82CE28073B
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 20:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbgJASvf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 14:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgJASvf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 14:51:35 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D67CC0613D0;
        Thu,  1 Oct 2020 11:51:35 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i3so522511pjz.4;
        Thu, 01 Oct 2020 11:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N3DV4N7weQ7Ou//3dPsMRIwTkhZJReJcjzu+S/ntzAo=;
        b=NPGOVp63IBaHrDrKVdIGxIf4hNV8B82gxs525CtjA4QjEiv1MyIiftLHJK4d26+LU7
         WD1MRMS3ygWAHRmHxYusNY6unBdd52aX82NUteEI6ymYKQ/Mf4aSmJWlM7+7sewPpauH
         p03NRRikMuR/2Ax8/ESvjgVSLA336Tzd4/Pli20ZVoDG9SY09ZiD4cFU4o/r3CxKl0Pl
         +GrExvRL8u7uejUpvwUQDx8ISa0RXUNRrbxuS+yTvedbwN+3fdL878PzTAx6mc7CY8FX
         5Zdj9q2h374MH2IM/2srcP6Wt13crde3b5Zt51xHw1Vm2gXECRbjR0LPSO+ubftwDvfF
         3cJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N3DV4N7weQ7Ou//3dPsMRIwTkhZJReJcjzu+S/ntzAo=;
        b=XhZ87AxQr667uujyRe6wN/MTEQe50OcWRXq52ZxOrOc4UUGKsGnI6M5fwFAc+9UxOf
         kSFHsk9fTv+JWOL/OI29Pa3AGnOQ5bd076taqXvKrD3MmeRdyP+hRqAWii/4WTTTTutA
         D84xhvICH2VzUJj05elKNgkoCUeD4kpVW6Cg2iTkz9VNbe0HkKjuNQmpTPDfCPuAxl6l
         h7Ms9Pc92qa+6FHQ2vp1hCJZ3tHqPEZei0aE+O8R1aTDpKM1DiPHVTu87yup1Fmh28Xq
         TjRR81uCSVQ/dNR0DA0+pmqXKkgTDTZAwFM9JztJM9+x6QiISiXd8t2bYxLrXiK0W7uQ
         LYjw==
X-Gm-Message-State: AOAM532P7rCgmfhVp1sPewX2cjVWsFA6Ow6adiHcP0iT/6Mrxu3gtAPg
        7HaMHahY0U8ZHdiN9j9+LFYZ+KZown3ajQ==
X-Google-Smtp-Source: ABdhPJy7EmAAKY6yXWReEWSAEVNknvnQdSjS71pSITrGt9qQJ0UiPsgO/RIolZDo93q/scq0fVMR1g==
X-Received: by 2002:a17:90b:4a0c:: with SMTP id kk12mr1160427pjb.223.1601578294688;
        Thu, 01 Oct 2020 11:51:34 -0700 (PDT)
Received: from [10.230.29.112] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j4sm6911674pfd.101.2020.10.01.11.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 11:51:34 -0700 (PDT)
Subject: Re: [PATCH v1] PCI: brcmstb: fix error return paths in probe()
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jim Quinlan <jquinlan@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201001151821.27575-1-james.quinlan@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <486218d6-734f-6f68-4c89-67e541e40377@gmail.com>
Date:   Thu, 1 Oct 2020 11:51:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201001151821.27575-1-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/1/2020 8:18 AM, Jim Quinlan wrote:
> Fixes two cases where we were returning without calling
> clk_disable_unprepare().  Although there is a common place to go on probe()
> errors (the 'fail' label), one can only jump there after executing
> brcm_pcie_setup(), so we have to add clk_disable_unprepare() calls to the
> two error paths.
> 
> Fixes: b98f52bc6495 ("PCI: brcmstb: Add control of rescal reset")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
