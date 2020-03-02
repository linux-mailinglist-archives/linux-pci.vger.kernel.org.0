Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFADA176029
	for <lists+linux-pci@lfdr.de>; Mon,  2 Mar 2020 17:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgCBQjn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Mar 2020 11:39:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbgCBQjn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Mar 2020 11:39:43 -0500
Received: from [10.92.140.24] (unknown [167.220.149.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0C1321D56;
        Mon,  2 Mar 2020 16:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583167182;
        bh=e4WX39dx3wQ/Stuc2+G+xsDQB91dilEWlHnVA3qQrCI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ge2lrXUxdZxrVr3AZTjN7ytRBIxaKjHCDUM6Q4kONpQMM/MWYfXsv00qkXONiI5hi
         EwHyJg9wG49z0p8+3Nd7kBLP6xZ5rKJHcO6SVgOcaqdYMV5cnJPHstmRSrNuhTbXzu
         Z1JxrPdZ2cGDWPouyCb9/8tIvFM0f505e9AUsXWU=
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
Message-ID: <51d5948e-8d53-432e-8ec2-46704c3e8d41@kernel.org>
Date:   Mon, 2 Mar 2020 11:39:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200228021855.GA57330@otc-nc-03>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/27/2020 9:18 PM, Raj, Ashok wrote:
>> If I remember right, there was no time mention about how long to
>> wait. Spec says device should send CRS as long as it is not ready.
> Not exactly.. there are some requirements to follow for rules after
> a conventional reset. 

Yes, but CRS happens after functional reset, D3hot etc. too not just
conventional reset.

1 second is too aggressive. We already have proof that several PCIe
cards take their time during FLR especially FPGA cards in the orders
of 10 seconds.

Current code is waiting up to 60 seconds. If card shows up before that
we happily return.

