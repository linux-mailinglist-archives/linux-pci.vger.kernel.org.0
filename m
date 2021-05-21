Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DFD38D1E5
	for <lists+linux-pci@lfdr.de>; Sat, 22 May 2021 01:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhEUX0x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 May 2021 19:26:53 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:37483 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhEUX0w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 May 2021 19:26:52 -0400
Received: by mail-ed1-f42.google.com with SMTP id g7so12906311edm.4;
        Fri, 21 May 2021 16:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aiikKG+tFeQmADV1dZ8/8SQyBQJ6TxAvGSh04p41B4M=;
        b=MKBJKPtc6+m2NndKrEILgxkhvJPGeYaj/HRzjIwfk3K/jzPNLm/C4AShsvqq/67fml
         9vtXLVyUT9zj9OXk3sp72C4cmlvj/1392ZVtFtlZXoQ6PO/hlelNn6wqTqX+E6etd29l
         ZwgEt1cwl4lZ/0bnXUpZzDxkkZd1zQ6yhNaKZu4dQOstlbOPsWrHV1AhAYKlAy2GAc9p
         7oxww8ZXslkXYRtmAAiKtJ7TDjblF3u7QQgAaiLvaKFe0GTsBMl9Wk7yk3ZxPHQPVzuv
         BKhveWkqyBOvNx4QFd4NaLi/8BSUga4k7F9mws+slMI20SEuzuwasu5ffAKFO7X+RrCh
         ww8g==
X-Gm-Message-State: AOAM533PNEsOlCHTSvP27Xks3w+MuvP71WpcySxtytvSq3VagbTuxRbt
        ONpKYN5KLD0m1KDDnqKj2zg=
X-Google-Smtp-Source: ABdhPJwEP5guoNj5fyZui+bkriIwr0Fzg4huj5Yypl+a6V+mrDdupjvI0Yn9ZdWQA1jCVL+bquyJgw==
X-Received: by 2002:a05:6402:684:: with SMTP id f4mr14029013edy.25.1621639526951;
        Fri, 21 May 2021 16:25:26 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id cf15sm5004602edb.62.2021.05.21.16.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 16:25:26 -0700 (PDT)
Date:   Sat, 22 May 2021 01:25:25 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Shradha Todi <shradha.t@samsung.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        pankaj.dubey@samsung.com, p.rajanbabu@samsung.com,
        hari.tv@samsung.com, niyas.ahmed@samsung.com, l.mehra@samsung.com
Subject: Re: [PATCH 2/3] PCI: debugfs: Add support for RAS framework in DWC
Message-ID: <20210521232525.GA79835@rocinante.localdomain>
References: <20210518174618.42089-1-shradha.t@samsung.com>
 <CGME20210518173823epcas5p1cb9f93e209ca4055365048287ec43ee8@epcas5p1.samsung.com>
 <20210518174618.42089-3-shradha.t@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210518174618.42089-3-shradha.t@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shradha,

Thank you for this working on this!  Looks very nice!

A few suggestions below.

> +config PCIE_DW_DEBUGFS
> +	bool "DWC PCIe debugfs entries"
> +	default n

No need to add this default for "no" answer, and this is the Kconfig's
default, so you can omit it here.

> +static int open(struct inode *inode, struct file *file)
> +{
> +	file->private_data = inode->i_private;
> +
> +	return 0;
> +}

Why custom callback?  This seem to almost copy what simple_open() does,
as per:

  int simple_open(struct inode *inode, struct file *file)
  {
  	if (inode->i_private)
  		file->private_data = inode->i_private;
  	return 0;
  }

You seem to be using simple_open() everywhere else.

> + * set_event_number: Function to set event number based on filename
> + *
> + * This function is called from the common read and write function
> + * written for all event counters. Using the debugfs filname, the
> + * group number and event number for the counter is extracted and
> + * then programmed into the control register.
> + *
> + * @file: file pointer to the debugfs entry
> + *
> + * Return: void
> + */

About this and other functions comments - did you intend to format this
and the others as kernel-doc compliant? At the first glance it does look
very similar, as per:

  https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html

