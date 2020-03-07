Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B8317CD60
	for <lists+linux-pci@lfdr.de>; Sat,  7 Mar 2020 10:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgCGJzw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Mar 2020 04:55:52 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43795 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgCGJzv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 Mar 2020 04:55:51 -0500
Received: by mail-lf1-f66.google.com with SMTP id s23so3831242lfs.10
        for <linux-pci@vger.kernel.org>; Sat, 07 Mar 2020 01:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ji/5/bt2XJ8xArwptxUIPsa40Bf1NEJkrKPYGi/BazA=;
        b=mOkGDt3zDt5ABNqQCXya1Tqs/c3KohphydAK7oT3wEo+qr98DsVY9zHJtubQ8OwgmD
         hDqKnoUNbZEG7xSHXEThQ47oxj/a/Ea3n1CL3s8Kl19qc+TVh6R8v8NFZPOMZASBE3qv
         bMxzbyIX77TxA3m4OCCKDZkowylP9h4f/9Qg/GablCJ/swiPsqDUckM2pl+nfI3+Oj3w
         AU0Z7jvUirz0Skocp/BLk7z3eX3sfE0/xzwSvQIYADlRF7utGjArjjrrYPu8QUUGoAli
         jCHQbiGivQT7xDj6//C3OAgaTkiKnnt63rShJ0sERTUhf27cM74n9i6wTzMCjOzfoXHl
         2GLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ji/5/bt2XJ8xArwptxUIPsa40Bf1NEJkrKPYGi/BazA=;
        b=lHOL7/12mql67S6/Fkd69KpBsH/BpY4AbwmP5cgAQytr5X/dP9HhUSbNuI7J2MGYde
         G8fsUMis45TwhnXx3G2xoWLd2aAGbob0hEqr/Kc9rwhsDjnwKki5D8NwB/e2DFAyc5ba
         Nbe6Y6b4Wa5NgIxcO1nR5J9c7qolDu4P1YBdz5joX8PBfhGerXbFHY2CjIk3gTMjmqBL
         f49Zeb1zD6t8qxfbjWvzZo+6biBUepbcWyvx3c/4uwRM9SiaWJYpmRkEJP0tKzavNoQb
         37lxdbgL+7mP1ydioQZKU18bT/oHeEgCD8211gteoYndNG5thpeyYS+a9x0BGljPYynO
         kHbg==
X-Gm-Message-State: ANhLgQ3LtOYmRKX4BGaVR2KLig4Q3TmthCSowvdxuZEFRV2avUy0u/6c
        kFRZrs6Dn53X1agQLbvMMiFlrg==
X-Google-Smtp-Source: ADFU+vs5VZMdNVhnnQ/MNq4B4lQUnHvHzclPq0rH3MnhPTJv3B+KFGP8bulUYE8fr5KHb7cInABAEg==
X-Received: by 2002:a05:6512:246:: with SMTP id b6mr4326390lfo.175.1583574947544;
        Sat, 07 Mar 2020 01:55:47 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:402:864b:dd24:504:68eb:a9fe? ([2a00:1fa0:402:864b:dd24:504:68eb:a9fe])
        by smtp.gmail.com with ESMTPSA id z18sm14212386ljm.15.2020.03.07.01.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2020 01:55:45 -0800 (PST)
Subject: Re: [PATCH v4 3/4] PCI: brcmstb: Wait for Raspberry Pi's firmware
 when present
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        tim.gover@raspberrypi.org, linux-pci@vger.kernel.org,
        wahrenst@gmx.net, Bjorn Helgaas <bhelgaas@google.com>
References: <20200306114348.5172-1-nsaenzjulienne@suse.de>
 <20200306114348.5172-4-nsaenzjulienne@suse.de>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <16c98273-a639-374d-e784-0d015aeee634@cogentembedded.com>
Date:   Sat, 7 Mar 2020 12:55:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306114348.5172-4-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06.03.2020 14:43, Nicolas Saenz Julienne wrote:

> xHCI's PCI fixup, run at the end of pcie-brcmstb's probe, depends on
> RPi4's VideoCore firmware interface to be up and running. It's possible
> for both initializations to race, so make sure it's available prior
> starting.

     Prior to starting?

> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
[...]

MBR, Sergei
