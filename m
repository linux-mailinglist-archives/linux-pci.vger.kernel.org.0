Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D93A1ED758
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 22:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgFCU2K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 16:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgFCU2K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2020 16:28:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D32C08C5C0;
        Wed,  3 Jun 2020 13:28:09 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c3so3731904wru.12;
        Wed, 03 Jun 2020 13:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QJoU0SL/WMOj7L3NadynkZeyU/j5E6/2RmbX2dsWEuI=;
        b=O1LVFpMdx6MshAlnzmBj79PlQO5s8ec4kdWGh+y1Lp4Tk4bQ8uKEJuaeGQX+dKGEbJ
         sLBjRjNR7OLo34SNlxhzLOc7vTz6E+Fg1Sz5LpB7kYH1LEG3Z/wasndPb262w/QmQWuA
         s5rtW9C3xatcgDg6G3ErDST7EnfUp2zg7Hz8+CC8ui6tPSTg4HglImmkhr0O69jYImbS
         ynLU+KdOwqP/9VsifF5GkohvIse8OP3jJqFLFp3+lSSXE+qFzax/ZMK4v7FpmMCMjJsU
         vGMC2e9BEhVVsKlQHkHenxKCbb3QPsaBsytEcndI1/WwvvKWVJ+uGTi+SF+vHwHroERa
         tqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QJoU0SL/WMOj7L3NadynkZeyU/j5E6/2RmbX2dsWEuI=;
        b=GokU4CNC9xUCOFWuUfCbkY242rmMICaehFoliQwWNR4m4dcazGk+zEU2MK3oA61EBr
         V/va9XZSUe0EMra61XuQEf29DRWdCavZFd9XqsIKIeF9hFxqrpu0wn36dm0eYe3wE2rY
         dDoVnPgfZ2y6xpq+jUH+DseqE1XOlYoSyRfNTh+TWrOK/ABCr1bpuozKuNFUH9b0beNK
         cPwpglmn4f8ZupLa+yXeIQVsm1JgrcaHCkjMHJB3VxE7G3X+ZRHW4Ni5yWU2PzgT1C2z
         oGVORNbEcOeHX6pPTUuMi7Kol5tvKJTpCHq04y+7MT4U1X6qRqJ2hfOVTOoHz0SH2Xjf
         mGiA==
X-Gm-Message-State: AOAM530Rr/4IvCSLhwvxolFFS60IJ3uoNZWHTXNN5sdWhxSBxL8/sqTz
        A06O8EXeAk/m0h+4GFJHhwA01KGD
X-Google-Smtp-Source: ABdhPJw1wLOdLyU2fIYxiFX1qFroH9/3SElpGfgD5z6nUeWbe6JPFezogiaAwdPas9bXLSZEBmUsbA==
X-Received: by 2002:adf:c98a:: with SMTP id f10mr1043664wrh.329.1591216088120;
        Wed, 03 Jun 2020 13:28:08 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id c5sm5237770wrb.72.2020.06.03.13.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 13:28:07 -0700 (PDT)
Subject: Re: [PATCH v3 04/13] PCI: brcmstb: Add bcm7278 reigister info
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
 <20200603192058.35296-5-james.quinlan@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f93f96f8-7034-d8a4-7959-0da00e6ee0ce@gmail.com>
Date:   Wed, 3 Jun 2020 13:28:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603192058.35296-5-james.quinlan@broadcom.com>
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
> Add in compatibility strings and code for three Broadcom STB chips.  Some
> of the register locations, shifts, and masks are different for certain
> chips, requiring the use of different constants based on of_id.
> 
> We would like to add the following at this time to the match list but we
> need to wait until the end of this patchset so that everything works.
> 
>     { .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
>     { .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
>     { .compatible = "brcm,bcm7216-pcie", .data = &bcm7278_cfg },
>     { .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },

If you need to resubmit, there is a typo in the subject: reigister vs.
register. Other than that:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
