Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3312513AFA
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2019 17:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfEDPbL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 May 2019 11:31:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53925 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfEDPbL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 May 2019 11:31:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id q15so10507805wmf.3
        for <linux-pci@vger.kernel.org>; Sat, 04 May 2019 08:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oOcHJEiA+Y+rDxwTO1WaunndvGDlLUoQW09R2p8Mf+g=;
        b=bTbVLXlzLdHLPoiVdu4ntxuo7sxyP8g2gbi0317hV72OwZhKpvWS9ESU1aJ/ggz1o2
         Rv8N1+gyu1XO1S8ybepqkYkdJNw6pMWUP0oGs+nYTZLme9gBO+odXOxMublKJZFwJS9F
         9WEkQ0PCDoPtcfT4/G9GRLlhHJpSJC8lNb8wNosCT8EAu7eLB9IUx4HzMKKlBz0id2q0
         4EDWn730ospJ5nYnlvo/eQli1DOZi//7n2H1de8Nw05J1B/Mvfvgw0kP6wxQhqmc9OhV
         8XmlO3r6+rLJ/iIP3+P9DGfzo5Wb9l7Djin0Dp42gFnb+4DmXZTKHM00cQ4Nc7RxTfAb
         4MRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oOcHJEiA+Y+rDxwTO1WaunndvGDlLUoQW09R2p8Mf+g=;
        b=D+4sppAkvwcQXgkrjiBUeRN4FGZTnwM/ND2uqp7vWew5z/576qfdNj+BVBwg7ceggz
         0jxTd2/686WlM4n8B5yfLFUGugHp1hzPVZSDX4u2hbvkhpw1wxzfAEqHRmVPg556lREJ
         lbjLw5VtA31BbNc9F07Hb6nvVLO6d3cZ238FHo24OBI8M643aIvR21B72reNnL+rSBx7
         11Hy3z5O6Php4w0ihcvWoBNtz90MtiRxb4d61JUR8982INj2+VFUQusJUlgjY/fzfD6Z
         6z7SSR+2RUGpcYWGQJb+quac/rcBkt8D3dC3cdJC3z2g79M4HdpGrpkiVV6igu5iG3Di
         BW3Q==
X-Gm-Message-State: APjAAAWTtJrqZWvFwtY3EN3PhlKLYK6hKZXM8ihd5JXdLppuCD5/gcmh
        l174ODLTjQV6eLp/mNAU1nwksPCbDQI=
X-Google-Smtp-Source: APXvYqzaA88OZzF/pEJ+65qVQLnS13X/IKA8/IX1QloPSLoblj/PUo/vqceYUgwN8FjNnWR5HFx24g==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr9953334wmj.32.1556983869207;
        Sat, 04 May 2019 08:31:09 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:4cd8:8005:fc98:c429? (p200300EA8BD457004CD88005FC98C429.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:4cd8:8005:fc98:c429])
        by smtp.googlemail.com with ESMTPSA id u2sm9582197wru.36.2019.05.04.08.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 08:31:08 -0700 (PDT)
Subject: Re: [PATCH RFC 3/3] PCI/ASPM: add sysfs attribute for controlling
 ASPM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <e63cec92-cfb1-d0c4-f21e-350b4b289849@gmail.com>
 <a0a39450-1f23-f5a0-d669-3d722e5b71dd@gmail.com>
 <20190430175304.GC145057@google.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <1cdf51f0-653a-f0e8-83dc-88b9d023a269@gmail.com>
Date:   Sat, 4 May 2019 17:31:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430175304.GC145057@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30.04.2019 19:53, Bjorn Helgaas wrote:
> On Sat, Apr 13, 2019 at 11:12:41AM +0200, Heiner Kallweit wrote:
>> Background of this extension is a problem with the r8169 network driver.
>> Several combinations of board chipsets and network chip versions have
>> problems if ASPM is enabled, therefore we have to disable ASPM per
>> default. However especially on notebooks ASPM can provide significant
>> power-saving, therefore we want to give users the option to enable
>> ASPM. With the new sysfs attribute users can control which ASPM
>> link-states are disabled.
> 
>> +void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
>> +void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
>>  #else
>>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>>  static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
>> -#endif
>> -
>> -#ifdef CONFIG_PCIEASPM_DEBUG
>> -void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
>> -void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
>> -#else
> 
> I like the idea of exposing these sysfs control files all the time,
> instead of only when CONFIG_PCIEASPM_DEBUG=y, but I think when we do
> that, we should put the files at the downstream end of the link (e.g.,
> an endpoint) instead of at the upstream end (e.g., a root port or
> switch downstream port).  We had some conversation about this here:
> 
> https://lore.kernel.org/lkml/20180727202619.GD173328@bhelgaas-glaptop.roam.corp.google.com
> 
> Doing it at the downstream end would require more changes, of course,
> and probably raises some locking issues, but I think we have a small

This isn't obvious to me as I'm not that familiar with the PCIe subsystem.
- Why do we need more changes on the downstream end?
- Which locking is affected?

> window of opportunity here where we can tweak the sysfs structure
> before we're committed to supporting something forever.
> 
> Bjorn
> 
Heiner
