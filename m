Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 129C4A0A23
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 20:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfH1S6t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 14:58:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39619 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfH1S6t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 14:58:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id i63so1170230wmg.4;
        Wed, 28 Aug 2019 11:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=h3hPr3aReWTRAXA22oX/cJbYrvqfiIXXgWPGxnjPUAY=;
        b=foJF6t8MzSyo7DTOjtVGVEZBUa3vP5j//fN2OglIXG/+wHl9CdiG6O6F9wvvRri2sF
         DC4viGsEfwI1FFf0nI0IK4NTnmLztHfaKN1+trvpm3Xe6VVHSd5HLHTBXqQ+YmJv0MaM
         l7uqqBtgUgM6a9CS8b0V4I9EXZTdwDKXbdh4DFWXA7hmlazvS2W1okEiOBw5k15lbh5i
         vMvPRkYykWrBh9e5NcCVL0o+dxqpAkcKwEa4sf04BDntWfqJ0MoNuUa8xFuq06LlhGtr
         rRfNY5wTZRq4H1/3LLEqY0p5wxIpjOM2+SkewsbgUmG9EyHA63hQSQISjWWkwjxP6c3J
         pmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=h3hPr3aReWTRAXA22oX/cJbYrvqfiIXXgWPGxnjPUAY=;
        b=KfEH2SQc03mHt2elMf0bfAZW1zlrvRLdmi/fAHOtFxj8CLGUFmUzoqhf47xaqUqjy0
         E7aIfMd1WAaCebtqopDbrBqAxNLkuyiyimOVJzsnx5KyXcyci+RghTt6YvPa668kZR3s
         BNWobdEHC+nRmyRyhucudtcDySId/xllJWCC4pQ+UnpiRVEZ/gohqAho/IwilBlcW8oZ
         faizEVj4r6vEBS/kuYMXJKXTap/Ebouu0D25nw+UQzS2xWCpCoIk1ZtFWdcaAoXLlBRK
         3aJMUq+TJ9j3nFmEIhtQp7MpWxA2c/OZtkcvR9mpuhyeZakqcX3HnAN0tEurWUTU9CyV
         l5Tw==
X-Gm-Message-State: APjAAAXqh563Ga20NSohK2sBlVVEohMae8ivSRUOnCAB8z2U5GUYStvX
        h4L+WrPJhZdYq0LcfsvyynQ=
X-Google-Smtp-Source: APXvYqyaFkLmHyhLTNCdux2+SjW3uOkMO7x5pN0naN68rph9wTC0NZQxCQtvczSTpP2qeYJZcHWGPg==
X-Received: by 2002:a1c:9d15:: with SMTP id g21mr6929443wme.96.1567018727062;
        Wed, 28 Aug 2019 11:58:47 -0700 (PDT)
Received: from [192.168.1.105] (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id q24sm7884609wmc.3.2019.08.28.11.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 11:58:46 -0700 (PDT)
Date:   Wed, 28 Aug 2019 20:58:44 +0200
From:   Krzysztof Wilczynski <kswilczynski@gmail.com>
Subject: Re: [PATCH v2] x86/PCI: Add missing log facility and move to use pr_
 macros in pcbios.c
To:     Joe Perches <joe@perches.com>
Cc:     Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1567018724.3507.1@gmail.com>
In-Reply-To: <082d21ef9effc015de671ff51d689dab740cea16.camel@perches.com>
References: <20190825182557.23260-1-kw@linux.com>
        <20190828175120.22164-1-kw@linux.com>
        <a13a086c2dd6dd6259d28e5d1d360e2b4d04ca83.camel@perches.com>
        <1567017627.3507.0@gmail.com>
        <082d21ef9effc015de671ff51d689dab740cea16.camel@perches.com>
X-Mailer: geary/3.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Joe,
[...]
>>  The lines over 80 characters wide would be taken care of when
>>  moving to using the pr_ macros as the line length will now be
>>  shorter contrary to when the e.g., printk(KERNEL_INFO ...),
>>  etc., was used.
> 
> Not really, those were the warnings checkpatch
> emits on your actual patch.

Ah! Yes, very true.  Sorry about that.  I will address these in v3,
of course.

Thank you for correcting me!

Krzysztof



