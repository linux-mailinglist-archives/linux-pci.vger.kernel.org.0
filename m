Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D014CC0E6
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2019 18:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfJDQh2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Oct 2019 12:37:28 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35308 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfJDQh1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Oct 2019 12:37:27 -0400
Received: by mail-lf1-f67.google.com with SMTP id w6so4931951lfl.2
        for <linux-pci@vger.kernel.org>; Fri, 04 Oct 2019 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pogQvn83j4oJYWNXWDTkvZI3328XLhVSQasefvcRlEo=;
        b=PdfDgpwIr1g4Y67mXvtlazABvYBvry20RKpT6nqDBwsoEMA1UggIaOA+GSES58t8j5
         fMIx086UHm7/b88MsJCfN8ZOxAuepUyPrzzKpb1NqG8feQZza50pkWIZufJkiIyIJ5d3
         UsGZwqwWo+p5Oav79q+Hf54Tj9iwHVNzNIl8yXczS0j4it193le9Toh/KWFliCnsFQws
         wSuYrW8Djbc53qW/I+wxL5r+8EAlYHwN7oo6BV9Fie92HeL+Ho1gl9BUCRWNDmB5binx
         IbNCjD+MxFBx7DwoG8nQE191Smp3x1b7DagE4EpMxk+tvCpq4oJ7Pses5GzpLf7I6RM8
         fDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pogQvn83j4oJYWNXWDTkvZI3328XLhVSQasefvcRlEo=;
        b=cvEeuaYX54bSZd/jX2M0dA2iWmdkQGG9zKtsc+6klX5K83TLqpfpyg+L36TOZLdjhI
         MOJAPgTAHfKeZ0FcYzU9jY4LDPIq8yxWFubbY5VvzEf8mEo3hxGsaa6Na/rDPFY/PSpW
         Hs3Cgfgi9pt9q0HZ6hv7GQ3YOmX5MsAkoO7C3A58juhhUNIhFAzRiC2a0iyKSwrR8eXa
         +f3UdUKi2GTh9b5jFXACugZ2it/POOrQZ67QxeI9eNtGYCZMaFhFl2tJLKtOXnOKpCre
         VJDWhLOeX7CCC2HRvl491rpAC61Mo849hb97zVXf7jRRNVlRFDhEouBxX/DkBS4GQoYZ
         GnKg==
X-Gm-Message-State: APjAAAXK36idh/sN/sxqasS2ahgusWt7nCbpVlDkIG7Z4OJOYBQFIyTz
        C6zPdWPxvIQ1UL3ReiKSnT39yjGceTbTfg==
X-Google-Smtp-Source: APXvYqxsaxkILmIuwEC6EHGQcURnhpi1tOyeRpTAU7bCdHqa/7oO5GjTxDQPJqdv+5f4sACediXMTw==
X-Received: by 2002:a19:f24d:: with SMTP id d13mr9593358lfk.127.1570207045962;
        Fri, 04 Oct 2019 09:37:25 -0700 (PDT)
Received: from monakov-y.office.kontur-niirs.ru ([81.222.243.34])
        by smtp.gmail.com with ESMTPSA id x25sm1396078ljb.60.2019.10.04.09.37.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 09:37:25 -0700 (PDT)
Date:   Fri, 4 Oct 2019 19:37:23 +0300
From:   Yurii Monakov <monakov.y@gmail.com>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     linux-pci@vger.kernel.org, m-karicheri2@ti.com
Subject: Re: [PATCH] PCI: keystone: Fix outbound region mapping
Message-ID: <20191004163723.GA31823@monakov-y.office.kontur-niirs.ru>
References: <20191004154811.GA31397@monakov-y.office.kontur-niirs.ru>
 <20191004160519.GV42880@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004160519.GV42880@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> This looks fine, however are the earlier lines still correct?
Yes, according to TI Keystone PCIe datasheet pg. 3-10 OB_SIZE
register should hold log2 of actual window size in MB (bits 2-0):

0h = 1MB
1h = 2MB
2h = 4MB
3h = 8MB

But OB_OFFSET_INDEXn/OB_OFFSETn_HI register pair hold absolute
64-bit bus address, so 'start' variable sholud be incremented
by 8M to map all PCIe data space (according to the comment above
the loop).

TI confirms this bug for for kernel v4.14, but since then
some driver code relocation happend and I've decided to
report this here.

Regards,
Yurii

