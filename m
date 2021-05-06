Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529CF374D0B
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 03:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhEFBt1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 21:49:27 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:36538 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhEFBt1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 May 2021 21:49:27 -0400
Received: by mail-wr1-f52.google.com with SMTP id m9so3839248wrx.3
        for <linux-pci@vger.kernel.org>; Wed, 05 May 2021 18:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zht7QIz6dscvrPVPownn2pEYgfmlzBwvasb0udbsUqQ=;
        b=iJJIR8qX2fVVO6hlHD081cteBW9RKppHroqu5DSh5EyQV8cFj1M8eq4HK1JIEGN1vd
         iv0nMYQYHzHhp2HM5QtHKg7TrgrgeEf9xW5PgbpMuqocSQGNG+iCv1jePY3EVwegTL/8
         wHPJ8mcjungl3SFuN2vl+CDr6LU7QdQNJ1bAIj52DDXYF3i7PiWMzhoifbkOff8LB55P
         37WjFz1wBUN86X7sDeQCj8Y/HNqDnb2hj/QjWIintbvcoUWx4k0bEHV0+odSVGVHOkV0
         JQQmAWSwlq6Q6VhmR4x6IRwjJX//B3gWNENyxSnl6PamUtJGVCuE09VfHU4gpmMhrAGm
         Cdaw==
X-Gm-Message-State: AOAM531F4el/N6einZ0jDw3sjvZ/+k8NCGrlx4vrWqD1uYDcWC3wzmkq
        Pj5fWp0kSw6bDQKb0d0AAzc=
X-Google-Smtp-Source: ABdhPJxB4vRzIdEQhaK2xxMMnTf0l3KiCwqEmDrVfMcUy4MGOA8I/6C6b1HLPRdZRDc5ieMnZn/CbQ==
X-Received: by 2002:a5d:4ac6:: with SMTP id y6mr1916406wrs.414.1620265708859;
        Wed, 05 May 2021 18:48:28 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id i12sm1493463wry.57.2021.05.05.18.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 18:48:28 -0700 (PDT)
Date:   Thu, 6 May 2021 03:48:27 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] Add support for PCIe SSD status LED management
Message-ID: <20210506014827.GA175453@rocinante.localdomain>
References: <20210416192010.3197-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210416192010.3197-1-stuart.w.hayes@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Keith for visibility]

Hi Stuart,

> >cat /sys/class/leds/0000:88:00.0::pcie_ssd_status/supported_states
> ok                              0x0004 [ ]
> locate                          0x0008 [*]
> fail                            0x0010 [ ]
> rebuild                         0x0020 [ ]
> pfa                             0x0040 [ ]
> hotspare                        0x0080 [ ]
> criticalarray                   0x0100 [ ]
> failedarray                     0x0200 [ ]
> invaliddevice                   0x0400 [ ]
> disabled                        0x0800 [ ]
> --
> supported_states = 0x0008
> 
> >cat /sys/class/leds/0000:88:00.0::pcie_ssd_status/current_states
> locate                          0x0008 [ ]

As per what Keith already noted, this is a very elaborate output as far
as sysfs goes - very human-readable, but it would be complex to parse
should some software would be interested in showing this values in a way
or another.

I would propose output similar to this one:

  $ cat /sys/block/sda/queue/scheduler
  mq-deadline-nodefault [bfq] none

If you prefer to show the end-user a string, rather than a numeric
value.  This approach could support both the supported and current
states (similarly to how it works for the I/O scheduler), thus there
would be no need to duplicate the code between the two attributes.

What do you think?

Also, and I appreciate it would be more work, it's customary to accept
a string value rather than a numeric value when updating state through
the sysfs object, especially when the end-user is presented with string
values on read.  Having said that, this is not a requirement, so I am
leaving it at your discretion. :)

[...]
> +static struct led_state led_states[] = {
> +	{ .name = "ok",			.mask = 1 << 2 },
> +	{ .name = "locate",		.mask = 1 << 3 },
> +	{ .name = "fail",		.mask = 1 << 4 },
> +	{ .name = "rebuild",		.mask = 1 << 5 },
> +	{ .name = "pfa",		.mask = 1 << 6 },
> +	{ .name = "hotspare",		.mask = 1 << 7 },
> +	{ .name = "criticalarray",	.mask = 1 << 8 },
> +	{ .name = "failedarray",	.mask = 1 << 9 },
> +	{ .name = "invaliddevice",	.mask = 1 << 10 },
> +	{ .name = "disabled",		.mask = 1 << 11 },
> +};

Just a suggestion: how about using the BIT() macro in the above?

[...]
> +static bool pdev_has_dsm(struct pci_dev *pdev)
> +{
> +	acpi_handle handle;
> +
> +	handle = ACPI_HANDLE(&pdev->dev);
> +	if (!handle)
> +		return false;
> +
> +	return !!acpi_check_dsm(handle, &pcie_ssdleds_dsm_guid, 0x1,
> +		1 << GET_SUPPORTED_STATES_DSM ||
> +		1 << GET_STATE_DSM ||
> +		1 << SET_STATE_DSM);
> +}

The acpi_check_dsm() function already returns a bool type, so you can
drop the conversion.

> +static ssize_t current_states_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct device *dsm_dev = led_cdev->dev->parent;
> +	struct ssd_status_dev *ssd;
> +	u32 val;
> +	int err, i, result = 0;
> +
> +	ssd = container_of(led_cdev, struct ssd_status_dev, led_cdev);
> +
> +	err = dsm_get(dsm_dev, GET_STATE_DSM, &val);
> +	if (err < 0)
> +		return err;
> +	for (i = 0; i < ARRAY_SIZE(led_states); i++)
> +		if (led_states[i].mask & ssd->supported_states)
> +			result += sprintf(buf + result, "%-25s\t0x%04X [%c]\n",
> +					  led_states[i].name,
> +					  led_states[i].mask,
> +					  (val & led_states[i].mask)
> +					  ? '*' : ' ');
> +
> +	result += sprintf(buf + result, "--\ncurrent_states = 0x%04X\n", val);
> +	return result;
> +}

This show() callback above might benefit from already using the
sysfs_emit_at() function instead of using the sprintf() here, see:

  https://www.kernel.org/doc/html/latest/filesystems/sysfs.html?highlight=sysfs_emi#reading-writing-attribute-data

[...]
> +static ssize_t supported_states_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct ssd_status_dev *ssd;
> +	int i, result = 0;
> +
> +	ssd = container_of(led_cdev, struct ssd_status_dev, led_cdev);
> +
> +	for (i = 0; i < ARRAY_SIZE(led_states); i++)
> +		result += sprintf(buf + result, "%-25s\t0x%04X [%c]\n",
> +				  led_states[i].name,
> +				  led_states[i].mask,
> +				  (ssd->supported_states & led_states[i].mask)
> +				  ? '*' : ' ');
> +
> +	result += sprintf(buf + result, "--\nsupported_states = 0x%04X\n",
> +			  ssd->supported_states);
> +	return result;
> +}

Same as above.  This might benefit from using sysfs_emit_at().

[...]
> +static DEVICE_ATTR_RW(current_states);
> +static DEVICE_ATTR_RO(supported_states);

A small nitpik.  These are customary added immediately after the show()
and store() functions for a given attribute.

Krzysztof
