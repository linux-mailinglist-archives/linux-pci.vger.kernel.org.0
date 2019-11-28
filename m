Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD5F810CA49
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2019 15:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfK1OVi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Nov 2019 09:21:38 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43933 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfK1OVi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Nov 2019 09:21:38 -0500
Received: by mail-ot1-f67.google.com with SMTP id l14so22305477oti.10;
        Thu, 28 Nov 2019 06:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pAOuUXPMeoRavXucH0FHeoL8ht+w96IWOMyp3rFxFc8=;
        b=KBsr5LptVS2b+zcFfq8COkxUXZcEB1jGnIvoAk8NwagRT1ELTfEAXLdstWJYDI6aaB
         5ikq8r7yeXpZJUsmuCTsxVZBwkn5e6kdd3PYtYjd8hk5CMTpB+upcSPMdHn7RqXcRyw9
         RinpBwEXjmy04jpU+6TDm7qfEQIz8RRtOLvhFl/p/3aDgIWn9sG3G5vb3HKjgi+KSAAt
         ZaKa8rtzMcIV6WLvWbALGQEksQ5F0K8jfcop3LjNWaYqAbqrFM454dVpuZ9AJMzROeHP
         h6bHdcHeRJOvB9+/tVwZlbfYUfLwkG8drmkGEA3Rtv+y2WYKJmiBXol2B/oaLD4Jmf2p
         cFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pAOuUXPMeoRavXucH0FHeoL8ht+w96IWOMyp3rFxFc8=;
        b=l/jhGirmfGJk+Ll0MmeGHYuAzTqXFt0aS5L8n3mgzyL4BrdTUnVJBzSC+ghQlLwVAA
         gs2RKFKbqHzqFDqa/GRThcdds3QRsXkCCvMaDDwfFTcTDuPkonkkHDDcHlLC6CFiu8lW
         FtsfXikCRfo/yF0SW5vNaJA4JYES0BC+4C4wIGk9oziyOsRzseBMUhdYtuXr7YSWc8Bk
         imeiNhoIu9BJO2zfRWcWXE1IHf2Kf9KXxrjKrBdts3euv3zRhKPIRgFRqSgNbUsGR9H1
         yM5hl6tO5lOiqX4kDxMi6Zb0s5vKzFg6xjWvK3usjlNoKq8lDNhOlKict5grFjVW5qNA
         LDcg==
X-Gm-Message-State: APjAAAVBkktTK4wRzI0wWqeD1uZgIpLrqdxwwTWvLKsvUqS9dZN4PbzB
        pVCwBRM3/f8bLd7ztr2s4sCCjcay
X-Google-Smtp-Source: APXvYqyg/dOuWAh3aONJFSxiOoY0asq6842kRVYbO07guEulmAV3bFhidrH7ncZ6zHHYAH92ywgZtA==
X-Received: by 2002:a9d:744a:: with SMTP id p10mr7122237otk.235.1574950896159;
        Thu, 28 Nov 2019 06:21:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l32sm6126339otl.74.2019.11.28.06.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 06:21:34 -0800 (PST)
Subject: Re: [PATCH 6/6] (v3) drivers: hwmon: i5k_amb: simplify probing /
 device identification
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     tim@buttersideup.com, james.morse@arm.com, rrichter@marvell.com,
        jdelvare@suse.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-crypto@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pci@vger.kernel.org
References: <20191128125406.10417-1-info@metux.net>
 <20191128125406.10417-6-info@metux.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <bee7ba11-6b4a-1cc7-ee8c-ddf17cb8daca@roeck-us.net>
Date:   Thu, 28 Nov 2019 06:21:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191128125406.10417-6-info@metux.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/28/19 4:54 AM, Enrico Weigelt, metux IT consult wrote:
> Simpilify the probing by putting all chip-specific data directly
> into the pci match table, removing the redundant chipset_ids table.
> 
> Changes v3:
>      * use pci_get_device_by_id() introduces by a previous patch
>        of this queue
> 
> Changes v2:
>      * use PCI_DEVICE_DATA() macro in the pci match table
>      * directly pass the pci device id to i5k_channel_probe(),
>        instead of computing it internally by extra offset parameter
> 
> Submitted: 2019-06-06
> Signed-off-by: Enrico Weigelt <info@metux.net>

I don't immediately see how this is better. I am not even sure if it is correct.

