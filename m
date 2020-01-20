Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59508142F4F
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2020 17:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgATQKO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jan 2020 11:10:14 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42412 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgATQKO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jan 2020 11:10:14 -0500
Received: by mail-oi1-f194.google.com with SMTP id 18so28929456oin.9;
        Mon, 20 Jan 2020 08:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hEQYDkqPX4uYMhuYWM6fr7tZlzBSPPJbG7zw6GGKPF8=;
        b=OciUar9FLHyi9IzxNGF0oGxjYDc7nKe/qJAhc24dHR1Vtqh7IUpF15oI1J7Z5s+0ab
         5cJbX/UiiBMHmHeRDNOQT7Fw+756E4wkrPGMxEDdsT/36jqo7aHGllHztsSocthRSdl4
         N4gk5zNCk8DpaEueOiEZapFJ9x50YqEiRAnU0+TmX+AFfFO3K7Sq0jsJQ499OiMxr+go
         UVc6deORjfwkOCmKlHfowWRpL7bTAV47/f31GqcpKMa7O6wHKjS77ORC56+UIPMljamR
         f3IKOPCysvdBfAljXA7SllOl5A6y8NnmRdPJ+Xa5yVxD2nodTOosbwEAmSY4rMCFa1Oz
         CruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hEQYDkqPX4uYMhuYWM6fr7tZlzBSPPJbG7zw6GGKPF8=;
        b=SFQI02EpQhJZ4/fQo+765y7Stj0s+3kIYoN6lvyMo1/PiDFIT+ZCxG/WAjCgmNL+o0
         m28W6xhccLt7/LOnMb6tklzavggDX4U3dMtK7G3vq/DBalx28h8YIAI2jnEL+ak4RxEF
         o/SY8T7ONqFF58clZcjbiphHRb4G6RHuPRbUpF+qhKQKySzCWEx9EeZex/M+LJ1P341S
         /pFFHdgH1vN+EIAQpOs4E5K3hDGKVxCdSuR78l5/bDQF43CaDnY4gjMuHdGROZsxA/CO
         9sXheOzW1hHdvMXiUCCiui7p+T65jH5Opeh1pgDO5K/U//e/4/tErUDqoIsanm05akw2
         5hFg==
X-Gm-Message-State: APjAAAWkiov8wcDhoA6lzktAaDzxNhPyh30f1equlKEopCnIpkF58NFm
        ytfyO8dNo2CIIvye7yfyvCk=
X-Google-Smtp-Source: APXvYqwKvXhusvAdd7PpGLaF7zlMGa8YTeeENIG0hi//rrxEB1/pVI5yuHqAvt/aNka9v5qJ2TcYvA==
X-Received: by 2002:a05:6808:1c5:: with SMTP id x5mr5765oic.57.1579536613069;
        Mon, 20 Jan 2020 08:10:13 -0800 (PST)
Received: from [100.71.96.87] ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id m12sm12480238otq.15.2020.01.20.08.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 08:10:12 -0800 (PST)
Subject: Re: [PATCH v2] PCI: pciehp: Make sure pciehp_isr clears interrupt
 events
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de
References: <20191120222043.53432-1-stuart.w.hayes@gmail.com>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <41285254-1bc1-3ffe-383e-276dc7193990@gmail.com>
Date:   Mon, 20 Jan 2020 10:10:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191120222043.53432-1-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/20/19 4:20 PM, Stuart Hayes wrote:
> Without this patch, a pciehp hotplug port can stop generating interrupts
> on hotplug events, so device adds and removals will not be seen.
> 
> The pciehp interrupt handler pciehp_isr() will read the slot status
> register and then write back to it to clear the bits that caused the
> interrupt. If a different interrupt event bit gets set between the read and
> the write, pciehp_isr will exit without having cleared all of the interrupt
> event bits. If this happens, and the port is using an MSI interrupt where
> per-vector masking is not supported, we won't get any more hotplug
> interrupts from that device.
> 
> That is expected behavior, according to the PCI Express Base Specification
> Revision 5.0 Version 1.0, section 6.7.3.4, "Software Notification of Hot-
> Plug Events".
> 
> Because the "presence detect changed" and "data link layer state changed"
> event bits are both getting set at nearly the same time when a device is
> added or removed, this is more likely to happen than it might seem. The
> issue was found (and can be reproduced rather easily) by connecting and
> disconnecting an NVMe storage device on at least one system model.
> 
> This issue was found while adding and removing various NVMe storage devices
> on an AMD PCIe port (PCI device 0x1022/0x1483).
> 
> This patch fixes this issue by modifying pciehp_isr() by looping back and
> re-reading the slot status register immediately after writing to it, until
> it sees that all of the event status bits have been cleared.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> ---
> v2:
>   * fixed ctrl_warn() call
>   * improved comments
>   * added pvm_capable flag and changed pciehp_isr() to loop back only when
>     pvm_capable flag not set (suggested by Lukas Wunner)
>   
>  drivers/pci/hotplug/pciehp.h     |  3 ++
>  drivers/pci/hotplug/pciehp_hpc.c | 50 ++++++++++++++++++++++++++++----
>  2 files changed, 47 insertions(+), 6 deletions(-)
> 

Bjorn,

Please let me know if I could do anything to help get this patch accepted.

Thanks!
Stuart

