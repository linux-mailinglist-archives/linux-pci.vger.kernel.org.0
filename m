Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 871C113AE4
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2019 17:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfEDPTH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 May 2019 11:19:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53223 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfEDPTH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 May 2019 11:19:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id v189so1619249wmf.2
        for <linux-pci@vger.kernel.org>; Sat, 04 May 2019 08:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/3kDf4zTbJ6JwCMltOkVGT11aLQIbZJwgoh9gwLcXAQ=;
        b=ivY5IDQ+DiCMyVPMV55EeTqY3dNpRHS7tnLrJShlkqqaQSlu3RS2/WTNCeFBW6sMWC
         xfUmOzd3Dpjfe2RgspDP9hAAtwxVosGE72d4iWovKMOZbZbMmh7Xrlr+CK3VMrx6TQPH
         /uuvsjcQC9ooVSKQJL9zJY5kxGd316rdcGfrXqdk3FcAF37J01afFOTF8fg9ig3As5XM
         e/3uQEWZ0KZibjCEYBTi4WF/osetEksFEvfyrlTNU/7FdA4mob1pm13t+ppNNnOhgEpr
         sGDvwckJ2Sz/KKqTwXyVxrehGqr/JPF92LlBM0pxGdh9AlI8eDGPI1WGVJJ/fUcatLLe
         D4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/3kDf4zTbJ6JwCMltOkVGT11aLQIbZJwgoh9gwLcXAQ=;
        b=kzoaGt+VyeucFUdUNXtEBbo1sckVM370KjsUH3PSen4UzIS4yr4g1aa6nG0FSQy6L7
         uOqJeFB9EoebnWxCbwPmsThQYjbwWi7BbVMjITXOax7dl2HiHha8emp3R4WTF0rZ67Yd
         CbM5JVsuW3YmjtHZNLJ5Y/V1JBFpuGNq6Y+GqlMz07udfnyiBZzPxP96oKV4UJG5I8zW
         AB7kDLNb/Wjv4oNRnHJCPBvBtBpBabg1nl6d22wPZ5qDF/iA1yYCyRgYFuU/fHqkUjBN
         fRJvVwg7rHyvvLtdHHZzpZXRUKH4MDuiebi0djbSxOyp35j/q3Uvglwd/DC1L7jLLzAY
         psfQ==
X-Gm-Message-State: APjAAAVqFcZnveIjlRG6/3/M7cr8ia5hpvQ709Y9UYI6+KpGI6YMNZLa
        nlNltgNouY0cPeLqccjQ/p5fDG3w6Vo=
X-Google-Smtp-Source: APXvYqw3FJn0AVxE8jHwU5uHFsIfC8cXhZUc0MOq67af83/Bj9tYGEDVMHiBW4XwT04nB/cTCIf1GA==
X-Received: by 2002:a1c:2104:: with SMTP id h4mr10204678wmh.146.1556983145188;
        Sat, 04 May 2019 08:19:05 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:4cd8:8005:fc98:c429? (p200300EA8BD457004CD88005FC98C429.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:4cd8:8005:fc98:c429])
        by smtp.googlemail.com with ESMTPSA id s2sm5122870wmc.7.2019.05.04.08.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 08:19:04 -0700 (PDT)
Subject: Re: [PATCH RFC 3/3] PCI/ASPM: add sysfs attribute for controlling
 ASPM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <e63cec92-cfb1-d0c4-f21e-350b4b289849@gmail.com>
 <a0a39450-1f23-f5a0-d669-3d722e5b71dd@gmail.com>
 <20190430175304.GC145057@google.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <0f7ffd17-7fd5-405f-48cc-ccaa3d25963a@gmail.com>
Date:   Sat, 4 May 2019 17:18:58 +0200
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
> window of opportunity here where we can tweak the sysfs structure
> before we're committed to supporting something forever.
> 
Thanks for the feedback. I'll check the mentioned conversation and try
to get the control moved to the endpoint.

> Bjorn
> 
Heiner
