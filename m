Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2658268406
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 07:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgINFYD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 01:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgINFYC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 01:24:02 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17007C06174A;
        Sun, 13 Sep 2020 22:24:01 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b124so11574393pfg.13;
        Sun, 13 Sep 2020 22:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=BJTrsJXsTm1uwKnFAZKbGiYZrVLF551foO+8RwWbzPw=;
        b=Bpp6S27QEWK/70smgm/uwoToXR1lDam7inciZPy/jkInbZg5IEQa64Kraz6IubGSrF
         kTiWsTRqP/FeVrrcZinUPQDEWFqkpsSxmr6E3JzsqvfEIv3CQI6ZaAxlhSgDyVu2RNgY
         rioGUWcSAMo3dm8iH0pvvgkCdij4G9b95BxhE+pFiE7elySEsBEW8YOqYWI5N1DTJuQw
         TSJsOHEz+RKeBar7ky9V2vXk9TV1seeEytv4PfFTlY6AtLlb/HYuChzWTSS4/zqTuXY8
         7tBHyCMHkW5qAf8c1E7N4f+cAM344pl84eXQmqS0kL9ybZwYppV5t/0TGrDcC99fnoi9
         8ZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=BJTrsJXsTm1uwKnFAZKbGiYZrVLF551foO+8RwWbzPw=;
        b=foqLZdxOiCtjE90KrZiw/9gjnveLvWPH5mj0n4wmLiUItoL4qhqmM1XNFFAIvy/+q+
         gsacaq72g7VCSMltKEwyhqK1nJ2bWACVKW57R0ueSPM4wle0LAkwuQ1BysJCmsigzCe7
         7rq3R0vg438j4ejO8TvHD/ry1at9Q8nRHr5YT4wiL8fY5ETfW9dp0xA8sMIeKeP8WJ4U
         iusCMxLcUw6DnXegLT+mKlstqA0jBwFeWqYuei0FQ0nbB7SNPcRYEGeKZPWbMTKCd5Pi
         BmDvvdIzNhazSM4pnE2z2XpJ/7yM36OCvj0VauN90ZAbF3e8ypZq2G9JtBBQ6rjRHijG
         aG9g==
X-Gm-Message-State: AOAM532qIZQesYhkL8eP26DcL+eU6y27Y47IMoEzVnf0XA4nCl3YUJ2P
        5Fx0cW7/sgXAiaZbXVQPMjvThoZlOQ0VmEoZ
X-Google-Smtp-Source: ABdhPJwFOPD+jFZKt3plH7UOAejhz2wwU1G3GQdGj4aHItcwUoC2+X8WErAeubr/RLKXAZPhVmKKkQ==
X-Received: by 2002:a63:5b64:: with SMTP id l36mr9679517pgm.413.1600061041154;
        Sun, 13 Sep 2020 22:24:01 -0700 (PDT)
Received: from [192.168.1.6] ([1.23.2.3])
        by smtp.gmail.com with ESMTPSA id j19sm9274043pfe.108.2020.09.13.22.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2020 22:24:00 -0700 (PDT)
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh@kernel.org
From:   Valmiki <valmikibow@gmail.com>
Subject: dma-coherent property for PCIe Root
Message-ID: <1512d7b5-54c6-3b87-0090-5e370955223e@gmail.com>
Date:   Mon, 14 Sep 2020 10:53:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

How does "dma-coherent" property will work for PCIe as RC on an
ARM SOC ?
Because the end point device drivers are the one which will request dma 
buffers and Root port driver doesn't involve in data path of end point
except for handling interrupts.

How does EP DMA buffers will be hardware coherent if RC driver exposes
dma-coherent property ?

Regards,
Valmiki


