Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5141D1A9D3
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2019 03:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfELBBs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 May 2019 21:01:48 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42739 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfELBBs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 May 2019 21:01:48 -0400
Received: by mail-io1-f65.google.com with SMTP id g16so7387187iom.9
        for <linux-pci@vger.kernel.org>; Sat, 11 May 2019 18:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=873Wmsox5IJEgipIA4xy2NG/sQOWz/yw/PolHgWAOXA=;
        b=2HHKQIgKqsDDNzTtAoj8WbGJEqy8G3wyr7TNA3Qnv4lsT03ackONPKAflmkmMeRka7
         A+VPyqxS47cQE5bbzjik1cYFMYsOXvS7rDZFDSDAiRBOekIKjWX+RRBQfPL7SWusPx61
         Ymb/9Ud5xk/zWinFRCl6+5TYwI2Yhr0y8isSyeVknOr7nBAMQeb7zsV3QvxpCzXXEiuq
         s/6oAX9srJ/dnf1dOg52YR3OiYYE0m2uh6MKmEAzQeHCAkSxITZ7qSIiOlbzLoTTrasJ
         2QWfn+YraomEgd/dhG7/FcpRELm7VW8Y+Bpvqv82CLDh1i0JD8UsWBSoD5osvPF1Oebu
         NPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=873Wmsox5IJEgipIA4xy2NG/sQOWz/yw/PolHgWAOXA=;
        b=ncIbX3M/I+aLgYEUowhnL12AYHuZWnQaFv/K4mp13/u8o7rVYINDgkwr/MhD3J/gDn
         cLdQoeTfOQaDzwCVGkSSMc/s7ekuuArlm+2Lb+gaMrU7CCmx/XVzxCfGKei6gNvOhgda
         9ABw7h2USXSTNefype7UyzU2BH/xjxHjoh6wZsIOwcSXEfC/Ap6lkKxVD7fYS3JRpFQ1
         d9pYoRbKWOlDSjF10M12MxaBixAx4ZOOJnlvAblds48maVVW8c9n+Bi9bzEC3eIWNm1L
         +7BkmVDznjkQ7It8rojdO+I9zEHXQm7ZwPrVkNoQi3/TgwBO3A2rss5bB44CHMSKQdr/
         EC+A==
X-Gm-Message-State: APjAAAV/SfoON5WO0aUlG+ws94hrVAXwDDFYtK3Rfbu8bjgbPOmEBUUt
        CRiT5xi8gveRsKNeuWmC3hnAhIPsyKM=
X-Google-Smtp-Source: APXvYqxp3mz+AvKCYfZ8a1jalGysps6SKHPo3gG2nxXA97nJWDSWqzgldqvUyL72XNJJquTzncqdig==
X-Received: by 2002:a6b:5117:: with SMTP id f23mr11171718iob.263.1557622906458;
        Sat, 11 May 2019 18:01:46 -0700 (PDT)
Received: from Fredericks-MacBook-Pro.local (173-17-200-179.client.mchsi.com. [173.17.200.179])
        by smtp.gmail.com with ESMTPSA id q72sm1604760ita.26.2019.05.11.18.01.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 18:01:45 -0700 (PDT)
Subject: Re: [PATCH RFC v2 3/3] PCI/ASPM: add sysfs attribute for controlling
 ASPM
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <e041842a-55ed-91e3-75c2-c1a0267b74e5@gmail.com>
 <773b6a8a-00ac-a275-c80b-d5909ca58f19@gmail.com>
From:   Frederick Lawler <fred@fredlawl.com>
Message-ID: <d8e271e0-d83f-14f9-00d6-ad63a56d8959@fredlawl.com>
Date:   Sat, 11 May 2019 20:02:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 PostboxApp/6.1.16.1
MIME-Version: 1.0
In-Reply-To: <773b6a8a-00ac-a275-c80b-d5909ca58f19@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Evening,

