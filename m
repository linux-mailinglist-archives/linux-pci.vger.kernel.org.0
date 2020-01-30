Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B19E14D576
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2020 05:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgA3ECg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 23:02:36 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:40774 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgA3ECf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jan 2020 23:02:35 -0500
Received: by mail-pg1-f176.google.com with SMTP id k25so932425pgt.7
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2020 20:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9gi7cftqQhgEACfQSG0oIMlygZz7GMQOh7VEOEdbmsk=;
        b=TkiYFdWKNw7Sp2JKCDubpt91jPpLEDCcOpRzE67lzrn4zUdF91ZeIBNvtsw1QkA5et
         2GJnr9gXAoUHg0NNr+GWAXmedY4i4yBw+0CstvfoRVyF60x/QbNS+Gastps2fRVBEiAJ
         N/kfKxZuLlsBWNv41ClMapYv2i8mMVb+OP2CIZfa8jGC08nyYbdHpwkqqKaU6poD5VmF
         4TMfbfiQs06gW0jbLZew1ZnArGD3aVMthyIEhJRs8y6w8OJ03PiJkLQMzBcYOsLqCD4Q
         nxdTslR0oSTmlW+JrZe1kSqZjR0oagOy/tjdoyYcRBQALabisuZ1dGyYro+jrvtAIWss
         hEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9gi7cftqQhgEACfQSG0oIMlygZz7GMQOh7VEOEdbmsk=;
        b=NzitXsQxdyj0kqC4Q+mAp0nLcF+vjbQlMjlvv7vzmJSs3lngrjsv5dU/FuKj5cOGYq
         GvzNmTF0lMqKM785569CyEAFWALPJfAzgR1aXSE25V88zo7W+llhlQddkB0jddOLA33/
         gzApH8rXKHmnHyFAForavS51Th6QEMEJDBrrM5G8sUtCWbr1ivjfQ8J7r/CK8T2MCHfE
         fpJQmEWWzyHrU9Hpoeh3CyjFb4SbFhEqtdaSpqIcgJg/FuMBysbDaV6g8EwQTRkxVuQ4
         69S0vlbnw23nVtKMV853DwAA69a81jPv2LJoEh88MFcrMascMDbNMfxUz+B/G/nJphli
         0ceg==
X-Gm-Message-State: APjAAAUxs5lvlzmpz9q9scNOBY1jinN8g4az1PH/VLGgola7PKU8nyUi
        4XFLZbBCL3YJKhoHAEk8gsKCcg==
X-Google-Smtp-Source: APXvYqygfj0eCdlxEcY/Q9qnem+Iu4pR2PO/Pv2r6Tz/SFwfD2kn37iJLTRwdI4m6x71W7niF7BisA==
X-Received: by 2002:a63:f62:: with SMTP id 34mr2736391pgp.184.1580356953827;
        Wed, 29 Jan 2020 20:02:33 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id u26sm4210926pfn.46.2020.01.29.20.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 20:02:33 -0800 (PST)
Subject: Re: [PATCH][v2] ata: ahci: Add shutdown to freeze hardware resources
 of ahci
To:     Prabhakar Kushwaha <pkushwaha@marvell.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        Kamlakant Patel <kamlakantp@marvell.com>,
        "prabhakar.pkin@gmail.com" <prabhakar.pkin@gmail.com>
References: <1579923437-12983-1-git-send-email-pkushwaha@marvell.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d610a34d-16f5-1035-f3c3-f32a75aa0fe2@kernel.dk>
Date:   Wed, 29 Jan 2020 21:02:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579923437-12983-1-git-send-email-pkushwaha@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/24/20 8:37 PM, Prabhakar Kushwaha wrote:
> device_shutdown() called from reboot or power_shutdown expect
> all devices to be shutdown. Same is true for even ahci pci driver.
> As no ahci shutdown function is implemented, the ata subsystem
> always remains alive with DMA & interrupt support. File system 
> related calls should not be honored after device_shutdown().
> 
> So defining ahci pci driver shutdown to freeze hardware (mask
> interrupt, stop DMA engine and free DMA resources).

Applied, thanks.

-- 
Jens Axboe

