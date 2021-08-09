Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFDF3E4C87
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 20:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbhHIS6M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 14:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbhHIS6L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Aug 2021 14:58:11 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA850C0613D3
        for <linux-pci@vger.kernel.org>; Mon,  9 Aug 2021 11:57:50 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k5-20020a05600c1c85b02902e699a4d20cso717519wms.2
        for <linux-pci@vger.kernel.org>; Mon, 09 Aug 2021 11:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q2V3VDp2VWzp6PGKLwjtja5w/UBXzz0jjo0xw2vO0Q0=;
        b=okn6t7AquJdYDdrnv55lYB0Aqr7/KcIqPHljeihVHltyF0DhKsjuWmxCcCp0kLsbeQ
         6dFjfRomYcKJms8ZoSponiV9qd9hJlJ+jK5Mpc1oYZCDb8d76tK1ivfpZAG+TXFQPuTi
         /kzRo//4NCr+MmwIbLunEPZk3MpqzLD469UWcznVaKQNiEIh/Zkgm8CwNmEkZDVSJ1h7
         GffHFDGTQVHzYpNxWOcGWaRix+M81ZbhwSuCL/14Y9S6iR/0rNHIifEv2PWV4CO/GQ7j
         2tx4ZKHaE4YhCvVR10huQOAI38FpW46ym06vkTxPwUSsdHzeO+3YsZ6nw7bP6vyJ/9r9
         hl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q2V3VDp2VWzp6PGKLwjtja5w/UBXzz0jjo0xw2vO0Q0=;
        b=WpmRltz8+A6ZQx42aP0etGLrsxj1b4CcBEAbw10Jj4wI+HfHJInMNqrmZgbzUwneAN
         7yPGoPngIf5aEIEm+wBncI+wTcE1qy8y7Mry0CleZo/cjVrogG2OmhADK+4nlfrtTpb5
         w7aTwKuIZzEKefo7orTRLjWyGqkKWlZj9rPY/ShQ1/CHnh3XDn+oEiPbIBc1YauNiCeg
         MtCwaG0kd9dj6s4QtkQyLKbNUZJuwmOI7gPtiQwdEz3R0ljCLP5PgXvHiaVNHGs+TftE
         XiHJhLQb0AdAQ4W0F/qn9y/FUonf2Bj6cdNSwE8WORe4P85B1plynqi5aaiC/FkDwZ+e
         NB9A==
X-Gm-Message-State: AOAM533oixTpCztrjBBpzvwCnNlfWj2/yLqxMVaIxxW8gnsNo/V3NgHt
        DpzEaDzfshybhcR+lLwtVeU=
X-Google-Smtp-Source: ABdhPJw6P4xBAo+dl22Z02wTOJsCKm+mW2kDDmGr+djXJQJwzOPcShP3Yxu/0QIogWfbooHQUXHu1w==
X-Received: by 2002:a05:600c:a44:: with SMTP id c4mr557269wmq.83.1628535469420;
        Mon, 09 Aug 2021 11:57:49 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f10:c200:50b3:512f:3b7:fe04? (p200300ea8f10c20050b3512f03b7fe04.dip0.t-ipconnect.de. [2003:ea:8f10:c200:50b3:512f:3b7:fe04])
        by smtp.googlemail.com with ESMTPSA id j36sm314954wms.16.2021.08.09.11.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 11:57:48 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] PCI/VPD: Reject resource tags with invalid size
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
References: <20210809184639.GA2172096@bjorn-Precision-5520>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <4182b611-a257-5fa8-258a-694fe71f4828@gmail.com>
Date:   Mon, 9 Aug 2021 20:57:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210809184639.GA2172096@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09.08.2021 20:46, Bjorn Helgaas wrote:
> On Mon, Aug 09, 2021 at 02:15:20PM -0400, Qian Cai wrote:
>>
>>
>> On 7/29/2021 2:42 PM, Bjorn Helgaas wrote:
>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> VPD is limited in size by the 15-bit VPD Address field in the VPD
>>> Capability.  Each resource tag includes a length that determines the
>>> overall size of the resource.  Reject any resources that would extend past
>>> the maximum VPD size.
>>>
>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>> + mlx5_core maintainers
>>
>> Hi there, running the latest linux-next with this commit, our system started to
>> get noisy. Could those indicate some device firmware bugs?
>>
>> [  164.937191] mlx5_core 0000:01:00.0: invalid VPD tag 0x78 at offset 113
>> [  165.933527] mlx5_core 0000:01:00.1: invalid VPD tag 0x78 at offset 113
> 
> Thanks a lot for reporting this!
> 
> I guess VPD contains a tag of 0x78, which is a small resource item
> with name 0xf (an End Tag) and size 0.  Per PNPISA, the End Tag should
> have a length 1, with the single byte being a checksum of the resource
> data.  But the PCI spec doesn't mention that checksum byte, so I think
> we should accept the size 0 without any message.
> 

PCI 2.2 spec includes a VPD example in section I.3.2.
There the end tag is listed as 0x78.

> I think the following patch on top of linux-next should do this:
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 5e2e638093f1..d7f705ba6664 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -69,12 +69,11 @@ EXPORT_SYMBOL(pci_write_vpd);
>   */
>  static size_t pci_vpd_size(struct pci_dev *dev)
>  {
> -	size_t off = 0;
> -	unsigned char header[1+2];	/* 1 byte tag, 2 bytes length */
> +	size_t off = 0, size;
> +	unsigned char tag, header[1+2];	/* 1 byte tag, 2 bytes length */
>  
>  	while (pci_read_vpd(dev, off, 1, header) == 1) {
> -		unsigned char tag;
> -		size_t size;
> +		size = 0;
>  
>  		if (off == 0 && (header[0] == 0x00 || header[0] == 0xff))
>  			goto error;
> @@ -95,7 +94,7 @@ static size_t pci_vpd_size(struct pci_dev *dev)
>  			/* Short Resource Data Type Tag */
>  			tag = pci_vpd_srdt_tag(header);
>  			size = pci_vpd_srdt_size(header);
> -			if (size == 0 || off + size > PCI_VPD_MAX_SIZE)
> +			if (off + size > PCI_VPD_MAX_SIZE)
>  				goto error;
>  
>  			off += PCI_VPD_SRDT_TAG_SIZE + size;
> @@ -106,8 +105,8 @@ static size_t pci_vpd_size(struct pci_dev *dev)
>  	return off;
>  
>  error:
> -	pci_info(dev, "invalid VPD tag %#04x at offset %zu%s\n",
> -		 header[0], off, off == 0 ?
> +	pci_info(dev, "invalid VPD tag %#04x (size %zu) at offset %zu%s\n",
> +		 header[0], size, off, off == 0 ?
>  		 "; assume missing optional EEPROM" : "");
>  	return off;
>  }
> 

