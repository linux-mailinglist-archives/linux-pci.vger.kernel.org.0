Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCD735563D
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 16:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244364AbhDFOPi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 10:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244344AbhDFOPh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 10:15:37 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F387C061756
        for <linux-pci@vger.kernel.org>; Tue,  6 Apr 2021 07:15:28 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h10so16731718edt.13
        for <linux-pci@vger.kernel.org>; Tue, 06 Apr 2021 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=syu1Q2zFBZO/WT38eA0jnz3HW13lws9Lu6W/8qRxwyg=;
        b=Ie8+tmEC0KGhp7QyI++MEIAnf0w0Dep7DeGdmO9bVQxN31Z786gHzev2fLM50HfmVW
         u11oifmFDH7CqLbGl2TvqeH4N8RFX5GyqCrTtS9DI/9kMVQOtUM4a1LExFXSLksw63fx
         qRe7ed+WTGVSsFGyqHY39yPGPfZw81kk0MQB/3sw/NgCtbH4/lg/94ULlVDi9NjwmjKd
         PBnBqWmcQAnQvI1UiLQBxZLr1BhdzkU65dHzwUg6JcUY6VUadKaUUU2jqEWRAZkM4puD
         +0z6aj//ZtDCN1JA056uU8NmOoAPb07bh+C3th2QFlxn9VjJYPB5Q6xVUKA0zJvCyqfg
         PBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=syu1Q2zFBZO/WT38eA0jnz3HW13lws9Lu6W/8qRxwyg=;
        b=kumPSbaVEa3t2c1q5jAO3VfNuQPAykt8TQJtJ6T+x9vhFD1xylDRhIZmPhrhQT8l6b
         N9l0IQBmFiMQF45X0dpQqzdlxrsWfwHmWYiXsK+qmC1FAgjSUGVhkeRI69TD3GzCOBbn
         IYZ6dhxi+UDEReIFQAmAlhJSDm64bywGArEVKxLrnkhli5kLJtRW4XU80JSm1iOLPmVb
         +PlCGWV9GsfTtSss2JEMtyCjnrZohp6Srx1fCQb8XpQtrocgzzVe5ZFQzXHaxq4MIEc2
         2705igY+VjnHxPJ8spGhyjs8kPwjp935K46cHcw7cykhlxAzabx2ORKybzHpy2V4v9k5
         l0ww==
X-Gm-Message-State: AOAM531KPxx2S0f8+elIETNfKM2PNB8OQJ8b8nhRm6eW9UzLMYnvxiIC
        +VBZZP9fSbG93ziDdWeGWEsFCwpuhP7GtOwo
X-Google-Smtp-Source: ABdhPJxovm1H11qGF71/xH3f4H7lDU1sriHrZDaqcs13U3LOSGqJyL2sBtL+YV2dwTClU5HyjdV2Vg==
X-Received: by 2002:a50:cdd1:: with SMTP id h17mr38044939edj.178.1617718526787;
        Tue, 06 Apr 2021 07:15:26 -0700 (PDT)
Received: from [10.202.0.7] ([31.31.140.89])
        by smtp.gmail.com with ESMTPSA id a19sm4401644ejy.42.2021.04.06.07.15.25
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 07:15:26 -0700 (PDT)
To:     linux-pci@vger.kernel.org
From:   Koen Vandeputte <koen.vandeputte@citymesh.com>
Subject: imx6: Question regarding warning in pci addition
Message-ID: <eef67246-43ac-f081-bca1-4327a2a6d4f5@citymesh.com>
Date:   Tue, 6 Apr 2021 16:15:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

Pinging on this list as it might trigger someone :-)


I just started testing kernel 5.10.27 in-depth (OpenWRT master) on imx6 
hw (Gateworks GW-52xx boards).

Following warnings are now present which were not using kernel 5.4.
They seem to get printed on every device being added to the PCIe 
topology during enumeration:    (See full log)


[    1.904789] sysfs: cannot create duplicate filename 
'/devices/platform/soc/1ffc000.pcie/pci0000:00/0000:00:00.0/config'
[    1.945983] CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted 5.10.27 #0
[    1.952254] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    1.958811] Workqueue: events_unbound async_run_entry_fn
[    1.964157] [<8010d5e0>] (unwind_backtrace) from [<801099f8>] 
(show_stack+0x10/0x14)
[    1.971917] [<801099f8>] (show_stack) from [<804a67cc>] 
(dump_stack+0x94/0xa8)
[    1.979154] [<804a67cc>] (dump_stack) from [<802fd440>] 
(sysfs_warn_dup+0x54/0x60)
[    1.986734] [<802fd440>] (sysfs_warn_dup) from [<802fd098>] 
(sysfs_add_file_mode_ns+0x15c/0x1a0)
[    1.995529] [<802fd098>] (sysfs_add_file_mode_ns) from [<802fd314>] 
(sysfs_create_bin_file+0x7c/0x84)
[    2.004768] [<802fd314>] (sysfs_create_bin_file) from [<804e55d4>] 
(pci_create_sysfs_dev_files+0x44/0x298)
[    2.014441] [<804e55d4>] (pci_create_sysfs_dev_files) from 
[<804d7248>] (pci_bus_add_device+0x20/0x84)
[    2.023757] [<804d7248>] (pci_bus_add_device) from [<804d72d8>] 
(pci_bus_add_devices+0x2c/0x70)
[    2.032465] [<804d72d8>] (pci_bus_add_devices) from [<804dabcc>] 
(pci_host_probe+0x40/0x94)
[    2.040833] [<804dabcc>] (pci_host_probe) from [<804f822c>] 
(dw_pcie_host_init+0x1c0/0x3fc)
[    2.049196] [<804f822c>] (dw_pcie_host_init) from [<804f88ec>] 
(imx6_pcie_probe+0x358/0x63c)
[    2.057648] [<804f88ec>] (imx6_pcie_probe) from [<8054710c>] 
(platform_drv_probe+0x48/0x98)
[    2.066009] [<8054710c>] (platform_drv_probe) from [<80545368>] 
(really_probe+0xfc/0x4dc)
[    2.074195] [<80545368>] (really_probe) from [<80545a28>] 
(driver_probe_device+0x5c/0xb4)
[    2.082378] [<80545a28>] (driver_probe_device) from [<80545b28>] 
(__driver_attach_async_helper+0xa8/0xac)
[    2.091963] [<80545b28>] (__driver_attach_async_helper) from 
[<8014bf48>] (async_run_entry_fn+0x44/0x108)
[    2.101546] [<8014bf48>] (async_run_entry_fn) from [<80141bbc>] 
(process_one_work+0x1d8/0x43c)
[    2.110168] [<80141bbc>] (process_one_work) from [<80141e84>] 
(worker_thread+0x64/0x5b0)
[    2.118268] [<80141e84>] (worker_thread) from [<80147708>] 
(kthread+0x148/0x14c)
[    2.125672] [<80147708>] (kthread) from [<80100148>] 
(ret_from_fork+0x14/0x2c)
[    2.132896] Exception stack(0x80c75fb0 to 0x80c75ff8)
[    2.137953] 5fa0:                                     00000000 
00000000 00000000 00000000
[    2.146136] 5fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[    2.154316] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000


Any idea what changed?


Full logs: https://pastebin.com/raw/D0NHAnbH

Thanks,

Koen

