Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68147373F1F
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 18:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhEEQC4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 12:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbhEEQC4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 May 2021 12:02:56 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55818C061574
        for <linux-pci@vger.kernel.org>; Wed,  5 May 2021 09:01:59 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id p6-20020a4adc060000b02901f9a8fc324fso581371oov.10
        for <linux-pci@vger.kernel.org>; Wed, 05 May 2021 09:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6fPPXjYzt7oQfhhF+DM2VCjK3n5/1wxts1BaJ771D0Q=;
        b=TZ1hHucpwxOrnYgGKpL71fqaasjzalULqvDt8z/pducGWoeBrP9UaedwwGB43ioWD1
         occn740UKaJpckVLUzcBxAAM73tjrHMG4aqDoNfBDeytHrGc8iH3/3LklbURZi42ngkn
         x5V51N+KehLlJjuuPy+vQnfHb3bYO+aodbxQE3KSC+MZRBw7N0ghv8gePAz2zQ4lzUBu
         WzHi0C7vI79wTXee8tmdm8jZ4ULKruupyCEfROyxBG3YSqaLq39eVnHsoRP+LF1YgENU
         qYILHPfZ/Fqx148gGx1HoIpde+h06WDgjkTmwaZj6ASkIp9SU5HHIjRSGMnebaEMoA2d
         LV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6fPPXjYzt7oQfhhF+DM2VCjK3n5/1wxts1BaJ771D0Q=;
        b=ssY09lhKsKXIBq8zLkMNZozd3fdjp8qn+dQzdK4ZeCt7ZLznCD1sF+rN5BmSBCQxPx
         k+ywyfY+Ovt7IritwXz3Fr9jRtYLF92rgi0RQggPrwmW5lzKRQQnrKDFbNJ5a2qdbW3/
         9daWbwWoS6+fePEVFx0xx3/U+Bir08dl1tyu9TGy/zRrDj4OQ2Z7h1BboYKVWtY6trjd
         RyDVpXLyewSGqob/V9oYcEvjYUVws8R0B3B4wUEBmEMG+Q4U2I6QrNi+7UkGPREgA0kV
         JG/ClQBiDYU4U74OhO0sfGJObyjcHasN7lRaEMPkaMWLpLhxrAf1yLp37fIunYaQP/91
         wXRg==
X-Gm-Message-State: AOAM533qVe4VAJOUbDYscHWuc9ZYEDaRmWascFtmeyGmQbeivx9iAC1L
        ryt9BExgUiDL/YHZN40X4ki+BrHBYcE=
X-Google-Smtp-Source: ABdhPJwGR2f2sx2ZvMY1U4RCd3H2Fa/h+Yd0gnyM8T6uSVNxvpj5BI5VZMKzFyVrVXwMhoVPXBk5Aw==
X-Received: by 2002:a4a:8e44:: with SMTP id z4mr17006665ook.17.1620230518063;
        Wed, 05 May 2021 09:01:58 -0700 (PDT)
Received: from ?IPv6:2603:8081:2802:9dfb:49b3:8e2:3d6d:26c8? (2603-8081-2802-9dfb-49b3-08e2-3d6d-26c8.res6.spectrum.com. [2603:8081:2802:9dfb:49b3:8e2:3d6d:26c8])
        by smtp.gmail.com with ESMTPSA id f13sm1642874ote.46.2021.05.05.09.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 09:01:57 -0700 (PDT)
Subject: Re: [PATCH] Add support for PCIe SSD status LED management
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20210416192010.3197-1-stuart.w.hayes@gmail.com>
From:   stuart hayes <stuart.w.hayes@gmail.com>
Message-ID: <9fa180bd-67d2-dbf7-4fa4-e9838b2ec830@gmail.com>
Date:   Wed, 5 May 2021 11:01:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20210416192010.3197-1-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/16/2021 2:20 PM, Stuart Hayes wrote:
> This patch adds support for the PCIe SSD Status LED Management
> interface, as described in the "_DSM Additions for PCIe SSD Status LED
> Management" ECN to the PCI Firmware Specification revision 3.2.
> 
> It will add a single (led_classdev) LED for any PCIe device that has the
> relevant _DSM. The ten possible status states are exposed using
> attributes current_states and supported_states. Reading current_states
> (and supported_states) will show the definition and value of each bit:
> 
>> cat /sys/class/leds/0000:88:00.0::pcie_ssd_status/supported_states
> ok                              0x0004 [ ]
> locate                          0x0008 [*]
> fail                            0x0010 [ ]
> rebuild                         0x0020 [ ]
> pfa                             0x0040 [ ]
> hotspare                        0x0080 [ ]
> criticalarray                   0x0100 [ ]
> failedarray                     0x0200 [ ]
> invaliddevice                   0x0400 [ ]
> disabled                        0x0800 [ ]
> --
> supported_states = 0x0008
> 
>> cat /sys/class/leds/0000:88:00.0::pcie_ssd_status/current_states
> locate                          0x0008 [ ]
> --
> current_states = 0x0000
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>

Any comments?  I think I sent at a bad time originally.  Thanks!
