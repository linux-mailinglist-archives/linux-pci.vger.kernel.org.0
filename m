Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3F96395F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2019 18:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfGIQ1r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jul 2019 12:27:47 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:45302 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfGIQ1r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jul 2019 12:27:47 -0400
Received: by mail-qk1-f169.google.com with SMTP id s22so16451902qkj.12
        for <linux-pci@vger.kernel.org>; Tue, 09 Jul 2019 09:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zeIsZWOF2NHVbHkU8Fjl+MB2g0Wmv5lza2vJSCGigfI=;
        b=ZxoIFHNybUPMxi5424Gg0XEKbsxWF8TTEtYO/la8j0nKBdrWghxKKBa+cOz3p+bIJ6
         tTKygkWgrK754qgZrQfejvuSPL1n+yL2TdFHkoXLm6whUm8UD0Uxei012qg19ATF3XZx
         QS8AVVX58NY9cw0cQK+aSBH+APDo5ZIUSXlqy2VihGiYzqp5CYS8Zwq+KjivofZ6RCRH
         vE470APdN7Jd2Fjp8hIg0+M5QmQABHfaib70shG5K/GJ1kWm5CtgaomhOy9TT0sl6hvC
         WMhUT+7OVg7tOIZ3Lsy10Y2Zl6JGarNL3FhSgYM66JFx02DPWqc2+9mab7+wqMEIIXeV
         X/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:references:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zeIsZWOF2NHVbHkU8Fjl+MB2g0Wmv5lza2vJSCGigfI=;
        b=XLBFhYB4rtpdp5feeiE5HstASt9QkCmoSBdNQltRBha0vDTllpjtek+PdiFIH0pCXv
         sDUfvJd5kDjlLqbgg3oVh6BDdxR+pGWYxa+0WG5+aInq+3v/9maWxrBxq9VVyF5J6Kpy
         F1vu60LNO8vTcQB4x5gwtj3OQ8Q1a0suvpeDGluw6IbT5bf7OurEhuN5jp3wB4Obb/EG
         0Moz3OjXOhDUWhhbTM9RcYzPddUu6E3vDKdRtHqQ/Qeicb2zv9qXtNgsA/CCXUQnWZUr
         AnwF8ACcAHpZl3bACe05rx8AlHvSTvK36zU/9FxJTbsN5rzRemGDuM8x4Wr+0ftfEGP/
         XVxA==
X-Gm-Message-State: APjAAAVmdnl07V5620PU5xLcANeSJrSXtj/rnNWk+TFOeS1IRQVkyOQW
        cRLcTbFr1cn3EP2mFg9GGrVOsafR
X-Google-Smtp-Source: APXvYqx/Qfj0vG7PGLxQEzAKfA0SwnBwiLIkQi0iUOrlPMX0YmDXpA90v61aAsBM6Q22qBVyPtHaCg==
X-Received: by 2002:a37:2c46:: with SMTP id s67mr19995854qkh.396.1562689666342;
        Tue, 09 Jul 2019 09:27:46 -0700 (PDT)
Received: from [10.84.150.31] ([167.220.148.31])
        by smtp.gmail.com with ESMTPSA id j22sm8799840qtp.0.2019.07.09.09.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 09:27:45 -0700 (PDT)
From:   Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Subject: Re: reprobing BAR sizes and capabilities after a FLR?
To:     Christoph Hellwig <hch@infradead.org>, linux-pci@vger.kernel.org
References: <20190709154019.GA30673@infradead.org>
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
Message-ID: <28402a5d-713e-93d4-560d-197605233ca6@kernel.org>
Date:   Tue, 9 Jul 2019 12:27:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709154019.GA30673@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/9/2019 11:40 AM, Christoph Hellwig wrote:
> Hi all,
> 
> I've just been talking to some firmware developers that were a little
> surprised that Linux does not reprobe BAR sizes after a FLR.  I looked
> at our code and we do not reprobe anything at all after a FLR.  Is it
> a good assumption that a devices comes back in exactly the same state
> after an FLR?
> 

What's the use case for BAR size changing? I do remember that code was
saving the assigned BAR values.

I don't think FLR can be treated as a full enumeration.
