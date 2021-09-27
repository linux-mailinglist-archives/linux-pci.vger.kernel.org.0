Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627BE418E01
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 05:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhI0Drv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Sep 2021 23:47:51 -0400
Received: from mailgw.kylinos.cn ([123.150.8.42]:9428 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232488AbhI0Dru (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 26 Sep 2021 23:47:50 -0400
X-UUID: a013bda241304fef8d0013d2f5512c96-20210927
X-CPASD-INFO: d1e693d2028646ec93ce80f3e3a234c2@rYGfVmZlkmJcUnqCg3mwnVlkk5VoXIa
        Cp22BYmFkj1KVhH5xTWJsXVKBfG5QZWNdYVN_eGpQYl9gZFB5i3-XblBgXoZgUZB3s3OfVmlhlA==
X-CPASD-FEATURE: 0.0
X-CLOUD-ID: d1e693d2028646ec93ce80f3e3a234c2
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,EXT:0.0,OB:0.0,URL:-5,T
        VAL:168.0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:266.0,IP:-2.0,MAL:0.0,ATTNUM:0
        .0,PHF:-5.0,PHC:-5.0,SPF:4.0,EDMS:-3,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CF
        OB:0.0,SPC:0.0,SIG:-5,AUF:5,DUF:14810,ACD:54,DCD:156,SL:0,AG:0,CFC:0.861,CFSR
        :0.022,UAT:0,RAF:2,VERSION:2.3.4
X-CPASD-ID: a013bda241304fef8d0013d2f5512c96-20210927
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1, 1
X-UUID: a013bda241304fef8d0013d2f5512c96-20210927
X-User: lizhenneng@kylinos.cn
Received: from [172.20.108.41] [(116.128.244.169)] by nksmu.kylinos.cn
        (envelope-from <lizhenneng@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
        with ESMTP id 1100316321; Mon, 27 Sep 2021 11:43:22 +0800
Subject: Re: [PATCH] PCI/sysfs: add write attribute for boot_vga
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210926202027.GA588220@bhelgaas>
From:   =?UTF-8?B?5p2O55yf6IO9?= <lizhenneng@kylinos.cn>
Message-ID: <70a472b8-7a3e-1792-efe4-125584231824@kylinos.cn>
Date:   Mon, 27 Sep 2021 11:45:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210926202027.GA588220@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


在 2021/9/27 上午4:20, Bjorn Helgaas 写道:
> On Sun, Sep 26, 2021 at 03:15:39PM +0800, Zhenneng Li wrote:
>> Add writing attribute for boot_vga sys node,
>> so we can config default video display
>> output dynamically when there are two video
>> cards on a machine.
>>
>> Xorg server will determine running on which
>> video card based on boot_vga node's value.
> When you repost this, please take a look at the git commit log history
> and make yours similar.  Specifically, the subject should start with a
> capital letter, and the body should be rewrapped to fill 75
> characters.
>
> Please contrast this with the existing VGA arbiter.  See
> Documentation/gpu/vgaarbiter.rst.  It sounds like this may overlap
> with the VGA arbiter functionality, so this should explain why we need
> both and how they interact.

"Some "legacy" VGA devices implemented on PCI typically have the same 
hard-decoded addresses as they did on ISA. When multiple PCI devices are 
accessed at same time they need some kind of coordination. ", this is 
the explain of config VGA_ARB, that is to say, some legacy vga devices 
need use the same pci bus address, if user app(such as xorg) want access 
card A, but card A and card B have same bus address,  then VGA 
agaarbiter will determine will card to be accessed.

And xorg will read boot_vga to determine which graphics card is the 
primary graphics output device.

That is the difference about boot_vga and vgaarbiter.



>
>> Signed-off-by: Zhenneng Li <lizhenneng@kylinos.cn>
>> ---
>>   drivers/pci/pci-sysfs.c | 24 +++++++++++++++++++++++-
>>   1 file changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index 7bbf2673c7f2..a6ba19ce7adb 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -664,7 +664,29 @@ static ssize_t boot_vga_show(struct device *dev, struct device_attribute *attr,
>>   			  !!(pdev->resource[PCI_ROM_RESOURCE].flags &
>>   			     IORESOURCE_ROM_SHADOW));
>>   }
>> -static DEVICE_ATTR_RO(boot_vga);
>> +
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
>> +
>> +	if (!capable(CAP_SYS_ADMIN))
>> +		return -EPERM;
>> +
>> +	if (pdev != vga_dev)
>> +		vga_set_default_device(pdev);
>> +
>> +	return count;
>> +}
>> +static DEVICE_ATTR_RW(boot_vga);
>>   
>>   static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
>>   			       struct bin_attribute *bin_attr, char *buf,
>> -- 
>> 2.25.1
>>
>>
>> No virus found
>> 		Checked by Hillstone Network AntiVirus
