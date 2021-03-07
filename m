Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE7E3304AA
	for <lists+linux-pci@lfdr.de>; Sun,  7 Mar 2021 21:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhCGUqh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Mar 2021 15:46:37 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:46279 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhCGUqE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Mar 2021 15:46:04 -0500
Received: by mail-ed1-f47.google.com with SMTP id w9so11670171edt.13;
        Sun, 07 Mar 2021 12:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y/j6Cq0L0/qK+bPKbsMfp46b9C06hF4J+uRP7tNJ/uQ=;
        b=pOW19Ie5sD+JbC5rh2BfSlJNI8j+7uGR5isFbWu/cFf5qDZlEW8DJcz1jPmHwjntyv
         uLIczGsSQHrBM/tc0BKxsjpqHf4ZayicUhyeaSeV1QlYTDPcYyWKdrTGy5gwtHKNzif9
         Oh3gB6oDYwGnSE4IpmsQfGh2pxwUrAEOYeac/XzYI9uSsR3BYB6JnoX/GBKAmPBk1Q8T
         fEObKjwi/8TA4wwxLvDjVFAog4LPT3P6bYP5bYUxqRjqEJrFskhPS7KCaBlFcINOuXbx
         yX/fX/pUWc+B6xjB9yVIYoscIsP+Q5Pta7mZ5GRtlJLZJJOyNbmVrY+Z91kA4OzoPYUz
         prYA==
X-Gm-Message-State: AOAM531CRyiOslKgUp1GHVCczXhJc78d9cK06rqD0MV4xCf9MeXfQv4q
        e9qJAMY4UgFg0X0Gl9zgS4U=
X-Google-Smtp-Source: ABdhPJzD0EWBZ9NQK51HxGvb39ETnp5a2NDmgKgrkl6dachAz9OfSnmgWX6A8tHqKj5AwXXFcJLNyA==
X-Received: by 2002:a05:6402:158d:: with SMTP id c13mr18828466edv.297.1615149962785;
        Sun, 07 Mar 2021 12:46:02 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id lu26sm5495962ejb.33.2021.03.07.12.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 12:46:01 -0800 (PST)
Date:   Sun, 7 Mar 2021 21:46:00 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Narendra K <narendra_k@dell.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [RFC 1/1] s390/pci: expose a PCI device's UID as its index
Message-ID: <YEU7iFjxNxQK3ldc@rocinante>
References: <20210303095250.1360007-1-schnelle@linux.ibm.com>
 <20210303095250.1360007-2-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210303095250.1360007-2-schnelle@linux.ibm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Niklas,

[...]
> +static ssize_t index_show(struct device *dev,
> +			  struct device_attribute *attr, char *buf)
> +{
> +	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
> +	u32 index = ~0;
> +
> +	if (zpci_unique_uid)
> +		index = zdev->uid;
> +
> +	return sprintf(buf, "%u\n", index);
[...]

Would it be possible to use the new sysfs_emit() rather than sprintf()
even though the zpci_attr macro and still use mio_enabled_show() still
would use sprintf().  What do you think?

See https://www.kernel.org/doc/html/latest/filesystems/sysfs.html for
the changes in the internal API.

Krzysztof
