Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE331AB4A
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2019 10:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfELIrN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 May 2019 04:47:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50907 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfELIrN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 May 2019 04:47:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id f204so5534468wme.0
        for <linux-pci@vger.kernel.org>; Sun, 12 May 2019 01:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V5jCv/lhzPMKKOqIWB+6KRjfdui5/dtNe5AOpv0PE1o=;
        b=htwqMIBS2LLdrVsUU4RdJjPwPpv8CA1/+Npwhvt5cDGtIzBfIxKNq7qtV1r8yn1bDH
         YPU0PrXFNr3uSKoLHMEPt+orJVxrRFSam4xGOVkZk+CNClhqBSDPg+BhuRpgHA3tJzd2
         cBHM9X/6yubkSkhw0aal+ha0TdPFDpAsN4HJM04sHu4VvrhOppzw4bqGNDWJR7+PW/Zv
         L5P98Vkg1LqBa3P61HrYipS1d75PQYvqnxo7dKIK6Dsyexsbb3S9mvLryVwFaKo2vkio
         8ZYS8cgkBcowHqU6waZdlis0rsQid7B0F+yCJBvuKJfmSxyzTqC88yxm20lvbfcypF8L
         eBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V5jCv/lhzPMKKOqIWB+6KRjfdui5/dtNe5AOpv0PE1o=;
        b=sELk6FC0HyB+Lqm+Q7ElhNSJexWFRNngv/UQmxe7Sux1VRhmXA4CrHw73/QRR3w1hn
         szhfoA/1cBtPXlumPMdDEf4Wl/8AxTGyqerawpWqZE1qEiTiPgbhmEQBIiFfmSCEK3Z/
         LWkLD0acOTGcIJL97/mqJK48Sp9lOWkliFOLGGTS29bETYqBCOIRPWDu4o1/He5UZJ4e
         +ISGgSqeFSa/Pk60g12mCSPUXjeSTnyK3nCpl2XyQXjm0TNq+32nwi26CHVw/P45hXEe
         fWcPhZ6n2RY1+PPiSnvvI+Dpi2QhwGyjW+0HhKU39UjMaLnhAhx9ByHTQHGnm+ucGr/j
         9w8Q==
X-Gm-Message-State: APjAAAW6mmZ52YXR0uTJ8yyHQAMSENPPDmTYX5UN3LQ26rPODcnTzfRW
        uKCdNn9yCdw0wvSk7uzD8O/Fb0ZbQL0=
X-Google-Smtp-Source: APXvYqz4LMRUUQqVf3bnFAFQV7AMlYP2QOYjt3uWbxEIH3mDXsmE7UQMKs9Bc/M3PDrLzPQQkadt+Q==
X-Received: by 2002:a1c:e916:: with SMTP id q22mr12233147wmc.148.1557650831092;
        Sun, 12 May 2019 01:47:11 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:9c27:51d8:9ed5:dad3? (p200300EA8BD457009C2751D89ED5DAD3.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:9c27:51d8:9ed5:dad3])
        by smtp.googlemail.com with ESMTPSA id y6sm14942928wrw.60.2019.05.12.01.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 01:47:10 -0700 (PDT)
Subject: Re: [PATCH RFC v2 3/3] PCI/ASPM: add sysfs attribute for controlling
 ASPM
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <e041842a-55ed-91e3-75c2-c1a0267b74e5@gmail.com>
 <773b6a8a-00ac-a275-c80b-d5909ca58f19@gmail.com>
 <d8e271e0-d83f-14f9-00d6-ad63a56d8959@fredlawl.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <f1d6e06c-5e07-574d-3ff4-f2245bbdddfa@gmail.com>
Date:   Sun, 12 May 2019 10:47:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d8e271e0-d83f-14f9-00d6-ad63a56d8959@fredlawl.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12.05.2019 03:02, Frederick Lawler wrote:
> Evening,
> 
> Heiner Kallweit wrote on 5/11/19 10:33 AM:> +static ssize_t aspm_disable_link_state_show(struct device *dev,
>> +                        struct device_attribute *attr,
>> +                        char *buf)
>> +{
>> +    struct pci_dev *pdev = to_pci_dev(dev);
>> +    struct pcie_link_state *link;
>> +    int len = 0, i;
>> +
>> +    link = aspm_get_parent_link(pdev);
>> +    if (!link)
>> +        return -EOPNOTSUPP;
>> +
>> +    mutex_lock(&aspm_lock);
>> +
>> +    for (i = 0; i < ARRAY_SIZE(aspm_sysfs_states); i++) {
>> +        const struct aspm_sysfs_state *st = aspm_sysfs_states + i;
>> +
>> +        if (link->aspm_disable & st->disable_mask)
>> +            len += scnprintf(buf + len, PAGE_SIZE - len, "[%s] ",
>> +                     st->name);
>> +        else
>> +            len += scnprintf(buf + len, PAGE_SIZE - len, "%s ",
>> +                     st->name);
>> +    }
>> +
>> +    if (link->clkpm_disable)
>> +        len += scnprintf(buf + len, PAGE_SIZE - len, "[CLKPM] ");
>> +    else
>> +        len += scnprintf(buf + len, PAGE_SIZE - len, "CLKPM ");
>> +
>> +    mutex_unlock(&aspm_lock);
>> +
>> +    len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
>> +
>> +    return len;
>> +}
> 
> I think it would be better to model the output to something similar to what lspci would do:
> 
> L1.1- L1.2- L0S+ ClockPM+, etc...
> 
> This better conveys the message that these states are enabled vs disabled.
> 
> I'd be interested to know if the use of [STATE]/STATE pattern is used elsewhere in the kernel. If so, then I'm cool with it :)
> 
This pattern is used in several places in sysfs. At first for "1 of n" selections like
in /sys/module/pcie_aspm/parameters/policy. But also for "m of n" selections,
examples would be LED triggers or active remote control protocols (drivers/media/rc).

