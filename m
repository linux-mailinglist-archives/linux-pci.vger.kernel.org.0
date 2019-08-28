Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDCEB9F9F4
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 07:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfH1FlD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 01:41:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39399 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfH1FlD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 01:41:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id i63so1392316wmg.4
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2019 22:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3gn0Zvm5vYsBKbBG4u7AezTlOq/VOJud55uzolnhHcM=;
        b=skq2OcLgvGzdKPi4PE+fuH1sFLJtY6SWaGfy/xIi5hHxnr0gr5Dn8w5ATQbOauCE4Y
         +DlKlt+LMvuXHRiK5tqGry5wPq3vsJ2ctEPRKou87ci6jvqAIArpArh0Ty/sOdyaJT0O
         5p8QMM5D2ih1gGLSt4t4DtO7YdbSOAf9BP0U/EyedH6CwSDuyZhNErQbMwBIUTn24/Bj
         lPtjouwWOOVvITQIpzp/cAdiZ7EXjDnMxzzBEN0AFwdoL4f3l1yO7YGrHQHgMNhyuCTW
         HpJDkCy38QLc3GlYH9Ebs5cGevLGWfqENjLJjgx/E/iccBpCGCRGFpUfVx5xlb1YcSmu
         D1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3gn0Zvm5vYsBKbBG4u7AezTlOq/VOJud55uzolnhHcM=;
        b=IAc7SQ0+h7T5pwv2mZF3SvR7g2FdMaWAnEofq9Io8EvO4mtsavXVtweW42MTC7X/V1
         gzw0mz+/fiBRLuDX+3faCkOHb0tZGFmrMYZiUiLx29rOTYss4NWCgdWoN65mVQevDiEV
         C/rGNMOwRIoJHaC2/LdxiCcE5FJrmtMqVjHvbUcMz6mdbWzhTTz+SeWV6jnA4WIthGuX
         N3D4CgkhoH2m4k0EwJDq8ckh4z9lEXDRxGpylYtZrhM5SCPo8dAkVHPx23RrD6t4hMd8
         S47TUBNfQMsjQ+e50hEwWlFuOp3e5eSzyasYuktfg23QWCDmXAQmw4Arf6isD214fTct
         aLwA==
X-Gm-Message-State: APjAAAVzzDroUkxwOW0bhBtswyoBa7zjCjG6s09W9nI/TbUwBctvv/CV
        xVcDRuZLDBIuW7EB4HGgRh+d/Otp
X-Google-Smtp-Source: APXvYqzA9QePNFBZDhpj6DA07p6Oqeg72VYpDz82wzVpQyQceM4WPLO9x+fuXl6aqd8QqNCljvYY3Q==
X-Received: by 2002:a7b:c40e:: with SMTP id k14mr2301456wmi.167.1566970860770;
        Tue, 27 Aug 2019 22:41:00 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:3ca9:fbff:ec1b:c219? (p200300EA8F047C003CA9FBFFEC1BC219.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:3ca9:fbff:ec1b:c219])
        by smtp.googlemail.com with ESMTPSA id w13sm2110337wre.44.2019.08.27.22.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 22:41:00 -0700 (PDT)
Subject: Re: [PATCH v4 0/4] PCI/ASPM: add sysfs attributes for controlling
 ASPM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <3797de51-0135-07b6-9566-a1ce8cf3f24e@gmail.com>
 <20190827233541.GL9987@google.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <4eace423-8727-2957-79ab-bf954a050e20@gmail.com>
Date:   Wed, 28 Aug 2019 07:40:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827233541.GL9987@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28.08.2019 01:35, Bjorn Helgaas wrote:
> On Sat, Aug 24, 2019 at 05:39:37PM +0200, Heiner Kallweit wrote:
>> Background of this extension is a problem with the r8169 network driver.
>> Several combinations of board chipsets and network chip versions have
>> problems if ASPM is enabled, therefore we have to disable ASPM per
>> default. However especially on notebooks ASPM can provide significant
>> power-saving, therefore we want to give users the option to enable
>> ASPM. With the new sysfs attributes users can control which ASPM
>> link-states are disabled.
>>
>> v2:
>> - use a dedicated sysfs attribute per link state
>> - allow separate control of ASPM and PCI PM L1 sub-states
>>
>> v3:
>> - patch 3: statically allocate the attribute group
>> - patch 3: replace snprintf with printf
>> - add patch 4
>>
>> v4:
>> - patch 3: add call to sysfs_update_group because is_visible callback
>>            returns false always at file creation time
>> - patch 3: simplify code a little
>>
>> Heiner Kallweit (4):
>>   PCI/ASPM: add L1 sub-state support to pci_disable_link_state
>>   PCI/ASPM: allow to re-enable Clock PM
>>   PCI/ASPM: add sysfs attributes for controlling ASPM link states
>>   PCI/ASPM: remove Kconfig option PCIEASPM_DEBUG and related code
>>
>>  Documentation/ABI/testing/sysfs-bus-pci |  13 ++
>>  drivers/pci/pci-sysfs.c                 |  10 +-
>>  drivers/pci/pci.h                       |  12 +-
>>  drivers/pci/pcie/Kconfig                |   7 -
>>  drivers/pci/pcie/aspm.c                 | 236 ++++++++++++++++--------
>>  include/linux/pci-aspm.h                |  10 +-
>>  6 files changed, 195 insertions(+), 93 deletions(-)
> 
> I can fix this if you don't get to it, but this doesn't apply cleanly
> to either my "master" branch (v5.3-rc1) or my "next" branch.  I always
> prefer series based on my "master" branch when possible.
> 
> Bjorn
> 
I based it on top of linux-next, can rebase it to your master branch.

Heiner
