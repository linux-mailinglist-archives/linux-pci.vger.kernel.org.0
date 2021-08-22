Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6453F3EC2
	for <lists+linux-pci@lfdr.de>; Sun, 22 Aug 2021 10:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhHVI4f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Aug 2021 04:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhHVI4e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Aug 2021 04:56:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D05C061575;
        Sun, 22 Aug 2021 01:55:53 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id x2-20020a1c7c02000000b002e6f1f69a1eso11905806wmc.5;
        Sun, 22 Aug 2021 01:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pe2cxYTU35zCmd6K7ClNeA3FLV7YkQsHmnGoH/EDgPo=;
        b=hfo0nWsD5ArA4ektXpXw/T4eXdq71PYcPZh+nrXYeTOoFCZ764v9/0Vf6Pp3Dp7d7g
         /PpTeDZP3QYwTIzgyGcWICI5ozGMpIJPvbBc5fB8Jg0UuIACU31a4EpB/wZ45EYdZbj9
         WrgHGptfMjp4AF3PTE58TxP4+rTxUDRM94IdOMEPchtXEONYvhv7d8vmtnU0iglh7cR+
         RNpRx8bw9j0rViAoE5NzAudPNX6VhjM5zSuwe98dnDs9HZmCrhj1PLkFBKimRjzv18Lf
         wSr4gByfKJhSwPS02EHMPxkQENY0SBO7qIgvPudVkwCZY9EVPlg5lm/BrjymR1zcQEyR
         x11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pe2cxYTU35zCmd6K7ClNeA3FLV7YkQsHmnGoH/EDgPo=;
        b=FyW0qVLpH+pgvkVnXnopMk2BkT3Ncg32xmV4c6bseN5VYOd2ZVgzG1SFVt7tTZKMnz
         UUrI7ri/mJxkzl95Y5EYOa5RSuo4WoVWEtXKJ/RpplJ8lWluwIhi6QJgmvHGR+VMmNFr
         SLP9sTSeNqHM5UF7tKqIJNeEJr89k/H2HGcv8EeiSKFFGcClM2BKbLTEbmmCIeh+urlz
         EZQ3RG++97XM/0+geSmWnVafTIXHN75j+pWz5iSaA3VwyTLTLTpeOShj6fpByyT8wi2X
         5P4uB+pDJInYfkVvAAKij5CvFegmuS0cbFucUOuoTatvYfcBtUjWeLZ7VC8Hixd2a65E
         8Y0Q==
X-Gm-Message-State: AOAM5336p/qJwzeJ3jO9xaGijNZQL70SxqoSuq5sG9LXY7o1dYLbXN89
        QbD7FA203djaibXKwvXniHlDfUQdf9AXzw==
X-Google-Smtp-Source: ABdhPJzRmfoLK53kCyNgYR0q2bXAc9ELX+LjH7O//q8n55Qajfho/rvL7U63cWLHLuipE5plgI05oA==
X-Received: by 2002:a05:600c:1d06:: with SMTP id l6mr11353079wms.18.1629622552318;
        Sun, 22 Aug 2021 01:55:52 -0700 (PDT)
Received: from [192.168.1.22] (amarseille-551-1-7-65.w92-145.abo.wanadoo.fr. [92.145.152.65])
        by smtp.gmail.com with ESMTPSA id s1sm14814844wmh.46.2021.08.22.01.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 01:55:52 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] MAINTAINERS: Widen brcmstb PCIe file scope
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        nsaenz@kernel.org, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        sdonthineni@nvidia.com, stefan.wahren@i2se.com,
        bcm-kernel-feedback-list@broadcom.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210820190917.GA3340819@bjorn-Precision-5520>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <44703985-286c-4f57-c4ef-7b4cbd82a8d7@gmail.com>
Date:   Sun, 22 Aug 2021 10:55:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210820190917.GA3340819@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/20/2021 9:09 PM, Bjorn Helgaas wrote:
> On Thu, Aug 19, 2021 at 04:56:55PM -0500, Jeremy Linton wrote:
>> The brcmstb PCI hardware is now split across
>> multiple files. Include them in the maintainers
>> block.
> 
> Rewrap to fill 75 columns or so.
> 
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   MAINTAINERS | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index fd25e4ecf0b9..605a385cea36 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3500,7 +3500,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>   S:	Maintained
>>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git
>>   F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>> -F:	drivers/pci/controller/pcie-brcmstb.c
>> +F:	drivers/pci/controller/pcie-brcmstb*
> 
> There are already two entries that mention
> drivers/pci/controller/pcie-brcmstb.c, and a patch headed for v5.14
> adds a third.  Do you want to update them all?

That would be a good idea, the patch that Bjorn is referring to is:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=e647eff57466c8cf7547532d6b26166b9b17f341

With that fixed:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
