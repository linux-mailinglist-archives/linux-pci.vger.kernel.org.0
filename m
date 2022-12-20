Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A1E651AF3
	for <lists+linux-pci@lfdr.de>; Tue, 20 Dec 2022 07:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbiLTGvY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Dec 2022 01:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiLTGvX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Dec 2022 01:51:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA7613F95
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 22:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671519036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zwDr1m1CSjW3QmkbeKM/ZutVDebLKvNg+n0oKeti2Eg=;
        b=gcvjyVtHZTPaAQ+kaVJdqrDE+r+8BzDcg7Oe+L8zKXvszoB7RdcHFAu9MzyqoffEbpSe4O
        X6ZFlWl8eA/erd1UC+lrWe2EgOxULeqA4wqzUOoVoXtZ8wGsaTvxnVlZo25XqsPZ+W87kH
        WO0DjZ8CzUZmgqbcRE/F1vVIr0HPXcA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-647-CJjijxloP92tzliu8Q-6kA-1; Tue, 20 Dec 2022 01:50:35 -0500
X-MC-Unique: CJjijxloP92tzliu8Q-6kA-1
Received: by mail-pg1-f200.google.com with SMTP id r22-20020a63ce56000000b00478f1cfb0fbso6765511pgi.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 22:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zwDr1m1CSjW3QmkbeKM/ZutVDebLKvNg+n0oKeti2Eg=;
        b=YCeH14VrvJoqiJEfoOhBJBzrs1CIEE+GWgAwekv6tIxm3HekYbBb20F3n+6clhznQ8
         GYuvsgRXS9oLyvfy9c4x3rV/sECyo24x48JAF3AYSSfLCxYpP+EtiqG0RwOkIe8mTULb
         RC7QrMeExbag2+XJfZ2O1XFVEocg3WtA5Dg+P2Oo8JlAiO21HJxKkZSd29KjcO2VAHEX
         dFR1FKpwjM+bMnvoFGrSDYUzwufwxCoeJA5TW8rYjMOc2CCId+6d1z/toWDARTP/tSW8
         YdaIPe8iaTHAwnnz+RHbTxq4zT0GsdxeIqTBbbY1n/yv3OGB7QJLzvP2RZSYJgpYnr+R
         6dPA==
X-Gm-Message-State: ANoB5pmxsr+8OckluJSi1oMfMNmGpRMp3bf69Omt+9OVCppDZLsWqqNp
        UVFzJhVaKym7BiIxceWIbcXR7yOkdH8A9kDJHTi3E5NyccAVsBOGspuPQXCSpvzVJC2bbmMHSgc
        YEkuvMh5S+O57+lv+5GTh
X-Received: by 2002:a05:6a20:1324:b0:ad:f2bf:bc50 with SMTP id g36-20020a056a20132400b000adf2bfbc50mr24198114pzh.13.1671519034423;
        Mon, 19 Dec 2022 22:50:34 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4lksCrEkh9cfPPZGSqkkcNl1O26INCsTnVEy3yl+IJ3fMl0eg6JDIrUDrpoRUzQTGDttYOcQ==
X-Received: by 2002:a05:6a20:1324:b0:ad:f2bf:bc50 with SMTP id g36-20020a056a20132400b000adf2bfbc50mr24198103pzh.13.1671519034114;
        Mon, 19 Dec 2022 22:50:34 -0800 (PST)
Received: from [10.72.12.177] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b4-20020a62cf04000000b005764c8f8f15sm7821518pfg.73.2022.12.19.22.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 22:50:33 -0800 (PST)
Message-ID: <96d85666-106b-a43e-6115-b9959b4e3e66@redhat.com>
Date:   Tue, 20 Dec 2022 14:50:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com>
Content-Language: en-US
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221219083511.73205-4-alvaro.karsz@solid-run.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


