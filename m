Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59190449F27
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 00:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhKHXrl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 18:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbhKHXrk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Nov 2021 18:47:40 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC37BC061570;
        Mon,  8 Nov 2021 15:44:55 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 127so17606424pfu.1;
        Mon, 08 Nov 2021 15:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OHXQVVugqLEZabs4XAPu6SxuojvcV+gl3GjwwPy2W6U=;
        b=GgP3yX+2RJ0qVe/n8jcElv+We0+LJBP1sfm8YckQ5tdrUWzNs30Tm1dCOfuuqF0aG2
         f5+1C/Gojs9C8EywY/XJ4Ffak+4Nd12FjylHL20kfId99LoumkL/Lnv4+fK12HzKda3V
         H6qoCRYpjGOeIt7+IJJzmWLKm7aERtRuJwAEekn/IsIdbaeR9x7tRZ8BMACDrrq0wZIb
         q+IPlgyQGPtbbxHdnveAOFGEzQn7Z4NJMvxZ/9mP7tcltN4PuAJHAD2F0UM0kZhQvo6U
         bZ3N4JR44V0rkL8Ogza9eYCB9QfSowGRK/7+56nuZpM7sgxyF668tisbyQ+WgB3Fz0YW
         6SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OHXQVVugqLEZabs4XAPu6SxuojvcV+gl3GjwwPy2W6U=;
        b=I/3t6nFRd1pzdenXpUJdXwTDatUEXX4Bl396+YvKqIhdz8yB0x0d31wwWBuDmV9tj2
         Ej4UMqfCOi3I0rwBnztH2ILIkxc73ZjnpQ/5U2ujyRvoKyOy0MUBEhhMsHDDyPDzTxd8
         mdfjl6Yi3lFuJrFYSkLjROL9ycqcjAn1PpMmtu8zXYSLsCWwpPPFnFRyzrMZwWyGWkCB
         GCMJwDDRn34x6fkAInAyWLYtakSj7sxCFEu+x16TTaMUC8IC17rawCAAIiY/eNPc23Rb
         YFDb7r9LsZjvpDujfiJOWz28Bsms74YKJKHGz1Z/6VMw6Om6IXm10hQ87Y9M3HYP5/Br
         llGw==
X-Gm-Message-State: AOAM530W79/itIQVxMpATSp0ooJa3M1/quPq+qEg5P7z6jKKmzxkG7Yp
        NFiTgorc4wygjowx+s1shkJoWJzMgRw=
X-Google-Smtp-Source: ABdhPJw4zjY7/8GRXtqYNtuqqQavoHjrurClmY1Xkr6EoPyJ2LZxsQfC4N+o7ldUWxOrrnwEu3FY8A==
X-Received: by 2002:a63:455f:: with SMTP id u31mr2572185pgk.206.1636415095093;
        Mon, 08 Nov 2021 15:44:55 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p14sm394627pjb.9.2021.11.08.15.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 15:44:54 -0800 (PST)
Subject: Re: [PATCH] PCI: brcmstb: Declare a bitmap as a bitmap, not as a
 plain 'unsigned long'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        nsaenz@kernel.org, jim2101024@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <e6d9da2112aab2939d1507b90962d07bfd735b4c.1636273671.git.christophe.jaillet@wanadoo.fr>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c3dafb74-8cb4-5336-b8af-8ea04570973f@gmail.com>
Date:   Mon, 8 Nov 2021 15:44:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e6d9da2112aab2939d1507b90962d07bfd735b4c.1636273671.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/7/21 1:32 AM, Christophe JAILLET wrote:
> The 'used' field of 'struct brcm_msi' is used as a bitmap. So it should
> be declared as so (i.e. unsigned long *).
> 
> This fixes an harmless Coverity warning about array vs singleton usage.
> 
> This bitmap can be BRCM_INT_PCI_MSI_LEGACY_NR or BRCM_INT_PCI_MSI_NR long.
> So, while at it, document it, should it help someone in the future.
> 
> Addresses-Coverity: "Out-of-bounds access (ARRAY_VS_SINGLETON)"
> Suggested-by: Krzysztof Wilczynski <kw@linux.com>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
