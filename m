Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0113418DDD
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 05:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhI0DIX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Sep 2021 23:08:23 -0400
Received: from mailgw.kylinos.cn ([123.150.8.42]:19660 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232526AbhI0DIU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 26 Sep 2021 23:08:20 -0400
X-UUID: 210ab987e7ee4120a6f881761a7c795a-20210927
X-CPASD-INFO: 17c0c1b8280543bc86431ceff58f605f@eoedUJBjkGheWHKBg3atnVhnZGNhj4W
        1qG9YlmRgYYaVhH5xTWJsXVKBfG5QZWNdYVN_eGpQYl9gZFB5i3-XblBgXoZgUZB3gHmdUJNfkg==
X-CPASD-FEATURE: 0.0
X-CLOUD-ID: 17c0c1b8280543bc86431ceff58f605f
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,EXT:0.0,OB:0.0,URL:-5,T
        VAL:168.0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:186.0,IP:-2.0,MAL:0.0,ATTNUM:0
        .0,PHF:-5.0,PHC:-5.0,SPF:4.0,EDMS:-3,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CF
        OB:0.0,SPC:0.0,SIG:-5,AUF:4,DUF:14797,ACD:54,DCD:156,SL:0,AG:0,CFC:0.624,CFSR
        :0.051,UAT:0,RAF:2,VERSION:2.3.4
X-CPASD-ID: 210ab987e7ee4120a6f881761a7c795a-20210927
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1, 1
X-UUID: 210ab987e7ee4120a6f881761a7c795a-20210927
X-User: lizhenneng@kylinos.cn
Received: from [172.20.108.41] [(116.128.244.169)] by nksmu.kylinos.cn
        (envelope-from <lizhenneng@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
        with ESMTP id 679021459; Mon, 27 Sep 2021 11:03:53 +0800
Subject: Re: [PATCH] PCI/sysfs: add write attribute for boot_vga
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210926071539.636644-1-lizhenneng@kylinos.cn>
 <YVDRbRF5wbcJmTtb@rocinante>
From:   =?UTF-8?B?5p2O55yf6IO9?= <lizhenneng@kylinos.cn>
Message-ID: <ca55d0ac-3127-9993-5d43-3bc97738cfbb@kylinos.cn>
Date:   Mon, 27 Sep 2021 11:06:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVDRbRF5wbcJmTtb@rocinante>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


在 2021/9/27 上午4:00, Krzysztof Wilczyński 写道:
> [+cc Huacai and Kai-Heng as they are working in this area]
>
> Hi,
>
> Thank you for sending the patch over.
>
> I assume this is simply a resend (rather than a v2), as I see no code
> changes from the previous version you sent some time ago.
Sorry, I haven't receive any reply about this email, so I resend this.
>
>> Add writing attribute for boot_vga sys node,
>> so we can config default video display
>> output dynamically when there are two video
>> cards on a machine.
> That's OK, but why are you adding this?  What problem does it solve and
> what is the intended user here?  Might be worth adding a little bit more
> details about why this new sysfs attribute is needed.
Xorg will detemine which graphics is prime output device according 
boot_vga, if there are two graphics card, and we want xorg output 
display to diffent graphics card, we can echo 1 to boot_vga.
>
> I also need to ask, as I am not sure myself, whether this is OK to do after
> booting during runtime?  What do you think Bjorn, Huacai and Kai-Heng?

I have test this function, during runtime, if xorg's graphics output 
device is card A, then we echo 1 to boot_vga of card B, and then restart 
xorg, xorg will output to card B, if we want xorg always output to card 
B, we can echo 1 to boot_vga of card B before xorg started in daemon 
process.

> Also, please correctly capitalise the subject - have a look at previous
> commit messages to see how it should look like.
>
>> +static ssize_t boot_vga_store(struct device *dev, struct device_attribute *attr,
>> +			      const char *buf, size_t count)
>> +{
>> +	unsigned long val;
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	struct pci_dev *vga_dev = vga_default_device();
>> +
>> +	if (kstrtoul(buf, 0, &val) < 0)
>> +		return -EINVAL;
>> +
>> +	if (val != 1)
>> +		return -EINVAL;
> Since this is a completely new API have a look at kstrtobool() over
> kstrtoul() as the former was created to handle user input more
> consistently.
As I want restrict available value  to 1, if we use  kstrtobool(), it 
will be available when user input other value.
>
>> +	if (!capable(CAP_SYS_ADMIN))
>> +		return -EPERM;
>> +
> Check for CAP_SYS_ADMIN is a good idea, but it has to take place before you
> attempt to accept and parse a input from the user.
>
> 	Krzysztof
