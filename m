Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F54D28A897
	for <lists+linux-pci@lfdr.de>; Sun, 11 Oct 2020 19:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388332AbgJKR4Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Oct 2020 13:56:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388329AbgJKR4Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 11 Oct 2020 13:56:16 -0400
Received: from [192.168.0.112] (75-58-59-55.lightspeed.rlghnc.sbcglobal.net [75.58.59.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EE4C2222A;
        Sun, 11 Oct 2020 17:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602438975;
        bh=3swoFZnk6eoJR33A60KKudC95FI10RHpWVJDChX64ag=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=vdQMvO0197ufHU2Xnm012dowy74xeJ4qOTOh6me0mBnoaSWAa4nxG6SBhENXxKdNh
         sGYP0th9GLnAinFbAxH82Y3ptXEJ8YEYu4MRK4PH8muTdxMqyCSERDJuHhuChvVbOn
         UzILR5BuW3HHoDlMEfn94BSbMgfJZy6HEsSHld04=
Subject: Re: [RESEND PATCH v3 1/1] PCI/ERR: don't clobber status after
 reset_link()
To:     Hedi Berriche <hedi.berriche@hpe.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Russ Anderson <rja@hpe.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Joerg Roedel <jroedel@suse.com>, stable@kernel.org
References: <20201010221653.2782993-1-hedi.berriche@hpe.com>
 <20201010221653.2782993-2-hedi.berriche@hpe.com>
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
Message-ID: <5f5eeaf4-4638-6718-1ec9-002d6753e73f@kernel.org>
Date:   Sun, 11 Oct 2020 13:56:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201010221653.2782993-2-hedi.berriche@hpe.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/10/2020 6:16 PM, Hedi Berriche wrote:
> Commit 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
> broke pcie_do_recovery(): updating status after reset_link() has the ill
> side effect of causing recovery to fail if the error status is
> PCI_ERS_RESULT_CAN_RECOVER or PCI_ERS_RESULT_NEED_RESET as the following
> code will *never* run in the case of a successful reset_link()
> 
>    177         if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>    ...
>    181         }
> 
>    183         if (status == PCI_ERS_RESULT_NEED_RESET) {
>    ...
>    192         }
> 
> For instance in the case of PCI_ERS_RESULT_NEED_RESET we end up not
> calling ->slot_reset() (because we skip report_slot_reset()) thus
> breaking driver (re)initialisation.
> 
> Don't clobber status with the return value of reset_link(); set status
> to PCI_ERS_RESULT_RECOVERED, in case of successful link reset, if and
> only if the initial value of error status is PCI_ERS_RESULT_DISCONNECT
> or PCI_ERS_RESULT_NO_AER_DRIVER.
> 
> Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
> Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
> Cc: Russ Anderson <rja@hpe.com>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Joerg Roedel <jroedel@suse.com>
> 
> Cc: stable@kernel.org # v5.7+
> ---
>  drivers/pci/pcie/err.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index c543f419d8f9..2730826cfd8a 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -165,10 +165,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	pci_dbg(dev, "broadcast error_detected message\n");
>  	if (state == pci_channel_io_frozen) {
>  		pci_walk_bus(bus, report_frozen_detected, &status);
> -		status = reset_link(dev);
> -		if (status != PCI_ERS_RESULT_RECOVERED) {
> +		if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED) {
>  			pci_warn(dev, "link reset failed\n");
>  			goto failed;
> +		} else {
> +			if (status == PCI_ERS_RESULT_DISCONNECT ||
> +			    status == PCI_ERS_RESULT_NO_AER_DRIVER)
> +				status = PCI_ERS_RESULT_RECOVERED;
>  		}
>  	} else {
>  		pci_walk_bus(bus, report_normal_detected, &status);
> 

Reviewed-by: Sinan Kaya <okaya@kernel.org>
