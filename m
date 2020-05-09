Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992361CC4E8
	for <lists+linux-pci@lfdr.de>; Sun, 10 May 2020 00:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgEIWTr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 May 2020 18:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgEIWTr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 May 2020 18:19:47 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3391C061A0C;
        Sat,  9 May 2020 15:19:46 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id hi11so5894867pjb.3;
        Sat, 09 May 2020 15:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NkwAQKO2nZlE3uuBtirHEeDdPuKbR6INkJzbMlhdoGM=;
        b=p08x8dH39ft2EvqtkKyWxm6u3j1uepE5xgigonFpPcCaL7pz8f7c4mNaIApkiqCRf7
         ZlZwGTnJW6uc+Qvr93iKAvozlbaMrQbuup7RD2Y9peh7MyYHG07m+3PWkVkw1pJT8JC1
         VL1P98ptWKsbQKEOtDW79ElLUMjyLV8IZwi//FkYkjbgsGWht95Y5N8vCvx9G7UI84db
         uSPEuPa+z26OYZty3R2LYyiyMsiEEdq92pZb8rdN2+7aNEW6rD5SKhWotA86OZhQirOv
         dSvE3LaRcydncvMsIlJEla4/UwGVTR4PiMI4SjHsBftRcVYjyF2HQO/B/pGWCtJfDVvg
         DuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NkwAQKO2nZlE3uuBtirHEeDdPuKbR6INkJzbMlhdoGM=;
        b=H4+cMGkLY7bzoI7aFo3ZH8VJyxsKplBD+15eCWcNLi14JrjhOBOaEzxYyWY9RIS2yK
         lTLFto4iGgtcHf7U+qVkug9joothPUxtdo2nDFEtMpArMfIg79aabjgMOR+rBIrkQ1F4
         bMwlSfpPReDAJWxRLbZZHfdRiUeYWmeIrhJPC40g2JolFvyCNi0hL+xIQ/f8q2oTqJ0W
         JzCo5cP/DagIzE8A7rH7DuzqExf8FIQa2qwbZQ1GqNFjvo8hiBlCm24Q2JsqGW5QtCxF
         Vj9+D3xRngeqHX/gUBEJTBihpObt/8N3/3dCdNnMkhATfcqUxB3X81tvGk3yB2rW7Jg1
         YTTQ==
X-Gm-Message-State: AGi0PuYV9kGEpd/xhngl0K0bO953N1Vyr2dY9YuGimd3Na21RCY5vb6u
        I8X9aHkG5bQDkGs3B/fTc8mMIqDs
X-Google-Smtp-Source: APiQypIXgc7qu73pCxyXNa1FW1rsCbNwZljJv3oOpWJpxoGIVjkjScxoQ1F0PMQJBqMZwKnQC7LE9Q==
X-Received: by 2002:a17:902:8349:: with SMTP id z9mr8810894pln.38.1589062785729;
        Sat, 09 May 2020 15:19:45 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p1sm5975566pjk.50.2020.05.09.15.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 15:19:44 -0700 (PDT)
Subject: Re: [PATCH] PCI: brcmstb: Assert fundamental reset on initialization
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jeremy Linton <jeremy.linton@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Jim Quinlan <james.quinlan@broadcom.com>
Cc:     s.nawrocki@samsung.com, tim.gover@raspberrypi.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200507172020.18000-1-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2ad744e7-53df-2601-2d04-891facc95154@gmail.com>
Date:   Sat, 9 May 2020 15:19:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200507172020.18000-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/7/2020 10:20 AM, Nicolas Saenz Julienne wrote:
> While preparing the driver for upstream this detail was missed.
> 
> If not asserted during the initialization process, devices connected on
> the bus will not be made aware of the internal reset happening. This,
> potentially resulting in unexpected behavior.
> 
> Fixes: c0452137034b ("PCI: brcmstb: Add Broadcom STB PCIe host controller driver")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
