Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7613A3DFB8C
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 08:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbhHDGrX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 02:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbhHDGrW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Aug 2021 02:47:22 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92188C0613D5
        for <linux-pci@vger.kernel.org>; Tue,  3 Aug 2021 23:47:10 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x8so2738488lfe.3
        for <linux-pci@vger.kernel.org>; Tue, 03 Aug 2021 23:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4L5C9qrfvxf2bLH/dJuxNea8Tx+I1a3YCfc9PAs4P7U=;
        b=Il/VCEqYlC6ksvcMadJhlPAmuN3qhS2Lt4yyz2/kXEqvxXrLwdykT1Gx2LRuqStLPn
         DtMKhXob1sGbHw8m0B4DjsfKi2LpFcURW6JuroRHTLQ2sJbbH4wKeje7S1c2iipCRjmO
         k09aO5mNKEO9a+UvI/YZP4gDlUhfS8xLyD6xR3JIyWaD2W5PW1L1w2LUJjy7DnNdNQbb
         x4myEr65cZQhnHZB3Qae7yG1V8PnLnAw1+6RsleeM+PFzvVfl9NBlMyHooMyyzeDRUyy
         LIvHZqpkLmidUTyLR3rsj6xaUNA/LLcBhrHckGrpTyIEc6iB/nN9ADEzEqgW21YCqWaN
         WBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4L5C9qrfvxf2bLH/dJuxNea8Tx+I1a3YCfc9PAs4P7U=;
        b=PGcPZJhvCIciHtQW4Mv1Oo0U67BWhTcUycgaoLidIXeabPvJF66IM36Nf2myyTjs4N
         672C//zsTx2mPH/tA5hGKSOQA3SWWnpf60rFDkrd/4qGRmOx1iM90iuHvY4dvajLyZ6N
         EMYJnYfunBn2m0Hg67WWi/9Ptk/bi3GCK1x3jX1f0/LdLgd0rZkK58RSE8o9oMzaecP/
         VBfp464udcKmOQFCMrP8wvo1RRRY+1z6uYgg4fhZegmTKexkJProUcuioY1bQSBgtMxV
         jQTLNTh9oXSe8qqzegC/U6Ck1BgHMMpJxkCNPyjdZUaRmil4MYUF3aTeBcwr4hgpCODJ
         LmfA==
X-Gm-Message-State: AOAM5310nUjQ2G6dUjKbWe8fB/5lOwAuLqx5QK+DjOtTXNIM+urWrrAa
        EVObrSWxNQetW9EzXtLfLEc3OfhpOXRMhg==
X-Google-Smtp-Source: ABdhPJxi11SfTIBDXlBAjy5KtHRdUDtJ0ibrwT78Sx7PJjwGirhoi3cGr/5LtfStPPFEFbG63rnSVw==
X-Received: by 2002:a05:6512:318d:: with SMTP id i13mr840978lfe.627.1628059628978;
        Tue, 03 Aug 2021 23:47:08 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id j6sm105858lfg.186.2021.08.03.23.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 23:47:08 -0700 (PDT)
Subject: Re: [PATCH 1/2] PCI: of: Don't fail devm_pci_alloc_host_bridge() on
 missing 'ranges'
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Roman Bacik <roman.bacik@broadcom.com>,
        Bharat Gooty <bharat.gooty@broadcom.com>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20210803215656.3803204-1-robh@kernel.org>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <43cf8f88-dd3f-5060-d300-4deb95dc371c@gmail.com>
Date:   Wed, 4 Aug 2021 08:47:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210803215656.3803204-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03.08.2021 23:56, Rob Herring wrote:
> Commit 669cbc708122 ("PCI: Move DT resource setup into
> devm_pci_alloc_host_bridge()") made devm_pci_alloc_host_bridge() fail on
> any DT resource parsing errors, but Broadcom iProc uses
> devm_pci_alloc_host_bridge() on BCMA bus devices that don't have DT
> resources. In particular, there is no 'ranges' property. Fix iProc by
> making 'ranges' optional.
> 
> If 'ranges' is required by a platform, there's going to be more errors
> latter on if it is missing.
> 
> Fixes: 669cbc708122 ("PCI: Move DT resource setup into devm_pci_alloc_host_bridge()")
> Reported-by: Rafał Miłecki <zajec5@gmail.com>
> Cc: Srinath Mannam <srinath.mannam@broadcom.com>
> Cc: Roman Bacik <roman.bacik@broadcom.com>
> Cc: Bharat Gooty <bharat.gooty@broadcom.com>
> Cc: Abhishek Shah <abhishek.shah@broadcom.com>
> Cc: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
> Cc: Ray Jui <ray.jui@broadcom.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

You're great Rob, thank you!

I've tested it on top of the 669cbc708122 and linux-5.10.y.

Tested-by: Rafał Miłecki <rafal@milecki.pl>
