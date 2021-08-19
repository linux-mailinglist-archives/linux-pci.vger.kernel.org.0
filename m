Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9753F157F
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 10:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhHSIr2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 04:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbhHSIr1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Aug 2021 04:47:27 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3490BC061575;
        Thu, 19 Aug 2021 01:46:51 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id f10so3365034wml.2;
        Thu, 19 Aug 2021 01:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=X/TEaZzu94ne4ay2syr/T654O+flopjeVsyOYpDjJno=;
        b=Nwks4G871aYpOheeqTFSc4lWtC4lXLeA53ppjfAQsSxhgAMZqL0mtQGOimf88UlF6h
         sD37CBA0jj228sCCxrUxpn4EL1Cg43hFq6OzJ/X3iZNS+Mt83DEGBuMgjCWyyQvlPBKH
         dEJ9YFsk0E3UGeS7ZCWHXO59h7F8rJhc+3XPSBn1BDupy957GAomgKl7tp2UBootElVO
         wOvHeHPACxIUvNW9EFdc1HzaDfFok707DMCyhfrge/CIBjPz42QZIwYFVZaV4QAyGDS4
         vXZ/pJiqNGOo4T6dGpycWuYpnji/LojNZtL6a4Nb91kIapWXCG4h3zYopuDPVCLjAu/b
         HCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X/TEaZzu94ne4ay2syr/T654O+flopjeVsyOYpDjJno=;
        b=a3ZNUGBPw/YoUZolYucoZ+4OicUebgp5xOv45J2MUOUkZjXL/cWdyUsu/8TFmgWBm8
         ZryvqGBsPdPKEpZi8dLe/m1AuEYDTytuUgEGsN2MhfGs+VVKLQ/p4WQ7vhHvQwn1wD0b
         Eon+HTGqElP+G1PGeIH9D+qf1QMQnTC0AzPLtRMDpIEIKRz2GVLrp7p6SYM3hGx+0NnV
         2E8HLxvt1vXJkNMLx3L5gbhtL3VOyzOwEeMyx9hErfPARBYQpkdg9VLXEBhNm5dpxWb2
         eo6kVG6ZEHb5lx11WJ2vIPlDZQwRHJPEjCIhj6433NqmaC4Nsjo6DSQ/UtVw0Y2yWLxU
         vZ/g==
X-Gm-Message-State: AOAM53191X9bdyltoyaYst5UvtD6MNpZkXrRLFBEQofCID/DZzZVENaE
        RLewWPprvaPWYbnSPN8aeGE=
X-Google-Smtp-Source: ABdhPJwYxscRIinzqhEtONF6p8gLbq+7oJhoE+fOvLEGr4P9cwE4Koxqa8JqsF28S4rldy4wW/XCcA==
X-Received: by 2002:a7b:c316:: with SMTP id k22mr7118105wmj.56.1629362809827;
        Thu, 19 Aug 2021 01:46:49 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:183:dc70:3158:43eb:fcb0:86a6? ([2a01:e0a:183:dc70:3158:43eb:fcb0:86a6])
        by smtp.gmail.com with ESMTPSA id u10sm2227301wrt.14.2021.08.19.01.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 01:46:49 -0700 (PDT)
Subject: Re: [PATCH v1] MAINTAINERS: new entry for Broadcom STB PCIe driver
To:     Jim Quinlan <jim2101024@gmail.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, f.fainelli@gmail.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
References: <20210818225031.8502-1-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <79e605cc-519e-94f2-0444-8700256c6458@gmail.com>
Date:   Thu, 19 Aug 2021 10:46:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210818225031.8502-1-jim2101024@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/19/2021 12:50 AM, Jim Quinlan wrote:
> The two files listed are also covered by
> 
> "BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
> 
> which covers the Raspberry Pi specifics of the PCIe driver.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Would be good to get this change applied soon so you are copied properly 
on all pcie-brcmstb.c changes. Thanks!
-- 
Florian
