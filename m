Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 907ED354D2
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2019 02:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfFEA7h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 20:59:37 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35312 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFEA7h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 20:59:37 -0400
Received: by mail-yw1-f68.google.com with SMTP id k128so9738468ywf.2
        for <linux-pci@vger.kernel.org>; Tue, 04 Jun 2019 17:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yKKrkMgWSq93zEFxYWV4MSSzOa4VPaOPkq02QeLRp94=;
        b=sliTTHHSxf3af10w+qICyDLZ8w6SKEHDKZbiqkmu1hFnbO3RXpWDqE6UAwZgI3S1ML
         EQI+rHla9pA+eTffctaSdiRZrq6vAyxoGzlgw/dG5Pp3asn5niVNvrpPM5TVcFlQ6UX1
         /uBCG1RjBB3wksKAOZS0demXCELqbI1HqKgsHJfYv7NWq3Mdg4z1E0WXRlhyvZ0c80JJ
         Osqit6xyBQQj1XTdOHzAwWqp/wu4F6X9g/wZHRCgGSqquAzE8GmEk4Rv8G0+Zad65/tZ
         8z32yPunIoTPrZ2GYmsaKPYzGCwj9usafT+UBtzMNmt4wCxT5VMqoj0977IlEq3VoH7R
         APaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yKKrkMgWSq93zEFxYWV4MSSzOa4VPaOPkq02QeLRp94=;
        b=Mn6anY7wuTLgj4rQYBfrVl+Tw+sMA2QPIA2awmc/uSm9YVFKlwzujH4powbJhOznyx
         HgLv08NuNLB6vDrXyJ07AIgphU/XlKU9noLAWzY/4EgsoaZiDSvlXl+i3TFgcEOcCu11
         jvjzsk6gGRbFaGjY7YYnnKZXU3III2V2GND+fU38uGMgO8NjMJVa19Y2IORBAl3Pip3l
         MpGAeRgeAcu3+1t7PD9mEEeZXMZqfUikd9NAhqETuRHlq2vbxmTt5T8ihxun9lr20eRN
         GEH/d/dDcLmehARGciwYGT9kSJAP0zCflHmA8T45uARTdx/JNZodn/eX/jUTBqb+gD3c
         Dg9A==
X-Gm-Message-State: APjAAAWLi7el1sBRC1whwC70jonMU1NK5OPjtuY2uyNcrreaJv6gfI6A
        COeYYaY3zQKRFX7YZPv9VDk5yD1Q
X-Google-Smtp-Source: APXvYqyqG1q9VJ6QTE4WgLmRWXpPLmN1V7oACOUPP1OqfuQob3GLN1miAEms0Iek9skWl7Qhljo4og==
X-Received: by 2002:a81:4b92:: with SMTP id y140mr8640877ywa.264.1559696376451;
        Tue, 04 Jun 2019 17:59:36 -0700 (PDT)
Received: from [192.168.1.74] (75-58-59-55.lightspeed.rlghnc.sbcglobal.net. [75.58.59.55])
        by smtp.gmail.com with ESMTPSA id u65sm4734547ywa.39.2019.06.04.17.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 17:59:35 -0700 (PDT)
From:   Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Subject: Re: Bug report: AER driver deadlock
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Fangjian (Turing)" <f.fangjian@huawei.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <a7dcc378-6101-ac08-ec8e-be7d5c183b49@huawei.com>
 <CAK9iUCPREGruU7zGqnkS9w_x8Q7iE8twveEp2dn8ArupTTQyHA@mail.gmail.com>
 <a1c90cfb9ce4062b4823c6647d7709baf1c5534f.camel@kernel.crashing.org>
