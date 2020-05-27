Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B485B1E5203
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 01:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgE0X5z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 19:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE0X5y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2020 19:57:54 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F70FC08C5C1;
        Wed, 27 May 2020 16:57:54 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x6so12417592wrm.13;
        Wed, 27 May 2020 16:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yJsIOGrYqyMlsvGZvuDbQbpz5zHJ2Al+1mhnUHoBcsg=;
        b=seQt8YDnOilGUARCihyoOHCAGFCt1PoRnotjOt68VWlMAGYTkZ97TNw3kUZ4L6Zeqw
         7Z3jgRR7Ub8E1ls+7A/Lzs2hut49rXXD0RzwaFRW7ZeuNpuuOa6LD1RYSIwlgzEhC3vu
         GNNPmaxCb50xP7fVb1E+NXrvQdqq6CP2qSbcMwvsyMzYsA6MtrsKhbKt1hRpyKLyD7hW
         488L33dDlSmEngnC8vsdVHlVO39jvyU7QZ4+11N9zyaZtXFz88U5/s1Nv01VHAvxjkA2
         zT8uPVPDmbkRvlggcL1sSQT6U3/BJpS+8d0izhc9Z3s6x4c3lX8t9QmHl28jkrogYmEg
         Me6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yJsIOGrYqyMlsvGZvuDbQbpz5zHJ2Al+1mhnUHoBcsg=;
        b=ahKpza7qAY7xPSDVEqOMY7rObPF70aNlzgqOEkybSHJFm6CmztkH+4M0rPJKmT6e4X
         9mt743nyJ9uDXcjduYsqcn7/PozUm52LtyymmJGr7i+kmW9/Fdrel2VTM+EKsDWyJ0IU
         2AJa6KF0RgyOYJOnRnxYY+4Th5BGoXcTcG6NOwHRuAWxt0WTGI3LDyaTeAT89gRS7K+O
         SuMULy4g7xQ1hJD2Qfq1WYXB8ot+zCY+i264t5tQQ3xwi2r3GCD0wSThls3e84NURMJd
         SRl5C95Qbo3h+vIAIOmNb78pw7h17UUAEvstOPxwSlJ2vpyoSuVd1vIVqax5ke3mJh/3
         RwcA==
X-Gm-Message-State: AOAM533fw4aWq5Y1Y+0HgXyA/PP80N1Gc+9aMyB8fBw+x2lRpuM8GuVC
        J57Tks0Du2dIqKKHKwj14JT/p3iB
X-Google-Smtp-Source: ABdhPJymbkfbuQSQVgegw9QxVZPM3gIUz9DOYYhBvFmcNqX4KpQy+La0Vqi9v2C/pyHSM/AXtB9miw==
X-Received: by 2002:a5d:6789:: with SMTP id v9mr758483wru.124.1590623872596;
        Wed, 27 May 2020 16:57:52 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id h196sm4445137wme.22.2020.05.27.16.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 16:57:51 -0700 (PDT)
Subject: Re: [PATCH v2 02/14] ata: ahci_brcm: Fix use of BCM7216 reset
 controller
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Jens Axboe <axboe@kernel.dk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200526191303.1492-1-james.quinlan@broadcom.com>
 <20200526191303.1492-3-james.quinlan@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7dc691ee-78cc-b6fd-78c2-567680e431c8@gmail.com>
Date:   Wed, 27 May 2020 16:57:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200526191303.1492-3-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/26/2020 12:12 PM, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> A reset controller "rescal" is shared between the AHCI driver and the PCIe
> driver for the BrcmSTB 7216 chip.  The code is modified to allow this
> sharing and to deassert() properly.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>

This patch is actually a bug fix and should have:

Fixes: 272ecd60a636 ("ata: ahci_brcm: BCM7216 reset is self de-asserting")
Fixes: c345ec6a50e9 ("ata: ahci_brcm: Support BCM7216 reset controller
name")

and it could probably be merged out of this patch series I believe.
-- 
Florian
