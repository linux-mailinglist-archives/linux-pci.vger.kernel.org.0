Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8399117E5C7
	for <lists+linux-pci@lfdr.de>; Mon,  9 Mar 2020 18:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgCIRdY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 13:33:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbgCIRdY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Mar 2020 13:33:24 -0400
Received: from [10.92.140.19] (unknown [167.220.149.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B68EE2253D;
        Mon,  9 Mar 2020 17:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583775203;
        bh=OPvAhZU/tS5NFfMe/c6StBpbMxSefWPPCHzSeD5wjiM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=0ZjuCybWyGhI8AYb0qPclD5fuOmsHSMa0+xj1q5dkUcUoZIFHMWihmvmLhTxPQ0ue
         OAoFXn94zwuzzPMk6MzfdEdihhavfy7KCijNulHzTwnKt3WDJMK1bcWSSAqF+RkmPl
         MPDC7eIQ46lrP9ikMN4Wf3iFrhUoli5uTyaiYKSs=
Subject: Re: [PATCH v4 3/3] PCI: Add CRS handling to pci_dev_wait()
To:     "Spassov, Stanislav" <stanspas@amazon.de>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Schoenherr, Jan H." <jschoenh@amazon.de>,
        "rajatja@google.com" <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
References: <20200307172044.29645-1-stanspas@amazon.com>
 <20200307172044.29645-4-stanspas@amazon.com>
 <0461c706-579b-8c03-cf33-66e79890af92@kernel.org>
 <20200309161951.GA25817@otc-nc-03>
 <af2ba4c11c28848dc7d1827c23e6b038cc051eed.camel@amazon.de>
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
Message-ID: <56e6d6e2-ebc4-7d37-70af-7d38c22f5f1d@kernel.org>
Date:   Mon, 9 Mar 2020 13:33:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <af2ba4c11c28848dc7d1827c23e6b038cc051eed.camel@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/9/2020 12:38 PM, Spassov, Stanislav wrote:
> So, whenever a VF is providing an actual response to a vid/did read, it will respond with a Successful Completion and the data
> will be 0xFFFF. However, when the VF is not ready yet after a reset, I would expect it to be returning CRS completions just like
> any other device (nothing in the spec explicitly confirms or denies this, as far as I can tell). Then, the root port has no idea
> if a device that it received a CRS completion from is a PF or VF, so it has to treat them equivalently, and therefore (for CRS SV enabled)
> synthesize 0x0001 for the VID.

Looking closer, I see you brought bad_value to the function parameter.
Yes, this should work as long as device responds with 0x0001. Previous
code used to bail out on ~0x0 immediately.