Openpgp: preference=signencrypt
Autocrypt: addr=okaya@kernel.org; keydata=
 mQENBFrnOrUBCADGOL0kF21B6ogpOkuYvz6bUjO7NU99PKhXx1MfK/AzK+SFgxJF7dMluoF6
 uT47bU7zb7HqACH6itTgSSiJeSoq86jYoq5s4JOyaj0/18Hf3/YBah7AOuwk6LtV3EftQIhw
 9vXqCnBwP/nID6PQ685zl3vH68yzF6FVNwbDagxUz/gMiQh7scHvVCjiqkJ+qu/36JgtTYYw
 8lGWRcto6gr0eTF8Wd8f81wspmUHGsFdN/xPsZPKMw6/on9oOj3AidcR3P9EdLY4qQyjvcNC
 V9cL9b5I/Ud9ghPwW4QkM7uhYqQDyh3SwgEFudc+/RsDuxjVlg9CFnGhS0nPXR89SaQZABEB
 AAG0HVNpbmFuIEtheWEgPG9rYXlhQGtlcm5lbC5vcmc+iQFOBBMBCAA4FiEEYdOlMSE+a7/c
 ckrQvGF4I+4LAFcFAlztcAoCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQvGF4I+4L
 AFfidAf/VKHInxep0Z96iYkIq42432HTZUrxNzG9IWk4HN7c3vTJKv2W+b9pgvBF1SmkyQSy
 8SJ3Zd98CO6FOHA1FigFyZahVsme+T0GsS3/OF1kjrtMktoREr8t0rK0yKpCTYVdlkHadxmR
 Qs5xLzW1RqKlrNigKHI2yhgpMwrpzS+67F1biT41227sqFzW9urEl/jqGJXaB6GV+SRKSHN+
 ubWXgE1NkmfAMeyJPKojNT7ReL6eh3BNB/Xh1vQJew+AE50EP7o36UXghoUktnx6cTkge0ZS
 qgxuhN33cCOU36pWQhPqVSlLTZQJVxuCmlaHbYWvye7bBOhmiuNKhOzb3FcgT7kBDQRa5zq1
 AQgAyRq/7JZKOyB8wRx6fHE0nb31P75kCnL3oE+smKW/sOcIQDV3C7mZKLf472MWB1xdr4Tm
 eXeL/wT0QHapLn5M5wWghC80YvjjdolHnlq9QlYVtvl1ocAC28y43tKJfklhHiwMNDJfdZbw
 9lQ2h+7nccFWASNUu9cqZOABLvJcgLnfdDpnSzOye09VVlKr3NHgRyRZa7me/oFJCxrJlKAl
 2hllRLt0yV08o7i14+qmvxI2EKLX9zJfJ2rGWLTVe3EJBnCsQPDzAUVYSnTtqELu2AGzvDiM
 gatRaosnzhvvEK+kCuXuCuZlRWP7pWSHqFFuYq596RRG5hNGLbmVFZrCxQARAQABiQEfBBgB
 CAAJBQJa5zq1AhsMAAoJELxheCPuCwBX2UYH/2kkMC4mImvoClrmcMsNGijcZHdDlz8NFfCI
 gSb3NHkarnA7uAg8KJuaHUwBMk3kBhv2BGPLcmAknzBIehbZ284W7u3DT9o1Y5g+LDyx8RIi
 e7pnMcC+bE2IJExCVf2p3PB1tDBBdLEYJoyFz/XpdDjZ8aVls/pIyrq+mqo5LuuhWfZzPPec
 9EiM2eXpJw+Rz+vKjSt1YIhg46YbdZrDM2FGrt9ve3YaM5H0lzJgq/JQPKFdbd5MB0X37Qc+
 2m/A9u9SFnOovA42DgXUyC2cSbIJdPWOK9PnzfXqF3sX9Aol2eLUmQuLpThJtq5EHu6FzJ7Y
 L+s0nPaNMKwv/Xhhm6Y=
Message-ID: <80014307-a6f0-7177-7af6-fb2f14e28b0c@kernel.org>
Date:   Tue, 4 Jun 2019 20:59:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a1c90cfb9ce4062b4823c6647d7709baf1c5534f.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/4/2019 7:47 PM, Benjamin Herrenschmidt wrote:
>> Should we replace these device lock with try lock loop with some sleep
>> statements. This could solve the immediate deadlock issues until
>> someone implements granular locking in pci.
> That won't necessarily solve this AB->BA problem. I think the issue
> here is that sriov shouldn't device_lock before doing something that
> can take the pci_bus_sem.
> 

I agree. I found out about lock ordering issue after reading the email
one more time.