>> +
>> +static ssize_t aspm_disable_link_state_store(struct device *dev,
>> +                         struct device_attribute *attr,
>> +                         const char *buf, size_t len)
>> +{
>> +    struct pci_dev *pdev = to_pci_dev(dev);
>> +    struct pcie_link_state *link;
>> +    char *buftmp = (char *)buf, *tok;
>> +    unsigned int disable_aspm, disable_clkpm;
>> +    bool first = true, add;
>> +    int err = 0, i;
>> +
>> +    if (aspm_disabled)
>> +        return -EPERM;
>> +
>> +    link = aspm_get_parent_link(pdev);
>> +    if (!link)
>> +        return -EOPNOTSUPP;
>> +
>> +    down_read(&pci_bus_sem);
>> +    mutex_lock(&aspm_lock);
>> +
>> +    disable_aspm = link->aspm_disable;
>> +    disable_clkpm = link->clkpm_disable;
>> +
>> +    while ((tok = strsep(&buftmp, " \n")) != NULL) {
>> +        bool found = false;
>> +
>> +        if (!*tok)
>> +            continue;
>> +
>> +        if (first) {
>> +            if (!strcasecmp(tok, "none")) {
>> +                disable_aspm = 0;
>> +                disable_clkpm = 0;
>> +                break;
>> +            }
>> +            if (!strcasecmp(tok, "all")) {
>> +                disable_aspm = ASPM_STATE_ALL;
>> +                disable_clkpm = 1;
>> +                break;
>> +            }
>> +            first = false;
>> +        }
>> +
>> +        if (*tok != '+' && *tok != '-') {
>> +            err = -EINVAL;
>> +            goto out;
>> +        }
>> +
>> +        add = *tok++ == '+';
>> +
>> +        for (i = 0; i < ARRAY_SIZE(aspm_sysfs_states); i++) {
>> +            const struct aspm_sysfs_state *st =
>> +                        aspm_sysfs_states + i;
>> +
>> +            if (!strcasecmp(tok, st->name)) {
>> +                if (add)
>> +                    disable_aspm |= st->disable_mask;
>> +                else
>> +                    disable_aspm &= ~st->disable_mask;
>> +                found = true;
>> +                break;
>> +            }
>> +        }
>> +
>> +        if (!found && !strcasecmp(tok, "clkpm")) {
>> +            disable_clkpm = add ? 1 : 0;
>> +            found = true;
>> +        }
>> +
>> +        if (!found) {
>> +            err = -EINVAL;
>> +            goto out;
>> +        }
>> +    }
>> +
>> +    if (disable_aspm & ASPM_STATE_L1)
>> +        disable_aspm |= ASPM_STATE_L1SS;
>> +
>> +    link->aspm_disable = disable_aspm;
>> +    link->clkpm_disable = disable_clkpm;
>> +
>> +    pcie_config_aspm_link(link, policy_to_aspm_state(link));
>> +    pcie_set_clkpm(link, policy_to_clkpm_state(link));
>> +out:
>> +    mutex_unlock(&aspm_lock);
>> +    up_read(&pci_bus_sem);
>> +
>> +    return err ?: len;
>> +}
>> +
>> +static DEVICE_ATTR_RW(aspm_disable_link_state);
>>   
> 
> Since we're introducing a new sysfs interface, would it be more appropriate to rename the sysfs files to aspm_set_link_state (or something to that effect)?
> 
> The syntax as it stands, means that to enable a state, a double negative must be used:
> 
> echo "-L1.1" > ./aspm_disable_link_state"
> vs
> echo "+L1.1" > ./aspm_set_link_state
> 
> If we avoid the double negative, the documentation about to be written will be more clear and use of the sysfs file will be more intuitive.
> 
I think this is a valid point. Let me check and come up with a proposal.

> Thanks,
> Frederick Lawler
> 
> 
Heiner