Guenter

> ---
>   drivers/hwmon/i5k_amb.c | 38 +++++++++++++++-----------------------
>   1 file changed, 15 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
> index b09c39abd3a8..cb85607d104f 100644
> --- a/drivers/hwmon/i5k_amb.c
> +++ b/drivers/hwmon/i5k_amb.c
> @@ -414,16 +414,14 @@ static int i5k_amb_add(void)
>   }
>   
>   static int i5k_find_amb_registers(struct i5k_amb_data *data,
> -					    unsigned long devid)
> +				  const struct pci_device_id *devid)
>   {
>   	struct pci_dev *pcidev;
>   	u32 val32;
>   	int res = -ENODEV;
>   
>   	/* Find AMB register memory space */
> -	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
> -				devid,
> -				NULL);
> +	pcidev = pci_get_device_by_id(devid);
>   	if (!pcidev)
>   		return -ENODEV;
>   
> @@ -447,14 +445,15 @@ static int i5k_find_amb_registers(struct i5k_amb_data *data,
>   	return res;
>   }
>   
> -static int i5k_channel_probe(u16 *amb_present, unsigned long dev_id)
> +static int i5k_channel_probe(u16 *amb_present, unsigned int vendor,
> +			     unsigned int device)
>   {
>   	struct pci_dev *pcidev;
>   	u16 val16;
>   	int res = -ENODEV;
>   
>   	/* Copy the DIMM presence map for these two channels */
> -	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL, dev_id, NULL);
> +	pcidev = pci_get_device(vendor, device, NULL);
>   	if (!pcidev)
>   		return -ENODEV;
>   
> @@ -473,23 +472,12 @@ static int i5k_channel_probe(u16 *amb_present, unsigned long dev_id)
>   	return res;
>   }
>   
> -static struct {
> -	unsigned long err;
> -	unsigned long fbd0;
> -} chipset_ids[]  = {
> -	{ PCI_DEVICE_ID_INTEL_5000_ERR, PCI_DEVICE_ID_INTEL_5000_FBD0 },
> -	{ PCI_DEVICE_ID_INTEL_5400_ERR, PCI_DEVICE_ID_INTEL_5400_FBD0 },
> -	{ 0, 0 }
> -};
> -
> -#ifdef MODULE
>   static const struct pci_device_id i5k_amb_ids[] = {
> -	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5000_ERR) },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5400_ERR) },
> +	{ PCI_DEVICE_DATA(INTEL, 5000_ERR, PCI_DEVICE_ID_INTEL_5000_FBD0) },
> +	{ PCI_DEVICE_DATA(INTEL, 5400_ERR, PCI_DEVICE_ID_INTEL_5400_FBD0) },
>   	{ 0, }
>   };
>   MODULE_DEVICE_TABLE(pci, i5k_amb_ids);
> -#endif
>   
>   static int i5k_amb_probe(struct platform_device *pdev)
>   {
> @@ -504,22 +492,26 @@ static int i5k_amb_probe(struct platform_device *pdev)
>   	/* Figure out where the AMB registers live */
>   	i = 0;
>   	do {
> -		res = i5k_find_amb_registers(data, chipset_ids[i].err);
> +		res = i5k_find_amb_registers(data, &i5k_amb_ids[i]);
>   		if (res == 0)
>   			break;
>   		i++;
> -	} while (chipset_ids[i].err);
> +	} while (i5k_amb_ids[i].device);
>   
>   	if (res)
>   		goto err;
>   
>   	/* Copy the DIMM presence map for the first two channels */
> -	res = i5k_channel_probe(&data->amb_present[0], chipset_ids[i].fbd0);
> +	res = i5k_channel_probe(&data->amb_present[0],
> +				i5k_amb_ids[i].vendor,
> +				i5k_amb_ids[i].driver_data);
>   	if (res)
>   		goto err;
>   
>   	/* Copy the DIMM presence map for the optional second two channels */
> -	i5k_channel_probe(&data->amb_present[2], chipset_ids[i].fbd0 + 1);
> +	i5k_channel_probe(&data->amb_present[2],
> +			  i5k_amb_ids[i].vendor,
> +			  i5k_amb_ids[i].driver_data+1);
>   
>   	/* Set up resource regions */
>   	reso = request_mem_region(data->amb_base, data->amb_len, DRVNAME);
> 

