Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988DE46F5F8
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 22:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhLIVfQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 16:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhLIVfQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 16:35:16 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F79C061746;
        Thu,  9 Dec 2021 13:31:42 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so7948421pju.3;
        Thu, 09 Dec 2021 13:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=anuYNGK8D1NL3vUwPz/i/FF0REMtyl6QVuwJrNMAAg4=;
        b=DrkSKlWFGz8MqI8NWOB6sVYHrrBVaoDSlQwJ1ApPtc9NprtqkiYUZVlxdZmiSk3SAd
         ypyqeI/rv6bm391gurcTgmJwYsNH+E0xtgdVNqartdj8CszftG8NSyEnG9NK4s7MGqvO
         0EZQMOx+euESzIkl4FhGRnIT9p3CIuLJ5y/VBASpD8n22EwL10zN98YPZ6F02V5spM5C
         PngYZ92unjOqesbbivj9O0p5n3Nprr3Zym4Lhdyh0qtFLVX6qBWYA92qUHOeJmjqaHPH
         QNNGPgAZRHhIf7liWECoamEM56i5F4bAuflfV5rvjOxM3FJumy8xFPgYYCbvzOmsRKrV
         h89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=anuYNGK8D1NL3vUwPz/i/FF0REMtyl6QVuwJrNMAAg4=;
        b=o0V6Mhg+1posP8WzNS+WsWoC6YzRVrg9YDKwW7oC45XztidR8waTxzuGm6omwmwmeS
         f2z+6E5hPbyt7XqTs4EJpSi/UkLwD+ZmGhrf5bWHaOLzDH0jYk0IqzveqgQgbKOfUq6R
         fS3LiIfVPIeUi32UbI1zqXrGMdBzUduwKTa7nK4JHt3C96Eoh1tZhuHxNgwX8kGkCH7h
         54Y+ytGZk/6uM19CBJ5/LoL0L1gWuMI1skIn6WkWx/cHyEAoDJwlJ/cRKcUka0L1ySjs
         sTolvcVR6MiYeeOzYaNKwDW8sdJuLlANh5lYyLsqHkNK5MjK5Q++U8Eilf+V6b5SjF2M
         DFVg==
X-Gm-Message-State: AOAM532TAohH7jmoMoUuk4ArnqHSu8IOggStPSL7Lh3EpXMHSqdjWUiU
        Lvgaya30TNmsjfQVvf4pZ31l5WeTmvI=
X-Google-Smtp-Source: ABdhPJwkw6GsFAzfwIDMZs8b+NAmm9n+ZaTx1yhaLDXkyFKmrbEun4appgIwwf9SDj449S9yLMitoQ==
X-Received: by 2002:a17:902:7086:b0:143:6ba3:9b27 with SMTP id z6-20020a170902708600b001436ba39b27mr70397028plk.60.1639085501994;
        Thu, 09 Dec 2021 13:31:41 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s2sm513083pgr.11.2021.12.09.13.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 13:31:41 -0800 (PST)
Subject: Re: [PATCH v1 3/4] MIPS: bmips: Remove obsolete DMA mapping support
To:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Christoph Hellwig <hch@lst.de>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20211209204726.6676-1-jim2101024@gmail.com>
 <20211209204726.6676-4-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <92db2bfe-4bf2-60c0-3483-01fa59723517@gmail.com>
Date:   Thu, 9 Dec 2021 13:31:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209204726.6676-4-jim2101024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/9/21 12:47 PM, Jim Quinlan wrote:
> The code in 'arch/mips/bmips/dma.c' performed DMA mapping for inbound
> regions.  This mapping was and is required for the Broadcom STB PCIe
> controller HW.  This code is removed as the current 'struct device' has a
> @dma_range_map field which performs the same functionality by processing
> the "dma-ranges" DT property.
> 
> Subsequently, ARCH_HAS_PHYS_TO_DMA is now unset since the dma_to_phys()
> and phys_to_dma() functions are removed.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>

CC Christoph so he can do the happy dance, thanks!

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
