Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19F2A1AE19
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2019 22:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfELURj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 May 2019 16:17:39 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35508 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfELURj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 May 2019 16:17:39 -0400
Received: by mail-it1-f195.google.com with SMTP id u186so17197955ith.0
        for <linux-pci@vger.kernel.org>; Sun, 12 May 2019 13:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DSBm5hTnVx+7dwCFzA5fliIxja1q/A/MZRb7WbAzM94=;
        b=pwYdxpnlhNwn2jvDkRjr7/7FWeDjTDe+Hozfre99whNdXsRBhtYPkMZ5Uf/380/ZXR
         NZEkLjpRtMjLrpi6r0FY7jYq+vtTiMwXm61D6xdNNaLvlrPm05tlrTw1ZYHusJvchObN
         iZ/Em2Ekbzxtpinc1CIFg4iMYCkRQ+Widmpu05SwJO1z1LNBGXqhsIz/K031JktjBpwK
         jcszZpYCntHf6jGE1J7SlnWShY7BhEZcAfhflaZ0fgoxfOAQ/Zx/4q+9MI1uFf0iMbQ/
         SgEruU8oX1GJlv0SBk2+gedJXRq3SjoG1AZLpeP7akWsGbtmbXD1vNAT8Pt/dypUogdb
         wYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DSBm5hTnVx+7dwCFzA5fliIxja1q/A/MZRb7WbAzM94=;
        b=jpmfCBO+TqOHBMjvKr7uVTIGddGxqEBMYtsMAnArjfCl3tWgVcP2x+88f5M/iRMRyU
         KRF6SHc+D0mM1N1zKHMU2jMEFOXfQMR8W0Lu/xlW4jHMqDkz3qLShF5w92c1QPCbDBLj
         SDJYWrqB1sTaGVJx3LRNhD4c+/2Uc4NE93KQbT2cSx4TjW9jNvUZw6KbYpD8rWo/AGAl
         /vallFRwAGJy8U+fXmd0CdWpoFWOwnIy4rmxcP/1xPWpdRXG1c5YBQddcAqfBdHNS5CM
         ++jKcHC5ee+/QGWXyOu3GWmG1mulaWyDR/AQQ3K+OO3jw7q84KorYPu/s4O0mwM8apjl
         hkJQ==
X-Gm-Message-State: APjAAAWkf1Svd8oKxn/Hr1flq0HEQtPaUXsec425eVmZdIzi0sE76AfK
        Ki8XR3HafEBdch2QQ4OgcZ4i1kW0wAk=
X-Google-Smtp-Source: APXvYqz7TpET9fzs9E1TMXoR3qu3K+pxRKqZN63i0UfY1jyuGvevpGo+lc/OnQCVsL4nGuTB022aLg==
X-Received: by 2002:a02:bb02:: with SMTP id y2mr16978369jan.105.1557692257905;
        Sun, 12 May 2019 13:17:37 -0700 (PDT)
Received: from Fredericks-MacBook-Pro.local (173-17-200-179.client.mchsi.com. [173.17.200.179])
        by smtp.gmail.com with ESMTPSA id x77sm649362ita.1.2019.05.12.13.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 13:17:36 -0700 (PDT)
Subject: Re: [PATCH RFC v2 3/3] PCI/ASPM: add sysfs attribute for controlling
 ASPM
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <e041842a-55ed-91e3-75c2-c1a0267b74e5@gmail.com>
 <773b6a8a-00ac-a275-c80b-d5909ca58f19@gmail.com>
 <d8e271e0-d83f-14f9-00d6-ad63a56d8959@fredlawl.com>
 <4370c154-7e0b-26ac-4660-bb254cef7425@gmail.com>
From:   Frederick Lawler <fred@fredlawl.com>
Message-ID: <d69eb045-4a20-7f75-799e-5a374cd5424b@fredlawl.com>
Date:   Sun, 12 May 2019 15:18:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 PostboxApp/6.1.16.1
MIME-Version: 1.0
In-Reply-To: <4370c154-7e0b-26ac-4660-bb254cef7425@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Heiner Kallweit wrote on 5/12/19 9:03 AM:
> On 12.05.2019 03:02, Frederick Lawler wrote:
>> Evening,
>>
>> Heiner Kallweit wrote on 5/11/19 10:33 AM:> +static ssize_t aspm_disable_link_state_show(struct device *dev,
> [..]
>>
>> Since we're introducing a new sysfs interface, would it be more appropriate to rename the sysfs files to aspm_set_link_state (or something to that effect)?
>>
>> The syntax as it stands, means that to enable a state, a double negative must be used:
>>
>> echo "-L1.1" > ./aspm_disable_link_state"
>> vs
>> echo "+L1.1" > ./aspm_set_link_state
>>
>> If we avoid the double negative, the documentation about to be written will be more clear and use of the sysfs file will be more intuitive.
>>
> In addition to these more formal parts: Can you test the functionality?

I don't have enough hardware to fully test things out. I just have 1 
device with ASPM support and no switches.

I'll have a go tonight with the v3 patches and report back.

> 
>> Thanks,
>> Frederick Lawler
>>
>>
> Heiner
> 

Frederick Lawler

