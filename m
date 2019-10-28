Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACF69E6C68
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 07:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbfJ1G02 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 02:26:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38050 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbfJ1G02 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 02:26:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id 22so7660706wms.3
        for <linux-pci@vger.kernel.org>; Sun, 27 Oct 2019 23:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5l+qsX7WECe81v1d1Mcoy8+QeEHbXdZNkAOza7rbPmc=;
        b=lGyIjhdcFCLnL2EhVsQ3dISpevn1p9ZHN7r8c32E2zpBfOYaBuPO05xekplekmxwDO
         t4aL75beOiLLbprHtYFmOy8XGAVsdnVghhCykf2z8MhE7cTrPAOV73D9teVxAGdGM4ea
         5muFcE0cfv/mf1AUvhYu6ju9IBXGLNggHLSBvTcnZpgovCPk0mdBM3Cdb28euevSc/ZB
         pHfSu1+8lO1qBwEXYSH90/4d1Pew3U+/OF2/x7L1b2bKYHsvvnTGnNChQISBnZrp6EyK
         qAHA2umrl8+XVuutb6xX+9Tq+q8E2Dn0YX8ktZCgFwCLHQGp4AS9wAWw8Ucha49enw7Z
         jkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5l+qsX7WECe81v1d1Mcoy8+QeEHbXdZNkAOza7rbPmc=;
        b=Q4Abaj88SvT91G4+CJ+dALgH6OWqdZsto0ffP6dTMnuH8zH4L50iL7lTb1fbiHg1wF
         FdXabGx1Ozc0RDPYXFAFIDxQ3KrLvp5sgf/xvNObqVh+5CD13WKOsYzjAA6kKhwJ+6rE
         heA9HOG02e5my4Xgp2pH5Cv8NxlYxb2rbFF5dUsp1QxzWHxiOAHduW2o6ZfA2fMZjRPw
         hjKbfSH+u/9JIv2t/NW94rbaI27MeMd8D+6sTkuYmBK8SZKyMDzPhP56Cw2FdgqyvlB8
         ChnRW+xrMQIguKol377opwFdMP0JqGw7szl9K7fK8rOW6eSHQIz0xLzADU6tWlxigIbr
         ZC0Q==
X-Gm-Message-State: APjAAAVgPuryEB6AWrVjxTWkAQsfclJRVsXuOzAEaFmAnRwIUSoDgzIt
        LRkER2IZV+XYlzWJ567Fht27gwEU
X-Google-Smtp-Source: APXvYqxHW3gKY8kDXgEpF1N1IlM0cU3mUtYBfmbZkro1clP4bq2jMk0nAZK5sfYzJHoaJXP5gE+SKg==
X-Received: by 2002:a1c:e40b:: with SMTP id b11mr14042278wmh.152.1572243986313;
        Sun, 27 Oct 2019 23:26:26 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f17:6e00:295c:195c:28c1:8e78? (p200300EA8F176E00295C195C28C18E78.dip0.t-ipconnect.de. [2003:ea:8f17:6e00:295c:195c:28c1:8e78])
        by smtp.googlemail.com with ESMTPSA id a5sm10033172wrm.78.2019.10.27.23.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 23:26:25 -0700 (PDT)
Subject: Re: Drop Kconfig option PCIEASPM?
To:     Vidya Sagar <vidyas@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1f784101-fe7a-becf-d855-ddc6d03a3f92@gmail.com>
 <d1c3ca5b-563a-6823-fb78-3f1853bc956e@nvidia.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <4f1ed14f-ccfa-6f0b-ea52-c826797e24dd@gmail.com>
Date:   Mon, 28 Oct 2019 07:26:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d1c3ca5b-563a-6823-fb78-3f1853bc956e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28.10.2019 06:41, Vidya Sagar wrote:
> On 10/26/2019 3:12 AM, Heiner Kallweit wrote:
>> I wonder whether anybody actually wants to disable ASPM support.
>> In an old Kconfig commit message is mentioned that it may help
>> to reduce kernel size of embedded systems. However I would
>> think that on embedded systems ASPM is quite useful as it
>> saves significant power and may result in a lower system
>> temperature therefore.
>> W/o ASPM support we have to live with devices coming up
>> in whatever mode boot loader or firmware configure.
>>
>> Heiner
>>
> It means that we can still have an option to specify one of
> PCIEASPM_DEFAULT/PERFORMANCE/POWERSAVE/POWER_SUPERSAVE configs right?
> 
Yes, these config options would remain.
PCIEASPM has a dependency on PCIEPORTBUS, so the idea would be to
build ASPM support whenever PCIEPORTBUS is defined.

> Vidya Sagar
> 
Heiner
