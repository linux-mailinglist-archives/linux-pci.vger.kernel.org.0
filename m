Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F37418ADD
	for <lists+linux-pci@lfdr.de>; Sun, 26 Sep 2021 22:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhIZUCZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Sep 2021 16:02:25 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:36811 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhIZUCZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Sep 2021 16:02:25 -0400
Received: by mail-lf1-f50.google.com with SMTP id b20so67527815lfv.3;
        Sun, 26 Sep 2021 13:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l3obkGQ+XpY0Vr97E+TyMlZ4RsCgsk4oyb1ai412+Ag=;
        b=8H2qK8f9ZNk8XEdBKeMUt/UfTtoGJ5y0YYE5jav6dQUqJoeSIEpzl2clcEzJXZjzyR
         bLbKCYLqI2j7ughnhBtcXnFOqeYBt0KcbTfH0vIaTGUlGY4loqJWlW/eci3pLWFhHZv6
         4hhWJDiWgCAuH9WDrJnl5TZis7fPHHmBr8izuZWdZ2yUwGXJ6LBSFZxrtjLvdw0pPhok
         FNFTzHHON/ED4rjDduwL9tSo5hzhNFgIUmdB8KnIGeFjrCdq+rJ5/bt7zL21X4o0dJB6
         vSVrMHE5CLdVSFyKWHrhqaIrLY/cabqfEwFAOcBB3EJBXQKVoO9ILj5JaiNAXNWb8MJq
         inlQ==
X-Gm-Message-State: AOAM530RjHA9vkJ/ANWmotWQxh6qRPlAyWPYU++1R5T3lFgqjhGNM/7j
        89IHtgPwY0QWHLCnvbyL0eo=
X-Google-Smtp-Source: ABdhPJxcm3fL6YxDm0G2Ib4EFFXmfP0Dzirpyzk6SLisVl/uyN1ODO7vehPfeTEzaJt11+BWGOY99w==
X-Received: by 2002:a2e:70a:: with SMTP id 10mr24301038ljh.187.1632686447374;
        Sun, 26 Sep 2021 13:00:47 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id y14sm1373236lfk.237.2021.09.26.13.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 13:00:46 -0700 (PDT)
Date:   Sun, 26 Sep 2021 22:00:45 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Zhenneng Li <lizhenneng@kylinos.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: add write attribute for boot_vga
Message-ID: <YVDRbRF5wbcJmTtb@rocinante>
References: <20210926071539.636644-1-lizhenneng@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210926071539.636644-1-lizhenneng@kylinos.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Huacai and Kai-Heng as they are working in this area] 

Hi,

Thank you for sending the patch over.

I assume this is simply a resend (rather than a v2), as I see no code
changes from the previous version you sent some time ago.

> Add writing attribute for boot_vga sys node,
> so we can config default video display
> output dynamically when there are two video
> cards on a machine.

That's OK, but why are you adding this?  What problem does it solve and
what is the intended user here?  Might be worth adding a little bit more
details about why this new sysfs attribute is needed.

I also need to ask, as I am not sure myself, whether this is OK to do after
booting during runtime?  What do you think Bjorn, Huacai and Kai-Heng?

Also, please correctly capitalise the subject - have a look at previous
commit messages to see how it should look like.

> +static ssize_t boot_vga_store(struct device *dev, struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	unsigned long val;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct pci_dev *vga_dev = vga_default_device();
> +
> +	if (kstrtoul(buf, 0, &val) < 0)
> +		return -EINVAL;
> +
> +	if (val != 1)
> +		return -EINVAL;

Since this is a completely new API have a look at kstrtobool() over
kstrtoul() as the former was created to handle user input more
consistently.

> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +

Check for CAP_SYS_ADMIN is a good idea, but it has to take place before you
attempt to accept and parse a input from the user.

	Krzysztof
