Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF297E8813
	for <lists+linux-pci@lfdr.de>; Sat, 11 Nov 2023 03:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjKKCHs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Nov 2023 21:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKKCHr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2023 21:07:47 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5F83C0E;
        Fri, 10 Nov 2023 18:07:43 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6bb4abb8100so2380803b3a.2;
        Fri, 10 Nov 2023 18:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699668462; x=1700273262; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=us4PH3hYSKV8M14QXIBOyvA+4JqUtwc0XH3JtG4nmDY=;
        b=H2SACKIh/aE8QyI9hmjRYgDpTcn2jhbedsoYWNKoryJo5gw9y7qRdGpdtzhyqtnT7Z
         IyaivMsC/o5jYmUFamrLMj9RntR/nwl0g8dafIeGJTDW1dg07ALue77KOXLepq+enGS/
         46tLvitQ3NET2vdPyIV9R5noUpnuWGcuaKZFdOLL/A6ZVNgLawVy4M7OTyxSymo48bNO
         HambX9i5EFqNPBzmShFNds6UgrMK1QOYi+0O1wvZdNrMiLyN3/KUQzJbTENNA1dIR3Pk
         sLNfBM82Q/cDLg4xKsWzYCoMR8jLVOchb6lHHLHwP7it+gpT9+Y2FpIlCv+CcExXeIRc
         MOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699668462; x=1700273262;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=us4PH3hYSKV8M14QXIBOyvA+4JqUtwc0XH3JtG4nmDY=;
        b=P3pAzLvZOpeLxQh1oPV5tCz10xk/ZcK6+p1XPqbHMSICLemiCMoao0Fn93PwvSljmH
         tjFsMNIqa+73RiZuFPzZote0LUUHJzU/pYFtXtZS8/kmgo83fIPYQjn3/RPy3fcM03jE
         di23VitBv5Eu+qCedPXRgS5DssTX9yqAtCntMxo+PTXY9YA961PaNu50GmizlzC1X2w3
         18XvVDFf61EYsOCH7JI7yNpqe1tacImlH4kwsLNq4KWyWOdwTq8eoMHrJ+5AnthPbMWH
         Gik916q8RqHs9OnMEeupN7x7U8sC/pig4zFqCZDF+RZc6NmAN7jElCXn9bpnQ85mjdht
         1vWQ==
X-Gm-Message-State: AOJu0Yw/tHvbPAotgeLg+64ZdE3AKl9yrM+SdGSmFxycEjAa73UqYBjY
        /AIBS52Bc/9wmLOlW2no107JkTRlazE60A==
X-Google-Smtp-Source: AGHT+IHNBBW3BK8jyaoUi7xXcxcZdBpSdb0qc7l3zTckarw97gd+X2tbBj1Oc1EwReuZ3Rk530zP9g==
X-Received: by 2002:a05:6a20:ce83:b0:131:b3fa:eaaa with SMTP id if3-20020a056a20ce8300b00131b3faeaaamr588855pzb.61.1699668462452;
        Fri, 10 Nov 2023 18:07:42 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b001a9b29b6759sm308895pll.183.2023.11.10.18.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 18:07:41 -0800 (PST)
Message-ID: <60585667-70ca-4ace-8d8f-dbdd8d4428a6@gmail.com>
Date:   Sat, 11 Nov 2023 09:07:35 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jian-Hong Pan <jhp@endlessos.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: The PCIe AER error flood between PCIe bridge and Realtek's
 RTL8723BE makes system hang
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> We have an ASUS X555UQ laptop equipped with Intel i7-6500U CPU and Realtek RTL8723BE PCIe Wireless adapter.
> 
> We tested it with kernel 6.6.  System keeps showing AER error message flood, even hangs up, until rtl8723be's ASPM is disabled.
> 
> kernel: pcieport 0000:00:1c.5: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
> kernel: pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00000001/00002000
> kernel: pcieport 0000:00:1c.5:    [ 0] RxErr                  (First)
> kernel: pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
> kernel: pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> kernel: pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
> kernel: pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> kernel: pcieport 0000:00:1c.5: AER: Multiple Corrected error received: 0000:00:1c.5
> kernel: pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> 
> Here is the PCI tree:
> $ lspci -tv
> -[0000:00]-+-00.0  Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Host Bridge/DRAM Registers
>            +-02.0  Intel Corporation Skylake GT2 [HD Graphics 520]
>            +-04.0  Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem
>            +-14.0  Intel Corporation Sunrise Point-LP USB 3.0 xHCI Controller
>            +-14.2  Intel Corporation Sunrise Point-LP Thermal subsystem
>            +-15.0  Intel Corporation Sunrise Point-LP Serial IO I2C Controller #0
>            +-15.1  Intel Corporation Sunrise Point-LP Serial IO I2C Controller #1
>            +-16.0  Intel Corporation Sunrise Point-LP CSME HECI #1
>            +-17.0  Intel Corporation Sunrise Point-LP SATA Controller [AHCI mode]
>            +-1c.0-[01]----00.0  NVIDIA Corporation GM108M [GeForce 940MX]
>            +-1c.4-[02]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
>            +-1c.5-[03]----00.0  Realtek Semiconductor Co., Ltd. RTL8723BE PCIe Wireless Network Adapter
>            +-1f.0  Intel Corporation Sunrise Point-LP LPC Controller
>            +-1f.2  Intel Corporation Sunrise Point-LP PMC
>            +-1f.3  Intel Corporation Sunrise Point-LP HD Audio
>            \-1f.4  Intel Corporation Sunrise Point-LP SMBus

And then the reporter found that it was ASPM bug:

> Notice a long time ago discussion mail: Dmesg filled with "AER: Corrected error received" [1]
> 
> So, I force write 1 to clear Receiver Error Status bit of Correctable Error Status Register, like
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 9c8fd69ae5ad..39faedd2ec8e 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1141,8 +1160,9 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>                         e_info.multi_error_valid = 0;
>                 aer_print_port_info(pdev, &e_info);
>  
> -               if (find_source_device(pdev, &e_info))
> -                       aer_process_err_devices(&e_info);
> +               //if (find_source_device(pdev, &e_info))
> +               //      aer_process_err_devices(&e_info);
> +               pci_write_config_dword(pdev, pdev->aer_cap + PCI_ERR_COR_STATUS, 0x1);
>         }
>  
>         if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
> 
> Then, system should clear the error right away.  However, system still get the AER flood ...
> 
> Seems that we still have to disable rtl8723be's ASPM.

See Bugzilla for the full thread and attached full kernel logs.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218127

-- 
An old man doll... just what I always wanted! - Clara
