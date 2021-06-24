Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5321A3B2EB7
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 14:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhFXMRm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 08:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhFXMRm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 08:17:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18170613EA;
        Thu, 24 Jun 2021 12:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624536923;
        bh=NZ5IzRqUG/3+NiojVo4uhV8g9Xk/X69iZ3olJw6qMn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OkEO8VfZnYW0izJii9OKiU4HJfJlT46JCgY0X7sN7KXx6LkSdDHA6Z8I9kw8BRdkB
         mxbXuLulFUxHe56AMid49tc9kiMfsHRRsa+VK/kt6LXSVjMYmM3lVhYKduNWqO000D
         66T4ieQe4dPuD83Y8C+JTL7IvDMhLQU0figPgWyOy7q/lsn2Zhj5dJ7VInD8oXhzpO
         wl1FeGyj0Mq3j3skIa9wcqgu1XlkyL1hWkbOZKSdS0SLME1F4dfVnigAsenymwqDRC
         3gn0qv8PW5bRYALr/4KUmESr35lQ5DlSvKk5k59oRnLLgvcnslFxiJSxBADZkIBf3M
         K89beqViMpmBg==
Date:   Thu, 24 Jun 2021 07:15:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 4/8] PCI/sysfs: Allow userspace to query and set
 device reset mechanism
Message-ID: <20210624121521.GA3518338@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608054857.18963-5-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 08, 2021 at 11:18:53AM +0530, Amey Narkhede wrote:
> Add reset_method sysfs attribute to enable user to
> query and set user preferred device reset methods and
> their ordering.

> +		Writing the name or comma separated list of names of any of
> +		the device supported reset methods to this file will set the
> +		reset methods and their ordering to be used when resetting
> +		the device.

> +	while ((name = strsep(&options, ",")) != NULL) {
> +		if (sysfs_streq(name, ""))
> +			continue;
> +
> +		name = strim(name);
> +
> +		for (i = 0; i < PCI_RESET_METHODS_NUM; i++) {
> +			if (reset_methods[i] &&
> +			    sysfs_streq(name, pci_reset_fn_methods[i].name)) {
> +				reset_methods[i] = prio--;
> +				break;
> +			}
> +		}
> +
> +		if (i == PCI_RESET_METHODS_NUM) {
> +			kfree(options);
> +			return -EINVAL;
> +		}
> +	}

Asking again since we didn't get this clarified before.  The above
tells me that "reset_methods" allows the user to control the *order*
in which we try reset methods.

Consider the following two uses:

  (1) # echo bus,flr > reset_methods

  (2) # echo flr,bus > reset_methods

Do these have the same effect or not?

If "reset_methods" allows control over the order, I expect them to be
different: (1) would try a bus reset and, if the bus reset failed, an
FLR, while (2) would try an FLR and, if the FLR failed, a bus reset.
