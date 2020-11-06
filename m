Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A5B2A95A0
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 12:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgKFLpa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 06:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgKFLpU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 06:45:20 -0500
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60E4C0613D2;
        Fri,  6 Nov 2020 03:45:19 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4CSJV34t8TzQl8j;
        Fri,  6 Nov 2020 12:45:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doubly.so; s=MBO0001;
        t=1604663113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/zuBtS3rhPXYCoC3ndjN4pCIaSWiuV08y9jfNTqh7Wo=;
        b=0zSU/WtQikqT6yQzFxPV9oJJB+V40KIrwOHMyUtVxgvITWRUokkTO/Jg16d/5sqcBSbQkF
        /LtLlnx+VzqRTAy6rEEj/ZckXOwQyldmTbAVf8073RHsra9YfVO5qpTy7R0ThXVqjliZzF
        Go7zZODpEYB4zzlT7iwdtqx/nM/u1sJMizsdFV9rnQIj+7TCH8Ck1Ox8fyYRkOOBqWjjM0
        LptDNeunH+0zhLbdBwcoTW17AU4E+ae2F5YFTN/TgtNpljRwye+dVNc9L9GJlxsp/KHbMG
        +dFlsNtJGAnEjLYK5bIKQUtFpoZ8nCy6aX+jr73eh5EyUY5iqEfzig3CuA/ktg==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id 5I3yJEUYpXRq; Fri,  6 Nov 2020 12:45:12 +0100 (CET)
From:   Devin Bayer <dev@doubly.so>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
To:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Govind Singh <govinds@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-wireless@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Thomas Krause <thomaskrause@posteo.de>,
        ath11k@lists.infradead.org
References: <20201103160838.GA246433@bjorn-Precision-5520>
 <874km61732.fsf@nanos.tec.linutronix.de>
Message-ID: <768b2f88-3da3-37bc-f512-f5249a52480e@doubly.so>
Date:   Fri, 6 Nov 2020 12:45:10 +0100
MIME-Version: 1.0
In-Reply-To: <874km61732.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.85 / 15.00 / 15.00
X-Rspamd-Queue-Id: 95B961833
X-Rspamd-UID: eb27ba
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03/11/2020 22.08, Thomas Gleixner wrote:
> On Tue, Nov 03 2020 at 10:08, Bjorn Helgaas wrote:
> 
> Check the BIOS for a switch which is named 'VT-d' or such. It might
> depend on 'Intel Virtualization Technology' or such.
> 

Thanks for this info. The platform I have, J1900, indeed does not support VT-d.

So I guess I'm not able to use this card. That's unfortunate.

It doesn't seem like the Windows driver works either. It doesn't give any errors
but it fails to find any wireless networks.

~ dev
