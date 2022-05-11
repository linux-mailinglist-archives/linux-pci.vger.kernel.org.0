Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7833523EE1
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 22:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbiEKUZE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 16:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344541AbiEKUZA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 16:25:00 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281DD72E2E
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 13:24:59 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c11so2930175plg.13
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 13:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7DHaehMDrh+03QkM5bqozyiHYpbroPhOjibyo1d3f6c=;
        b=dvgBF7ZyO/9FAMpMHJWydksAMiUwTsq3BJsWkuahaTHwQna24VsNFBREJJ4dgguD8X
         L+7B7KkTZyN7Y9C/Ov4d6yd59jeHfNFB9B+ufRP6dibTDzBDfFBOq+IYro6uck6UISGD
         x9WzYQaxQpm7IxEZh7RSM1Tp36k2ibSyx8C6rNWNeTWecX1DJzssi+MNC9EDd6iKw16a
         ylVCcONKMzEZ+x+jAz2B2qlcTGHNR5GJyBQ93dNaJM9bK9Udoiuil/ASR+pTwH1ENgze
         AN3U4362aG3HGjEyt4rv45361EyZ/7ZYIPYtI4NQDpKQIjdXjC3KtLr0KbH4kQvKZLgE
         o7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7DHaehMDrh+03QkM5bqozyiHYpbroPhOjibyo1d3f6c=;
        b=gtnfEucRS9Nen9lf3ZErur0/XOMd+JJpStApIGsRYtYREUwjcB9NcSupY6AsVabHaj
         YH/WC1kcQYbos7xUdLm9hicitoIxXCGSzi83BYb5OmHt0xDwprVlXEuQaPpUAMW2vhMb
         KMhsAyxoLsCA9Y6xth3cXLlq0EJ/BPiWqIQQFwKHUO3XQiFMtxwCCUHHP52FCg72d6pt
         SCi+1KI7tGU+DFjgP4nhSBB0Rf6TjdLGrYIDYy6HWQhyCt+XnmGi1sSM6IiOjpyBURHE
         kiPYgaAh8/jwnIvKxlSOZX30jPDWn6fQwWiM2y9qh5wPFCkNn5E7cRHVT/jaYF+H6+/K
         BtdA==
X-Gm-Message-State: AOAM531kgXRCtWcGO+j8ERC+YFeO1UIJAfwpDZDA6QSGI5KoF/K+LTvT
        uPp9ojmXtiGYMoMQYhwlEeo=
X-Google-Smtp-Source: ABdhPJzEF6Skn5sgMrWIE7eSe9jrqlrgN4p0n+NkZxLiTL7kjAtQbXjDrBpKFgt5681tfU1mFbieHQ==
X-Received: by 2002:a17:90a:7f94:b0:1cb:1853:da1b with SMTP id m20-20020a17090a7f9400b001cb1853da1bmr7095881pjl.14.1652300698522;
        Wed, 11 May 2022 13:24:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u11-20020a17090341cb00b0015ee60ef65bsm2340389ple.260.2022.05.11.13.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 13:24:57 -0700 (PDT)
Message-ID: <f9be7d36-d670-ef6c-8877-5b38e828e97f@gmail.com>
Date:   Wed, 11 May 2022 13:24:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/4] PCI: brcmstb: Revert subdevice regulator stuff
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
References: <20220511201856.808690-1-helgaas@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220511201856.808690-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/11/22 13:18, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Cyril reported that 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup()
> into two funcs"), which appeared in v5.17-rc1, broke booting on the
> Raspberry Pi Compute Module 4.  Revert 830aa6f29f07 and subsequent patches
> for now.

How about we get a chance to fix this? Where, when and how was this even 
reported?
-- 
Florian
