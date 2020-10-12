Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E44228BB63
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 16:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389539AbgJLOvo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 10:51:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387930AbgJLOvo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Oct 2020 10:51:44 -0400
Received: from [192.168.0.112] (75-58-59-55.lightspeed.rlghnc.sbcglobal.net [75.58.59.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A3982080A;
        Mon, 12 Oct 2020 14:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602514303;
        bh=MqiIO/6MLXuvTKpPmH2MYO7ZOZ7tXD/fVdrsl4Sxio4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ab0mjyt6GjPskoZ3bBXarcCywI9R/YTxaDDDWlwsdaq5jRBDUNjnMrLvHH4gNM1Da
         Pujbe7UUQgTx60I0z+s0XmsxmB7Jyhwj0PBW+Cmpftvmez29g4Ebj0jv8JdS++Ftla
         wsFSV7Lc0VBp6m4ype8rPRqRdYnpb6zptW/LGzew=
Subject: Re: [PATCH v3 1/1] PCI/ERR: Fix reset logic in pcie_do_recovery()
 call
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        Jay Vosburgh <jay.vosburgh@canonical.com>
References: <20200922233333.GA2239404@bjorn-Precision-5520>
 <1fdcc4a6-53b7-2b5f-8496-f0f09405f561@linux.intel.com>
 <aef0b9aa-59f5-9ec3-adac-5bc366b362e0@kernel.org>
 <a647f485-8db4-db45-f404-940b55117b53@linux.intel.com>
 <aefd8842-90c4-836a-b43a-f21c5428d2ba@kernel.org>
 <95e23cb5-f6e1-b121-0de8-a2066d507d9c@linux.intel.com>
 <65238d0b-0a39-400a-3a18-4f68eb554538@kernel.org>
 <4ae86061-2182-bcf1-ebd7-485acf2d47b9@linux.intel.com>
 <f360165e-5f73-057c-efd1-557b5e5027eb@kernel.org>
 <8beca800-ffb5-c535-6d43-7e750cbf06d0@linux.intel.com>
 <44f0cac5-8deb-1169-eb6d-93ac4889fe7e@kernel.org>
 <3bc0fd23-8ddd-32c5-1dd9-4d5209ea68c3@linux.intel.com>
 <a2bbdfed-fb17-51dc-8ae4-55d924c13211@kernel.org>
 <8a3aeb3c-83c4-8626-601d-360946d55dd8@linux.intel.com>
 <9b295cad-7302-cf2c-d19d-d27fabcb48be@kernel.org>
 <93b4015f-df2b-728b-3ef7-ac5aa10f03ed@kernel.org>
 <d6da2246-cf82-315e-c716-62ab9ec13a22@linux.intel.com>
 <0013f3d2-569a-27ba-336e-3d4668834545@linux.intel.com>
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
Message-ID: <95fb03e3-97c0-296f-25ba-5d7ce857ad86@kernel.org>
Date:   Mon, 12 Oct 2020 10:51:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <0013f3d2-569a-27ba-336e-3d4668834545@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/12/2020 1:13 AM, Kuppuswamy, Sathyanarayanan wrote:
> Hi Sinan,
> 
> On 9/28/20 11:32 AM, Kuppuswamy, Sathyanarayanan wrote:
>>
>>
>> On 9/28/20 11:25 AM, Sinan Kaya wrote:
>>> On 9/28/2020 2:02 PM, Sinan Kaya wrote:
>>>> Since there is no state restoration for FATAL errors, I am wondering
>>>> whether
>>>> calls to ->error_detected(), ->mmio_enabled() and ->slot_reset() are
>>>> required?
>>>
>>> I also would like to ask someone closer to the spec language double
>>> check this.
>>>
>>> When we recover the link at the end of the DPC handler, what is the
>>> expected state of the endpoint?
>>>
>>> Is it a some kind of a reset like secondary bus reset? (I assumed this
>>>   one)
>> I think it will be in reset state.
>>>
>>> Undefined?
>>>
>>> or just plain link recovery with everything else as intact as it used
>>> to be?
>>>
>>
> 
> Please check the following version. It should fix most of the reset issues
> properly.
> 
> https://lore.kernel.org/linux-pci/5c5bca0bdb958e456176fe6ede10ba8f838fbafc.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com/T/#t
> 
> 

Thanks, good stuff.