[...]
> +/*
> + * ras_event_counter_en_read: Function to get if counter is enable
> + *
> + * This function is invoked when the following command is made:
> + * cat /sys/kernel/debug/dwc_pcie_plat/ras_des_counter/<name>/counter_enable

You don't really need to explain when the read() function evokes.  This
is also true for other such comments.

> + * It returns whether the counter is enabled or not

Nit pick: missing period at the end of the sentence (also true in other
code comments and sentences throughout).

[...]
> +	u32 ret;
> +	u32 val;
> +	u32 lane;
> +	struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
> +
> +	ret = kstrtou32_from_user(buf, count, 0, &lane);
> +	if (ret)
> +		return ret;
> +
> +	set_event_number(file);

You could add a newline here so that this is easier to read and also
consistent with other functions.

[...]
> +	err_num = get_error_inj_number(file);
> +	inj_num = (err_num & 0xFF);

Surplus parenthesis above.  This could also be moved to the top where
you declare all the variables.

[...]
> +	err_num = get_error_inj_number(file);
> +	inj_num = (err_num & 0xFF);
> +	err_num = (err_num >> 8);

Surplus parenthesis here too.  Also, you could probably move some of
these to the top, if possible.

[...]
> +static const struct file_operations rx_valid_fops = {
> +	.open = open,
> +	.read = rx_valid_read,
> +	.write = lane_selection_write

Just to make sure - this "lane_selection_write" here is intended?

[...]
> +	if (!pci) {
> +		pr_err("pcie struct is NULL\n");
> +		return -ENODEV;
> +	}

I think, given this particular case should the "pci" be a NULL pointer,
then we ought to have a much worse problems, if you think about this.

Thus, I am not sure if returning here would be better over letting
things crash properly (which might not be ideal either), as if at this
point "pci" is invalid and we still use it here, then something is
potentially has gone really bad somewhere.

Regardless of the approach here, the pr_err() message is not very
helpful in its current wording.

> +
> +	dev = pci->dev;

You can move this to the top where you declare your variable, so that
you would define it at the same time, for example:

  struct device *dev = pci->dev;

[...]
> +	/* Create main directory for each platform driver */
> +	dir = debugfs_create_dir(dirname, NULL);
> +	if (dir == NULL) {
> +		pr_err("error creating directory: %s\n", dirname);
> +		return -ENODEV;
> +	}

A small suggestion about the above: you could perhaps rely on the
following approach:

  if (IS_ERR(dir)) {
  	dev_err(dev, ...);
  	return PTR_ERR(dir);
  }

Unless you want to return -ENODEV for everything, regardless of what the
underlying error code might have been (such as i.e., -EPERM, for
example).  If so, then perhaps the IS_ERR_OR_NULL() macro could be
useful?

Note that debugfs_create_dir() and many other debugfs functions
correctly return -ENODEV if debugfs is not enabled.

Having said that, perhaps this approach would be an overkill.

> +	/* Create sub dirs for Debug, Error injection, Statistics */
> +	ras_des_debug_regs = debugfs_create_dir("ras_des_debug_regs", dir);
> +	if (ras_des_debug_regs == NULL) {
> +		pr_err("error creating directory: %s\n", dirname);
> +		ret = -ENODEV;
> +		goto remove_debug_file;
> +	}
> +
> +	ras_des_error_inj = debugfs_create_dir("ras_des_error_inj", dir);
> +	if (ras_des_error_inj == NULL) {
> +		pr_err("error creating directory: %s\n", dirname);
> +		ret = -ENODEV;
> +		goto remove_debug_file;
> +	}
> +
> +	ras_des_event_counter = debugfs_create_dir("ras_des_counter", dir);
> +	if (ras_des_event_counter == NULL) {
> +		pr_err("error creating directory: %s\n", dirname);
> +		ret = -ENODEV;
> +		goto remove_debug_file;
> +	}

I believe you don't necessary need to print an error message for each
sub-directory created under the root directory "dir".  Why? Technically,
if you can create the root, then you should be able to create all the
sub-directories without issues.

Also, each of the subsequent error messages would print the same name
being the root directory "dir" regardless of which one has failed to be
created.

[...]
> +	/* Create debugfs files for Debug subdirectory */
> +	lane_detection = debugfs_create_file("lane_detection", 0644,
> +					     ras_des_debug_regs, pci,
> +					     &lane_detection_fops);
> +
> +	rx_valid = debugfs_create_file("rx_valid", 0644,
> +					     ras_des_debug_regs, pci,
> +					     &lane_detection_fops);
> +
> +	/* Create debugfs files for Error injection sub dir */

Nit pick: to be consistent, if you could keep using "subdirectory"
everywhere where you use "sub dir".

[...]
> +int create_debugfs_files(struct dw_pcie *pci)
> +{
> +	/* No OP */
> +	return 0;
> +}
> +
> +void remove_debugfs_files(void)
> +{
> +	/* No OP */
> +}
[...]

No need for the "No OP" comment.  Also, you could potentially fit
everything on a single line, for example:

  int create_debugfs_files(struct dw_pcie *pci) { return 0; }
  void remove_debugfs_files(void) {}

But this is a matter of style, so I leave it up to you.

Having said that, both of these functions could use less generic names,
so that any potential current or future symbol name clash would be
avoided, especially since these have global scope.  Thus, adding
a prefix such as e.g., "ras_", or "dw_", etc., I am not sure which one
would be more appropriate.

	Krzysztof
