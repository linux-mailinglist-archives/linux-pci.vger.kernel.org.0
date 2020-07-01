Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0379210F12
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jul 2020 17:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbgGAPYo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jul 2020 11:24:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731586AbgGAPYo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Jul 2020 11:24:44 -0400
Received: from [192.168.1.74] (75-58-59-55.lightspeed.rlghnc.sbcglobal.net [75.58.59.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1861620760;
        Wed,  1 Jul 2020 15:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593617083;
        bh=lYDpo6N5utNIV5srpaGQzyD7U2VmRJv6m6CY2CUUBvw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OTHiCAr8JYDWs8xd16Vi63K1/h0cR6LDCc4IvjLQ35RawePAj8XYjibwKOmH2WJLt
         ZVKpHXxoaugFbAkdfOVUlfzjDZ900xwBDs69lktnpyhbLmfVFOa03riMSrTzoxom20
         tU7gALdFbt9McLmJtrbWzzevsZYxgYADUumnEnsQ=
Subject: Re: [PATCH 2/2] PCI/AER: Fix deadlock triggered by AER and sriov
 enable routine
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, f.fangjian@huawei.com,
        huangdaode@huawei.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Christoph Hellwig <hch@lst.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20200630235853.GA3500801@bjorn-Precision-5520>
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
Message-ID: <63f0a62c-ec47-e48f-d6b6-74448fef9de5@kernel.org>
Date:   Wed, 1 Jul 2020 11:24:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630235853.GA3500801@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/30/2020 7:58 PM, Bjorn Helgaas wrote:
> when adding VF by sysfs:
> sriov_numvfs_store()
> 	device_lock()
> 		...
> 		sriov_enable()
> 			...
> 			pci_device_add()
> 				down_write(&pci_bus_sem)
> when invoking aer routine:
> pcie_do_recovery()
> 	...
> 	pci_walk_bus()
> 		down_read(&pci_bus_sem)
> 		report_*()
> 			...
> 			device_lock()

if we are going to this path, I'd like to see that we kill pci_bus_sem
altoghether.
