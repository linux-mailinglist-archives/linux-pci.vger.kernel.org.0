Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDFD8CF0AC
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 03:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfJHBxm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Oct 2019 21:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbfJHBxm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Oct 2019 21:53:42 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 273BA20835;
        Tue,  8 Oct 2019 01:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570499621;
        bh=0yXQhK19Mw0w1IGGYqyCQOunRGjo3goSMnd8zoRHxYg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TylWAA27qDEX7EmispmBCvHsfLeRUu30vpQ7KnGOk3KBwssiWsFrRtph0+E42r0U0
         Lj/iXqkbCQoYPyQNQZsOT0FLU7Y4mXUMge6/krFhHsIm2RoxaMs4pFXEn5RDF7CPX/
         flGsCzfJ/Qq4dOaqeBJvM7AjVhuZtJUv1RUZ0gaI=
Date:   Mon, 7 Oct 2019 20:53:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v7 4/5] PCI/ASPM: Add sysfs attributes for controlling
 ASPM link states
Message-ID: <20191008015339.GA93531@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1c83f8a-9bf6-eac5-82d0-cf5b90128fbf@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 05, 2019 at 02:07:56PM +0200, Heiner Kallweit wrote:
> Background of this extension is a problem with the r8169 network driver.
> Several combinations of board chipsets and network chip versions have
> problems if ASPM is enabled, therefore we have to disable ASPM per default.
> However especially on notebooks ASPM can provide significant power-saving,
> therefore we want to give users the option to enable ASPM. With the new
> sysfs attributes users can control which ASPM link-states are
> enabled/disabled.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

> +static ssize_t aspm_attr_show_common(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf, u8 state)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct pcie_link_state *link;
> +	bool enabled;
> +
> +	link = pcie_aspm_get_link(pdev);
> +
> +	mutex_lock(&aspm_lock);
> +	enabled = link->aspm_enabled & state;
> +	mutex_unlock(&aspm_lock);

Not sure the mutex is needed; do you have a reason, or is it just
copied from existing code?  If the latter, we can just wait to see
what Rafael says.

> +	return sprintf(buf, "%d\n", enabled ? 1 : 0);
> +}
