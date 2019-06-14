Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA3145D93
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 15:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfFNNMz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 09:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfFNNMz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 09:12:55 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB86720850;
        Fri, 14 Jun 2019 13:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560517975;
        bh=s7zyuYWu+DaWGbyiuI6YfpVgY4YZ3vd5LpUoa4GAm24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r9h4sOJw4TWqwZ6Htg6I96ppoZEAiCpUG+mrI/LkdOC+aeRusUOZ91ISOH7nOaxks
         v84qfGmWQ3spRQq4sQZkPS4zIH+6rZ0Hk3zwxlLwcwsq9tDqzOkq2TxyU5I/yWY0ca
         D194xOv9xtvOVOfuHGBKAABDHW4XhR1kSTEvX90I=
Date:   Fri, 14 Jun 2019 08:12:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH v2] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
Message-ID: <20190614131253.GR13533@google.com>
References: <5783e36561bb77a1deb6ba67e5a9824488cc69c6.camel@kernel.crashing.org>
 <20190613190248.GH13533@google.com>
 <e6c7854ae360be513f6f43729ed6d4052e289376.camel@kernel.crashing.org>
 <CAKv+Gu95pQ7_OfLbEXHZ_bhYnqOgTBKCmTgqUY27un-Y708BgQ@mail.gmail.com>
 <d5d3e7b9553438482854c97e09543afb7de23eaa.camel@kernel.crashing.org>
 <20190614095742.GA27188@e121166-lin.cambridge.arm.com>
 <906b2576756e82a54b584c3de2d8362602de07ce.camel@kernel.crashing.org>
 <84320a45ef9395d82bf1c5d4d2d7e6db189cbfda.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84320a45ef9395d82bf1c5d4d2d7e6db189cbfda.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 14, 2019 at 08:43:19PM +1000, Benjamin Herrenschmidt wrote:

> This least to another conversation we hinted at earlier.. we should
> probably have a way to do the same at least for BARs on ACPI systems so
> we don't have to temporarily disable access to a device to size them.

The PCI Enhanced Allocation capability provides a way to do this.  I
don't know how widely used it is, but it's theoretically possible.
