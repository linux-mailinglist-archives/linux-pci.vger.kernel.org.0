Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 442EB2112C
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2019 02:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfEQAQq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 20:16:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38104 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfEQAQp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2019 20:16:45 -0400
Received: by mail-io1-f65.google.com with SMTP id x24so4096375ion.5
        for <linux-pci@vger.kernel.org>; Thu, 16 May 2019 17:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FR0YqwZKtPnfuzHVj0sWqiHoN2bRoQr/amrzVPjlYjw=;
        b=YpaP4d7ANIzX154M7DTAmuIMscXS8rgL+AyUfbq6hZ3ZooZlg27y7AXCZoh2vakN2l
         y+iS5C8OqvaoYogD0AuWj1OQmZKSD5G8lie2i58VJa/5hSuN/DApCYg1t8+vH3GUYAnC
         dD7FMV9ndSX6Zv8clBUL2trASKdz9swVE9dGbVHO9Q45blXVmla7vxY+KJfc8Lv1oKOc
         ZNYBE774YFvQjelVpFK3sa/W4+uKPNrClwUmE1hw9aPP05Cnt4DJZ7WSNuZshU3l5W1L
         DdkYf0xrAXY8/94L9iltQr7oXHmzFjbdTGZucY/g5s/cqYdYPm1jE+NMq4UYJH/fhGRf
         mrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FR0YqwZKtPnfuzHVj0sWqiHoN2bRoQr/amrzVPjlYjw=;
        b=gF1Zm/bfz0CObvzAy9Jl8/5ALEtkAWOiXzY3sXNLo1BnuqHDdTixbcUiPnrqwZ6rdP
         kaNWZYo8s/lbl1GyVCVph6ky9UFgQy1ubhxQs7v6EE4dzZ7NhxIUhoMckKwKBA5AYEhD
         cSTRbKnlZgiuktZ62VyrR+oALMRMy74xs7oicq+YX1jvlcqHz0bYmU7kn8fYlQzzu93X
         o+yWL0fqAQL0hgigon7FOPLW+GMsczL4zc2LqdB2yehfB9thm2aW/vq0DbtOivJ7v63u
         k+xw9bfky+0JX+Ef4lBe4+8QJjCSpeJZcLGdKVhRa1ZbJ8qA2urGcm2vOfFMQvcteeYQ
         7d6g==
X-Gm-Message-State: APjAAAUnjDt/K46Ua2sXMYgd11NPQ63SnC1kQmYbe8CKpM3/OZndeXuR
        z8bTwGFO4NBg0/EkVBLNeh0VzgA02Do=
X-Google-Smtp-Source: APXvYqyHNHi2qAY11itqUMknSe/SyJ3SbGcb6nCq2DCiD066gVZbnju4tOlwh19hB5COUXTo+r1ihw==
X-Received: by 2002:a5d:8043:: with SMTP id b3mr29623208ior.115.1558051893693;
        Thu, 16 May 2019 17:11:33 -0700 (PDT)
Received: from Fredericks-MacBook-Pro.local ([172.58.139.116])
        by smtp.gmail.com with ESMTPSA id f20sm2175821ioh.4.2019.05.16.17.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 17:11:32 -0700 (PDT)
Subject: Re: [PATCH RFC v3 3/3] PCI/ASPM: add sysfs attribute for controlling
 ASPM
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <bde6db67-b432-f23c-5a44-d2cbb794ad40@gmail.com>
 <061c2def-8998-d62e-a268-c5d1426b14f9@gmail.com>
From:   Frederick Lawler <fred@fredlawl.com>
Message-ID: <9bc7c84f-5508-46b1-9f61-7ea8023e65ee@fredlawl.com>
Date:   Thu, 16 May 2019 19:12:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 PostboxApp/6.1.16.1
MIME-Version: 1.0
In-Reply-To: <061c2def-8998-d62e-a268-c5d1426b14f9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Heiner,

Heiner Kallweit wrote on 5/12/19 8:54 AM:> [snip]
> +static ssize_t aspm_link_states_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
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
> +		if (link->aspm_enabled & st->mask)
> +			len += scnprintf(buf + len, PAGE_SIZE - len, "[%s] ",
> +					 st->name);
> +		else
> +			len += scnprintf(buf + len, PAGE_SIZE - len, "%s ",
> +					 st->name);
> +	}

   # echo "-L1" > aspm_link_states
   # cat aspm_link_states
   L0S L1 L1.1 L1.2 [CLKPM]

   # echo "+L1" > aspm_link_states
   # cat aspm_link_states
   L0S [L1] L1.1 L1.2 [CLKPM]

In v1 & v2 [STATE] was used to show that a state was disabled, now 
[STATE] is used to show enabled. Is that intended?

> +
> +	if (link->clkpm_enabled)
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "[CLKPM] ");
> +	else
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "CLKPM ");
> +

Same as above...

> +	mutex_unlock(&aspm_lock);
> +
> +	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
> +
> +	return len;
> +}

Other than the above, v3 works as expected on my machine. Good work :)

Frederick Lawler

