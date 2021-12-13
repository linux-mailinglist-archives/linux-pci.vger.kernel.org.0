Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F24473443
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 19:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241899AbhLMSpD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 13:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbhLMSpC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Dec 2021 13:45:02 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2355FC061574;
        Mon, 13 Dec 2021 10:45:02 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v23so12485191pjr.5;
        Mon, 13 Dec 2021 10:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZupeclOAcso4hoqTXtQMuYwkfCRn+B/m6AVve583m9M=;
        b=GEdbu4YM0X6HdqWNpX04pzIBj+5bAAoWMx5sl79LeWXJo6hbEZl/51U5b60G72F2WZ
         5mu3eI3POFDT9c4rhadGM0tuhWW4GLZegAX02hxns7SDlKzAOdruWEWgbzos51uW9yeh
         iaR4eGt28fGuM8LjxMPLwclTgg9PyptS2zHQmNSTvfHYmjezoZwkzQbEpbJaEyjyyOSa
         HCQuOi/8OTx6/WFR+GHBRlqmewFQUlrIOFF2NCMm3rlG3pM8zktS7d+s+6XO8SGLQKXC
         BDE0ZucAnlf/VvPGe0Nt58d2GPfdINIpNFZAyjK7/ONTviTGyXtug4X77HZjN068zRWF
         ChOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZupeclOAcso4hoqTXtQMuYwkfCRn+B/m6AVve583m9M=;
        b=V1OtS8VQKaC1NQeYIhRLFg1c8JPzx1xYDxx/HwYlXBxdMkfXr5rgq9JjWu3RNtMbUU
         XX3GHOpVWqPw3nNJpAHaGRCvNU885FGvAqAR/WYqWIvDWFnIbUal5lyUnSNk2VDjVQfC
         66Izigtw92vfoiWxxcitWvET9NqzClRsxf5yGLQlol+iTssuMvSe1T4Jq2rQFyM5e/h/
         wfsb/OG4MCKD8nT35QIwAcWEVecalbOMn7gWsBMlNc9G8vp+rLoPg+Fi+/OIV9cCL8Fz
         tWFR/OAgIVMP5dVLWXISeZAB2MCM6kwF8/csAQHcHMobOmYY1cQjh3PDg9DOTk+MwWu8
         g76Q==
X-Gm-Message-State: AOAM530N9S2WtLka03UPNAqJL9xLEXjuBsto91Jw5cWAtk0N9Q/E3CDJ
        kQ9F5OZNaYurkSZ90gncRb9cv9r+/II=
X-Google-Smtp-Source: ABdhPJzk6Civtv1xJEpbs8vx/aixI3f7kcE49mJsPddPJQJibfNcjf34SJQUA53BLHcPsHkxnnM/9A==
X-Received: by 2002:a17:90b:4b4e:: with SMTP id mi14mr72260pjb.122.1639421100918;
        Mon, 13 Dec 2021 10:45:00 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id z2sm13907511pfh.188.2021.12.13.10.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 10:45:00 -0800 (PST)
Subject: Re: [PATCH v4 0/6] Convert iProc PCIe binding to YAML
To:     Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "moderated list:BROADCOM IPROC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20211210200451.3849106-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7d44fec0-bbbd-c15e-9d60-1a0ecd962045@gmail.com>
Date:   Mon, 13 Dec 2021 10:44:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211210200451.3849106-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/10/21 12:04 PM, Florian Fainelli wrote:
> This patch series converts the iProc PCIe binding to YAML. Given there
> is a majority of DTS changes, it would make sense for me to pull this
> via the Broadcom ARM SoC git tree.
> 
> Thanks!
> 
> Changes in v4:

This is not what I did in this version, I will send a v5. Sorry about
the noise.
-- 
Florian
