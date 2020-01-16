Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 850C013D249
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2020 03:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgAPCoZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 21:44:25 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42371 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgAPCoZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2020 21:44:25 -0500
Received: by mail-ot1-f66.google.com with SMTP id 66so18035135otd.9;
        Wed, 15 Jan 2020 18:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a4pKcw/2BK8WWEeubF0Q2A9y+I7yO16zCFaw5GtTcg8=;
        b=fZC0gpoWyib170KL5rP2oTpwxhcZZLQjhtxaZDNij1MDAPULVU14doVOJGK46LsTp/
         1UQ7oBb7UEPQZih68kAds0Z483kZkk83bDJ+1yb80YqLdqbau1lHyjCZPhCj9b21rTYK
         CnSWETNaJ8saaWFDaDezzX8keTnxM+Y1ZpTQcHh8PeQarkHYigNoPEwpCrwPCdp4HDxe
         biZrYKEbssNNmDoJnS7A8QQxhitW3VOnDf39hK/mam6xb2W7Otyq9mmMqwyyXemNdBgJ
         TB8ujQyqQLPnB42CvGQ2DOj/065LULoN9BNElsMkpE54uTVX9derTW4Cd2G2psbxP0y+
         F1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a4pKcw/2BK8WWEeubF0Q2A9y+I7yO16zCFaw5GtTcg8=;
        b=b5+gxGpbs/B47aLCqsEnOGOQCvWVjFJI/TVIcIS5V07CDkBOWtii4sr2fEP/VGQ4pN
         CsYqKMi2LfmR2PRTAhTvLTC+F+HPQ3MT+R5p+M6kgiujFhp6Ith4Txonr9cQH4zaZNos
         W2jG+l7KT7VJYN4E2h1mWo43Rogmaq/ZNLdEzVyGNHqnSkkHsSwyRoovosSNi4Yhsk5p
         hqW8iHBW+UqdQGJbUCa1j9QTmzElUVMBNgoZUO7scdosct3juduheRoAq9vp/ixEcmYM
         BqU4MGzD0mJhHvoKE2lY6a1SZcx9Tax3lDx7Rkgnx0++KX7h0nYD3wtZPBeNAE+Vo1SK
         772w==
X-Gm-Message-State: APjAAAWePj9p2y56lQMmJalMcTC7BNInZcdFWpFwoBfQSkg3/6ZN7+5W
        23wFYLJFLxjv+dNcg5FxBjuKxrgXS9s=
X-Google-Smtp-Source: APXvYqyMzjUqnYZhbCuI8vmeXgY3MMiWg+xL/yMGpoTUZvlOw9zo4fFc9iQ7oLgje0urhCYDbdTXmw==
X-Received: by 2002:a9d:5888:: with SMTP id x8mr285541otg.361.1579142664039;
        Wed, 15 Jan 2020 18:44:24 -0800 (PST)
Received: from nukespec.gtech ([2601:2c1:8501:182d::6fe])
        by smtp.gmail.com with ESMTPSA id c12sm7357959otp.9.2020.01.15.18.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 18:44:23 -0800 (PST)
Subject: Re: Issues with "PCI/LINK: Report degraded links via link bandwidth
 notification"
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     Jan Vesely <jano.vesely@gmail.com>, Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>,
        Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200115221008.GA191037@google.com>
From:   Alex G <mr.nuke.me@gmail.com>
Message-ID: <967fb44c-b1cd-875c-2354-b6ad0b8ae6d7@gmail.com>
Date:   Wed, 15 Jan 2020 20:44:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200115221008.GA191037@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

I'm no longer working on this, so my memory may not be up to speed. If 
the endpoint is causing the bandwidth change, then we should get an 
_autonomous_ link management interrupt instead. I don't think we report 
those, and that shouldn't spam the logs

If it's not a (non-autonomous) link management interrupt, then something 
is causing the downstream port to do funny things. I don't think ASPM is 
supposed to be causing this.

Do we know what's causing these swings?

For now, I suggest a boot-time parameter to disable link speed reporting 
instead of a compile time option.

Alex

On 1/15/20 4:10 PM, Bjorn Helgaas wrote:
> I think we have a problem with link bandwidth change notifications
> (see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/bw_notification.c).
> 
> Here's a recent bug report where Jan reported "_tons_" of these
> notifications on an nvme device:
> https://bugzilla.kernel.org/show_bug.cgi?id=206197
> 
> There was similar discussion involving GPU drivers at
> https://lore.kernel.org/r/20190429185611.121751-2-helgaas@kernel.org
> 
> The current solution is the CONFIG_PCIE_BW config option, which
> disables the messages completely.  That option defaults to "off" (no
> messages), but even so, I think it's a little problematic.
> 
> Users are not really in a position to figure out whether it's safe to
> enable.  All they can do is experiment and see whether it works with
> their current mix of devices and drivers.
> 
> I don't think it's currently useful for distros because it's a
> compile-time switch, and distros cannot predict what system configs
> will be used, so I don't think they can enable it.
> 
> Does anybody have proposals for making it smarter about distinguishing
> real problems from intentional power management, or maybe interfaces
> drivers could use to tell us when we should ignore bandwidth changes?
> 
> Bjorn
> 
