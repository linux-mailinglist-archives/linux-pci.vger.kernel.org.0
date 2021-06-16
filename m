Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8923A9D48
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 16:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhFPOQz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 10:16:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233398AbhFPOQz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 10:16:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4E5F60200;
        Wed, 16 Jun 2021 14:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623852888;
        bh=gddT+iJoudoVpablFQEYkqg+MNl5OKYIo4Jvk+UWE58=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YtNSVLEva/mHnZOnQojvcTftq7t0/Oo64rh4bnsnxAC8JdGaA1nSOyEOHrDTqh38+
         XXeEAZgP77UFd9D/ijnXBf5GcJao/AS7f8AwpssnqJ1J9QiL5hQ2r6wjEycEUcYLnA
         DMhIjmqg5g7gNpqJQWY2MZ4J52bsL6LLuJR7cgxhxJVN4vLO8JRjuAT+VUnv4Oi1yE
         gcoeSupDdv/VpkZ2uswF8T3XOUd9am0Ip2oXIlAqgzMP63Ie/IlMjJJ8gWM/xMeCvA
         FsuaxHHclYPydDVXzztTgO08uOBaay5xH46rOZ6ORXj3NSpQdzfPB6LUSE7+x0PPFR
         Lner0uMJtLBPQ==
Date:   Wed, 16 Jun 2021 09:14:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Qi Liu <liuqi115@huawei.com>, will@kernel.org,
        mark.rutland@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        zhangshaokun@hisilicon.com
Subject: Re: [PATCH v6 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
Message-ID: <20210616141447.GA2973335@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210611233355.GA183580@rocinante>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 12, 2021 at 01:33:55AM +0200, Krzysztof Wilczyński wrote:

> > +static ssize_t hisi_pcie_bus_show(struct device *dev,
> > +				  struct device_attribute *attr, char *buf)
> > +{
> > +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(dev_get_drvdata(dev));
> > +
> > +	return sysfs_emit(buf, "0x%02x\n", PCI_BUS_NUM(pcie_pmu->bdf_min));
> > +}
> 
> Same as above, what about "%#02x"?

I think you'd need "%#04x" because the field width includes the
leading "0x", so printing 1 with "%#02x" would result in "0x1" instead
of "0x01".
