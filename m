Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0FF1C86B5
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 12:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgEGKan (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 06:30:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32611 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgEGKan (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 06:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588847441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8jYlXVIeYwPIAaTa/8NGwUOA9TXF5pyDMIzCVjgMxm8=;
        b=ZIFuDpaoUEQQRUqzMnDI//N7av9iJMXl3E3F1ASzbW4xCHBNtieHHoBeds1ERLVdbq7xqS
        euIXxMBb70koZE+lXZ3IVRL/jKkxqgu71xe4E9OiGF3Os+H1eTueBdWtUv7tdwklQuftuy
        SG6NWd5YBBLAm6q0P5HjHXxY1+EK+ag=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-BRBD9VtDMeaajR5zdxxhLA-1; Thu, 07 May 2020 06:30:40 -0400
X-MC-Unique: BRBD9VtDMeaajR5zdxxhLA-1
Received: by mail-wm1-f69.google.com with SMTP id n127so2291358wme.4
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2020 03:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8jYlXVIeYwPIAaTa/8NGwUOA9TXF5pyDMIzCVjgMxm8=;
        b=bwUQfN1trPAqKrX1uJ0lS2ei8UKk2ZFBBGG6sYSjhd25cFymn8NyT/k7J5kpEAeyg/
         +QMEXbjBlisYf2wjBgfgjpJD0m2X/KqYip0hSJzJEVq/pdeLmL7qTecnY++t0yF7Juux
         B06p/JhJX/a3HaSwqnHf2fLVwLDtoxYaHe8lbYG81A4WcATp2CjllV1QnNUm1GLZBU0R
         7wop9fYx7uE++6NxWU41MAWzSYURh7swhcRtU7l6nC75n+zq4zbBdG3hyQMIjKtrjgTJ
         WFYYHiu7ZGI11d14+Ywrj+DkmlEOy2wXzx4kWJM2hLtUZCfnoJBuL0HD+X24NWbnXmSv
         ITMg==
X-Gm-Message-State: AGi0Pubg+IeyYMMEkrYfu9gyZqPGU3kFgTPb+4+h4y8wnZWkq1SYv1Wi
        mzLfRjqxY1CWdFIk0e0LZvfAhoVSciR7bghYtbUcOcZBhK9wWkiysdztp0EEeN5S0rEL/DcOuI9
        4j0V9BGKiQpTFFc/Xa7LD
X-Received: by 2002:a5d:5642:: with SMTP id j2mr3913179wrw.52.1588847439015;
        Thu, 07 May 2020 03:30:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypLYsFyxuTZc14Fgz1L9YXfTpaCsMoR+ZYvt4JlYFVWwq/uNI7MbYeDdYuumr/g0A43oTs6NUA==
X-Received: by 2002:a5d:5642:: with SMTP id j2mr3913158wrw.52.1588847438835;
        Thu, 07 May 2020 03:30:38 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id q187sm7512995wma.41.2020.05.07.03.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 03:30:38 -0700 (PDT)
Subject: Re: [PATCH 1/3] ACPI / utils: Add acpi_evaluate_reg() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20200505132128.19476-1-hdegoede@redhat.com>
 <20200505132128.19476-2-hdegoede@redhat.com>
 <20200505154205.GR185537@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3a8682dc-5423-d057-4289-929a84f28f94@redhat.com>
Date:   Thu, 7 May 2020 12:30:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505154205.GR185537@smile.fi.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 5/5/20 5:42 PM, Andy Shevchenko wrote:
> On Tue, May 05, 2020 at 03:21:26PM +0200, Hans de Goede wrote:
>> With a recent fix to the pinctrl-cherryview driver we know have
>> 2 drivers open-coding the parameter building / passing for calling
>> _REG on an ACPI handle.
>>
>> Add a helper for this, so that these 2 drivers can be converted to this
>> helper.
> 
> Suggested-by?

Right sorry about that I will fix this for v2.

 >> + * @function: Parameter to pass to _REG one of ACPI_REG_CONNECT or
 >> + *            ACPI_REG_DISCONNECT
 >
 > Is it enum or definitions? If former can we refer to it?

These are #define-s.

Regards,

Hans

