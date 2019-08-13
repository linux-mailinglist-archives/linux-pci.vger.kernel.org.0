Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67AD58B917
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 14:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfHMMsl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 08:48:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36914 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfHMMsi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Aug 2019 08:48:38 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190813124836euoutp0208e57700f58be3bba8135649a664b4a7~6fFMLSnN80545005450euoutp02X
        for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2019 12:48:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190813124836euoutp0208e57700f58be3bba8135649a664b4a7~6fFMLSnN80545005450euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565700516;
        bh=xJW2N+InaQSTPomm1XVnEng30foi6NAeLOPusdmdIo0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GxsdQ6/xYDYAKv4Lkn6CqM/mR7wacUeWb343ooTs+ofvvUZOMiQww7Py5eFAEILRV
         GPzBjiIHaEzZ2jgFhIbpYfs8gyez4aXFNms19gX/SYqdEEJUxh7uXMXwZD7mlxLiNw
         Zqqg3uzjBEt964nv5smzdmhUqZPBxVM8eTmzSZgY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190813124835eucas1p13cf168bcd18f3c75ed1a5bf426829594~6fFLUKorf3217532175eucas1p1y;
        Tue, 13 Aug 2019 12:48:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 8F.CA.04469.3A1B25D5; Tue, 13
        Aug 2019 13:48:35 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190813124834eucas1p16c12b52102e18fd6dcfb02f44a2acd6f~6fFKif5F73225832258eucas1p1-;
        Tue, 13 Aug 2019 12:48:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190813124834eusmtrp11d974e10d5e764a6e94e70b69bebd531~6fFKSqW4F0418804188eusmtrp1V;
        Tue, 13 Aug 2019 12:48:34 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-3f-5d52b1a3149e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9D.32.04166.2A1B25D5; Tue, 13
        Aug 2019 13:48:34 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190813124834eusmtip26b03372d95c5e25986128063367696a2~6fFJ8r4NG0656706567eusmtip2O;
        Tue, 13 Aug 2019 12:48:34 +0000 (GMT)
Subject: Re: [PATCH 6/7] efifb: Use PCI_STD_NUM_BARS in loops instead of
 PCI_STD_RESOURCE_END
To:     Denis Efremov <efremov@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Peter Jones <pjones@redhat.com>, linux-fbdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <6c4e491c-8afd-92b0-45b5-d915de399ccc@samsung.com>
Date:   Tue, 13 Aug 2019 14:48:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190811150802.2418-7-efremov@linux.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djP87qLNwbFGvQvEbNY0pRhceXUbkaL
        E30fWC0u75rDZnF23nE2i66FN9gd2DwWbCr1eHJlOpPH+31X2Tw+b5ILYInisklJzcksSy3S
        t0vgylj29TNzwTn2ilUfJ7M2MM5m62Lk5JAQMJFo+nGBvYuRi0NIYAWjxMM9/SwQzhdGiYYz
        p6AynxklFi5Zw9TFyAHWcuqlJUR8OaPE2q3vmSGct0BFmzezg8wVFoiXuPvpOCuILSLgJfF2
        /y2wfcwC1RJLj24Eq2ETsJKY2L6KEcTmFbCT+HXrAZjNIqAqsWBGB1i9qECExP1jG1ghagQl
        Ts58wgJicwqYSTT/PcYEMVNc4taT+VC2vMT2t3PADpIQWMQu8WfhbahHXSTm9G9mgbCFJV4d
        38IOYctInJ7cwwLRsI5R4m/HC6ju7YwSyyf/g+q2ljh8/CIryP/MApoS63fpQ4QdJTq/3mWB
        BAufxI23ghBH8ElM2jadGSLMK9HRJgRRrSaxYdkGNpi1XTtXMk9gVJqF5LVZSN6ZheSdWQh7
        FzCyrGIUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMNqf/Hf+0g/HrpaRDjAIcjEo8vBUJ
        gbFCrIllxZW5hxglOJiVRHgvmQTFCvGmJFZWpRblxxeV5qQWH2KU5mBREuetZngQLSSQnliS
        mp2aWpBaBJNl4uCUamCU2R94qVNmQZt+bdynpwHsVlw3le69uF517kR5xTu1ouL12w7fvvet
        32WrKIOD8p9K36hnPN3PN/6yK01d+49n602OgzMrA34pv/E1u/XVN+9G5o0v95ZsTOt0L5A4
        tC9L5fQxC+lZwmwiTEcTlXXbWd9cus7byZH4jk/7d4jgfYdMwQlp6veVWIozEg21mIuKEwG7
        qPvzMgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xe7qLNgbFGizrVLBY0pRhceXUbkaL
        E30fWC0u75rDZnF23nE2i66FN9gd2DwWbCr1eHJlOpPH+31X2Tw+b5ILYInSsynKLy1JVcjI
        Ly6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy1j29TNzwTn2ilUfJ7M2
        MM5m62Lk4JAQMJE49dKyi5GLQ0hgKaPE9BXXWSHiMhLH15d1MXICmcISf651sUHUvGaUaJ21
        hAkkISwQL3H303FWEFtEwEvi7f5bYDOZBaolLvRrQ9RvZZR4d7CVHaSGTcBKYmL7KkYQm1fA
        TuLXrQdgNouAqsSCGR1sILaoQITEmfcrWCBqBCVOznwCZnMKmEk0/z0GtpdZQF3iz7xLzBC2
        uMStJ/Oh4vIS29/OYZ7AKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5y
        fu4mRmBkbTv2c/MOxksbgw8xCnAwKvHwViQExgqxJpYVV+YeYpTgYFYS4b1kEhQrxJuSWFmV
        WpQfX1Sak1p8iNEU6LmJzFKiyfnAqM8riTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2a
        WpBaBNPHxMEp1cDo8Svr2Krt0xn9125e/nWTTWLYzJtmwnwfXr4vVPJ62iDpeqLw4L13DoVn
        596x1+/3/9u674NwhstyodSG1pfKZ8N7Ne16jr2K05iqq1Nuksitc/Xk+nnHYzOWN7Tsf+QS
        W5Bw+dX7qoNqpz5/eCH09Z2f9gzZvV/qI/bwRb7ti2796MC4w++cEktxRqKhFnNRcSIAf2dF
        T8ICAAA=
X-CMS-MailID: 20190813124834eucas1p16c12b52102e18fd6dcfb02f44a2acd6f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190811151322epcas3p283d7a3293a12dfac23d13d8a16349d1f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190811151322epcas3p283d7a3293a12dfac23d13d8a16349d1f
References: <20190811150802.2418-1-efremov@linux.com>
        <CGME20190811151322epcas3p283d7a3293a12dfac23d13d8a16349d1f@epcas3p2.samsung.com>
        <20190811150802.2418-7-efremov@linux.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/11/19 5:08 PM, Denis Efremov wrote:
> This patch refactors the loop condition scheme from
> 'i <= PCI_STD_RESOURCE_END' to 'i < PCI_STD_NUM_BARS'.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> ---
>  drivers/video/fbdev/efifb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index 04a22663b4fb..6c72b825e92a 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -668,7 +668,7 @@ static void efifb_fixup_resources(struct pci_dev *dev)
>  	if (!base)
>  		return;
>  
> -	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  		struct resource *res = &dev->resource[i];
>  
>  		if (!(res->flags & IORESOURCE_MEM))

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
