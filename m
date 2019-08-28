Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3D70A005C
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 12:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfH1K7u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 06:59:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33624 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfH1K7u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 06:59:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so2055498wrr.0;
        Wed, 28 Aug 2019 03:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=4e6dKncyC8lppPWJvFlONYDFtBQAbbnYiHIeSIDNvNo=;
        b=eIprUPXRpsLzuaXAUzKBaM7IpTdSw6XABL4VxaqqldXK/lX4ElDqlRvy1zblQtSrE1
         ai2b2ubv4a6AgNuifyPIZtuM2YPhQAduEi1FiMhjRpppYbO+rw+Ky2Q6oimX1/L2NgPp
         Gj6uUix49iHQadgJxep34frC++ySipugVJxSzH5h7iLEeexJBDkdBnlM80aMq/pyVI95
         VRxQfDB9IL5lYN0uM/1o22RFh1d7fQQaEx2Ns8iQw0njAx8ltYQSmNl7sfInyuKpTMXL
         xAagDk4XOc8n+oYjsSAe/8iLiJvCGO2b6uXeYTiayz20u+8Ru2tSF3n9kz1HQD5Gkkqo
         BAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=4e6dKncyC8lppPWJvFlONYDFtBQAbbnYiHIeSIDNvNo=;
        b=f7LMXP+n/OpLnx0nk6UUy4nC2BnJITDjDUh5Ox7iTJ3jXObc+LPuqpRgyNBwC94m7c
         7ghZhoD+GSDInT2B341MyHI6NQ6PFo+xDVxTKYN8hKvwpSNonCOy0kKMnPgxCp6325Um
         ROuHqWRA8UhktP6fP1VkYctYP3Oawjk7+0K82Qry8i0MsonNT5i93+oTNp9bK5FjKVrU
         Guk30tNtJIn2dpcXRjLEZFHHUY7r9QarqZVkhR21FySj8rzH2pA9Ox3+d13n/zcNVQfl
         i06maHgaWTspDj5fKM0B2jh6aMpk11eZiN3g4xZhq+M8UgNpJHXIXQkyysgiVtK0PFrc
         An6A==
X-Gm-Message-State: APjAAAUXthQNAQWLsZYTzD304p5av/uiXyasAGW+vFfKQ4HD+zraJ9XQ
        xpUPXGg3+19dnQPiD4amcmAJhVqiWUFS0A==
X-Google-Smtp-Source: APXvYqxQOaOKwoOUHo201U9bFqXrt+nZtY7OrdmazPpB6kx5obOFIFow50MilXv5wS+WAGrgz70f5Q==
X-Received: by 2002:adf:bc84:: with SMTP id g4mr3884149wrh.135.1566989987792;
        Wed, 28 Aug 2019 03:59:47 -0700 (PDT)
Received: from [192.168.1.105] (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id b144sm4381228wmb.3.2019.08.28.03.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 03:59:47 -0700 (PDT)
Date:   Wed, 28 Aug 2019 12:59:45 +0200
From:   Krzysztof Wilczynski <kswilczynski@gmail.com>
Subject: Re: [PATCH] x86/PCI: Add missing log facility and move to use pr_
 macros in pcbios.c
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krzysztof Wilczynski <kw@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1566989985.26704.2@gmail.com>
In-Reply-To: <20190827224725.GD9987@google.com>
References: <20190825182557.23260-1-kw@linux.com>
        <20190827224725.GD9987@google.com>
X-Mailer: geary/3.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

Thank you for the feedback.
[...]
>>  Make the log facility used to print warnings to be KERN_WARNING
>>  explicitly, rather than rely on the current (or default) value
>>  of the MESSAGE_LOGLEVEL_DEFAULT set in Kconfig.  This will make
>>  all the warnings in the arch/x86/pci/pcbios.c to be printed
>>  consistently at the same log facility.
> 
> This is slightly confusing.  There are only two messages that didn't
> supply a log level, so the avoidance of MESSAGE_LOGLEVEL_DEFAULT
> applies to those.

Good point.  I will update both the wording and the explanation so that
it would be more accurate and make a whole lot more sense.

[...]
> Might be worth doing this as well:
> 
>   #define pr_fmt(fmt) "PCI: " fmt
> 
> and removing the "PCI: " prefix from the messages.  This would change
> the "bios32_service" output slightly, but I think the change would be
> a good one.

Will do. The v2 have all the improvements. Thank you!

Krzysztof


