Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC623120B7
	for <lists+linux-pci@lfdr.de>; Sun,  7 Feb 2021 02:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBGBhB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Feb 2021 20:37:01 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:46616 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGBhA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Feb 2021 20:37:00 -0500
Received: by mail-lf1-f48.google.com with SMTP id v5so14519424lft.13;
        Sat, 06 Feb 2021 17:36:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MsIYELOiBOvxC7BLCCq9XFdfwN6TwYFsgK/fAqU4LV4=;
        b=bVf/liT4DI0R2plh/aFJyUu69vlDaISsXFO/5vWEiZ6A8QnVuVeEG2jm4YfikXBIWm
         rx82ZPbR4jozX8Ba+p0A1Fa8P1tKpYVV1U5EHaaWkol64uBu1fldkBbp/d/xGgV4555U
         axacnKxns0CrebsjWG14GrfIMtguV7s/DHZu1V33X0LmIVOWkiM3af684w+rA76YBW47
         kgOTdhKQmh0JxqZPW0oQtbeu0H1nyufPb3I2LqPaf7VN/TbbJ49YwpXxrsQ4d2x1iJhY
         2vGSvWbNfEi/Vyl+reh7aMqrDVUasi8JVBXb9VZpWrQIZKrM0RRE9iplKFXM2qkZMB9j
         M+0w==
X-Gm-Message-State: AOAM532ti+4+VkeP8BUEt6iEUIJIxujBzYsedhdbRxqU8D+TdtX1C+yD
        vc87iEM4AWbTjiAY9MtQ73xQk2sF6xvSvmYp
X-Google-Smtp-Source: ABdhPJzy/jEwHgYAGmRrI1aQ/pcZFAfJ9GDkGIE5fdaqHNDxnI7gfQv/2yqD2VXgKOnimvg1uFWXBQ==
X-Received: by 2002:ac2:5dfc:: with SMTP id z28mr6715442lfq.218.1612661777948;
        Sat, 06 Feb 2021 17:36:17 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id o11sm1503365lfu.157.2021.02.06.17.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 17:36:17 -0800 (PST)
Date:   Sun, 7 Feb 2021 02:36:15 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RESEND v4 1/6] misc: Add Synopsys DesignWare xData IP driver
Message-ID: <YB9EDzI7mSrzXUUB@rocinante>
References: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
 <bba090c3d9d3d90fb2dfe5f2aaa52c155d87958f.1612390291.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bba090c3d9d3d90fb2dfe5f2aaa52c155d87958f.1612390291.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Gustavo,

Thank you for all the work here!

A few suggestions.

[...]
> +static void dw_xdata_stop(struct dw_xdata *dw)
> +{
> +	u32 burst = readl(&(__dw_xdara_regs(dw)->burst_cnt));
> +
> +	if (burst & BIT(31)) {
> +		burst &= ~(u32)BIT(31);
> +		writel(burst, &(__dw_regs(dw)->burst_cnt));
> +	}
> +}

Would it be possible to add a define for this "BIT(31)", similarly to
the "XPERF_CONTROL_ENABLE", for example:

  #define XPERF_CONTROL_ENABLE		BIT(5)
  #define XPERF_CONTROL_DISABLE		BIT(31)

What do you think?

> +static void dw_xdata_start(struct dw_xdata *dw, bool write)
> +{
> +	u32 control, status;
> +
> +	/* Stop first if xfer in progress */
> +	dw_xdata_stop(dw);
> +
> +	/* Clear status register */
> +	writel(0x0, &(__dw_regs(dw)->status));
> +
> +	/* Burst count register set for continuous until stopped */
> +	writel(0x80001001, &(__dw_regs(dw)->burst_cnt));

Would you mind adding a define (possibly with a comment, if it makes
sense, of course) rather than open coding it here.

> +	/* Pattern register */
> +	writel(0x0, &(__dw_regs(dw)->pattern));
> +
> +	/* Control register */
> +	control = CONTROL_DOORBELL | CONTROL_PATTERN_INC | CONTROL_NO_ADDR_INC;
> +	if (write) {
> +		control |= CONTROL_IS_WRITE;
> +		control |= CONTROL_LENGTH(dw->max_wr_len);
> +	} else {
> +		control |= CONTROL_LENGTH(dw->max_rd_len);
> +	}
> +	writel(control, &(__dw_regs(dw)->control));
> +
> +	usleep_range(100, 150);
[...]

Why sleep here?

Do you just add some delay that changes were reflected, or is it
a requirement of sorts?  What do you think about documenting why the
sleep where? Would it make sense?

[...]
> +static void dw_xdata_perf(struct dw_xdata *dw, u64 *rate, bool write)
> +{
> +	u64 data[2], time[2], diff;
> +
> +	/* First measurement */
> +	writel(0x0, &(__dw_regs(dw)->perf_control));
> +	dw_xdata_perf_meas(dw, &data[0], write);
> +	time[0] = jiffies;
> +	writel((u32)XPERF_CONTROL_ENABLE, &(__dw_regs(dw)->perf_control));
> +
> +	/* Delay 100ms */
> +	mdelay(100);
[...]

The mdelay() is self-explanatory, so a comment that explains why to take
two measurements that are 100 ms apart and how rate is calculated might
be more useful (unless it would be an overkill here).

If this is an arbitrary delay without any special meaning, then probably
no comment is needed here.

What do you think?

[...]
> +	/* Calculations */

What sort of calculations precisely? :)

[...]
> +static int dw_xdata_pcie_probe(struct pci_dev *pdev,
> +			       const struct pci_device_id *pid)
> +{
> +	const struct dw_xdata_pcie_data *pdata = (void *)pid->driver_data;
> +	struct dw_xdata *dw;
> +	u64 addr;
> +	int err;
> +
> +	/* Enable PCI device */
> +	err = pcim_enable_device(pdev);

This comment might not be needed.

[...]
> +	/* Mapping PCI BAR regions */
> +	err = pcim_iomap_regions(pdev, BIT(pdata->rg_bar), pci_name(pdev));

This comment might also not be needed.

[...]
> +	/* Allocate memory */

And so this comment.

[...]
> +	/* Data structure initialization */
[...]
> +	/* Saving data structure reference */
[...]
> +	/* Sysfs */
[...]

And possibly few of these are also not needed.

Krzysztof
