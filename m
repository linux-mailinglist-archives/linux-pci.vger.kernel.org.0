Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17FFB9F9FD
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 07:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfH1FsZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 01:48:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45684 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfH1FsY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 01:48:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id q12so1081280wrj.12
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2019 22:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ed6Zz6ORAf1kO0s6RblWZzYGuxzlXdpcJcn8EitzMDI=;
        b=VF0x2PyLvADCQmHGabCR8sDEqj0LsaT1+1MWAEimsKB+KKQizZutZHromGldnubEni
         frDsR+OeoQ0lPR0LTdR/CFo8/KhcDPBwnZwSS/wrt1bO9IsdlGkYHD1Wsplf03XeKvuB
         DGut5jjPON9McOWWCEzYycFKycPo8S7VqApfbCd5Duflw99A44PPNNY1oo/m8hgZ/6BY
         HyUSnFUK4JIiruSV1YhWbzBBPpS9J5roVd1v11VdwKPjY29Dx/NrzBgyN9GLZd7sq/Gw
         ZIqw0ccK471rx/B5087POqSU7NZ+d5jl97gVCjQMYBSFQ6DvuI2gkvtiHXmLI92Faa5+
         r/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ed6Zz6ORAf1kO0s6RblWZzYGuxzlXdpcJcn8EitzMDI=;
        b=t88awDSVcOsJxrDYf6cjFUsT8VYEi3L5G4YhkI7sfLOIzeSlwdo0Vfh8B0OXtFJao/
         pF7QZoT9GCf6SQ5EpblEiX5GMxgoWdYaFqJ6C01Byy5I46e4tARkFLT/+gUdOAWGYpd9
         4PDIbgTRlWkzzcM36xo1fU7/PB5uiX0toLCzhM/CMzvO89flrg1taCcynZ4220P71Yvr
         YN2F/HVn/aOTYTN+DzxP9gOUKoPWEU59lD4vrurvX0InTCHc/4pr0CYIhaPkGR5MLuJU
         yXNoq2+9DXfY5pDso3le9f0Kj+++L34/kC8VoSXbjG0mD7fxqLGTF5iVlIYxjR3FO1LF
         l2jw==
X-Gm-Message-State: APjAAAWmR4c5fwXZVK+OHv9ckK3+tn3tB2cLG05MSGvY1UEZrEOcPoNv
        tFum9uFfc96bC3cDO3uqtm0DYLai
X-Google-Smtp-Source: APXvYqxrERbb+YmVVuMsf0MXed5V6OidYMYRZXzxGMwzPY0Zkz7zrPwn1Bm0ZZfj6DXmKCvxYXjXyg==
X-Received: by 2002:adf:ee41:: with SMTP id w1mr2163626wro.102.1566971302032;
        Tue, 27 Aug 2019 22:48:22 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:3ca9:fbff:ec1b:c219? (p200300EA8F047C003CA9FBFFEC1BC219.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:3ca9:fbff:ec1b:c219])
        by smtp.googlemail.com with ESMTPSA id 12sm1286486wmi.34.2019.08.27.22.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 22:48:21 -0700 (PDT)
Subject: Re: [PATCH v4 0/4] PCI/ASPM: add sysfs attributes for controlling
 ASPM
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <3797de51-0135-07b6-9566-a1ce8cf3f24e@gmail.com>
 <20190827233541.GL9987@google.com>
 <4eace423-8727-2957-79ab-bf954a050e20@gmail.com>
Message-ID: <acfcbedc-4019-95b8-71a3-4fb5d1185a92@gmail.com>
Date:   Wed, 28 Aug 2019 07:48:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4eace423-8727-2957-79ab-bf954a050e20@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28.08.2019 07:40, Heiner Kallweit wrote:
> On 28.08.2019 01:35, Bjorn Helgaas wrote:
>> On Sat, Aug 24, 2019 at 05:39:37PM +0200, Heiner Kallweit wrote:
>>> Background of this extension is a problem with the r8169 network driver.
>>> Several combinations of board chipsets and network chip versions have
>>> problems if ASPM is enabled, therefore we have to disable ASPM per
>>> default. However especially on notebooks ASPM can provide significant
>>> power-saving, therefore we want to give users the option to enable
>>> ASPM. With the new sysfs attributes users can control which ASPM
>>> link-states are disabled.
>>>
>>> v2:
>>> - use a dedicated sysfs attribute per link state
>>> - allow separate control of ASPM and PCI PM L1 sub-states
>>>
>>> v3:
>>> - patch 3: statically allocate the attribute group
>>> - patch 3: replace snprintf with printf
>>> - add patch 4
>>>
>>> v4:
>>> - patch 3: add call to sysfs_update_group because is_visible callback
>>>            returns false always at file creation time
>>> - patch 3: simplify code a little
>>>
>>> Heiner Kallweit (4):
>>>   PCI/ASPM: add L1 sub-state support to pci_disable_link_state
>>>   PCI/ASPM: allow to re-enable Clock PM
>>>   PCI/ASPM: add sysfs attributes for controlling ASPM link states
>>>   PCI/ASPM: remove Kconfig option PCIEASPM_DEBUG and related code
>>>
>>>  Documentation/ABI/testing/sysfs-bus-pci |  13 ++
>>>  drivers/pci/pci-sysfs.c                 |  10 +-
>>>  drivers/pci/pci.h                       |  12 +-
>>>  drivers/pci/pcie/Kconfig                |   7 -
>>>  drivers/pci/pcie/aspm.c                 | 236 ++++++++++++++++--------
>>>  include/linux/pci-aspm.h                |  10 +-
>>>  6 files changed, 195 insertions(+), 93 deletions(-)
>>
>> I can fix this if you don't get to it, but this doesn't apply cleanly
>> to either my "master" branch (v5.3-rc1) or my "next" branch.  I always
>> prefer series based on my "master" branch when possible.
>>
>> Bjorn
>>
> I based it on top of linux-next, can rebase it to your master branch.
> 
> Heiner
> 
Ah, one more point:
This series has a dependency on Mika Westerberg's
"PCI: Make pcie_downstream_port() available outside of access.c"
that is sitting in your inbox. How do you want to deal with this?

Heiner
