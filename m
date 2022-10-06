Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325905F7107
	for <lists+linux-pci@lfdr.de>; Fri,  7 Oct 2022 00:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiJFWPr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 18:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiJFWPp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 18:15:45 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD5794101;
        Thu,  6 Oct 2022 15:15:43 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id m19so1974031qkm.0;
        Thu, 06 Oct 2022 15:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YPWRIyFmhTQi1c/otJ8TX0Tmmc42emcIyNa0up4l4yo=;
        b=W87/Zvc7ynN+Ty65Y+E/71kKnu5Jf6PXk+3EZ5rZMx+QjgI/bVXu2a8xvXWTUHserX
         I8b6x8gW/0WxvUhi7UcWj6M0ioXgZMldgrDsBs6lw5oiH/IoPgwcJ9Wpcr/m70tDXgt1
         MAooNIycPcieVkHBJeZrd2yg4IJZDFnTssu8skUrBxnvCQizuoVSBLt7rhdYCLHG1lXg
         hdMFV1VLpD6oDRJgG+DEXVNON3g+kKR7oeG8onEK9/Jp8X7erc2Idkm8q8Gu+yxjb145
         NXBe5h7E3zDjxjKxUiLZJXq9NIu09bjyDonl8Byu6LKcDs1p85x8yYvrPQvErQV/FxwX
         vNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YPWRIyFmhTQi1c/otJ8TX0Tmmc42emcIyNa0up4l4yo=;
        b=EQQCB+jJ+Ek3yXKny+JlUYkYhyE9Omk4yBDbeY7lsmBv3WVYiFzhZh7LzlIEYbLYnP
         UndM8SBAPwzjJwQvKrFHT5spmaNF7CbmR+ZQFbE8tX50NdcONgN07MPkn44jaqz5CcxZ
         m+fArqzysH0WSZZ6HOE8gxXnCSugm2LsF40n+eRMWKWUxddM3N5aNqPO2m5PJabd44xA
         VUYU+6Q74FiYEbiUcZPlqjM2X4vfle8ASjRPUC7onJXrgf7HMhYNFcAyVUFj8/bwB61h
         m3wv1wLR30WTZnoOQ/ioXdDc6qd+4FmCLi22akwYrA/a7oYXX626Ud8jcCQ+EE2ovfX7
         FX0A==
X-Gm-Message-State: ACrzQf0wkM+ULtyd94bFWwy/olM9SxdLDwOf+3k8pWg45hxxQGROPIkW
        VplrO+qDHS+Uj79TfL5ETiE=
X-Google-Smtp-Source: AMsMyM51opGZhOExAempF9+D9IWwsWjIZlTdr+SSmUNWiMJj6eX20GtXeVEtubbEE4nXa7U0V5oe3g==
X-Received: by 2002:a37:ad0a:0:b0:6ce:1769:6f51 with SMTP id f10-20020a37ad0a000000b006ce17696f51mr1921506qkm.522.1665094543037;
        Thu, 06 Oct 2022 15:15:43 -0700 (PDT)
Received: from [192.168.1.102] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id z22-20020ac84556000000b0031eddc83560sm599278qtn.90.2022.10.06.15.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 15:15:42 -0700 (PDT)
Message-ID: <fe838f93-dfa2-e21e-896b-c1e836405e92@gmail.com>
Date:   Thu, 6 Oct 2022 15:15:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1 5/5] PCI: brcmstb: Set RCB_{MPS,64B}_MODE bits
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
 <20221006220322.33000-6-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221006220322.33000-6-jim2101024@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/6/2022 3:03 PM, Jim Quinlan wrote:
> Set RCB_MPS mode bit so that data for PCIe read requests up to the size of
> the Maximum Payload Size (MPS) are returned in one completion, and data for
> PCIe read requests greater than the MPS are split at the specified Read
> Completion Boundary setting.
> 
> Set RCB_64B so that read compeletion boudnary is 64B.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
