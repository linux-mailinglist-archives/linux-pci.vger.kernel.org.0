Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FC73F3EAF
	for <lists+linux-pci@lfdr.de>; Sun, 22 Aug 2021 10:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbhHVIum (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Aug 2021 04:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhHVIum (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Aug 2021 04:50:42 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CABC061575;
        Sun, 22 Aug 2021 01:50:01 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h13so21206702wrp.1;
        Sun, 22 Aug 2021 01:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uEayeFSGw6mspVpGM6cdAaMIlvR8r6ZNpJsALclqMzc=;
        b=nnhwx17ZAbAD/TsER+y9OR57IiH/h0JVmFICLscyXA3VGPCpO8Ph610nFEaHfx8szn
         s6tJ3fQtwmGPKmXoEqte9DG5/eSEsfkLEKrw38INJ4xYejMbfLU5u4jYy2IQuY+wFXb9
         bQBNJ+ugoyaKAbMS5T/vrb+txccrSyvY/AAB0sKmTAnXAIwCsvTcK0sD5u5Z69yElk0L
         KLsFeqa1aIq4b8Cwh6ASx7cVUCBDWtflwFRp7z+o4KcFHBdLuK7wUEyEww8T8WLcxndd
         cm6HjSdWdrdgxTfBbtH0IRxF0yyAQI3I80GotUtl3LvSwAatkKkIS8FmZ6vMN5HHOgti
         SgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uEayeFSGw6mspVpGM6cdAaMIlvR8r6ZNpJsALclqMzc=;
        b=gjxcLIWVJUoSPAUugEiw+CIdsLmZxxdybH+ZjT5W7NDlXVgd71gxo+O+dr/FAoJfzY
         ASIX8PttBYra1+3HE+Q5Ny1vErmdWgfWPgyYnNK1prf9SIZ5l0R/xxFjs50Dv0KLyg/1
         CwDt4Q+KL4Hoh9DWp+0QiZppZZ6R/bdAFPwZ+ThzdtzjOZkjEImFdyZciSKKKkeaHIJX
         AFEkNoegzBnOdtXZymyR5VN0iduj2kbtQ4kZaUuo+CEa7bOyKyQ+dX4eGnn2fnY0dcef
         DW0cLqZCZXTlH55Y8wjZPvULdCfJDlTnp56+vfKbC3HCTsCQ88zUZIjO2cMsRHVSpjRE
         vrhg==
X-Gm-Message-State: AOAM5315S9F3Wwi0RZ4kEUXu3OA81dc7IogaaxKBQ1iJRZZHW/aHl87h
        fbvFYltLlFOKUdFy1/YhEJE=
X-Google-Smtp-Source: ABdhPJwqnHaIEFX3YprnNnl91Ie+QFTrhVkqUNm1KZczyrQB3LnlDaD+bLeWcuxI3zpr5dnY219C1w==
X-Received: by 2002:adf:80ef:: with SMTP id 102mr7565695wrl.403.1629622199997;
        Sun, 22 Aug 2021 01:49:59 -0700 (PDT)
Received: from [192.168.1.22] (amarseille-551-1-7-65.w92-145.abo.wanadoo.fr. [92.145.152.65])
        by smtp.gmail.com with ESMTPSA id d18sm12131700wrb.16.2021.08.22.01.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 01:49:59 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] PCI: brcmstb: Break register definitions into
 separate header
To:     Jeremy Linton <jeremy.linton@arm.com>, linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, nsaenz@kernel.org, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, robh@kernel.org, kw@linux.com,
        sdonthineni@nvidia.com, stefan.wahren@i2se.com,
        bcm-kernel-feedback-list@broadcom.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jim Quinlan <jim2101024@gmail.com>
References: <20210819215655.84866-1-jeremy.linton@arm.com>
 <20210819215655.84866-2-jeremy.linton@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f791df30-4916-fd58-e7fe-472f101247c1@gmail.com>
Date:   Sun, 22 Aug 2021 10:49:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210819215655.84866-2-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/19/2021 11:56 PM, Jeremy Linton wrote:
> We are about to create a standalone ACPI quirk module for the
> bcmstb controller. Lets move the register definitions into a separate
> file so they can be shared between the APCI quirk and the normal
> host bridge driver.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
--
Florian
