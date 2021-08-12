Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0DC3EA84F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 18:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhHLQNu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 12:13:50 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:40544 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhHLQNI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Aug 2021 12:13:08 -0400
Received: by mail-lj1-f169.google.com with SMTP id m17so7558100ljp.7
        for <linux-pci@vger.kernel.org>; Thu, 12 Aug 2021 09:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v02StyjpgDyu9cObm0nKUgeCS1MQ3K36dNC5PTaA9EM=;
        b=PtuFOFuzjGDryHpkLuXd01eI+6R1Sxklh3Dhvn00VSwC9R6uv2ImRtrR81/GRKFnIk
         KSNN1EYRXnO1hdKOvCU2d/ZBXh38gnZqXPucBziKi6XSZCuhVK6rvhFf8tmMQUn+iCET
         yWid0PLDW7qjG9K+juT8EPxq6CJ/BNLiJUUoY3Ekd9R2N1KM4oeN07IQoHWPbqGfJE+F
         1mdu7gbcBAeowdXhcWKkXe+FVj7rCvmrM+luNMx+xIFKIJLnTsYfG3vqp8WKRtwFkY7w
         +ys5UUW09HUV9zwvAWEMoPOp++vAWizrSPbW0RGC2JLH5e3SibjaMUWT5T20D7k+Z2ev
         jZog==
X-Gm-Message-State: AOAM530kH3F5ZFfDrIekrWEnB8nX3nPgprpguQR2fYbDf8iZOqAsFNRg
        niAdh8C1rq4V59Nn14yuygNGyl5eLRjUC1oD
X-Google-Smtp-Source: ABdhPJzlKW+2OZlRu1g/7fd1P5z6T95x4FaYprINgTIPwtnnIqYKtz6Z3SRpHPdPbNv4Jkw6WqiFUA==
X-Received: by 2002:a2e:8114:: with SMTP id d20mr3464190ljg.405.1628784718388;
        Thu, 12 Aug 2021 09:11:58 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d9sm383191ljq.54.2021.08.12.09.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 09:11:57 -0700 (PDT)
Date:   Thu, 12 Aug 2021 18:11:56 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] x86/pci: Add missing forward declaration for
 pci_numachip_init()
Message-ID: <20210812161156.GA563797@rocinante>
References: <20210730211920.GA1099849@bjorn-Precision-5520>
 <87y296hez9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y296hez9.ffs@tglx>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

[...]
> > What should be done with the pci_numachip_init() declaration in
> > arch/x86/include/asm/numachip/numachip.h?  It doesn't seem like we
> > should have *two* declarations.
> 
> Right. Include that file in the C file and be done with it.

I will send v2 shortly with the correct header file included.

Thank you both!

	Krzysztof