在 2022/12/19 16:35, Alvaro Karsz 写道:
> This commit includes:
>   1) The driver to manage the controlplane over vDPA bus.
>   2) A HW monitor device to read health values from the DPU.
>
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> --
> v2:
> 	- Auto detect the BAR used for communication.
> 	- When waiting for the DPU to write a config, wait for 5secs
> 	  before giving up on the device.
> 	- Return EOPNOTSUPP error code in vDPA set_vq_state callback if
> 	  the vq state is not the same as the initial one.
> 	- Implement a vDPA reset callback.
> 	- Wait for an ACK when sending a message to the DPU.
> 	- Add endianness comments on 64bit read/write functions.
> 	- Remove the get_iova_range and free vDPA callbacks.
> 	- Usage of managed device functions to ioremap a region.
> 	- Call pci_set_drvdata and pci_set_master before
> 	  vdpa_register_device.
> 	- Create DMA isolation between the vDPA devices by using the
> 	  chip SR-IOV feature.
> 	  Every vDPA device gets a PCIe VF with its own DMA device.
>
> v3:
> 	- Validate vDPA config length while receiving the DPU's config,
> 	  not while trying to write the vDPA config to the DPU.
> 	- Request IRQs when vDPA status is set to
> 	  VIRTIO_CONFIG_S_DRIVER_OK.
> 	- Remove snet_reset_dev() from the PCI remove function for a VF.
> v4:
> 	- Get SolidRun vendor ID from pci_ids
> v5:
> 	- Remove "select HWMON" from Kconfig.
> 	  Usage of "depends on HWMON || HWMON=n" instead and usage of
> 	  IS_ENABLED(CONFIG_HWMON) when calling to snet hwmon functions.
> 	  snet_hwmon.c is compiled only if CONFIG_HWMON is defined.
> 	- Remove the  #include <linux/hwmon-sysfs.h> from snet_hwmon.c.
> 	- Remove the unnecessary (long) casting from snet_hwmon_read_reg.
> 	- Remove the "_hwmon" ending from the hwmon name.
> 	- Usage of IS_ERR macro to check if devm_hwmon_device_register_with_info
> 	  failed.
> 	- Replace schedule() with usleep_range() in the "hot loop" in
> 	  psnet_detect_bar.
> 	- Remove the logging of memory allocation failures.
> 	- Add parenthesis to arguments in SNET_* macros.
> 	- Prefer sizeof(*variable) instead of sizeof(struct x) when allocating
> 	  memory.
> v6:
> 	- SNET_WRN -> SNET_WARN.
> ---
>   MAINTAINERS                        |    4 +
>   drivers/vdpa/Kconfig               |   10 +
>   drivers/vdpa/Makefile              |    1 +
>   drivers/vdpa/solidrun/Makefile     |    6 +
>   drivers/vdpa/solidrun/snet_hwmon.c |  188 +++++
>   drivers/vdpa/solidrun/snet_main.c  | 1111 ++++++++++++++++++++++++++++
>   drivers/vdpa/solidrun/snet_vdpa.h  |  196 +++++
>   7 files changed, 1516 insertions(+)
>   create mode 100644 drivers/vdpa/solidrun/Makefile
>   create mode 100644 drivers/vdpa/solidrun/snet_hwmon.c
>   create mode 100644 drivers/vdpa/solidrun/snet_main.c
>   create mode 100644 drivers/vdpa/solidrun/snet_vdpa.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a608f19da3a..7f4d9dcb760 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21955,6 +21955,10 @@ IFCVF VIRTIO DATA PATH ACCELERATOR
>   R:	Zhu Lingshan <lingshan.zhu@intel.com>
>   F:	drivers/vdpa/ifcvf/
>   
> +SNET DPU VIRTIO DATA PATH ACCELERATOR
> +R:	Alvaro Karsz <alvaro.karsz@solid-run.com>
> +F:	drivers/vdpa/solidrun/
> +
>   VIRTIO BALLOON
>   M:	"Michael S. Tsirkin" <mst@redhat.com>
>   M:	David Hildenbrand <david@redhat.com>
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 50f45d03761..79625c7cc46 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -86,4 +86,14 @@ config ALIBABA_ENI_VDPA
>   	  VDPA driver for Alibaba ENI (Elastic Network Interface) which is built upon
>   	  virtio 0.9.5 specification.
>   
> + config SNET_VDPA
> +	tristate "SolidRun's vDPA driver for SolidNET"
> +	depends on PCI_MSI && PCI_IOV && (HWMON || HWMON=n)


So I think we actually don't need to depend on HWMON here?

hwmon.c is only complied when HWMON is enabled and we use IS_ENABLED to 
exclude the hwmon specific does.

Other looks good to me.

Thanks

