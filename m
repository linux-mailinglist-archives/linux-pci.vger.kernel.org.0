Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8E81EDB73
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jun 2020 04:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgFDC4a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 22:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgFDC4a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2020 22:56:30 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28561C03E96D;
        Wed,  3 Jun 2020 19:56:30 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w7so3449190edt.1;
        Wed, 03 Jun 2020 19:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CgBPhORK8BDXStxy7iglUZzxBGtxWPV9iURqby3XwmE=;
        b=N6Eho2OyzAmXXGuG63SRWOa9R4QlHG+qpRjZ6daDg1hO9NR0aet2gMbSke29k7O1qw
         6mIdM6yoQ7NJoj/6gokTPrfn/Zg7Taqn+z57cXmLydYwi1b5WoxyMtGHh5BRkNQTkafp
         VGLrMH63C6swkwg9ITCBxBnkpsNQP0JiJGnzN020O8Abl++Y6HxRPazJRioyx0KFcadE
         knj1KUm0SSjKU9aV+M1bWMl0IHEuR2qj/qjMbCdtB5wyUZ71lUEXI7+7bM0Tx0REczI3
         Rrv1eY1gHseAJ8KSn1t5aMMXtHoSpT6tOzd+TWAweQvKu+cWHZZIYnQy3nHXXd1x+b/W
         MrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CgBPhORK8BDXStxy7iglUZzxBGtxWPV9iURqby3XwmE=;
        b=UYHpHzwju+ucgNqW4YnusbfdBGGSA/shjdU98PQryg3q2VrcJvic++ISK2o7bHU4Zz
         3ioTzDjSwAB9Dc5QROhQYZkrgVIko25xzm7r3Ce8jjhMnb8SFv0VFVMuX7b9l4zHJMDu
         ejmzOHCbqttZss6WMWMVSuyulworszrvBtBJo5N9HoDuLGRvl0alxdFuy6GsxJC04hzm
         int6Iv764WHWlCe/8rTICvd3D9a75qgEvJ2aQqYUvemAaMKpUGH6upALGTQnxnRI03TQ
         I6EeJg3PHgz/YsfGcO2lPrI8DFtAqWknXBMc+Kfzx8muV/7CGkjJ/WUHJE+lBOdBVAsV
         AQKw==
X-Gm-Message-State: AOAM533UbnUYTJWccJTXcC0za0Jx3SaAYwbbvW4mPBaei3IQiphv5u5b
        5YmeYhKIAALHI9cKtf2/pQ+IAP1K
X-Google-Smtp-Source: ABdhPJztfvBspyA3sbFNMMaWRB9lVRm2xItqVmhoCIGh0cVoE0Jd1GUVN3hEHHCI3E/71BWMBrZVuw==
X-Received: by 2002:a50:8707:: with SMTP id i7mr2289118edb.180.1591239388635;
        Wed, 03 Jun 2020 19:56:28 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id j31sm946828edb.12.2020.06.03.19.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 19:56:27 -0700 (PDT)
Subject: Re: [PATCH v3 11/13] PCI: brcmstb: Accommodate MSI for older chips
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200603192058.35296-1-james.quinlan@broadcom.com>
 <20200603192058.35296-12-james.quinlan@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <9c35053c-22b5-c9bc-13fd-1e83e980d56d@gmail.com>
Date:   Wed, 3 Jun 2020 19:56:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603192058.35296-12-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/3/2020 12:20 PM, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> Older BrcmSTB chips do not have a separate register for MSI interrupts; the
> MSIs are in a register that also contains unrelated interrupts.  In
> addition, the interrupts lie in bits [31..24] for these legacy chips.  This
> commit provides common code for both legacy and non-legacy MSI interrupt
> registers.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
