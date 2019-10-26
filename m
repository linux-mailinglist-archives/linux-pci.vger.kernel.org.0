Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75925E5D92
	for <lists+linux-pci@lfdr.de>; Sat, 26 Oct 2019 15:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfJZN7e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Oct 2019 09:59:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbfJZN7e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 26 Oct 2019 09:59:34 -0400
Received: from [192.168.1.74] (75-58-59-55.lightspeed.rlghnc.sbcglobal.net [75.58.59.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63243214DA;
        Sat, 26 Oct 2019 13:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572098373;
        bh=2092hUManuELIoPthm7V2zGy49LHaePQUOfeSdT5QdM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PeHNzb/ZKNXk8y3Fqvhtf7b2J2LmDIVvrGkzLDojWKOtM4FZ5owkrJVsEcq1TYTPT
         AG0/ufkMTsMQlrWkJNFffgPfq5ZWGnYgo4JuO9PJr7mljToQ6BkGeDDHsMLFFTbuUU
         KRRReHJ9e+K4a0LSob49an3FifZjsKUNW3ODPg+k=
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
To:     Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Thierry Reding <treding@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20191005182129.32538-1-vidyas@nvidia.com>
 <20191014082023.GA232162@ulmo>
 <ce411d27-5b92-8dae-fccd-73c63aa30f1c@kernel.org>
 <20191015093053.GA5778@ulmo>
 <4953b718-8818-575e-2ec1-8197e6b32593@kernel.org>
 <85267afb-c08e-5625-d3ee-bd32af9ecb12@nvidia.com>
 <afa16546-e63d-6eba-8be0-8e52339cd100@nvidia.com>
 <aed391af-f54c-c25e-43b9-ed9db01bd3cf@nvidia.com>
From:   Sinan Kaya <okaya@kernel.org>
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
Message-ID: <4424cd45-e441-0d8d-548e-5c025f48bb03@kernel.org>
Date:   Sat, 26 Oct 2019 09:59:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <aed391af-f54c-c25e-43b9-ed9db01bd3cf@nvidia.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/25/2019 7:58 AM, Vidya Sagar wrote:
> On 10/21/2019 11:13 AM, Vidya Sagar wrote:
> 
> Hi Sinan / Rafael,
> Apologies for the ping again.
> Do you guys have any further comments on this?
> 
> -Vidya Sagar

I think you'll need some attention from Bjorn here to see the complete
picture.

As I said, changing pci_device_is_present() is not right. This needs to
be done at one level higher.
