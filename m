Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 234351762BA
	for <lists+linux-pci@lfdr.de>; Mon,  2 Mar 2020 19:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgCBSar (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Mar 2020 13:30:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:52208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbgCBSar (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Mar 2020 13:30:47 -0500
Received: from [10.92.140.24] (unknown [167.220.149.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87CA124676;
        Mon,  2 Mar 2020 18:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583173846;
        bh=2eVK1AtuSn8+UNKrDC4S7gLe4Rv5HLzujGn3iumTNBk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dJNxp8TQgrZIb8wKphs5RGuslTef4V1oP4Yri5ZcqJ1BrDOMciyA7d65zeMLJbIZ5
         kI0tLYxDST1x22lJT7dwvKBKddZzq+Hrtf0V1XEbu17ZUF0pgDBn+8iTpGLl0jcG2/
         k9bi8VjOJgQlUe3NNJWsxMRtw3rUBHrcA+kNXsgs=
Subject: Re: [PATCH 1/3] PCI: Make PCIE_RESET_READY_POLL_MS configurable
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Spassov, Stanislav" <stanspas@amazon.de>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Wang, Wei" <wawei@amazon.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Schoenherr, Jan H." <jschoenh@amazon.de>,
        "rajatja@google.com" <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20200227214534.GA143139@google.com>
 <e162efcd-70fd-3390-2452-4915af1c9171@kernel.org>
 <20200228021855.GA57330@otc-nc-03>
 <51d5948e-8d53-432e-8ec2-46704c3e8d41@kernel.org>
 <20200302173728.GA77115@otc-nc-03>
From:   Sinan Kaya <okaya@kernel.org>
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
Message-ID: <885cef84-575b-b564-f5b4-75848486466c@kernel.org>
Date:   Mon, 2 Mar 2020 13:30:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302173728.GA77115@otc-nc-03>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/2/2020 12:37 PM, Raj, Ashok wrote:
>> 1 second is too aggressive. We already have proof that several PCIe
>> cards take their time during FLR especially FPGA cards in the orders
>> of 10 seconds.
> Aren't the rules specified in 7.9.17 Rediness Time Reporting Extended Capability
> sufficient to cover this?
> 

Yes, readiness would work too but it is not a mandatory feature.
Readiness is yet another alternative to CRS advertised as the new
flashy way of doing things. Problem is backwards compatibility.

Do you want to break all existing/legacy drivers for an optional/new
spec defined feature?

> If a device doesn't have them we could let the driver supply this value
> as a device specific value to override the default.
> 
>> Current code is waiting up to 60 seconds. If card shows up before that
>> we happily return.
>>
> But in 7.9.17.2 Readiness Time Reporting 1 Register, says devices
> can defer reporting by not setting the valid bit, but if it remains
> clear after 60s system software can assume no valid values will be reported.
> 
> Maybe keep the system default to something more reasonable (after some
> testing in the community), and do this insane 60s for devices that 
> support the optional reporting capability?

I think we should add readiness capability on top of CRS but not
exclusively.

If readiness is supported, do the spec defined behavior.
If not supported, fallback to CRS for legacy devices.

I remember Bjorn mentioning about readiness capability. Maybe, this is
the time to implement it.
