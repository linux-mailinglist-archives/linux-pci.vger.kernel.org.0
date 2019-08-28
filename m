Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41105A09C8
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 20:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfH1Skd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 14:40:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36725 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfH1Skd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 14:40:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id p13so1141501wmh.1;
        Wed, 28 Aug 2019 11:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=1ZQ5ojymViBrAruzvPsWbm4OehLwZlcgiZDLWBOPkfM=;
        b=NAU7esjH2NV9GhK0Lz2BHZ+3nHLUsrrpH5KEinI+cgBB6OOMDv+05mIDKSszvqUnL9
         VLyAkrMRInSdFJB6Xm3A6w1yl5FVtiswgPmYF6wIiyyigxfXAutOEd4m+4aC2w/hhAeK
         9M8F0uvPPPZaN7rgrCqf5bjoVecefE5kUZQRtL4yXS8N2xh8OYfZvDsUQoGSlIL5c7+u
         6NiE2eNs/qDsRCXUEy/ol0ucYicIu0c+Ng7j7/4c1WH8OtBQEgI38sv2AJ6iow7k8mU/
         WBTit9nROwHCS6pN6Lfrf3f/qPf5n9pJ7onNZQ8FaDfJJr/XonrmcKtuOAi3b/QZrcM2
         xevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=1ZQ5ojymViBrAruzvPsWbm4OehLwZlcgiZDLWBOPkfM=;
        b=oxEBdhnpZFcCSLsQfamBuUfJ3RsLCLT+95hwGqJwzbYltMZkfyJFNPs7QVqs6jds10
         m7pXLDEzLyC3Mv6vxFKbytkPMqEKA7dbxkZeedDq7+ppr5/ZuMOmyzRlugaJqhf0Ten/
         mNGNLEU7ZP7+x/kbyc3qil4mM5XDuQ2+JrabSYGjtrAkXSic4xysOURb/d620FjCr63V
         vHKc0xGZLgCydbRSuZgcybx7FEVilnYh9nQhMkHRwBCNU6PPxcXj4/Ctszhs6JZKA9T+
         4SMyLRotGRRcqSUqwYuDoJH+JMUg3GsgF4l23qams1jBfpAA6lgoQ6QNMJP6+x2fldcT
         Vqqg==
X-Gm-Message-State: APjAAAUCD15ug2ShjTJLnWsGxKN1mH+90cZt45xEHRA2Adt8jjkuCTtT
        x3i/xnvIWPG28BdoX+sNtzQ=
X-Google-Smtp-Source: APXvYqyRk1lLXpkl6DdhmfkGq0J29LE5Po5p5CYSB5sL6KGREpE8nu8iCeVVG6wMhSo7ndyr6HkZHw==
X-Received: by 2002:a05:600c:24cf:: with SMTP id 15mr6641221wmu.76.1567017630452;
        Wed, 28 Aug 2019 11:40:30 -0700 (PDT)
Received: from [192.168.1.105] (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id n8sm319052wma.7.2019.08.28.11.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 11:40:29 -0700 (PDT)
Date:   Wed, 28 Aug 2019 20:40:27 +0200
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
Message-Id: <1567017627.3507.0@gmail.com>
In-Reply-To: <a13a086c2dd6dd6259d28e5d1d360e2b4d04ca83.camel@perches.com>
References: <20190825182557.23260-1-kw@linux.com>
        <20190828175120.22164-1-kw@linux.com>
        <a13a086c2dd6dd6259d28e5d1d360e2b4d04ca83.camel@perches.com>
X-Mailer: geary/3.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Joe,

Thank you for feedback.
[...]
>>    Move to pr_debug() over using DBG() from 
>> arch/x86/include/asm/pci_x86.h.
> 
> You might also consider the checkpatch output for this patch.
> 
> arch/x86/pci/pcbios.c:116: WARNING: line over 80 characters
> arch/x86/pci/pcbios.c:116: WARNING: Prefer using '"%s...", __func__' 
> to using 'bios32_service', this function's name, in a string
> arch/x86/pci/pcbios.c:119: WARNING: Prefer using '"%s...", __func__' 
> to using 'bios32_service', this function's name, in a string
> arch/x86/pci/pcbios.c:391: WARNING: line over 80 characters

Good point.

The lines over 80 characters wide would be taken care of when
moving to using the pr_ macros as the line length will now be
shorter contrary to when the e.g., printk(KERNEL_INFO ...),
etc., was used.

The other warnings I am going to address in v3.  I was thinking
of replacing the following:

pr_warn("bios32_service(0x%lx): not present\n", service);

With something that looks like this:

pr_warn("BIOS32 Service(0x%lx): not present\n", service);

Using "bios32_service" name directly or even moving to __func__
feels a lot like an implementation detail is exposed to the
end user.  I am not sure how useful that could be.  Also,
we are already using log lines starting with "BIOS32", thus
it seemed like following them would be the most sensible
choice, especially to keep messages consistent.

What do you think?

Krzysztof


