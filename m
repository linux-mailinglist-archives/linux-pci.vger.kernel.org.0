Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912181ED75E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 22:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgFCU2o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 16:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgFCU2n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2020 16:28:43 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96595C08C5C0;
        Wed,  3 Jun 2020 13:28:41 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q25so3457222wmj.0;
        Wed, 03 Jun 2020 13:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3VXmnF8EgRzJMbsjtWg39hj09dVW44ZQvW/fSfCfu50=;
        b=dWUP+E17zB853SpZEYOkqg8Gp5ynOn/p83i0ZdAN5G5Rh/N5BKGD6iqxv/Kofw5xh5
         FhFWNvM36f2HwaGYzXS3KJzUKJ43aYMI0p4bf+AoejqNIkdRXQEGSkkxZIOPg8uXWMXA
         gNJUl7BsHXPeN4Mcs2G5SYiuG0wPE3gGhLOSxSUTORhS8CMhMUVnE2ajepQ14ADoK9o2
         mCGprtkSS617OxVmja1li4HeTReCuFSeFfNZWyoX80y9RG4nDlKyqcwmkfLuS4YR8dXH
         ZTWIXgfmv5PhmbsRsx5MzkUkgEEU0upz4LyXmWcpEbQC53fXndP2HCwo20oo7kiCwVnO
         wyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3VXmnF8EgRzJMbsjtWg39hj09dVW44ZQvW/fSfCfu50=;
        b=dECT6wju2ht02PtLHBtgvB2NsZqCV8lyGrjHeK4dfWNUgZqa59UBhqZU4JeQF8r7sZ
         v7jbQFftkaibCX+fBV2lgg09aZDe1aa2jLbCU96z6u19NMWa9ocndnruxy5N7hNobdCB
         xPzEmcoXxIAgpJfuRqqwQZMqRiqs5gSp38laxfqVv6jhKGDb9/CjGcoSBlKpuHGJ8MZr
         ZUsXRJRsbVA8xQ+t7y4b8G9Vr1TYyXx4W36jZMICWoA1d43YEwsfacimd7Q/EKFAepAq
         8IZJLiFYPFp0TB777aLLXTSRhXfwumLDPj5cAXCxr4bsNaRS5T9BmtFdhpK+5C1fb+ES
         TaqA==
X-Gm-Message-State: AOAM531ep1Bm4yF/j6jr0KEA/+eD0iVSSopybKN9FvZdE9TOKCUo1yEZ
        d20e7B4Hkv4fdhTnG5wX59dMyasu
X-Google-Smtp-Source: ABdhPJxfIcfzNSx+0MJQ/0Rpmj3SLcdYcgyaETO6dW73dHwzzZzmqSBI5u7tSiWbQvcbjVKQNlvnmA==
X-Received: by 2002:a1c:b445:: with SMTP id d66mr759225wmf.29.1591216120140;
        Wed, 03 Jun 2020 13:28:40 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id z7sm4659054wrt.6.2020.06.03.13.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 13:28:39 -0700 (PDT)
Subject: Re: [PATCH v3 06/13] PCI: brcmstb: Add bcm7278 PERST support
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200603192058.35296-1-james.quinlan@broadcom.com>
 <20200603192058.35296-7-james.quinlan@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2d42e5da-8c84-7b7b-45ba-3a24d091ede8@gmail.com>
Date:   Wed, 3 Jun 2020 13:28:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603192058.35296-7-james.quinlan@broadcom.com>
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
> The PERST bit was moved to a different register in 7278-type STB chips.  In
> addition, the polarity of the bit was also changed; for other chips writing
> a 1 specified assert; for 7278-type chips, writing a 0 specifies assert.
> 
> Signal-wise, PERST is an asserted-low signal.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