Heiner Kallweit wrote on 5/11/19 10:33 AM:> +static ssize_t 
aspm_disable_link_state_show(struct device *dev,
> +					    struct device_attribute *attr,
> +					    char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct pcie_link_state *link;
> +	int len = 0, i;
> +
> +	link = aspm_get_parent_link(pdev);
> +	if (!link)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&aspm_lock);
> +
> +	for (i = 0; i < ARRAY_SIZE(aspm_sysfs_states); i++) {
> +		const struct aspm_sysfs_state *st = aspm_sysfs_states + i;
> +
> +		if (link->aspm_disable & st->disable_mask)
> +			len += scnprintf(buf + len, PAGE_SIZE - len, "[%s] ",
> +					 st->name);
> +		else
> +			len += scnprintf(buf + len, PAGE_SIZE - len, "%s ",
> +					 st->name);
> +	}
> +
> +	if (link->clkpm_disable)
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "[CLKPM] ");
> +	else
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "CLKPM ");
> +
> +	mutex_unlock(&aspm_lock);
> +
> +	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
> +
> +	return len;
> +}

I think it would be better to model the output to something similar to 
what lspci would do:

L1.1- L1.2- L0S+ ClockPM+, etc...

This better conveys the message that these states are enabled vs disabled.

I'd be interested to know if the use of [STATE]/STATE pattern is used 
elsewhere in the kernel. If so, then I'm cool with it :)

> +
> +static ssize_t aspm_disable_link_state_store(struct device *dev,
> +					     struct device_attribute *attr,
> +					     const char *buf, size_t len)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct pcie_link_state *link;
> +	char *buftmp = (char *)buf, *tok;
> +	unsigned int disable_aspm, disable_clkpm;
> +	bool first = true, add;
> +	int err = 0, i;
> +
> +	if (aspm_disabled)
> +		return -EPERM;
> +
> +	link = aspm_get_parent_link(pdev);
> +	if (!link)
> +		return -EOPNOTSUPP;
> +
> +	down_read(&pci_bus_sem);
> +	mutex_lock(&aspm_lock);
> +
> +	disable_aspm = link->aspm_disable;
> +	disable_clkpm = link->clkpm_disable;
> +
> +	while ((tok = strsep(&buftmp, " \n")) != NULL) {
> +		bool found = false;
> +
> +		if (!*tok)
> +			continue;
> +
> +		if (first) {
> +			if (!strcasecmp(tok, "none")) {
> +				disable_aspm = 0;
> +				disable_clkpm = 0;
> +				break;
> +			}
> +			if (!strcasecmp(tok, "all")) {
> +				disable_aspm = ASPM_STATE_ALL;
> +				disable_clkpm = 1;
> +				break;
> +			}
> +			first = false;
> +		}
> +
> +		if (*tok != '+' && *tok != '-') {
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		add = *tok++ == '+';
> +
> +		for (i = 0; i < ARRAY_SIZE(aspm_sysfs_states); i++) {
> +			const struct aspm_sysfs_state *st =
> +						aspm_sysfs_states + i;
> +
> +			if (!strcasecmp(tok, st->name)) {
> +				if (add)
> +					disable_aspm |= st->disable_mask;
> +				else
> +					disable_aspm &= ~st->disable_mask;
> +				found = true;
> +				break;
> +			}
> +		}
> +
> +		if (!found && !strcasecmp(tok, "clkpm")) {
> +			disable_clkpm = add ? 1 : 0;
> +			found = true;
> +		}
> +
> +		if (!found) {
> +			err = -EINVAL;
> +			goto out;
> +		}
> +	}
> +
> +	if (disable_aspm & ASPM_STATE_L1)
> +		disable_aspm |= ASPM_STATE_L1SS;
> +
> +	link->aspm_disable = disable_aspm;
> +	link->clkpm_disable = disable_clkpm;
> +
> +	pcie_config_aspm_link(link, policy_to_aspm_state(link));
> +	pcie_set_clkpm(link, policy_to_clkpm_state(link));
> +out:
> +	mutex_unlock(&aspm_lock);
> +	up_read(&pci_bus_sem);
> +
> +	return err ?: len;
> +}
> +
> +static DEVICE_ATTR_RW(aspm_disable_link_state);
>   

Since we're introducing a new sysfs interface, would it be more 
appropriate to rename the sysfs files to aspm_set_link_state (or 
something to that effect)?

The syntax as it stands, means that to enable a state, a double negative 
must be used:

echo "-L1.1" > ./aspm_disable_link_state"
vs
echo "+L1.1" > ./aspm_set_link_state

If we avoid the double negative, the documentation about to be written 
will be more clear and use of the sysfs file will be more intuitive.

Thanks,
Frederick Lawler

