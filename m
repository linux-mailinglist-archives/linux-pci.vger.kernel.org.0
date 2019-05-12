Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 140F91AC8E
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2019 15:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfELN7L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 May 2019 09:59:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33598 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfELN7L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 May 2019 09:59:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id c66so4311235wme.0
        for <linux-pci@vger.kernel.org>; Sun, 12 May 2019 06:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uZA3SlwnUAewzjkcXHcmq/No5VrHoGP8pnAAUr4sAmY=;
        b=qdQ5DWiwdTQ4Pq+1H2J1yN9o0GDr7iEW2cosqZ2VTH43FpKZ/fslOq+RJVPfa33+6F
         CpRX9mW3IBFgl8YGX9cBWjD6bHnL0nYvm8Btc0RurjeXKHCra8kujBnZ/TFakurZq5pq
         UQcfme8TYrgMpvGnVWT9Ug0Ssx0kJgmVFYBwnm9TodrhIIJs+R7naod6/oTEoeqCKwBU
         6b8OJP6LLhgoDUf0yzdak8mHdxversWSMiMU0gwKkP5PcN//jLMBESzUT4O30/rAK8is
         r5AbKB8uCh3vVooQMcEn6vt1ZDp05x6WQQZhPio0ylsVU+iPx4YS7NUmRPEPFYWHITSA
         /BBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uZA3SlwnUAewzjkcXHcmq/No5VrHoGP8pnAAUr4sAmY=;
        b=oakJmdgNhxs3oI7/a20ZB56hagKnPIyZ6zZ0Md+QcoIhLH3gV1VAzE1QJGy1duT4p5
         Yvd/fvc3sGYtN/IrDUaHZV3lAfuH5vO/Fqs2wSwvPRJmTfQOB0M1ZzzBOxhVsGU4pqGl
         46wTNrWnsPWJKQ1yJhygOtinhv8Bu6LRCuOMFzF+ej7vhJjAb4BmDaXlaY5tLqcu32ii
         ngGV+eI8cu5pKfIBQgpiIbGBJPvPA1ZnV6xBQ/9kQ4JUR37VdcAp2fdMRYhlmFaO4hyL
         9LlV53GGUxGSZOGo8rTx2fiGbB0+Og7QAQ7/q9QtKzBNGoBpBXVjPCl1fheTEIpaHAZs
         867A==
X-Gm-Message-State: APjAAAXNhbfj8y/dWb4/uS1hAd0Ocoa55u0svM8enkjm6PiLgv7dUkGz
        tWOZhJ8JgPyzNwE+1zqOSmvuEuW2mQE=
X-Google-Smtp-Source: APXvYqzvb2xg5YPorTJn+L/3lbLRizUe3iglXLqBOgA+Lfi/wEr68SL42YDMuHDetuLcjIAGjNrLAA==
X-Received: by 2002:a7b:c0d5:: with SMTP id s21mr7458431wmh.152.1557669549147;
        Sun, 12 May 2019 06:59:09 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:9c27:51d8:9ed5:dad3? (p200300EA8BD457009C2751D89ED5DAD3.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:9c27:51d8:9ed5:dad3])
        by smtp.googlemail.com with ESMTPSA id x22sm1090229wmi.4.2019.05.12.06.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 06:59:08 -0700 (PDT)
Subject: Re: [PATCH RFC v2 3/3] PCI/ASPM: add sysfs attribute for controlling
 ASPM
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <e041842a-55ed-91e3-75c2-c1a0267b74e5@gmail.com>
 <773b6a8a-00ac-a275-c80b-d5909ca58f19@gmail.com>
 <d8e271e0-d83f-14f9-00d6-ad63a56d8959@fredlawl.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <ff5dac4c-0e80-5277-ecfa-0f9d3d8e6f87@gmail.com>
Date:   Sun, 12 May 2019 15:59:06 +0200
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
I changed the attribute to aspm_link_states. The "set" isn't needed IMO. It's a RW attribute and that should make
clear it can be used to change the state.

> The syntax as it stands, means that to enable a state, a double negative must be used:
> 
> echo "-L1.1" > ./aspm_disable_link_state"
> vs
> echo "+L1.1" > ./aspm_set_link_state
> 
> If we avoid the double negative, the documentation about to be written will be more clear and use of the sysfs file will be more intuitive.
> 
> Thanks,
> Frederick Lawler
> 
> 
Heiner
